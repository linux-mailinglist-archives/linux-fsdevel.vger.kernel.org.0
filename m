Return-Path: <linux-fsdevel+bounces-68376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B313C5A395
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 22:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D037C4F2668
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 21:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DBD326D77;
	Thu, 13 Nov 2025 21:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQMTUWJu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAD7324B36;
	Thu, 13 Nov 2025 21:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763069566; cv=none; b=nePknczKlo9WjbLFmevtmqmQdG/jr0TMkP89qscki0wnxJr6o1phEVQk7mHPwGDuQiZCdowb59WSl07WThtQsGT4wjWgW0um0EJjEohhrUnQJGHTHa1fBecsr2azL97JrnsXX+RmINn80vZm2rQYyMIcMczrEWU8rkstLfRoSjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763069566; c=relaxed/simple;
	bh=MYGTFx3lPfWJdTrVOJ8KQ4lu0UujbjHiUqOl9oglQZU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mkGYar7sA+zc8gXKZNqiHEhuemLwxR1x6CzxmnSuNJCY530KF5v+xKGzslnqoQFG5YHEvN38X7XNOU+H0t9uKxjdGMWxKjE/gQUAFb7QBW9Gl7HeLL0vJ4JK4WwDjDkNhXmWRXg7OY6mc/+3tv4+RxA4N2HR4io7ZyjpX2H7rhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQMTUWJu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38507C16AAE;
	Thu, 13 Nov 2025 21:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763069566;
	bh=MYGTFx3lPfWJdTrVOJ8KQ4lu0UujbjHiUqOl9oglQZU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OQMTUWJuflE1/ofPqbBAkAVWT7OWGYisaLFzaL1QApY9zjmTsau3PXgX7Q1Zir7kc
	 W2zXnXJmRmWiIueMmq9VVgjKA0s4x7ZW2uDsIax2nzdhJ68o4X7gG2wPESzUvJqZqk
	 Qz+i4lBuok+f5g8wt63G6WkCDIueRQPgNK+lhTJspqHgMuQX9WsUmZQYMrWaUF2Ljm
	 vVaGpT3NJR9RyqyySTqz+LkE4HiHAIcCGqrDfy0dUGCyNrAqFg+37pcb0pAaAi/cVC
	 9cEvEMT5XLHqsW4VTcwrrhK8XX2PE2gZWs+fwLJRXoYqC8LcLkux4spjU/kvFckdar
	 qg+c51EE2Ubyg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 22:32:03 +0100
Subject: [PATCH v3 20/42] ovl: port ovl_fileattr_set() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v3-20-b35ec983efc1@kernel.org>
References: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1195; i=brauner@kernel.org;
 h=from:subject:message-id; bh=MYGTFx3lPfWJdTrVOJ8KQ4lu0UujbjHiUqOl9oglQZU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSK+YULxWru+Vbsav94RrDJT439szjl89UuPJzS9vHAz
 Vv/dQMKO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbykJ3hf2523JSqqMchIef4
 m6zEtFtyDFpa5exkbgpd+ZOlyBQSxMhwcOekXctupNVoZVyZfHS645s0Ln5O/Yx8AY+dO5qFXjx
 iAQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/inode.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 5574ce30e0b2..3a23eb038097 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -638,7 +638,6 @@ int ovl_fileattr_set(struct mnt_idmap *idmap,
 {
 	struct inode *inode = d_inode(dentry);
 	struct path upperpath;
-	const struct cred *old_cred;
 	unsigned int flags;
 	int err;
 
@@ -650,7 +649,7 @@ int ovl_fileattr_set(struct mnt_idmap *idmap,
 		if (err)
 			goto out;
 
-		old_cred = ovl_override_creds(inode->i_sb);
+		with_ovl_creds(inode->i_sb) {
 			/*
 			 * Store immutable/append-only flags in xattr and clear them
 			 * in upper fileattr (in case they were set by older kernel)
@@ -661,7 +660,7 @@ int ovl_fileattr_set(struct mnt_idmap *idmap,
 			err = ovl_set_protattr(inode, upperpath.dentry, fa);
 			if (!err)
 				err = ovl_real_fileattr_set(&upperpath, fa);
-		ovl_revert_creds(old_cred);
+		}
 		ovl_drop_write(dentry);
 
 		/*

-- 
2.47.3


