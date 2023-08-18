Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3606E780C65
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 15:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377110AbjHRNSm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 09:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377048AbjHRNSL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 09:18:11 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323EA26A5;
        Fri, 18 Aug 2023 06:18:10 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68874269df4so742728b3a.2;
        Fri, 18 Aug 2023 06:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692364689; x=1692969489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzzMWGzNSLRyaBcN3mZ9k3m0heMsfpzA3+qcnBXsGqU=;
        b=YLoH3BK/waIQP1nP5jtKqbnW1GxErxLDqGmPHjYocbmIOBV1zJfjAqelJbf9jJ35Jd
         WAHDyUocGplRyyIBxvo2OS8n27JbdFXfCE6TwcMw32KXBQwKoa3uo2YFbYQdlJhNNUy3
         Gmv9S58jhba2U5QInoHSVIytkHKDfkiR/DNFqHZE4ZdQPDMxT6B6YDOAmGQrsTVUq7Ti
         XC+JfkXBMOMTm6HdQFB0FjnmK+ofs2Pe6eFLM7IlJCAPcTLEXGSZPrjsC6y4fw0skPA/
         +Mdf/PhNcuar6Kf3y/j5OjjYFNE1iHBVIEqB+8EIJFMc9LFAVIIrjSs9hoCny5Ojxmo9
         RZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692364689; x=1692969489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qzzMWGzNSLRyaBcN3mZ9k3m0heMsfpzA3+qcnBXsGqU=;
        b=aIA9K1mVYeDJfSvwjn7YG6g5U7gmHwzQzmuZkJGtU3ml7GwEfUbmJHNCm2sxilxGNa
         AJsIBlbrapxoCwKOOcGPDEWxj//7whDR96KxNlUKYrZdl3hYpZknvm/6+6VKTulD2JHp
         Xulgz/0bnQ/3Y/2r1JjHQXSQ4NnboKYvyzg1zTSgKDKmKunf0/hm6LDh101dGp5S08AV
         9Q+XAQ5xMLNVSnu51cGUG7wFWIi+l3egqGBFpEAouFzKG/pqyQu3viWh8rGFVYH6t7Rj
         ZkgIQKyHujiqGykHZoRrII7Jhzqrbq79rqRIrfmhtpP4XQW6IvHvxqqVNgeUTRyoK3bZ
         n8fA==
X-Gm-Message-State: AOJu0Yz1/VDw5zXd9jPBgmowtr4tTr383wI8RqKk4DPO2G47SbGxD3D2
        dvJDRZTrQe/IFrnFU2C9e7ONR0mJTJo=
X-Google-Smtp-Source: AGHT+IEV0w3BbGspE0QedPMefSDcnjuA+y9d7ljuNWKsjoi6J63c/V3Lcgm0CppbN/WpCKfmlvfv9A==
X-Received: by 2002:a05:6a00:99e:b0:687:20d6:fae5 with SMTP id u30-20020a056a00099e00b0068720d6fae5mr2871180pfg.24.1692364689524;
        Fri, 18 Aug 2023 06:18:09 -0700 (PDT)
Received: from carrot.. (i118-20-76-4.s41.a014.ap.plala.or.jp. [118.20.76.4])
        by smtp.gmail.com with ESMTPSA id x9-20020aa793a9000000b0068895adfdffsm1572063pff.143.2023.08.18.06.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 06:18:08 -0700 (PDT)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs@vger.kernel.org,
        syzbot <syzbot+cdfcae656bac88ba0e2d@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] nilfs2: fix WARNING in mark_buffer_dirty due to discarded buffer reuse
Date:   Fri, 18 Aug 2023 22:18:04 +0900
Message-Id: <20230818131804.7758-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0000000000003da75f05fdeffd12@google.com>
References: <0000000000003da75f05fdeffd12@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A syzbot stress test using a corrupted disk image reported that
mark_buffer_dirty() called from __nilfs_mark_inode_dirty() or
nilfs_palloc_commit_alloc_entry() may output a kernel warning, and can
panic if the kernel is booted with panic_on_warn.

This is because nilfs2 keeps buffer pointers in local structures for some
metadata and reuses them, but such buffers may be forcibly discarded by
nilfs_clear_dirty_page() in some critical situations.

This issue is reported to appear after commit 28a65b49eb53 ("nilfs2: do
not write dirty data after degenerating to read-only"), but the issue has
potentially existed before.

Fix this issue by checking the uptodate flag when attempting to reuse
an internally held buffer, and reloading the metadata instead of reusing
the buffer if the flag was lost.

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: syzbot+cdfcae656bac88ba0e2d@syzkaller.appspotmail.com
Closes: https://lkml.kernel.org/r/0000000000003da75f05fdeffd12@google.com
Fixes: 8c26c4e2694a ("nilfs2: fix issue with flush kernel thread after remount in RO mode because of driver's internal error or metadata corruption")
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: <stable@vger.kernel.org> # 3.10+
---
 fs/nilfs2/alloc.c | 3 ++-
 fs/nilfs2/inode.c | 7 +++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/nilfs2/alloc.c b/fs/nilfs2/alloc.c
index 6ce8617b562d..7342de296ec3 100644
--- a/fs/nilfs2/alloc.c
+++ b/fs/nilfs2/alloc.c
@@ -205,7 +205,8 @@ static int nilfs_palloc_get_block(struct inode *inode, unsigned long blkoff,
 	int ret;
 
 	spin_lock(lock);
-	if (prev->bh && blkoff == prev->blkoff) {
+	if (prev->bh && blkoff == prev->blkoff &&
+	    likely(buffer_uptodate(prev->bh))) {
 		get_bh(prev->bh);
 		*bhp = prev->bh;
 		spin_unlock(lock);
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index 35bc79305318..acf7a266f72f 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -1025,7 +1025,7 @@ int nilfs_load_inode_block(struct inode *inode, struct buffer_head **pbh)
 	int err;
 
 	spin_lock(&nilfs->ns_inode_lock);
-	if (ii->i_bh == NULL) {
+	if (ii->i_bh == NULL || unlikely(!buffer_uptodate(ii->i_bh))) {
 		spin_unlock(&nilfs->ns_inode_lock);
 		err = nilfs_ifile_get_inode_block(ii->i_root->ifile,
 						  inode->i_ino, pbh);
@@ -1034,7 +1034,10 @@ int nilfs_load_inode_block(struct inode *inode, struct buffer_head **pbh)
 		spin_lock(&nilfs->ns_inode_lock);
 		if (ii->i_bh == NULL)
 			ii->i_bh = *pbh;
-		else {
+		else if (unlikely(!buffer_uptodate(ii->i_bh))) {
+			__brelse(ii->i_bh);
+			ii->i_bh = *pbh;
+		} else {
 			brelse(*pbh);
 			*pbh = ii->i_bh;
 		}
-- 
2.34.1

