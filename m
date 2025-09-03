Return-Path: <linux-fsdevel+bounces-60084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BBFB413EF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81CD76814E4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFC22D9782;
	Wed,  3 Sep 2025 04:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="d26A+aEc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CA92D4B7C
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875348; cv=none; b=svouclTRSu3BufrmK6lxj0Au86fuuUMqxs16b4lFrHUFJ0yEVoGXl26sKj+/6mb1JCvwMfdWLGGJb7UkClHnTCABkhqUssuQVtSDAfzRcUXZCSLKK7CZtMGbOv8etdUpL3lkat6Ex6fWZ4BT8jOl/va+QGHjie2guDjt+MtTRNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875348; c=relaxed/simple;
	bh=RQVLkimqqL/aTKR5HZPMHcpgwLLQBcTVo7KVc2W5Yc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sah0vdfp3G6nOo6/HJdcMJUKmYTwHjM/PC63E4rckJ4n2N/fAEY5yMDEL5DNiTBDUIIwWdTv0TiiDaRaXP86ycvvugYDEvRLqw9AEHB9NTvwvFRy394x+rQl3/cFPvo6cuuimgbbCch84/PTKXS1kzO7kdhPObExfnXIo+nMJ/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=d26A+aEc; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=qAC+mRleCqfh6GP7zB/CSixuSNqVGCyT4Dntsl3mF1w=; b=d26A+aEcvoOXaOWh8rGWWmQibt
	+vitm8LUDwQuMM0H0kcN5ysp51Ol3M+vWO9PlXvpU9mB8jhoT2X6SbMY1SPZoX1ZoAxq8J6VuZLTd
	l41GD3nf2sM9Zgyo2msmopyO0pzA9Ke9e4TBpkmt9PjAO/fRUgYLcBIjKQ9bv+Hzdzx3Xfu81pJiF
	5XnNhOLMWCJDxR5btPGAOEUD7m6EiYcF6bQLvs4KMxhy3UmPIbh9ND0oKNPW8p10FRzr7IVWlnwkc
	3YygB8BdAjhnXL21klVzq58OUoUehbWOhsvGIYSfxdrSaOTZScRRDbLFOtH+Piq/tMLB8mWIJgzXj
	1+DFMT7w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfX7-0000000ApCv-2FN5;
	Wed, 03 Sep 2025 04:55:45 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 41/65] do_move_mount(), vfs_move_mount(), do_move_mount_old(): constify struct path argument(s)
Date: Wed,  3 Sep 2025 05:55:03 +0100
Message-ID: <20250903045537.2579614-42-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
References: <20250903045432.GH39973@ZenIV>
 <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
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
index 759bfd24d1a0..dcaf50e920af 100644
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


