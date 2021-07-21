Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F34A93D16AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 20:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbhGUSO2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 14:14:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54312 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229833AbhGUSO1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 14:14:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626893703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jJTgBMXwThnuFAlDzExyHYWCk5DsYLxTDpEqi54da7Q=;
        b=dYmsSM8JqA/TQ6k30JybIhVZwlfxa04/EpXhMvM75RIgf8YRrap2H/HmimryA3TWrjWWBw
        iyCmosMWT9o+wpPsua4ElzVv7Rm1WgBM8FY06ef4MXAuZ+dyDsV5vsvmw9jtPudaQWQcvv
        rwOLCJEfuV14vq90Lk2Cz7esNaRrqWc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-_zwGKJtQPgywbHz1n30GUA-1; Wed, 21 Jul 2021 14:55:02 -0400
X-MC-Unique: _zwGKJtQPgywbHz1n30GUA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8567F2B6;
        Wed, 21 Jul 2021 18:54:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-62.rdu2.redhat.com [10.10.112.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D744F5D740;
        Wed, 21 Jul 2021 18:54:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <e7a3b850e8a42845f4e020c7642743b3dce2b9f1.camel@redhat.com>
References: <e7a3b850e8a42845f4e020c7642743b3dce2b9f1.camel@redhat.com> <162687506932.276387.14456718890524355509.stgit@warthog.procyon.org.uk> <162687511125.276387.15493860267582539643.stgit@warthog.procyon.org.uk>
To:     Jeff Layton <jlayton@redhat.com>
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Mike Marshall <hubcap@omnibond.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        devel@lists.orangefs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 03/12] netfs: Remove netfs_read_subrequest::transferred
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <298116.1626893692.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 21 Jul 2021 19:54:52 +0100
Message-ID: <298117.1626893692@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeff Layton <jlayton@redhat.com> wrote:

> The above two deltas seem like they should have been in patch #2.

Yeah.  Looks like at least partially so.

> > @@ -635,15 +625,8 @@ void netfs_subreq_terminated(struct netfs_read_su=
brequest *subreq,
> >  		goto failed;
> >  	}
> >  =

> > -	if (WARN(transferred_or_error > subreq->len - subreq->transferred,
> > -		 "Subreq overread: R%x[%x] %zd > %zu - %zu",
> > -		 rreq->debug_id, subreq->debug_index,
> > -		 transferred_or_error, subreq->len, subreq->transferred))
> > -		transferred_or_error =3D subreq->len - subreq->transferred;
> > -
> >  	subreq->error =3D 0;
> > -	subreq->transferred +=3D transferred_or_error;
> > -	if (subreq->transferred < subreq->len)
> > +	if (iov_iter_count(&subreq->iter))
> >  		goto incomplete;
> >  =

> =

> I must be missing it, but where does subreq->iter get advanced to the
> end of the current read? If you're getting rid of subreq->transferred
> then I think that has to happen above, no?

For afs, afs_req_issue_op() points fsreq->iter at the subrequest iterator =
and
calls afs_fetch_data().  Thereafter, we wend our way to
afs_deliver_fs_fetch_data() or yfs_deliver_fs_fetch_data() which set
call->iter to point to that iterator and then call afs_extract_data() whic=
h
passes it to rxrpc_kernel_recv_data(), which eventually passes it to
skb_copy_datagram_iter(), which advances the iterator.

For the cache, the subrequest iterator is passed to the cache backend by
netfs_read_from_cache().  This would be cachefiles_read() which calls
vfs_iocb_iter_read() which I thought advances the iterator (leastways,
filemap_read() keeps going until iov_iter_count() reaches 0 or some other =
stop
condition occurs and doesn't thereafter call iov_iter_revert()).

David

