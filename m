Return-Path: <linux-fsdevel+bounces-59262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E46B36E73
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 17:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C5421BC0759
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 15:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9688F345752;
	Tue, 26 Aug 2025 15:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="PAIBrMSp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAD1368093
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 15:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222894; cv=none; b=Pd7RIDp/JkD2uT4x5i+r0WB4vGvbaxZPBh8hbiJUKfjpCOE/5GJzxks181NGaA2WkfEFnAPfDZU7og79WugMypMI/+T+T2coaphPYBI0CroaVWnXg3FpMXndmPII/V87NJrRmzUC0z0yDiqBLoTY7/58fJ7Vixw1EoPWFk1tSco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222894; c=relaxed/simple;
	bh=KH914xoQJXrO8N3ZjmL923rQ+0fw5BtVRwkJcmLo93g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SA7NeOp1uGCb0/7yoihK6C5uJJJhEwmH0ADWXS0OKsa+JxF8iMNoDoq4W9KzS/4evHTRIVdRqUK+b1GPZATCsynrBHd+4yzftv4JIcnU5UkZCENLBJCzs4RZixAPTHN0u8gc4r4KR8k+T0QLNRB53L0YRKAE4xvkymCXGU3/Y8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=PAIBrMSp; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-71d60110772so49945287b3.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 08:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222891; x=1756827691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C5KAKsh2PfGXT4+TYPG/ltaJ7kkJlF6llKvHHQC7hMo=;
        b=PAIBrMSpjeDzuYzNJC62+RMhL/Fl6xdLmvBwZflI1a2/qZ0H7VxahgeFe2J2cCNZRY
         B7WCA2M7b7ZxDaLu8Pv1/LjFNsZODqQwetoe6/v53qB85BF4QxQRvZt+epApAW5nmbox
         5K4Z5S9FFpR5PrM1gDfEFGHtONcq8m5NWSsyG+D3GR2Xr6y9n/29LBjdYnoYNqyDtZ6a
         aqoCK/SRshuysx1TLXRFN6UKV6pcIFgfMJamxsm/QRbcCddYijlsCeSpK+3iW5MlUTpL
         QIbe3e8BkATd0PTHj2lgJVw7U8vA7LWjvbcnN36GpewVJX01gNebt/D18gy6m+PdtcNT
         zUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222891; x=1756827691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C5KAKsh2PfGXT4+TYPG/ltaJ7kkJlF6llKvHHQC7hMo=;
        b=kmX/pzw/LDjQub+v3ZwHKoLi5RbymuOscHYivIvfjjuyeIbiW5/3nm2YNRDfXDSfRp
         ZxN89Z+FL/E+WRcwB8FRz3q3kMobbk4fkEZILN2Z7DvlIqORBgR8shFC8UZ1MH/XSg70
         7z7VW0p+2lu58x7mL9Gyqaqqbv2SBpfiBgI8bT0K8JmdOnKmLy04jf7JrX+xro8H9ISC
         satb58/sVdwbA0rUTXDeanTeUqemhjlwZ4OscfRpJyVTapvBGSoiF3owYmqfahLnfqif
         GHQSgbZ7xQT+sRczQDDp6egxaptTJ1qOZXZ49xNNCNPO/6smFoL4CtbUknU+FbUolMUp
         RVHQ==
X-Gm-Message-State: AOJu0YwYt+8KINRwTYAsC3wKV4ufLEZGCnDXHTfQ5FKOa0KoguZ38V/g
	TDqLNvXxfy3YJp4D9EtSXNoVdpb2K6B9tPE1srOcKNQzbI+q/QxZZVjOWRGe74jXSxHhQrSF9fO
	2ykKv
X-Gm-Gg: ASbGncvl0PCSqKm4Dg8jCgQkCHf2tmmxqYTf1GN1A/fkhZLW2riLsMJFmPhHsOoeIXT
	jZbEH77AgmOJFZ2nKdisqbDwIqQYlfuQ30Od6iGXGqBjV9X3mbCXPUsqkaHNJbCgkPjj0F5jmp6
	Tgt99W1BvNVt9Mvhw4R/90EN62El6jsscDNJVgmj+88l8esB+zjD0Jmezif0pJlbCTaWOiVmjlv
	CDbjjcxh0V2vufEUGndTSbkLRfQikeCxiO2Gj2pa9ZSaXp26XncNaZun+iQRVmOTZgK0MTYn5V0
	UpoINq+X3laObTSXXssL+suTZVzR/tBZuOeXfKL8jeTKb9BxeCff9H0r/rRZPCn1XfCvkUp9DGT
	GhLC74sFWYt0/JdmU/QduopUuh66vbQ4qO6oHgpT+ASxRBH7chdugxQ7O8y2cnAScdNWoNg==
X-Google-Smtp-Source: AGHT+IFKqwEmHNx5eQFlQTUVO696PTRIuWbfxVqgnshRh3PzZ7/9O1IwzGnfu42E66nP2s6IML84qQ==
X-Received: by 2002:a05:690c:620d:b0:721:369e:44e4 with SMTP id 00721157ae682-721369e668dmr18015457b3.45.1756222890893;
        Tue, 26 Aug 2025 08:41:30 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ffce104d1sm21641597b3.28.2025.08.26.08.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:30 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 29/54] fs: use inode_tryget in evict_inodes
Date: Tue, 26 Aug 2025 11:39:29 -0400
Message-ID: <a9182c9716b474752c0110af726b95125a7007db.1756222465.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1756222464.git.josef@toxicpanda.com>
References: <cover.1756222464.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of checking I_WILL_FREE|I_FREEING we can simply use
inode_tryget() to determine if we have a live inode that can be evicted.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 2ceceb30be4d..eb74f7b5e967 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -967,12 +967,16 @@ void evict_inodes(struct super_block *sb)
 	spin_lock(&sb->s_inode_list_lock);
 	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
 		spin_lock(&inode->i_lock);
-		if (inode->i_state & (I_NEW | I_FREEING | I_WILL_FREE)) {
+		if (inode->i_state & I_NEW) {
+			spin_unlock(&inode->i_lock);
+			continue;
+		}
+
+		if (!inode_tryget(inode)) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
 
-		__iget(inode);
 		inode_lru_list_del(inode);
 		list_add(&inode->i_lru, &dispose);
 		spin_unlock(&inode->i_lock);
-- 
2.49.0


