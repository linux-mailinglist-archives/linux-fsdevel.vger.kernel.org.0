Return-Path: <linux-fsdevel+bounces-53733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FCAAF63FA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 23:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 350834E26E1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 21:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8A3279794;
	Wed,  2 Jul 2025 21:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="HcOE4+/P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F812DE6E2;
	Wed,  2 Jul 2025 21:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751491702; cv=none; b=GeG5DzKuATl00uUM932k8FgR40BHAF6IqATwXefDEHBiGG3mv/K17qmgEXCk93V3ZNkC53JyKOx4etTPecPS8jQPArC3KUAZb5psWQ4lBGL1B/rBai5m43SAa/o4UOcYNtQRRYF0/5VqchQg0cTDo8rdDyVTCErxKDr3NrvEmCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751491702; c=relaxed/simple;
	bh=rC/hi9QSQXWt5NH9NFWDg11yN3sHPqubrqAi8bKjntQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VV10t0kmj8yQZZf2fth5PuQJDMqEr7VJnASzSLUklMsNFVe5CFl7TU4c+KZUFOcBnp5FFXyQesDSpt7HOvExdNZavqrrwGlflV3UpDFTykc0nniMeKuX+fiJm9lBhFCwI94JQrztbZvY9fxMTbTJ1R42cUnFcqKRpNwkQ2VAw0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=HcOE4+/P; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3IWpTfuI42fP5pvclqV13nLmz5nNh5owCAXqwQb77zA=; b=HcOE4+/PvsKQ9VXbXwQLRPZJ1R
	RJjlNy1wsrhhDQ89QILGCPMFJ+FPG8BSuuSPdR9oyrRFoJE+n6mwu+0TaNq7rY4TXn+MdCz+lR4gg
	Nj9QwzYEdqaRn+9fyjfDP7rnNydIWimt4UNQvwXuRXTEliJZ3QS5SjLsEgXAdNoayCDYM/NzNOYK1
	v1wFWlBfD+QVotQBWfJWOZKCO5X4UmsR5M0O6NjJOt3Py4MpndtNoZI/OC1iHRdu00whe28R8V2bk
	vsXZamlaMRIqMLEpsDvb3QWO4XugEDGpte0l1RwXA48s04REAQ1N1gFALpIMFG7tUduK+QaL1pvkz
	6RVDdtAA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uX506-0000000EPG8-3ntL;
	Wed, 02 Jul 2025 21:28:19 +0000
Date: Wed, 2 Jul 2025 22:28:18 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH 10/11] blk-mq-debugfs: use debugfs_get_aux()
Message-ID: <20250702212818.GJ3406663@ZenIV>
References: <20250702211305.GE1880847@ZenIV>
 <20250702211408.GA3406663@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702211408.GA3406663@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

instead of manually stashing the data pointer into parent directory inode's
->i_private, just pass it to debugfs_create_file_aux() so that it can
be extracted without that insane chasing through ->d_parent.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 block/blk-mq-debugfs.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 29b3540dd180..7ed3e71f2fc0 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -521,7 +521,7 @@ CTX_RQ_SEQ_OPS(poll, HCTX_TYPE_POLL);
 static int blk_mq_debugfs_show(struct seq_file *m, void *v)
 {
 	const struct blk_mq_debugfs_attr *attr = m->private;
-	void *data = d_inode(m->file->f_path.dentry->d_parent)->i_private;
+	void *data = debugfs_get_aux(m->file);
 
 	return attr->show(data, m);
 }
@@ -531,7 +531,7 @@ static ssize_t blk_mq_debugfs_write(struct file *file, const char __user *buf,
 {
 	struct seq_file *m = file->private_data;
 	const struct blk_mq_debugfs_attr *attr = m->private;
-	void *data = d_inode(file->f_path.dentry->d_parent)->i_private;
+	void *data = debugfs_get_aux(file);
 
 	/*
 	 * Attributes that only implement .seq_ops are read-only and 'attr' is
@@ -546,7 +546,7 @@ static ssize_t blk_mq_debugfs_write(struct file *file, const char __user *buf,
 static int blk_mq_debugfs_open(struct inode *inode, struct file *file)
 {
 	const struct blk_mq_debugfs_attr *attr = inode->i_private;
-	void *data = d_inode(file->f_path.dentry->d_parent)->i_private;
+	void *data = debugfs_get_aux(file);
 	struct seq_file *m;
 	int ret;
 
@@ -612,11 +612,9 @@ static void debugfs_create_files(struct dentry *parent, void *data,
 	if (IS_ERR_OR_NULL(parent))
 		return;
 
-	d_inode(parent)->i_private = data;
-
 	for (; attr->name; attr++)
-		debugfs_create_file(attr->name, attr->mode, parent,
-				    (void *)attr, &blk_mq_debugfs_fops);
+		debugfs_create_file_aux(attr->name, attr->mode, parent,
+				    (void *)attr, data, &blk_mq_debugfs_fops);
 }
 
 void blk_mq_debugfs_register(struct request_queue *q)
-- 
2.39.5


