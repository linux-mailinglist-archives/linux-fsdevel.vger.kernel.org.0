Return-Path: <linux-fsdevel+bounces-16950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD508A5639
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 17:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4951D283345
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 15:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D807678691;
	Mon, 15 Apr 2024 15:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vFCgA1FZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4455176F17
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Apr 2024 15:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713194475; cv=none; b=ZHHwZw8/lNhmNLdfVkhv2VG4qcU+ZXYDGK05r6ZNP4xbfbecWqRMoqa0gkWd4BmWLQatkN1Taq77tlXfT3jxpAsK6tWfmpcgvNQvU6MsVnEeOuVIsdB8gGsxbkGWcLlo0dYahi2znO1Ns5qH4NruXORSSZuJuQp5eDTF/jONHkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713194475; c=relaxed/simple;
	bh=mO6wYl0n2gAH7rOKjNiOQSLCNMJDIMoBV14J5VV6Xlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UsxAj8KWLVQrT2CbbiMvz0DudOoMObDAC1u65p6+/8dFmebO95Bp/W2GNS+4mpJuVkakIGevAEodCpR30l20KSM/XBp2RWPMirePlucVOOTlNa16U99r3o+IF9GLLHP0gDvF6x+jULqJ7yryl6Dm6XS/1FLziv/i0PJQ6SGB0Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vFCgA1FZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D91C113CC;
	Mon, 15 Apr 2024 15:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713194474;
	bh=mO6wYl0n2gAH7rOKjNiOQSLCNMJDIMoBV14J5VV6Xlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vFCgA1FZx+zHL6zi8ml8urWl2cE0x72HPCSG5lHUoGzZC7mBECHmwM15eq2ZYPis/
	 cz+2gCQru56GVA0matdtGiYRGBASnJ+9xizjG9KO5O3OKYcLDSC081d6/9Eog6fhUA
	 IJZvSz0oAsa8HstqEY49QOMRe13GYa9doMHhC07zT+YHVSBaGWshGXELk+u7sMffe4
	 Yc2RgwTDtYZB4qGyCLMJK54mJCRVTjeQ0CUEHqlGsGRmmIOLm0NmcZzIJ94oMb6Tnd
	 EXdSEOyCSMfiz7SyNRbVoBCwTFEtsAYuy/aAikrHtLOZlMFNMEJP7j88MyHytfPljp
	 xu2kmPS1fk/FA==
From: cel@kernel.org
To: Christian Brauner <brauner@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 3/3] shmem: Fix shmem_rename2()
Date: Mon, 15 Apr 2024 11:20:56 -0400
Message-ID: <20240415152057.4605-4-cel@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240415152057.4605-1-cel@kernel.org>
References: <20240415152057.4605-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

When renaming onto an existing directory entry, user space expects
the replacement entry to have the same directory offset as the
original one.

Link: https://gitlab.alpinelinux.org/alpine/aports/-/issues/15966
Fixes: a2e459555c5f ("shmem: stable directory offsets")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/libfs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/libfs.c b/fs/libfs.c
index c392a6edd393..b635ee5adbcc 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -366,6 +366,9 @@ int simple_offset_empty(struct dentry *dentry)
  *
  * Caller provides appropriate serialization.
  *
+ * User space expects the directory offset value of the replaced
+ * (new) directory entry to be unchanged after a rename.
+ *
  * Returns zero on success, a negative errno value on failure.
  */
 int simple_offset_rename(struct inode *old_dir, struct dentry *old_dentry,
@@ -373,8 +376,14 @@ int simple_offset_rename(struct inode *old_dir, struct dentry *old_dentry,
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
2.44.0


