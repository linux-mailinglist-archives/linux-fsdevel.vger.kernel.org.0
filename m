Return-Path: <linux-fsdevel+bounces-65441-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57751C05B06
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 12:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96C2318922BC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 10:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C117C3128A3;
	Fri, 24 Oct 2025 10:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDMSPBmt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B7930E0E7;
	Fri, 24 Oct 2025 10:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303187; cv=none; b=T9XcYQ9gHvU/2RcE2yM7c8Y/xV+1pigDjBt/oqoFRLDeOGjBTnXwQKMKoA141aHdK+P8zwRd1YYAxlPZ4Wqmi9K7IXGTW0LQycrgZmzTEUA9wIc2oxO7vxu3wesIEobOlLN2KTjnCj/qDAaDRcaUlXZ6JFec+bSbdrfrrxBiIY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303187; c=relaxed/simple;
	bh=wpu8fA7qXxdZSYnV2Wt9hfd/qe1FdRoJcNk3AI3VvA4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u/JDPmQpntaK8qI0y+il9xyJhoQIsbdC2Id+KDm1cFt53jSfAdzoh0q2no6XuQZjy/LP4CO32fizgQn5s85D/QMv/8CKnibtJjSf0QgWecF6MbxvISPmqEFxUHxRusQfK6ZTanVFPJCqPAD2Pg6vdLDU+soCJ2Vfyd8jBI4lriQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDMSPBmt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D049C116B1;
	Fri, 24 Oct 2025 10:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761303186;
	bh=wpu8fA7qXxdZSYnV2Wt9hfd/qe1FdRoJcNk3AI3VvA4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kDMSPBmtRj26rFr7amHZs5Me8zv5KQtORio0ATW0/AFODAt5alD3IEK7bsLKalrft
	 J1cxy7Z3v/ol+zt03ogwZo04go708SQhx4OYyFJJwULhnejlUcS/eDrQnjCbbyG4hD
	 FhLlpywHhBXgRx1gkv0Mp3ZkRPMV6nx7X3NmH0joDVPxXz5lbjzMfT9/7ddZo6D+Yf
	 T5D32b/SM9GoH0KkF+FCbKIzA2UQtFVnQBDhhYpNeWticNUXXWEkzWqa80jOVR/mE9
	 FxZD56xfSSdSnAlAXjPt7C4N6HO3W0kwOPa0qoZEKVPCd1CqTdU1+XHykf160eCuWD
	 Fi/h2exnYRAGg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 24 Oct 2025 12:52:30 +0200
Subject: [PATCH v3 01/70] libfs: allow to specify s_d_flags
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-work-namespace-nstree-listns-v3-1-b6241981b72b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1073; i=brauner@kernel.org;
 h=from:subject:message-id; bh=wpu8fA7qXxdZSYnV2Wt9hfd/qe1FdRoJcNk3AI3VvA4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8jmrp8UqpYDYQ/PZsj+1N+7VnLt/5lFgWMZvnwfGte
 94xOvhHdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzk0xZGhi7nL2mXfQ4d9TgS
 Pm+J8qejLOK50644C/SlHuI/l2F+npmRYc3d/Le2q/tkjpyJcffj1lrz5aJZ+ARV472TW+tcKpo
 XsgEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Make it possible for pseudo filesystems to specify default dentry flags.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/libfs.c                | 1 +
 include/linux/pseudo_fs.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/libfs.c b/fs/libfs.c
index ce8c496a6940..4bb4d8a313e7 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -680,6 +680,7 @@ static int pseudo_fs_fill_super(struct super_block *s, struct fs_context *fc)
 	s->s_export_op = ctx->eops;
 	s->s_xattr = ctx->xattr;
 	s->s_time_gran = 1;
+	s->s_d_flags |= ctx->s_d_flags;
 	root = new_inode(s);
 	if (!root)
 		return -ENOMEM;
diff --git a/include/linux/pseudo_fs.h b/include/linux/pseudo_fs.h
index 2503f7625d65..a651e60d9410 100644
--- a/include/linux/pseudo_fs.h
+++ b/include/linux/pseudo_fs.h
@@ -9,6 +9,7 @@ struct pseudo_fs_context {
 	const struct xattr_handler * const *xattr;
 	const struct dentry_operations *dops;
 	unsigned long magic;
+	unsigned int s_d_flags;
 };
 
 struct pseudo_fs_context *init_pseudo(struct fs_context *fc,

-- 
2.47.3


