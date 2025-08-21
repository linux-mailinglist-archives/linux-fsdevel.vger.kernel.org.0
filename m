Return-Path: <linux-fsdevel+bounces-58645-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C98B30640
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 22:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A56C762293A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 20:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455BD38B644;
	Thu, 21 Aug 2025 20:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="0MkpeVu4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C91372166
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 20:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807630; cv=none; b=uyhk89Cy9sQgE9mGmnwmtxviWKzkBo+0+Uz/olfojEVDNl0FTiFvSr2DSFoqCCVwVgBlsFH9mh+HVKWml6m+eo9zHD2XksYCeL5EH8UaiBuIza6nUUo2QU7u8ZFFAaV4x0tNU/BbUPww10CddXXUC1XFhQ26Y2nC3J3p8QYJ5sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807630; c=relaxed/simple;
	bh=JqyAltqlHsDhxnWV26UFEbViQ/nho1N/pG6i6mXuWqY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TvEUtZY9exwG1rATAAPQ1QZow96lBs1ZJSUa+QVFPY7jg+w5u4IZnHtjxXdoZ5ghwi8nMHwf/oz+KKI39PyDUpomZDZim6KferaeKmXoyiAjYPltNYd7nLqh7Ozf4/GmsSFHGKIirk/lNr0bZHTExx8ewC1oFExva50CGQIwpzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=0MkpeVu4; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e94f19917d2so1385728276.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 13:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807628; x=1756412428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cb2V9k5PVP583r5lr+1rASUj/P55tkAhqxStui+NIFo=;
        b=0MkpeVu4GmWpGkbrloT4mINPrJhM10MgHRIt/8CUVdG+NpXBWleHIZGvCW2cesBcsZ
         pvkL3spRfGdon4rr4gaLWFx7jnNxHE/tleDPePNcksfy3wqU6n6sRgkjom8Rh9DP/BW2
         vXQ6B4JgErqJehnyO86EBnh+mQ0+yu+Jnakk2e9arQWAK57MEboa5czFZlxLn5MAg0dd
         kb3o9H+63nJjskSx/zg+GpYpotZvqA0Os3R2yh7qWW3cma2G17eFKoaxyuGJqKd+IFkZ
         DtgIcWcRMTSUDnfGY3WKUIlyW4HF4pYsl1QAVmXhjFv/ufVcwdoocGUDUiYp3nO4WPD6
         HrjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807628; x=1756412428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cb2V9k5PVP583r5lr+1rASUj/P55tkAhqxStui+NIFo=;
        b=PvCeONybeJGd5hVtuigId00kV4XQ5KyTf6pwctqcLv53QnysI9oul/ETnj7JwgfPD1
         BF4G5QMXWvHJFES5tK/u3MjPoJaJ3axP821VQoN2nGZBsllsFgKiTtPHnI5miNj1leJX
         5qeahCu1ztiZYxw9/V6mdCGtABTB8l37xL5JIP7z4FE6lug8vssIiepfd4l7WE9hkjG4
         cwDJxwpDMWSSgpfGWS+ot8HdOEbVTVhm9NUVfgFOCqvW+5B3DjYOhqg6ZjBuXBWPffbV
         AeS5PZY1sMTeelLQxxAtlRFn688Yz3yatyxrfxYWFvAwcH2262UXdpwtPRH8whKkhcQN
         zqIw==
X-Gm-Message-State: AOJu0YxFTjNmIzycmF+Skk9ioN1aP1vl7bUE3+1/cIO5eXLB2vlj5Kc4
	0PcoYZFOwEjWrzmI8JvfybuXV5+IKdWl8ALHMV5dBo5nWK4aQwzBIR85+EK79vGc4iUtT6x85yi
	DL1eseId3nA==
