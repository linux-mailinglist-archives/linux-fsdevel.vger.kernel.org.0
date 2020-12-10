Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35B762D67FB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Dec 2020 21:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404302AbgLJUCW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Dec 2020 15:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404367AbgLJUCT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Dec 2020 15:02:19 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1CDC0613D3
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Dec 2020 12:01:22 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id z136so6906003iof.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Dec 2020 12:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h7UptUmHp/iVsUfHaHXWWUXQwS1cM7SuU6GoYK2QXnU=;
        b=m0UK3Zt7rzepGY0v53PyFtvPtIRCOAWC/QdOlvstKisb4QAOxk1w1QpsbBrNZLiU/Q
         prxiS4reVDVsYQGlsqWsYSrD03sv6x+on9LJLs92LWyIllEP+iCoTCv0DAHIc++MblAD
         j/hdYznQ34p/qrBXmU7dUi40rNBfe2VSCj55Kc6DhJ1/hDRtKgYTGkT4t7dgcKHCGDb0
         GrtH5KATONiRSgCqrGRUgDOW3S38UuywsLSfrwNM4JsYB1MKwoQkmg1urURZOAlR8Dvf
         eHOoYRxi80BU6BSyP7d4ivSYLnYJOJt2V8uzfCfmfOD93PuRKnOxMTD58cHLurrO+e/M
         kDyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h7UptUmHp/iVsUfHaHXWWUXQwS1cM7SuU6GoYK2QXnU=;
        b=XzA5EKKPJx94O5U58FcLX/+vr/I1C9gz3MeOSdxn/rwKr1s0XpFfhyJQVkDfhT3bs4
         rM3Ta22TKkR0xEJCQoRx/b3pMgKejUDHENSC2ShBamBcMXecm2oyqgw5hb4g3rBPjk0l
         sPUR3r589BR7hZdwG68hjUNXPMWhg27aLMV2VBb7P8imuIAZQlC6zISL/ukDCw0GSWHN
         oAuHVCPOZ4I9/Ed5Nv08Wv89kslhINXchUJF7BtaEgYznfuZzAVZpx8Sf045W/owpmh7
         +YxXj3fYMvFEkjV3c55RVTLVRGZdSZjKtiyKvNiMR/DhiEx8hGMfjezrARMMYuViJfg4
         3v+g==
X-Gm-Message-State: AOAM531/DxTQsN3RbOe2++uPCwesN/gZbYsfGX7CTfImeM1q33jXwasA
        p27rc++SeKRNJph92aFr+WmNQMscf/U2Nw==
X-Google-Smtp-Source: ABdhPJyPEImMYiCFne9XgGf2qv9C7u82dJfrmd4G8x0Asx+KEhYGPtcNAohM0rbPmFSLeowFfhmk8g==
X-Received: by 2002:a5d:8793:: with SMTP id f19mr10167064ion.106.1607630481368;
        Thu, 10 Dec 2020 12:01:21 -0800 (PST)
Received: from p1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id x5sm3850277ilm.22.2020.12.10.12.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 12:01:20 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/2] fs: add support for LOOKUP_NONBLOCK
Date:   Thu, 10 Dec 2020 13:01:13 -0700
Message-Id: <20201210200114.525026-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201210200114.525026-1-axboe@kernel.dk>
References: <20201210200114.525026-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

io_uring always punts opens to async context, since there's no control
over whether the lookup blocks or not. Add LOOKUP_NONBLOCK to support
just doing the fast RCU based lookups, which we know will not block. If
we can do a cached path resolution of the filename, then we don't have
to always punt lookups for a worker.

During path resolution, we always do LOOKUP_RCU first. If that fails and
we terminate LOOKUP_RCU, then fail a LOOKUP_NONBLOCK attempt as well.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/namei.c            | 60 +++++++++++++++++++++++++++++++------------
 include/linux/namei.h |  1 +
 2 files changed, 44 insertions(+), 17 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 03d0e11e4f36..3d86915568fa 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -679,7 +679,7 @@ static bool legitimize_root(struct nameidata *nd)
  * Nothing should touch nameidata between unlazy_walk() failure and
  * terminate_walk().
  */
-static int unlazy_walk(struct nameidata *nd)
+static int complete_walk_rcu(struct nameidata *nd)
 {
 	struct dentry *parent = nd->path.dentry;
 
@@ -704,6 +704,18 @@ static int unlazy_walk(struct nameidata *nd)
 	return -ECHILD;
 }
 
+static int unlazy_walk(struct nameidata *nd)
+{
+	int ret;
+
+	ret = complete_walk_rcu(nd);
+	/* If caller is asking for NONBLOCK lookup, assume we can't satisfy it */
+	if (!ret && (nd->flags & LOOKUP_NONBLOCK))
+		ret = -EAGAIN;
+
+	return ret;
+}
+
 /**
  * unlazy_child - try to switch to ref-walk mode.
  * @nd: nameidata pathwalk data
@@ -764,10 +776,13 @@ static int unlazy_child(struct nameidata *nd, struct dentry *dentry, unsigned se
 
 static inline int d_revalidate(struct dentry *dentry, unsigned int flags)
 {
-	if (unlikely(dentry->d_flags & DCACHE_OP_REVALIDATE))
+	if (unlikely(dentry->d_flags & DCACHE_OP_REVALIDATE)) {
+		if ((flags & (LOOKUP_RCU | LOOKUP_NONBLOCK)) == LOOKUP_NONBLOCK)
+			return -EAGAIN;
 		return dentry->d_op->d_revalidate(dentry, flags);
-	else
-		return 1;
+	}
+
+	return 1;
 }
 
 /**
@@ -792,7 +807,7 @@ static int complete_walk(struct nameidata *nd)
 		 */
 		if (!(nd->flags & (LOOKUP_ROOT | LOOKUP_IS_SCOPED)))
 			nd->root.mnt = NULL;
