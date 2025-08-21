Return-Path: <linux-fsdevel+bounces-58644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA5DB30636
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 22:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDDBBA0264F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 20:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA26E37219B;
	Thu, 21 Aug 2025 20:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ute/rt2a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FF537216F
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 20:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807629; cv=none; b=Csah65oZqB9BRmwCnyZ2HDLG6ba6N6lbPQUuiRG5r3pnP8b8ZHDZIqeilrJwPt5NmqpzziaP4oOL1zY8BfSUlZmWpVPVxSzaR9xUfSJoGhR8Jh0JW0boqghZaQe8s2/GPPU+h+StKEupg61zu+vhugawKFXWCnJvfsicR1HHGjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807629; c=relaxed/simple;
	bh=79hNy8MLLzEWxtQB4sKNaWyskip03chASXjDy5oeEVE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QIuWVZ+LIXZM4cjE1T2vGrZZHRn05EeDBhsgSHbkwxnIHmCGGBhHOJHs0jVFszR6MiuyrKoGvZml0+2PtUYHBk5eJtQkIL9a/9tkeWajI905dNq5c7gEogVR1VwjOgTE5vm2d4GO73hoK7dDTVtkqbgoECCDKcVBSp73wfTSFiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=ute/rt2a; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e94e3c3621fso1439813276.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 13:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807626; x=1756412426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fQfgrNdLLZc/kRK8PuHP6T1NoeMFhCjwF6aVkuwb+Vw=;
        b=ute/rt2aDrIGbZcCD4LoRaErKtNRZOnwRe0tj73h6Uh6wBt09gFyfS/b+nr5VTrHRM
         jdjYrsHb9aizSdiPtxJVHryfIZOUzkn87zPRqYAq+K0hTuwI2KIe+d6AL2RHHxFmWjgp
         MDZwbUO1v7gEpLVagg0/apRbDMBjjdbsNvSjZkHOkpGRnZRMZ4/+ubFnpmObjsxFR51T
         LcFRDS6cb9uyvV5QZOB+NA8lyg3YSLW1rqv8ylfL4DfMwWfbG2xVo4FP9AyCF41kfH66
         kwrft+1sGQl0g5Niz8Pvx4ZmvYk4EdBSTpYybUhSzpeT3hEs1yilEbdxHSJLrW5JrGDP
         s1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807626; x=1756412426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQfgrNdLLZc/kRK8PuHP6T1NoeMFhCjwF6aVkuwb+Vw=;
        b=EhFRJUKcIz87jAFr7DQGBKuF0FU2WNVG3y42Ybn+ezv5Zsx2Lc1pGCjuWZKiY72baL
         nV4rDLGcEsvKlIbPoLpa67b0h91Fte6p9Vp5sxQr/kGt/RgmGcYGgCpYm9DK3IWJgdum
         tduDayhxb5k6bGrNQ+uHicfK5Ifxf7dzOrV/yj2DvEZM6ycKeEW3EOj+cf4BOly5zuqC
         HmvkVn1ejw8dFD9KJ//mQ87ZR1RuBT+EaJmtxrdckVLVVv5jTjM2EgQKbKmwevJh8KlH
         o6I3GBapv0wHxwujIfuNacWVEp1xh1glB1c/9nGBlG6suGFph2RISbAanc/NDHmQM2Fq
         7M0w==
X-Gm-Message-State: AOJu0YyNC+NP8BMqfp1crwNX3pfs0Ybfv+SjkmH67ax4yMpeKvXJobyk
	wABcxv3ktqT0yxRB5R6rCf7Vtw9USO7JEbKCe++2wltS9FAUGbM5+y1Pg5NE4QqMU/GK4t8wnNt
	BgIrMHPFM1A==
