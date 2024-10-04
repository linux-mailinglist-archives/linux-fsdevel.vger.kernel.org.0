Return-Path: <linux-fsdevel+bounces-30965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E8C990287
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 13:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBDBC281342
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 11:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2002915A868;
	Fri,  4 Oct 2024 11:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ecbuIeRA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9421E1EB2E
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Oct 2024 11:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728042720; cv=none; b=L8K+l31P+GQtFAXwkGU2ZnfMjpirhHaSE1MVCfp0M5B1BzIXL1GrhLQWH1vjmlfSRCbSjFIoWNM5GdhALumIvtGLAiELkZE1SimZ+CINuwFzUwuw7CkFCCjQB0E1D3C7ra/ffhwk+CehNEwAM9BORrZrPY0zQ9eNQFp4uLxM2ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728042720; c=relaxed/simple;
	bh=CmvJJbFcNtV5NlD2bchx3oGUcL7a/pVS3TwQcv4BJH4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ie9Iea+iQGJ6XXYw9tnRRpcM6BvNrqBUOp9uaHI97oZFBYfHrg+uwweV6bkYIjRoV4Ug9DaVe3yFCf6kY1IjhaX1UgGrZSEYdBCalvfJsNgTFPKlnogCSD/TyqoR+3Bc6F1GQ1xRFvCh2zUW8M8gpQJ3M8+hadfnBSXGBh5cAu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ecbuIeRA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728042717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WXWU99ogo6XTn/bEX7hE8CzToc2YDHws17zA7PPQEIM=;
	b=ecbuIeRA9mRIh68cjVNCiTNrBgpe5fKrC284kPSQPP0Kzyj+ITLW1NLgzWy7CXNR80DaBz
	R6Awdl20GQ3ufVEY8F72I4zowL9kp2u5NG0jV2AXY3jQseQhtkQ1er/JiT8wWq1Q41Nbnv
	ihQQbSe1U4nl+lIlBEFnb7JbzUk/nqQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-210-Ac3yZuADOXyVQIJWAXeynA-1; Fri,
 04 Oct 2024 07:51:56 -0400
X-MC-Unique: Ac3yZuADOXyVQIJWAXeynA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E43791956069;
	Fri,  4 Oct 2024 11:51:54 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.226.51])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A84DF19560A2;
	Fri,  4 Oct 2024 11:51:52 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] vfs: inode insertion kdoc corrections
Date: Fri,  4 Oct 2024 13:51:51 +0200
Message-ID: <20241004115151.44834-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Some minor corrections to the inode_insert5 and iget5_locked kernel
documentation.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/inode.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 471ae4a31549..6b3ff38df7f7 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1239,16 +1239,15 @@ EXPORT_SYMBOL(unlock_two_nondirectories);
  * @data:	opaque data pointer to pass to @test and @set
  *
  * Search for the inode specified by @hashval and @data in the inode cache,
- * and if present it is return it with an increased reference count. This is
- * a variant of iget5_locked() for callers that don't want to fail on memory
- * allocation of inode.
+ * and if present return it with an increased reference count. This is a
+ * variant of iget5_locked() that doesn't allocate an inode.
  *
- * If the inode is not in cache, insert the pre-allocated inode to cache and
+ * If the inode is not present in the cache, insert the pre-allocated inode and
  * return it locked, hashed, and with the I_NEW flag set. The file system gets
  * to fill it in before unlocking it via unlock_new_inode().
  *
- * Note both @test and @set are called with the inode_hash_lock held, so can't
- * sleep.
+ * Note that both @test and @set are called with the inode_hash_lock held, so
+ * they can't sleep.
  */
 struct inode *inode_insert5(struct inode *inode, unsigned long hashval,
 			    int (*test)(struct inode *, void *),
@@ -1312,16 +1311,16 @@ EXPORT_SYMBOL(inode_insert5);
  * @data:	opaque data pointer to pass to @test and @set
  *
  * Search for the inode specified by @hashval and @data in the inode cache,
- * and if present it is return it with an increased reference count. This is
- * a generalized version of iget_locked() for file systems where the inode
+ * and if present return it with an increased reference count. This is a
+ * generalized version of iget_locked() for file systems where the inode
  * number is not sufficient for unique identification of an inode.
  *
- * If the inode is not in cache, allocate a new inode and return it locked,
- * hashed, and with the I_NEW flag set. The file system gets to fill it in
- * before unlocking it via unlock_new_inode().
+ * If the inode is not present in the cache, allocate and insert a new inode
+ * and return it locked, hashed, and with the I_NEW flag set. The file system
+ * gets to fill it in before unlocking it via unlock_new_inode().
  *
- * Note both @test and @set are called with the inode_hash_lock held, so can't
- * sleep.
+ * Note that both @test and @set are called with the inode_hash_lock held, so
+ * they can't sleep.
  */
 struct inode *iget5_locked(struct super_block *sb, unsigned long hashval,
 		int (*test)(struct inode *, void *),
-- 
2.46.1


