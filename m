Return-Path: <linux-fsdevel+bounces-20760-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D0B8D794A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 02:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B09081F21D5C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 00:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE64625;
	Mon,  3 Jun 2024 00:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="HlMaL/TE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC80391;
	Mon,  3 Jun 2024 00:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717373500; cv=none; b=lyoyNeAuFahMJyOWOiz6OJi475SjbkoNKvZ2unsfLo0pp1SkMs526c7F+VQ8axn6lK2VzfytI9I3TPSaQ6acq8hz6agRIbUYAoPomgHii2xRSX5LWMYL+Hxh8FsrrMLiW+yJtz8zACDfO0oAtD2spxSXJvjj43a3ZNpoQGdlD38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717373500; c=relaxed/simple;
	bh=0N9/3beR6r3NlBuOs+ExSKBxyVEUTdd78kumcqgbUFY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Jurvlb4zYM5+Ls3wQACcij7xUCfH5vcRgq3uVj0OWmOBmJl6freXBxa1wWtAKcCasN66EbIovH2PZ5b1WyfB/VRvR5z++ZzPKtYa60ck+Xoy7GzlHK4TNbBO8uy0liXQOBmaLU11YszWMzaV6nyUebOuLhRFn20X+tvGglHigLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=HlMaL/TE; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=k+aTG+7jrx2T4a778EpixhdD8FY1cMDJkJZ0swf1dBg=; b=HlMaL/TEtG1b+PO7ynkHuAVRQ9
	UQ+48uk2BOJmv6Y6LxcOdHn9GPPrahc06bbg/kJ/rExZAjb6mQAJXNMWeiDreerXv/zXS9wMv0BVV
	8tuAeebhvH4E4cYO5BwmtsHKBjSOsjzPlD13b1qHhreHk5e6w6b6GHxWlBpEENVm89Ty/TRXf+fD4
	OaZtbwvyUpCGVxyG8PP8e02pOH/U1O+y06L4DTeg7G55t7QzOCNnTxQDOv9nZsQ3JFBcPWWCxPxJC
	ni6/HJyttMMVF2XTx/LCT1Y5uOqvj2XULvGDAFsEA3HvPPT1FJkel8IflxsbSCekHwZS9zU9gJ7nE
	KR2ctH9w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sDvIO-00B9uk-1m;
	Mon, 03 Jun 2024 00:11:28 +0000
Date: Mon, 3 Jun 2024 01:11:28 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Jeffle Xu <jefflexu@linux.alibaba.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>, netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] get rid of close_fd() misuse in cachefiles
Message-ID: <20240603001128.GG1629371@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	fd_install() can't be undone by close_fd().  Just delay it
until the last failure exit - have cachefiles_ondemand_get_fd()
return the file on success (and ERR_PTR() on error) and let the
caller do fd_install() after successful copy_to_user()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 4ba42f1fa3b4..b5da26ef2d45 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -205,7 +205,7 @@ int cachefiles_ondemand_restore(struct cachefiles_cache *cache, char *args)
 	return 0;
 }
 
-static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
+static struct file *cachefiles_ondemand_get_fd(struct cachefiles_req *req)
 {
 	struct cachefiles_object *object;
 	struct cachefiles_cache *cache;
@@ -238,7 +238,6 @@ static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
 	}
 
 	file->f_mode |= FMODE_PWRITE | FMODE_LSEEK;
-	fd_install(fd, file);
 
 	load = (void *)req->msg.data;
 	load->fd = fd;
@@ -246,7 +245,7 @@ static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
 
 	cachefiles_get_unbind_pincount(cache);
 	trace_cachefiles_ondemand_open(object, &req->msg, load);
-	return 0;
+	return file;
 
 err_put_fd:
 	put_unused_fd(fd);
@@ -254,7 +253,7 @@ static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
 	xa_erase(&cache->ondemand_ids, object_id);
 err:
 	cachefiles_put_object(object, cachefiles_obj_put_ondemand_fd);
-	return ret;
+	return ERR_PTR(ret);
 }
 
 static void ondemand_object_worker(struct work_struct *work)
@@ -299,9 +298,9 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 {
 	struct cachefiles_req *req;
 	struct cachefiles_msg *msg;
+	struct file *file = NULL;
 	unsigned long id = 0;
 	size_t n;
-	int ret = 0;
 	XA_STATE(xas, &cache->reqs, cache->req_id_next);
 
 	xa_lock(&cache->reqs);
@@ -335,8 +334,8 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 	id = xas.xa_index;
 
 	if (msg->opcode == CACHEFILES_OP_OPEN) {
-		ret = cachefiles_ondemand_get_fd(req);
-		if (ret) {
+		file = cachefiles_ondemand_get_fd(req);
+		if (IS_ERR(file)) {
 			cachefiles_ondemand_set_object_close(req->object);
 			goto error;
 		}
@@ -346,10 +345,15 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 	msg->object_id = req->object->ondemand->ondemand_id;
 
 	if (copy_to_user(_buffer, msg, n) != 0) {
-		ret = -EFAULT;
-		goto err_put_fd;
+		if (file)
+			fput(file);
+		file = ERR_PTR(-EFAULT);
+		goto error;
 	}
 
+	if (file)
+		fd_install(((struct cachefiles_open *)msg->data)->fd, file);
+
 	/* CLOSE request has no reply */
 	if (msg->opcode == CACHEFILES_OP_CLOSE) {
 		xa_erase(&cache->reqs, id);
@@ -358,14 +362,11 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 
 	return n;
 
-err_put_fd:
-	if (msg->opcode == CACHEFILES_OP_OPEN)
-		close_fd(((struct cachefiles_open *)msg->data)->fd);
 error:
 	xa_erase(&cache->reqs, id);
-	req->error = ret;
+	req->error = PTR_ERR(file);
 	complete(&req->done);
-	return ret;
+	return PTR_ERR(file);
 }
 
 typedef int (*init_req_fn)(struct cachefiles_req *req, void *private);

