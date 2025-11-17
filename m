Return-Path: <linux-fsdevel+bounces-68670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FDDC6347B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 10:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4D5E234E9C0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 09:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6634B32E12B;
	Mon, 17 Nov 2025 09:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tAfQDfM+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BBF329C60;
	Mon, 17 Nov 2025 09:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372074; cv=none; b=cv+6e0v+f9u8atHGljtKxLJPRPmvfHDIIpfofd8E+JBgsDMCcR8B6U3V25XSYmeIv4D8yfX/HfRcHL61klvLxJ4aDyfqdLDTX6jkBDFBih6vvoGmuGAyMVAO0ES6dsakG5iUn/ekkGnfSUbvYIrDcqyzT/q/hJR+l+oLzEUUyE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372074; c=relaxed/simple;
	bh=6JO31yQ8b52pZf6ywlKuDL4HyxoyT7H7YRqH3JYIyoA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=apqvP1SdyAS0LsBwqV0AmxoV2/R6HEDTnaATwACNRYOPIQKF5NlaqYjx+txqGQxqSamOzaWAnTCeHSA1evc1qMt0g03BQlpZa07aMeRUSxwEw2glJI4dkOwR5oHmlbsLIkMi5W3pjhdrA1WdcbSQR0gSb7xV70Btc/Z29D2ItYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tAfQDfM+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD48C4CEF5;
	Mon, 17 Nov 2025 09:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763372073;
	bh=6JO31yQ8b52pZf6ywlKuDL4HyxoyT7H7YRqH3JYIyoA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tAfQDfM+kWoEgZGXk8Lab0R9HLVmmcI6ingFSRD5z71aidtt2I+SVWhy295gBd+yZ
	 rpvEJ/lMBCrPiLp2b/mGcmqhCEVFf4SwHWGbrI00awPnU+Dvdtpea10gs/1XC0ruxs
	 DroXpWFf2Qac0hes/yg/7CpR4ypoBIAnbDrCv52SCL5+X/pdZ5bhsbn701DjnmXeUg
	 Vsl9bQjRTWjxwbsZ1lv7GN36Ro2LZMIO7rwBU91SFi2elqJcP3a5rp1ItXLSEOgPU5
	 CpK4ABjOvjlS++RsUx0FA9r26O2yEi/2I5mNlCpX9C05++3poUHrFfi2iAe7bdUEs1
	 TZciqGl4doOcQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 17 Nov 2025 10:33:58 +0100
Subject: [PATCH v4 27/42] ovl: port ovl_check_empty_dir() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-work-ovl-cred-guard-v4-27-b31603935724@kernel.org>
References: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
In-Reply-To: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=811; i=brauner@kernel.org;
 h=from:subject:message-id; bh=6JO31yQ8b52pZf6ywlKuDL4HyxoyT7H7YRqH3JYIyoA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRKvf42Xfmy96u7pnUnt74RqAr69K32g0b4dB/WQEH9p
 e8Wn5N43FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCR7K0M/9NfP0woXO50lfFT
 Zsq5W6dcrkfvy9QVUDDM55ulvYItfTbDf+fj38zPLBJ1WB83N3HDrcncX489O8CRzl+j0BqRxOb
 UyA0A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/readdir.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 3af6a8bb6fe5..9fb11b303d1a 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -1077,11 +1077,9 @@ int ovl_check_empty_dir(struct dentry *dentry, struct list_head *list)
 	int err;
 	struct ovl_cache_entry *p, *n;
 	struct rb_root root = RB_ROOT;
-	const struct cred *old_cred;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
+	with_ovl_creds(dentry->d_sb)
 		err = ovl_dir_read_merged(dentry, list, &root);
-	ovl_revert_creds(old_cred);
 	if (err)
 		return err;
 

-- 
2.47.3


