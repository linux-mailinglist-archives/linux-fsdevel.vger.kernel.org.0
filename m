Return-Path: <linux-fsdevel+bounces-67045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DD7C338B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 01:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C94018953FF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 00:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC98243387;
	Wed,  5 Nov 2025 00:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWULER6r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2B023EAA1;
	Wed,  5 Nov 2025 00:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762304050; cv=none; b=aD4slcLE3Zc+TxLvhDXwm4B+MCiDQaLTnVnJaKoHLSgyBoxa7K+pC+98PiyW1TVZV9yg7uiPpdVg3w2qz5cwm6QHHzi26zxEVq4kY0IOxKJupP9qdSaQXSX1Qdpck4ruHoGDjU4n1LZr9o5AHNXaYG/E1QBuDnPD0oMe9Cp70s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762304050; c=relaxed/simple;
	bh=QFXsMDK95cVPH+qHVnRuvqxxlK5NXIAHjxQZWdqpkAU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E/91ZAeM1+oqIi/hwqUVwewv77AlhoVmpYvqwyR7eS4R2sMTtTMW52BboYP3NWN82tf1bgjVSXonngPCCMLqFyEdNyEbUeKmXUjO26lNUSFQvRB0T6jyMiCYyAyc8TNm8Vxd2ueM0P+YKIQVkMSIgz1jUcvejyZzVJIkOdjRC1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWULER6r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B180FC4CEF7;
	Wed,  5 Nov 2025 00:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762304049;
	bh=QFXsMDK95cVPH+qHVnRuvqxxlK5NXIAHjxQZWdqpkAU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=jWULER6rLNVsAk4rZcsM90Pz0IaAs0Mg36qgkmepj/zyzXUaXl5CAvvG91uk+/XLd
	 TyzcY6bOPVdtW4VZnCAGATlpDS8i0ZX/LnYYt6voxg+TMacAb0cHIYvIOXE8BcoNXC
	 WfEWjuN5Orf2hmP01G1OP5fmOPeneJihp1pOPE/MiTNSoMVt7d2P5O6C4yOrlsC5r5
	 AUxds4wFAYEzTocRH+OlRVHbx9i4cHQDzWVQLMTrcLQ6PsjtOjjXWPMp3at9Nlc/0V
	 D0JeEDcsxPwXYMYTpY0bQw9Bns7TNYvbGKiapEGzQXlgf03pYS61+L3kbek+fMtC67
	 +W/rN/udeH85Q==
Date: Tue, 04 Nov 2025 16:54:09 -0800
Subject: [PATCH 22/22] xfs: charge healthmon event objects to the memcg of the
 listening process
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, cem@kernel.org
Cc: hch@lst.de, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <176230366171.1647136.9212032052914661024.stgit@frogsfrogsfrogs>
In-Reply-To: <176230365543.1647136.3601811429298452884.stgit@frogsfrogsfrogs>
References: <176230365543.1647136.3601811429298452884.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Event objects are created in the context of whichever process
experienced the health event, which means that we currently charge that
process' memory cgroup controller for that object.  This isn't entirely
fair to that process, because it's being charged for memory that solely
benefits whatever's using the healthmon fd (xfs_healer).

Therefore, save the memcg that was in place when the healthmon fd was
created (which we assume is xfs_healer) and make sure the objects are
charged to that memcg.  This also enables sysadmins to constrain the
kernel memory usage of xfs_healer through memcgs.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_healthmon.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)


