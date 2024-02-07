Return-Path: <linux-fsdevel+bounces-10554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D519284C2D2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 03:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8453FB2BDF5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 02:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE15D1BF44;
	Wed,  7 Feb 2024 02:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ikPWdEbJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C864B14A8D
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 02:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707274604; cv=none; b=s/qMZ/AxpvxJPcVsLy3/0VrVtDPO3R2mB1S8kOiBBFeewtFr2y5M5/lsZtglte7MZEbfkFnw3hNgS/pFMeV6bwpmVMBLS7s9V+LU5I+xWLrcfPt0SM6TtiRYnBE60Wbxn0ChRV9ET33htEMgTd0v4bBsG+igfxiokhQ8xeE/PK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707274604; c=relaxed/simple;
	bh=9e/MXJft6EzmQOooxBh8r+OYNdKFUyEkGTtUvjDUC+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ANm29KfIlFXNMFaQGNRr6lAt4vlcbIPdHeJw4Ac9YyeE6yv9PJv9624spiF3fWEV6b4U9yYFl/TGCEW3dPzOCUEOXtN5KyJi9Ol11yNYmMYZCz3Y4Vqy1/F6r3qKp4r9LZr23FnjcFQ7YuG8D6g6oc+ceX0ub8xO3eQSDIobNU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ikPWdEbJ; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707274601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yl2gqkk+sAKRJz4hIi3mHc5lsx+eQ6R4/Q2FflhRIYg=;
	b=ikPWdEbJZ62qfNEl3mHPsRhcLZG2tQXOPfhoGBljkviPkYBOa7syPKDuB3C418Nju9qzlT
	9DahmCfifwaIBw904JDU11GyKcPo53lWb5KHAggWLDsURptBiJ6iBQe+4fWlgQB9WmNtID
	tgg0jHl+ncnuxS5zLbSHUhIn1jEDR50=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	linux-btrfs@vger.kernel.org
Subject: [PATCH v3 6/7] xfs: add support for FS_IOC_GETSYSFSNAME
Date: Tue,  6 Feb 2024 21:56:20 -0500
Message-ID: <20240207025624.1019754-7-kent.overstreet@linux.dev>
In-Reply-To: <20240207025624.1019754-1-kent.overstreet@linux.dev>
References: <20240207025624.1019754-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/xfs/xfs_mount.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index 4a46bc44088f..57fa21ad7912 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -706,6 +706,8 @@ xfs_mountfs(
 	/* enable fail_at_unmount as default */
 	mp->m_fail_unmount = true;
 
+	super_set_sysfs_name_id(mp->m_super);
+
 	error = xfs_sysfs_init(&mp->m_kobj, &xfs_mp_ktype,
 			       NULL, mp->m_super->s_id);
 	if (error)
-- 
2.43.0


