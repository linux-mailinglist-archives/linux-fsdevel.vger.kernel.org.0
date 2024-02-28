Return-Path: <linux-fsdevel+bounces-13044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 882D286A79E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 05:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F79A1F24E68
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 04:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B4C208CF;
	Wed, 28 Feb 2024 04:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="AhMEiNXp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A919200B7
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 04:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709094546; cv=none; b=kU3iarTOvOAiXWaTd/yo5UeIovtq8J1944ejkpic7ljf6OzMw2BcRs+MK9trVc5ikYhG1/KP3xtVmUkRd6669z5rKamwkhDqcgXCZgqrCE8s00oO+71QIuxowm30tsD73qK3CEUsoRNO/JpPL6e824KJcbgZe90GOmeNeleBnjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709094546; c=relaxed/simple;
	bh=RnJbLG/wCSkflRTJ9DXhmGmjhg+znrGK9pG1gnnWZYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fwQNF6qarwvBe1C+Nw7vGsYet0bQFK265pMgHg6VinYDN+lwNFiC38QcY0PtV91cAjc3CwEdwqjCoDCP3UUkvITaOhoaZgdHFIQDj0O4BUrRn4PPEB+42PdINZTubQ3XSz2kh51vU5G9Ipcbz3w46Y+cYJj302JFfmS5vhQFifY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=AhMEiNXp; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e55731af5cso743534b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 20:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1709094543; x=1709699343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GvLGVDkXeXw8ikqc8FjmbAfxHoB2MC+jPP1CVgaet+0=;
        b=AhMEiNXp7v91JBCAj4iUjFXE55EOMk+6JS8JLjUygRiADj/AwgGDoccMsiuTQf+DAG
         yv3ZpXDxT1KnEW4rcrZQQNP+Ow6qmNrSCE7XOcPco2dao6vhGEAyvqIMaIUR48bsJc8F
         VakkQTMPvN6U2hdsBwSQlZyV2ZDessKTa8WxzCFjIeTWNeoz+d6fR2HPecd9V25ANPi+
         gXOVoTpKMMDAthR8TpB1xwvE3SP5jxWOMIxJcbe56UQrri6mfd5/a8yuaFHXgByirNYT
         iYMyALHz0G3T2fJxN+MT7sK086w+wdUWPHqY76wlupRGOXSMFmteU1te2eA0/NTYilE9
         zapg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709094543; x=1709699343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GvLGVDkXeXw8ikqc8FjmbAfxHoB2MC+jPP1CVgaet+0=;
        b=K069DJfbqdrac9kpHfk4hEP73B8wiKKQyDhAO2alq7MfGn8uE+a+tdzhFaLmiGGogM
         c6v+xoIdDvXAbPVHeICVt3S8AoL/76t4GzYTmQCT+HrFlOGNoBe4eCw0B+KRT9LM8MzD
         iiPpc1BCsBdQbCAj+ZC1xF1gS7ODN+1PL+N4ws16SnwIOCeic0GWoDVJ9ej7CQ7ICGqh
         CkWEHDBemYSKbIk+/Q4Lv4gvJMTfmS8jybzLDSRywA1WAupPL/bwgCn3uchV2B43m+bK
         kM/vKyjaXkkGefCQ1V5FBy1NGjJMleESmQ3ATvykWqWRkGfYUvWtd10WUQei/F9Lf52l
         g61w==
X-Forwarded-Encrypted: i=1; AJvYcCUbTxUKZRR8qijfV1YAifXWQpT6qJnqihj8Nf6mTfC+saBTSgyqqD9UvNUxS4rW1sTb7ZgPTdsG75WvVWoyCE+/b+tB686IhjK9auCiYw==
X-Gm-Message-State: AOJu0Yxt1U375Bq7NEx6C8QE003+HFnX8SiOloouaUIOMtgAoPQOcT/9
	viHBy+9jdzwoSjCEUGZIZwFQwv8J+l9HZaxk0NsjJhy1mtYtss2bzVK3RwkLO5w=
X-Google-Smtp-Source: AGHT+IHGltB03n+8ycK0QOrhos4kvlvRUvr4hRXHQgj7JMMy/aENjVTtsGay5RSsDGC2fJ6Qcd4f4w==
X-Received: by 2002:a05:6a00:80df:b0:6e5:571d:a60a with SMTP id ei31-20020a056a0080df00b006e5571da60amr2148696pfb.5.1709094542767;
        Tue, 27 Feb 2024 20:29:02 -0800 (PST)
Received: from dread.disaster.area (pa49-181-247-196.pa.nsw.optusnet.com.au. [49.181.247.196])
        by smtp.gmail.com with ESMTPSA id i2-20020a056a00004200b006e558416202sm861787pfk.148.2024.02.27.20.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 20:29:02 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.96)
	(envelope-from <dave@fromorbit.com>)
	id 1rfBYy-00CVVl-0F;
	Wed, 28 Feb 2024 15:28:59 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.97)
	(envelope-from <dave@devoid.disaster.area>)
	id 1rfBYx-00000003Wwm-2O5b;
	Wed, 28 Feb 2024 15:28:59 +1100