diff --git a/fs/xfs/xfs_healthmon.c b/fs/xfs/xfs_healthmon.c
index a8ea6483ca98fb..def4de5f6bc543 100644
--- a/fs/xfs/xfs_healthmon.c
+++ b/fs/xfs/xfs_healthmon.c
@@ -67,6 +67,9 @@ struct xfs_healthmon {
 	struct xfs_healthmon_event	*first_event;
 	struct xfs_healthmon_event	*last_event;
 
+	/* charge event object usage to this memory cgroup */
+	struct mem_cgroup		*memcg;
+
 	/* live update hooks */
 	struct xfs_shutdown_hook	shook;
 	struct xfs_health_hook		hhook;
@@ -500,6 +503,7 @@ xfs_healthmon_metadata_hook(
 	struct xfs_health_update_params	*hup = data;
 	struct xfs_healthmon		*hm;
 	struct xfs_healthmon_event	*event;
+	struct mem_cgroup		*old_memcg;
 	enum xfs_health_update_type	type = action;
 	unsigned int			mask = 0;
 	int				error;
@@ -511,6 +515,7 @@ xfs_healthmon_metadata_hook(
 		return NOTIFY_DONE;
 
 	mutex_lock(&hm->lock);
+	old_memcg = set_active_memcg(hm->memcg);
 
 	trace_xfs_healthmon_metadata_hook(hm->mp, action, hup, hm->events,
 			hm->lost_prev_event);
@@ -586,6 +591,7 @@ xfs_healthmon_metadata_hook(
 		goto out_event;
 
 out_unlock:
+	set_active_memcg(old_memcg);
 	mutex_unlock(&hm->lock);
 	return NOTIFY_DONE;
 out_event:
@@ -602,11 +608,13 @@ xfs_healthmon_shutdown_hook(
 {
 	struct xfs_healthmon		*hm;
 	struct xfs_healthmon_event	*event;
+	struct mem_cgroup		*old_memcg;
 	int				error;
 
 	hm = container_of(nb, struct xfs_healthmon, shook.shutdown_hook.nb);
 
 	mutex_lock(&hm->lock);
+	old_memcg = set_active_memcg(hm->memcg);
 
 	trace_xfs_healthmon_shutdown_hook(hm->mp, action, hm->events,
 			hm->lost_prev_event);
@@ -626,6 +634,7 @@ xfs_healthmon_shutdown_hook(
 		kfree(event);
 
 out_unlock:
+	set_active_memcg(old_memcg);
 	mutex_unlock(&hm->lock);
 	return NOTIFY_DONE;
 }
@@ -640,12 +649,14 @@ xfs_healthmon_media_error_hook(
 	struct xfs_healthmon		*hm;
 	struct xfs_healthmon_event	*event;
 	struct xfs_media_error_params	*p = data;
+	struct mem_cgroup		*old_memcg;
 	enum xfs_healthmon_domain	domain = 0; /* shut up gcc */
 	int				error;
 
 	hm = container_of(nb, struct xfs_healthmon, mhook.error_hook.nb);
 
 	mutex_lock(&hm->lock);
+	old_memcg = set_active_memcg(hm->memcg);
 
 	trace_xfs_healthmon_media_error_hook(p, hm->events,
 			hm->lost_prev_event);
@@ -677,6 +688,7 @@ xfs_healthmon_media_error_hook(
 		kfree(event);
 
 out_unlock:
+	set_active_memcg(old_memcg);
 	mutex_unlock(&hm->lock);
 	return NOTIFY_DONE;
 }
@@ -691,6 +703,7 @@ xfs_healthmon_file_ioerror_hook(
 	struct xfs_healthmon		*hm;
 	struct xfs_healthmon_event	*event;
 	struct xfs_file_ioerror_params	*p = data;
+	struct mem_cgroup		*old_memcg;
 	enum xfs_healthmon_type		type = 0;
 	int				error;
 
@@ -709,6 +722,7 @@ xfs_healthmon_file_ioerror_hook(
 	}
 
 	mutex_lock(&hm->lock);
+	old_memcg = set_active_memcg(hm->memcg);
 
 	trace_xfs_healthmon_file_ioerror_hook(hm->mp, action, p, hm->events,
 			hm->lost_prev_event);
@@ -748,6 +762,7 @@ xfs_healthmon_file_ioerror_hook(
 		kfree(event);
 
 out_unlock:
+	set_active_memcg(old_memcg);
 	mutex_unlock(&hm->lock);
 	return NOTIFY_DONE;
 }
@@ -1188,6 +1203,7 @@ xfs_healthmon_release(
 	xfs_healthmon_free_events(hm);
 	if (hm->outbuf.size)
 		kfree(hm->outbuf.buffer);
+	mem_cgroup_put(hm->memcg);
 	kfree(hm);
 
 	return 0;
@@ -1367,6 +1383,7 @@ xfs_ioc_health_monitor(
 		return -ENOMEM;
 	hm->mp = mp;
 	hm->format = hmo.format;
+	hm->memcg = get_mem_cgroup_from_mm(current->mm);
 
 	/*
 	 * Since we already got a ref to the module, take a reference to the
@@ -1443,6 +1460,7 @@ xfs_ioc_health_monitor(
 	xfs_health_hook_disable();
 	mutex_destroy(&hm->lock);
 	xfs_healthmon_free_events(hm);
+	mem_cgroup_put(hm->memcg);
 	kfree(hm);
 	return ret;
 }


