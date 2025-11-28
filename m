Return-Path: <linux-fsdevel+bounces-70190-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C183C93389
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 23:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E1D74E1FDD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 22:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3872E173D;
	Fri, 28 Nov 2025 22:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RaiGbSc0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F962DAFB8
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Nov 2025 22:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764367598; cv=none; b=UVGpSWuq9cQGTfNkaLwxwzSWDmjkF3r4LH1lIDgGrx18tVFDOwCJpSBg/T9cY5EtfbRRm9n8w29lLraD/VScYzVnUOoC/iy58yDajx5KoRUX62xReBj8P9vJiPFBtEg9Uxfwv/KSodlHh+92erN489fKFTfwL83QTdbnuMiBkjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764367598; c=relaxed/simple;
	bh=Nl1asJOqF9mxpBcBeuyS88Yf3Ed/NUld+MGt5pFtQ+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bb2lvTer8OVz7ugUQ2KK0JWm5onC5Z9oweU3/b46+bErSml7hLZ6f4fqeEVy1xmrll1yBigPUlh4mHPDqyDRklwCTOiVtQaIMLFrkGKcsJyE/ePIGDoJxPnNxCnzn/srj9yj/l4wtyRxiiZdcPpXl0b+T3Rh3OEgEeppsDle/q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RaiGbSc0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=MpIdvKFLJCSYbEJe8nEDhQGDYRcsZm1/oDwocYvO3Xg=; b=RaiGbSc088EEMFCvQKYkJfV3OH
	puOufpnyeP7vs3EfOZvDolCpt3XE2P9T2fCH9WbSZUWKfWxxuIRLnDgMc9t0tEAUNtiVMVZQ3hBEW
	Gw2lotOYQyAJLpkqPJnpD51+bGeQ98RnoSBp0lriggTK3GYSwb9Sxa7DIvcW1sO3e1smvGkRri0vD
	O0gylxYC9ZSh5UYuSx+NfObTlvvBYo2c1Y7FP6JTIMfUI6tWucYX2uEHDZ9vHT/vOEwclCaXsjZKl
	rSb8xrSeJMZJ+DqrAhh7HQzqcY/HeF0+Odxt7L3bS47Dj2sLXS3hB1oS76UWZQ+N1rJdvQ61syNLN
	AKMX/lnQ==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vP6bo-00000000zz2-2cvL;
	Fri, 28 Nov 2025 22:06:33 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	NeilBrown <neil@brown.name>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v2] VFS: namei: fix start_dirop() kernel-doc warnings
Date: Fri, 28 Nov 2025 14:06:32 -0800
Message-ID: <20251128220632.948713-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the kernel-doc function description from just prior to __start_dirop()
to just before start_dirop() to avoid these kernel-doc warnings:

Warning: fs/namei.c:2853 function parameter 'state' not described
 in '__start_dirop'
WARNING: fs/namei.c:2853 expecting prototype for start_dirop().
 Prototype was for __start_dirop() instead

Fixes: ff7c4ea11a05 ("VFS: add start_creating_killable() and start_removing_killable()")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
v2: move kernel-doc to start_dirop() instead of __start_dirop() [Neil]
---
Cc: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>
---
 fs/namei.c |   25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

--- linux-next-20251127.orig/fs/namei.c
+++ linux-next-20251127/fs/namei.c
@@ -2835,19 +2835,6 @@ static int filename_parentat(int dfd, st
 	return __filename_parentat(dfd, name, flags, parent, last, type, NULL);
 }
 
-/**
- * start_dirop - begin a create or remove dirop, performing locking and lookup
- * @parent:       the dentry of the parent in which the operation will occur
- * @name:         a qstr holding the name within that parent
- * @lookup_flags: intent and other lookup flags.
- *
- * The lookup is performed and necessary locks are taken so that, on success,
- * the returned dentry can be operated on safely.
- * The qstr must already have the hash value calculated.
- *
- * Returns: a locked dentry, or an error.
- *
- */
 static struct dentry *__start_dirop(struct dentry *parent, struct qstr *name,
 				    unsigned int lookup_flags,
 				    unsigned int state)
@@ -2869,6 +2856,18 @@ static struct dentry *__start_dirop(stru
 	return dentry;
 }
 
+/**
+ * start_dirop - begin a create or remove dirop, performing locking and lookup
+ * @parent:       the dentry of the parent in which the operation will occur
+ * @name:         a qstr holding the name within that parent
+ * @lookup_flags: intent and other lookup flags.
+ *
+ * The lookup is performed and necessary locks are taken so that, on success,
+ * the returned dentry can be operated on safely.
+ * The qstr must already have the hash value calculated.
+ *
+ * Returns: a locked dentry, or an error.
+ */
 struct dentry *start_dirop(struct dentry *parent, struct qstr *name,
 			   unsigned int lookup_flags)
 {

