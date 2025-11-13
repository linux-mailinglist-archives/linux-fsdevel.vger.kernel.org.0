Return-Path: <linux-fsdevel+bounces-68222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0E1C5792F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 14:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC2C63B21C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 13:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49093352F9D;
	Thu, 13 Nov 2025 13:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQf7g9kf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA85352F80;
	Thu, 13 Nov 2025 13:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763038960; cv=none; b=AY6+P4D7/zDeZQkOYV5qwcJXdpbhJZhnOurVu9GWmfn1BWfjxar2qjpL4k8Uma4HIk6XVy+xs0YNEwaX69RHUwJdTM2HtT66nfNRNP7a12VXJySPQPAgvsZvm1bVV60tC3i77gzV8m5LlTv1RCXBkG1n4lmevjzEF7zxQqSsAs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763038960; c=relaxed/simple;
	bh=molOICUQW3X46UrGX77UiLUXaKpzuZ+wtVzKGOF9RfA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ks1n+1hzay232Q3Xa79PXz8z69RZb26dV+9NC2Ja1QzmzNO38iBbxcBkWIvjyG+WdU50K5mtAxgiG1Iyv1ldHgffeHm4QcyCXg03jJeMC0xefaDD8UMAt77JmH0i7RIqXQzfNJe8aEkhaDONeAT078x8gdsb1mJXS2xMvBU1vpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qQf7g9kf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A600DC4CEF8;
	Thu, 13 Nov 2025 13:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763038960;
	bh=molOICUQW3X46UrGX77UiLUXaKpzuZ+wtVzKGOF9RfA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qQf7g9kf0cU0uDTThfAqBVBheDQXTSd4u9g4A94Qus+8tkx23ZeqxQWy3o5kBaFbg
	 ELpubdgmvoR3WjoZ4kU1IxaQbzkdsxgJztG0w6jQe0GXOaEBEHAGLC/s5iAtu2Ywi7
	 EybocQMioseBNMsMdLJ3TjQw3mBe0Jl59x/Cd3dvZheYof58sYXvTJXnYfnCHPHZSh
	 pifOByL0fzXScgsmBXdXtsOiu3ghosGfV9ZnN2aQZ7iu+1/YQSq+PFtTuYEIm+DfJA
	 aqTw4xToFu2BmZ+yK87y3Z5pgfU41rtlr1fVvWToGGOJmNRadzASTeC07z7nBRKSPs
	 89hrw43ujJWGw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 14:01:25 +0100
Subject: [PATCH RFC 05/42] ovl: port ovl_do_remove() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v1-5-fa9887f17061@kernel.org>
References: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1173; i=brauner@kernel.org;
 h=from:subject:message-id; bh=molOICUQW3X46UrGX77UiLUXaKpzuZ+wtVzKGOF9RfA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKXnukxBPEE/FOYlactan9gl/V5+M7MxIt6wvSW42PB
 N8+cu9sRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQa3jD8z3y76/m1Ncyc3K8a
 ZPdarKiMnqUbe0jw27u/MxRWbOnVPs/wz0ht5pEZRZz1wtGrp62rOyx2SuHpF48GT/etPqdeSnp
 asAAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/dir.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

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
-	if (!lower_positive)
-		err = ovl_remove_upper(dentry, is_dir, &list);
-	else
-		err = ovl_remove_and_whiteout(dentry, &list);
-	ovl_revert_creds(old_cred);
+	with_ovl_creds(dentry->d_sb) {
+		if (!lower_positive)
+			err = ovl_remove_upper(dentry, is_dir, &list);
+		else
+			err = ovl_remove_and_whiteout(dentry, &list);
+	}
 	if (!err) {
 		if (is_dir)
 			clear_nlink(dentry->d_inode);

-- 
2.47.3


