Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5BA82D8873
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Dec 2020 18:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407682AbgLLQwW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Dec 2020 11:52:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404701AbgLLQvz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Dec 2020 11:51:55 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127ECC0613D3
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Dec 2020 08:51:15 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id b26so9185372pfi.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Dec 2020 08:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HNS3V4F8jAe8Zg8QFutKhAJSQ459FMWmyXZjmDhEIcQ=;
        b=LBeFVWwSvVYcHQOqOnBvJy6D7RQeZXrLMa7FHTN7lzKiON6X/gPAszHopNoHYqQaUT
         DBScY/GsVBtQA1GZMdltjSjR9NYHbJWl0jXiZAvon1qBe/1DA5ONjDUi7fIFWVzMjvw9
         hVQ24SoovJxckdMOrgT4gg0Diem0kjnO+z605nXLz0c7mwQwg+Y5w+RvnVy0j8+Moo1j
         Sx9S4AwZ7BuNgsYYxT1HdQiSrqilw5b5frKUfWA/uwc8GEtzE2h6fEpttOjqL/Q1xcsE
         zyNgmLQJCqyHsNRlQgO1tdrZXvyUVkx+PXit+fDysZfK6mql2GigGyiwY6U7k5Xd1qdX
         mpMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HNS3V4F8jAe8Zg8QFutKhAJSQ459FMWmyXZjmDhEIcQ=;
        b=fDNPVL00GnVhHmQn9t/RLDlnxe9RhYDviqD2Mez38V8D/1036BlNKXeZXofLaBe6xk
         qJnZeZ5h6gfr+WGU47DqEIatpEUX5EGBjGR++hstrCgiAfUH8u+h8zDgsAukfTYMqpzd
         q6RmsXt0GriTouUzmoCuZhzMJLBwY5sgEnTGA754hypaki2UcoTqwKdgLM1OxU99mMMJ
         RwycJUO6LIsmxSzrZ6ydQ9qqLgMK+D1nlhyjBCxtDlinEIeU1JRZ01eZMB85P/pPSsF7
         kCklbv9gLcLu8c3TZS/z22yCaXElpt52o2zS/FY+7rVtHjOvpUqtKuXYPJNObn70UMAA
         AhFg==
X-Gm-Message-State: AOAM531uKvxzvSLlzur+eisfL87gwlBeFi9XFboEBwr8Y6A5oERd/0YP
        t3Y4ePYrzA0yZWq39WaysDcz0940MLqWDw==
X-Google-Smtp-Source: ABdhPJzWfiWqvSEVuazHYU7fN/0MbPH8ZVCUGFFEyfc7T0zyHPgnPzmzd0cOg0ix3D3ZQdEpWnU/Aw==
X-Received: by 2002:a63:560b:: with SMTP id k11mr11205752pgb.407.1607791874246;
        Sat, 12 Dec 2020 08:51:14 -0800 (PST)
Received: from p1.localdomain ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id s17sm14855352pge.37.2020.12.12.08.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Dec 2020 08:51:13 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/5] fs: make unlazy_walk() error handling consistent
Date:   Sat, 12 Dec 2020 09:51:01 -0700
Message-Id: <20201212165105.902688-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201212165105.902688-1-axboe@kernel.dk>
References: <20201212165105.902688-1-axboe@kernel.dk>
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

