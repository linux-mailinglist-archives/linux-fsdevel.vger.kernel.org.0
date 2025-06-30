Return-Path: <linux-fsdevel+bounces-53257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3298BAED296
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 04:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C42F818950D9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 02:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B281187346;
	Mon, 30 Jun 2025 02:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="iMuFEJx+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8333E1865FA
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 02:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751251980; cv=none; b=VZV9qrao44BdKs90I1jVhxjsbrS0aJ9W4at6inZxLtPSeQhWhebUB8+1b4jxHBxq/O7zYtXF41tvX+jh4kfVykpXh6O9ZNQCzfcZzhFIStjLHBQzsBEfeV4uVns6SDDcSetgBzSRC/ayJtqfET4ftppfSxCSzL/swUwLxVn7uUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751251980; c=relaxed/simple;
	bh=+7doAFqcS00ctaVas+Ggrn9oFIszbOr+3Di+RJE6+LI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a6/UkHHpGYrxLeG3rSukN7RD6ExavXBBLTX1E1cGFgU5Q0BrFONJEN0iADuTiRooheSZumMdu7lzDDU0il5g6f0Oj7XlU+jxBA1ZuYSh6q/e3nkEWb4AavJw/VTwGkQp3fMwjzMyNP+jRhIWFICTuT42FmR5xTnDi1LY10Htjn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=iMuFEJx+; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=aZ9+0mFshNvwGKzfeyZQBhQwrBcEW/ro32xKnSbuZaQ=; b=iMuFEJx+f+24O0FCH2bk8hRgOl
	eyDYubFfjmNDwCbo8FRIGiaUV1qbhTf242dsCU8NJRi2vt27IWSadqJuHpqFqU/IqcgKxUsQtCmLJ
	A4O8z86empfFCqR774bk2eh/9SSgcUPUPam8Q4HZ4m7Mt25g4SSikc351nou3NTYV+ChpcQ7yImTc
	/Y4kcfXnBgL6+Bdew2MFg/zMoLUMMckdmrRBR8Q+zD2YSLrqWGSdS5PFKwn1lcmR8btmHaT2tVvgg
	M8K09rycYY+OouWBwJNuuY2X8iHVM1pjA54qJa0HTr5Rq3mdfhHN/PZRNBmIFptkmmRqf1ZdwYaok
	p29cqRvw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW4dc-00000005owV-0Qj5;
	Mon, 30 Jun 2025 02:52:56 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 08/48] constify is_local_mountpoint()
Date: Mon, 30 Jun 2025 03:52:15 +0100
Message-ID: <20250630025255.1387419-8-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250630025255.1387419-1-viro@zeniv.linux.org.uk>
References: <20250630025148.GA1383774@ZenIV>
 <20250630025255.1387419-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/mount.h     | 4 ++--
 fs/namespace.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/mount.h b/fs/mount.h
index c4d417cd7953..f10776003643 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -147,8 +147,8 @@ struct proc_mounts {
 
 extern const struct seq_operations mounts_op;
 
-extern bool __is_local_mountpoint(struct dentry *dentry);
-static inline bool is_local_mountpoint(struct dentry *dentry)
+extern bool __is_local_mountpoint(const struct dentry *dentry);
+static inline bool is_local_mountpoint(const struct dentry *dentry)
 {
 	if (!d_mountpoint(dentry))
 		return false;
diff --git a/fs/namespace.c b/fs/namespace.c
index aa93e1a48b5d..c4feb8315978 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -894,7 +894,7 @@ struct vfsmount *lookup_mnt(const struct path *path)
  * namespace not just a mount that happens to have some specified
  * parent mount.
  */
-bool __is_local_mountpoint(struct dentry *dentry)
+bool __is_local_mountpoint(const struct dentry *dentry)
 {
 	struct mnt_namespace *ns = current->nsproxy->mnt_ns;
 	struct mount *mnt, *n;
-- 
2.39.5


