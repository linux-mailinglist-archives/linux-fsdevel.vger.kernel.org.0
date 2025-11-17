Return-Path: <linux-fsdevel+bounces-68662-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 67274C6345D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 10:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6B1964EEC45
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 09:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0296532824A;
	Mon, 17 Nov 2025 09:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GP+2I2TX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7CF1E0B9C;
	Mon, 17 Nov 2025 09:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372059; cv=none; b=YD9KocH9ozm2zSUM4eMOEghZzNSqnjqy6aVRWA9nm33AHChD6cDUKTz4aXl5+18A9hUifHAITlJLJUN39HUifxq6xLDrTqKGr1p7+SPjQ/+v2UfiU0aO+VuM19UdiafcZDEYIS4qpv5ZqFWczI+WaaRQ23A/VmXAgxoWvnxKktM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372059; c=relaxed/simple;
	bh=Iart+ZiBD15gJWXZaXHTY4U2G+xILumZmopHdJ0h0IM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fwPAvcM5WCefCgqrNqFpzGzKGcPSQLi+464zzavZqJwFsgM7JPeB1vTHm4iPPawKuQxPFsBI7UhbGxObUbjBvDO0tJPteN90J50Dbwmy0wasn1WWxYBYXqgLb5/0VL3hBUH/WTaN9MHNVug5nR+a0dClI2ySz8KWagIahC/QLqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GP+2I2TX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB470C4CEF5;
	Mon, 17 Nov 2025 09:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763372059;
	bh=Iart+ZiBD15gJWXZaXHTY4U2G+xILumZmopHdJ0h0IM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GP+2I2TXwDv47baHfdgKd3eVpLm6zTT+9FMdTDlr+kRFETXREfgn2wjz9JrfAzLSr
	 dzZW4dChUGLYUJCiitOc4pjT60oN+5L8ljHaJs77nKclg8AKXb7JND0en3mv70Fgue
	 SBFEx6oIMRCMfFKlgMXvxW1MiRPiWcL7OtPPkJPlA0rYo2y5F3MMNlKHq9D5h0yDHL
	 GqRO89u+1vSTPUIURABfigOVxmKL83i5QRzWQhIUFTpg0ywhAQ1I0xtT4X7/gb9UL5
	 Z4OgGf/wzvU+yGSYnJQXOB3vhzgUD4eMthAjXLT6+SEFFqdZDvCNs+W+mkabJM+xO9
	 ElzDfgYNho6CA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 17 Nov 2025 10:33:50 +0100
Subject: [PATCH v4 19/42] ovl: port ovl_fiemap() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-work-ovl-cred-guard-v4-19-b31603935724@kernel.org>
References: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
In-Reply-To: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1164; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Iart+ZiBD15gJWXZaXHTY4U2G+xILumZmopHdJ0h0IM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRKvf669ufP02fLNzWc5AxNnL7Sq6rYYlJgIdcTzarvv
 H13eyZ5d5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzE6Rgjw6fp60QK7b62qX11
 Yry/Su/1onflUtuK8iS+xYV/MpuY/paRoeFe7YysL2pcSQFuP5+8FWDfluB23vuSvSencIatbEU
 UIwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/inode.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index e6d6cfd9335d..5574ce30e0b2 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -578,9 +578,7 @@ int ovl_update_time(struct inode *inode, int flags)
 static int ovl_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		      u64 start, u64 len)
 {
-	int err;
 	struct inode *realinode = ovl_inode_realdata(inode);
-	const struct cred *old_cred;
 
 	if (!realinode)
 		return -EIO;
@@ -588,11 +586,8 @@ static int ovl_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	if (!realinode->i_op->fiemap)
 		return -EOPNOTSUPP;
 
-	old_cred = ovl_override_creds(inode->i_sb);
-	err = realinode->i_op->fiemap(realinode, fieinfo, start, len);
-	ovl_revert_creds(old_cred);
-
-	return err;
+	with_ovl_creds(inode->i_sb)
+		return realinode->i_op->fiemap(realinode, fieinfo, start, len);
 }
 
 /*

-- 
2.47.3


