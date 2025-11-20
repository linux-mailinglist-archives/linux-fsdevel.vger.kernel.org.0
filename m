Return-Path: <linux-fsdevel+bounces-69289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DBFC76822
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 23:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3FFC64E38FB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 22:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F4430BBAB;
	Thu, 20 Nov 2025 22:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3a1b5aL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D41242D7D
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 22:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763677958; cv=none; b=YVVmgZQxA4kcAYb0Zry90Tz0DCN5yPg6U0b06DinJYHi6ueXYH+qvJxL7W9mL/6Ze55w81DrLO6CAulPneRBzUp5W9iek/V96AjpouZ6EauVsvFnbGvjoVMNb9jzspDIp8cyY1LDyUErpXCTgIRa26u5NvQ9R7ZAgKPUA2ebskY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763677958; c=relaxed/simple;
	bh=E48gxlGevED1EKOPkOF5GiHfgVOYJxT8kGS0ObvVITU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jPtG9UyE48U3wQmd4KrZ/dGe5GXnDem2XBe9rH6TCGAyFqIuDCASxGz2qUDlFWzRZyUVD7BkywAM1U1y8stMiXeDtUknSlZ53DPaq2WK5kXunNaG9HJbmcpLFnMhWqi3SN5IHDcBiwaElRgvMU2YeZCLH4+xyQM46VSGUkPVt0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3a1b5aL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D535C116B1;
	Thu, 20 Nov 2025 22:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763677958;
	bh=E48gxlGevED1EKOPkOF5GiHfgVOYJxT8kGS0ObvVITU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=J3a1b5aLnU/Cft5h1TwWOk2yQEwyNYGizGodwzwARevAUeywE/Dvdz9rMKHc10ai8
	 1btRyFgV+WVN7UGoTINozBlDjWpY00eRzJ+xyChnXln6+n3N+LgGjXmDVVlpV2Mjt+
	 JYW53IObYxfc80Z7IBE3n6IB/uHLnck02iora5mwXjD4vYRBw1yy6j4aBQ+ObyVz79
	 yTHDV2AnY3Hq4MDMruGvSSniePl7g4lS0FBmAp3j6h58cu0gvG/wrVA72kJfs7r6ME
	 H15ZpsFD63f7KKaA9R64n6uMcbGfqlXwnoBQBA08BtVAIBpXsL9CAyL65/dGmOXqBj
	 Ezu3ogsQ1NgGw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Nov 2025 23:32:07 +0100
Subject: [PATCH RFC v2 10/48] nsfs: convert ns_ioctl() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-work-fd-prepare-v2-10-fef6ebda05d3@kernel.org>
References: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
In-Reply-To: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1321; i=brauner@kernel.org;
 h=from:subject:message-id; bh=E48gxlGevED1EKOPkOF5GiHfgVOYJxT8kGS0ObvVITU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKT3vzpC3ev5lvC1OkslJpdFrspt957JWSJxOPRBk67
 2R1ke/rKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmIjGf0aGY3MXLGzfczxt2fa/
 y69+OrZYrfTB2RWiM2fc5y7fu6zsrCQjw6R/7vurC4+xzZFx7Z45X0z04qQvE92ObpP/wvV9yva
 wCkYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Placeholder commit message.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/nsfs.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index ee1b2ecddf0f..fae7dc328896 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -325,15 +325,10 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
 		if (ret)
 			return ret;
 
-		CLASS(get_unused_fd, fd)(O_CLOEXEC);
-		if (fd < 0)
-			return fd;
+		FD_PREPARE(fdf, O_CLOEXEC, dentry_open(&path, O_RDONLY, current_cred())) {
+			if (fd_prepare_failed(fdf))
+				return fd_prepare_error(fdf);
 
-		f = dentry_open(&path, O_RDONLY, current_cred());
-		if (IS_ERR(f))
-			return PTR_ERR(f);
-
-		if (uinfo) {
 			/*
 			 * If @uinfo is passed return all information about the
 			 * mount namespace as well.
@@ -341,12 +336,10 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
 			ret = copy_ns_info_to_user(to_mnt_ns(ns), uinfo, usize, &kinfo);
 			if (ret)
 				return ret;
-		}
 
-		/* Transfer reference of @f to caller's fdtable. */
-		fd_install(fd, no_free_ptr(f));
-		/* File descriptor is live so hand it off to the caller. */
-		return take_fd(fd);
+			ret = fd_publish(fdf);
+		}
+		break;
 	}
 	default:
 		ret = -ENOTTY;

-- 
2.47.3


