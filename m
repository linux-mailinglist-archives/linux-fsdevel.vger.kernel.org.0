Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5AF24BD2B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Feb 2022 00:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245275AbiBTXXR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Feb 2022 18:23:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245268AbiBTXXD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Feb 2022 18:23:03 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE412DCB;
        Sun, 20 Feb 2022 15:22:41 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id p15so28458332ejc.7;
        Sun, 20 Feb 2022 15:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+/6FVXbQ7tm987ktGB+50LSyqQ0w7Psn1nbQn39v9Mk=;
        b=jh2B04F4bFkcklCxKRTTZz0yBhTx7u775Sqvphij1AvQP67vOcwiZ8O+cZNkibc0n0
         LWAX/XeaLXXDQYPV2G8mZxF6BZmPFXlS1NDwUts88vpGhXC2PXF6dJRo5CrsMQRW+uyq
         SgQ5LaPPGoC+01nVCq5mlzWVJthO76ECbX+x+PdJcNbwgMbh/5KH4uuAKCUuUhQ37xgp
         dnsciCyQS5W5gFzgG7x8AIk1rUorxKQE2orvzMEnz9pFhNujB39Xyt1le0fGVpOB22mb
         pyMCURUTQ0Pb1j3jeXg5NxzjXrwRqfpIZ1rwd3JTrX6dMUNWgJzqHy5E56PNvdPQ1+Fw
         O+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+/6FVXbQ7tm987ktGB+50LSyqQ0w7Psn1nbQn39v9Mk=;
        b=srxFT2afLF86HiB4OYAXTFDjtcwgwj9g9dETxd4OS23UtZvV91tUGGzWC4aodaDAxy
         YfRHnZTCrCOpzwYRoGef+FqJZVwc1Z3zOaB4R0cCvPbd8qlYBYM1uCUG2F6doLHFv1Qg
         ejLJSOz28aQIblpEm55711VDFQQKdILotbcrbxffTQD4K9b1DQtmsQSJ7rJj5BOY5lmd
         CSApnahrmh5rRQdLt5eT/xrbswb3otrYrCCeo2woiMFkw5aLm7DL/P9euQcTg/NgTtv9
         GUfLK0tB0fQdmTqHyNzAML3f/NT+/VY7jnt4LcUUSDVWGe+XfAdYREfc5V94FeKrPUvY
         fCHg==
X-Gm-Message-State: AOAM531bvutTOPQ4TzGCiob+7U/g/C+kchFrgbr9vVoZvxCem8Gmgic2
        t8OyTtGkIZmntuJ3qxRogww=
X-Google-Smtp-Source: ABdhPJxypxWpPrNCfXhZ4GXbRyH1nZn37fM7+e/ArYeJA2Y/LyCbU+ewjEVtcm9hgLeiVlyZ+9dAuQ==
X-Received: by 2002:a17:906:7e52:b0:6cf:cf1a:17f with SMTP id z18-20020a1709067e5200b006cfcf1a017fmr13498500ejr.251.1645399360058;
        Sun, 20 Feb 2022 15:22:40 -0800 (PST)
Received: from localhost.localdomain (ip-046-005-230-144.um12.pools.vodafone-ip.de. [46.5.230.144])
        by smtp.gmail.com with ESMTPSA id y27sm4611031ejd.19.2022.02.20.15.22.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 20 Feb 2022 15:22:39 -0800 (PST)
From:   Edward Shishkin <edward.shishkin@gmail.com>
To:     willy@infradead.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, reiserfs-devel@vger.kernel.org,
        jack@suse.cz
Cc:     Edward Shishkin <edward.shishkin@gmail.com>
Subject: [PATCH] reiserfs: get rid of AOP_FLAG_CONT_EXPAND flag
Date:   Mon, 21 Feb 2022 00:22:19 +0100
Message-Id: <20220220232219.1235-1-edward.shishkin@gmail.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <fbc744c9-e22f-138c-2da3-f76c3edfcc3d@gmail.com>
References: <fbc744c9-e22f-138c-2da3-f76c3edfcc3d@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Edward Shishkin <edward.shishkin@gmail.com>
---
 fs/reiserfs/inode.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
index f49b72ccac4c..e943930939f5 100644
--- a/fs/reiserfs/inode.c
+++ b/fs/reiserfs/inode.c
@@ -2763,13 +2763,6 @@ static int reiserfs_write_begin(struct file *file,
 	int old_ref = 0;
 
  	inode = mapping->host;
-	*fsdata = NULL;
- 	if (flags & AOP_FLAG_CONT_EXPAND &&
- 	    (pos & (inode->i_sb->s_blocksize - 1)) == 0) {
- 		pos ++;
-		*fsdata = (void *)(unsigned long)flags;
-	}
-
 	index = pos >> PAGE_SHIFT;
 	page = grab_cache_page_write_begin(mapping, index, flags);
 	if (!page)
@@ -2896,9 +2889,6 @@ static int reiserfs_write_end(struct file *file, struct address_space *mapping,
 	unsigned start;
 	bool locked = false;
 
-	if ((unsigned long)fsdata & AOP_FLAG_CONT_EXPAND)
-		pos ++;
-
 	reiserfs_wait_on_write_block(inode->i_sb);
 	if (reiserfs_transaction_running(inode->i_sb))
 		th = current->journal_info;
@@ -3316,7 +3306,11 @@ int reiserfs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 
 		/* fill in hole pointers in the expanding truncate case. */
 		if (attr->ia_size > inode->i_size) {
-			error = generic_cont_expand_simple(inode, attr->ia_size);
+			loff_t pos = attr->ia_size;
+
+			if ((pos & (inode->i_sb->s_blocksize - 1)) == 0)
+				pos++;
+			error = generic_cont_expand_simple(inode, pos);
 			if (REISERFS_I(inode)->i_prealloc_count > 0) {
 				int err;
 				struct reiserfs_transaction_handle th;
-- 
2.21.3

