Return-Path: <linux-fsdevel+bounces-68319-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC90EC58F92
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 18:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 97BC235E9AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 16:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA823624B3;
	Thu, 13 Nov 2025 16:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUqyW3ne"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446FC3624AF;
	Thu, 13 Nov 2025 16:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051898; cv=none; b=p3HzTjUJ+cnN/bKw8aA9q3PODT5VmL5TCA0ZBcNvxr/BMpuP6JSfYO3C2lZGi/W2HcocRxa/XP3JeH7tzCpsigndDQQcOUJ9rsMzIOINq+ZivwlmegW1cqH02BjdqKrcCQml7i/aQD+r5sdVEptw/kVlIzgwCgC/z/jTT7InIWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051898; c=relaxed/simple;
	bh=1MZVdRUKosqXtBiMsvH3uE9xNBnZA9QSOrmBBVhXTUQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cdBBIiz8MKf56Jm0QWtz0vaO8nJtT6WGxfargcVdPtJeW5fST63ooABV+2LcESOQidEbMW/tWBN9FeVnN74nBQw4JZmteAvLQ+6/xViHl/Vkd7K4TATLGr0Wjee4r4NKk4ND1FJO1wZGEASqkAvKytkVzsYwcAegRRs3xqh7eiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUqyW3ne; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 638E9C4CEF5;
	Thu, 13 Nov 2025 16:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763051897;
	bh=1MZVdRUKosqXtBiMsvH3uE9xNBnZA9QSOrmBBVhXTUQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZUqyW3nej3azS8awFAGZme9QQ2JsLwCdjastfwjugwXNMfwDLVNwdMf1dTszhM4m+
	 S4OJiNbNhKLAWg9R+UUiaFcDM60v9pyZIBPL8a3fhV8nMvb6WeKnxCCh+6pT77Ei5h
	 JIWSg80d0DAB4y+vqf5ODGZdD+Gv9veSqnf3pSF7YVBcsWpyi54aH8+YoHIQuyh/G/
	 Ii4wsnPTFpnb62+mifRxJOFKEYuM/W3h6Im0mEUTQIypsL6qlNdWcgbKUpHvANGsMd
	 Q3majbiekcLrTzOB9wu3ShvNn2D6UeW6PqlVEYXwq1DwHPhZv+QIl7Jub1ex0hB6p/
	 dxsTN0W7t3jLQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 17:37:31 +0100
Subject: [PATCH v2 26/42] ovl: port ovl_dir_llseek() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v2-26-c08940095e90@kernel.org>
References: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=944; i=brauner@kernel.org;
 h=from:subject:message-id; bh=1MZVdRUKosqXtBiMsvH3uE9xNBnZA9QSOrmBBVhXTUQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKcbozLmf8yb1o8wP2dD811YrC2ZzCW7XeL7m3RSt65
 YrL2odVO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZiNI2RocVTcur7e5y603Vv
 p9VKz9P8neL3yreRxyg1fln/0RksuowM58xk2fka6k7Z3DHLUtO7rn5kLceJ00bbWRy6GPoUu36
 yAwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/readdir.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index dd76186ae739..f3bdc080ca85 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -941,14 +941,8 @@ static loff_t ovl_dir_llseek(struct file *file, loff_t offset, int origin)
 static struct file *ovl_dir_open_realfile(const struct file *file,
 					  const struct path *realpath)
 {
-	struct file *res;
-	const struct cred *old_cred;
-
-	old_cred = ovl_override_creds(file_inode(file)->i_sb);
-	res = ovl_path_open(realpath, O_RDONLY | (file->f_flags & O_LARGEFILE));
-	ovl_revert_creds(old_cred);
-
-	return res;
+	with_ovl_creds(file_inode(file)->i_sb)
+		return ovl_path_open(realpath, O_RDONLY | (file->f_flags & O_LARGEFILE));
 }
 
 /*

-- 
2.47.3


