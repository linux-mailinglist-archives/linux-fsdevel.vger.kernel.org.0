Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9702B7E6C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 14:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgKRNik (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 08:38:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42872 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725790AbgKRNik (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 08:38:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605706718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GVUanouneBkgZu23QQLjtjHhi4h+JZ5xuyDpQF39nTs=;
        b=L26G0aKPUFMPLrd5XfktGNG8wwZqpg3COrtXfrmZBrC2HqTOheDAiokVS3SZAdWilqGCP3
        bw+/pgjSmFJyniE6kWPLilYtSP1FMoL9ern3/kP+/+esQzS1PW+T1XNKtRXhj6WQghMuuF
        bL0mWCif5k5i2qQsPrrwdr/8XKhFSsQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-519-qk5WILKIOxCB2TWzC_mkgw-1; Wed, 18 Nov 2020 08:38:34 -0500
X-MC-Unique: qk5WILKIOxCB2TWzC_mkgw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3AE7ECE64B;
        Wed, 18 Nov 2020 13:38:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD6805B4BE;
        Wed, 18 Nov 2020 13:38:28 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20201118124826.GA17850@nautica>
References: <20201118124826.GA17850@nautica> <1514086.1605697347@warthog.procyon.org.uk>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     dhowells@redhat.com, Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        v9fs-developer@lists.sourceforge.net, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] 9p: Convert to new fscache API
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1561010.1605706707.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 18 Nov 2020 13:38:27 +0000
Message-ID: <1561011.1605706707@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dominique Martinet <asmadeus@codewreck.org> wrote:

> What's the current schedule/plan for the fscache branch merging? Will
> you be trying this merge window next month?

That's the aim.  We have afs, ceph and nfs are about ready; I've had a go =
at
doing the 9p conversion, which I'll have to leave to you now, I think, and=
 am
having a poke at cifs.

> >  (*) I have made an assumption that 9p_client_read() and write can han=
dle I/Os
> >      larger than a page.  If this is not the case, v9fs_req_ops will n=
eed
> >      clamp_length() implementing.
> =

> There's a max driven by the client's msize

The netfs read helpers provide you with a couple of options here:

 (1) You can use ->clamp_length() to do multiple slices of at least 1 byte
     each.  The assumption being that these represent parallel operations.=
  A
     new subreq will be generated for each slice.

 (2) You can go with large slices that are larger than msize, and just rea=
d
     part of it with each read.  After reading, the netfs helper will keep
     calling you again to read some more of it, provided you didn't return=
 an
     error and you at least read something.

> (client->msize - P9_IOHDRSZ ; unfortunately msize is just guaranted to b=
e >=3D
> 4k so that means the actual IO size would be smaller in that case even i=
f
> that's not intended to be common)

Does that mean you might be limited to reads of less than PAGE_SIZE on som=
e
systems (ppc64 for example)?  This isn't a problem for the read helper, bu=
t
might be an issue for writing from THPs.

> >  (*) The cache needs to be invalidated if a 3rd-party change happens, =
but I
> >      haven't done that.
> =

> There's no concurrent access logic in 9p as far as I'm aware (like NFS
> does if the mtime changes for example), so I assume we can keep ignoring
> this.

By that, I presume you mean concurrent accesses are just not permitted?

> >  (*) If 9p supports DIO writes, it should invalidate a cache object wi=
th
> >      FSCACHE_INVAL_DIO_WRITE when one happens - thereby stopping cachi=
ng for
> >      that file until all file handles on it are closed.
> =

> Not 100% sure actually there is some code about it but comment says it's
> disabled when cache is active; I'll check just found another problem
> with some queued patch that need fixing first...

Ok.

> > I forgot something: netfs_subreq_terminated() needs to be called when
> > the read is complete.  If p9_client_read() is synchronous, then that
> > would be here,
> =

> (it is synchronous; I'll add that suggestion)

Thanks.

David

