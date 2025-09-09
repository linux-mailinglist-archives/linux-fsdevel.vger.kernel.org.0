Return-Path: <linux-fsdevel+bounces-60624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5FFB4A534
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 10:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7280C188C8F5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 08:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8BB246327;
	Tue,  9 Sep 2025 08:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Awuf4czK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EB919A288;
	Tue,  9 Sep 2025 08:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757406384; cv=none; b=soEw/UU47Hki8DEXJXHP8m/++LpmO3y5WO7pZ8cfVYHULcoEZ4R/J6KYb73sBcKh2PoR2nSfivTArDqzAxvKV1HBtcZX004rXpErjIIPabgHGCwysvRVjgyqL5ON6EkXjO5xllVE/Q1oW09cczW+qg935EiI2kIeXkCvpHUWnwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757406384; c=relaxed/simple;
	bh=+9fKZfqZlLuFyx4VN6ubnXS9dr52HtsJyQCsiLgHoEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jc0zuij38Zh3vRZ2TRR6CKFbnWGcYFKqYp0y507tor0ALR8m1HciNPRXOcvek88u+WYLH28a2WLE4MQTc6WZEDpn/UzlmxtddFpDmkef2E5pruu/1vk7CVdcMFIaqaTQ+vhH6sCZ4zlgU8GbKVr2kyz7b+4upZf2E5MUMMqB9QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Awuf4czK; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45dec601cd3so7843245e9.2;
        Tue, 09 Sep 2025 01:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757406380; x=1758011180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cpT6i930F2C9n57UA/7/DmYKv7ZcjJclQ2FIk4XMjYM=;
        b=Awuf4czKWkHf8NikB947gz72QJkZkBV2ja4lIWVPGg74A/aQ1YpuLDn3gZT9bz7F5y
         /jIaa5ON+CkheqXt1ymRboUsf7309cVnDVzHk36UFO7nINuuzkD7aZebd/ZI38Zd0LRB
         M+sGsv13XcXs/TDVMUK/t1FIuiw1w+3uO1pt3HQ/o4XO3+uJVMkaZMEeoKP9tcFjTF/2
         FJlmwFpCLklXAEPuu+5oV+rLzPZgWJB1aNu8s3lnxYfjQDs/4tLgbY14yrGgNGJHaDXl
         +gcoDXNfuNI/7JpMy2tf9xL/lJqSpDkDPoSC6H7cxZKR0hZ2qpY7twQVnyK/3nrUpi5T
         RqLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757406380; x=1758011180;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cpT6i930F2C9n57UA/7/DmYKv7ZcjJclQ2FIk4XMjYM=;
        b=YYJ/EzQIYZJt+Z7kBMQpnePNFY9vlPkIk+s2UheVFar1crQGE+dOeINx7GGvl034t+
         qM/Qi77KyUnYeWyaRv0sjUToxaG0+6oVJrdtwbHpUgVBOkXanfj7zGesiHrqyMGjr8oq
         vrQXdnPOaLSG/z0DWezVwSx/LBZKuSXnt3iUNhmMMIQXOhxKdg+6YqmM2PuMr68X4z/h
         TrTVcOcdeNBJWWP3rg/qGqUjbg6bXHL482d63tWa5ORRlVMHWPcYJ54Cx4yfyYQfiK+w
         8jcZeCYE7jVE0vSlgt5fnI+uDcRTTM7whkJmQGddndGpFSX/1ZEfYsA/0Ey7y1crQuO/
         XWuw==
