Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC6753F5CF4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Aug 2021 13:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236550AbhHXLNp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Aug 2021 07:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236068AbhHXLNo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Aug 2021 07:13:44 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18FCC061757;
        Tue, 24 Aug 2021 04:13:00 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id h4so529166wro.7;
        Tue, 24 Aug 2021 04:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qDZfUArbodzeHWOl6Bya6lgiV/+V5CqHIHSjhK1z5X8=;
        b=aXKB0+CCppOl6lpuwF+svXZF7VUrIonGhpW1mMFol5aX5OTjiMrABgyCtWMwyjvFJd
         ZswLE3jfG/FkWedcykiRgfg/fODu3Ekwg258OKzB/v96tUyzhTMDex0Us2hd9DcpGIk5
         1FuTD2G8wozKsoZ8I8zkwq0AqbWz3r7OWsk6wLGAaB0tQmOwDmRSh2rdN13RAhN7sZqI
         mzSKTycmXtyahITBT0hIwDjp73Qe3Jmdrp9dIlFdn2q5syKvXq+HLDXDTHqdGKHG8cwd
         WEXyl5WFku5//HXPNMk5fEk2/b1LutUuvKUHLnVVv6Rg4+htk8MTYWYI+J/s5MKQc4AJ
         /IEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qDZfUArbodzeHWOl6Bya6lgiV/+V5CqHIHSjhK1z5X8=;
        b=ZHpOi0ymudCbbsMoisgnhwwtLL0eRlf7eNNWMj12xl/ADGqSOCT6yvc5cWbrh0mGyG
         UeP7ToVQbGa3A8nfTZd1CXRN7Xe7bqsUoKaJ49k6o4dG4XeGqD+gqWZKUKwuAZjTK3vw
         2+Wao9yt5DmUD8C4w2PWSHjWgCuWOWgowDbXQL9XfjHxmdjWBILQ1hKIbssbNsP+j3cn
         xTiYQskvxr807NwQkrozOX2Kuvp3GOwgzM+wRxb6eN8KbV0k33rRi7D1s7xeDezCn86M
         fVHvNgdhF3U655eBl8qGEGX6ZnEE7ZO4d1h9MyJVN9dJoyrlCJ2vnp8N+kgzF+vKL1v/
         kSPA==
X-Gm-Message-State: AOAM533Kl2pxhHRJovGHj3xr4dnZLg0MYRSuelhd3FRq8UlvXK9V85OL
        +X3XHvQ/Ih0BNCAO/k4YPfCTB5nUeZE=
X-Google-Smtp-Source: ABdhPJwy9DItNoTJrTVRYRN0NxBKv3BMNLiw+zQ/kayJXbZYU88H0ww2u3osa5ZQ5icQCAewrwUc3g==
X-Received: by 2002:a05:6000:92:: with SMTP id m18mr12320749wrx.293.1629803579325;
        Tue, 24 Aug 2021 04:12:59 -0700 (PDT)
Received: from localhost.localdomain (arl-84-90-178-246.netvisao.pt. [84.90.178.246])
        by smtp.gmail.com with ESMTPSA id t14sm6328727wrw.59.2021.08.24.04.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 04:12:58 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] fs: clean up after mandatory file locking support removal
Date:   Tue, 24 Aug 2021 13:12:59 +0200
Message-Id: <20210824111259.13077-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit 3efee0567b4a ("fs: remove mandatory file locking support") removes
some operations in functions rw_verify_area() and remap_verify_area().

As these functions are now simplified, do some syntactic clean-up as
follow-up to the removal as well, which was pointed out by compiler
warnings and static analysis.

No functional change.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Jeff, please pick this clean-up patch on top of the commit above.

 fs/read_write.c  | 10 +++-------
 fs/remap_range.c |  2 --
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index ffe821b8588e..af057c57bdc6 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -365,12 +365,8 @@ SYSCALL_DEFINE5(llseek, unsigned int, fd, unsigned long, offset_high,
 
 int rw_verify_area(int read_write, struct file *file, const loff_t *ppos, size_t count)
 {
-	struct inode *inode;
-	int retval = -EINVAL;
-
-	inode = file_inode(file);
 	if (unlikely((ssize_t) count < 0))
-		return retval;
+		return -EINVAL;
 
 	/*
 	 * ranged mandatory locking does not apply to streams - it makes sense
@@ -381,12 +377,12 @@ int rw_verify_area(int read_write, struct file *file, const loff_t *ppos, size_t
 
 		if (unlikely(pos < 0)) {
 			if (!unsigned_offsets(file))
-				return retval;
+				return -EINVAL;
 			if (count >= -pos) /* both values are in 0..LLONG_MAX */
 				return -EOVERFLOW;
 		} else if (unlikely((loff_t) (pos + count) < 0)) {
 			if (!unsigned_offsets(file))
-				return retval;
+				return -EINVAL;
 		}
 	}
 
diff --git a/fs/remap_range.c b/fs/remap_range.c
index ec6d26c526b3..6d4a9beaa097 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -99,8 +99,6 @@ static int generic_remap_checks(struct file *file_in, loff_t pos_in,
 static int remap_verify_area(struct file *file, loff_t pos, loff_t len,
 			     bool write)
 {
-	struct inode *inode = file_inode(file);
-
 	if (unlikely(pos < 0 || len < 0))
 		return -EINVAL;
 
-- 
2.26.2

