Return-Path: <linux-fsdevel+bounces-65141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F3DBFD14E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 18:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5482F561114
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26D230FC2A;
	Wed, 22 Oct 2025 16:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1Q2FIkh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB7B26FD9B;
	Wed, 22 Oct 2025 16:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149235; cv=none; b=Y9J5QSa7pOiGRA6o9w46ZPU2DNxmgtug1mynCWWyQDoTqGt20ykuqnD62oXyW41Oq955H34oH17d8Og34cji5A0E4I7x/3ZdnS+JaYd464hVdZkaVs+rd8oWC0tWOAeKK+MKOrEzgCqm3kDGXwM2kvQYhnkME0DmZjhZjzsYbHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149235; c=relaxed/simple;
	bh=j0WQly3wTCTevkshQpRfR9gFQtuZN2v/pgPj++s8+Zg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OC9GDYNhLCgzKIJQXehszr5G3M4iZTdhBcEJWFi0g3c9fXHLMTrRTp50zqLEONu1WDZPw8Z7UkVxjshJre2QXKMYhr8BCloqXflVVe+pyOElKuPC2B6QXhAOOtpX59XAbp9J0zruLg0ZlKr9WiX4uEuUHBQvGie+Fl0QpWMbFnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1Q2FIkh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34F4C4CEF7;
	Wed, 22 Oct 2025 16:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761149234;
	bh=j0WQly3wTCTevkshQpRfR9gFQtuZN2v/pgPj++s8+Zg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=O1Q2FIkhNW3glBSr4QrWFub+LpYikf5GOvbITTQYjXL27CPSiAIyZq9uskxHdgZIB
	 uOPdT4S4HXh3cgKJKxdL+ZgpGHDd2YcgVaNzI8QVpaCUOD4BdR9ZK5YR0Q2b7MSWTM
	 gUXYCWtoO2MTCThsxpbw9ilehUv419J9SuH4+AXXEZ1nuq+dp3neXKVIph97Ngcs5S
	 qXyMXUgl/0krSqkRpErgF1QESxCzFzl1CLvoy4/Rb/an5Q1YtXRfE2XRNa0ID7GVtk
	 jlYxTWosqJ6cbBJ+yHL0tRcMlFbFzRcxEqy/98dMyZQIHdeo3Vp/WVx/xJTtEq5C6o
	 CwGDd/SHOdRTg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 22 Oct 2025 18:05:51 +0200
Subject: [PATCH v2 13/63] nstree: allow lookup solely based on inode
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-work-namespace-nstree-listns-v2-13-71a588572371@kernel.org>
References: <20251022-work-namespace-nstree-listns-v2-0-71a588572371@kernel.org>
In-Reply-To: <20251022-work-namespace-nstree-listns-v2-0-71a588572371@kernel.org>
To: linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>
Cc: Jann Horn <jannh@google.com>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Amir Goldstein <amir73il@gmail.com>, Tejun Heo <tj@kernel.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, bpf@vger.kernel.org, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 netdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=1240; i=brauner@kernel.org;
 h=from:subject:message-id; bh=j0WQly3wTCTevkshQpRfR9gFQtuZN2v/pgPj++s8+Zg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8ZHhy0Uh8TvXrc8kuuksXPbES/X2Zocngq3Km0c3zs
 98K7zb70FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRW9MY/jvkamiof46R2vdX
 l5VVYJbh9clnf16OviNQPHPS1tKqEA9GhreZx7RSvd9tcLB9eHd39t60q6tvL3r230LksbBN9s4
 /trwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The namespace file handle struct nsfs_file_handle is uapi and userspace
is expressly allowed to generate file handles without going through
name_to_handle_at().

Allow userspace to generate a file handle where both the inode number
and the namespace type are zero and just pass in the unique namespace
id. The kernel uses the unified namespace tree to find the namespace and
open the file handle.

When the kernel creates a file handle via name_to_handle_at() it will
always fill in the type and the inode number allowing userspace to
retrieve core information.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/nsfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index ef9880232845..bbef9a49eb37 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -502,8 +502,8 @@ static struct dentry *nsfs_fh_to_dentry(struct super_block *sb, struct fid *fh,
 			return NULL;
 
 		VFS_WARN_ON_ONCE(ns->ns_id != fid->ns_id);
-		VFS_WARN_ON_ONCE(ns->ns_type != fid->ns_type);
-		VFS_WARN_ON_ONCE(ns->inum != fid->ns_inum);
+		if (fid->ns_inum && (fid->ns_inum != ns->inum))
+			return NULL;
 
 		/*
 		 * This is racy because we're not actually taking an

-- 
2.47.3