X-Forwarded-Encrypted: i=1; AJvYcCU+wxDfwM/tXULerDBYG4hiqpE/hFMFfQYrN0duMdlzD3jABvWCax+HwD8EnaZfmaRZ+b2YTQhOGsKepWn4@vger.kernel.org, AJvYcCWII/5/EznP4Pev5g7Bd5EciSIm4hbbV487q5bf8WauSTfqnrURxkmp6stq5Bxo6zmGOnTwIgeFpkl7GtpX@vger.kernel.org
X-Gm-Message-State: AOJu0YygYUMznQueM9f1yreTE88C2C39ttO+jtbYpoES6AzNd/40Pzmg
	eV9OC5rnNRKheyYxU6g0bLYhVI5hStQHeUH1f7LKzjbo1oXjX1NDW7Iv
X-Gm-Gg: ASbGncsBkFXlA7m3+HiZjQQxbIWU3CJQgw3DTTckjloeHeinplXGLf/kjVu0Qvl8c2K
	ZoA6zcVMSqvi1DMHVwz7el7lvaCFO5ieJFp4kVYSHVb0PwxDxnXkJ8/rOaDuk3EhlQagnHjN5Us
	oS+KkQB2AX+kMi9VjFCu26ErAv4Qkau4Odg/xZU/ZidBuzyTBgepvLPcTpk7gEt3oftXL55Na8+
	opMJi80wLP3LSHr1mk7IUhD0KAaVnJERyA9lwnpNmAzX/2A4eVZssSRKJEvjqu9ncFUb9W11e4l
	NXe9kFHum7AQQbNaWAlUtJ2ThCau44lQYzHl5UxcgY6wqVEOX2rQXkYDlVdCNqv/90E07R6cLty
	iD+AjIrJYv3ueJskgEt+6bGdCD7RaLQ9Y+iJf5AOkhb2KIqne720=
X-Google-Smtp-Source: AGHT+IGoP7Fo0oYbGvNx/zC+T7kzrMPShf39+63laEJD6Zm/K9+E4O0HsjRdqeKXHE9ot6K+6Joi2w==
X-Received: by 2002:a05:600c:3596:b0:45c:b5ff:8252 with SMTP id 5b1f17b1804b1-45dddef758fmr97595645e9.25.1757406380160;
        Tue, 09 Sep 2025 01:26:20 -0700 (PDT)
Received: from f.. (cst-prg-84-152.cust.vodafone.cz. [46.135.84.152])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd296ed51sm224573155e9.3.2025.09.09.01.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 01:26:19 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] fs: expand dump_inode()
Date: Tue,  9 Sep 2025 10:26:13 +0200
Message-ID: <20250909082613.1296550-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds fs name and few fields from struct inode: i_mode, i_opflags,
i_flags and i_state.

All values printed raw, no attempt to pretty-print anything.

Compile tested on for i386 and runtime tested on amd64.

Sample output:
[   31.450263] VFS_WARN_ON_INODE("crap") encountered for inode ffff9b10837a3240
               fs sockfs mode 140777 opflags c flags 0 state 100

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

This is generated against master.

Depending on where this lands you might get a trivial merge conflict as
it gets rid of the whitespace issue also fixed in https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=vfs-6.18.inode.refcount.preliminaries&id=90ccf10de527c0c9b117beddd09ee7ac38efaa5b

 fs/inode.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index 01ebdc40021e..fe7591186b6e 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2911,10 +2911,18 @@ EXPORT_SYMBOL(mode_strip_sgid);
  *
  * TODO: add a proper inode dumping routine, this is a stub to get debug off the
  * ground.
+ *
+ * TODO: handle getting to fs type with get_kernel_nofault().
+ * See dump_mapping() above.
  */
 void dump_inode(struct inode *inode, const char *reason)
 {
-       pr_warn("%s encountered for inode %px", reason, inode);
+	struct super_block *sb = inode->i_sb;
+
+	pr_warn("%s encountered for inode %px\n"
+		"fs %s mode %ho opflags %hx flags %u state %x\n",
+		reason, inode, sb->s_type->name, inode->i_mode, inode->i_opflags,
+		inode->i_flags, inode->i_state);
 }
 
 EXPORT_SYMBOL(dump_inode);
-- 
2.43.0


