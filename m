Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDED31B121
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Feb 2021 17:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbhBNQGN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Feb 2021 11:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhBNQGN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Feb 2021 11:06:13 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAFD4C061574
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Feb 2021 08:05:32 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lBJti-00Dv1h-A9; Sun, 14 Feb 2021 16:05:22 +0000
Date:   Sun, 14 Feb 2021 16:05:22 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC] namei: don't drop link paths acquired under
 LOOKUP_RCU
Message-ID: <YClKQlivsPPcbyCd@zeniv-ca.linux.org.uk>
References: <8b114189-e943-a7e6-3d31-16aa8a148da6@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b114189-e943-a7e6-3d31-16aa8a148da6@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Feb 07, 2021 at 01:26:19PM -0700, Jens Axboe wrote:

> Al, not sure if this is the right fix for the situation, but it's
> definitely a problem. Observed by doing a LOOKUP_CACHED of something with
> links, using /proc/self/comm as the example in the attached way to
> demonstrate this problem.

That's definitely not the right fix.  What your analysis has missed is
what legitimize_links() does to nd->depth when called.  IOW, on transitions
from RCU mode you want nd->depth to set according the number of links we'd
grabbed references to.  Flatly setting it to 0 on failure exit will lead
to massive leaks.

Could you check if the following fixes your reproducers?

diff --git a/fs/namei.c b/fs/namei.c
index 4cae88733a5c..afb293b39be7 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -687,7 +687,7 @@ static bool try_to_unlazy(struct nameidata *nd)
 
 	nd->flags &= ~LOOKUP_RCU;
 	if (nd->flags & LOOKUP_CACHED)
-		goto out1;
+		goto out2;
 	if (unlikely(!legitimize_links(nd)))
 		goto out1;
 	if (unlikely(!legitimize_path(nd, &nd->path, nd->seq)))
@@ -698,6 +698,8 @@ static bool try_to_unlazy(struct nameidata *nd)
 	BUG_ON(nd->inode != parent->d_inode);
 	return true;
 
+out2:
+	nd->depth = 0;	// as we hadn't gotten to legitimize_links()
 out1:
 	nd->path.mnt = NULL;
 	nd->path.dentry = NULL;
@@ -725,7 +727,7 @@ static bool try_to_unlazy_next(struct nameidata *nd, struct dentry *dentry, unsi
 
 	nd->flags &= ~LOOKUP_RCU;
 	if (nd->flags & LOOKUP_CACHED)
-		goto out2;
+		goto out3;
 	if (unlikely(!legitimize_links(nd)))
 		goto out2;
 	if (unlikely(!legitimize_mnt(nd->path.mnt, nd->m_seq)))
@@ -753,6 +755,8 @@ static bool try_to_unlazy_next(struct nameidata *nd, struct dentry *dentry, unsi
 	rcu_read_unlock();
 	return true;
 
+out3:
+	nd->depth = 0;	// as we hadn't gotten to legitimize_links()
 out2:
 	nd->path.mnt = NULL;
 out1:
