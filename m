Return-Path: <linux-fsdevel+bounces-59568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04876B3AE24
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B264D583EB8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC13E2F83C9;
	Thu, 28 Aug 2025 23:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="EI7EAVj5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDE52EFD81
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422496; cv=none; b=lVxGhB9RN2xUt4s6HkpjVh9jD8nCEEzXUIVptwwRs3OwGPegqEc0PDjq1vvJksTGLin+TERcoHpOdH7h0B312Ksz73oEzVMimUCLcSG6VqF042GD94NlR83Q0KEeNbSq3Ptn9+6n0E9zd4NvooCxtbvyogVjtj1ZvqxGeSHOEcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422496; c=relaxed/simple;
	bh=59+bNPMNBtt5/y5OuPNrjk966iqnc8mjoqk8vSkX8Ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I/cIYpaRo28lhVbwFEC2OkSYrWwNVn2gVNv1OYIihXs3LadGjYKVbHepRmh4jhKtzUHQdrSZmwH+rJDMF4ZCHsh362Bx14BxcXrSwgAKtNBGs4k8aJF6j8NZK5qTCpkCle5/kiYo87BQBp+LzC55VYwxGA0bNQHXGof+GQ4BZ8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=EI7EAVj5; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=lHdPM1GW/HBRWs52soppMRKfMYvhKFqQans9PlIZ2Lc=; b=EI7EAVj5t2uuA54AbXltqKltiA
	hGXn+SBlXRnVyr6v91ASULwp3QUJGA2zDptRRf0ABXwiHQKZgqWohuJ+TmO/ZUATnfVr5q2NzgEW5
	GODer5gJNtXf2PtIqZG9mzzcMk1kmwX2gZrm3w+z3VTR4O9xfXqTpw6CLI7VDX3v1iWPSEkbW5Tdg
	F5zjHPwqUxkw+P7rU+brlskmg1sT55+/HvIgbOMI15gGgf3IZq5Bwye2UvyiZN3hFQR61VlULChpo
	yPxb/Af/m9elaNs7un/+Jz9joF+Gdt2rMUQjcl4w/yJuWjgFCgbEHPtT/1k+sWx7JGAnUvITiEO0m
	kzo5Seiw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urlj2-0000000F27d-2Vrx;
	Thu, 28 Aug 2025 23:08:12 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 41/63] do_move_mount(), vfs_move_mount(), do_move_mount_old(): constify struct path argument(s)
Date: Fri, 29 Aug 2025 00:07:44 +0100
Message-ID: <20250828230806.3582485-41-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
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
 fs/namespace.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 43f46d9e84fe..70ae769ecf11 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3572,8 +3572,9 @@ static inline bool may_use_mount(struct mount *mnt)
 	return check_anonymous_mnt(mnt);
 }
 
-static int do_move_mount(struct path *old_path,
-			 struct path *new_path, enum mnt_tree_flags_t flags)
+static int do_move_mount(const struct path *old_path,
+			 const struct path *new_path,
+			 enum mnt_tree_flags_t flags)
 {
 	struct mount *old = real_mount(old_path->mnt);
 	int err;
@@ -3645,7 +3646,7 @@ static int do_move_mount(struct path *old_path,
 	return attach_recursive_mnt(old, &mp);
 }
 
-static int do_move_mount_old(struct path *path, const char *old_name)
+static int do_move_mount_old(const struct path *path, const char *old_name)
 {
 	struct path old_path;
 	int err;
@@ -4475,7 +4476,8 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
 	return ret;
 }
 
-static inline int vfs_move_mount(struct path *from_path, struct path *to_path,
+static inline int vfs_move_mount(const struct path *from_path,
+				 const struct path *to_path,
 				 enum mnt_tree_flags_t mflags)
 {
 	int ret;
-- 
2.47.2


