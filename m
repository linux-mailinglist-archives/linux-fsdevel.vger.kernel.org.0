Return-Path: <linux-fsdevel+bounces-48677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85603AB275B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 May 2025 10:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0786D3BBE9E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 May 2025 08:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9A51A3029;
	Sun, 11 May 2025 08:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFr07TbS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CFF2F2E
	for <linux-fsdevel@vger.kernel.org>; Sun, 11 May 2025 08:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746952602; cv=none; b=S5t/iDACDzZ9d8ZEUrd215+sJPrdb7MtFgZxyYnkXaerswgwbWXTAtwpsUFqIiCm129UKsRuydF9z8SQYD3RKesQg9nYb48la8WG1onYpM78hPkXcYzpXk8SbuoWzGAE1wPIbqrm3ufwRiUbPfxbgaoRFGw7zPbzGe8tL+uOkNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746952602; c=relaxed/simple;
	bh=gKl65MoblkWxE/LPnp6mHtW9ORyFMc2vGtyWfLrhnyk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=USigt8Sc8d22emY3ZKK/iB/2KKswDYg3CI8L3ATHjotypC2ZiqUr+Mxr99NJmACpvHeeS1Dio6QdPxSxlAjJTZMXFg+EMpfTub1kIviIMFPZpGwNo5nrjPWVbHGVsTU9t63jvqlfRMeUnAhqopOYdk5H3yP83Azm07cNAW2tRtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFr07TbS; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2301ac32320so2846225ad.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 May 2025 01:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746952599; x=1747557399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OIFeWtsnSci1S3qJd5rwip5C+pMwTRaGPy977xetq28=;
        b=FFr07TbS4lYpXsDosXxtA+Gito0V1D4YMbiV4BuyjgIfBeIn1HHaKJIYwtGfj1mhdT
         5ax6vcAWFPGr19I1RDE+pWbE1HjCbTdXWmBhMQyqPo8hoLEkeWbHYyN2LFHAxImrFgY5
         aRMAsvpBHGNo2F63vOuxhn+BqCGIqTWiCxd7RxA48hNFfaRyKklyzovEAmOJAujYFof4
         9VunnERzBD68XzrDE1uIjrOXiXs2Tv949F8C29rXs+fPjc368xTezP200yG/EUs/8CID
         rLsj2aAeaMcdpWMuhlIusehRrxq0BfotRS6bJfBVfAhjiwN/x+x/VV/p/vegoQl6ZUH4
         6SUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746952599; x=1747557399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OIFeWtsnSci1S3qJd5rwip5C+pMwTRaGPy977xetq28=;
        b=QpVenF8NDGm1IeoBuxEPep3uduYmoKr0UyiYVptSyqH+ckEA6dHLXSGu0i//sybdc6
         os9mlqTRnEp/kvGWKTsgZsZU33beS8E/JBaPSidzYr53TJ1qiUPtRmo1mKOBLfSKrE8v
         8n+WvUECYfo4l/9xNrFVW6/bUY8+Ewaq1sHQ6IN+fxXZ1lNe0O6x263GIUvZVeWgogb/
         BXuklbWg8qXzFjQq4k/KCfuXLndJcii+ZsghH0/wXUdJjji6a/L9sYpBJ0VaRRBSw3ak
         +zemNtPDvN/Le1AnNqY5p4b3QALvgeEvBqJwhN3YYikzlAyxLs/5d6XRh8RIgbT1xoz9
         wmHA==
X-Gm-Message-State: AOJu0YzbEa7eekFhHGht18To6c5zbaV60XHCvtBMhLtcV8RavA0FUtyp
	uPnRkrW983feotLJK0vQv4l3m1MJ33Q95is9LAwoqqZiLE/hWXEq
X-Gm-Gg: ASbGncsyuTw4tgw1bCsiyXZZPeG9ETedJ6vQ6o9kM3dg3GR8AUJvVXUNG4nBXz75UEK
	1AC6dO6Jev8L/pLhkNzylNjJKtGiK0ZGEdY36gcXScWTKo+oiOa4tZyDhAM4COwa3YkvKAN1ePb
	iRu6xbOaz02gPKjM/NAkFMGZ+Sx63QjyDN/PPKma4B/h/Jd4A5aX/9szd87LPaTGwXT3TObC/53
	dk3+0muR0y0LOYPoSlbX+rZMCl0mtW9FpilhjlOAWZYjpQK86Pocbd4f47X7ZAtawHHC4AjfZKR
	gyMZHK1n8hGWnAfyqb7/DOMKsr+BToTa5nq6xYkqQjIjdPHQt3kGqzKj+Sll0IP0FBsi5F8m/kI
	mFyNzN7c=
X-Google-Smtp-Source: AGHT+IEzysGTc06mklUQdLXGdvr9JTVPsWueDYYZhg+fEoKOm825deovjO+QiTD7li0JVZ18Q7g0yQ==
X-Received: by 2002:a17:903:182:b0:22e:6cc6:cf77 with SMTP id d9443c01a7336-22fc91cec2bmr158528005ad.53.1746952599070;
        Sun, 11 May 2025 01:36:39 -0700 (PDT)
