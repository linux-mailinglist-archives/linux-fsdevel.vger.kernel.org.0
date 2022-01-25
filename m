Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA1249B882
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jan 2022 17:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352870AbiAYQVw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jan 2022 11:21:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:24854 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241090AbiAYQQc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jan 2022 11:16:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643127386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BgT1E20ri3cxt8CbRBVfeIbwdx60ZOrpnL5xCfuxcBk=;
        b=iq+YY8dDMnj8fOS46OzkWHpAABFa9H27bihvNjW51EKJiSh/68Q9bWksIAZXrFYXs1JzHK
        Pw5+WznIPD/XAg6MHVS+0H8yoZQfkB/6DFFyJQ6YfQPspgUchBDWmJRV0okoVeIEuboUHi
        b7gPm9ybIrwh7qwAEq4H9E78HnX/9WQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-597-tiOAcsb0MG29xsEXCYTEQg-1; Tue, 25 Jan 2022 11:16:22 -0500
X-MC-Unique: tiOAcsb0MG29xsEXCYTEQg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C913639385;
        Tue, 25 Jan 2022 16:16:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 62E6484D08;
        Tue, 25 Jan 2022 16:15:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20220118131216.85338-1-jefflexu@linux.alibaba.com>
References: <20220118131216.85338-1-jefflexu@linux.alibaba.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/20] fscache,erofs: fscache-based demand-read semantics
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2815557.1643127330.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 25 Jan 2022 16:15:30 +0000
Message-ID: <2815558.1643127330@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeffle Xu <jefflexu@linux.alibaba.com> wrote:

> The following issues still need further discussion. Thanks for your time
> and patience.
> =

> 1. I noticed that there's refactoring of netfs library[1],
> ...
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.gi=
t/log/?h=3Dnetfs-lib

Yes.  I'm working towards getting netfslib to do handling writes and dio a=
s
well as reads, along with content crypto/compression, and the idea I'm aim=
ing
towards is that you just point your address_space_ops at netfs directly if
possible - but it's going to require its own context now to manage pending
writes.

See my netfs-experimental branch for more of that - it's still a work in
progress, though.

Btw, you could set rreq->netfs_priv in ->init_rreq() rather than passing i=
t in
to netfs_readpage().

> 2. The current implementation will severely conflict with the
> refactoring of netfs library[1][2]. The assumption of 'struct
> netfs_i_context' [2] is that, every file in the upper netfs will
> correspond to only one backing file. While in our scenario, one file in
> erofs can correspond to multiple backing files. That is, the content of
> one file can be divided into multiple chunks, and are distrubuted over
> multiple blob files, i.e. multiple backing files. Currently I have no
> good idea solving this conflic.

I can think of a couple of options to explore:

 (1) Duplicate the cachefiles backend.  You can discard a lot of it, since=
 a
     much of it is concerned with managing local modifications - which you=
're
     not going to do since you have a R/O filesystem and you're looking at
     importing files into the cache externally to the kernel.

     I would suggest looking to see if you can do the blob mapping in the
     backend rather than passing the offset down.  Maybe make the cookie i=
ndex
     key hold the index too, e.g. "/path/to/file+offset".

     Btw, do you still need cachefilesd for its culling duties?

 (2) Do you actually need to go through netfslib?  Might it be easier to c=
all
     fscache_read() directly?  Have a look at fs/nfs/fscache.c

> Besides there are still two quetions:
> - What's the plan of [1]? When is it planned to be merged?

Hopefully next merge window, but that's going to depend on a number of thi=
ngs.

> - It seems that all upper fs using fscache is going to use netfs API,
>   while the APIs like fscache_read_or_alloc_page() are deprecated. Is
>   that true?

fscache_read_or_alloc_page() is gone completely.

You don't have to use the netfs API.  You can talk to fscache directly,
doing DIO from the cache to an xarray-class iov_iter constructed from your
inode's pagecache.

netfslib provides/will provide a number of services, such as multipage
folios, transparent caching, crypto, compression and hiding the existence =
of
pages/folios from the filesystem as entirely as possible.  However, you
already have some of these implemented on top of iomap for the blockdev
interface, it would appear.

David

