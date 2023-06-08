Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4127275A6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 05:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234035AbjFHDYa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 23:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234019AbjFHDYV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 23:24:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DDB1BF7;
        Wed,  7 Jun 2023 20:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=sMjmb+Wm54NnkkgYgz+La9q4lHjnPp58T0sIUFLYLug=; b=PYnv5Nlik3D3xkttqofPCLeerz
        6toPkObfXRJV+vaqW+1uGWp5TU5vbR7LxWr1TeadroX29KvxG31CxZq2RiOSmGmBW3Hmdd3KgCEEP
        KCU+6sPf8Z+IMDADGYBL7cI07DaTFCrvQFsF6o42U8wlZeDWOSixdpoTM3gYsTyOK7/6fGQQDxpSY
        Vu/mdZNpxoS0qV8gGbotX8ZTuxij7qvgC562L3iAsGqqamU2bvRgRV0C4iCdx/PBxWOszFWhrbEdW
        NkIudd5ueFlTXBAHHfL+NalrmDvnmD65A8GuAQkbOdi0COUy2RLofqPjiY/NY7fLa/u0n+sI8J4gc
        xuBCCOFg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q76Fr-007uui-2h;
        Thu, 08 Jun 2023 03:24:07 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     hch@infradead.org, djwong@kernel.org, dchinner@redhat.com,
        kbusch@kernel.org, willy@infradead.org
Cc:     hare@suse.de, ritesh.list@gmail.com, rgoldwyn@suse.com,
        jack@suse.cz, patches@lists.linux.dev, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        p.raghav@samsung.com, da.gomez@samsung.com, rohan.puri@samsung.com,
        rpuri.linux@gmail.com, mcgrof@kernel.org, corbet@lwn.net,
        jake@lwn.net
Subject: [RFC 1/4] bdev: replace export of blockdev_superblock with BDEVFS_MAGIC
Date:   Wed,  7 Jun 2023 20:24:01 -0700
Message-Id: <20230608032404.1887046-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230608032404.1887046-1-mcgrof@kernel.org>
References: <20230608032404.1887046-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is no need to export blockdev_superblock because we can just
use the magic value of the block device cache super block, which is
already in place, BDEVFS_MAGIC. So just check for that.

This let's us remove the export of blockdev_superblock and also
let's this block dev cache scale as it wishes internally. For
instance in the future we may have different super block for each
block device. Right now it is all shared on one super block.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/bdev.c       | 1 -
 include/linux/fs.h | 4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 21c63bfef323..91477c3849d2 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -379,7 +379,6 @@ static struct file_system_type bd_type = {
 };
 
 struct super_block *blockdev_superblock __read_mostly;
-EXPORT_SYMBOL_GPL(blockdev_superblock);
 
 void __init bdev_cache_init(void)
 {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 0b54ac1d331b..948a384af8a3 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -43,6 +43,7 @@
 #include <linux/cred.h>
 #include <linux/mnt_idmapping.h>
 #include <linux/slab.h>
+#include <uapi/linux/magic.h>
 
 #include <asm/byteorder.h>
 #include <uapi/linux/fs.h>
@@ -2388,10 +2389,9 @@ extern struct kmem_cache *names_cachep;
 #define __getname()		kmem_cache_alloc(names_cachep, GFP_KERNEL)
 #define __putname(name)		kmem_cache_free(names_cachep, (void *)(name))
 
-extern struct super_block *blockdev_superblock;
 static inline bool sb_is_blkdev_sb(struct super_block *sb)
 {
-	return IS_ENABLED(CONFIG_BLOCK) && sb == blockdev_superblock;
+	return IS_ENABLED(CONFIG_BLOCK) && sb->s_magic == BDEVFS_MAGIC;
 }
 
 void emergency_thaw_all(void);
-- 
2.39.2

