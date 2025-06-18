Return-Path: <linux-fsdevel+bounces-52133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07991ADF823
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 22:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A38644A1503
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 20:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAFA20E71E;
	Wed, 18 Jun 2025 20:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VgBtZN7e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7DA21B9F4
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 20:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750280070; cv=none; b=NO4XpWhDMI+zNCH/xP8LZGuU4EbglHZMlHS2bkSzpMctTIPpEgK5/+ycve3zx8AV/RtQBgdyuLntRx3duakDpy5LeQH3zLhTYZ5sogyQUrCrTqXypybT/TH7xYRRhFv58eNYHZLijm1lXrGInlkOClIryj5ChlqK/C50uE5kWes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750280070; c=relaxed/simple;
	bh=o7xFeY8aY+kfvHfkaleOX5H1igQIfAu/CGpBdAhJKbw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jx9k/AdgdTwGxdMyQoa7DLEallkXV4kaCPOfnauKahZ0Io2jpT91za/SffeWrT8qCc+lmR91YfgLw3Lr+T5DoENQmhEBO9+f7HHj3WAS/KcxZG7qvWw94ZSGlK874nzkTmZljacxXk5KGsvc2F7Q57mNLJ8kbr+0E7xz1/oHiY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VgBtZN7e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E821EC4CEE7;
	Wed, 18 Jun 2025 20:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750280070;
	bh=o7xFeY8aY+kfvHfkaleOX5H1igQIfAu/CGpBdAhJKbw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VgBtZN7euDhUKnIYb+2Fvs5jiaP/mVME6VSt6BlzrgCHEUw7Vh0hoYbipQL6S4Q7i
	 RrfQ9VKDIlYy92hdvpMUxLQz0rUVy+m9bW+hl1EDUzEndLh3vnEgZ2usCAOf4ov0za
	 QoEr676Ndh59egaDshey8XA9j06LNHF/zi5n/oAL1zlGNeZ7+66hWYjoAlTiyrqyDP
	 TFAN8ghzQMU28Cz7G3DHUHCQ157NCCJzXYRukj6L3eJXZtPqGzBHMufDIL+lMVjQnI
	 24IbeX2+Ir5CW19Q8AikZ7h1/NDAVzDaxl68aAF4dXmNCGuGaH2J6v9WgWfoGWD7Nq
	 h7RzSAMYaIk6Q==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 18 Jun 2025 22:53:50 +0200
Subject: [PATCH v2 16/16] pidfs: add some CONFIG_DEBUG_VFS asserts
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-work-pidfs-persistent-v2-16-98f3456fd552@kernel.org>
References: <20250618-work-pidfs-persistent-v2-0-98f3456fd552@kernel.org>
In-Reply-To: <20250618-work-pidfs-persistent-v2-0-98f3456fd552@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
 Lennart Poettering <lennart@poettering.net>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-262a7
X-Developer-Signature: v=1; a=openpgp-sha256; l=774; i=brauner@kernel.org;
 h=from:subject:message-id; bh=o7xFeY8aY+kfvHfkaleOX5H1igQIfAu/CGpBdAhJKbw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQEq0f2vZtopc7xYer546ZeoimvNrMaLmgs93CfUrP/s
 u5LBy6ejlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlwPmBk2Mc3cfLqC4Xz5di/
 dCdvaM+SKZhwaMlWX8NN+0I28uZfCmX4n/k1PvK/oWRQTciepQ4Hpy0MveCzO/5Gyb6b/aqKu1f
 P5wQA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Allow to catch some obvious bugs.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 15d99854d243..1cf66fd9961e 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -809,6 +809,8 @@ static struct dentry *pidfs_fh_to_dentry(struct super_block *sb,
 	if (ret < 0)
 		return ERR_PTR(ret);
 
+	VFS_WARN_ON_ONCE(!pid->attr);
+
 	mntput(path.mnt);
 	return path.dentry;
 }
@@ -1038,6 +1040,8 @@ struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags)
 	if (ret < 0)
 		return ERR_PTR(ret);
 
+	VFS_WARN_ON_ONCE(!pid->attr);
+
 	flags &= ~PIDFD_STALE;
 	flags |= O_RDWR;
 	pidfd_file = dentry_open(&path, flags, current_cred());

-- 
2.47.2


