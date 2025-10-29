Return-Path: <linux-fsdevel+bounces-66081-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 115E7C17BF6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE5F73AA9BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8C92D979F;
	Wed, 29 Oct 2025 01:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p75xcRwP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B0E1F0E32;
	Wed, 29 Oct 2025 01:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699934; cv=none; b=u6hixB+UY6khqgJrKOkPyuDGyrzNUCAcuxLJqNem6sMJSWImdh0TOlHwIC+ULVdi1iqwADFjWaACYDV6BrR4RRRwNBn+Nv0YHd3gD1JsNt7PK5MOlfmLpQ+rXJVMn21Im8lk/BqJxRLxapexRNxHGFLmAwni/lDp7b5kjs3CkYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699934; c=relaxed/simple;
	bh=FH6ODyJsYUv8YKrVXc31OxDGkjUJjRlW6xBoMclfkSI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AbglF9h9d1d3kpaecenb+isHqF1z/YaZwFcnNMzz+Qhb/M3wPDX+fjtngzRZFpmPbh0PjtxpaUzmLaySA7gWuzb7R0ef1dvhtEEyfCeRyU520w55MCCmynK8pq3MKCJLu/+yDVhNN8Lt6SRdVjeB4zDAz2CDJtuzG3zdIFS14kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p75xcRwP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5310DC4CEE7;
	Wed, 29 Oct 2025 01:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761699934;
	bh=FH6ODyJsYUv8YKrVXc31OxDGkjUJjRlW6xBoMclfkSI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=p75xcRwPungjzy+9uUtJDkV13DG1mHiyEvxcOOSy7M0B4gL+ODrpa3BLNNjYbIZ8A
	 VqCCUMF/PKzQ/cf+RocDPfO9jAenJFTpOYW95/8BAjH0nSIUfKvCgrp0cGpUNVuzEE
	 FGQfWvIRZe05JJGTEKlkoyeTuFy2/86Uuij6WMiuvMA+W+rHrEulo9pXBlw+zzJbWz
	 35iCkqERipf4kLQs209TIREHFLkeuROh1AJqbn+ACw8Nv5f8mq/s4upogATMlg+vxU
	 SzJa73XRaks71zfzoIT4NpkWyPOuvSHPX2+lFMA6brMF1wOHAMhGr6mjvfuqv2wOtP
	 JkQ/hMIZ7MZfA==
Date: Tue, 28 Oct 2025 18:05:33 -0700
Subject: [PATCH 1/4] libfuse: add strictatime/lazytime mount options
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, miklos@szeredi.hu, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <176169814339.1428390.3706681659823223489.stgit@frogsfrogsfrogs>
In-Reply-To: <176169814307.1428390.11550104537543281678.stgit@frogsfrogsfrogs>
References: <176169814307.1428390.11550104537543281678.stgit@frogsfrogsfrogs>
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
index c82fd4c293ce66..1b20c4eab92d46 100644
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
 
@@ -189,11 +196,18 @@ static const struct mount_flags mount_flags[] = {
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


