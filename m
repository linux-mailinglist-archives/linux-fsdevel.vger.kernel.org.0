Return-Path: <linux-fsdevel+bounces-67708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0CCC47736
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 16:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D1A41893991
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 15:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F0F32570B;
	Mon, 10 Nov 2025 15:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ij2YPvvI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D76324B30;
	Mon, 10 Nov 2025 15:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762787373; cv=none; b=Vt01lGGt8qfO2D4pTCt1PuE9pwp4EbdiY0wfykR0hJqECFh0fqU5FSVY3MwGU4AfFlxSU/sbUKs4CPFBAh4UfeHxXUsM/nO/0R/UdQ/1T42xL45qZfBDt6XA15vUtdp9J2AISadsifQilbhy4E2nEcnH04f6jkTeWwsBpRjk0uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762787373; c=relaxed/simple;
	bh=OiZjviKQjU08OlUi4t2BENexV5D4xornk0SbQ9lo5Do=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mgaC8stgIp4Ehz7DNJxaNPYdnPnk8hTBbInvS0OTzN8R9A1Jno1sMB+FoF0cRZ9VR2DuqtgtljVCRbe9Oduuc4i5bzsIMoqgnIM0wc5JIPDbat0WU9F+84CVVVB4VcEakFraE7GhoEKYHjTj92m003kHzXYJ3LKdorBvUQIbXBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ij2YPvvI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE1FEC113D0;
	Mon, 10 Nov 2025 15:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762787373;
	bh=OiZjviKQjU08OlUi4t2BENexV5D4xornk0SbQ9lo5Do=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ij2YPvvI+QorgA98O/jD9q+PPCzvr2A41SESN6SJ95E8aObVpFfYvcndZNt6CWdM4
	 52XZ1eKK/v4DmXxjQY66vWOt0XOkha4HhdPV+pQa3dYhHePVfhIQBtkeaaok3FhmBn
	 lRv/GDPemSSgKxfP3QKYnVOULMRR1wyDRjnbwTUEvTGwNDQmh0/E5E0gRxKO7gtUq7
	 SlTknudc771PZYu84j62hzaPcqr3pq+hCUV/qCdvPIVQaxkL9SD7ZHiXSRcnepVzvU
	 X53go0dMucVWxH8RH6In0dfxRS1FHk1XJvA8xhXR2BY8RGQ7Pz16ktWZ54E1fDenMz
	 6/n8GTEBz89LQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 10 Nov 2025 16:08:22 +0100
Subject: [PATCH 10/17] fs: use boolean to indicate anonymous mount
 namespace
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-work-namespace-nstree-fixes-v1-10-e8a9264e0fb9@kernel.org>
References: <20251110-work-namespace-nstree-fixes-v1-0-e8a9264e0fb9@kernel.org>
In-Reply-To: <20251110-work-namespace-nstree-fixes-v1-0-e8a9264e0fb9@kernel.org>
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
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1757; i=brauner@kernel.org;
 h=from:subject:message-id; bh=OiZjviKQjU08OlUi4t2BENexV5D4xornk0SbQ9lo5Do=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQK/v9sNyWiINjt6hXJbbkBalsYvEuTIpwzrln1VC1xL
 VJK7s3pKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmEitNSPDAQ/n43M/BjSrby1a
 /+aye41BtVTXt/dmacsfXbj6fu7P+wz/U8T/7XlzRtiaPWe66vmfV/mv77sVpqbi1iGlEv6o7OB
 +LgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Stop playing games with the namespace id and use a boolean instead:

* This will remove the special-casing we need to do everywhere for mount
  namespaces.

* It will allow us to use asserts on the namespace id for initial
  namespaces everywhere.

* It will allow us to put anonymous mount namespaces on the namespaces
  trees in the future and thus make them available to statmount() and
  listmount().

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/mount.h     | 3 ++-
 fs/namespace.c | 5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/mount.h b/fs/mount.h
index f13a28752d0b..2d28ef2a3aed 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -27,6 +27,7 @@ struct mnt_namespace {
 	unsigned int		nr_mounts; /* # of mounts in the namespace */
 	unsigned int		pending_mounts;
 	refcount_t		passive; /* number references not pinning @mounts */
+	bool			is_anon;
 } __randomize_layout;
 
 struct mnt_pcp {
@@ -175,7 +176,7 @@ static inline bool is_local_mountpoint(const struct dentry *dentry)
 
 static inline bool is_anon_ns(struct mnt_namespace *ns)
 {
-	return ns->ns.ns_id == 0;
+	return ns->is_anon;
 }
 
 static inline bool anon_ns_root(const struct mount *m)
diff --git a/fs/namespace.c b/fs/namespace.c
index ad19530a13b2..efaff8680eaf 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4093,8 +4093,9 @@ static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *user_ns, bool a
 		dec_mnt_namespaces(ucounts);
 		return ERR_PTR(ret);
 	}
-	if (!anon)
-		ns_tree_gen_id(new_ns);
+	ns_tree_gen_id(new_ns);
+
+	new_ns->is_anon = anon;
 	refcount_set(&new_ns->passive, 1);
 	new_ns->mounts = RB_ROOT;
 	init_waitqueue_head(&new_ns->poll);

-- 
2.47.3