From: Dave Chinner <david@fromorbit.com>
To: linux-xfs@vger.kernel.org
Cc: djwong@kernel.org,
	jlayton@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] xfs: stop advertising SB_I_VERSION
Date: Wed, 28 Feb 2024 15:28:59 +1100
Message-ID: <20240228042859.841623-1-david@fromorbit.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Chinner <dchinner@redhat.com>

The redefinition of how NFS wants inode->i_version to be updated is
incomaptible with the XFS i_version mechanism. The VFS now wants
inode->i_version to only change when ctime changes (i.e. it has
become a ctime change counter, not an inode change counter). XFS has
fine grained timestamps, so it can just use ctime for the NFS change
cookie like it still does for V4 XFS filesystems.

We still want XFS to update the inode change counter as it currently
does, so convert all the code that checks SB_I_VERSION to check for
v5 format support. Then we can remove the SB_I_VERSION flag from the
VFS superblock to indicate that inode->i_version is not a valid
change counter and should not be used as such.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 fs/xfs/libxfs/xfs_trans_inode.c | 15 +++++----------
 fs/xfs/xfs_iops.c               | 16 +++-------------
 fs/xfs/xfs_super.c              |  8 --------
 3 files changed, 8 insertions(+), 31 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_trans_inode.c b/fs/xfs/libxfs/xfs_trans_inode.c
index 70e97ea6eee7..8071aefad728 100644
--- a/fs/xfs/libxfs/xfs_trans_inode.c
+++ b/fs/xfs/libxfs/xfs_trans_inode.c
@@ -97,17 +97,12 @@ xfs_trans_log_inode(
 
 	/*
 	 * First time we log the inode in a transaction, bump the inode change
-	 * counter if it is configured for this to occur. While we have the
-	 * inode locked exclusively for metadata modification, we can usually
-	 * avoid setting XFS_ILOG_CORE if no one has queried the value since
-	 * the last time it was incremented. If we have XFS_ILOG_CORE already
-	 * set however, then go ahead and bump the i_version counter
-	 * unconditionally.
+	 * counter if it is configured for this to occur.
 	 */
-	if (!test_and_set_bit(XFS_LI_DIRTY, &iip->ili_item.li_flags)) {
-		if (IS_I_VERSION(inode) &&
-		    inode_maybe_inc_iversion(inode, flags & XFS_ILOG_CORE))
-			flags |= XFS_ILOG_IVERSION;
+	if (!test_and_set_bit(XFS_LI_DIRTY, &iip->ili_item.li_flags) &&
+	    xfs_has_crc(ip->i_mount)) {
+		inode->i_version++;
+		flags |= XFS_ILOG_IVERSION;
 	}
 
 	iip->ili_dirty_flags |= flags;
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index be102fd49560..97e792d9d79a 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -584,11 +584,6 @@ xfs_vn_getattr(
 		}
 	}
 
-	if ((request_mask & STATX_CHANGE_COOKIE) && IS_I_VERSION(inode)) {
-		stat->change_cookie = inode_query_iversion(inode);
-		stat->result_mask |= STATX_CHANGE_COOKIE;
-	}
-
 	/*
 	 * Note: If you add another clause to set an attribute flag, please
 	 * update attributes_mask below.
@@ -1044,16 +1039,11 @@ xfs_vn_update_time(
 	struct timespec64	now;
 
 	trace_xfs_update_time(ip);
+	ASSERT(!(flags & S_VERSION));
 
 	if (inode->i_sb->s_flags & SB_LAZYTIME) {
-		if (!((flags & S_VERSION) &&
-		      inode_maybe_inc_iversion(inode, false))) {
-			generic_update_time(inode, flags);
-			return 0;
-		}
-
-		/* Capture the iversion update that just occurred */
-		log_flags |= XFS_ILOG_CORE;
+		generic_update_time(inode, flags);
+		return 0;
 	}
 
 	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_fsyncts, 0, 0, 0, &tp);
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 6ce1e6deb7ec..657ce0423f1d 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1692,10 +1692,6 @@ xfs_fs_fill_super(
 
 	set_posix_acl_flag(sb);
 
-	/* version 5 superblocks support inode version counters. */
-	if (xfs_has_crc(mp))
-		sb->s_flags |= SB_I_VERSION;
-
 	if (xfs_has_dax_always(mp)) {
 		error = xfs_setup_dax_always(mp);
 		if (error)
@@ -1917,10 +1913,6 @@ xfs_fs_reconfigure(
 	int			flags = fc->sb_flags;
 	int			error;
 
-	/* version 5 superblocks always support version counters. */
-	if (xfs_has_crc(mp))
-		fc->sb_flags |= SB_I_VERSION;
-
 	error = xfs_fs_validate_params(new_mp);
 	if (error)
 		return error;
-- 
2.43.0