-		if (unlikely(unlazy_walk(nd)))
+		if (unlikely(complete_walk_rcu(nd)))
 			return -ECHILD;
 	}
 
@@ -1466,8 +1481,9 @@ static struct dentry *lookup_fast(struct nameidata *nd,
 		unsigned seq;
 		dentry = __d_lookup_rcu(parent, &nd->last, &seq);
 		if (unlikely(!dentry)) {
-			if (unlazy_walk(nd))
-				return ERR_PTR(-ECHILD);
+			int ret = unlazy_walk(nd);
+			if (ret)
+				return ERR_PTR(ret);
 			return NULL;
 		}
 
@@ -1569,8 +1585,9 @@ static inline int may_lookup(struct nameidata *nd)
 		int err = inode_permission(nd->inode, MAY_EXEC|MAY_NOT_BLOCK);
 		if (err != -ECHILD)
 			return err;
-		if (unlazy_walk(nd))
-			return -ECHILD;
+		err = unlazy_walk(nd);
+		if (err)
+			return err;
 	}
 	return inode_permission(nd->inode, MAY_EXEC);
 }
@@ -1591,9 +1608,11 @@ static int reserve_stack(struct nameidata *nd, struct path *link, unsigned seq)
 		// we need to grab link before we do unlazy.  And we can't skip
 		// unlazy even if we fail to grab the link - cleanup needs it
 		bool grabbed_link = legitimize_path(nd, link, seq);
+		int ret;
 
-		if (unlazy_walk(nd) != 0 || !grabbed_link)
-			return -ECHILD;
+		ret = unlazy_walk(nd);
+		if (ret && !grabbed_link)
+			return ret;
 
 		if (nd_alloc_stack(nd))
 			return 0;
@@ -1634,8 +1653,9 @@ static const char *pick_link(struct nameidata *nd, struct path *link,
 		touch_atime(&last->link);
 		cond_resched();
 	} else if (atime_needs_update(&last->link, inode)) {
-		if (unlikely(unlazy_walk(nd)))
-			return ERR_PTR(-ECHILD);
+		error = unlazy_walk(nd);
+		if (unlikely(error))
+			return ERR_PTR(error);
 		touch_atime(&last->link);
 	}
 
@@ -1652,8 +1672,9 @@ static const char *pick_link(struct nameidata *nd, struct path *link,
 		if (nd->flags & LOOKUP_RCU) {
 			res = get(NULL, inode, &last->done);
 			if (res == ERR_PTR(-ECHILD)) {
-				if (unlikely(unlazy_walk(nd)))
-					return ERR_PTR(-ECHILD);
+				error = unlazy_walk(nd);
+				if (unlikely(error))
+					return ERR_PTR(error);
 				res = get(link->dentry, inode, &last->done);
 			}
 		} else {
@@ -2193,8 +2214,9 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 		}
 		if (unlikely(!d_can_lookup(nd->path.dentry))) {
 			if (nd->flags & LOOKUP_RCU) {
-				if (unlazy_walk(nd))
-					return -ECHILD;
+				err = unlazy_walk(nd);
+				if (err)
+					return err;
 			}
 			return -ENOTDIR;
 		}
@@ -3394,10 +3416,14 @@ struct file *do_filp_open(int dfd, struct filename *pathname,
 
 	set_nameidata(&nd, dfd, pathname);
 	filp = path_openat(&nd, op, flags | LOOKUP_RCU);
+	/* If we fail RCU lookup, assume NONBLOCK cannot be honored */
+	if (flags & LOOKUP_NONBLOCK)
+		goto out;
 	if (unlikely(filp == ERR_PTR(-ECHILD)))
 		filp = path_openat(&nd, op, flags);
 	if (unlikely(filp == ERR_PTR(-ESTALE)))
 		filp = path_openat(&nd, op, flags | LOOKUP_REVAL);
+out:
 	restore_nameidata();
 	return filp;
 }
diff --git a/include/linux/namei.h b/include/linux/namei.h
index a4bb992623c4..c36c4e0805fc 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -46,6 +46,7 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};
 #define LOOKUP_NO_XDEV		0x040000 /* No mountpoint crossing. */
 #define LOOKUP_BENEATH		0x080000 /* No escaping from starting point. */
 #define LOOKUP_IN_ROOT		0x100000 /* Treat dirfd as fs root. */
+#define LOOKUP_NONBLOCK		0x200000 /* don't block for lookup */
 /* LOOKUP_* flags which do scope-related checks based on the dirfd. */
 #define LOOKUP_IS_SCOPED (LOOKUP_BENEATH | LOOKUP_IN_ROOT)
 
-- 
2.29.2

