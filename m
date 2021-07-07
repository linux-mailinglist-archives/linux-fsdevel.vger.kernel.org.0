Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D883BF103
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jul 2021 22:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhGGUv2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jul 2021 16:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhGGUv0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jul 2021 16:51:26 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FA0C061574
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jul 2021 13:48:45 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id y9so3096374qtx.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jul 2021 13:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version;
        bh=zBNfbXpBNmhb98xHVWiDj3Sr7g66ZNi5yrexACG3dvg=;
        b=jCJGhylBGo9mRXeanuHxRZhhCCj3FSkm/awSCUEKQKqMx9tVfHNnBrsbeHDlwt/nmi
         E68+XL2JLUjHozPXu3hkUm4K88OTTEtvtr0xDMn7cXcBK8ubwJyUUgN9VaE5kh7FdYi4
         nzsGwi8A+4ipjXOujnZToWdksv5Nsji/eT12341ovf7AtqB369rG+kRIrMhAgM1qdaIz
         vg0bWF4bKZbsGvU5fOgpRcHEnTHA3tvREGHW+Dz04OGfdMD1ty6N7RkiLpP7L6rh9RG0
         gUBjj7exxUDQvJpp7TMC65MsqL8IgpxhQK7eLnwshBcl5SdrzMPjPoxyeyvxXbozjTv4
         KXlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version;
        bh=zBNfbXpBNmhb98xHVWiDj3Sr7g66ZNi5yrexACG3dvg=;
        b=llUa1lNZq4A0yXGtmF9E97vevI99ZW0Rg1/aABvmu/cRySCfTwh2Uv2yb7wihlyBhE
         lp8n6td0m/pUj5V9xGG1lrXK7flUo1Uine94ufR8uztwttuT1Ns/UfL4dnFFeSC8eoYE
         BQspcCOKlcOeTCOJUKlpSQuO157CAfahOPxvTMIHtJa6QAxZMjEyEYXG4OY+06/tTPb+
         K3wcoRGMhZW7c433pIaIorWELKstQnzYM4vn8epQhCtekrN4MUdq6gPiLmOvDIFIikRE
         Foz0kMscbF9uxeqZ/F9ZoPHP90cHGPyOtugUMR5eWBVf3psvjyqnJopUpWj0LpewXfrj
         yrIg==
X-Gm-Message-State: AOAM530jSzdb7ncAfiMteJPor4PaaY9rjllYNv7AaaCOOVg8rDS9lBHS
        SGV3SxoFIzRRFpwictKtYvDAwoRGXxhXxQ==
X-Google-Smtp-Source: ABdhPJx4A07Csj2ry9jMLONbnNINO+ORK8G+nJ7+AShhJQcQbVe8WLzFRsKq468qlWKfpXJrK2VaDQ==
X-Received: by 2002:ac8:59d5:: with SMTP id f21mr24231595qtf.126.1625690924098;
        Wed, 07 Jul 2021 13:48:44 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 6sm34991qkn.83.2021.07.07.13.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 13:48:43 -0700 (PDT)
Date:   Wed, 7 Jul 2021 13:48:31 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, Willy Tarreau <w@1wt.eu>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] fs, mm: fix race in unlinking swapfile
Message-ID: <e17b91ad-a578-9a15-5e3-4989e0f999b5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We had a recurring situation in which admin procedures setting up
swapfiles would race with test preparation clearing away swapfiles;
and just occasionally that got stuck on a swapfile "(deleted)" which
could never be swapped off.  That is not supposed to be possible.

2.6.28 commit f9454548e17c ("don't unlink an active swapfile") admitted
that it was leaving a race window open: now close it.

may_delete() makes the IS_SWAPFILE check (amongst many others) before
inode_lock has been taken on target: now repeat just that simple check
in vfs_unlink() and vfs_rename(), after taking inode_lock.

Which goes most of the way to fixing the race, but swapon() must also
check after it acquires inode_lock, that the file just opened has not
already been unlinked.

Fixes: f9454548e17c ("don't unlink an active swapfile")
Signed-off-by: Hugh Dickins <hughd@google.com>
---
 fs/namei.c    | 8 +++++++-
 mm/swapfile.c | 6 ++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index bf6d8a738c59..ff866c07f4d2 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4024,7 +4024,9 @@ int vfs_unlink(struct user_namespace *mnt_userns, struct inode *dir,
 		return -EPERM;
 
 	inode_lock(target);
-	if (is_local_mountpoint(dentry))
+	if (IS_SWAPFILE(target))
+		error = -EPERM;
+	else if (is_local_mountpoint(dentry))
 		error = -EBUSY;
 	else {
 		error = security_inode_unlink(dir, dentry);
@@ -4526,6 +4528,10 @@ int vfs_rename(struct renamedata *rd)
 	else if (target)
 		inode_lock(target);
 
+	error = -EPERM;
+	if (IS_SWAPFILE(source) || (target && IS_SWAPFILE(target)))
+		goto out;
+
 	error = -EBUSY;
 	if (is_local_mountpoint(old_dentry) || is_local_mountpoint(new_dentry))
 		goto out;
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 1e07d1c776f2..7527afd95284 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3130,6 +3130,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	struct filename *name;
 	struct file *swap_file = NULL;
 	struct address_space *mapping;
+	struct dentry *dentry;
 	int prio;
 	int error;
 	union swap_header *swap_header;
@@ -3173,6 +3174,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 
 	p->swap_file = swap_file;
 	mapping = swap_file->f_mapping;
+	dentry = swap_file->f_path.dentry;
 	inode = mapping->host;
 
 	error = claim_swapfile(p, inode);
@@ -3180,6 +3182,10 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		goto bad_swap;
 
 	inode_lock(inode);
+	if (d_unlinked(dentry) || cant_mount(dentry)) {
+		error = -ENOENT;
+		goto bad_swap_unlock_inode;
+	}
 	if (IS_SWAPFILE(inode)) {
 		error = -EBUSY;
 		goto bad_swap_unlock_inode;
-- 
2.26.2

