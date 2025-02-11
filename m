Return-Path: <linux-fsdevel+bounces-41530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4730A31294
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 18:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7557018896B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 17:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02636262D32;
	Tue, 11 Feb 2025 17:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tVMJrP1C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F4626BD8E;
	Tue, 11 Feb 2025 17:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739294207; cv=none; b=WbIq24LERrzj63/R1TncmQ5awwHzXg3af6FtEfkt+azeGfPe9Sp5ZZnbnCE28Bcb8wwVcAomPWrpZEV4W1eeuwM9sZZFrzt3bThGlj/IZCV0eEy8NMaOwq8k7yLyUS4FToGanlZWPG6dTb7E9tZQBE0jhmMVX1xyRVdQzcvrge0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739294207; c=relaxed/simple;
	bh=R8d5Ssr+h4DakuPRujcY1UcNTq2kza5I6mwLHnz1mt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HwaeXxnnj1cEm1wD4obGLBGRbqAb6bP/qwojZus1N6ftSxYXc1dErbs7RuhFF8puni6NKvjP1JLCiqwdyoM4TV52QIEjlSjg9uKWD1ScYBLXkApvafb2hzXR3LoNo2cSrM6DZL9Zuism8p63+ZmsF0jhHR3iziNA61ZWs3wuTlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tVMJrP1C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B1FBC4CEE7;
	Tue, 11 Feb 2025 17:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739294206;
	bh=R8d5Ssr+h4DakuPRujcY1UcNTq2kza5I6mwLHnz1mt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tVMJrP1CRNsyE+8u/InV9JqgmQua6GhyffEgl6CLXwuJc8lkm3oveZOhTRyQaC6BO
	 EUA/cnNtE3XIj/ILxGOnN5R8/Gv/5i2lFecYVt+HXDAFKlgKtirg1xnlN9QY6YJxxa
	 dDl0tSHBupZ9JEwjZcrxo61VG5DAWFNOX/G3wk/M5erTGlrOAbrRjkxF3QjZAnuQED
	 ZzX08k75IFTvMkdSl7/KABgMto1KDtKERlMSptFh5mE8WWfUkakNo0aPWMzEEZTKQE
	 PeYHB4hVIj0W3RSA/QYiaeE1+U6Y8ZXHp7/Lmlqwknuh9cfGuLA7+qSYRgrbc6F6bA
	 erQBVPwHx70sg==
From: Christian Brauner <brauner@kernel.org>
To: Zicheng Qu <quzicheng@huawei.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	jlayton@kernel.org,
	axboe@kernel.dk,
	joel.granados@kernel.org,
	tglx@linutronix.de,
	viro@zeniv.linux.org.uk,
	hch@lst.de,
	len.brown@intel.com,
	pavel@ucw.cz,
	pengfei.xu@intel.com,
	rafael@kernel.org,
	tanghui20@huawei.com,
	zhangqiao22@huawei.com,
	judy.chenhui@huawei.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	linux-pm@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] acct: block access to kernel internal filesystems
Date: Tue, 11 Feb 2025 18:16:00 +0100
Message-ID: <20250211-work-acct-v1-2-1c16aecab8b3@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250211-work-acct-v1-0-1c16aecab8b3@kernel.org>
References: <20250211-work-acct-v1-0-1c16aecab8b3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-d23a9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1108; i=brauner@kernel.org; h=from:subject:message-id; bh=R8d5Ssr+h4DakuPRujcY1UcNTq2kza5I6mwLHnz1mt4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSvbr3ok9HCnmjp5jU5uET2QFSa01nWeZzdH9/7Fb7i+ Cg6ySeto5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCI3lzMy/FrnbrF949ozkVxH n8ZsUpL9meyjn3DK98O+zdc21R3Sc2H4K8n8Ve1HCJ+ceF6VecEj+5LeY2cUjLpbVK7fl1c4EHG BBQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

There's no point in allowing anything kernel internal nor procfs or
sysfs.

Reported-by: Zicheng Qu <quzicheng@huawei.com>
Link: https://lore.kernel.org/r/20250127091811.3183623-1-quzicheng@huawei.com
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: <stable@vger.kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/acct.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/acct.c b/kernel/acct.c
index 48283efe8a12..6520baa13669 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -243,6 +243,20 @@ static int acct_on(struct filename *pathname)
 		return -EACCES;
 	}
 
+	/* Exclude kernel kernel internal filesystems. */
+	if (file_inode(file)->i_sb->s_flags & (SB_NOUSER | SB_KERNMOUNT)) {
+		kfree(acct);
+		filp_close(file, NULL);
+		return -EINVAL;
+	}
+
+	/* Exclude procfs and sysfs. */
+	if (file_inode(file)->i_sb->s_iflags & SB_I_USERNS_VISIBLE) {
+		kfree(acct);
+		filp_close(file, NULL);
+		return -EINVAL;
+	}
+
 	if (!(file->f_mode & FMODE_CAN_WRITE)) {
 		kfree(acct);
 		filp_close(file, NULL);

-- 
2.47.2


