Return-Path: <linux-fsdevel+bounces-49616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C756AC00F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 02:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FD1B9E4A31
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 00:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CC3182BD;
	Thu, 22 May 2025 00:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sNJ2EUE6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EAE171CD;
	Thu, 22 May 2025 00:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747872303; cv=none; b=LcuLoTvCMU3RFU7a995L/FZhQMo07zGLAuK0JC16sPkcdaHPCGqXiRk9rdYywRgtKxZyuE4ezp19uCGtUIByGKX3r/pEYGARzm8WtgWWu5zAo7Af71nphHLoqtqLfP8B5OgFJAlplJKaur0LhiGx/6QD/xuy7QvIw7TZlPANmVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747872303; c=relaxed/simple;
	bh=aF1Q16UBkUwDs+k+z3w4JQGgAiKtnJeHzz31AP5g9z8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UodCQxQgAe4erVX/0z6klu8ImxEbM9+IPg41LnInsSP6OMV488cnSeXijIGNS8C2CQ/gzoO9A9EYKBEZkdRdp6+64jF78mizGGBYbLTiHZGs7s2tPZ5KkXhgyNART3Wf8ED44sIeuIoaahrEHrsd7MqX9zQtclLYJsbX7VP5o50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sNJ2EUE6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B2E7C4CEE4;
	Thu, 22 May 2025 00:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747872303;
	bh=aF1Q16UBkUwDs+k+z3w4JQGgAiKtnJeHzz31AP5g9z8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=sNJ2EUE6U8Q9OXRni59f9JaF3fl9MJhWMM9K2bsj3NUU5MuD+ZwJhhoyyarL0Hha8
	 zTtdTZutPLilgl4vtRtXh+6P/13UHstPNezre6y65AHaTgjHN9GpZGUGFgHL2jUxnG
	 r52h4hnL1SUW/fL0FYgrsc09UAEtu9+gFP/VLnSPgVyIHRPEaxJfthiOHztAB7bvAQ
	 JGkMcRRbUtq1EFsz2euPy6yZtAUTxiLdHw80LkNnf9Wwiv08URF67+xe+TraUhwFfh
	 ErJkpUITecqbKry0iChN9myQPyEcRiLOgeVGFILAsJc526HeCRImql3wY2+BGkEZ9Y
	 39nAk0QqZcpaw==
Date: Wed, 21 May 2025 17:05:02 -0700
Subject: [PATCH 10/11] fuse: use an unrestricted backing device with iomap
 pagecache io
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com,
 linux-xfs@vger.kernel.org, bernd@bsbernd.com, John@groves.net
Message-ID: <174787195779.1483178.6014743615559519131.stgit@frogsfrogsfrogs>
In-Reply-To: <174787195502.1483178.17485675069927796174.stgit@frogsfrogsfrogs>
References: <174787195502.1483178.17485675069927796174.stgit@frogsfrogsfrogs>
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
 fs/fuse/file_iomap.c |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)


diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index c58ac812598d8f..746d9ae192dc55 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -427,6 +427,28 @@ void fuse_iomap_init_reply(struct fuse_mount *fm)
 
 	if (sb->s_bdev)
 		__fuse_iomap_add_device(fc, sb->s_bdev_file);
+
+	if (fc->iomap_pagecache) {
+		struct backing_dev_info *old_bdi = sb->s_bdi;
+		char *suffix = sb->s_bdev ? "-fuseblk" : "-fuse";
+		int err;
+
+		/*
+		 * sb->s_bdi points to the initial private bdi however we want
+		 * to redirect it to a new private bdi with default dirty and
+		 * readahead settings because iomap writeback won't be pushing
+		 * a ton of dirty data through the fuse device
+		 */
+		sb->s_bdi = &noop_backing_dev_info;
+		err = super_setup_bdi_name(sb, "%u:%u%s.iomap", MAJOR(fc->dev),
+					   MINOR(fc->dev), suffix);
+		if (err) {
+			sb->s_bdi = old_bdi;
+		} else {
+			bdi_unregister(old_bdi);
+			bdi_put(old_bdi);
+		}
+	}
 }
 
 int fuse_iomap_add_device(struct fuse_conn *fc,


