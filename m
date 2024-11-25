Return-Path: <linux-fsdevel+bounces-35815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE27C9D8822
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 15:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 072ABB479EB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 14:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C6D1CDA01;
	Mon, 25 Nov 2024 14:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMNgiK8A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0368D1CD1E4;
	Mon, 25 Nov 2024 14:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732543863; cv=none; b=utz5anVKeY9DU2s6NPghkBqNTF6P4LKwXlSiRuolmKXL3XUvcdYjniNKCP4gwZLyOVQJdGXWnX6WE1xpeVzyC4RwzZYfuDjJJYeQbP+Ok2Ifbplg0mZt8rM/pVLTCgJFiIUqD0Nu0SaXcHOKr5lRZpSt2ZFCB58utclf2NGeiIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732543863; c=relaxed/simple;
	bh=qn9Xf5o2GvqjcZpyBGVHdCcZBvfUa8h8mFJlHlRuGIA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m5wHREXn+GbFewr8NxPmHWz9OqcxACIAKvCngIPpMjAcR9TbAEFdgHfmcTB1OlQl6PTfftN0Szu/rUMJx9F0tNdu2+nb7yHkkkWesSZ744ZhXAN6h+XEcXPJ/FkRGRf1mJA+GCNRXHv3/T20zE5BJoxYpn/8dBv5ZUPdx1vTV7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMNgiK8A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B877DC4CECF;
	Mon, 25 Nov 2024 14:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732543862;
	bh=qn9Xf5o2GvqjcZpyBGVHdCcZBvfUa8h8mFJlHlRuGIA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LMNgiK8AnD6qJ2zTo/JPhfRH60F3MWk1rJ2ubGUw/QpqsZU3316giRMuI0MLgOq7F
	 r34JHiWf518xWSBr+sZfLZMGNSIdex6bR53Pj/n90QTwinXkCABmp0cAAJWph/RyXp
	 EPrlVrStFV/+ZaOlUZSu90wsP5XibsXpdq6b2DG3J6jiqhuPrvMGnkJWkwyzWTtyy/
	 VWtTNrel9d0OsMS0NiksfPddvrV4YIc9yYEass9TZQqWEDk7enja2fD7IhZC2zkC+R
	 BkwiSuaVfM5lUpDKUEZjGeiX5ryiMoE5E8dc4KEJ+LjGWWiIMg/c3F7HpiWxErqpPw
	 TudHBbXiRixJA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 25 Nov 2024 15:10:14 +0100
Subject: [PATCH v2 18/29] ovl: avoid pointless cred reference count bump
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-work-cred-v2-18-68b9d38bb5b2@kernel.org>
References: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
In-Reply-To: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=997; i=brauner@kernel.org;
 h=from:subject:message-id; bh=qn9Xf5o2GvqjcZpyBGVHdCcZBvfUa8h8mFJlHlRuGIA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS7tHqeW/3x1+016z7u75ViYBU9pXU8Pk5aIelvT0euo
 Hd0XUZhRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwES2zGD478Q4wzZsYvzGr+1f
 3T1WSd+crxrAn6UqFJn//98qBpO/jxl+MZ/4/E6vO+zAu9ObUi4KCtfMTO3VFDzy/wXD1ec3WtW
 Z+AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

security_inode_copy_up() allocates a set of new credentials and has
taken a reference count.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/copy_up.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 439bd9a5ceecc4d2f4dc5dfda7cea14c3d9411ba..3601ddfeddc2ec70764756905d528570ad1020e1 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -741,7 +741,7 @@ static int ovl_prep_cu_creds(struct dentry *dentry, struct ovl_cu_creds *cc)
 		return err;
 
 	if (cc->new)
-		cc->old = override_creds(get_new_cred(cc->new));
+		cc->old = override_creds(cc->new);
 
 	return 0;
 }
@@ -749,7 +749,7 @@ static int ovl_prep_cu_creds(struct dentry *dentry, struct ovl_cu_creds *cc)
 static void ovl_revert_cu_creds(struct ovl_cu_creds *cc)
 {
 	if (cc->new) {
-		put_cred(revert_creds(cc->old));
+		revert_creds(cc->old);
 		put_cred(cc->new);
 	}
 }

-- 
2.45.2


