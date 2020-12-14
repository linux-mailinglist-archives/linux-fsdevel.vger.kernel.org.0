Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52EBD2DA012
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Dec 2020 20:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502039AbgLNTOe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Dec 2020 14:14:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438061AbgLNTOQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Dec 2020 14:14:16 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD184C0613D6
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Dec 2020 11:13:35 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id m23so3182997ioy.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Dec 2020 11:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HNS3V4F8jAe8Zg8QFutKhAJSQ459FMWmyXZjmDhEIcQ=;
        b=YU5GWNle8fntTtzxU0JK9Aw42CeQCGQwXiYajQgNSGMBLs0y2ZBhQcO/pFavWZmepW
         A23+UIUu739pCHp9EyH/angGkas8gcKMuznKNocHrwhXm4iKl/Gf/DB4FGJ4P+5E8VwV
         RYye3c8DkAjU9TuNeiVyke+Dc467NQA2W+1FiuLGhxKPRR7CA1MBdeVitQ2ISrvxSGTC
         RvzSYe9Zag4rbuPVD9ljdyxDExdZgLnuj49zV5JpCg6BGtFIRsqPl17pp5fFwGxejhsA
         HM2tuVMo8w08PusoNfLmSZ/5/hXa/7f93o54GdlWyWfjCShdy7E8J/7JkV6XTRCugMCo
         HuCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HNS3V4F8jAe8Zg8QFutKhAJSQ459FMWmyXZjmDhEIcQ=;
        b=JVuIIW1VyTZTmjtzDbRwunFtHdtGssvT91JEqy8c8pYVfdn94pQjoYwR0XQCtkFikP
         Xt4s/zMfhRPzAWin0l1dDjd3ccgF1dnY1xRd7jgKJV/tt/hr25N6e3JpIYSERgHIDWVr
         9nkuldxcO2mLrL3O7rzq3oHNetHE87crWaCMTC5J7nEPoH32gktJNSSM4baihvjBWXzO
         KzHCU+f6PR4TKJLibKJdNp+FtoccGEpDODDAr9ISiq3AV7M37TEDszNpSkCr7EKIsPic
         v3oLK88SqVk6zshd2+cBfyRRkuyTrSjtOae3Itg1UF/aJEFBB1fOfS+Q1Oe5hXfe5YOT
         tX8A==
X-Gm-Message-State: AOAM532WRpw94HYY9H8mfJK0JnMvCxjAwuuXewGrfsRYvoVKl2XHFqhA
        0ZV5HieIbu5aWalgI4SXjp2DBf0uQaEFtw==
X-Google-Smtp-Source: ABdhPJwh/8wmJ06/LURctn5PVfDcJORAwy8CqB470SCuUia9iEyWqB6KG2whIcTKMTTXFcfE1QPDOg==
X-Received: by 2002:a05:6602:150b:: with SMTP id g11mr33681181iow.88.1607973214816;
        Mon, 14 Dec 2020 11:13:34 -0800 (PST)
Received: from p1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 11sm11760566ilt.54.2020.12.14.11.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 11:13:34 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/4] fs: make unlazy_walk() error handling consistent
Date:   Mon, 14 Dec 2020 12:13:21 -0700
Message-Id: <20201214191323.173773-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201214191323.173773-1-axboe@kernel.dk>
References: <20201214191323.173773-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Most callers check for non-zero return, and assume it's -ECHILD (which
it always will be). One caller uses the actual error return. Clean this
up and make it fully consistent, by having unlazy_walk() return a bool
instead. Rename it to try_to_unlazy() and return true on success, and
failure on error. That's easier to read.

No functional changes in this patch.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/namei.c | 43 +++++++++++++++++--------------------------
 1 file changed, 17 insertions(+), 26 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 03d0e11e4f36..7eb7830da298 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -669,17 +669,17 @@ static bool legitimize_root(struct nameidata *nd)
  */
 
 /**
- * unlazy_walk - try to switch to ref-walk mode.
+ * try_to_unlazy - try to switch to ref-walk mode.
  * @nd: nameidata pathwalk data
- * Returns: 0 on success, -ECHILD on failure
+ * Returns: true on success, false on failure
  *
- * unlazy_walk attempts to legitimize the current nd->path and nd->root
+ * try_to_unlazyk attempts to legitimize the current nd->path and nd->root
  * for ref-walk mode.
  * Must be called from rcu-walk context.
- * Nothing should touch nameidata between unlazy_walk() failure and
+ * Nothing should touch nameidata between try_to_unlazy() failure and
  * terminate_walk().
  */
