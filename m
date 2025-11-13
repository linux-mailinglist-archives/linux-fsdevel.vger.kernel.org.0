Return-Path: <linux-fsdevel+bounces-68305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4326C58E6E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 17:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFB173BFABF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 16:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F93363C74;
	Thu, 13 Nov 2025 16:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0o9NRNG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFBC35BDAE;
	Thu, 13 Nov 2025 16:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051872; cv=none; b=H7EFlpDZaSCv5PvYDDt6gZwKAfhu4gW7UoQ+/MmMWd5KCBlIHi3l0ST9unaKDzaWg+nRGmQrJEXxssoqoTMHGKXYY5DidaJ0OcKCx5F18zF1ZPrA7/LN9D7hAg0HVXoPb1EEL3pwn4eWc+kc7uOb4ihOm+LMuianr7sFVu8IRN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051872; c=relaxed/simple;
	bh=mYAazB7wrI1J5ikVvAtD45Dc0hu0xkzYEf6782/9+0o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tYBwP2hpQPHfYp5FwnRIyn/1LSWJ1hhgsOLFCo+MaXOn2IoXeilp6urlCo9ye0v3eka9vMk4FmyOuLFr7MJokCJ8fs347BWb7k/HsDmsLTyioGJcuayOvufL8CgD/bCBqHcibOEYyaRHiH03vWpB0FpscNhlscOnG8OeWiT93XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0o9NRNG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6F12C4CEF1;
	Thu, 13 Nov 2025 16:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763051872;
	bh=mYAazB7wrI1J5ikVvAtD45Dc0hu0xkzYEf6782/9+0o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=L0o9NRNGFKLIyF3YIXNKZXWeQjiRun03PXLx4oeCQ9IGIFNGBiwWqrquPDVEd77Wt
	 cwE5tA1YqwuAhsAeE/gF/2MvDWZjQJ1mLuENBAs3eg9Wnqelh1FYs3nEgo1nn6u91A
	 J6JPydqo+y38V+goQlTKnu9dlQRn/DX9WAzh/BWzF5yOczAwNGONhWSDJjobNoxbzm
	 9Q5c/N5SxMDlnTbzKsssIvg+tUrm69Wjqd/+7AYmOi8bzHMeLeLqqMWk7MxE4X+rCp
	 b82+w+srL0zzFzOwpLMlIejYe2/h1lsDE+OTN8Kxpu2jqpq2WSz1gKhhYRTJ6FeOLJ
	 sk+kHaJKwNMQA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 17:37:17 +0100
Subject: [PATCH v2 12/42] ovl: port ovl_flush() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v2-12-c08940095e90@kernel.org>
References: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=954; i=brauner@kernel.org;
 h=from:subject:message-id; bh=mYAazB7wrI1J5ikVvAtD45Dc0hu0xkzYEf6782/9+0o=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKcbpN/M9Y8//L+sgb/3ae7Hvc11fyc9HDLX2Top/uO
 ObXrJSc0FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRm5KMDFOe39DkYLviEOrW
 ks50r+DxhTXxOXHSZ/lXrROfUraSs5WRoWFL+NEFFyfO1+8OeX3z2cupKx3T9Hh/zPri1t1Sk+d
 sygAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/file.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index f562f908f48a..e375c7306051 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -620,7 +620,6 @@ static loff_t ovl_remap_file_range(struct file *file_in, loff_t pos_in,
 static int ovl_flush(struct file *file, fl_owner_t id)
 {
 	struct file *realfile;
-	const struct cred *old_cred;
 	int err = 0;
 
 	realfile = ovl_real_file(file);
@@ -628,9 +627,8 @@ static int ovl_flush(struct file *file, fl_owner_t id)
 		return PTR_ERR(realfile);
 
 	if (realfile->f_op->flush) {
-		old_cred = ovl_override_creds(file_inode(file)->i_sb);
+		with_ovl_creds(file_inode(file)->i_sb)
 			err = realfile->f_op->flush(realfile, id);
-		ovl_revert_creds(old_cred);
 	}
 
 	return err;

-- 
2.47.3


