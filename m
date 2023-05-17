Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08297060EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 09:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjEQHQf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 May 2023 03:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjEQHQb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 May 2023 03:16:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15815449A;
        Wed, 17 May 2023 00:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=L9Rma4Q1qDKB9y05bibUf7H4u/Qt/w4qqQA7vkQBHhw=; b=hnjQeZYxV88CDNJnYVZxS9Ogzb
        /rGRANh+Rb2oHRd/CSQtpL38iDlXzfV/nCAWMRf91jzgaqNKYfBbwmGUb8+QPD91hTl51Bc680hAZ
        ytdAV872DJBp65Lq3M/dFlPE+K/X2cJGZ2Tc/+GHiXKHGKA5MN2lMgKjxglsO65x7F7f6cqFJfLfP
        SbgMZkqKL9Dap9wFQNXwfrdi7vpeYwndyFn8MsygBg3QNH/6cw8HPEJiFslgbOBIVV0MXL8e+yEII
        KZrHGXdkwuVc9pcQxDo0o+Ub6Sa+rw5uixfiA/ncblOwpyLFM03zj2RbQaMFKoRfhtjaNUqjsP1W4
        LUa2qddw==;
Received: from [2001:4bb8:188:3dd5:bc0:409a:ad8d:a02b] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pzBOa-008dWg-33;
        Wed, 17 May 2023 07:16:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     phillip@squashfs.org.uk
Cc:     akpm@linux-foundation.org, squashfs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] squashfs: don't include buffer_head.h
Date:   Wed, 17 May 2023 09:16:22 +0200
Message-Id: <20230517071622.245151-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Squashfs has stopped using buffers heads in 93e72b3c612adcaca1
("squashfs: migrate from ll_rw_block usage to BIO").

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/squashfs/block.c                     | 1 -
 fs/squashfs/decompressor.c              | 1 -
 fs/squashfs/decompressor_multi_percpu.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/fs/squashfs/block.c b/fs/squashfs/block.c
index bed3bb8b27fa3d..cb4e48baa4ba5b 100644
--- a/fs/squashfs/block.c
+++ b/fs/squashfs/block.c
@@ -18,7 +18,6 @@
 #include <linux/vfs.h>
 #include <linux/slab.h>
 #include <linux/string.h>
-#include <linux/buffer_head.h>
 #include <linux/bio.h>
 
 #include "squashfs_fs.h"
diff --git a/fs/squashfs/decompressor.c b/fs/squashfs/decompressor.c
index 8893cb9b419833..a676084be27e43 100644
--- a/fs/squashfs/decompressor.c
+++ b/fs/squashfs/decompressor.c
@@ -11,7 +11,6 @@
 #include <linux/types.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
-#include <linux/buffer_head.h>
 
 #include "squashfs_fs.h"
 #include "squashfs_fs_sb.h"
diff --git a/fs/squashfs/decompressor_multi_percpu.c b/fs/squashfs/decompressor_multi_percpu.c
index 1dfadf76ed9ae8..8a218e7c2390f2 100644
--- a/fs/squashfs/decompressor_multi_percpu.c
+++ b/fs/squashfs/decompressor_multi_percpu.c
@@ -7,7 +7,6 @@
 #include <linux/types.h>
 #include <linux/slab.h>
 #include <linux/percpu.h>
-#include <linux/buffer_head.h>
 #include <linux/local_lock.h>
 
 #include "squashfs_fs.h"
-- 
2.39.2

