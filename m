Return-Path: <linux-fsdevel+bounces-65454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E2667C05BF3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 13:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 057D5505119
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 11:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E7D31BC85;
	Fri, 24 Oct 2025 10:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bi8ShVAS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D102F313287;
	Fri, 24 Oct 2025 10:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303253; cv=none; b=CJjSXK6XNXFa8WVUnvPiGv3jdUCJboLlLnzKk2BryTfX68T5afBivSyQsIJ/55WCdBzEgnHFwfWYzQUivZOeVFhXZw3EfZ8PUPizkznL/eW5jzb9sa4qh/pJBrc9c9zigna6jYCca9PRHdzklvjHn1jVx+yz6hc3ZxPjR7QYmds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303253; c=relaxed/simple;
	bh=XlNTVHPsWhpdc2SiiHtveAAcuq9JAFNLIFuraBp1Wjs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SfuS++DAcT7e30H++v+h7Olgsvq9HRzD7k541mzMY0SrjgdcrdIzVlOFsasuLhIvRSsterNPgwm98JVa0SFDIT7e5j8Xs0Ah854E8Crzxh3fiedLaj3fyEWf3tpyL/2T1jbQOM45MptQY6yQMRzdAUghbH9ZzzTjU7qWRC80NuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bi8ShVAS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C29F7C4CEF1;
	Fri, 24 Oct 2025 10:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761303252;
	bh=XlNTVHPsWhpdc2SiiHtveAAcuq9JAFNLIFuraBp1Wjs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bi8ShVASZDe7TFMCaU15nPVFSxk7q3Z1YEguj/UUVxtY/FDkqd3rGSPldICKJJERm
	 x+YQ4gehppau2apFmcRP8MqJ0qlsgTDNYQx7kO71bL8A1ugSolFW+yO3c8gUjC5pFs
	 /lbyCFdbG45iDL1J9b3/2vbLKFd7r8a6AdDsATvD39kZulKrsQHjd0negZp4IeURT+
	 zEcFbbKlHQ+KYzQ/2u61yp7sCX7cu2M7Y8MnJQ/xx5m2qL5A1mOvn3eyAMyCvZuKOF
	 CHiN+q8Ak/k1khg24RzqZbczAlrUwZt7czhoIDTpgwhuBGJoLz6kL4gh1zUu4MiwfL
	 Eks8huUxV7oiA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 24 Oct 2025 12:52:43 +0200
Subject: [PATCH v3 14/70] nstree: allow lookup solely based on inode
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-work-namespace-nstree-listns-v3-14-b6241981b72b@kernel.org>
References: <20251024-work-namespace-nstree-listns-v3-0-b6241981b72b@kernel.org>
In-Reply-To: <20251024-work-namespace-nstree-listns-v3-0-b6241981b72b@kernel.org>
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
 h=from:subject:message-id; bh=XlNTVHPsWhpdc2SiiHtveAAcuq9JAFNLIFuraBp1Wjs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8jmrRNko7ktX7LuTwp5NMaQePubOsmbpwoYeamJn6R
 HGpMpXAjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIk8lGX4zfKv8EE6Z5uNZNJR
 Xo+q+PLNM0LM1huVH72iW/Gb/4fzcUaGOWd/8YXZLvFP2FH39PThdraoyZw2ejFc3no8zFv2/Pj
 CAQA=
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
index 8b9bebd11c49..19dc28742a42 100644
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


