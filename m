Return-Path: <linux-fsdevel+bounces-64863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0A6BF6256
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 13:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C06419A180F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 11:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC997339B32;
	Tue, 21 Oct 2025 11:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYJboOxS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102183321B3;
	Tue, 21 Oct 2025 11:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761047093; cv=none; b=GmUtrHMSPg8Ee88v1GV8I/aZWByeylj0+b+SAh49Oe9eXvUfA/8/oNQ7ePWSFcBnDqZj2wRDiYJlKRbGfV9hbBUp5L+6UJyqIece7mQnT50RVdnw/em07wK84LZRgrIkwIN1uk4QNaWISNyJoh1py2dw1pDn4VYmObLchC045Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761047093; c=relaxed/simple;
	bh=eWr4sp3ZFxiKmdi2bQvM/V/b89IuZ5Yj6h5wRkppsEI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H5VpitGPhsAbYoY8/LFvyIT2bf+smOxlq4GtCsCbCFyGB2MTvegVWQIBz5XkJv54tZdlLASM16rN3WwUMTvCeL2Xu2Ywxd3yzYxSbWgDPmLDP3Pc2EjykUjjGj9ELGfUgpX6ip2bkDkglhz2+tKKVlBWJVYv+mlmxnlHLLx4IYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYJboOxS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0121BC4CEF1;
	Tue, 21 Oct 2025 11:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761047092;
	bh=eWr4sp3ZFxiKmdi2bQvM/V/b89IuZ5Yj6h5wRkppsEI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JYJboOxSdjvgZ72iFp79ep7mtAlNBvWehcuffbFyhLCGqjmqEdiB1uXDSS4Xp8+Z9
	 2w91e6Vjl2WDorjBQI5+IjlpJwYIwsIlIspjbS0Sve398GNcLurAY/UqxJs73mlLZK
	 6izkD33g4iuZ8Tnncrrw0kkboPpI9XhTwnOxNyaC0XYFZstVba/uWLwEVgIm7fFJyn
	 uAqbYyfsWGCY/5ZxIGDrGMUdVEjJ24/PP7mNqA2Q7r4UVOfnaH/Iu2Wbdce7NAcE3S
	 EiMv950HoBaMRtimjoX+w+5GoB834LKRi3eF2U6rBGegU4CDqmUpDqIDmLPUZr6ZGc
	 8QCBA5S25IyAg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 21 Oct 2025 13:43:18 +0200
Subject: [PATCH RFC DRAFT 12/50] nstree: allow lookup solely based on inode
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-work-namespace-nstree-listns-v1-12-ad44261a8a5b@kernel.org>
References: <20251021-work-namespace-nstree-listns-v1-0-ad44261a8a5b@kernel.org>
In-Reply-To: <20251021-work-namespace-nstree-listns-v1-0-ad44261a8a5b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1215; i=brauner@kernel.org;
 h=from:subject:message-id; bh=eWr4sp3ZFxiKmdi2bQvM/V/b89IuZ5Yj6h5wRkppsEI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR8L3z7wVL2f3n670Bxkc6KRlWndfMjz51+nyhYKy+w7
 q++3o3EjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIk8PcXwh/O43b0f68z6I2v+
 3ZpuzXPTJkywqWtlm/AlBTXzr462jxgZ1lXJzlW5yXD5iKNEzQSlq0fkvhu36LuoddfpHnz/xUi
 RGwA=
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
index a190e1e38442..ba5863ee4150 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -496,8 +496,8 @@ static struct dentry *nsfs_fh_to_dentry(struct super_block *sb, struct fid *fh,
 			return NULL;
 
 		VFS_WARN_ON_ONCE(ns->ns_id != fid->ns_id);
-		VFS_WARN_ON_ONCE(ns->ns_type != fid->ns_type);
-		VFS_WARN_ON_ONCE(ns->inum != fid->ns_inum);
+		if (fid->ns_inum && (fid->ns_inum != ns->inum))
+			return NULL;
 
 		if (!ns_get(ns))
 			return NULL;

-- 
2.47.3


