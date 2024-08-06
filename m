Return-Path: <linux-fsdevel+bounces-25132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B79C94952F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 18:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CBCF1C2130D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 16:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8B9535D4;
	Tue,  6 Aug 2024 16:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+0BNnj4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C028F28382
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Aug 2024 16:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722960169; cv=none; b=BYi/4ISBj4zU3oDsa0X7DgI6VrGgmeoHImopaW7EhYAWT17CGuS5YKBOP/n3bdwLeokTQGGB64wsqqUtkkfNiPGRsNwzzajj7ddQzl8hyWmCCKyQSMjNnPbpox0StINBOO0h84OFOoQgCcYlGGmeiR7mPX2fmjIphsVv8QnM2g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722960169; c=relaxed/simple;
	bh=PCqgiUtrfFNRs8S6V6oi9qOM8cvc8rx8luFKBcBqD+Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WR7M9rmaY/5f5F6WwKbcmqQGuXTwNfwyaYIR60Totq0NSjb0mOEKraLrDqdoVMjUhoODouReM9ha/jnoBvBQSP48NEOCOyTKluGEKHpobIM+lyn8JMYZrFRxsxlFKmyA07nMzx3tmsMISpQLbZ6imSmf7oqIZ5jbx1hs+x3g+ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+0BNnj4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8AD8C32786;
	Tue,  6 Aug 2024 16:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722960169;
	bh=PCqgiUtrfFNRs8S6V6oi9qOM8cvc8rx8luFKBcBqD+Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=N+0BNnj4AlQcuMM0nuK6L2f7jR/u2ZUrTj7bUKuNpiRsiKZcFK/rJ16Pr+Y4hXFIq
	 ZTuqQ7J+7dbgVtwzb0i1YV2CD9qnurKzcr/5i3LA85/5A6UcftPMqcOgDC9Ln6s+nV
	 89A+8rdbSCeRwM11mdivi/5YiOpEEFUfbJuizCMjxCTVxDazSwhlifHocVB2puzozQ
	 t6XrE/Oley635VzE09j7VP6CWrd5ijA1CkJDXjg+Dfirln9/dPrvilYu9gvJfl+zaV
	 PZzoIjXc+JreWk3HQxsTEM9mVqtGQwg2owl1GNnMBZQnPsiDICba3mzEIwu7PRI0bz
	 ER2TkLBcsbTyQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 06 Aug 2024 18:02:32 +0200
Subject: [PATCH RFC 6/6] proc: block mounting on top of
 /proc/<pid>/fdinfo/*
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240806-work-procfs-v1-6-fb04e1d09f0c@kernel.org>
References: <20240806-work-procfs-v1-0-fb04e1d09f0c@kernel.org>
In-Reply-To: <20240806-work-procfs-v1-0-fb04e1d09f0c@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Aleksa Sarai <cyphar@cyphar.com>, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=967; i=brauner@kernel.org;
 h=from:subject:message-id; bh=PCqgiUtrfFNRs8S6V6oi9qOM8cvc8rx8luFKBcBqD+Y=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRt8pSev1Bm2wzXQ0vUbzZtCZXquVTu0djz+1ZMVvenM
 2ViwVLfO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZiuZyRYfO28Nsz/eN53fvm
 yRo/+qWY8YmBT2mf5eSHHFFGDWFcCxgZFjKKrir3ZNJmfbioueds5YLrH0TSz19ftnGm4ZQ99yM
 L2AE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Entries under /proc/<pid>/fdinfo/* are ephemeral and may go away before
the process dies. As such allowing them to be used as mount points
creates the ability to leak mounts that linger until the process dies
with no ability to unmount them until then. Don't allow using them as
mountpoints.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/proc/fd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index f6b7344b9b2e..e9ac955ca9f3 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -397,8 +397,8 @@ static struct dentry *proc_fdinfo_instantiate(struct dentry *dentry,
 	inode->i_fop = &proc_fdinfo_file_operations;
 	tid_fd_update_inode(task, inode, 0);
 
-	d_set_d_op(dentry, &tid_fd_dentry_operations);
-	return d_splice_alias(inode, dentry);
+	return proc_splice_unmountable(inode, dentry,
+				       &tid_fd_dentry_operations);
 }
 
 static struct dentry *

-- 
2.43.0