X-Gm-Gg: ASbGncsFuu69f1foIpEKAn9nY+ce8iX//dYnz5oaxieBfLF0HZFI4KdhX33dSEyalTv
	nSo2zRXqUWj7fONq39QO/EXVCEgjYf4G0Lg30GuVP0SMaIYyHA72RzGNHnZIfcSBydRnBboqo2m
	ZvguTxOLwaFeFkx8stgj6GQxz/SGzcdDbnG/RwDLQ+2+o3r04oChc3lMXtT+KoMtHytGPbdzDJA
	ywb6SyspjTQX/Vx5TJ7yoQV/DgEqQ4cdsiGYfbXKBlGAx7KEnzX9TwRGrumrrsx8UYzVhbYR0oQ
	c1WEmS3SmCTy+Mkxmz2J4rPXfTz7QkJQQKt3TuwJs6rD7hTLia3Af+kqDyxogXtNUEJEhLzRzf+
	GB7LHzzJ3WVnTyP5g6LmWG/4eSgtaI+b5Ex813Opx5Aaop+67JsMXVFR/teU=
X-Google-Smtp-Source: AGHT+IH6qMUNtcjMenDwwsBm6WjRZG6TyRrHXTaa6FiUieFXv2EqpL/3ycbYTymZg5Nc7D4WJE0sWg==
X-Received: by 2002:a05:690c:b06:b0:702:52af:7168 with SMTP id 00721157ae682-71fdc2be3eemr6737757b3.2.1755807625992;
        Thu, 21 Aug 2025 13:20:25 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71fa8224c2csm19078567b3.16.2025.08.21.13.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:20:25 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 07/50] fs: hold an i_obj_count reference while on the hashtable
Date: Thu, 21 Aug 2025 16:18:18 -0400
Message-ID: <56fd237584c36a1afd72b429a1d8fbf4049268cf.1755806649.git.josef@toxicpanda.com>
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

While the inode is on the hashtable we need to hold a reference to the
object itself.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index 454770393fef..1ff46d9417de 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -667,6 +667,7 @@ void __insert_inode_hash(struct inode *inode, unsigned long hashval)
 
 	spin_lock(&inode_hash_lock);
 	spin_lock(&inode->i_lock);
+	iobj_get(inode);
 	hlist_add_head_rcu(&inode->i_hash, b);
 	spin_unlock(&inode->i_lock);
 	spin_unlock(&inode_hash_lock);
@@ -681,11 +682,16 @@ EXPORT_SYMBOL(__insert_inode_hash);
  */
 void __remove_inode_hash(struct inode *inode)
 {
+	bool putref;
+
 	spin_lock(&inode_hash_lock);
 	spin_lock(&inode->i_lock);
+	putref = !hlist_unhashed(&inode->i_hash) && !hlist_fake(&inode->i_hash);
 	hlist_del_init_rcu(&inode->i_hash);
 	spin_unlock(&inode->i_lock);
 	spin_unlock(&inode_hash_lock);
+	if (putref)
+		iobj_put(inode);
 }
 EXPORT_SYMBOL(__remove_inode_hash);
 
@@ -1314,6 +1320,7 @@ struct inode *inode_insert5(struct inode *inode, unsigned long hashval,
 	 * caller is responsible for filling in the contents
 	 */
 	spin_lock(&inode->i_lock);
+	iobj_get(inode);
 	inode->i_state |= I_NEW;
 	hlist_add_head_rcu(&inode->i_hash, head);
 	spin_unlock(&inode->i_lock);
@@ -1451,6 +1458,7 @@ struct inode *iget_locked(struct super_block *sb, unsigned long ino)
 		if (!old) {
 			inode->i_ino = ino;
 			spin_lock(&inode->i_lock);
+			iobj_get(inode);
 			inode->i_state = I_NEW;
 			hlist_add_head_rcu(&inode->i_hash, head);
 			spin_unlock(&inode->i_lock);
@@ -1803,6 +1811,7 @@ int insert_inode_locked(struct inode *inode)
 		}
 		if (likely(!old)) {
 			spin_lock(&inode->i_lock);
+			iobj_get(inode);
 			inode->i_state |= I_NEW | I_CREATING;
 			hlist_add_head_rcu(&inode->i_hash, head);
 			spin_unlock(&inode->i_lock);
-- 
2.49.0


