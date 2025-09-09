Return-Path: <linux-fsdevel+bounces-60633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D961B4A73F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 11:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F03F160E9B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 09:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B159298CC4;
	Tue,  9 Sep 2025 09:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="beOuUbYf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC26285CBB;
	Tue,  9 Sep 2025 09:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409254; cv=none; b=TMkzuvJUMs887KaQBJb3BZc+DwzZvSBwuGKj6idZOcROfs15yY7ejOnsaOEWzhwBbRi1r4XmfBiH+6Y29zoKIQylpzI8jHoUgM63aNLZqMbuyxFUBXYtabocvzjslZGzl7VEzPMOi5kFpa1jrH6dEbh0CO9KU1Kk+aKGsolkSvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409254; c=relaxed/simple;
	bh=TYlBN9SWy6X1LN8X45cEXu8CIOiJF9kPJiuMRA9CPXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eAjuoBEEVIcTc71Djl/Y2O2iRsy87WMRCO0R5N3LwynogY2rNh+g1zn/19ilRJVgWqtMUtBAaqnvIj355UuExKNcHg9l3Rm55DsfcXCEUYzMXVVNtv7Y7qY5SexTG8FaLy1rRj6Rypav/SpxHPBKOKuoyUeDRAhmOVT0B7/mwuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=beOuUbYf; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3e46fac8421so2648717f8f.2;
        Tue, 09 Sep 2025 02:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757409250; x=1758014050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLviJGbVCxzfvbX4BT9S5ksTvNKxyPolWu16EG1Zpx8=;
        b=beOuUbYfuhZ5XDaNnBAgrv8WRP2nGkreMNTaKL3ixcqIHYk5nVdEPd7yCOnhXtIxRw
         4iEkHoXJOVQNJZNxjQ+9GI5jxBtiyvj8QeyowdbTWyD/4zqmR3RzZ620YxtxkjoNtop6
         W0s0X29EJ0czSMd2Zet1IMPEfK3B2xn2Se6xGsC1B0pN0+7ijb23eAjrp1cRVgUAApWU
         ItoRuZ/EBdsHFC62iermzrr4YLS2H9s2VHkt+uLKvFE6KCF+G83/h0mimvJbDB04+d4C
         Ayqe8Q9sIM367nn0aMOQFXw7sDFBJfOPTUgI0IEGA4/G6u+3L32O2cP2d3lmAVREsDOx
         u9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757409250; x=1758014050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wLviJGbVCxzfvbX4BT9S5ksTvNKxyPolWu16EG1Zpx8=;
        b=mDxlUhVMZCTga2ccVS1O370kqBOWg+zOBlVvTDx+YjliylUPlhBbrAdW6Wl3xzDqDJ
         3aluUroNI5b1xZr+2EjATUVreOoIhIhFy2ha3MRcncHGwfQAqUPDtEXaPbThAX7WHWZm
         78Kp2sUfrvwoVOX0xtddapTNf2rM9xP80aOgzCTTJo+7edL/fSVa2KwLxTm5YejHSREY
         OVz23Oh6MjEyWymvw3SU4b+uYrBm36dOhWKLhc0Q0h4qnJTZ5ErWRr2x9+4QrpCBwJaG
         zIwPt4rc2o6sXdjegwtuGvMx6khEhaXa+tfO00L4YV4OpGy9YIVhhpwR2N+TYHIq16ag
         PLjA==
X-Forwarded-Encrypted: i=1; AJvYcCUx2GJGR6lk+ieLu6Fds1R8ekKTVHWz92KNJryO9kCHYRcrVCTwroOHv8DmKaOMB/pxjJ0qbDxHWqYPrjoyUg==@vger.kernel.org, AJvYcCV96r4Ck7jKvI1cs/ZNhvxmZzJ+XSn6uICjxOtu+cWhA0Q2L3iWCsx7a4X7JcHTjqLigrFxCn/OUmA1AlOn@vger.kernel.org, AJvYcCVHI9bViAfWkNu33m0XL7G5g7kICEnuzclAdoSR3PPQy639OWBOCIVS2pnPTUYqymzR75+90kcMDpc7pg==@vger.kernel.org, AJvYcCVdJBaOPulLqLRURTSd720YiFsRTV6Z0r5UiH9AWbMpMSSknByQ/ZRBZul/0pptRxTGJVinJsDrx+7f@vger.kernel.org, AJvYcCWbI5ZYb/1XcJG7Q5TEtUqf8f3E4pneb4gRPDL1sYXUo7RMLSPnLiu2YGPT34auH+plunmtmSS4sqglag==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2tDuY5sj78JmzuJ06fER1v3+LILoV0paqYMvxFd5y7tKOC+nK
	hZWql/UrSFyPArBRrjkaJT1r8nAh4gmLT4vmvA+n3NYd0ZU52z2S5GPBaJH19F5X
