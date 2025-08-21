Return-Path: <linux-fsdevel+bounces-58664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6108B30696
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 22:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65DC91D20405
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 20:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB43638E75E;
	Thu, 21 Aug 2025 20:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="anu4mt8g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C4638CFBA
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 20:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807659; cv=none; b=trKQ+nyhCS4Pm7yzCs/FNMGb6aNPFHJOLeVdJdbAyrNNthC+Og/IrwSwhcBYDYWzba1YqZLhNVjW2TKz0LMLju7r8AHoM5ZOPo2EKOSCOd3MFPkddKAUVnHsRoHisP1voOAV6kNPq18cX/sSI/Oyt+3tLhyKhoErMKcOEuxNyII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807659; c=relaxed/simple;
	bh=pZWAfjeKEyxWVI1i/b/M2R87xzgDWCxe1Yk13Yj6LPk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nFVDaoeHDdOvN+d5G049MZ+P8YenHsCjn00H6bWM2C1I3e9x2PQQgkQfgPPXpf6BpKzTwzokk29K844ytxC94omMxmMfGFUf1boHpXvGmY8fI1nAmi2FsHtMH5mCvK8eOVy5Q3OXTLH4B+doJz1NsDX0cXS6xAH533tR+T/XeFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=anu4mt8g; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e95026b33eeso1473492276.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 13:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807656; x=1756412456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s8OxZ8arGUc2qFIUcpcCgS+zVxBChijINy+DyEvJNls=;
        b=anu4mt8g4EDrDHPwRfIeh+t/OfTiE6iTKHYbAl1ufsbOmDrHXxNeZyZPlUopTl18Jc
         zoT+amOB+TiovX4lcBQSI4NcmDavG+hMR9zDDcB03Zh9XMn/lOMM/BIVNiWiSSVBvaEo
         nV0kfxrI1DIrDqxfKqYFFkIc20yoHJBu4CrrCzS0lTH6+DrRCgGeBD8PQQ5hSfTVwebE
         SSjAiQzrYlN677ZgEF/F5YLofuJPhgl0P825tvVuKqNs9ay+prdXy2TmXKOnwG+Jrtgr
         hbVdnYjBgU7Nc1Oo8i0cmFmLk49/rV22w2s1UDJGagx5G9m0x9x5I32/sfvBmRqFvhKp
         r+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807656; x=1756412456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s8OxZ8arGUc2qFIUcpcCgS+zVxBChijINy+DyEvJNls=;
        b=a3xp0OrWxUsGX5qdOJBRxhvpdEe88B4nyN6syxzBxAgMyuxLP+YGouvco9+a4evO/e
         ai5QE5DpxkVPtZafDZiX8PEVgfH+T2cZRgbO2Zee8nQQEE2ErRYaieNVxqywYx9lnQDW
         AWPLjtIHYdiOArtWucb22mbI1qVGo/88fpuJn++XxwAAcNeJomE/EY8qFAxYMFRwy5Qg
         3H834xEjxChL7VCpCOK7c8LZ+hUxr8XPq5ZQuR6745+3jMEdOU8+QBDYnNzdWpeTZJIv
         BbRTCD+oNtqofQnxso3IJlL//YWievzPGeEQFdoo2oHdo1UGOjt2GN78Za6GCDu3CKnR
         SdaA==
X-Gm-Message-State: AOJu0Yy1EgnhPaup36tXMzZcvTDt9iVXDmVEuvGNjxF/KaqMeQj8niDL
	JEZdZiuCMM3zTh5Mkc/KT+Y8w922Tn9wfeKK89zbaz5dYOLLn3HZpKiBeDtEMq4mqZJOzYxWFvm
	f1fpT/YblDr3g
X-Gm-Gg: ASbGncsTXe/hjLe38O+CiVFYC+R18MrVZElzpkw5rv7zDEAX49S8oZZvyT6BkPrnCam
	Cb5CUJONueeMBusGvtzJLkbbb27CTh+2TQmXtfD61dzUjm8WL5Q+m+luQdBR78YmvV5LLVDg5Ld
	azidEFJb/NQaOBsGDZRCl20c6cumdd7PKws6IuvOJnruBEwQegnxj84xphkCVvVVYKnIhAGvQf2
	M9VaeDGtZziD/fRFsFrAj22s0bGmhe4Erm5OI11g2FouzHBJUQZG4/YnjS9YKT3KhczIRCKC2PI
	8ArSbLtSsocTmxK+scugpM14QKWXXDXzqwIsHGmg09xRWwLkaKvwW8A1MYCJzH09aaywd76ig9f
	T0++I0km3m0G1Lwc1GV1x1bs3ex4aHTC+K8bLNSdTRJgE2DXadModU8w8FpSCRBJLjYHIPEnaRq
	n5Ft/G
X-Google-Smtp-Source: AGHT+IHKdD7c0NoLaVeNfnIQ5Yw7Ue8ZdBZnrvI+mZUb/Urk+RN0cKprW6ynBsmjXYuBK0VVixEYQA==
X-Received: by 2002:a05:6902:102e:b0:e93:4952:e2bb with SMTP id 3f1490d57ef6-e951cdc81a7mr498133276.1.1755807656238;
        Thu, 21 Aug 2025 13:20:56 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e94f1150b34sm2414635276.4.2025.08.21.13.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:20:55 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 27/50] fs: use inode_tryget in evict_inodes
Date: Thu, 21 Aug 2025 16:18:38 -0400
Message-ID: <7564463eb7f0cb60a84b99f732118774d2ddacaa.1755806649.git.josef@toxicpanda.com>
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

Instead of checking I_WILL_FREE|I_FREEING we can simply use
inode_tryget() to determine if we have a live inode that can be evicted.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index a14b3a54c4b5..4e1eeb0c3889 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -983,12 +983,16 @@ void evict_inodes(struct super_block *sb)
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


