Return-Path: <linux-fsdevel+bounces-39372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE40A1327E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 06:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76C45167711
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 05:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167B51A83E2;
	Thu, 16 Jan 2025 05:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="JGIH7BoS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B54157E99;
	Thu, 16 Jan 2025 05:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737005004; cv=none; b=tcpKv1r8PMAJG8bh4VUP/oJy0G1Qmc/QdF5rG9qcS65kdr552GS3e1gIwlFGZwUxfXbXD0SAZ+6dYSrtspmSe6e3qn166Dv9X1/W4QnSrFaBa7yfpva6Nfz7xkTZidweBeQsSYjvM/ZdHIO8714QXD09Akt8LXCusFl+BLspvzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737005004; c=relaxed/simple;
	bh=iMTwkherERqG2jXg3Z7V0S70qleyzVs7qz0zbFHx5Ic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fwGyDWsV/bjZPvh+GHfqxfMXQQpQo7cyCl9evRF6Fk6vX2HCLgzYk+Q31NEc+kjAMYgnFJf6/iwuRStjuuvKHnx4vLGTko48VPLZVDse0Go9YwUnq7/m+w95gQqePnZUTZCftqGsXB9i1c/7sgurEIm1EPx7+ufa3tIs52REPRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=JGIH7BoS; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Si/uF5hJcqrfgE3sJVbSurvV2+6YdEKTgvQSMpIDyZU=; b=JGIH7BoSvquH4mljBFOFL33SqZ
	1+0Ue1ZYcT/ni3cNLHRvp/9nuBRN17oOadHldxhUmvlYngw2dQ1TNO34TqwDchO/0L19UFDzcTAwB
	GnCl74DvDXpb4m51dIJONoJ8Oj+/anfC4z5mA5Jm5iG3d79/gk+2EmXWeqCTpAJr9d2J4LE9HuW0O
	9UrScuq6S7GL9FzMMGDBp3eDUb7uXerAOfBVBZEf4kh3hm/R3goQrUYvaFs6kEPfVXcIQ+L1sKNNg
	CGGztT1vQ1VEJhZnDEE0s6PIoFM5RdrnrCiK3DD8hsZS51hWIJUAOlJcbBN9IBeTNA9Ww9atWYO90
	hu8XYfeQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tYILg-000000022If-03bP;
	Thu, 16 Jan 2025 05:23:20 +0000
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
Subject: [PATCH v2 18/20] ocfs2_dentry_revalidate(): use stable parent inode and name passed by caller
Date: Thu, 16 Jan 2025 05:23:15 +0000
Message-ID: <20250116052317.485356-18-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250116052317.485356-1-viro@zeniv.linux.org.uk>
References: <20250116052103.GF1977892@ZenIV>
 <20250116052317.485356-1-viro@zeniv.linux.org.uk>
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


