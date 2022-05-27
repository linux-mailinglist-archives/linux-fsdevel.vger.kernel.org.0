Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B71B535E77
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 May 2022 12:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350625AbiE0KoF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 May 2022 06:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351006AbiE0KoE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 May 2022 06:44:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88558427F9
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 03:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653648241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=NHkSj7X5NKgJK27qI3S4gtnz+ks1f17QdsvgCRP5aYk=;
        b=V0Pn6Wf/7L+IuMW5KLkW2MW69H3cUhYrniwixM5xf4sZCujFLfiT6ugsp8bZQS0Y8Oa4nj
        Q7nUa7fIHFKvt6KfMhjqhv6imKFo7ZrPG/UinQZuFRXKKC2WJBEdK6JZ1l/3wr4muLdJjE
        JCztG8nJxJdSi6P+TDkEhYU17GQOc3w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-96-qgV3NnC9Nl-1jS02mYygBA-1; Fri, 27 May 2022 06:43:58 -0400
X-MC-Unique: qgV3NnC9Nl-1jS02mYygBA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 67CD4101AA46;
        Fri, 27 May 2022 10:43:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0A789C27E8F;
        Fri, 27 May 2022 10:43:55 +0000 (UTC)
Subject: [PATCH v3 0/9] cifs: Use iov_iters down to the network transport
From:   David Howells <dhowells@redhat.com>
To:     Steve French <smfrench@gmail.com>
Cc:     linux-cifs@vger.kernel.org,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Steve French <sfrench@samba.org>, dhowells@redhat.com,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 27 May 2022 11:43:55 +0100
Message-ID: <165364823513.3334034.11209090728654641458.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi Steve,

Here's a third version of a subset of my cifs-experimental branch.  It
alters the cifs driver to pass iov_iters down to the lowest layers where
they can be passed to the network transport.

ver #3)
- I fixed some things in the RDMA interface after running xfstests.  It now
  correctly chops up requests so that they'll actually fit within the
  available SGE slots, both for short and bulk requests.

- I also fixed both the cifs_readahead and cifs_writepages algorithms, so
  those now work properly - and I found and fixed a memory leak too.

cifs over softRoCE RDMA got as far as generic/138 before the RXE driver
  deadlocked itself.  I've posted a bug report for that.  Lockdep spotted
  the bug right away on mount.

cifs over softIWarp RDMA got as far as generic/006 before triggering a UAF
in the reconnect code, spotted by KASAN.  Both this and the above fail on
the vanilla kernel also.

Beyond the 6 main patches, there are two patches which add some trace
points (if they look of interest to you, I can properly fill out the commit
log) and the patch to make softiwarp work - all three of which can be
dropped.

I've pushed the patches here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=cifs-for-sfrench

David
---
David Howells (8):
      iov_iter: Add a function to extract an iter's buffers to a bvec iter
      iov_iter: Add a general purpose iteration function
      cifs: Add some helper functions
      cifs: Add a function to read into an iter from a socket
      cifs: Change the I/O paths to use an iterator rather than a page list
      cifs: Remove unused code
      cifs: Trace writedata page wrangling
      cifs: Add some RDMA send tracepoints

Namjae Jeon (1):
      cifs, ksmbd: Fix MAX_SGE count for softiwarp


 fs/cifs/cifsencrypt.c     |   40 +-
 fs/cifs/cifsfs.h          |    6 +
 fs/cifs/cifsglob.h        |   29 +-
 fs/cifs/cifsproto.h       |   11 +-
 fs/cifs/cifssmb.c         |  276 +++++--
 fs/cifs/connect.c         |   16 +
 fs/cifs/file.c            | 1434 ++++++++++++++-----------------------
 fs/cifs/fscache.c         |   22 +-
 fs/cifs/fscache.h         |   10 +-
 fs/cifs/misc.c            |  109 ---
 fs/cifs/smb2ops.c         |  367 +++++-----
 fs/cifs/smb2pdu.c         |   44 +-
 fs/cifs/smbdirect.c       |  335 ++++-----
 fs/cifs/smbdirect.h       |    6 +-
 fs/cifs/trace.h           |  161 +++++
 fs/cifs/transport.c       |   37 +-
 fs/ksmbd/transport_rdma.c |    2 +-
 include/linux/uio.h       |    8 +
 lib/iov_iter.c            |  133 ++++
 19 files changed, 1470 insertions(+), 1576 deletions(-)


