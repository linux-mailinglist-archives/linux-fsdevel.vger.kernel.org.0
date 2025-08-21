Return-Path: <linux-fsdevel+bounces-58495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B7EB2EA02
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B78023BA8C9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67B51E7C23;
	Thu, 21 Aug 2025 01:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="homDUS44"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D1A1632DD
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 01:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738396; cv=none; b=Z9OscTkfIsdqIEbGPGvW+RgBRjENWp0NS71Q6GQxpSFUCn7pDtv8caTH8jR5eq9gesZSm4n+jhVvE8mF0FAo/MxCtGzXNkkXICPxf/IbmacKgiiYhwTaTTDWwq48FZtGrQyZqP2Ypn7D8ol8P1P8qcuEDqkCkwzBCn919hgYEVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738396; c=relaxed/simple;
	bh=MrzCU1qYdhX0hjjeL8Q/zqHcIPfky/0sRFUJ7vWfgyw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YWrqj2HEulwSyyuBMWQbSEXHoBfiqTVcbU/WclWE6Zhhc0QEjqvbRBsso5u3JmTbLAbbw/+DsW6wfh7e13yB171C5ekiwp34h3yZZMgwgbBifPRqtaxZX/BgguAZyBqh8nKJV+OvTnqho7plUugjdfDQFsfwWz6UPOGWGj4u9X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=homDUS44; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED11C4CEE7;
	Thu, 21 Aug 2025 01:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755738394;
	bh=MrzCU1qYdhX0hjjeL8Q/zqHcIPfky/0sRFUJ7vWfgyw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=homDUS44Dzc72tkccqiZs42JtgZ5debpjt+n5aa00mWWYaLtKdcvpOxSabEI+gsf7
	 9aUcUtqV3KZPSOi388T3FXCHjxuuDfuBPLeRFN7qMQH7TS+kYLQ+TD6AZmiWGRQtpu
	 gk66TlGnOoEbw2eoZnbqGFOelBSVy4nm/qmbsz74PnIAOcFpJD22rOqjceIuizbBs2
	 3D3nX/8P0sabwe0erjtgLfm5tr6KGEUx3gkHF5Y9sJizBOtS0ECJGtHiZ7IriWzb/b
	 tuARPQl6qv+pcNfC84DcAuwHjJycoSIdvA2/vlF4SGSB7n6OJUGhRhO1gyg9BfbpDY
	 m1xJ/mhQ3dNgw==
Date: Wed, 20 Aug 2025 18:06:34 -0700
Subject: [PATCH 20/21] libfuse: add strictatime/lazytime mount options
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: John@groves.net, joannelkoong@gmail.com, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, neal@gompa.dev
Message-ID: <175573711660.19163.13606812626830633788.stgit@frogsfrogsfrogs>
In-Reply-To: <175573711192.19163.9486664721161324503.stgit@frogsfrogsfrogs>
References: <175573711192.19163.9486664721161324503.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

fuse+iomap leaves the kernel completely in charge of handling
timestamps.  Add the lazytime and strictatime mount options so that
fuse+iomap filesystems can take advantage of those options.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/mount.c |   18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)


diff --git a/lib/mount.c b/lib/mount.c
index 140489fa74bb55..01d473902d50d7 100644
--- a/lib/mount.c
+++ b/lib/mount.c
@@ -117,9 +117,16 @@ static const struct fuse_opt fuse_mount_opts[] = {
 	FUSE_OPT_KEY("dirsync",			KEY_KERN_FLAG),
 	FUSE_OPT_KEY("noatime",			KEY_KERN_FLAG),
 	FUSE_OPT_KEY("nodiratime",		KEY_KERN_FLAG),
-	FUSE_OPT_KEY("nostrictatime",		KEY_KERN_FLAG),
 	FUSE_OPT_KEY("symfollow",		KEY_KERN_FLAG),
 	FUSE_OPT_KEY("nosymfollow",		KEY_KERN_FLAG),
+#ifdef MS_LAZYTIME
+	FUSE_OPT_KEY("lazytime",		KEY_KERN_FLAG),
+	FUSE_OPT_KEY("nolazytime",		KEY_KERN_FLAG),
+#endif
+#ifdef MS_STRICTATIME
+	FUSE_OPT_KEY("strictatime",		KEY_KERN_FLAG),
+	FUSE_OPT_KEY("nostrictatime",		KEY_KERN_FLAG),
+#endif
 	FUSE_OPT_END
 };
 
@@ -190,11 +197,18 @@ static const struct mount_flags mount_flags[] = {
 	{"noatime", MS_NOATIME,	    1},
 	{"nodiratime",	    MS_NODIRATIME,	1},
 	{"norelatime",	    MS_RELATIME,	0},
-	{"nostrictatime",   MS_STRICTATIME,	0},
 	{"symfollow",	    MS_NOSYMFOLLOW,	0},
 	{"nosymfollow",	    MS_NOSYMFOLLOW,	1},
 #ifndef __NetBSD__
 	{"dirsync", MS_DIRSYNC,	    1},
+#endif
+#ifdef MS_LAZYTIME
+	{"lazytime",	    MS_LAZYTIME,	1},
+	{"nolazytime",	    MS_LAZYTIME,	0},
+#endif
+#ifdef MS_STRICTATIME
+	{"strictatime",	    MS_STRICTATIME,	1},
+	{"nostrictatime",   MS_STRICTATIME,	0},
 #endif
 	{NULL,	    0,		    0}
 };