X-Gm-Gg: ASbGncvpq4fP+EtX7vzyVG4YlXA4SgqbfHbr/TBKhYNRvCVy/pNgvvUFXZW1qSi3CVD
	WTrn6e9Xst84qtyLLcv3mLYWQY60zJOfCqQKwymxUdYhesyI4SPU3lMBWfop/xgvA4Q3nQBhXAi
	A0UrHy7NnVWpfPaAqTyMxyefhEFw26HFLTSah7C5dmMie5EJAf0ilTRFQ5pefD+B7LMwUr2m/w4
	ukz2KdKrt1FpMTK8qX4C7D3oQmsal9N84wOJHcLCQXsKtyqi4fLr8XkUlGI2POWTy/oIWsOaBXl
	kyGAMkfN40pCg17djICL/cWxhNfyMEGBwSp0W2uydi0/E4+kX59qePpFlnt4ny9n/H9REAK/kid
	bTNYDBI3/G6Mlx2Z4PegOxh4HWr30ycKziGfBJ4C0oTmYRDKbGyYULG51L6E=
X-Google-Smtp-Source: AGHT+IE87W5Ra788mXEaYg1x3BO4fJJ18wjL8kms/6rnsfpL0Qf/z0M6cHEdhh+NBNhq7o8SIEAtHA==
X-Received: by 2002:a05:6902:6c13:b0:e94:ffa6:177a with SMTP id 3f1490d57ef6-e951c2428f4mr1122255276.23.1755807627448;
        Thu, 21 Aug 2025 13:20:27 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e9519ef31c6sm374368276.23.2025.08.21.13.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:20:26 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 08/50] fs: hold an i_obj_count reference while on the LRU list
Date: Thu, 21 Aug 2025 16:18:19 -0400
Message-ID: <1e6c8bb039a6f1e76347b3214be78326b403c57d.1755806649.git.josef@toxicpanda.com>
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

While on the LRU list we need to make sure the object itself does not
disappear, so hold an i_obj_count reference.

This is a little wonky currently as we're dropping the reference before
we call evict(), because currently we drop the last reference right
before we free the inode.  This will be fixed in a future patch when the
freeing of the inode is moved under the control of the i_obj_count
reference.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 1ff46d9417de..7e506050a0bc 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -542,10 +542,12 @@ static void __inode_add_lru(struct inode *inode, bool rotate)
 	if (!mapping_shrinkable(&inode->i_data))
 		return;
 
-	if (list_lru_add_obj(&inode->i_sb->s_inode_lru, &inode->i_lru))
+	if (list_lru_add_obj(&inode->i_sb->s_inode_lru, &inode->i_lru)) {
+		iobj_get(inode);
 		this_cpu_inc(nr_unused);
-	else if (rotate)
+	} else if (rotate) {
 		inode->i_state |= I_REFERENCED;
+	}
 }
 
 struct wait_queue_head *inode_bit_waitqueue(struct wait_bit_queue_entry *wqe,
@@ -571,8 +573,10 @@ void inode_add_lru(struct inode *inode)
 
 static void inode_lru_list_del(struct inode *inode)
 {
-	if (list_lru_del_obj(&inode->i_sb->s_inode_lru, &inode->i_lru))
+	if (list_lru_del_obj(&inode->i_sb->s_inode_lru, &inode->i_lru)) {
+		iobj_put(inode);
 		this_cpu_dec(nr_unused);
+	}
 }
 
 static void inode_pin_lru_isolating(struct inode *inode)
@@ -861,6 +865,15 @@ static void dispose_list(struct list_head *head)
 		inode = list_first_entry(head, struct inode, i_lru);
 		list_del_init(&inode->i_lru);
 
+		/*
+		 * This is going right here for now only because we are
+		 * currently not using the i_obj_count reference for anything,
+		 * and it needs to hit 0 when we call evict().
+		 *
+		 * This will be moved when we change the lifetime rules in a
+		 * future patch.
+		 */
+		iobj_put(inode);
 		evict(inode);
 		cond_resched();
 	}
@@ -897,6 +910,7 @@ void evict_inodes(struct super_block *sb)
 		}
 
 		inode->i_state |= I_FREEING;
+		iobj_get(inode);
 		inode_lru_list_del(inode);
 		spin_unlock(&inode->i_lock);
 		list_add(&inode->i_lru, &dispose);
-- 
2.49.0


