Return-Path: <linux-fsdevel+bounces-39223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAD1A1177A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 03:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D66D3A7DCE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 02:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB4D22E40E;
	Wed, 15 Jan 2025 02:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ZX/aBcE4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36447846D
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2025 02:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736909409; cv=none; b=FGGbRuRo+TTzf7kJB8e+7sjvfv7ROFdQ9WmZTQL5c/x9g/r+69wysR5GEhmOuVAAn4EcQ/pFF5QiLJEKj8THnIq3HVwbPmS+9uh4oJAT++c7Irs5HSVELSQMK7V83TLBeD7nC+H3nbIrdAhGIeT0b5xhuRzrd/nWFKpCdcHdEgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736909409; c=relaxed/simple;
	bh=bfxijhl//DPONmt/Ku162c1hQrG7+b7BLN9iPnPs9EU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MCwR8cADetkGmABjQLLJUpRNv45AT+G2V0boPEaqZuiBXOcCdQx953qSKFzTcFCTCfDN0/EixamGmW9K2WY1JhDb0ahhY1npr3xkg6tGF5Xh/t9QQ0GRtKB3Euqu+hSbgQSxK3D9/rlQaStrSG9IjYGwnAXfG7A7DVsvbcwSMmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ZX/aBcE4; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=jdYQIdvex2eMPatfajMsHu8Ei1r0p/FqHNtH/jwczb0=; b=ZX/aBcE4cvzPZjnBk68maDI7MW
	UOes/8DOdOKuevv2xSogY+idGouQHVIqklgU9TUx5Yc1j28Z++syQ8cDV/kkyoAHV3hVDQiioYSWU
	l/OSsJwWtZ9q8SRy436Zcgxfd7i6XMxpm4NRoOE38nNv8V40k6NyQpnco9QNafpPexr6zH609/A1R
	lsk6InJEg+kEtHMS/R9kdgtxlXRsqp77e8Sn+GZerxCkK25zcdqRYV7tVHWqkLHMMgshK7/Ewgh82
	vI/vcJpIHTIoCzVYAFm3SNZH7KPMkF7kNBjbQO3uqUsaC2fczJfNzD9TjonT9rDFMBxX5hsvA1eWz
	KbjPj8LQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tXtTn-00000001Rua-01ij;
	Wed, 15 Jan 2025 02:50:03 +0000
Date: Wed, 15 Jan 2025 02:50:02 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Elizabeth Figura <zfigura@codeweavers.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] fix a file reference leak in drivers/misc/ntsync.c
Message-ID: <20250115025002.GA1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	struct ntsync_obj contains a reference to struct file
and that reference contributes to refcount - ntsync_alloc_obj()
grabs it.  Normally the object is destroyed (and reference
to obj->file dropped) in ntsync_obj_release().  However, in
case of ntsync_obj_get_fd() failure the object is destroyed
directly by its creator.

	That case should also drop obj->file; plain kfree(obj)
is not enough there - it ends up leaking struct file * reference.

	Take that logics into a helper (ntsync_free_obj()) and
use it in both codepaths that destroy ntsync_obj instances.

Fixes: b46271ec40a05 "ntsync: Introduce NTSYNC_IOC_CREATE_SEM"
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index 4954553b7baa..6eb00d625bd1 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -97,13 +97,15 @@ static int ntsync_sem_post(struct ntsync_obj *sem, void __user *argp)
 	return ret;
 }
 
-static int ntsync_obj_release(struct inode *inode, struct file *file)
+static void ntsync_free_obj(struct ntsync_obj *obj)
 {
-	struct ntsync_obj *obj = file->private_data;
-
 	fput(obj->dev->file);
 	kfree(obj);
+}
 
+static int ntsync_obj_release(struct inode *inode, struct file *file)
+{
+	ntsync_free_obj(file->private_data);
 	return 0;
 }
 
@@ -183,7 +185,7 @@ static int ntsync_create_sem(struct ntsync_device *dev, void __user *argp)
 	sem->u.sem.max = args.max;
 	fd = ntsync_obj_get_fd(sem);
 	if (fd < 0) {
-		kfree(sem);
+		ntsync_free_obj(sem);
 		return fd;
 	}
 

