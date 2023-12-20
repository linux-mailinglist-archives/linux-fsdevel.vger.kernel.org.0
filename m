Return-Path: <linux-fsdevel+bounces-6549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC916819800
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 06:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BEC51F25CCD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 05:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18212FC07;
	Wed, 20 Dec 2023 05:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="KQ6/Dfrv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E8EFBE1
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Dec 2023 05:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oGoJfhgfYqH1rbfIK0HfvLkdO9o5OYoUPJPVPgQwoLg=; b=KQ6/Dfrv8Tefj1bhlsge7FGvg2
	bbPwQnR9vHaA24NM+vKB7EU3nGGe6TSc99zpctwrCb1evoO5YsVtiCTRzT9wo+q5BGvJkusrn7HkW
	pqBT4GpQZYzEFYTi/Lca/A94m5boE1kLljch9MZDhxouezo/KZY/XzxCdnbpywGxpsf0pB9JNP07N
	iretzVphirxvCGFd2OKatCBPzHogRLVczTjeihXRKlykvCxjU44QuHO59ZBnPQZz5rrsntcHteHND
	YQ334ymg2m3QCwiX2AvnLvNveI1GnY/V+cSVGX/x2/VHTWoyKKZYuXo8f6BrMY3E7DYdgI2yFF0us
	f8XRm04g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rFowp-00HIXN-17;
	Wed, 20 Dec 2023 05:16:47 +0000
Date: Wed, 20 Dec 2023 05:16:47 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>
Subject: [PATCH 02/22] /proc/sys: use d_splice_alias() calling conventions to
 simplify failure exits
Message-ID: <20231220051647.GA1674809@ZenIV>
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
 fs/proc/proc_sysctl.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 8064ea76f80b..1ae6486dc7d4 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -534,13 +534,8 @@ static struct dentry *proc_sys_lookup(struct inode *dir, struct dentry *dentry,
 			goto out;
 	}
 
-	inode = proc_sys_make_inode(dir->i_sb, h ? h : head, p);
-	if (IS_ERR(inode)) {
-		err = ERR_CAST(inode);
-		goto out;
-	}
-
 	d_set_d_op(dentry, &proc_sys_dentry_operations);
+	inode = proc_sys_make_inode(dir->i_sb, h ? h : head, p);
 	err = d_splice_alias(inode, dentry);
 
 out:
@@ -698,13 +693,8 @@ static bool proc_sys_fill_cache(struct file *file,
 			return false;
 		if (d_in_lookup(child)) {
 			struct dentry *res;
-			inode = proc_sys_make_inode(dir->d_sb, head, table);
-			if (IS_ERR(inode)) {
-				d_lookup_done(child);
-				dput(child);
-				return false;
-			}
 			d_set_d_op(child, &proc_sys_dentry_operations);
+			inode = proc_sys_make_inode(dir->d_sb, head, table);
 			res = d_splice_alias(inode, child);
 			d_lookup_done(child);
 			if (unlikely(res)) {
-- 
2.39.2


