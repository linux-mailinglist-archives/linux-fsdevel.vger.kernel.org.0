Return-Path: <linux-fsdevel+bounces-66019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAB0C17A30
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D52C44EF734
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C992D3EE4;
	Wed, 29 Oct 2025 00:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NU0oMS87"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EC784039;
	Wed, 29 Oct 2025 00:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761698964; cv=none; b=facneXVhMcL3lIQRBc+aAK7ebOkZmhfdw1pKauu+1T3iijdV0dmpFUB8zA4t/iOA+y9yQYozDrCafyTZFbrYLAod8mpHq2BJU9zJ2N6SWyd27Fp7T4qHPm9sXdwFsbdzBfilgK1VV+648laEwlO7ddBGLTw5sh6Xdgbh4pc6qFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761698964; c=relaxed/simple;
	bh=zV3qMzHe5erS3ZZYcgMoxSXlVMIJ7ruqsMAjlzAyZZU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tK9HNtICGmpcUoPuZnygXgM+MB05A/SA4nBgL4kkD3op667+23wdVEVp+cQFOJA+LZdAj4hguw3l6FwUZUwOebyf+n7htgwDQqcxlnZbBOWHxJO90+5L+l2chDbBV4vEAPmYKBKbwNHEUX2KQhs1+x9W9Zv7QOWUSlKJkRFv11I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NU0oMS87; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABEEDC4CEE7;
	Wed, 29 Oct 2025 00:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761698963;
	bh=zV3qMzHe5erS3ZZYcgMoxSXlVMIJ7ruqsMAjlzAyZZU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=NU0oMS87jAz5+D0RWrh773geZ9CxUiyrC8YsHTTAYs3W20qJhB8qe/IeojaKXUGX5
	 x32tQncJ8rfSQ/yS7RD+cIkyGw2uZ+KomHV8OzcbahmH22vK5cl9VZQAMNxgsPkus6
	 jQHoM+1P59TeOunEmCLPXfikzODZwmbyMirgohQolzBVCAbU5irU5aAzVHE5tu9lpX
	 y8QaSxo5KDay7vQibM6HxeSO/KXAaZSwdhHD8fqetds8txBEPlFJgOmVT+0pvovV9N
	 xMOTk+2NjnyHoJCuEXw5+uvP9WKTlf5QbCa9Icu84trrY9pvrsSICgauxA1OAXKCkF
	 tIWUZap1aMJMQ==
Date: Tue, 28 Oct 2025 17:49:23 -0700
Subject: [PATCH 17/31] fuse: use an unrestricted backing device with iomap
 pagecache io
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, bernd@bsbernd.com, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <176169810721.1424854.6150447623894591900.stgit@frogsfrogsfrogs>
In-Reply-To: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
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
index 0bae356045638b..a9bacaa0991afa 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -713,6 +713,27 @@ const struct fuse_backing_ops fuse_iomap_backing_ops = {
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


