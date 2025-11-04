Return-Path: <linux-fsdevel+bounces-66953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C794C31119
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 13:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 242414F3AB8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 12:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137DB2EC0A2;
	Tue,  4 Nov 2025 12:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gzrcw1E7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF8920C461
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 12:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762260675; cv=none; b=cvh1r6pggnQQZnDRoBiYbnL8mQj/1VurXZhCC4m9LDKhFthsOLklno9Wj1/1ESpcMqy30L340G8X6b955A/JSw/PdgVHq1HHwzshfKHCJR0RCN2FbgScjqigea7qk6ej4dBohglMu90bq0R2Lmelh2QLhjggQOGfsHbaak0diYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762260675; c=relaxed/simple;
	bh=s3yhfECKQACggkqiSvS6yFm+dl+Idqcymxv/EyA77Zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uCwJ+tmFUtH/5+xOdO1TRZtiJZqoCS3QlOCYi7fcw146MU+gEch31So3cIxBQ7CuZXt5T0Jk5sPHfEuD2oIr68lK2Vce9iwK4VQ9SlomuxUHMhAhJRBHTJoo/3RPfEqyUypr5US77yA7DV+0XPcLU7Vh8RaLryub/Umn2pVAeBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gzrcw1E7; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-78125ed4052so7268690b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Nov 2025 04:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762260673; x=1762865473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WH7uti94Ifpss7uaEo1ftZ9XWOLDmVeeF5wLRCtaeDE=;
        b=Gzrcw1E7d5y2aoJUnTcshd60F4LWfOQ63t/EsqrvDyfK2Ewh8Wf8pjc/kpCJfHIpwf
         /Rz89C9Ym9ixt/lO8+h3JC04JG7VOy+EaEpt4t0LfphzoJgeFhPgmjXagu6fmSibZKDW
         t4dVVY1MLBP3ao8Er9udkSX66StWVpJBOIH/r2s/sy5JNWw22RFlsVgapeaWWoWIMnP7
         g9hzuMDLaB/DX/l8uJa0S5U1l70CIAEx5DMEAD98CiEmdlDeHn0okSeFIi4NhZgfBrQ9
         ie21cqAQBHOF5XxjXZDJIKqauKNVWYHN3BIBpbIwYcRVneanBSJPbQcojXrQGnaJBd0p
         LqJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762260673; x=1762865473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WH7uti94Ifpss7uaEo1ftZ9XWOLDmVeeF5wLRCtaeDE=;
        b=X/fogUiNd3jiC4jBXDAepCZSiKNFOQqXGPT7ZiC+tHuG+ZsTBzaV/aLoCjZbk9Gt5A
         1hPVJkl1e5ivERCGyVwG3Dg8NBbDeBzeg/UvRcSsRCgEAtXSzKPkFED6BRlp1E5KFz8E
         mwLEkAytKWG5/oLteRhtXhFYK/RG4Mzyt98ugH+mH9s4kxAU84L/gKaUUYhXwHgl1nm+
         n2KBMENqdc3PGe8SXCnD40ipFQ86wRT1OT17LKPF7d0V9pLP8G3Cnw5qogpPwR/CeFGV
         cxV3doK++OpGr5nQs/M+lPR2U9KDPJ2QfjlnSAnntKc06iLezMGvO3cu9Pn0cgUMXbCJ
         N11w==
X-Forwarded-Encrypted: i=1; AJvYcCVCs39URbXvjllbUWrkaHDTdH9ViTd3hLtiRC//D5mM5vo6RYuhRBeAGA3llTLJVGGQn4n1RCN4C0luX/Xv@vger.kernel.org
X-Gm-Message-State: AOJu0YzwwvYMeG8klDRNw1vAAlBM3+EgXXaGOoFBa18V1q4Asy/8wMoP
	nDrdcAj/lu/rSueizndmaSFGUCpAbZH2S2d8AXYJxXPRulILJOpmfpXz
