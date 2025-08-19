Return-Path: <linux-fsdevel+bounces-58249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 235A7B2B822
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 05:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E72C81B60B57
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 03:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281D52D24AF;
	Tue, 19 Aug 2025 03:57:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F3E20B80D;
	Tue, 19 Aug 2025 03:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755575847; cv=none; b=MjdU5h3Kwk54P04cRluxTRx8E+6UgTHA4yMzg95doGvuolTYKVjK6AcXiMh8lxvmpj5IZjTprlJqjoj8o9fhtqlPRdfgHbetIQilG5jIk5Dap9wfJmWD3pYrCnqao3WCx97jfT+d2G5YUJ1HeykqYCFUYQKc0/pedAQuj2ounfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755575847; c=relaxed/simple;
	bh=Q/etQNA8XJ8N84jSDBTgzKqb+RRBSlGEL6z3r/Tt81s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M7CqaRl3lFjopmA/rl37GsMehi7bFHNSPJ3huMZiAIUetAb8TdnpIafjwjUBhH0SulQfPHwKjnCrZwpP7BJpN1rJDG9fBIrqXvhYugZB+ul+w1yi3MtMr8+aUSzttl/m2Hehowp3+go2lh/Ydl6VZ5wcEj/7KLUfchI4gY3izug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu; spf=pass smtp.mailfrom=ustc.edu; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ustc.edu
Received: from localhost (unknown [14.116.239.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1fd1b3e58;
	Tue, 19 Aug 2025 11:52:08 +0800 (GMT+08:00)
From: Chunsheng Luo <luochunsheng@ustc.edu>
To: luis@igalia.com
Cc: bernd@bsbernd.com,
	david@fromorbit.com,
	kernel-dev@igalia.com,
	laura.promberger@cern.ch,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mharvey@jumptrading.com,
	miklos@szeredi.hu
Subject: Re: [PATCH v4] fuse: new work queue to periodically invalidate expired dentries
Date: Tue, 19 Aug 2025 11:52:08 +0800
Message-ID: <20250819035208.540-1-luochunsheng@ustc.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250707153413.19393-1-luis@igalia.com>
References: <20250707153413.19393-1-luis@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a98c074ad1603a2kunmf38e4f903be0c2
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCHxhPVh1ITRhNT0kYGBhJGVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKT1VKSk1VSUhCVUhPWVdZFhoPEhUdFFlBWU9LSFVKS0lCTUtKVUpLS1VLWQ
	Y+

On Mon,  7 Jul 2025 16:34:13 Luis Henriques wrote:

>+static void fuse_dentry_tree_add_node(struct dentry *dentry)
>+{
>+	struct fuse_conn *fc = get_fuse_conn_super(dentry->d_sb);
>+	struct fuse_dentry *fd = dentry->d_fsdata;
>+	struct fuse_dentry *cur;
>+	struct rb_node **p, *parent = NULL;
>+	bool start_work = false;
>+
>+	if (!fc->inval_wq)
>+		return;

First check.

>+
>+	spin_lock(&fc->dentry_tree_lock);
>+
>+	if (!fc->inval_wq) {
>+		spin_unlock(&fc->dentry_tree_lock);
>+		return;
>+	}

Check again.

I don't think the if (!fc->inval_wq) check needs to be re-evaluated
while holding the lock. The reason is that the inval_wq variable 
doesn't appear to require lock protection. It only gets assigned 
during fuse_conn_init and fuse_conn_destroy. Furthermore, 
in fuse_conn_destroy we set inval_wq to zero without holding a lock, 
and then synchronously cancel any pending work items. 

Therefore, performing this check twice with if (!fc->inval_wq) 
seems unnecessary.

Also, in the subject, it would be more appropriate to change
"work queue" to "workqueue".

Thanks
Chunsheng Luo

>+
>+	start_work = RB_EMPTY_ROOT(&fc->dentry_tree);
>+	__fuse_dentry_tree_del_node(fc, fd);
>+
>+	p = &fc->dentry_tree.rb_node;
>+	while (*p) {
>+		parent = *p;
>+		cur = rb_entry(*p, struct fuse_dentry, node);
>+		if (fd->time > cur->time)
>+			p = &(*p)->rb_left;
>+		else
>+			p = &(*p)->rb_right;
>+	}
>+	rb_link_node(&fd->node, parent, p);
>+	rb_insert_color(&fd->node, &fc->dentry_tree);
>+	spin_unlock(&fc->dentry_tree_lock);
>+
>+	if (start_work)
>+		schedule_delayed_work(&fc->dentry_tree_work,
>+				      secs_to_jiffies(fc->inval_wq));
>+}

