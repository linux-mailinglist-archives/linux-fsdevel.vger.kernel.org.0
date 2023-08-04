Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8C47700E2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 15:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjHDNOQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 09:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjHDNOP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:14:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CAF11B
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Aug 2023 06:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691154814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=YdazvjmGmZmgj91lOlAbSLPEx72pSHsRbgB1k8qsYaw=;
        b=BE4i2nsv9/PZprM6g6yVUnx0Fko+veOX0Cu3D/g7QMdxqwYvJQmIZhecfUwEAttkrhTh3b
        WEh10U1eYokbcwcQYXoFBXZeqkpncytVZBAVWKacnV0of2dPMsGmJm06n+2mMqCs3AQYKi
        1Lg+6M0wU/CyKJ11WkqCTglgws+ik4I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-370-MjUsA69JPfGO44TxO2PFBQ-1; Fri, 04 Aug 2023 09:13:32 -0400
X-MC-Unique: MjUsA69JPfGO44TxO2PFBQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 274C180006E;
        Fri,  4 Aug 2023 13:13:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3DE8F112132D;
        Fri,  4 Aug 2023 13:13:30 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 00/18] ceph, rbd: Collapse all the I/O types down to something iov_iter-based
Date:   Fri,  4 Aug 2023 14:13:09 +0100
Message-ID: <20230804131327.2574082-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Ilya, Xiubo,

[!] NOTE: This is a preview of a work in progress and doesn't yet fully
    compile, let alone actually work!

Here are some patches that (mostly) collapse the different I/O types
(PAGES, PAGELIST, BVECS, BIO) down to a single one.  I added a new type,
ceph_databuf, to make this easier.  The page list is attached to that as a
bio_vec[] with an iov_iter, but could also be some other type supported by
the iov_iter.  The iov_iter defines the data or buffer to be used.  I have
an additional iov_iter type implemented that allows use of a straight
folio[] or page[] instead of a bio_vec[] that I can deploy if that proves
more useful.

The conversion isn't quite complete:

 (1) rbd is done; BVECS and BIO types are replaced with ceph_databuf.

 (2) ceph_osd_linger_request::preply_pages needs switching over to a
     ceph_databuf, but I haven't yet managed to work out how the pages that
     handle_watch_notify() sticks in there come about.

 (3) I haven't altered data transmission in net/ceph/messenger*.c yet.  The
     aim is to reduce it to a single sendmsg() call for each ceph_msg_data
     struct, using the iov_iter therein.

 (4) The data reception routines in net/ceph/messenger*.c also need
     modifying to pass each ceph_msg_data::iter to recvmsg() in turn.

 (5) It might be possible to merge struct ceph_databuf into struct
     ceph_msg_data and eliminate the former.

 (6) fs/ceph/ still needs some work to clean up the use of page arrays.

 (7) I would like to change front and middle buffers with a ceph_databuf,
     vmapping them when we need to access them.

I added a kmap_ceph_databuf_page() macro and used that to get a page and
use kmap_local_page() on it to hide the bvec[] inside to make it easier to
replace.

Anyway, if anyone has any thoughts...


I've pushed the patches here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=iov-extract

David

David Howells (18):
  iov_iter: Add function to see if buffer is all zeros
  ceph: Rename alignment to offset
  ceph: Add a new data container type, ceph_databuf
  ceph: Convert ceph_mds_request::r_pagelist to a databuf
  rbd: Use ceph_databuf for rbd_obj_read_sync()
  ceph: Change ceph_osdc_call()'s reply to a ceph_databuf
  ceph: Unexport osd_req_op_cls_request_data_pages()
  ceph: Remove osd_req_op_cls_response_data_pages()
  ceph: Convert notify_id_pages to a ceph_databuf
  rbd: Switch from using bvec_iter to iov_iter
  ceph: Remove bvec and bio data container types
  ceph: Convert some page arrays to ceph_databuf
  ceph: Convert users of ceph_pagelist to ceph_databuf
  ceph: Remove ceph_pagelist
  ceph: Convert ceph_osdc_notify() reply to ceph_databuf
  ceph: Remove CEPH_OS_DATA_TYPE_PAGES and its attendant helpers
  ceph: Remove CEPH_MSG_DATA_PAGES and its helpers
  ceph: Don't use data_pages

 drivers/block/rbd.c             | 645 ++++++++++----------------------
 fs/ceph/acl.c                   |  39 +-
 fs/ceph/addr.c                  |  18 +-
 fs/ceph/file.c                  | 157 ++++----
 fs/ceph/inode.c                 |  85 ++---
 fs/ceph/locks.c                 |  23 +-
 fs/ceph/mds_client.c            | 134 ++++---
 fs/ceph/mds_client.h            |   2 +-
 fs/ceph/super.h                 |   8 +-
 fs/ceph/xattr.c                 |  68 ++--
 include/linux/ceph/databuf.h    |  65 ++++
 include/linux/ceph/messenger.h  | 141 +------
 include/linux/ceph/osd_client.h |  97 ++---
 include/linux/ceph/pagelist.h   |  72 ----
 include/linux/uio.h             |   1 +
 lib/iov_iter.c                  |  22 ++
 net/ceph/Makefile               |   5 +-
 net/ceph/cls_lock_client.c      |  40 +-
 net/ceph/databuf.c              | 149 ++++++++
 net/ceph/messenger.c            | 376 +------------------
 net/ceph/osd_client.c           | 430 +++++++--------------
 net/ceph/pagelist.c             | 171 ---------
 22 files changed, 876 insertions(+), 1872 deletions(-)
 create mode 100644 include/linux/ceph/databuf.h
 delete mode 100644 include/linux/ceph/pagelist.h
 create mode 100644 net/ceph/databuf.c
 delete mode 100644 net/ceph/pagelist.c

