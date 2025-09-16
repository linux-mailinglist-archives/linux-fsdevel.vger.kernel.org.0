Return-Path: <linux-fsdevel+bounces-61524-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 070E0B5898D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94715188CFD9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E4D7E0E4;
	Tue, 16 Sep 2025 00:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgcYuIVd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE6F1BC5C;
	Tue, 16 Sep 2025 00:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982745; cv=none; b=iMWnQ9ptHSmhV4JHeBqydFb/FYGwFyT8J4a5sP0ZcD/g3ul7gxq1sD+9IU14/UugbA0iY2L0gNevPyxBNC5le6WzL/RXionYh2MIsswMJ9m9hvwGL+bVsoqe/RNuQ9pB8hqPFrcfeT34o+ctnCdNRTjxjkcCiFUmFHgrzjMM3SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982745; c=relaxed/simple;
	bh=NwrWwbSLmJkJTJwrLiSTOVinz7eRwAMBqYJarml72zI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nf6PXpE3jSktdl+mgzAZuKt81Cc6SAWVmKCP62mToheuz4P8BGDtdHN41pUorH1HpoYRPrnH2dFL64xc5f04WmS1paOe9sGHtFaXqitUP3R6iM2NY0p1RObcNC68RgM6DEu8FuczUs9owgo1UAmAxSnBioIyjMyNqwkHFXE1CZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgcYuIVd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D17D5C4CEF1;
	Tue, 16 Sep 2025 00:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757982744;
	bh=NwrWwbSLmJkJTJwrLiSTOVinz7eRwAMBqYJarml72zI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=dgcYuIVdmHVkIDkxH1DaI+jbxaxRp716NyCcmOO5QQKwqzUIcnmMsz50EEunKhwnt
	 TEMzFC+OaBiRezS9ARRtWa5cS4/lq8e3ZCe/KZv8PweyNG0EUZrZIjr6VxQ37Nsg4o
	 9t3V3ygcXHHMigYuBa+fvSL5RzHa4sh94c1g3WkKtapO9dbXme7bJ1QhHrXRsBCFjC
	 qEsLGJ40xMEPtnZi4Qf/Ny408MiA4kG2iKJnMLx+6Xvv681Kvplah9nl+cHBKRreYU
	 OeeyeTdPfHwyM2D9jv7NzYWIctlUPOXgpQUBrc3T5phiMArzST8Z35VGFrTyBLa1os
	 l0cE4UtHcqgkw==
Date: Mon, 15 Sep 2025 17:32:24 -0700
Subject: [PATCH 17/28] fuse: use an unrestricted backing device with iomap
 pagecache io
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
 linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798151631.382724.8920443497310476278.stgit@frogsfrogsfrogs>
In-Reply-To: <175798151087.382724.2707973706304359333.stgit@frogsfrogsfrogs>
References: <175798151087.382724.2707973706304359333.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

With iomap support turned on for the pagecache, the kernel issues
writeback to directly to block devices and we no longer have to push all
those pages through the fuse device to userspace.  Therefore, we don't
need the tight dirty limits (~1M) that are used for regular fuse.  This
dramatically increases the performance of fuse's pagecache IO.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/file_iomap.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)


diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index c09e00c7de2694..6cc1f91fe3d5a4 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -711,6 +711,27 @@ const struct fuse_backing_ops fuse_iomap_backing_ops = {
 void fuse_iomap_mount(struct fuse_mount *fm)
 {
 	struct fuse_conn *fc = fm->fc;
+	struct super_block *sb = fm->sb;
+	struct backing_dev_info *old_bdi = sb->s_bdi;
+	char *suffix = sb->s_bdev ? "-fuseblk" : "-fuse";
+	int res;
+
+	/*
+	 * sb->s_bdi points to the initial private bdi.  However, we want to
+	 * redirect it to a new private bdi with default dirty and readahead
+	 * settings because iomap writeback won't be pushing a ton of dirty
+	 * data through the fuse device.  If this fails we fall back to the
+	 * initial fuse bdi.
+	 */
+	sb->s_bdi = &noop_backing_dev_info;
+	res = super_setup_bdi_name(sb, "%u:%u%s.iomap", MAJOR(fc->dev),
+				   MINOR(fc->dev), suffix);
+	if (res) {
+		sb->s_bdi = old_bdi;
+	} else {
+		bdi_unregister(old_bdi);
+		bdi_put(old_bdi);
+	}
 
 	/*
 	 * Enable syncfs for iomap fuse servers so that we can send a final


