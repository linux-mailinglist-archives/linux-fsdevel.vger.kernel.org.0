Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647C4611676
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 17:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiJ1P5C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 11:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiJ1P44 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:56:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A9E1C813E
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Oct 2022 08:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666972553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=hQM2P8ykq/hiieMREgaD1+G+mSyHhsgs0GYOAB71Ku0=;
        b=QBj9aP+JbBedvgZWbJ3lNOS9Zw3GO7OfeY8axloSQWS7OXk8m3pUA3nF7z0OZJeM64diOV
        obK0ahCmYhdSQDZc/4IVwsT/vYmmQFMF4vgU8fe+jMJ6FAXEazHwowtGYlaRy7vSwvFA3e
        zwKxdzJxjVbK/T1LyUkZIXVwm03Rabg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-250-krPUD6jBPLSCY8bxTUkkhg-1; Fri, 28 Oct 2022 11:55:48 -0400
X-MC-Unique: krPUD6jBPLSCY8bxTUkkhg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 79074185A794;
        Fri, 28 Oct 2022 15:55:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.73])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C7F9A1415102;
        Fri, 28 Oct 2022 15:55:45 +0000 (UTC)
Subject: [RFC PATCH 0/9] smb3: Add iter helpers and use iov_iters down to the
 network transport
From:   David Howells <dhowells@redhat.com>
To:     Steve French <smfrench@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Rohith Surabattula <rohiths.msft@gmail.com>,
        Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        linux-cifs@vger.kernel.org, dhowells@redhat.com,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Tom Talpey <tom@talpey.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 28 Oct 2022 16:55:44 +0100
Message-ID: <166697254399.61150.1256557652599252121.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi Steve, Al, Christoph,

Here's an updated version of a subset of my branch to make the cifs/smb3
driver pass iov_iters down to the lowest layers where they can be passed to
the network transport.

Al, Christoph: Could you look at the first four patches and see if you're okay
with them - at least on a temporary basis so that I can get this moving?

Note that patch (4) uses kmap_local_folio() to map an entire folio - this is
wrong.  I'm going to try using Willy's vmap_folio() code - but I haven't done
that yet.

The first two patches are placed in netfslib as I have patches for netfslib
that will want to use them:

 (1) Add a function to extract part of an IOVEC-/UBUF-type iterator into a
     BVEC-type iterator.  Refs are taken on the pages to prevent them from
     evaporating.

 (2) Add a function to extract part of an iterator into a scatterlist.  If
     extracting from an IOVEC-/UBUF-type iterator, the pages have refs taken on
     them; any other type and they don't.

     It might be worth splitting this into two separate functions, one for
     IOVEC/UBUF that refs and one for the others that doesn't.

The other patches are placed in cifs as they're only used by cifs for now.

 (3) Add a function to build an RDMA SGE list from a BVEC-, KVEC- or
     XARRAY-type iterator.  It's left to the caller to make sure they don't
     evaporate.

 (4) Add a function to hash part of the contents of a BVEC-, KVEC- or
     XARRAY-type iterator.

I will need to make use of thew proposed page pinning when it becomes
available, but that's not yet.

Changes made in a later patch in the series make the upper layers convert an
IOVEC-/UBUF-iterator to a BVEC-type iterator in direct/unbuffered I/O so that
the signing, crypt and RDMA code see the BVEC instead of user buffers.

Note also that I haven't managed to test all the combinations of transport.
Samba doesn't support RDMA and ksmbd doesn't support encryption.  I can test
them separately, but not together.  That said, rdma, sign, seal and sign+seal
seem to work.

I've pushed the patches here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=cifs-for-viro

David
---
David Howells (9):
      netfs: Add a function to extract a UBUF or IOVEC into a BVEC iterator
      netfs: Add a function to extract an iterator into a scatterlist
      cifs: Add a function to build an RDMA SGE list from an iterator
      cifs: Add a function to Hash the contents of an iterator
      cifs: Add some helper functions
      cifs: Add a function to read into an iter from a socket
      cifs: Change the I/O paths to use an iterator rather than a page list
      cifs: Build the RDMA SGE list directly from an iterator
      cifs: Remove unused code


 fs/cifs/cifsencrypt.c |  167 +++-
 fs/cifs/cifsfs.h      |    3 +
 fs/cifs/cifsglob.h    |   30 +-
 fs/cifs/cifsproto.h   |   11 +-
 fs/cifs/cifssmb.c     |   13 +-
 fs/cifs/connect.c     |   16 +
 fs/cifs/file.c        | 1700 ++++++++++++++++++-----------------------
 fs/cifs/fscache.c     |   22 +-
 fs/cifs/fscache.h     |   10 +-
 fs/cifs/misc.c        |  110 +--
 fs/cifs/smb2ops.c     |  378 +++++----
 fs/cifs/smb2pdu.c     |   44 +-
 fs/cifs/smbdirect.c   |  503 +++++++-----
 fs/cifs/smbdirect.h   |    4 +-
 fs/cifs/transport.c   |   57 +-
 fs/netfs/Makefile     |    1 +
 fs/netfs/iterator.c   |  347 +++++++++
 include/linux/netfs.h |    5 +
 18 files changed, 1835 insertions(+), 1586 deletions(-)
 create mode 100644 fs/netfs/iterator.c


