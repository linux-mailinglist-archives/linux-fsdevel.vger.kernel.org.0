Return-Path: <linux-fsdevel+bounces-58464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB62B2E9DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 02:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D583FA26B95
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 00:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46101E98E6;
	Thu, 21 Aug 2025 00:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gi1Xpco3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAE6190685
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 00:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755737910; cv=none; b=exzm56p1hxra2t2RbsKlCvmkQtH4mKzwbmLYqesn5S26jxlfptQap+n/DAom7XWJO69EyvvqQ8NqouyrSzMQ2DO6iJyDyFzhIzmqSq7MJepSrW9hBlztM3tJUy6jQZ2zi8mWT1AGaM04r941XcI1tCK84LScDLJRXuJZzD1oN+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755737910; c=relaxed/simple;
	bh=5A5p+U+etAnI2fQzW9R6zyFlG56Ggv9fFLZPWdfPLVA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oEWm+E+MRtr4pvaFa1zZUT3dYnX8MGXWEFy8F6vbBUyTCWY9lHSXGaSXVfQ1jKDT9iTfKpJu4hEwvekedQLnUNDSk1m+Un9iKQgTiGv7w8aGaJ4+NjsT8C4/svvu0+cughPISDKvXYYq1r21AipyZnQ+Y6Ua8ZiO8rJPPI7zZCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gi1Xpco3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 274D7C4CEE7;
	Thu, 21 Aug 2025 00:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755737910;
	bh=5A5p+U+etAnI2fQzW9R6zyFlG56Ggv9fFLZPWdfPLVA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=gi1Xpco398/PwBHniPkL7/uYrvVGmsh7XZkComo1qY8rPMZ0eF6vyh0V60l/CUynO
	 MdBXZiOIM4RtGAjyfhsAfpc12BZoAcaEu3urlWL1QTUKRNthbLCu3GZl4iPXBZYQs6
	 jij4ZF2xT3rb4XQASnGcj3OuuFWUugPCp5XbO1iapawbvUBlNuZqhNK2X8UHlqWF92
	 qUmW+7rlzzhFbUnSXkr2hN04bQUdT4dX1xlsN7yFC6G2b8wXvRGX+vfDUg/8DgL5P1
	 01gMyQIJ1/k4y6FGZVPQeFWtOiOp3SOVm6sFaDig4J3z1Yap8/9P9B14LCsBGe7lcO
	 lZQrfGO3wS3LQ==
Date: Wed, 20 Aug 2025 17:58:29 -0700
Subject: [PATCH 23/23] fuse: enable iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <175573709610.17510.12221929305255487135.stgit@frogsfrogsfrogs>
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

Remove the guard that we used to avoid bisection problems.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/file_iomap.c |    3 ---
 1 file changed, 3 deletions(-)


diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index ee199c1fd27b1f..3141518cc6e67d 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -104,9 +104,6 @@ void fuse_iomap_sysfs_cleanup(struct kobject *fuse_kobj)
 
 bool fuse_iomap_enabled(void)
 {
-	/* Don't let anyone touch iomap until the end of the patchset. */
-	return false;
-
 	/*
 	 * There are fears that a fuse+iomap server could somehow DoS the
 	 * system by doing things like going out to lunch during a writeback


