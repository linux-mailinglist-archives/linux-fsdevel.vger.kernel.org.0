Return-Path: <linux-fsdevel+bounces-35807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF279D877F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 15:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77662165123
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 14:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3301B85E4;
	Mon, 25 Nov 2024 14:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qOzUBOKr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A951B6D06;
	Mon, 25 Nov 2024 14:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732543844; cv=none; b=KxhvhWZrffIMgQhei0Oif/JqV+UIv3xOJPb/FiIjHYfSX0A0mvWfd5yYF8w9rxRtT5orQNOjLhdtxOC4/C8IoIBMiQeqaS5+s6xCbVUCnJVm/3JqXN2c2fp8FM8Yv/p9EYIY6h3YDmpvKAo0XpyTUlEXMHf4gLg2+nXZ3pnrozA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732543844; c=relaxed/simple;
	bh=ABY5Uagf0J2R/aq8j5D/rTRPz0TPoL0WU6jzCxYW3J0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lwRFFklPuBoW1rcoEXc5F+4i6HkoXhd2JNonc8QDEL2rKTKHpwZ9aW96s+2AzXxyYtwdV2eq7bGJhR8JBHNSzt1ADeH4kjU5tQfPZPZByQMfPHTo8H3C/MHowF+bKYkNMp8bPkirPeqfQf1ojLE/UYX/PkJeG3l+q6WV5oVaF5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qOzUBOKr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1AAC4CECF;
	Mon, 25 Nov 2024 14:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732543844;
	bh=ABY5Uagf0J2R/aq8j5D/rTRPz0TPoL0WU6jzCxYW3J0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qOzUBOKr5TsY6ML1jNW9dP+Ncf3b0S49O7oY/3phvZsoZnPLxG66c4DUNVvnqOme+
	 xA9wA3w5NWr9rsAbX7LfTyTliPDQzJceG7mkb5oi42lOOB4QIJ9XPosbKLdRhI44Kh
	 hvq5uc8b5+v6eHKMit2iD99xa/xPTY6bitMx9mFcptRueADne75qfWGnaVU4uzeODY
	 3/VJoTll56ameEBKBOMVLYStn4qmMkwJEsepxz4m5votIPOb6r2koVgYxDBr97sHiZ
	 Tkrb7MoDKn20EG26Gz82oU4fbMTqXIj86F/LIT+B8txgVvP1ZamkWghemyLxhQLL5n
	 tvckiad7sBCnQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 25 Nov 2024 15:10:06 +0100
Subject: [PATCH v2 10/29] aio: avoid pointless cred reference count bump
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-work-cred-v2-10-68b9d38bb5b2@kernel.org>
References: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
In-Reply-To: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=985; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ABY5Uagf0J2R/aq8j5D/rTRPz0TPoL0WU6jzCxYW3J0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS7tHru+NAyIdtq1tbW1HXWVn/nMvXa5isXZhSumdtVO
 enWhG8mHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPZ+J2R4WSSv8eCX5/0yuV2
 6rrfszneP/eamS0vX/anfx9eZzQ8+cTIsPd417LVF27+eiAw9w9/aM0epmuel9dFck199i914qm
 +52wA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

iocb->fsync.creds already holds a reference count that is stable while
the operation is performed.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/aio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 5e57dcaed7f1ae1e4b38009b51a665954b31f5bd..50671640b5883f5d20f652e23c4ea3fe04c989f2 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1639,10 +1639,10 @@ static int aio_write(struct kiocb *req, const struct iocb *iocb,
 static void aio_fsync_work(struct work_struct *work)
 {
 	struct aio_kiocb *iocb = container_of(work, struct aio_kiocb, fsync.work);
-	const struct cred *old_cred = override_creds(get_new_cred(iocb->fsync.creds));
+	const struct cred *old_cred = override_creds(iocb->fsync.creds);
 
 	iocb->ki_res.res = vfs_fsync(iocb->fsync.file, iocb->fsync.datasync);
-	put_cred(revert_creds(old_cred));
+	revert_creds(old_cred);
 	put_cred(iocb->fsync.creds);
 	iocb_put(iocb);
 }

-- 
2.45.2


