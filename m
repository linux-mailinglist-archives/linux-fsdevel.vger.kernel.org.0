Return-Path: <linux-fsdevel+bounces-6569-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E42E6819830
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 06:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A249B288713
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 05:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E45B156F0;
	Wed, 20 Dec 2023 05:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="HzDd+azD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE13156DD
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Dec 2023 05:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JEsBIIZq7ARW+vWFkRPXkXpSNO+fGKJrrx/Q6gEIHO4=; b=HzDd+azD232qj33DLxPKk7wUad
	koHHW5jLk9VH6jmmeVhq8Joe+Xdfi7EqpXgNQQEBeAHju/bY0PRFfYte14olLS9PNr99J42tYXN8Y
	ztdb09EJRW9y7RgVHZeP8zWwykSKxAB13uO3B4V072J0TA3nSVE/In0Ll36lU+BkrFL6VYF6gV91O
	sts92oCIgHLs+ur2NWMjRUVxkF/ApaPv0WJhVNEyvuOklnUmVpmMUCmGHHv9uoqM/TmR8b2hVFbDN
	9mDUKrWz8hThVa1IyDuYOH6Hmi+f6Wn42FJKHuLe+wpww4DP83Y1175uxgpNkgVILD6Z/ToXOzZOn
	FLQMX/aQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rFpD1-00HJnY-30;
	Wed, 20 Dec 2023 05:33:32 +0000
Date: Wed, 20 Dec 2023 05:33:31 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: apparmor@lists.ubuntu.com
Subject: [PATCH 22/22] apparmorfs: don't duplicate kfree_link()
Message-ID: <20231220053331.GU1674809@ZenIV>
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

rawdata_link_cb() is identical to it

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 security/apparmor/apparmorfs.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 38650e52ef57..63ca77103de9 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -1615,11 +1615,6 @@ static char *gen_symlink_name(int depth, const char *dirname, const char *fname)
 	return buffer;
 }
 
-static void rawdata_link_cb(void *arg)
-{
-	kfree(arg);
-}
-
 static const char *rawdata_get_link_base(struct dentry *dentry,
 					 struct inode *inode,
 					 struct delayed_call *done,
@@ -1643,7 +1638,7 @@ static const char *rawdata_get_link_base(struct dentry *dentry,
 	if (IS_ERR(target))
 		return target;
 
-	set_delayed_call(done, rawdata_link_cb, target);
+	set_delayed_call(done, kfree_link, target);
 
 	return target;
 }
-- 
2.39.2