-static int unlazy_walk(struct nameidata *nd)
+static bool try_to_unlazy(struct nameidata *nd)
 {
 	struct dentry *parent = nd->path.dentry;
 
@@ -694,14 +694,14 @@ static int unlazy_walk(struct nameidata *nd)
 		goto out;
 	rcu_read_unlock();
 	BUG_ON(nd->inode != parent->d_inode);
-	return 0;
+	return true;
 
 out1:
 	nd->path.mnt = NULL;
 	nd->path.dentry = NULL;
 out:
 	rcu_read_unlock();
-	return -ECHILD;
+	return false;
 }
 
 /**
@@ -792,7 +792,7 @@ static int complete_walk(struct nameidata *nd)
 		 */
 		if (!(nd->flags & (LOOKUP_ROOT | LOOKUP_IS_SCOPED)))
 			nd->root.mnt = NULL;
-		if (unlikely(unlazy_walk(nd)))
+		if (!try_to_unlazy(nd))
 			return -ECHILD;
 	}
 
@@ -1466,7 +1466,7 @@ static struct dentry *lookup_fast(struct nameidata *nd,
 		unsigned seq;
 		dentry = __d_lookup_rcu(parent, &nd->last, &seq);
 		if (unlikely(!dentry)) {
-			if (unlazy_walk(nd))
+			if (!try_to_unlazy(nd))
 				return ERR_PTR(-ECHILD);
 			return NULL;
 		}
@@ -1567,10 +1567,8 @@ static inline int may_lookup(struct nameidata *nd)
 {
 	if (nd->flags & LOOKUP_RCU) {
 		int err = inode_permission(nd->inode, MAY_EXEC|MAY_NOT_BLOCK);
-		if (err != -ECHILD)
+		if (err != -ECHILD || !try_to_unlazy(nd))
 			return err;
-		if (unlazy_walk(nd))
-			return -ECHILD;
 	}
 	return inode_permission(nd->inode, MAY_EXEC);
 }
@@ -1592,7 +1590,7 @@ static int reserve_stack(struct nameidata *nd, struct path *link, unsigned seq)
 		// unlazy even if we fail to grab the link - cleanup needs it
 		bool grabbed_link = legitimize_path(nd, link, seq);
 
-		if (unlazy_walk(nd) != 0 || !grabbed_link)
+		if (!try_to_unlazy(nd) != 0 || !grabbed_link)
 			return -ECHILD;
 
 		if (nd_alloc_stack(nd))
@@ -1634,7 +1632,7 @@ static const char *pick_link(struct nameidata *nd, struct path *link,
 		touch_atime(&last->link);
 		cond_resched();
 	} else if (atime_needs_update(&last->link, inode)) {
-		if (unlikely(unlazy_walk(nd)))
+		if (!try_to_unlazy(nd))
 			return ERR_PTR(-ECHILD);
 		touch_atime(&last->link);
 	}
@@ -1651,11 +1649,8 @@ static const char *pick_link(struct nameidata *nd, struct path *link,
 		get = inode->i_op->get_link;
 		if (nd->flags & LOOKUP_RCU) {
 			res = get(NULL, inode, &last->done);
-			if (res == ERR_PTR(-ECHILD)) {
-				if (unlikely(unlazy_walk(nd)))
-					return ERR_PTR(-ECHILD);
+			if (res == ERR_PTR(-ECHILD) && try_to_unlazy(nd))
 				res = get(link->dentry, inode, &last->done);
-			}
 		} else {
 			res = get(link->dentry, inode, &last->done);
 		}
@@ -2193,7 +2188,7 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 		}
 		if (unlikely(!d_can_lookup(nd->path.dentry))) {
 			if (nd->flags & LOOKUP_RCU) {
-				if (unlazy_walk(nd))
+				if (!try_to_unlazy(nd))
 					return -ECHILD;
 			}
 			return -ENOTDIR;
@@ -3127,7 +3122,6 @@ static const char *open_last_lookups(struct nameidata *nd,
 	struct inode *inode;
 	struct dentry *dentry;
 	const char *res;
-	int error;
 
 	nd->flags |= op->intent;
 
@@ -3151,9 +3145,8 @@ static const char *open_last_lookups(struct nameidata *nd,
 	} else {
 		/* create side of things */
 		if (nd->flags & LOOKUP_RCU) {
-			error = unlazy_walk(nd);
-			if (unlikely(error))
-				return ERR_PTR(error);
+			if (!try_to_unlazy(nd))
+				return ERR_PTR(-ECHILD);
 		}
 		audit_inode(nd->name, dir, AUDIT_INODE_PARENT);
 		/* trailing slashes? */
@@ -3162,9 +3155,7 @@ static const char *open_last_lookups(struct nameidata *nd,
 	}
 
 	if (open_flag & (O_CREAT | O_TRUNC | O_WRONLY | O_RDWR)) {
-		error = mnt_want_write(nd->path.mnt);
-		if (!error)
-			got_write = true;
+		got_write = !mnt_want_write(nd->path.mnt);
 		/*
 		 * do _not_ fail yet - we might not need that or fail with
 		 * a different error; let lookup_open() decide; we'll be
-- 
2.29.2

