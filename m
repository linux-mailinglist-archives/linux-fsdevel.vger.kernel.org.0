Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583615FF14E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Oct 2022 17:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbiJNP1Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Oct 2022 11:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbiJNP1S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Oct 2022 11:27:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E051D4DE7
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Oct 2022 08:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665761223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=epwEpOAT5Cl8SInIytePHPx8If+GKP8hKRIGGFonV6Q=;
        b=DG2Ujgk8FyndkLhONfsrHaufUiMDhHsovkasSPZiYjQbHFKX800VZHhgi7lI2JFpQ8TsoN
        508BaenSgfyWXqriS3xsXVOCb/7b/Lw4xN9G++qCLaEBIM447LZPvZnxmbUCYcRBIik23D
        VV0VxSXotmhofKjfi1Pk+hG2zTb+JcQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-315-w8bdphd0NM-OU1J8lrqGoQ-1; Fri, 14 Oct 2022 11:27:00 -0400
X-MC-Unique: w8bdphd0NM-OU1J8lrqGoQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9161B811E7A;
        Fri, 14 Oct 2022 15:26:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0453840C83EE;
        Fri, 14 Oct 2022 15:26:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com, willy@infradead.org, dchinner@redhat.com,
        Steve French <smfrench@gmail.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        torvalds@linux-foundation.org, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: How to convert I/O iterators to iterators, sglists and RDMA lists
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1762412.1665761217.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 14 Oct 2022 16:26:57 +0100
Message-ID: <1762414.1665761217@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph, Al,

One of the aims I have for netfslib is to hide the involvement of pages/fo=
lios
entirely from the filesystem.  That way the filesystem need not concern it=
self
with changes such as multipage folios appearing in the VM.

To this end, I'm trying to make it such that each netfs_io_subrequest cont=
ains
an iterator that describes the segment of buffer that a subrequest is deal=
ing
with.  The filesystem interprets the buffer appropriately, and can even pa=
ss
the iterator directly to kernel_sendmsg() or kernel_recvmsg() if this is
convenient.

In netfslib and in the network filesystems using it, however, there are a
number of situations where we need to "convert" an iterator:

 (1) Async direct I/O.

     In the async case direct I/O, we cannot hold on to the iterator when =
we
     return, even if the operation is still in progress (ie. we return
     EIOCBQUEUED), as it is likely to be on the caller's stack.

     Also, simply copying the iterator isn't sufficient as virtual userspa=
ce
     addresses cannot be trusted and we may have to pin the pages that
     comprise the buffer.

 (2) Crypto.

     The crypto interface takes scatterlists, not iterators, so we need to=
 be
     able to convert an iterator into a scatterlist in order to do content
     encryption within netfslib.  Doing this in netfslib makes it easier t=
o
     store content-encrypted files encrypted in fscache.

 (3) RDMA.

     To perform RDMA, a buffer list needs to be presented as a QPE array.
     Currently, cifs converts the iterator it is given to lists of pages, =
then
     each list to a scatterlist and thence to a QPE array.  I have code to
     pass the iterator down to the bottom, using an intermediate BVEC iter=
ator
     instead of a page list if I can't pass down the original directly (eg=
. an
     XARRAY iterator on the pagecache), but I still end up converting it t=
o a
     scatterlist, which is then converted to a QPE.  I'm trying to go dire=
ctly
     from an iterator to a QPE array, thus avoiding the need to allocate a=
n
     sglist.

Constraints:

 (A) Userspace gives us a list (IOVEC/UBUF) of buffers that may not be pag=
e
     aligned and may not be contiguous; further, within a particular buffe=
r
     span, the pages may not be contiguous and may be part of multipage
     folios.

     Converting to a BVEC iterator allows a whole buffer to be described, =
and
     extracting a subset of a BVEC iterator is straightforward.

 (B) Kernel buffers may not be pinnable.  If we get a KVEC iterator, say, =
we
     can't assume that we can pin the pages (say the buffer is part of the
     kernel rodata or belongs to a device - say a flash).

     This may also apply to mmap'd devices in userspace iovecs.

 (C) We don't want to pin pages if we can avoid it.

 (D) PIPE iterators.


So, my first attempt at dealing with (1) involved creating a function that
extracted part of an iterator into another iterator[2].  Just copying and
shaping if possible (assuming, say, that an XARRAY iterator doesn't need t=
o
pin the pages), but otherwise using repeated application of
iov_iter_get_pages() to build up a BVEC iterator (which is basically just =
a
list of {page,offset,len} tuples).

Al objected on the basis that it was pinning pages that it didn't need to =
(say
extracting BVEC->BVEC) and that it didn't deal correctly with PIPE (becaus=
e
the underlying pipe would get advanced too early) or KVEC/BVEC (because it
might refer to a page that was un-get_pages-able).

Christoph objected that it shouldn't be available as a general purpose hel=
per
and that it should be kept inside cifs - but I'm wanting to use it inside =
of
netfslib also.

My first attempt at dealing with (2) involved creating a function to scan =
an
iterator[2] and call a function on each segment of it.  This could be used=
 to
perform checksumming or to build up a scatterlist.  However, as Al pointed
out, I didn't get the IOBUF or KVEC handling right.  Mostly, though, I wan=
t to
convert to an sglist and work from that.

I then had a go at implementing a common framework[3] to extract an iterat=
or
into another iterator, an sglist, a RDMA QPE array or any other type of li=
st
we might envision.  Al's not keen on that for a number of reasons (see his
reply) including that it loses type safety and that I should be using
iov_iter_get_pages2() - which he already objected to me doing in[1]:-/


So any thoughts on what the right way to do this is?  What is the right AP=
I?

I have three things I need to make from a source iterator: a copy and/or a
subset iterator, a scatterlist and an RDMA QPE array, and several differen=
t
types of iterator to extract from.  I shouldn't pin pages unless I need to=
,
sometimes pages cannot be pinned and sometimes I may have to add the physi=
cal
address to the entry.

If I can share part of the infrastructure, that would seem to be a good th=
ing.

David

https://lore.kernel.org/r/165364824259.3334034.5837838050291740324.stgit@w=
arthog.procyon.org.uk/ [1]
https://lore.kernel.org/r/165364824973.3334034.10715738699511650662.stgit@=
warthog.procyon.org.uk/ [2]
https://lore.kernel.org/r/3750754.1662765490@warthog.procyon.org.uk/ [3]