Received: from localhost.localdomain ([116.232.227.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc827063fsm43073215ad.115.2025.05.11.01.36.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 11 May 2025 01:36:38 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH] vfs: Add sysctl vfs_cache_pressure_denom for bulk file operations
Date: Sun, 11 May 2025 16:36:24 +0800
Message-Id: <20250511083624.9305-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On our HDFS servers with 12 HDDs per server, a HDFS datanode[0] startup
involves scanning all files and caching their metadata (including dentries
and inodes) in memory. Each HDD contains approximately 2 million files,
resulting in a total of ~20 million cached dentries after initialization.

To minimize dentry reclamation, we set vfs_cache_pressure to 1. Despite
this configuration, memory pressure conditions can still trigger
reclamation of up to 50% of cached dentries, reducing the cache from 20
million to approximately 10 million entries. During the subsequent cache
rebuild period, any HDFS datanode restart operation incurs substantial
latency penalties until full cache recovery completes.

To maintain service stability, we need to preserve more dentries during
memory reclamation. The current minimum reclaim ratio (1/100 of total
dentries) remains too aggressive for our workload. This patch introduces
vfs_cache_pressure_denom for more granular cache pressure control. The
configuration [vfs_cache_pressure=1, vfs_cache_pressure_denom=10000]
effectively maintains the full 20 million dentry cache under memory
pressure, preventing datanode restart performance degradation.

Link: https://hadoop.apache.org/docs/r1.2.1/hdfs_design.html#NameNode+and+DataNodes [0]

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 Documentation/admin-guide/sysctl/vm.rst | 32 ++++++++++++++++---------
 fs/dcache.c                             | 11 ++++++++-
 2 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index 8290177b4f75..d385985b305f 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -75,6 +75,7 @@ Currently, these files are in /proc/sys/vm:
 - unprivileged_userfaultfd
 - user_reserve_kbytes
 - vfs_cache_pressure
+- vfs_cache_pressure_denom
 - watermark_boost_factor
 - watermark_scale_factor
 - zone_reclaim_mode
@@ -1017,19 +1018,28 @@ vfs_cache_pressure
 This percentage value controls the tendency of the kernel to reclaim
 the memory which is used for caching of directory and inode objects.
 
-At the default value of vfs_cache_pressure=100 the kernel will attempt to
-reclaim dentries and inodes at a "fair" rate with respect to pagecache and
-swapcache reclaim.  Decreasing vfs_cache_pressure causes the kernel to prefer
-to retain dentry and inode caches. When vfs_cache_pressure=0, the kernel will
-never reclaim dentries and inodes due to memory pressure and this can easily
-lead to out-of-memory conditions. Increasing vfs_cache_pressure beyond 100
-causes the kernel to prefer to reclaim dentries and inodes.
+At the default value of vfs_cache_pressure=vfs_cache_pressure_denom the kernel
+will attempt to reclaim dentries and inodes at a "fair" rate with respect to
+pagecache and swapcache reclaim.  Decreasing vfs_cache_pressure causes the
+kernel to prefer to retain dentry and inode caches. When vfs_cache_pressure=0,
+the kernel will never reclaim dentries and inodes due to memory pressure and
+this can easily lead to out-of-memory conditions. Increasing vfs_cache_pressure
+beyond vfs_cache_pressure_denom causes the kernel to prefer to reclaim dentries
+and inodes.
 
-Increasing vfs_cache_pressure significantly beyond 100 may have negative
-performance impact. Reclaim code needs to take various locks to find freeable
-directory and inode objects. With vfs_cache_pressure=1000, it will look for
-ten times more freeable objects than there are.
+Increasing vfs_cache_pressure significantly beyond vfs_cache_pressure_denom may
+have negative performance impact. Reclaim code needs to take various locks to
+find freeable directory and inode objects. When vfs_cache_pressure equals
+(10 * vfs_cache_pressure_denom), it will look for ten times more freeable
+objects than there are.
 
+Note: This setting should always be used together with vfs_cache_pressure_denom.
+
+vfs_cache_pressure_denom
+========================
+
+Defaults to 100 (minimum allowed value). Requires corresponding
+vfs_cache_pressure setting to take effect.
 
 watermark_boost_factor
 ======================
diff --git a/fs/dcache.c b/fs/dcache.c
index bd5aa136153a..ed46818c151c 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -74,10 +74,11 @@
  * arbitrary, since it's serialized on rename_lock
  */
 static int sysctl_vfs_cache_pressure __read_mostly = 100;
+static int sysctl_vfs_cache_pressure_denom __read_mostly = 100;
 
 unsigned long vfs_pressure_ratio(unsigned long val)
 {
-	return mult_frac(val, sysctl_vfs_cache_pressure, 100);
+	return mult_frac(val, sysctl_vfs_cache_pressure, sysctl_vfs_cache_pressure_denom);
 }
 EXPORT_SYMBOL_GPL(vfs_pressure_ratio);
 
@@ -225,6 +226,14 @@ static const struct ctl_table vm_dcache_sysctls[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 	},
+	{
+		.procname	= "vfs_cache_pressure_denom",
+		.data		= &sysctl_vfs_cache_pressure_denom,
+		.maxlen		= sizeof(sysctl_vfs_cache_pressure_denom),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ONE_HUNDRED,
+	},
 };
 
 static int __init init_fs_dcache_sysctls(void)
-- 
2.43.5


