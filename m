Return-Path: <linux-fsdevel+bounces-58454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8896DB2E9D3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 02:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DA9B5C868F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 00:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48231E5B64;
	Thu, 21 Aug 2025 00:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjrcSpOn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C011632DD
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 00:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755737754; cv=none; b=XabuVGUZ7tl+LQR6MBTqk08HKDsG8l6XjIQSXSHVI25yB9z+vqrKrE0kkAiX5PjOP4gVGVW8Kb2of8bIeLwcamH/TTxkfmks+rBOCeGiUF2ZOB0tNGWwUafG2e0+mz2sE/B4DpLXKYa0rAIbwp328km+/XP+ShwGu3Q3py/fSzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755737754; c=relaxed/simple;
	bh=mNcJtmVsBN4UDzbsalsipg1HQamJspv5ovCgLYUr8qc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bcUP9H1idAV70Ug6uzAptxlT+2VsT9ReP9scJmD3gBnuhPKEnriF9CteTtKXeQaegUl9iITaos/BKxsA3oLtrtpLAx4ntcMiBQIhkMQuSVhVyQ0GAIeH+9jaBMlX3J8ryqKjOk0Efqacwu4YJ6BfpiVVEntzFSovQ/lR/Kz46Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mjrcSpOn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE315C4CEE7;
	Thu, 21 Aug 2025 00:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755737753;
	bh=mNcJtmVsBN4UDzbsalsipg1HQamJspv5ovCgLYUr8qc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=mjrcSpOnc64qlfgQINbwXZU8pqEGrZEOSAiBqXYQ0zMQhlumj2cBFSghplzBNbB/V
	 ie+2eiWXIBrg457YQWscBvhj0EpemaHgBKp5CvTnpjRXUn3E7BEQMkM8RC0Eu16z0Y
	 FK6nC22e8uhid/vMoQwN1OrcY8jZ5B1/aDU8ZraU1+MczE7z1u/6jtCfHotyPgu24c
	 uZR03barCtAWH+fH7dPO/1YA+ZzEpZOmx+o0cYlUs4OADUSo4XjRO3tNxXYVtF2oUJ
	 vkuigQ3jfbgPlxS7EJsEXmmQiI5V6JECjtO53W1W9V06Zw+2ZTMA2pIHtlKfa5Z5DV
	 g/UcOasoYeSKQ==
Date: Wed, 20 Aug 2025 17:55:53 -0700
Subject: [PATCH 13/23] fuse: use an unrestricted backing device with iomap
 pagecache io
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <175573709395.17510.10315122954906531559.stgit@frogsfrogsfrogs>
In-Reply-To: <175573708972.17510.972367243402147687.stgit@frogsfrogsfrogs>
References: <175573708972.17510.972367243402147687.stgit@frogsfrogsfrogs>
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
index 92cc85b5b8a8b5..701df0d34067ee 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -699,6 +699,27 @@ int fuse_iomap_backing_close(struct fuse_conn *fc, struct fuse_backing *fb)
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


