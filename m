Return-Path: <linux-fsdevel+bounces-68229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCD3C5786C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 14:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 680534E14FB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 13:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4C1351FCD;
	Thu, 13 Nov 2025 13:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egNP3sb4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0714A31A554;
	Thu, 13 Nov 2025 13:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763038973; cv=none; b=mN7EKnLGRRo+VDoHxGb25Cg+w2CcXEN4HbXeIiPvWaCzpvPG4/9DikFT68nmCvG31JPrpNy2ORzY4DJ/0bCvjvhMSstbIQDV8OVHka63qbLRGk+IsXgU3swrFj33hN9pCmQQPWPF47H0QHyfzE0siSh11ybe/jFQqqdgGtbceKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763038973; c=relaxed/simple;
	bh=sqUSmSJqtQfDlz+Sg+xtIxiPn64KYGI9BokrEmpKoyg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MatKHOtEhFHH368ZhWJwHmTP8VE6k3fdglwwqNutUZcwCT/iD44W32WCVLSpAi88/ce/jrwTWr6VQiTdpufUbsFC/joCN9WMo9OKiqY0ianN0Uwt8zRR/Vd8OHdWGkGrnzaxpairp471TEsPrGdyJbfzpibm3Acj4Oim76xEgOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egNP3sb4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B549C2BC86;
	Thu, 13 Nov 2025 13:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763038972;
	bh=sqUSmSJqtQfDlz+Sg+xtIxiPn64KYGI9BokrEmpKoyg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=egNP3sb4A1bt+cqN8Y4On7arIF6sgDmZ7qfBV0CiBlTLmY+i0XRSOgWNb+EyUUONx
	 rM56gLjsZEvBWhNHvRwBvJp/Iby09aFBuvt0/p9LWGil3hPue/JjYKW0VNM7Uko7iJ
	 faTGqnenRn0h2ubgntj5EJp2RitZQpaqa/g1yMTitlOS9aYTmml9ebqiicyifoFKGv
	 VGXAcxJSung/V9bu+sSyRaopEQART8pa6f5qIRg0YEkjD5ppZoTAF82jLujIz5NSYN
	 wcJFqUis9X32IBEdKE6E6X1+8v4hyTp5Qck/CyqCyM3pweBzF1FL7uwMqX956zCHYA
	 uEEdYWOg+JALQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 14:01:32 +0100
Subject: [PATCH RFC 12/42] ovl: port ovl_flush() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v1-12-fa9887f17061@kernel.org>
References: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1004; i=brauner@kernel.org;
 h=from:subject:message-id; bh=sqUSmSJqtQfDlz+Sg+xtIxiPn64KYGI9BokrEmpKoyg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKXnu8YdME/rxtFj+2+6YFHJhwMe/cw252ddOk5yyes
 qX3f9+d3lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRmyWMDDvVirhzPXzyAz8t
 1hLR2JbhmT/984VTebZ3w9dN+ffN9RfDb/bMyVFWN5bwnKuTFkl+erqOSanOSOGDr+ymncfSF2/
 Yxg8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/file.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

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
-		err = realfile->f_op->flush(realfile, id);
-		ovl_revert_creds(old_cred);
+		with_ovl_creds(file_inode(file)->i_sb)
+			err = realfile->f_op->flush(realfile, id);
 	}
 
 	return err;

-- 
2.47.3


