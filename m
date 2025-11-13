Return-Path: <linux-fsdevel+bounces-68298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 663A9C58E13
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 17:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6F29F5054DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 16:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF7B35A124;
	Thu, 13 Nov 2025 16:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eeG8h+Lo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621272FC013;
	Thu, 13 Nov 2025 16:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051859; cv=none; b=eDfRPZ/5ozDuMKrKbh0WJIGChP1PNOVKLlQzXv3oZkPJdA7ZhHZ5qYdQ3URduxDzUe9AeEbmr+VSDNZxFjlnhnGm4XFXsiVAfl1yKEI/Pc5kNmjAGoDh09JMwQ+yohyG6TEyYXlk8y6pE8rpkv5pAQvyT0PBUb9/PYLDTjfcmyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051859; c=relaxed/simple;
	bh=TX++D1Q3F+zo5muH/+V2/Wk6U2CNLWnq1YTXgIKoVWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g8mSA+uMCWBnBpS/7FHThac1Yz/qApI6UnjGd0gMdmBB/kzn2kl2AJpMRBoK1BLAyXJk/TuQGZjGwPiRJZYl8TImXGxj+BvJW4MN3mbdwB2pzBGwV9d+BO6jckNc9PdPho2ls3wYJyB/mx8164zVLQamgi/ghyAgp8rx7PJs5IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eeG8h+Lo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EFCBC4CEF1;
	Thu, 13 Nov 2025 16:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763051858;
	bh=TX++D1Q3F+zo5muH/+V2/Wk6U2CNLWnq1YTXgIKoVWY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eeG8h+LoGLGUpFM+kC248bjQ/V5RPvlYxP5MRcC2reA9SKOXBBrsQcb4api77qEl7
	 Gq+ivNwuFmOb+ZM0dXT45afWSVzfmQ1uC92GwbFdoRpUGqtjqLtvEw81YTRrcEm1FY
	 ryUlcnlgKJkIBt/6th6RtyXrhkOySEOpd/bofGPs+yY6opqeKEuRYqaOoHQX0hOtLQ
	 4Ffp8KT2DPhTvCNbcrqOyWmmuQRjxfwq/Et6YsH9RM7le5TCb7+Y+J7v7aVGzCEGDB
	 UE/JRHAoGaX5Iqq30PXO8ozAMsOkjavhyHwexhuB1nY3k/xslw6nzB8pGtslpFEzkE
	 bhBLWggm2yPYw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 17:37:10 +0100
Subject: [PATCH v2 05/42] ovl: port ovl_do_remove() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v2-5-c08940095e90@kernel.org>
References: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1031; i=brauner@kernel.org;
 h=from:subject:message-id; bh=TX++D1Q3F+zo5muH/+V2/Wk6U2CNLWnq1YTXgIKoVWY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKcbqu6f+hfGGGE6+08CmJpXf02TvfKh+58LG7VUjrn
 tyXdfv5OkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACayNIuR4X2gh5+Ted7X3riZ
 JvMN1v8/O33x4sjp395OtjpQslwz8xfD//QrtTb7fAzFL7pcW/hY40/WT67NBZ3cPkv8o7pPXTU
 t4wAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/dir.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 63f2b3d07f54..1a801fa40dd1 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -903,7 +903,6 @@ static void ovl_drop_nlink(struct dentry *dentry)
 static int ovl_do_remove(struct dentry *dentry, bool is_dir)
 {
 	int err;
-	const struct cred *old_cred;
 	bool lower_positive = ovl_lower_positive(dentry);
 	LIST_HEAD(list);
 
@@ -922,12 +921,12 @@ static int ovl_do_remove(struct dentry *dentry, bool is_dir)
 	if (err)
 		goto out;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
+	with_ovl_creds(dentry->d_sb) {
 		if (!lower_positive)
 			err = ovl_remove_upper(dentry, is_dir, &list);
 		else
 			err = ovl_remove_and_whiteout(dentry, &list);
-	ovl_revert_creds(old_cred);
+	}
 	if (!err) {
 		if (is_dir)
 			clear_nlink(dentry->d_inode);

-- 
2.47.3


