Return-Path: <linux-fsdevel+bounces-24569-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81ED7940780
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 07:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACA881C2269C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 05:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A837C1A01CD;
	Tue, 30 Jul 2024 05:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4WS1uur"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C7E1A01AE;
	Tue, 30 Jul 2024 05:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722316522; cv=none; b=dP0VduZsdfE9NpXRqqHd6vBeGnDpyyKWGGQsZhFUPLZHemns6kzeb+1ITVrdbzDGOriatOZsV72+bZgh+nzjKbQRVA5nUvQBZyIjVEbdVcVr+mqbaswwQqWIY8n8UyFichmSCFYvTLXrTETmKWmStTqZSWksTL+YUywSbr7JU3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722316522; c=relaxed/simple;
	bh=aUoBejbujiMz+wTDOR0WpWX6hK62a/dCX4v7RBavop8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hrENWCBjcQ3YgsGuwb3JSDzk/7OaFRMjLlp2lbMLEL19nFxVU3fTQQhZXjT6hzUL9qdqy05fMJ3D55bnH/gSx0qDz9XS1w9ABgH1uPqulWPQi8743ZynoiJE/121c8bgdPyZFLRtN2mlW1ALqxjq6ga+YSXcjtF7dLa07Kk3lOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4WS1uur; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB2C2C4AF0A;
	Tue, 30 Jul 2024 05:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722316521;
	bh=aUoBejbujiMz+wTDOR0WpWX6hK62a/dCX4v7RBavop8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F4WS1uurKcX/JKpG4KFx35YJ7/pByzQqnCOySXCLOF1YUyX2CsiS2HEEE8RMnVWOU
	 L3M/kkckZJ61tP1/wp2i5hRavvJxS/AFFZjfOvNgqGERmiDom0BNLEgL1mn7lTQRP4
	 /tU1dG6LR1CjAYjs3s/swk2hIVAoW5lwT64A4GdoSd1wU7Av1dorXF3BhXJzZc+pbo
	 RKKrKa2OjLTcv+Dn5nMh5ou1aN+pDBqT/Ke5Y3KFQWMM/g4k2D34e20jcbb7JFKVlk
	 MNIpw5S5q8M62X0XCH3FKcDGtOC3ZEoN/7E/Nek2jx7U7bmsS0UKWMxB5Rz6kl+1d/
	 mKtJZF4J8FKPQ==
From: viro@kernel.org
To: linux-fsdevel@vger.kernel.org
Cc: amir73il@gmail.com,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH 37/39] memcg_write_event_control(): switch to CLASS(fd)
Date: Tue, 30 Jul 2024 01:16:23 -0400
Message-Id: <20240730051625.14349-37-viro@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240730051625.14349-1-viro@kernel.org>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

some reordering required - take both fdget() to the point before
the allocations, with matching move of fdput() to the very end
of failure exit(s); after that it converts trivially.

simplify the cleanups that involve css_put(), while we are at it...

[stuff moved in mainline]

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 mm/memcontrol-v1.c | 44 +++++++++++++++-----------------------------
 1 file changed, 15 insertions(+), 29 deletions(-)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 9725c731fb21..478bb3130c1b 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -1824,8 +1824,6 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
 	struct mem_cgroup_event *event;
 	struct cgroup_subsys_state *cfile_css;
 	unsigned int efd, cfd;
-	struct fd efile;
-	struct fd cfile;
 	struct dentry *cdentry;
 	const char *name;
 	char *endp;
@@ -1849,6 +1847,12 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
 	else
 		return -EINVAL;
 
+	CLASS(fd, efile)(efd);
+	if (fd_empty(efile))
+		return -EBADF;
+
+	CLASS(fd, cfile)(cfd);
+
 	event = kzalloc(sizeof(*event), GFP_KERNEL);
 	if (!event)
 		return -ENOMEM;
@@ -1859,20 +1863,13 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
 	init_waitqueue_func_entry(&event->wait, memcg_event_wake);
 	INIT_WORK(&event->remove, memcg_event_remove);
 
-	efile = fdget(efd);
-	if (!fd_file(efile)) {
-		ret = -EBADF;
-		goto out_kfree;
-	}
-
 	event->eventfd = eventfd_ctx_fileget(fd_file(efile));
 	if (IS_ERR(event->eventfd)) {
 		ret = PTR_ERR(event->eventfd);
-		goto out_put_efile;
+		goto out_kfree;
 	}
 
-	cfile = fdget(cfd);
-	if (!fd_file(cfile)) {
+	if (fd_empty(cfile)) {
 		ret = -EBADF;
 		goto out_put_eventfd;
 	}
@@ -1881,7 +1878,7 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
 	/* AV: shouldn't we check that it's been opened for read instead? */
 	ret = file_permission(fd_file(cfile), MAY_READ);
 	if (ret < 0)
-		goto out_put_cfile;
+		goto out_put_eventfd;
 
 	/*
 	 * The control file must be a regular cgroup1 file. As a regular cgroup
@@ -1890,7 +1887,7 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
 	cdentry = fd_file(cfile)->f_path.dentry;
 	if (cdentry->d_sb->s_type != &cgroup_fs_type || !d_is_reg(cdentry)) {
 		ret = -EINVAL;
-		goto out_put_cfile;
+		goto out_put_eventfd;
 	}
 
 	/*
@@ -1917,7 +1914,7 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
 		event->unregister_event = memsw_cgroup_usage_unregister_event;
 	} else {
 		ret = -EINVAL;
-		goto out_put_cfile;
+		goto out_put_eventfd;
 	}
 
 	/*
@@ -1929,11 +1926,9 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
 					       &memory_cgrp_subsys);
 	ret = -EINVAL;
 	if (IS_ERR(cfile_css))
-		goto out_put_cfile;
-	if (cfile_css != css) {
-		css_put(cfile_css);
-		goto out_put_cfile;
-	}
+		goto out_put_eventfd;
+	if (cfile_css != css)
+		goto out_put_css;
 
 	ret = event->register_event(memcg, event->eventfd, buf);
 	if (ret)
@@ -1944,23 +1939,14 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
 	spin_lock_irq(&memcg->event_list_lock);
 	list_add(&event->list, &memcg->event_list);
 	spin_unlock_irq(&memcg->event_list_lock);
-
-	fdput(cfile);
-	fdput(efile);
-
 	return nbytes;
 
 out_put_css:
-	css_put(css);
-out_put_cfile:
-	fdput(cfile);
+	css_put(cfile_css);
 out_put_eventfd:
 	eventfd_ctx_put(event->eventfd);
-out_put_efile:
-	fdput(efile);
 out_kfree:
 	kfree(event);
-
 	return ret;
 }
 
-- 
2.39.2


