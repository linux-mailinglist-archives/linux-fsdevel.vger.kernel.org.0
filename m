Return-Path: <linux-fsdevel+bounces-55339-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F36B09820
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DE05A625BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B20B2367A9;
	Thu, 17 Jul 2025 23:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JT2OA+pw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B92233D85
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 23:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795172; cv=none; b=scaKi8kkyAJMs1hMNDMsl+UMiOJ2POAVdp5F9YEv9Lg468uCtUeQZ5kYvCdUwUL82AZRRsGBHElv6PsRcGPYYenZOBxXdepF0CffIR5QPSsfyqUOHZml/HsrEKfnOnomFKrajfP9SHtZ8GqbdTwVP2uxOlT6FX16BOHMJaJUB3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795172; c=relaxed/simple;
	bh=CYUbP5CbZh9UPmZrRuKoDLheSiBNQbpAQNyzSt3QdZE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q0foVbc7ZCqOyuvuNmnM6iwUIBntSYJfXRzVOdQ9/bWkwmYX35Ai2fyiMjyk+15l1tqyoXD78sJWCxgtzlDrGbgUjRKBv8QU24tYrizu4ko9HHOJCIkVmZvFqhlJeHUMXzmsT3UZu++vT+trtFqa3sJwvRrvU4NPo6XwQ/PyzB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JT2OA+pw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F45C4CEE3;
	Thu, 17 Jul 2025 23:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795171;
	bh=CYUbP5CbZh9UPmZrRuKoDLheSiBNQbpAQNyzSt3QdZE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=JT2OA+pw1zeitRSqlwxyUMGZ2Vz9UFu7xpsPwct+88FPd+BH00ai61HW52puIKeht
	 ABU7NFa3B8d0tfhnb8o8ifu4J28zSR7bE8iBVJz2WKF3YBXHQHLfeH7ItZH4+kYqv6
	 I2PTpT8W0yUaI5Wj3nJVvyYrsmGrULP1mrlwJe1qjCxXosJplUMs0pbZE8+sodrsgh
	 yHADI4Fv36RnFTs64x2rgYMIyKWL15wjIcpvVnn2c2L7gudA6CeD+Za/BpBVOx3KnT
	 Pn6zDMsUy+Vr3yoCiaxN3TlLp3am9yYcsXQMNuTn4+Pqk/h43U8FlpbQNAl4kE92gj
	 ibs9R0KYIHZCA==
Date: Thu, 17 Jul 2025 16:32:51 -0700
Subject: [PATCH 1/7] fuse: force a ctime update after a fileattr_set call when
 in iomap mode
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net,
 miklos@szeredi.hu, bernd@bsbernd.com, joannelkoong@gmail.com
Message-ID: <175279450806.713693.7015302699436633846.stgit@frogsfrogsfrogs>
In-Reply-To: <175279450745.713693.16690872492281672288.stgit@frogsfrogsfrogs>
References: <175279450745.713693.16690872492281672288.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

In iomap mode, the kernel is in charge of driving ctime updates to
the fuse server and ignores updates coming from the fuse server.
Therefore, when someone calls fileattr_set to change file attributes, we
must force a ctime update.

Found by generic/277.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/ioctl.c |   11 +++++++++++
 1 file changed, 11 insertions(+)


diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
index 2d9abf48828f94..5be73609dfe979 100644
--- a/fs/fuse/ioctl.c
+++ b/fs/fuse/ioctl.c
@@ -546,8 +546,13 @@ int fuse_fileattr_set(struct mnt_idmap *idmap,
 	struct fuse_file *ff;
 	unsigned int flags = fa->flags;
 	struct fsxattr xfa;
+	struct fileattr old_ma = { };
+	bool is_wb = (fuse_get_cache_mask(inode) & STATX_CTIME);
 	int err;
 
+	if (is_wb)
+		vfs_fileattr_get(dentry, &old_ma);
+
 	ff = fuse_priv_ioctl_prepare(inode);
 	if (IS_ERR(ff))
 		return PTR_ERR(ff);
@@ -571,6 +576,12 @@ int fuse_fileattr_set(struct mnt_idmap *idmap,
 
 cleanup:
 	fuse_priv_ioctl_cleanup(inode, ff);
+	/*
+	 * If we cache ctime updates and the fileattr changed, then force a
+	 * ctime update.
+	 */
+	if (is_wb && memcmp(&old_ma, fa, sizeof(old_ma)))
+		fuse_update_ctime(inode);
 
 	return err;
 }


