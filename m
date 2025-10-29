Return-Path: <linux-fsdevel+bounces-66227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84829C1A3C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71F48562F71
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 12:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA281350D75;
	Wed, 29 Oct 2025 12:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IESlURWP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BF3350D44;
	Wed, 29 Oct 2025 12:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740510; cv=none; b=KcswvWOS2FDNpH9yDkjIGOZkRXe3w9hCTPiBfBr1dIvU2B2tD8oxDHawPX6RN3/mEMDkpx3PpvVulWCf8Q+bxpwbWmQ93+ur+rrE8/gHE6Sk1SoWl0aYjhDEuFSgQ8P8Zr8rwgHH2XJcHZ9iIrPHX/4Le73lbC2bHpDdIehNYH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740510; c=relaxed/simple;
	bh=MytxepP0DfHSoS+/OXNPO9l7OLu6SuN3axgNA99B+CQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H5wEHtVsarN4k+Vub6jUHdvocyor8sq8eNT3eqBNddv3wpnAt/6ALuEYtb+22eABdeDXHXjtM21MVR6nR3s2JzlHMjjX/BSO+CI7wZnPLkSw9O/2zAsyjpr3a+NPgRbC2mUojFG3jkO4roM74zSHI3N0tH74xfNuM5foVioi6rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IESlURWP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE97C4CEF7;
	Wed, 29 Oct 2025 12:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761740509;
	bh=MytxepP0DfHSoS+/OXNPO9l7OLu6SuN3axgNA99B+CQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IESlURWPE9H7GfHgu5SdcDuWq6OnRHQitBMAr7+NniY5jzdAP9YvZ49kW5qvx52Gx
	 eQ3CdZmjM2YJektWQZ8Ed378B/94RoDNQs9jlPuHZl9lzUirH8KCEld9v7EW4WxII3
	 dS2YR4w3HThA64wuFJP5bVNph6FcKrnm/c071qcPw49LARQeZES90TvCyF41FdLOJ5
	 4MrXdhmyKjzOa//5ZpV+Yf9o1h6ueW4RXvWCDmIYfKaZCJBoI83cuL0nyjK4tv1w5t
	 v0TSfzptikfV5kqEi5ePpPVntpLTQK3dCMBb4OD5CTwt9v237LiocdHVm1dGEG6uL3
	 yY0z/g7fD0ivw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 29 Oct 2025 13:20:27 +0100
Subject: [PATCH v4 14/72] nstree: allow lookup solely based on inode
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-work-namespace-nstree-listns-v4-14-2e6f823ebdc0@kernel.org>
References: <20251029-work-namespace-nstree-listns-v4-0-2e6f823ebdc0@kernel.org>
In-Reply-To: <20251029-work-namespace-nstree-listns-v4-0-2e6f823ebdc0@kernel.org>
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
 h=from:subject:message-id; bh=MytxepP0DfHSoS+/OXNPO9l7OLu6SuN3axgNA99B+CQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQysfUYR+/ZEPnpq60cd8W5gga5wB/bWH/O+V/KVX4lg
 9Hhd9q8jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImYvmBkOPfxsU/VtU+bzW8z
 LusV/jlRoGWdluVPY8nyC+mnI0seLmdkmH54kX2X+1m/Gp71ktt26N0SCPxx/ZRGyxl5DQvhQLN
 fvAA=
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
index a6a28d9cb55d..201d6de53353 100644
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


