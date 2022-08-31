Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879DF5A7718
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Aug 2022 09:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbiHaHKJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 03:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiHaHKG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 03:10:06 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC732E03D;
        Wed, 31 Aug 2022 00:10:03 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MHZvP637NzYcy3;
        Wed, 31 Aug 2022 15:05:37 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 31 Aug
 2022 15:10:00 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <cluster-devel@redhat.com>,
        <ntfs3@lists.linux.dev>, <ocfs2-devel@oss.oracle.com>,
        <reiserfs-devel@vger.kernel.org>
CC:     <jack@suse.cz>, <tytso@mit.edu>, <akpm@linux-foundation.org>,
        <axboe@kernel.dk>, <viro@zeniv.linux.org.uk>,
        <rpeterso@redhat.com>, <agruenba@redhat.com>,
        <almaz.alexandrovich@paragon-software.com>, <mark@fasheh.com>,
        <dushistov@mail.ru>, <hch@infradead.org>, <yi.zhang@huawei.com>,
        <chengzhihao1@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH 00/14] buffer: remove ll_rw_block()
Date:   Wed, 31 Aug 2022 15:20:57 +0800
Message-ID: <20220831072111.3569680-1-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ll_rw_block() will skip locked buffer before submitting IO, it assumes
that locked buffer means it is under IO. This assumption is not always
true because we cannot guarantee every buffer lock path would submit
IO. After commit 88dbcbb3a484 ("blkdev: avoid migration stalls for
blkdev pages"), buffer_migrate_folio_norefs() becomes one exceptional
case, and there may be others. So ll_rw_block() is not safe on the sync
read path, we could get false positive EIO return value when filesystem
reading metadata. It seems that it could be only used on the readahead
path.

Unfortunately, many filesystem misuse the ll_rw_block() on the sync read
path. This patch set just remove ll_rw_block() and add new friendly
helpers, which could prevent false positive EIO on the read metadata
path. Thanks for the suggestion from Jan, the original discussion is at
[1].

 patch 1: remove unused helpers in fs/buffer.c
 patch 2: add new bh_read_[*] helpers
 patch 3-11: remove all ll_rw_block() calls in filesystems
 patch 12-14: do some leftover cleanups.

Thanks,
Yi.

[1]. https://lore.kernel.org/linux-mm/20220825080146.2021641-1-chengzhihao1@huawei.com/

Zhang Yi (14):
  fs/buffer: remove __breadahead_gfp()
  fs/buffer: add some new buffer read helpers
  fs/buffer: replace ll_rw_block()
  gfs2: replace ll_rw_block()
  isofs: replace ll_rw_block()
  jbd2: replace ll_rw_block()
  ntfs3: replace ll_rw_block()
  ocfs2: replace ll_rw_block()
  reiserfs: replace ll_rw_block()
  udf: replace ll_rw_block()
  ufs: replace ll_rw_block()
  fs/buffer: remove ll_rw_block() helper
  ext2: replace bh_submit_read() helper with bh_read_locked()
  fs/buffer: remove bh_submit_read() helper

 fs/buffer.c                 | 150 +++++++++++++++---------------------
 fs/ext2/balloc.c            |   2 +-
 fs/gfs2/meta_io.c           |   6 +-
 fs/gfs2/quota.c             |   4 +-
 fs/isofs/compress.c         |   2 +-
 fs/jbd2/journal.c           |   7 +-
 fs/jbd2/recovery.c          |  16 ++--
 fs/ntfs3/inode.c            |   7 +-
 fs/ocfs2/aops.c             |   2 +-
 fs/ocfs2/super.c            |   5 +-
 fs/reiserfs/journal.c       |  11 +--
 fs/reiserfs/stree.c         |   4 +-
 fs/reiserfs/super.c         |   4 +-
 fs/udf/dir.c                |   2 +-
 fs/udf/directory.c          |   2 +-
 fs/udf/inode.c              |   5 +-
 fs/ufs/balloc.c             |   4 +-
 include/linux/buffer_head.h |  47 ++++++++---
 18 files changed, 135 insertions(+), 145 deletions(-)

-- 
2.31.1

