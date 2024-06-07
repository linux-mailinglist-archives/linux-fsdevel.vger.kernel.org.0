Return-Path: <linux-fsdevel+bounces-21234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C879007F1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 17:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE4A41C22C39
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 15:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02721991B1;
	Fri,  7 Jun 2024 14:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyvXdza5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAB61990D9
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jun 2024 14:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717772154; cv=none; b=GgyDcAebp8QaIbWCe8pdCyfHzQLv95W4osrZPOcYkUGKC3QWohQ6E8TwJdyBL+K0/SuVbyYkDYm63iQ2sOnaOaerEVT4vJc/XpgFhnjua6g6ZQULZWgoDV35r/mVbrNS7iDqdLq1aZNh1GnCmZxOGuH685bAG/fcK4bMu4Z+fzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717772154; c=relaxed/simple;
	bh=XT752m2ZpER1NkGIF7sWtnOyCyqQcjmj71FGb9XAVz0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J1LwrEWc9UyuAqsWv27HNEg2PsM/1DtOUeuv45f+9mbUwSwuT0bz1m3ItN35XbG1uEjqzT+lo/ZuvsXWKO4K7s0n8EkWiT8N+/pmySEoikLIgykJbAzTpLr84+nUYLPICjzMc97SMLokM5HJZafDZeXuy6X9d/s4PPiIQzoSzTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eyvXdza5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD5CC3277B;
	Fri,  7 Jun 2024 14:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717772153;
	bh=XT752m2ZpER1NkGIF7sWtnOyCyqQcjmj71FGb9XAVz0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eyvXdza5zRy4l/W0ptzW7uIUSI6XCqRNpoQTtARWLICHhr/B+koVvigKkWzxmL+ax
	 88YJOrvpYFujFxlkS6v+KWLBtEupO5b9yqeta7YTyt7K0LkwbxEPLO9rWBC7EwjvOR
	 qqazSQUoJ+lkU0Yt/cDDptWD15bAuskoeeq7CpHUNaCTC1S0DQFhMXrre64JL41dtN
	 3FLsf/8uSHLD7T0eZJ2gk9hVTGB92fVQD6JCiXsrlxwtf1GaMxF6BT9uZHesoScFnG
	 IBMaOU3VBxbhMVPR68KahPcK/qS+rTdB/hJ5krBbxVmMXB7SU7dCDP73Al4jyKq3aJ
	 XhsT/ELFSChsg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 07 Jun 2024 16:55:34 +0200
Subject: [PATCH 1/4] fs: use semaphore gard in listmount()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-vfs-listmount-reverse-v1-1-7877a2bfa5e5@kernel.org>
References: <20240607-vfs-listmount-reverse-v1-0-7877a2bfa5e5@kernel.org>
In-Reply-To: <20240607-vfs-listmount-reverse-v1-0-7877a2bfa5e5@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, Karel Zak <kzak@redhat.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.14-dev-2ee9f
X-Developer-Signature: v=1; a=openpgp-sha256; l=923; i=brauner@kernel.org;
 h=from:subject:message-id; bh=XT752m2ZpER1NkGIF7sWtnOyCyqQcjmj71FGb9XAVz0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQly5cxHNqz3CJ31v/vdTM53xbm1Xn63/MznrtSRejNe
 6fnHc+NO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDaEi1MAJqK1nuGfUquOvdmx1fcXX67o
 ehrrFBStdlRWuebAbk0D3YS8uYt+MPxTWyTwWu/GrF8RH7M5Y2vNU/gv8srUHtbKLowUFeEsF2U
 AAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Instead of open-coding the locking use a guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 5a51315c6678..72c6e884728b 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5106,7 +5106,8 @@ SYSCALL_DEFINE4(listmount, const struct mnt_id_req __user *, req, u64 __user *,
 	mnt_parent_id = kreq.mnt_id;
 	last_mnt_id = kreq.param;
 
-	down_read(&namespace_sem);
+	guard(rwsem_read)(&namespace_sem);
+
 	get_fs_root(current->fs, &root);
 	if (mnt_parent_id == LSMT_ROOT) {
 		orig = root;
@@ -5125,7 +5126,6 @@ SYSCALL_DEFINE4(listmount, const struct mnt_id_req __user *, req, u64 __user *,
 	ret = do_listmount(first, &orig, mnt_parent_id, mnt_ids, nr_mnt_ids, &root);
 err:
 	path_put(&root);
-	up_read(&namespace_sem);
 	return ret;
 }
 

-- 
2.43.0


