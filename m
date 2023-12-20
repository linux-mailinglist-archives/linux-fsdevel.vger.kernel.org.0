Return-Path: <linux-fsdevel+bounces-6558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E432B81980F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 06:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79B2D2831C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 05:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCB411732;
	Wed, 20 Dec 2023 05:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="O/Nuvr/a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A2511715
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Dec 2023 05:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KX/kg4VkkikY4aexK//LcsVLecPvPOPke2DJ/gmuNFI=; b=O/Nuvr/a3Nry8EfRVXgtIVjadC
	csVXMiOHSIrxs3BHSWT6blAnVSk65Czx84v81lqmma4fRVSeLUWISBw8NrNHmmLQFfAqvO/mk0l58
	4jUPs957/q8PB2Ha6D5L+a+aF5SLVFfHJXWrO/JvTU7zEOtsJtCLsm+j2UlrqOi57iQkDg3tJ9BmY
	4LKU5/v89LFZ+kNUEkFLBy2JfGY1K3flDhh2bkZ8eVGXHwzXWTJZivsDISTiOM2p3V08Hzr3VdQ/2
	n8s3xEnikxm5UdMSHZI4B0HYe2ij/WwQDP0/ckzx89kpvrQIcqDweIPC45+Vq5F8nB0VyTACq6y3h
	FW0EvuJA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rFp3n-00HIzY-2P;
	Wed, 20 Dec 2023 05:24:00 +0000
Date: Wed, 20 Dec 2023 05:23:59 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.com>
Subject: [PATCH 11/22] udf: d_obtain_alias(ERR_PTR(...)) will do the right
 thing...
Message-ID: <20231220052359.GJ1674809@ZenIV>
References: <20231220051348.GY1674809@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220051348.GY1674809@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/udf/namei.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 92f25e540430..a64102d63781 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -897,7 +897,6 @@ static int udf_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 static struct dentry *udf_get_parent(struct dentry *child)
 {
 	struct kernel_lb_addr tloc;
-	struct inode *inode = NULL;
 	struct udf_fileident_iter iter;
 	int err;
 
@@ -907,11 +906,7 @@ static struct dentry *udf_get_parent(struct dentry *child)
 
 	tloc = lelb_to_cpu(iter.fi.icb.extLocation);
 	udf_fiiter_release(&iter);
-	inode = udf_iget(child->d_sb, &tloc);
-	if (IS_ERR(inode))
-		return ERR_CAST(inode);
-
-	return d_obtain_alias(inode);
+	return d_obtain_alias(udf_iget(child->d_sb, &tloc));
 }
 
 
-- 
2.39.2


