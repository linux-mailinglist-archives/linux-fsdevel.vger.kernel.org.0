Return-Path: <linux-fsdevel+bounces-24286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A5393CCD7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 05:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 399051C21998
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 03:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09F92262B;
	Fri, 26 Jul 2024 03:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="DBkVFoXt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF088442F
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jul 2024 03:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721963162; cv=none; b=GsOi86KqvHQZgBrb2rhTHMSFKAi2I6eLlE/CaIFHlJctVF9omTp1KgUlwSo4KVZULFWWmoE2e2QwMDOTaFXVUXKrytTwtNtOgXEAAT+HVUeLQUrGcE2/SVV10JM+TRR5DPJvoZ6YDovN/AkXETN20P1EIzkTolW/1npsDVlOOQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721963162; c=relaxed/simple;
	bh=quLpI2hmZVxke/lF3DDSHfy9b3cBQdbVSjdUv4HeYak=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CbVdCpmbb2Yx+YCPzB2JgXrrEZtPaUzQXZJN3Erx8FlMWcUpq3JhsktkW4EkhZO7XzhBx1LarTf4NK3FGBTSLdseni3l9PAD1vZ/pBILuMu76mMSt0l8kg8r28pAEsSgMQrLdbOO/pkIjlFq++NSn5N9iuOUx/UpCQ8JPYja79U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=DBkVFoXt; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2cb63ceff6dso400147a91.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 20:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1721963160; x=1722567960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zMy6Wm4Xr4VmqiEPea2U7nMauV7O2Gfn+WgAXgyr3U=;
        b=DBkVFoXtO/VB9UG5jdoMKGqAjuOKUt2cJ1yjOm8MyeeHTTTCea7IjrEy9eePHng4ut
         K/a+Z4qCiVJPn+7FLwmScnrpbbVphPrSN0PrbcorQcvRz1QxMmbBC2OSAY8R8iOil1tz
         GFFxnbhw+VNaV0mVjr0lxUW1aamLvmEMF+B5hMkvKGw2ktO5kZOctwxP+DOIBD2m9XGL
         a7GMwgTpV17b1iGVyR7yWTYS8Wc8Q+5po7K1P8lbWnNw8eQ8HV5A/hDLw7pF7qBfF9yY
         HHXzMfgvCHI7D79apr4fDKbdMRqNy5KAMsqSIHoRL6CLT5F6pM6Id9mdRjZDa+tea4AE
         S4NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721963160; x=1722567960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0zMy6Wm4Xr4VmqiEPea2U7nMauV7O2Gfn+WgAXgyr3U=;
        b=K59lqLsoxuvxSZKaHVdXyVc8IzNa/DZB8wp/0169DBEeVjKe2FImtj2ONUvYaXmPZV
         oJ1krWMirIMLeAZBz+8TNhAwCLmR9IfKtN/nyQfG04NESkP0gW7CYaJl8B1f4PrbUGQS
         zZm8U6QJXt+Y73A25MEk3IgDt/G5qFzEisBpdqbuxK79s9M1DhX/c1Nsdn6JIWjPmskm
         P5d8LVhlQ46ZRp930GYxGv8JtHzsvK2px3xf0LnmsZs14epynrNsUf7zNuYYet9zOvGi
         oEspdzlv66ZRjtTd09lcz8o+klZ9xFFk44stS9RBDOOWLXjSbSfi8kzspDMgoE006UVM
         2oRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHinQSnpdG9bczmyINifJuHhhu0NpeOMBEeS4x1WbYYPek4Bp7g7l4UHQrQPy2JWSvgiZEhjJMSoF7+/KTc86zrVnBx4V2qvzLUCw0iw==
X-Gm-Message-State: AOJu0Yw1wKx4UwJA2MciwBGvSXyP3EPpPVteyo31Zgd8HfLXCmLMYo+Y
	jTYsChBG0vSQV3tU+oXAOKPIlVpoK7j4fJtN6dt1eiFddrP1lQPNzT/z2Sfgppk=
X-Google-Smtp-Source: AGHT+IGpxwOy71N55NwgyOQ41ABsR85yT6e4HPAsYRwjPO/GciuqVW0ATMQ5DpYETORlfje8rrIXtg==
X-Received: by 2002:a17:90b:4b09:b0:2c4:ee14:94a2 with SMTP id 98e67ed59e1d1-2cf238ccadamr5760863a91.27.1721963160112;
        Thu, 25 Jul 2024 20:06:00 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cd8f7692f0sm3435117a91.1.2024.07.25.20.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 20:05:59 -0700 (PDT)
From: Haifeng Xu <haifeng.xu@shopee.com>
To: jack@suse.cz
Cc: axboe@kernel.dk,
	brauner@kernel.org,
	tj@kernel.org,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH v2] fs: don't flush in-flight wb switches for superblocks without cgroup writeback
Date: Fri, 26 Jul 2024 11:05:25 +0800
Message-Id: <20240726030525.180330-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240725084232.bj7apjqqowae575c@quack3>
References: <20240725084232.bj7apjqqowae575c@quack3>
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
Suggested-by: Jan Kara <jack@suse.cz>
---
Changes since v1:
- do the check in cgroup_writeback_umount().
- check the capabilities of bdi.
---
 fs/fs-writeback.c         | 6 +++++-
 fs/super.c                | 2 +-
 include/linux/writeback.h | 4 ++--
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 92a5b8283528..09facd4356d9 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1140,8 +1140,12 @@ int cgroup_writeback_by_id(u64 bdi_id, int memcg_id,
  * rare occurrences and synchronize_rcu() can take a while, perform
  * flushing iff wb switches are in flight.
  */
-void cgroup_writeback_umount(void)
+void cgroup_writeback_umount(struct super_block *sb)
 {
+
+	if (!(sb->s_bdi->capabilities & BDI_CAP_WRITEBACK))
+		return;
+
 	/*
 	 * SB_ACTIVE should be reliably cleared before checking
 	 * isw_nr_in_flight, see generic_shutdown_super().
diff --git a/fs/super.c b/fs/super.c
index 095ba793e10c..acc16450da0e 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -621,7 +621,7 @@ void generic_shutdown_super(struct super_block *sb)
 		sync_filesystem(sb);
 		sb->s_flags &= ~SB_ACTIVE;
 
-		cgroup_writeback_umount();
+		cgroup_writeback_umount(sb);
 
 		/* Evict all inodes with zero refcount. */
 		evict_inodes(sb);
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 112d806ddbe4..d78d3dce4ede 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -217,7 +217,7 @@ void wbc_account_cgroup_owner(struct writeback_control *wbc, struct page *page,
 			      size_t bytes);
 int cgroup_writeback_by_id(u64 bdi_id, int memcg_id,
 			   enum wb_reason reason, struct wb_completion *done);
-void cgroup_writeback_umount(void);
+void cgroup_writeback_umount(struct super_block *sb);
 bool cleanup_offline_cgwb(struct bdi_writeback *wb);
 
 /**
@@ -324,7 +324,7 @@ static inline void wbc_account_cgroup_owner(struct writeback_control *wbc,
 {
 }
 
-static inline void cgroup_writeback_umount(void)
+static inline void cgroup_writeback_umount(struct super_block *sb)
 {
 }
 
-- 
2.25.1


