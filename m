Return-Path: <linux-fsdevel+bounces-40068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5202AA1BCC4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 20:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B03016DCA8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 19:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD68D2253EC;
	Fri, 24 Jan 2025 19:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmvAjPom"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28180224B1C;
	Fri, 24 Jan 2025 19:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737746398; cv=none; b=fpaz2Ym/G7yYX0zHMb+SRMHwqPJdi/m6NWaGwqYX+PmUEgw7n3uslFw5lD/0s5JornEdK0Bk75RWvilz4ET18ztTQBa+qtSYoduCVdXRDE0R3XWHOoSC5qU1myQpHhsfMfOMwZK1s26wQV+zbsiNYDGQMOp9yq5m10/V1Wh++7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737746398; c=relaxed/simple;
	bh=PSeXT5OPmZ3CLHOWnsn06fMWMBlx3JfvOW356lmNS5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FU5gs9NA+dwMUtltLR3zDB+kuAsrlqSZNIFhiyiMWDeSL9FcwZBoCD22869CmFPvZxk/kiPiDD05ud5T1D5MG4zdFBYHp6JiduBaYGaJe4/O+HA+ivqq+Cy1QvH9QCHgnyvzliJri+pRztGE3QwwbHiEE0b1dd2FC0hIOUl1EMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmvAjPom; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB29EC4CEE6;
	Fri, 24 Jan 2025 19:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737746398;
	bh=PSeXT5OPmZ3CLHOWnsn06fMWMBlx3JfvOW356lmNS5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JmvAjPomIA5ROix25gQqohqFQGadayGDEb/GVgwrMLYV3LfblJ1SQbdIFz86sl0xC
	 XL/9Ei90N5aEa39nCIzzxj/gvmPgeB8HdFiaQJKSnRrkjt3FG4yrd2FEi/POCCrLx3
	 C5YgCEt9JpNtn6eTApz2lQKkl9g96Ff7iOmm4/1EW+fZKPQW3M1s7mvf9dbyk1TTsR
	 bbmFDhNn0JK1sPZqpnwHe5IahIHFxnYxbO+mBOIaOO/SNFhdmkoWGKeTdEqdEmDN1G
	 oh88dnCbSO0Dcnnxx+arF0++YHwKEVvPPOk/3mjyyu17Uv6ygJ1Qpv5H5BvT03Pcjy
	 tw9+K+hGvT0jw==
From: cel@kernel.org
To: Hugh Dickins <hughd@google.com>,
	Andrew Morten <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	<stable@vger.kernel.org>,
	<linux-mm@kvack.org>,
	yukuai3@huawei.com,
	yangerkun@huawei.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH v6.6 06/10] shmem: Fix shmem_rename2()
Date: Fri, 24 Jan 2025 14:19:41 -0500
Message-ID: <20250124191946.22308-7-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250124191946.22308-1-cel@kernel.org>
References: <20250124191946.22308-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit ad191eb6d6942bb835a0b20b647f7c53c1d99ca4 ]

When renaming onto an existing directory entry, user space expects
the replacement entry to have the same directory offset as the
original one.

Link: https://gitlab.alpinelinux.org/alpine/aports/-/issues/15966
Fixes: a2e459555c5f ("shmem: stable directory offsets")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Link: https://lore.kernel.org/r/20240415152057.4605-4-cel@kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/libfs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/libfs.c b/fs/libfs.c
index 15d8c3300dae..ab9fc182fd22 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -365,6 +365,9 @@ int simple_offset_empty(struct dentry *dentry)
  *
  * Caller provides appropriate serialization.
  *
+ * User space expects the directory offset value of the replaced
+ * (new) directory entry to be unchanged after a rename.
+ *
  * Returns zero on success, a negative errno value on failure.
  */
 int simple_offset_rename(struct inode *old_dir, struct dentry *old_dentry,
@@ -372,8 +375,14 @@ int simple_offset_rename(struct inode *old_dir, struct dentry *old_dentry,
 {
 	struct offset_ctx *old_ctx = old_dir->i_op->get_offset_ctx(old_dir);
 	struct offset_ctx *new_ctx = new_dir->i_op->get_offset_ctx(new_dir);
+	long new_offset = dentry2offset(new_dentry);
 
 	simple_offset_remove(old_ctx, old_dentry);
+
+	if (new_offset) {
+		offset_set(new_dentry, 0);
+		return simple_offset_replace(new_ctx, old_dentry, new_offset);
+	}
 	return simple_offset_add(new_ctx, old_dentry);
 }
 
-- 
2.47.0


