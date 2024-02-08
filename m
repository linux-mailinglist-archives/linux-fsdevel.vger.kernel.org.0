Return-Path: <linux-fsdevel+bounces-10706-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9770A84D7C0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 03:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83BB11C221AA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 02:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D6C200BA;
	Thu,  8 Feb 2024 02:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gw3N8FAu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9CB1EB46
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Feb 2024 02:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707358903; cv=none; b=uVL3MrLyAenu/7smipzI+GyPNfAiH+X17Qtv63D+MZoijxvpQPde6vbTC5zdOXOF7mfbO4tKwgx+i4aTUZRTVaJ5PjslaFs8DRvYNj5Qp3OgLlY2Id4ZYKZbS6k5ZGVWRa65gqvlHkEyrk+1gEngDXtzsmMBMqr95ZXLX17rX+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707358903; c=relaxed/simple;
	bh=S7Fyth2o7C0oeXrP7QWtpfU2zEaeDUSuyoZcs6zwH3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fIbsWaAgf/X+p/qyW/bxAK/4ezDTRUGtWPflQpjxtEbheH4RVH1i6H1/WZ8MuMuqXLQP4hDPdols5sZ6nKHI/fKI51eARQmKbqoE9bEqGT3YQ230Xj/aX461tf/yXpCjc3WW+2UaUSEYsOLEi+DfmDRjKUneLoZxWxbF3/Y3Uio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gw3N8FAu; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5d4d15ec7c5so1027962a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Feb 2024 18:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707358901; x=1707963701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OcrpujjG4PsCPev9+m1Qsti6EPTjolmttW9lJssf8t4=;
        b=gw3N8FAu9tCkAGjNhNd9gHTZNT08ca/dw2te3FR1FGnXI5EsqsRtn5aAZJTpguyU71
         D5lHJmClJHXpkqhTb/jDIbeHRge0fXDKbxM5u9QDy5EgCka07euPXTe8zjco041Agjbs
         HdIwPGd7AhhWus8E9kXNhYWkZCHUmHL5jI693xnS4etGUGOQ76ZmO4ZKC7BRZz6ZRBAl
         X4JRTCJ5ymNJ4JHgREBxL1KgHF9XSG/h/o2HsHiyO99mUbQrvacf/UOzn27QJRMA45wL
         AGEwTGp/a8K0cQaGzWRJpro5LrvyEAQC+vCh+3MTaiEvkUMS1VimmqOgKEHSXNsAXykh
         7ayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707358901; x=1707963701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OcrpujjG4PsCPev9+m1Qsti6EPTjolmttW9lJssf8t4=;
        b=p0MZh19kzAs0ktKgkFTqaz8yXGlDGswNOCf8SxF/QSs44ghph5N5tdJGqlKnzft8uu
         AxVgGzcj1pyaERWkpsKERY4vMmr57EsJb7Y+eDOKrz/pwAqID/BSdW6w3M22yR6U8V4y
         PnlbOSAQdvpYMUbwTFfJTgF1gqM0RsYCc2CVkQhzixMDUxVn5rjN/Ln7fLt22pXSne7B
         6XYuQu4ERBJx1SuJDyRiQI+1ByVTWE62kHj6swTI2+OFlG8GUKX1mlM+WFEKI43sETLC
         S39OK1Lo9D7+i2m32QemMG14POAIqSsVnOYEfYGziCj2jC89nWpXZPSQ+KvhW2tkhZZW
         0fvw==
X-Gm-Message-State: AOJu0YwXNac4yhZhbPo5vwCoDEbEgIl0BZvsv+qY6OXnatWEDYYb7tnc
	rx64uiGAf/OLrwuMxudBsS/ORCU7Oz6SJRo1inmVlL6lwPAMO7HdcUtZp3jD
X-Google-Smtp-Source: AGHT+IG77yBwbvX6TZ07fxx954Kl0xconK69f1HIPUW2vgAdRQWz/9jDsxC1xFZ84KKz3h/NODcHyw==
X-Received: by 2002:a17:90a:fd0e:b0:296:5941:d25d with SMTP id cv14-20020a17090afd0e00b002965941d25dmr4041994pjb.49.1707358901432;
        Wed, 07 Feb 2024 18:21:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUgYcsyKVKI9m7HlDfzGndyefC10AjFAWiu9xRz9/uC52rjpmWsGLx/0xrzYZIYfwmQVi+zjF707Mskg9zhMmVWkYYR4FzJIxA1ZW8LErhp3j7vc+jNpsvg
Received: from petra.lan ([2607:fa18:9ffd:1:3fa5:2e62:9e44:c48d])
        by smtp.gmail.com with ESMTPSA id li16-20020a17090b48d000b00296fac6f7b6sm64007pjb.47.2024.02.07.18.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 18:21:41 -0800 (PST)
From: Alex Henrie <alexhenrie24@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	linux@rainbow-software.org
Cc: Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] isofs: handle CDs with bad root inode but good Joliet root directory
Date: Wed,  7 Feb 2024 19:21:32 -0700
Message-ID: <20240208022134.451490-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I have a CD copy of the original Tom Clancy's Ghost Recon game from
2001. The disc mounts without error on Windows, but on Linux mounting
fails with the message "isofs_fill_super: get root inode failed". The
error originates in isofs_read_inode, which returns -EIO because de_len
is 0. The superblock on this disc appears to be intentionally corrupt as
a form of copy protection.

When the root inode is unusable, instead of giving up immediately, try
to continue with the Joliet file table. This fixes the Ghost Recon CD
and probably other copy-protected CDs too.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 fs/isofs/inode.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index 3e4d53e26f94..86a767fa1e16 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -908,8 +908,22 @@ static int isofs_fill_super(struct super_block *s, void *data, int silent)
 	 * we then decide whether to use the Joliet descriptor.
 	 */
 	inode = isofs_iget(s, sbi->s_firstdatazone, 0);
-	if (IS_ERR(inode))
-		goto out_no_root;
+
+	/*
+	 * Fix for broken CDs with a corrupt root inode but a correct Joliet
+	 * root directory.
+	 */
+	if (IS_ERR(inode)) {
+		if (joliet_level) {
+			printk(KERN_NOTICE
+				"ISOFS: root inode is unusable. "
+				"Disabling Rock Ridge and switching to Joliet.");
+			sbi->s_rock = 0;
+			inode = NULL;
+		} else {
+			goto out_no_root;
+		}
+	}
 
 	/*
 	 * Fix for broken CDs with Rock Ridge and empty ISO root directory but
@@ -939,7 +953,8 @@ static int isofs_fill_super(struct super_block *s, void *data, int silent)
 			sbi->s_firstdatazone = first_data_zone;
 			printk(KERN_DEBUG
 				"ISOFS: changing to secondary root\n");
-			iput(inode);
+			if (inode != NULL)
+				iput(inode);
 			inode = isofs_iget(s, sbi->s_firstdatazone, 0);
 			if (IS_ERR(inode))
 				goto out_no_root;
-- 
2.43.0


