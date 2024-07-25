Return-Path: <linux-fsdevel+bounces-24218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6230493BAE4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 04:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1268A1F221F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 02:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27D011711;
	Thu, 25 Jul 2024 02:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="Ucj5nsdj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36C963D0
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 02:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721875234; cv=none; b=mgLxThnel86oTwBZTyDRcZfuWmjEFEIKR+f8DyUVeLI41KZF8eVt6JcPpUHJ/svOQqNDbx4JUelqugSvaU8VjUqnmeU/6vofQ/ve79r7adfPkuYkzjbMBBO4+srx7czrcfndBc2dykGZWm2Tcq7YDjdB6udTNhsjVJdN7TVA4XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721875234; c=relaxed/simple;
	bh=+Q3gEmDizWp+wVM9J7repNjFwCf88tvXmIhUEt02z3U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tnOZqANivFST6MQZdlHqlAH1gdPh2RIAiIwYaU3aoZ0HIZt1YNe650Yw5ahs69qCJS06s2g56xDSOuA5Bnjqz12WK+LEuX/fNFqP7Xqc/blJ3VRkRwA1OoB9mBh1Ah387GA0gmMuKfvNj02MQuEEr3I9ANbjHZZ68v0zisJbaDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=Ucj5nsdj; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fc65329979so3423305ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jul 2024 19:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1721875232; x=1722480032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6qGDo/UGEvSr10Mbjrm7JlnAMdeNemkg4xjMy1whgo=;
        b=Ucj5nsdj/Uhls5WQA73mxy2+GNsBls5GF2CiLS++Ort4R/m9Tzf44U/O2FRP0WAiHc
         KYWof9/jy4cG0TSySHCgoPvKpFp7F48COnV60NOSrFcqBeLZQLQztZ6zg1XgukOa0OVm
         wGnl8A3+lVDEfxoIA6aTlNDXNf8AF54ZfO327tMKvEF0tnoKt74lgXbKTRAPY+oOCzpe
         QC/mH0sBPqFUZlk0IGgdIE3xt0kWUtwqQ4KTIlC+Foqt5FkHOTXTEhBtFkjXmmFFB+AI
         PK6tlbwtu2mfs56MoqwmWm13d43mNU5A5GFty8nILu4MpbAyBAdHcNwZOJkgMSaeE+RJ
         XPgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721875232; x=1722480032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q6qGDo/UGEvSr10Mbjrm7JlnAMdeNemkg4xjMy1whgo=;
        b=XUo9YJZrXS4NLccFeVZ7Idwz6vxOKbCNd5cIpd/2WkZgGrXhiqVxL4F/YMwbAeOIJf
         QCHcW6Ot1DN9XXTAH3r4NVTUZ18Y9CdM/7WM+ycyw3szKqSMkFbDzwkYBYW1HcRnLMHT
         pKvJWm0iq1kkGdBjkwD6l28jKZ1dHBIxQNQS76nZ7o6jDJnCBo4l48RaAMCfzOQMyMG+
         Bx57eM3+/TekSuIxZyhOYm4o7drofE/ugSl/Xt2Dwhw83fjNlQj5nbfGcW2HsvcKipyh
         FJ54VltmA7lTUA7b9YE2u39F1SpUICDChygJ/Em2dZR10pybdIRl5UgOBJxdd5B5uWZA
         Pp+A==
X-Forwarded-Encrypted: i=1; AJvYcCVSc9Zn3yYEw5DjYjWNnBu6q9CTVCe/5VMg86QNxr0N/sbf7GSD+8xgK5449wN1c2dVngQwyOA7I3D09rz1adROSLKkvvLbWyjFL/GMzw==
X-Gm-Message-State: AOJu0YwH9M5UXP2oq4qhxCsGOWaTUt9PB/HRffZxb6y/X4wFLbPvxJiL
	J9twq++CfRUvT9NkgceEC+q/dcg8j/z/BiMw+HnaDmARiTlVtVDt5n584vGGbLI=
X-Google-Smtp-Source: AGHT+IFptWv1W0aKCBfAlsb4iJ8o/+2ZgqQljyVLnF95YGVYKfrsg+wXBhNV7DYReRptmCteiaPr5w==
X-Received: by 2002:a17:902:fb0e:b0:1f7:1b08:dda9 with SMTP id d9443c01a7336-1fed924ff52mr4939955ad.8.1721875231899;
        Wed, 24 Jul 2024 19:40:31 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.18])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c8c6f4sm2814165ad.24.2024.07.24.19.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 19:40:31 -0700 (PDT)
From: Haifeng Xu <haifeng.xu@shopee.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	tj@kernel.org
Cc: axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH] fs: don't flush in-flight wb switches for superblocks without cgroup writeback
Date: Thu, 25 Jul 2024 10:39:58 +0800
Message-Id: <20240725023958.370787-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When deactivating any type of superblock, it had to wait for the in-flight
wb switches to be completed. wb switches are executed in inode_switch_wbs_work_fn()
which needs to acquire the wb_switch_rwsem and races against sync_inodes_sb().
If there are too much dirty data in the superblock, the waiting time may increase
significantly.

For superblocks without cgroup writeback such as tmpfs, they have nothing to
do with the wb swithes, so the flushing can be avoided.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
 fs/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/super.c b/fs/super.c
index 095ba793e10c..f846f853e957 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -621,7 +621,8 @@ void generic_shutdown_super(struct super_block *sb)
 		sync_filesystem(sb);
 		sb->s_flags &= ~SB_ACTIVE;
 
-		cgroup_writeback_umount();
+		if (sb->s_bdi != &noop_backing_dev_info)
+			cgroup_writeback_umount();
 
 		/* Evict all inodes with zero refcount. */
 		evict_inodes(sb);
-- 
2.25.1


