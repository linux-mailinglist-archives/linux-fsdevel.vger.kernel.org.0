Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B872C254B6C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 19:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgH0RC2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 13:02:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28194 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726093AbgH0RC1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 13:02:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598547745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NMjSe8/lymTip6a6jkuCTdmDon/Viuu47OP6Nmp2Xco=;
        b=CrWfbuSu7R9oI8fs1lU7InzhGRayI4DEcLlQsKHfn64d6Q5EJtOJdvL2h4nfeLpYQKtP2D
        nRGsTggtl9mVSRf3FmHAIk1Rr6CW0RZ/nq5pc/CKjW4orCX8jz2XZlD1yADttWWe6bJRmx
        hBJfs7TuC/ONt9rFpv8Nhs5EW/D80SE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-7qs9sGcuPae4mYKQrsDu5Q-1; Thu, 27 Aug 2020 13:02:21 -0400
X-MC-Unique: 7qs9sGcuPae4mYKQrsDu5Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80BC41074657;
        Thu, 27 Aug 2020 17:02:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-127.rdu2.redhat.com [10.10.120.127])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7618A50B3F;
        Thu, 27 Aug 2020 17:02:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200826193116.GU17456@casper.infradead.org>
References: <20200826193116.GU17456@casper.infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Mike Marshall <hubcap@omnibond.com>
Subject: Re: The future of readahead
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1441310.1598547738.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 27 Aug 2020 18:02:18 +0100
Message-ID: <1441311.1598547738@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> So solving #2 and #3 looks like a new interface for filesystems to call:
> =

> void readahead_expand(struct readahead_control *rac, loff_t start, u64 l=
en);
> or possibly
> void readahead_expand(struct readahead_control *rac, pgoff_t start,
> 		unsigned int count);
> =

> It might not actually expand the readahead attempt at all -- for example=
,
> if there's already a page in the page cache, or if it can't allocate
> memory.  But this puts the responsibility for allocating pages in the VF=
S,
> where it belongs.

This is exactly what the fscache read helper in my fscache rewrite is doin=
g,
except that I'm doing it in fs/fscache/read_helper.c.

Have a look here:

	https://lore.kernel.org/linux-fsdevel/159465810864.1376674.10267227421160=
756746.stgit@warthog.procyon.org.uk/

and look for the fscache_read_helper() function.

Note that it's slighly complicated because it handles ->readpage(),
->readpages() and ->write_begin()[*].

[*] I want to be able to bring the granule into the cache for modification=
.
    Ideally I'd be able to see that the entire granule is going to get wri=
tten
    over and skip - kind of like write_begin for a whole granule rather th=
an a
    page.

Shaping the readahead request has the following issues:

 (1) The request may span multiple granules.

 (2) Those granules may be a mixture of cached and uncached.

 (3) The granule size may vary.

 (4) Granules fall on power-of-2 boundaries (for example 256K boundaries)
     within the file, but the request may not start on a boundary and may =
not
     end on one.

To deal with this, fscache_read_helper() calls out to the cache backend
(fscache_shape_request()) and the netfs (req->ops->reshape()) to adjust th=
e
read it's going to make.  Shaping the request may mean moving the start
earlier as well as expanding or contracting the size.  The only thing that=
's
guaranteed is that the first page of the request will be retained.

I also don't let a request cross a cached/uncached boundary, but rather cu=
t
the request off there and return.  The filesystem can then generate a new
request and call back in.  (Note that I have to be able to keep track of t=
he
filesystem's metadata so that I can reissue the request to the netfs in th=
e
event that cache suffers some sort of error).

What I was originally envisioning for the new ->readahead() interface is a=
dd a
second aop that allows the shaping to be accessed by the VM, before it's
started pinning any pages.

The shaping parameters I think we need are:

	- The inode, for i_size and fscache cookie
	- The proposed page range

and what you would get back could be:

	- Shaped page range
	- Minimum I/O granularity[1]
	- Minimum preferred granularity[2]
	- Flag indicating if the pages can just be zero-filled[3]

[1] The filesystem doesn't want to read in smaller chunks than this.

[2] The cache doesn't want to read in smaller chunks than this, though in =
the
    cache's case, a partially read block is just abandoned for the moment.
    This number would allow the readahead algorithm to shorten the request=
 if
    it can't allocate a page.

[3] If I know that the local i_size is much bigger than the i_size on the
    server, there's no need to download/read those pages and readahead can
    just clear them.  This is more applicable to write_begin() normally.

Now a chunk of this is in struct readahead_control, so it might be reasona=
ble
to add the other bits there too.

Note that one thing I really would like to avoid having to do is to expand=
 a
request forward, particularly if the main page of interest is precreated a=
nd
locked by the VM before calling the filesystem.  I would much rather the V=
M
created the pages, starting from the lowest-numbered.

Anyway, that's my 2p.
David