X-Gm-Gg: ASbGnctrERIm5wUf9WnEhUpNY7SF8qKvHgh/119sCl5A9x4KgRc3DqdCpAlhyoOUUc2
	Epvyxm0LOLmghuLuOVDyDo0YQGk7QdXfX6+zXPFXmMseIvLcLcHBJKbQGOmOYNgMlWLkPSVMTlM
	3HDNiSG6mjxFYRCGw0oiB9ihdEJBla9i1znmzmNLLSwujTD01XnydTYP1gdeAU9p24W0yscaBGB
	lf7xW7Y1wXImD9bzR84zg93etAHKE2b8MletkfXweJQkxHLO9dTioAToDzQXBHgxzMdOjVzajWI
	hfsA7ZULk3wnG3lR6+LQ139bogqt1gx/6pF9W0AZmyMvivuBct5R8qBmWPK2PqkTR0bKhxSgt94
	Ntq8qbvJrxr2mXYN4GPq1Y6HHkt+buVYiM7T1ErEb
X-Google-Smtp-Source: AGHT+IHjsTfqM5PBGVR6UF94HDhLwfXTx/8ONN5qUE2vE5qVeIKFE1xIuEhq4NJqrwwdtIH9zK4Ugg==
X-Received: by 2002:a05:6000:2481:b0:3d9:dbe6:e613 with SMTP id ffacd0b85a97d-3e6427d8186mr9548204f8f.15.1757409249630;
        Tue, 09 Sep 2025 02:14:09 -0700 (PDT)
Received: from f.. (cst-prg-84-152.cust.vodafone.cz. [46.135.84.152])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521bff6esm1810784f8f.13.2025.09.09.02.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 02:14:08 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	josef@toxicpanda.com,
	kernel-team@fb.com,
	amir73il@gmail.com,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2 03/10] bcachefs: use the new ->i_state accessors
Date: Tue,  9 Sep 2025 11:13:37 +0200
Message-ID: <20250909091344.1299099-4-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250909091344.1299099-1-mjguzik@gmail.com>
References: <20250909091344.1299099-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/bcachefs/fs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
index 687af0eea0c2..172685ced878 100644
--- a/fs/bcachefs/fs.c
+++ b/fs/bcachefs/fs.c
@@ -347,7 +347,7 @@ static struct bch_inode_info *bch2_inode_hash_find(struct bch_fs *c, struct btre
 			spin_unlock(&inode->v.i_lock);
 			return NULL;
 		}
-		if ((inode->v.i_state & (I_FREEING|I_WILL_FREE))) {
+		if ((inode_state_read(&inode->v) & (I_FREEING|I_WILL_FREE))) {
 			if (!trans) {
 				__wait_on_freeing_inode(c, inode, inum);
 			} else {
@@ -411,7 +411,7 @@ static struct bch_inode_info *bch2_inode_hash_insert(struct bch_fs *c,
 		 * only insert fully created inodes in the inode hash table. But
 		 * discard_new_inode() expects it to be set...
 		 */
-		inode->v.i_state |= I_NEW;
+		inode_state_set_unchecked(&inode->v, inode_state_read_unlocked(&inode->v) | I_NEW);
 		/*
 		 * We don't want bch2_evict_inode() to delete the inode on disk,
 		 * we just raced and had another inode in cache. Normally new
@@ -2224,8 +2224,8 @@ void bch2_evict_subvolume_inodes(struct bch_fs *c, snapshot_id_list *s)
 		if (!snapshot_list_has_id(s, inode->ei_inum.subvol))
 			continue;
 
-		if (!(inode->v.i_state & I_DONTCACHE) &&
-		    !(inode->v.i_state & I_FREEING) &&
+		if (!(inode_state_read_unlocked(&inode->v) & I_DONTCACHE) &&
+		    !(inode_state_read_unlocked(&inode->v) & I_FREEING) &&
 		    igrab(&inode->v)) {
 			this_pass_clean = false;
 
-- 
2.43.0


