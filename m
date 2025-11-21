Return-Path: <linux-fsdevel+bounces-69408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C88F2C7B328
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 334623571AF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 18:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051202F0C66;
	Fri, 21 Nov 2025 18:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3ObvuQr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E9327FB34
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 18:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748073; cv=none; b=XF6dqmsO4uagNsEdnaspeNaeRKHx5yv7Q90yZQF1WCHW+wa0VnwtuU5exN+0o12xWwrFHO77AVqYnn06CqvhznSSzCFwGW5pHczVxAXvUMAP5QErDUTecyQ4vHmoVCJttZzdT0OqigU05Nyh2d1h+aNtfF4LoruzyqeMFGrEJ5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748073; c=relaxed/simple;
	bh=ECfsKxcbhMtFPfXV8Q4ADT9uqroqQq5PM7OyxHr4eUI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eG1u/ViqT6lRO4EBlz5/cVcoYfyG29AY1Gtzkpj6QKy+tkvpbJ3G2JcmABqTkfSIcq9k8cl9o9CkH+/bSb3gBRp6SiwGY7Wm5NaDU3ieoSoAMcXvxWyfAcYoq8f/0G4T/Si5ljzt7de57tBrpBc57jublzJT14b4w2CFuATUMNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3ObvuQr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 597C1C116C6;
	Fri, 21 Nov 2025 18:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763748072;
	bh=ECfsKxcbhMtFPfXV8Q4ADT9uqroqQq5PM7OyxHr4eUI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=A3ObvuQrxFYsHtCQKeO+p21Go6KM3UvsVUEtTsvRxDfFuoWhWvlvRpFQZFU+uszz9
	 dp5VyY4Oi1m5pmcZmSpkR/pQGTNDHkBbKaXlBuBpdsjqQARdAwMPq3QPQAnZIBjXYq
	 rTQ4roA39PQasn34ORRsEn7Cvn+RjNoNbQOMvh+oB8CGxt4OX7BHettJYOppIqoLwo
	 7j7sUsw+FZpeVDyB3yuPodTS0KhOfeyNGsGnrTz8RGVWDPJmenFZ1apP/dJxyxjpxn
	 Te2ag0RbxhYKvYdIvXN4/F0I7135cnKX2efvtmeiSdFD5Lbef6M4/OluISba/OFjif
	 qU2gotomPMrlg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Nov 2025 19:00:49 +0100
Subject: [PATCH RFC v3 10/47] nsfs: convert ns_ioctl() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-work-fd-prepare-v3-10-2c6444d13e0e@kernel.org>
References: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
In-Reply-To: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1433; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ECfsKxcbhMtFPfXV8Q4ADT9uqroqQq5PM7OyxHr4eUI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqrDg/yeWKz6O2+Tr8l+4fnbdRQvjK1uVflwqfZo8KC
 Nl09sPGDx2lLAxiXAyyYoosDu0m4XLLeSo2G2VqwMxhZQIZwsDFKQATcUlnZGibOmnhrktbonJn
 rN7//XKZwNQ4/q+T8gJVxBU/XfLbWx3CyHBt6byPp9YdOFMmzOS83H31D8aDM3Q1OG7l//GWZdM
 ylWYAAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/nsfs.c | 35 +++++++++++++----------------------
 1 file changed, 13 insertions(+), 22 deletions(-)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index 61102cc63e1d..d4f115c4b11d 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -324,28 +324,19 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
 		if (ret)
 			return ret;
 
-		CLASS(get_unused_fd, fd)(O_CLOEXEC);
-		if (fd < 0)
-			return fd;
-
-		f = dentry_open(&path, O_RDONLY, current_cred());
-		if (IS_ERR(f))
-			return PTR_ERR(f);
-
-		if (uinfo) {
-			/*
-			 * If @uinfo is passed return all information about the
-			 * mount namespace as well.
-			 */
-			ret = copy_ns_info_to_user(to_mnt_ns(ns), uinfo, usize, &kinfo);
-			if (ret)
-				return ret;
-		}
-
-		/* Transfer reference of @f to caller's fdtable. */
-		fd_install(fd, no_free_ptr(f));
-		/* File descriptor is live so hand it off to the caller. */
-		return take_fd(fd);
+		FD_PREPARE(fdf, O_CLOEXEC, dentry_open(&path, O_RDONLY, current_cred()));
+		ret = ACQUIRE_ERR(fd_prepare, &fdf);
+		if (ret)
+			return ret;
+		/*
+		 * If @uinfo is passed return all information about the
+		 * mount namespace as well.
+		 */
+		ret = copy_ns_info_to_user(to_mnt_ns(ns), uinfo, usize, &kinfo);
+		if (ret)
+			return ret;
+		ret = fd_publish(fdf);
+		break;
 	}
 	default:
 		ret = -ENOTTY;

-- 
2.47.3


