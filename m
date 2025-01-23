Return-Path: <linux-fsdevel+bounces-39915-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CFFA19C7F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 02:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B3D416D05B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 01:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD8933E1;
	Thu, 23 Jan 2025 01:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Vy+ZaKt8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635322BAF4;
	Thu, 23 Jan 2025 01:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737596809; cv=none; b=VuAyvtewLqJq3vP6vzOz6zkMjp2x1w5+15JlwjQLNuSChzLyB3dOUh5mmto0YnLVUNkSjIN25VJBvEjpGcZzUilYsYIg6Ap+mCFjGAmKM9KBsJg9phGu12ypgpJmgeToL0dIzLw4y6xpNNVL11jyGYRkdFWMzGezaI9S2SHC6Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737596809; c=relaxed/simple;
	bh=iMTwkherERqG2jXg3Z7V0S70qleyzVs7qz0zbFHx5Ic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BnbIG92E0lGw4gygRHYpZ+95GtGgYG0zOAS7QDPKTf8NXP0kWmDzZudyRpIYiEdTGg8EIE8tEr1RRC+0ifTPvIO4zx+q8rn4OOdX8Wq9cY2fX3qLS6WJVi0YV/CqwnqDl3Dn7ZqzjJ7/O/15xV7Amk8RKmtzv5QomB5jLE05ljY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Vy+ZaKt8; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Si/uF5hJcqrfgE3sJVbSurvV2+6YdEKTgvQSMpIDyZU=; b=Vy+ZaKt85NcPcYMfF3tDN0AnGo
	kqUbYzqObQaVaSh59/egC271fHjqdca7xvMaB6Dwt8hehiNMuMIHxySRnxKETX8+E6bR34s7/X1Yn
	jpP5udZPuEGKoCX0ow/EobtuLZYOAy3QotxtQwvhhhS0rFF0e0TXPOnpWyG7oc2GM3WFaPvQccBKQ
	j1S7ukho+h5S2iYHCS5t1C3Uc9vv3z/6JGFP7YqWCwdbZZKn1nDOlW3RQPZYqCYIk7GM6eLVyRs2A
	YpqFKStSZHt3k+A4PXN13r+48y3ZjCNwCGVMCbPcsdZJQpov9EacfVYaDGRg6FRP0HU1ip7l3gZjr
	oRr2Q+Fg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tamIv-00000008F3o-2agE;
	Thu, 23 Jan 2025 01:46:45 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: agruenba@redhat.com,
	amir73il@gmail.com,
	brauner@kernel.org,
	ceph-devel@vger.kernel.org,
	dhowells@redhat.com,
	hubcap@omnibond.com,
	jack@suse.cz,
	krisman@kernel.org,
	linux-nfs@vger.kernel.org,
	miklos@szeredi.hu,
	torvalds@linux-foundation.org
Subject: [PATCH v3 18/20] ocfs2_dentry_revalidate(): use stable parent inode and name passed by caller
Date: Thu, 23 Jan 2025 01:46:41 +0000
Message-ID: <20250123014643.1964371-18-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250123014643.1964371-1-viro@zeniv.linux.org.uk>
References: <20250123014511.GA1962481@ZenIV>
 <20250123014643.1964371-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

theoretically, ->d_name use in there is a UAF, but only if you are messing with
tracepoints...

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ocfs2/dcache.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/fs/ocfs2/dcache.c b/fs/ocfs2/dcache.c
index ecb1ce6301c4..1873bbbb7e5b 100644
--- a/fs/ocfs2/dcache.c
+++ b/fs/ocfs2/dcache.c
@@ -45,8 +45,7 @@ static int ocfs2_dentry_revalidate(struct inode *dir, const struct qstr *name,
 	inode = d_inode(dentry);
 	osb = OCFS2_SB(dentry->d_sb);
 
-	trace_ocfs2_dentry_revalidate(dentry, dentry->d_name.len,
-				      dentry->d_name.name);
+	trace_ocfs2_dentry_revalidate(dentry, name->len, name->name);
 
 	/* For a negative dentry -
 	 * check the generation number of the parent and compare with the
@@ -54,12 +53,8 @@ static int ocfs2_dentry_revalidate(struct inode *dir, const struct qstr *name,
 	 */
 	if (inode == NULL) {
 		unsigned long gen = (unsigned long) dentry->d_fsdata;
-		unsigned long pgen;
-		spin_lock(&dentry->d_lock);
-		pgen = OCFS2_I(d_inode(dentry->d_parent))->ip_dir_lock_gen;
-		spin_unlock(&dentry->d_lock);
-		trace_ocfs2_dentry_revalidate_negative(dentry->d_name.len,
-						       dentry->d_name.name,
+		unsigned long pgen = OCFS2_I(dir)->ip_dir_lock_gen;
+		trace_ocfs2_dentry_revalidate_negative(name->len, name->name,
 						       pgen, gen);
 		if (gen != pgen)
 			goto bail;
-- 
2.39.5


