Return-Path: <linux-fsdevel+bounces-28714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F139A96D60C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 12:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D3B3B211F1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 10:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6537198E81;
	Thu,  5 Sep 2024 10:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JtvbZT78"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C64198833
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Sep 2024 10:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725532025; cv=none; b=Y5kZNOU3WpaSpS/W5gTOjS0vTJlEYm8RV2YkwiY1omnjyqkS865C4HHUi2Q0IlDncd/DEUlBAieHCsFgzLYkjidEGfCn96nET2RSBOBGY5iY7vuOr2Ug4OHyl+k0uj3m9XFadb1vbhDdKcmJvXYqiTT8ijCTk6r2zjRdyVAeM9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725532025; c=relaxed/simple;
	bh=WZzT5BpQnU/IDkY5TbnvVbnpeSboG8Cas3ZVjda00B4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pvCf2C/aCpA24lYBSO0t9EtgIPv1KoTOF3FV2e2dOxBtol4ZrRk1fK+3OHk6+RV9fUjtT+0BhPDrVva41XhW5WdeBcnWYH9/18nLoCcJTUpIp7dfvA2fWr6xUsi7jpVRF5gCIMV9YrNSpZ6to0YlLuDKQnOoH4f0a2Icg513M+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JtvbZT78; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7c6aee8e8daso494138a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Sep 2024 03:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725532022; x=1726136822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gQLkYz851xV52gzNbD07f6SnIzvOfxOgXnNEUY/1Rw4=;
        b=JtvbZT78oCypxk8PtzWglUjUInChBdz/Uh4zhYCw72aVZ3j9ofgBq5+OjNiFYVAmQo
         9349ueD+itpsAcDDsUyJxkIviI52t1wHOM9RXpSebuEmlFOe9i8ne3nq8f0d7o+8HNKL
         bBorHkTq9c2hMQFWDeTgPqDdIgBubPwOj6yWKamR5w25HtrAA+aXAKJB5oDYIPQJXJq2
         mH6spnU8oDoaThrc8Z8zFfGuu4zTNI2YmXm7UkRW84AXMHfh5zN06PYRUs3vtBfKzArh
         RB3aotBz3uAhhENbfUuF0ECjC5zYmRwF8udSk1yS7Ut/lq9KBkPCUQ+ORAueIh+lUg+C
         E2Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725532022; x=1726136822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gQLkYz851xV52gzNbD07f6SnIzvOfxOgXnNEUY/1Rw4=;
        b=JTqYj/vtrTWR/JFfljCWJtxtPbI+5Nra0xfOsMb4LDgoYCMzCAXMgZdj8p6mEf71Ig
         fohQL/r6J+BZviqgB4gJeCjsLnyOag0Wf8GJHCFqoAb6qs6E3kkDT0EGsqShaaihDg+Y
         S5kX+YzjgdO7U08rLaS1kuhE3PzypuLjIl6IdkjRDo2rhNLNGTfzWmm/m70xR3NVEGBr
         CLjfFqLwyYORrV275NyJGtx88EOMc7SG0bXhf2cB8JFVmNABGXvKZldIkFiyy/ZSJthT
         z6flOt9fhwYikEM1a6yyvaCW9awGfPfMEyo89gj9dt8NRFnjeqsum1A9Uz8lxxFbRulw
         8TBA==
X-Gm-Message-State: AOJu0YypiyHSfHJ2DwE2pUxb2DO7PFup/yRZDaIg38AA1kHbJ5uCd7mX
	clrp8GwcHXyBp3xpmiDLIPdhQLV6RvgSuiYuVkuCSRUEB37TbsaAAUdbSOSVTK0=
X-Google-Smtp-Source: AGHT+IEb2GyXWVt7vLLMhYWz5CUtpIDYWMUQt3IJvnl5f0aJxGTI6Yi1g6h9vXA52zG4PLsgoZ4zFg==
X-Received: by 2002:a05:6a20:b305:b0:1cc:9f24:42 with SMTP id adf61e73a8af0-1cecdf0fb63mr16659713637.20.1725532022226;
        Thu, 05 Sep 2024 03:27:02 -0700 (PDT)
Received: from localhost ([123.113.110.156])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2da7532583bsm4650438a91.8.2024.09.05.03.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 03:27:01 -0700 (PDT)
From: Julian Sun <sunjunchao2870@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: jack@suse.cz,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	djwong@kernel.org,
	david@fromorbit.com,
	hch@lst.de,
	Julian Sun <sunjunchao2870@gmail.com>,
	syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com
Subject: [PATCH 2/2] vfs: Fix implicit conversion problem when testing overflow case
Date: Thu,  5 Sep 2024 18:26:56 +0800
Message-Id: <20240905102656.1107446-1-sunjunchao2870@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The overflow check in generic_copy_file_checks() and generic_remap_checks()
is now broken because the result of the addition is implicitly converted to
an unsigned type, which disrupts the comparison with signed numbers.
This caused the kernel to not return EOVERFLOW in copy_file_range()
call with len is set to 0xffffffffa003e45bul.

Use the check_add_overflow() macro to fix this issue.

Reported-and-tested-by: syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=296b1c84b9cbf306e5a0
Fixes: 1383a7ed6749 ("vfs: check file ranges before cloning files")
Fixes: 96e6e8f4a68d ("vfs: add missing checks to copy_file_range")
Inspired-by: Dave Chinner <david@fromorbit.com>
Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
---
 fs/read_write.c  | 5 +++--
 fs/remap_range.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 90e283b31ca1..349e4df5e0b0 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1416,7 +1416,7 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
 	struct inode *inode_in = file_inode(file_in);
 	struct inode *inode_out = file_inode(file_out);
 	uint64_t count = *req_count;
-	loff_t size_in;
+	loff_t size_in, tmp;
 	int ret;
 
 	ret = generic_file_rw_checks(file_in, file_out);
@@ -1451,7 +1451,8 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
 		return -ETXTBSY;
 
 	/* Ensure offsets don't wrap. */
-	if (pos_in + count < pos_in || pos_out + count < pos_out)
+	if (check_add_overflow(pos_in, count, &tmp) ||
+	    check_add_overflow(pos_out, count, &tmp))
 		return -EOVERFLOW;
 
 	/* Shorten the copy to EOF */
diff --git a/fs/remap_range.c b/fs/remap_range.c
index 28246dfc8485..6fdeb3c8cb70 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -36,7 +36,7 @@ static int generic_remap_checks(struct file *file_in, loff_t pos_in,
 	struct inode *inode_out = file_out->f_mapping->host;
 	uint64_t count = *req_count;
 	uint64_t bcount;
-	loff_t size_in, size_out;
+	loff_t size_in, size_out, tmp;
 	loff_t bs = inode_out->i_sb->s_blocksize;
 	int ret;
 
@@ -45,7 +45,8 @@ static int generic_remap_checks(struct file *file_in, loff_t pos_in,
 		return -EINVAL;
 
 	/* Ensure offsets don't wrap. */
-	if (pos_in + count < pos_in || pos_out + count < pos_out)
+	if (check_add_overflow(pos_in, count, &tmp) ||
+	    check_add_overflow(pos_out, count, &tmp))
 		return -EINVAL;
 
 	size_in = i_size_read(inode_in);
-- 
2.39.2


