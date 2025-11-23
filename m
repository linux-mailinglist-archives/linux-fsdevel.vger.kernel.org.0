Return-Path: <linux-fsdevel+bounces-69556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 548DDC7E3EE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 17:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E06823A55EC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 16:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0661B2DA74C;
	Sun, 23 Nov 2025 16:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5vNReiO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623EC2D9786
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 16:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763915689; cv=none; b=XgHLH2aflXbZdTB7n4RVefu4D8nr0CKeDwmkY8UumGyIVbwUJ/hpSqwhks6JaVzEN8rfjTbyoarAhIcZsjdDYnu/7To0zr61aKBl3pL+oT4NrwwtVVWj1OKwfPf7FLaxzS1E4UoPNJlJsrE4+LxQiEyA1zf5xlkAww1oqBGtYcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763915689; c=relaxed/simple;
	bh=Q7XHH4uRzhdPtJAhh07+sjnUwcg0AMm40+Rz21lToi0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tl1diiFvLYdBcTQKxxRxJHfiAbl7BMV09T+I49ZNHmIChuAXNXJ8EDLOx3koS17/S0fbVJ2TFneMkiqJS7jwhLhOiNpSp148PGGazUF+94+ww1jO094xkRUc4W+xUQnpryK5FMwbtmPpBMGd7PTnNauMKROE4JPVrnQQfooyP+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5vNReiO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 291CCC19422;
	Sun, 23 Nov 2025 16:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763915688;
	bh=Q7XHH4uRzhdPtJAhh07+sjnUwcg0AMm40+Rz21lToi0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=h5vNReiOUp72FQIVflhTMppr2fqn5g+L7hRPGzisFNT+9XV5+hZrJ5jk1tuHiHLeA
	 2T7i4IfWtBPPe04/raK6fWX05vzh9JCcPl1okTDofsxX2OyjrHnZpaXQ0HGp7qcBsR
	 ZmNmuJzaqKFyu4DIrFmq0k7hdZ/GXwVN+XArkPIg5EDkvLEE18HcW9BMDEpiQHmi/8
	 vkRyNELfGYURZS3Y08VL4I6af73eDaBsFrb0Cen6OWTDkJVQPYCwBO46NGuYxVIyNd
	 WJWZsRbvCwYZwcbLjBiC+SE62ZDDduZ88hYXExYvBhoAD6QUgXt7ha7xGG/e6R3SHM
	 E9aqLcVz2QS/w==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 23 Nov 2025 17:33:52 +0100
Subject: [PATCH v4 34/47] spufs: convert spufs_gang_open() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-work-fd-prepare-v4-34-b6efa1706cfd@kernel.org>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
In-Reply-To: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1239; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Q7XHH4uRzhdPtJAhh07+sjnUwcg0AMm40+Rz21lToi0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqm0dNms2mVr4j6MAd421mVw7kBPsun+GbvV5Obdb8U
 6buIfePdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyk/ifDPzX//CqlZx4MebN/
 Hv3ncOqGelnr4Ruzd/yLUvwoHNc/04/hfx23h8CPtZlGzW3tk5Jezg96Fcua+b30+LWGtt//d0R
 v5AcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 arch/powerpc/platforms/cell/spufs/inode.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index 195322393709..78c4b6ce5f13 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -497,26 +497,15 @@ static const struct file_operations spufs_gang_fops = {
 
 static int spufs_gang_open(const struct path *path)
 {
-	int ret;
-	struct file *filp;
-
-	ret = get_unused_fd_flags(0);
-	if (ret < 0)
-		return ret;
-
 	/*
 	 * get references for dget and mntget, will be released
 	 * in error path of *_open().
 	 */
-	filp = dentry_open(path, O_RDONLY, current_cred());
-	if (IS_ERR(filp)) {
-		put_unused_fd(ret);
-		return PTR_ERR(filp);
-	}
-
-	filp->f_op = &spufs_gang_fops;
-	fd_install(ret, filp);
-	return ret;
+	FD_PREPARE(fdf, 0, dentry_open(path, O_RDONLY, current_cred()));
+	if (fdf.err)
+		return fdf.err;
+	fd_prepare_file(fdf)->f_op = &spufs_gang_fops;
+	return fd_publish(fdf);
 }
 
 static int spufs_create_gang(struct inode *inode,

-- 
2.47.3


