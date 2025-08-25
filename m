Return-Path: <linux-fsdevel+bounces-58938-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC55B33588
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 06:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05AAF3B38A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 04:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB78C284B5B;
	Mon, 25 Aug 2025 04:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="l5Zb0bO3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9D4259CA5
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 04:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756097044; cv=none; b=NNuhVDI4M3DYpDurTH5AKeJVtWFiVdSsVqwBjSoYoAQQO3fEfiVOABF/O3Wj70WwxTS/HpVJjENhFsx/IvJ0+8maNgpyyTL0uiFY40Rw3dHR4+B4wQ3SeNgZEEyfeN33IAbqoLAiGPRPXefIvwnMJ6eBOjNGCyXOSCcFEvzlPdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756097044; c=relaxed/simple;
	bh=44oFKwHEXX5Fnmu3ffdYG+6A6Bl0t+HyGIPu02ioOM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XqVjJcu8Or9Gv85QFuCKMPU2Xvhjrn3pvl0x043gpzvMh2r26kDo7C8eSMJ1xDvHpOX9JtT29W28sokYBT2k2vmF9eZSan3KkHzLx24pFb4V3ys0D5beO/gi8u6kmCI1HMWHt3vNWmjUFZ2RNvntAdSSUjxK7nKjD15f/A/Bj8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=l5Zb0bO3; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=5BqC5c73nhwhV9KDL5FGkPMKzB2cIrG1LFMzVV2jWfw=; b=l5Zb0bO3zqFyct0zKYl/4MVp9F
	GtiUvx1sNH0SXXoCdIM0I4urER0Og8PnxIiazjF3mAqMkN/5PmDJzaxIZWEKWzaBchZBfU2ZoYjVc
	AEjBdO30A1j7YNO0LJ+66K+pJYe0DmOxspbv+LnEIg2v3CorX4RQTGrjYnhgp7cNO0DnKzi/Ly6Oo
	zlm5myq0FKTOYmUF2+NZibVnO1YUk5VHWgt8mQEz92Bxnpq8cEV6qMcgcvZJiJVm9OANm0S2NnvAp
	NMaxQH+WC4NMi5d7B+YrE2y8tD+7/SYOvZkW9xhyXG3f+p0MCLWi13XrHrRgtX+RRS7B2LrbCQncL
	abtjhRbA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqP3p-00000006TEe-08je;
	Mon, 25 Aug 2025 04:44:01 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 42/52] do_new_mount{,_fc}(): constify struct path argument
Date: Mon, 25 Aug 2025 05:43:45 +0100
Message-ID: <20250825044355.1541941-42-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 70636922310c..bf1a6efd335e 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3705,7 +3705,7 @@ static bool mount_too_revealing(const struct super_block *sb, int *new_mnt_flags
  * Create a new mount using a superblock configuration and request it
  * be added to the namespace tree.
  */
-static int do_new_mount_fc(struct fs_context *fc, struct path *mountpoint,
+static int do_new_mount_fc(struct fs_context *fc, const struct path *mountpoint,
 			   unsigned int mnt_flags)
 {
 	struct super_block *sb = fc->root->d_sb;
@@ -3739,8 +3739,9 @@ static int do_new_mount_fc(struct fs_context *fc, struct path *mountpoint,
  * create a new mount for userspace and request it to be added into the
  * namespace's tree
  */
-static int do_new_mount(struct path *path, const char *fstype, int sb_flags,
-			int mnt_flags, const char *name, void *data)
+static int do_new_mount(const struct path *path, const char *fstype,
+			int sb_flags, int mnt_flags,
+			const char *name, void *data)
 {
 	struct file_system_type *type;
 	struct fs_context *fc;
-- 
2.47.2


