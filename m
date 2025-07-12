Return-Path: <linux-fsdevel+bounces-54745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59150B02971
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 07:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F33F21C20046
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 05:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4BE1FBE8A;
	Sat, 12 Jul 2025 05:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="bs+yfsuG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE10F149DE8
	for <linux-fsdevel@vger.kernel.org>; Sat, 12 Jul 2025 05:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752296961; cv=none; b=RnO1zqiabDHRfnhkHptkLky4IHEC4TwKNa5NWtdvd+IOvMjyFhaYj3XUd4cpLdHOWEahCKbukjByBaYWhu9XjMHf4Yj6bneov1NOd0gOTF5DVUO6+r9T49fnXr+aBB6WcO+4GF81HJ5HptUq7YaC/EZomALlNx1bC5OJxB+UbTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752296961; c=relaxed/simple;
	bh=2xb0zpZVAIjPxxxkd7c8i9PksMLHEjiqxCqO4EgHE0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DII6G8v2ndacBFg4SrwqATBUIXziEEMXaLLWM18yazN7T4mAZrhJLWunOS1+Zi+RiwLiAHsH/Qx+DkPMHAijPmHJ1/ntF9yW/ORhMF0PTziX9U6Au7Jq0XqmiOp6+PUdSpMR8nLc7wKYYHdl+UfI3+3clKv5EiOSy8DPO2k+wdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=bs+yfsuG; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=l4nwspgTz+l9sR3355o4FMkPkNZdY9hGjiuSmrLjNKU=; b=bs+yfsuG7XRj1XO/uN9MEmhgnk
	kRzQL0dv2QpI5YIms7g6hHjuC4wqhfKIik6IBzc8/sfbylyMg8dKMuRFsrAgi+PMreOCQ21wosqLk
	wp4m1EZO9cIXpTqEGkvnoP+B4XTaXc7NREarbT0f1BiYOEu/E2vL72V2cBgcSGB8esTK+qlHDKYZz
	symoirS4r9mfFmCDWqmOjzi/mn2c2lKigTAPwCH7yNqU2QJTjI6isKuOjjw0WsDUYkOHcBhKubim8
	2YBMuBFKZ9E4f+CbFpCDVNqgyCs5wmv0GdFF69YZ6lCGKWlG9PSC5e7kKf/bqBqHyfoO3mnts7DBi
	7PCNmGAw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uaSU8-00000004dvA-2G9U;
	Sat, 12 Jul 2025 05:09:17 +0000
Date: Sat, 12 Jul 2025 06:09:16 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Subject: [PATCH 2/2] xen: fix UAF in dmabuf_exp_from_pages()
Message-ID: <20250712050916.GY1880847@ZenIV>
References: <20250712050231.GX1880847@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250712050231.GX1880847@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

[dma_buf_fd() fixes; no preferences regarding the tree it goes through -
up to xen folks]

As soon as we'd inserted a file reference into descriptor table, another
thread could close it.  That's fine for the case when all we are doing is
returning that descriptor to userland (it's a race, but it's a userland
race and there's nothing the kernel can do about it).  However, if we
follow fd_install() with any kind of access to objects that would be
destroyed on close (be it the struct file itself or anything destroyed
by its ->release()), we have a UAF.

dma_buf_fd() is a combination of reserving a descriptor and fd_install().
gntdev dmabuf_exp_from_pages() calls it and then proceeds to access the
objects destroyed on close - starting with gntdev_dmabuf itself.

Fix that by doing reserving descriptor before anything else and do
fd_install() only when everything had been set up.

Fixes: a240d6e42e28 ("xen/gntdev: Implement dma-buf export functionality")
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/xen/gntdev-dmabuf.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/xen/gntdev-dmabuf.c b/drivers/xen/gntdev-dmabuf.c
index 5453d86324f6..82855105ab85 100644
--- a/drivers/xen/gntdev-dmabuf.c
+++ b/drivers/xen/gntdev-dmabuf.c
@@ -357,8 +357,11 @@ struct gntdev_dmabuf_export_args {
 static int dmabuf_exp_from_pages(struct gntdev_dmabuf_export_args *args)
 {
 	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
-	struct gntdev_dmabuf *gntdev_dmabuf;
-	int ret;
+	struct gntdev_dmabuf *gntdev_dmabuf __free(kfree) = NULL;
+	CLASS(get_unused_fd, ret)(O_CLOEXEC);
+
+	if (ret < 0)
+		return ret;
 
 	gntdev_dmabuf = kzalloc(sizeof(*gntdev_dmabuf), GFP_KERNEL);
 	if (!gntdev_dmabuf)
@@ -383,32 +386,21 @@ static int dmabuf_exp_from_pages(struct gntdev_dmabuf_export_args *args)
 	exp_info.priv = gntdev_dmabuf;
 
 	gntdev_dmabuf->dmabuf = dma_buf_export(&exp_info);
-	if (IS_ERR(gntdev_dmabuf->dmabuf)) {
-		ret = PTR_ERR(gntdev_dmabuf->dmabuf);
-		gntdev_dmabuf->dmabuf = NULL;
-		goto fail;
-	}
-
-	ret = dma_buf_fd(gntdev_dmabuf->dmabuf, O_CLOEXEC);
-	if (ret < 0)
-		goto fail;
+	if (IS_ERR(gntdev_dmabuf->dmabuf))
+		return PTR_ERR(gntdev_dmabuf->dmabuf);
 
 	gntdev_dmabuf->fd = ret;
 	args->fd = ret;
 
 	pr_debug("Exporting DMA buffer with fd %d\n", ret);
 
+	get_file(gntdev_dmabuf->priv->filp);
 	mutex_lock(&args->dmabuf_priv->lock);
 	list_add(&gntdev_dmabuf->next, &args->dmabuf_priv->exp_list);
 	mutex_unlock(&args->dmabuf_priv->lock);
-	get_file(gntdev_dmabuf->priv->filp);
-	return 0;
 
-fail:
-	if (gntdev_dmabuf->dmabuf)
-		dma_buf_put(gntdev_dmabuf->dmabuf);
-	kfree(gntdev_dmabuf);
-	return ret;
+	fd_install(take_fd(ret), no_free_ptr(gntdev_dmabuf)->dmabuf->file);
+	return 0;
 }
 
 static struct gntdev_grant_map *
-- 
2.39.5


