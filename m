Return-Path: <linux-fsdevel+bounces-58677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD188B306E4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 22:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E49701D25E8E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 20:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7FA391926;
	Thu, 21 Aug 2025 20:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="0xrRm3+m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C2F39193D
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 20:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807679; cv=none; b=LB+FY0AMe/1nHTFTrwt2VN+J6fCrlcp3XiQz+PFLACcG0hNOHPxozJnflxNJSVmYlvu9FKtJT8pYAikyOHuDvLjzzg40+z8Hm9XlSd0M5VazIS8DzkQytU2UxHnqFW7to943J/QhtikZtZ+3HpCVpHjqydhdFNXD2M5NW5fLwZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807679; c=relaxed/simple;
	bh=l9LGL5YoR+E74x5+N/Eq/UXBXN/oa7FDffUkNr02mvs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nWka60U5qu8DufSIuKJguVQtkYIOLvqgOjmaTaX0yvgNGGOlL0E9ejBvg+dlLnu8nRK5p6znygTnU1DX8wLq56lyohdmH+n3pGTsS/6C3ZEBz0fLOSzRuKSkfMDJw238bEscQhv8j7Jpu3ENG7ZV4F0eD7wcvW7oP13wxFojCM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=0xrRm3+m; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e931cad1fd8so1366154276.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 13:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807677; x=1756412477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6A8xX7Mkw85UitdhfeCIWR7erYk+tgthiF9HNGtDW90=;
        b=0xrRm3+mKVWYP/+dwHCORPrPDAjir0w4zx3zLOwCTKGB+pDuowu8CcuA5AxVOv7AqE
         ObUCrRWYbHPjdlD7w1VFDcTl//pv/aFW9Jno7uOXMn7wT+eE/IaC6jiT5zPtEfaJKfiK
         eEGADrUX3oa9tvHvMGYVQO1HkMGWO4JBOoLFeQN0iadnnQzovw2YRSnWeFPhsf5pzT5R
         SEyLTBVJIC2ruab/aGzXU1f6Tmiu4rh3sFMIfCUH71vtcz8PAHxkOe/0wFDUQY0Yva8w
         IKGvY9VZ2FnDHM+zLKW9puN/37D3jJbayuFX5g9yNhpI5VgQkyVRlFg9mh6/k92Y6TiF
         2ZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807677; x=1756412477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6A8xX7Mkw85UitdhfeCIWR7erYk+tgthiF9HNGtDW90=;
        b=iFaZCc0Z+S2FbZ+IhtUxDt6Xwmr0L0q/KOn28+cMIqS4R/uTC8u3GFVQvVmfL5WoVe
         V+BcAC8kXImG3Zym0CC45g2coSdovPn85Gb8VS70tr5Hwrv1k7am81i0m5x2WGTauM74
         nhFbjz9VE4cpv/yLjZQd8KpJ7xdT0Gkqmg46sllHbxFZiggTHo++9MbxzaHXIDOcjnXb
         uI8XXsIJIVZ9ZN+/uyEXsRIXe+egI24gq+6mJ/RGdDwV1xritupdZuymRgxTwydaL7mt
         5LHslSgJwLV99V4ZsNQCTjsR5lM4bFSn+m+zwn4FtbU8mka3M+1eCU2huCJ6mB7jSeIZ
         Lkhg==
X-Gm-Message-State: AOJu0YzLVDRs/CAv9hKXwQBmt0KL5PtRNrVxNvPMo1FytCKs2Ek06Hak
	wjc8E0raQnZ2CIf2Rz/Oo6Lvnvw5ysDqXSsEO9CDBKQ86rSK+D6yuYdw+a+tx5EKsvi1YUzXEc3
	awnZMa5eVTg==
X-Gm-Gg: ASbGncv333JvVibnHHOKZHfqhH9p0CdabrvtwryAbPaweuRUOd8fS7lQFXwytQCjqIH
	byEuorfVGqox2cuVJvtTU79eAFyKDC+OgjCFYtgOhq24dCvNaz0XFc9VPefvzgUcxTYLDP0ACWH
	hvzdGB2jySH56cHrFBia9VhWvww/zLQ8E7Zn2J5klrCt9xLRgAOa6LaI/p+dktjb+r10RJHK+oR
	786Dwn3mtUbOi7qDxgnfim0Hkx9LyXK34prPZfEGnlu8LqgQUctz8MWue+JpXaLGmVa8d41ql2c
	rqRmfTlipTKTC512BdnyDZisR7HByPQ6u0F4Lr7fy3xRzkc3AOjl/hOTfQWvuTjuzf1ZQZB9iC+
	nIj5RoWsuhk2xRNgE02gvacYfdfjrFeTlkde1gGvHveAMGReRgVUEqSfSR88=
X-Google-Smtp-Source: AGHT+IEslmPaAmy8j7deq0G6NJW1ig6p7tgKnrmQqRmoW4yzMeUV0UVc/9ZPvIEXnYkUv+t0w0Cs7g==
X-Received: by 2002:a05:690c:e0e:b0:71f:9a36:d33b with SMTP id 00721157ae682-71fdc412c54mr7580807b3.45.1755807676808;
        Thu, 21 Aug 2025 13:21:16 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71e6e0b039dsm46055887b3.59.2025.08.21.13.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:21:16 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 40/50] landlock: remove I_FREEING|I_WILL_FREE check
Date: Thu, 21 Aug 2025 16:18:51 -0400
Message-ID: <e54edfc39b9b19fe8ff8c4c7e8b5fe06caa78fc9.1755806649.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755806649.git.josef@toxicpanda.com>
References: <cover.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have the reference count that we can use to see if the inode is
alive.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 security/landlock/fs.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 570f851dc469..fc7e577b56e1 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1280,23 +1280,8 @@ static void hook_sb_delete(struct super_block *const sb)
 	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
 		struct landlock_object *object;
 
-		/* Only handles referenced inodes. */
-		if (!refcount_read(&inode->i_count))
-			continue;
-
-		/*
-		 * Protects against concurrent modification of inode (e.g.
-		 * from get_inode_object()).
-		 */
 		spin_lock(&inode->i_lock);
-		/*
-		 * Checks I_FREEING and I_WILL_FREE  to protect against a race
-		 * condition when release_inode() just called iput(), which
-		 * could lead to a NULL dereference of inode->security or a
-		 * second call to iput() for the same Landlock object.  Also
-		 * checks I_NEW because such inode cannot be tied to an object.
-		 */
-		if (inode->i_state & (I_FREEING | I_WILL_FREE | I_NEW)) {
+		if (inode->i_state & I_NEW) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
@@ -1308,10 +1293,11 @@ static void hook_sb_delete(struct super_block *const sb)
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
-		/* Keeps a reference to this inode until the next loop walk. */
-		__iget(inode);
 		spin_unlock(&inode->i_lock);
 
+		if (!igrab(inode))
+			continue;
+
 		/*
 		 * If there is no concurrent release_inode() ongoing, then we
 		 * are in charge of calling iput() on this inode, otherwise we
-- 
2.49.0


