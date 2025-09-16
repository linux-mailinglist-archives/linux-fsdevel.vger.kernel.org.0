Return-Path: <linux-fsdevel+bounces-61580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9B4B589FC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 275193AC66F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD061CD2C;
	Tue, 16 Sep 2025 00:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYqki8Vq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8792DC763
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 00:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983620; cv=none; b=N0SOKENTQXWqGMJeFKbbUB6aYaNo8G5mjS6MuUubUDin8ij5KUz4ZXt0Kz7u8ERt3F8TRBHActzvt13oGH+jBT5sXKWXYrh7jUfbzTh96b9u6FqZhCyglWJka1rK5XDXrg00dUGmkL0ARWQ2bQebkW+V0sJ5bKxAQspF2+irDes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983620; c=relaxed/simple;
	bh=MrzCU1qYdhX0hjjeL8Q/zqHcIPfky/0sRFUJ7vWfgyw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JdGqawvv35nd55smNzflJ+KiJw51cPXYhkURznqX6VoBp/CGhivecvLtm0sAJpF3Z5Y/G3Mgma4uc/+r/rRtRR3qtTl8td7dlRUKoo+K2gacML/qRYziX7/5jcgVR3agYyvq3XjdDYv6u/5o273vhdi0yQoTdUMzpsph2QhMras=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYqki8Vq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DF0DC4CEF1;
	Tue, 16 Sep 2025 00:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757983620;
	bh=MrzCU1qYdhX0hjjeL8Q/zqHcIPfky/0sRFUJ7vWfgyw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=DYqki8VqYsP6lJKwk6KOQ43LQP0IBmz1fSg80/trn6mOXa48T8V+s7WY9w+mm0FmB
	 HN7TvsSzL1vrspc8jy1urYvylcjrF2tI308mjK7piSeO7Er7RZlv0eXuhYbQF5kyC4
	 at0+88WwPBzgTKmdC4VLiVjIRC7TXl9XsCvJ+VKzk2EWWJ+TZ+pa0NquoLfQD7rITP
	 9snffBTRZpVSL0XqULFiqCYUHxFp+/34CpX0yhxc8gHXncGilR2MsSLn/RwyTRX/D3
	 MJHWxTXYWbKYjrgorzVKa5oUrY38x1DWGUqt+yZDE4BFn4lrVQPRFWLxfEa0aqIBii
	 ZoiWikUH3NSWw==
Date: Mon, 15 Sep 2025 17:46:59 -0700
Subject: [PATCH 1/4] libfuse: add strictatime/lazytime mount options
From: "Darrick J. Wong" <djwong@kernel.org>
To: bschubert@ddn.com, djwong@kernel.org
Cc: John@groves.net, neal@gompa.dev, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com
Message-ID: <175798155260.387738.12679398499806621003.stgit@frogsfrogsfrogs>
In-Reply-To: <175798155228.387738.1956568770138953630.stgit@frogsfrogsfrogs>
References: <175798155228.387738.1956568770138953630.stgit@frogsfrogsfrogs>
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