X-Gm-Gg: ASbGnctxVIKfZGrx1s+/HpV58og+7BuhA36oa56SFkGxWUzEr5iFpa0itOksYaby2dp
	LvscnO/5p02JuR2UXlS0uMzaawqYNtYFK5HqH6Q1V0S/M2tHaQAZstB187rFCa2JJcXKA2okgzK
	8NS5elExxDhIsqeJDnctV4yB19IGYKHaK/rELmm9d5h555Joy8GnNHIEOnRO85Pj5vEsS8bggPe
	2oIA3KEW4FsTDv8c6J2mVEomk5eCbrdx8f9eNTn5aD5pBeoxJUyPzAs0CGFlvh8Gm5WKBmJUBZu
	vdUvpE06Tw2AIWF8q/sajGKgvUytn+5SESBihv/km6FdmcCo7gZFW8fMnmJk/FsTpdqSX30ZmPV
	eNL4PoGWuxkd7JGvrSqWCoDPgHI/+tx8LGbclL/kkiUhR+A8eEuCLVMG24XOJa5k9/cfuaXIgY2
	0dxPulNoEXqC7/8zGUBQiaD76y6etzUcsjeRmSotdlz1M34NI=
X-Google-Smtp-Source: AGHT+IFyV0Z4aoh1hb5I/IbU1UarLZfuiNquenj/qB2Rx0uGFDeOr6CMSuEHHdT/4+TY88jlIMdvbA==
X-Received: by 2002:a05:6a21:8981:b0:34f:1c92:762 with SMTP id adf61e73a8af0-34f1c92f840mr640906637.19.1762260673189;
        Tue, 04 Nov 2025 04:51:13 -0800 (PST)
Received: from xiaomi-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd6d026dcsm2860710b3a.70.2025.11.04.04.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 04:51:13 -0800 (PST)
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Jan Kara <jack@suse.cz>,
	Carlos Maiolino <cem@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	stable@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Yongpeng Yang <yangyongpeng@xiaomi.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v6 5/5] block: add __must_check attribute to sb_min_blocksize()
Date: Tue,  4 Nov 2025 20:50:10 +0800
Message-ID: <20251104125009.2111925-6-yangyongpeng.storage@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251104125009.2111925-2-yangyongpeng.storage@gmail.com>
References: <20251104125009.2111925-2-yangyongpeng.storage@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

When sb_min_blocksize() returns 0 and the return value is not checked,
it may lead to a situation where sb->s_blocksize is 0 when
accessing the filesystem super block. After commit a64e5a596067bd
("bdev: add back PAGE_SIZE block size validation for
sb_set_blocksize()"), this becomes more likely to happen when the
block device’s logical_block_size is larger than PAGE_SIZE and the
filesystem is unformatted. Add the __must_check attribute to ensure
callers always check the return value.

Cc: <stable@vger.kernel.org> # v6.15
Suggested-by: Matthew Wilcox <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
 block/bdev.c       | 2 +-
 include/linux/fs.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 810707cca970..638f0cd458ae 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -231,7 +231,7 @@ int sb_set_blocksize(struct super_block *sb, int size)
 
 EXPORT_SYMBOL(sb_set_blocksize);
 
-int sb_min_blocksize(struct super_block *sb, int size)
+int __must_check sb_min_blocksize(struct super_block *sb, int size)
 {
 	int minsize = bdev_logical_block_size(sb->s_bdev);
 	if (size < minsize)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c895146c1444..3ea98c6cce81 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3423,8 +3423,8 @@ static inline void remove_inode_hash(struct inode *inode)
 extern void inode_sb_list_add(struct inode *inode);
 extern void inode_add_lru(struct inode *inode);
 
-extern int sb_set_blocksize(struct super_block *, int);
-extern int sb_min_blocksize(struct super_block *, int);
+int sb_set_blocksize(struct super_block *sb, int size);
+int __must_check sb_min_blocksize(struct super_block *sb, int size);
 
 int generic_file_mmap(struct file *, struct vm_area_struct *);
 int generic_file_mmap_prepare(struct vm_area_desc *desc);
-- 
2.43.0


