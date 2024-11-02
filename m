Return-Path: <linux-fsdevel+bounces-33527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE6D9B9D15
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 06:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A512A1C221EE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 05:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E250D19CC2D;
	Sat,  2 Nov 2024 05:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ndOO70n+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F7F156C70;
	Sat,  2 Nov 2024 05:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730524115; cv=none; b=UnJj9n4XIqxvUDAknSE+8xubQNPix1Z/10nnio7M9knQXWaC+C6t5EpHX2jKlLBgIcYFD6Ban9ZqOxp9EGBqHmxK8TTBlx23JU88sIJPwPyn6qkXpexGRtKZ0g+95YgLlmcxa6Lw5FGB1u1YqZ6bQytfAXs2W0qiYHRTBR8Fy7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730524115; c=relaxed/simple;
	bh=y9A9hE1UH4j+XxOd0QcxpZAi3sxhvQPsBapMhwBR0Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HPTSzfGRObLfl7p2/U5ivTBBt9MZCLnCmZcRYn/OzLBMLGacwgnlGnwxqphk/BUNbZn1caxX0ubiLbk1DAcXyppo7Ih5Iw+K7BVsnkH8OVWEFe3E6DCA9aWd5IycVKVfBptMOTmfWIJECYfuXfZ/cKvhTv8qzCUFUL4m/BSg228=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ndOO70n+; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=WJ1jclsboPTR+HyjmMStNlGD9G7+6MgWUazJ2tWZgsA=; b=ndOO70n+uIHy58XRAJrdFYburi
	Wt6ZaIwnKIqafHMOLh7lFBDdiZ3qZIFeHN0JvxyfpXoLsqLqJkkpGs9exwhiDQvhe6vAnwEBYdbu6
	a4V/TLLpJfSfJK6MW3Mp7yXh2a4N9nAAMJ659vuER2vjCoHKJa6Xz2dP031bYN5HTu/TbfoFfi+xy
	kl4OCij1yN+zX2PehJUcsk0fq6aroM+A/ZyVkSV5CLnWk5ivOHjwpLflCFyjofOJP0sAtXOphZtbq
	KshUkesbAfhr0oEvy3nhwT6O9BloM6K+ZeXrnTAZwrQ2WXtDjP5XrkheYZsP2RJVQW2m88U1Ea/X5
	LDaZ4Asw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t76NC-0000000AHoS-3nEe;
	Sat, 02 Nov 2024 05:08:30 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH v3 26/28] memcg_write_event_control(): switch to CLASS(fd)
Date: Sat,  2 Nov 2024 05:08:24 +0000
Message-ID: <20241102050827.2451599-26-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241102050827.2451599-1-viro@zeniv.linux.org.uk>
References: <20241102050219.GA2450028@ZenIV>
 <20241102050827.2451599-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

some reordering required - take both fdget() to the point before
the allocations, with matching move of fdput() to the very end
of failure exit(s); after that it converts trivially.

simplify the cleanups that involve css_put(), while we are at it...

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 mm/memcontrol-v1.c | 44 +++++++++++++++-----------------------------
 1 file changed, 15 insertions(+), 29 deletions(-)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 81d8819f13cd..bc54cff7615f 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -1911,8 +1911,6 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
 	struct mem_cgroup_event *event;
 	struct cgroup_subsys_state *cfile_css;
 	unsigned int efd, cfd;
-	struct fd efile;
-	struct fd cfile;
 	struct dentry *cdentry;
 	const char *name;
 	char *endp;
@@ -1936,6 +1934,12 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
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
@@ -1946,20 +1950,13 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
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
@@ -1968,7 +1965,7 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
 	/* AV: shouldn't we check that it's been opened for read instead? */
 	ret = file_permission(fd_file(cfile), MAY_READ);
 	if (ret < 0)
-		goto out_put_cfile;
+		goto out_put_eventfd;
 
 	/*
 	 * The control file must be a regular cgroup1 file. As a regular cgroup
@@ -1977,7 +1974,7 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
 	cdentry = fd_file(cfile)->f_path.dentry;
 	if (cdentry->d_sb->s_type != &cgroup_fs_type || !d_is_reg(cdentry)) {
 		ret = -EINVAL;
-		goto out_put_cfile;
+		goto out_put_eventfd;
 	}
 
 	/*
@@ -2010,7 +2007,7 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
 		event->unregister_event = memsw_cgroup_usage_unregister_event;
 	} else {
 		ret = -EINVAL;
-		goto out_put_cfile;
+		goto out_put_eventfd;
 	}
 
 	/*
@@ -2022,11 +2019,9 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
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
@@ -2037,23 +2032,14 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
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
2.39.5


