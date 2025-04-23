Return-Path: <linux-fsdevel+bounces-47250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE32CA9AFDA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 15:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0F409A7BC1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 13:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7D227EC89;
	Thu, 24 Apr 2025 13:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zum0nVly"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B3A19E7F9
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 13:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745502678; cv=none; b=sfG2Qa/1STP9FyJxFVfQ2N+Sw5hEmloevNzDllb8fT9CXvjsA1q6/E3Iy70X9f2Omp7616nAlVdRVIwxtdMvOjW6TXkg9HuGBPvWZ17GBl/iCOCI+fz/NUfziTy+1l6rlxb7Fa0Pgg4VscuCsCdJgPF9bk86ZZeG03M75R62ZME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745502678; c=relaxed/simple;
	bh=acIfMihEmnuSi4247hYoG+etgLusLUGQMgaInD/nRcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pgekIn4qMWRHkfHL70N7T3LcMzcuzBWCxqCHU3fd84BNYDDn4XZ+2lKSp2jXjVRAnl6Gko3r8Asp0CZv+5cqOl7/76YHr130B3/mJyZ+Qq7Zo4X5AZEHI6+bwrclnOKuNewXVzT/ZGOcXqueBMzTpTgeGkTTrfg/RHlYYpbtpPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zum0nVly; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745502675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=udKMH1CU1t2Ev+wjCTCy32K3ZTMMah0I4lS2t0dApE0=;
	b=Zum0nVlyWHySEXfjfyqKo39Uwi47CM0PA7qaSEsF4NKO6uDB8ZCtLymBv2lFYqa51rsc+W
	rbjjEr5BI2CxOKP1CfyIm6DKCToL33qaZwiUg3IauSuJpIdN8Wfv71m78Km/LmM+Bbl+FP
	gWUTgEFduv5ejtnArPPS28XCyd++mGg=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-xkKiJ7FYOOujVC1QaWpgdw-1; Thu, 24 Apr 2025 09:51:13 -0400
X-MC-Unique: xkKiJ7FYOOujVC1QaWpgdw-1
X-Mimecast-MFC-AGG-ID: xkKiJ7FYOOujVC1QaWpgdw_1745502672
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-72b862d2e23so600840a34.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 06:51:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745502672; x=1746107472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=udKMH1CU1t2Ev+wjCTCy32K3ZTMMah0I4lS2t0dApE0=;
        b=hnD96khCjkdtcU5kyC25w/uqZqm8FDbXZ69Lt43Bgp7ZBrPOsHX5ljrNBTJjMVLWtC
         hGxYK09kEEQEjgb0wrmMZlkytNr40VzvqvpYSx7K0NhuhmKrLqCxpCS9PeRqr2KUf4vr
         F6gliejvu904e2M67ayZyAVxefVbc1NTQCcWz3Bb92c5C4KZvI1QGzZCA9VRhim1VQgs
         pxnD0yOPXFD/777D1HvVIwtDajjBXcfZXh5HAOR+8fMft7BCURI9ef6kDCmn3hecs6IA
         ve1ue6OaL3ckye/dTg70FoQrfKOlo9iLdzmXIhcxmrCPbzXyVHrCW7Xj+oS062pO1ubL
         Xw/w==
X-Gm-Message-State: AOJu0YwkjGg8fFqGkAppg+1lxGXAKuVW6UelrrrX84vE/HJRfaexB2nb
	baC9Y0tfVK//HgyZWuxLaHge7TTFIZqXmPKFkpPGCX5oOFX+WuVu77t3WJg7xXZZcusd2nYdiQ5
	aBOB3HcgqM31PrdwP3xG1g4g9jbSO54f+Ywk/NkctRAb8mYPCTwVb0kF1XX9tjhk=
X-Gm-Gg: ASbGncuLP7zTppKLlAolJMTheSfNoWeribZwkWB3AcZYCt+kvTi6s58xvdAoLNGQURh
	YUAgf5HdGMsmHyX4korWYrPf7B35WZO6uoMEaZQ1bGFo1Fj+wtUNyzBOR5RAjBMdzqhGl+7EnJL
	LQQBv+CSp0RN6HCJx6xUBqU0hKCk5cAAQ1LRyaC7DFkDjjzZKgsuZACHU7FR3t5c8Aoy6oTx0I2
	wNXrZxXqWcao0hp+eAxufIebmN/BdW5xY6ADzTrcK5pGjknz3vgMTK2yXE0soEYtH/0+AKQywMT
	/AGm0wWfcoElmlLH7Bf94xyiCVLLC1SKKEf4fGX/ME66+5o0g03LZLg=
X-Received: by 2002:a05:6830:699a:b0:727:876:c849 with SMTP id 46e09a7af769-7304dbb0a68mr1810755a34.27.1745502672312;
        Thu, 24 Apr 2025 06:51:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHytkAZ6rDjaVBYhWIVU1VT8tqkJSUb23Y4x3ScNmZVhWKTjLIRxd6fQ/FI9xJUcBHGkyC2OQ==
X-Received: by 2002:a05:6830:699a:b0:727:876:c849 with SMTP id 46e09a7af769-7304dbb0a68mr1810747a34.27.1745502672075;
        Thu, 24 Apr 2025 06:51:12 -0700 (PDT)
Received: from localhost.localdomain (nwtn-09-2828.dsl.iowatelecom.net. [67.224.43.12])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7304f37b158sm233595a34.49.2025.04.24.06.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 06:51:11 -0700 (PDT)
From: Eric Sandeen <sandeen@redhat.com>
To: linux-f2fs-devel@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org,
	jaegeuk@kernel.org,
	chao@kernel.org,
	lihongbo22@huawei.com,
	Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH V3 6/7] f2fs: introduce fs_context_operation structure
Date: Wed, 23 Apr 2025 12:08:50 -0500
Message-ID: <20250423170926.76007-7-sandeen@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423170926.76007-1-sandeen@redhat.com>
References: <20250423170926.76007-1-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hongbo Li <lihongbo22@huawei.com>

The handle_mount_opt() helper is used to parse mount parameters,
and so we can rename this function to f2fs_parse_param() and set
it as .param_param in fs_context_operations.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
[sandeen: forward port]
Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 fs/f2fs/super.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 149134775870..37497fd80bb9 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -707,7 +707,7 @@ static int f2fs_set_zstd_level(struct f2fs_fs_context *ctx, const char *str)
 #endif
 #endif
 
-static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
+static int f2fs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
 	struct f2fs_fs_context *ctx = fc->fs_private;
 #ifdef CONFIG_F2FS_FS_COMPRESSION
@@ -1173,7 +1173,7 @@ static int parse_options(struct fs_context *fc, char *options)
 			param.key = key;
 			param.size = v_len;
 
-			ret = handle_mount_opt(fc, &param);
+			ret = f2fs_parse_param(fc, &param);
 			kfree(param.string);
 			if (ret < 0)
 				return ret;
@@ -5277,6 +5277,10 @@ static struct dentry *f2fs_mount(struct file_system_type *fs_type, int flags,
 	return mount_bdev(fs_type, flags, dev_name, data, f2fs_fill_super);
 }
 
+static const struct fs_context_operations f2fs_context_ops = {
+	.parse_param	= f2fs_parse_param,
+};
+
 static void kill_f2fs_super(struct super_block *sb)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
-- 
2.49.0


