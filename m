Return-Path: <linux-fsdevel+bounces-31870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E1599C604
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 11:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 966731C22CAC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 09:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED2E15C13F;
	Mon, 14 Oct 2024 09:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLmpB9nT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B781B15B97E;
	Mon, 14 Oct 2024 09:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728898872; cv=none; b=lqStyGq2MX7FIeXtSLeBHeSC8yCbSfetgnKGg4pyxtZetGuBVEjTGeX3pFHgjgO/BzA6WNu1tCEV3bGPu+NZNYpnJYPXvu1bE3Vnh+KrSH83w+A96ZeCSt2HgWJSrN32crYHU5aMwl6bgUBRGI/eR7A/VlhnQo06piY0IkXKZg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728898872; c=relaxed/simple;
	bh=Ai9orcwJKxMB1d2lHTAIh+DXnKUDBg6ZOYAJ/xf+E8A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aVFdcS8pzqN3iHObHEcTU1t59NX2CR4jH4uPxbVPvGvuvpn9LiWzdGy8Bk99sSi6w+vWkXjSLllN5f5IjSElLl97/HwVUmUGCuFUaH+pYdB2kImyK099Vma5GSryjS2KpqnZ2rJ2YT9gdOmkXDMM3rR8WweMhCbFw5OWJQrSPt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLmpB9nT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 490B1C4CEC7;
	Mon, 14 Oct 2024 09:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728898872;
	bh=Ai9orcwJKxMB1d2lHTAIh+DXnKUDBg6ZOYAJ/xf+E8A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MLmpB9nTnCxt6jgwre4JgWJxNQ4qesFfYg03Go/AmVC/75urAyo9fePkw2ag+jFbI
	 A2+6U++bJonh/otTWxQatbi/QJ0tcJjXNBlvuCF0FrJDQrT52YR2EpgVHfZntLzkPs
	 3iK+jZt7kSmqMVQepCxBW88DUKi43wV9MJ0MNBRg7mawW3H90DV+ZsXcMzz0O/k2q+
	 wPd910+Fhz5TVMrR/lRyR5ep54+emVqNrFyWuLihMedNuDjLiyLrfJhO8xz4Za4470
	 9dRAQ3LSKhMKz47PKrzMiA29B2r3IGz/GioVERmJHj53L0xeuEz5V2uyA9CCJHs7PN
	 N5wRHNJOZaRUA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 14 Oct 2024 11:40:58 +0200
Subject: [PATCH v3 3/5] Documentation,ovl: document new file descriptor
 based layers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-work-overlayfs-v3-3-32b3fed1286e@kernel.org>
References: <20241014-work-overlayfs-v3-0-32b3fed1286e@kernel.org>
In-Reply-To: <20241014-work-overlayfs-v3-0-32b3fed1286e@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
 linux-unionfs@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=openpgp-sha256; l=1521; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Ai9orcwJKxMB1d2lHTAIh+DXnKUDBg6ZOYAJ/xf+E8A=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTzPDdcvnH3wk7n+rsK94uPXn82l23/1Huhq+sbz7sd2
 MDwyHhTekcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEFukxMhzcpei0XLH4/P+g
 XaxGHGtXf3k09bBxQfPJ/VrMmwRzHX0Y/od79TwKsI5OKfQ65ldk3Mn4Sye2TO5Aw9YFHhqcu/c
 nMAIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a minimal example how to specify layers via file descriptors.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 Documentation/filesystems/overlayfs.rst | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/filesystems/overlayfs.rst b/Documentation/filesystems/overlayfs.rst
index 3436447123409726cbd78badea2f8b4f002e0640..4c8387e1c88068fa10c640191fe3bcc20587f6b0 100644
--- a/Documentation/filesystems/overlayfs.rst
+++ b/Documentation/filesystems/overlayfs.rst
@@ -440,6 +440,23 @@ For example::
   fsconfig(fs_fd, FSCONFIG_SET_STRING, "datadir+", "/do2", 0);
 
 
+Specifying layers via file descriptors
+--------------------------------------
+
+Since kernel v6.13, overlayfs supports specifying layers via file descriptors in
+addition to specifying them as paths. This feature is available for the
+"datadir+", "lowerdir+", "upperdir", and "workdir+" mount options with the
+fsconfig syscall from the new mount api::
+
+  fsconfig(fs_fd, FSCONFIG_SET_FD, "lowerdir+", NULL, fd_lower1);
+  fsconfig(fs_fd, FSCONFIG_SET_FD, "lowerdir+", NULL, fd_lower2);
+  fsconfig(fs_fd, FSCONFIG_SET_FD, "lowerdir+", NULL, fd_lower3);
+  fsconfig(fs_fd, FSCONFIG_SET_FD, "datadir+", NULL, fd_data1);
+  fsconfig(fs_fd, FSCONFIG_SET_FD, "datadir+", NULL, fd_data2);
+  fsconfig(fs_fd, FSCONFIG_SET_FD, "workdir", NULL, fd_work);
+  fsconfig(fs_fd, FSCONFIG_SET_FD, "upperdir", NULL, fd_upper);
+
+
 fs-verity support
 -----------------
 

-- 
2.45.2


