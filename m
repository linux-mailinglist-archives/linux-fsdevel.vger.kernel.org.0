Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41FE75A19E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 00:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjGSWTg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jul 2023 18:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjGSWTf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jul 2023 18:19:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E481FE8;
        Wed, 19 Jul 2023 15:19:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0D92B222D9;
        Wed, 19 Jul 2023 22:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689805171; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BqbNsJJZFHzrk+OQKgoo/9ZCZoHSnGZs9WOrN7/OQBs=;
        b=ADRsD1Jcw/vcGrx4BTVWmM2VK7daFp0uxIOqfl9S+jTVz2ItB7vFeY6PJ3wiQ5BpjDiyv1
        Ks8EVusKip5WUHqhQd5lp0euD0ApelIq/ha14TXlRobJWwIqPUAc9PcjuN+iG3TBzJ7tLE
        bX/vpj0NVBckk1Wqtrr3LcPOQC7S8a8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689805171;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BqbNsJJZFHzrk+OQKgoo/9ZCZoHSnGZs9WOrN7/OQBs=;
        b=MTk8FDvkwaRjQnMM4zvFMuqLq9yAKkyyuSUoPvbHoEQwl3inTM9iY25+Iyvi7Xnt/CX1M/
        S6X5zmrqZleoNNBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CB6CD1361C;
        Wed, 19 Jul 2023 22:19:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4rUtLHJhuGQLJgAAMHmgww
        (envelope-from <krisman@suse.de>); Wed, 19 Jul 2023 22:19:30 +0000
From:   Gabriel Krisman Bertazi <krisman@suse.de>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
        ebiggers@kernel.org, jaegeuk@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Gabriel Krisman Bertazi <krisman@suse.de>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH v3 1/7] fs: Expose name under lookup to d_revalidate hook
Date:   Wed, 19 Jul 2023 18:19:12 -0400
Message-ID: <20230719221918.8937-2-krisman@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719221918.8937-1-krisman@suse.de>
References: <20230719221918.8937-1-krisman@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Gabriel Krisman Bertazi <krisman@collabora.com>

Negative dentries support on case-insensitive ext4/f2fs will require
access to the name under lookup to ensure it matches the dentry.  This
adds an optional new flavor of cached dentry revalidation hook to expose
this extra parameter.

I'm fine with extending d_revalidate instead of adding a new hook, if
it is considered cleaner and the approach is accepted.  I wrote a new
hook to simplify reviewing.

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v2:
  - Document d_revalidate_name hook. (Eric)
---
 Documentation/filesystems/locking.rst |  3 +++
 Documentation/filesystems/vfs.rst     | 12 ++++++++++++
 fs/dcache.c                           |  2 +-
 fs/namei.c                            | 23 ++++++++++++++---------
 include/linux/dcache.h                |  1 +
 5 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index ed148919e11a..d68997ba6584 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -18,6 +18,8 @@ dentry_operations
 prototypes::
 
 	int (*d_revalidate)(struct dentry *, unsigned int);
+	int (*d_revalidate_name)(struct dentry *, const struct qstr *,
+				 unsigned int);
 	int (*d_weak_revalidate)(struct dentry *, unsigned int);
 	int (*d_hash)(const struct dentry *, struct qstr *);
 	int (*d_compare)(const struct dentry *,
@@ -37,6 +39,7 @@ locking rules:
 ops		   rename_lock	->d_lock	may block	rcu-walk
 ================== ===========	========	==============	========
 d_revalidate:	   no		no		yes (ref-walk)	maybe
+d_revalidate_name: no		no		yes (ref-walk)	maybe
 d_weak_revalidate: no		no		yes	 	no
 d_hash		   no		no		no		maybe
 d_compare:	   yes		no		no		maybe
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index cb2a97e49872..34c842bd7cb2 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -1252,6 +1252,8 @@ defined:
 
 	struct dentry_operations {
 		int (*d_revalidate)(struct dentry *, unsigned int);
+		int (*d_revalidate_name)(struct dentry *, const struct qstr *,
+					 unsigned int);
 		int (*d_weak_revalidate)(struct dentry *, unsigned int);
 		int (*d_hash)(const struct dentry *, struct qstr *);
 		int (*d_compare)(const struct dentry *,
@@ -1288,6 +1290,16 @@ defined:
 	return
 	-ECHILD and it will be called again in ref-walk mode.
 
+``d_revalidate_name``
+	Variant of d_revalidate that also provides the name under look-up.  Most
+	filesystems will keep it as NULL, unless there are particular semantics
+	for filenames encoding that need to be handled during dentry
+	revalidation.
+
+	When available, it is called in lieu of d_revalidate and has the same
+	locking rules and return semantics.  Refer to d_revalidate for more
+	information.
+
 ``d_weak_revalidate``
 	called when the VFS needs to revalidate a "jumped" dentry.  This
 	is called when a path-walk ends at dentry that was not acquired
diff --git a/fs/dcache.c b/fs/dcache.c
index 52e6d5fdab6b..98521862e58a 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1928,7 +1928,7 @@ void d_set_d_op(struct dentry *dentry, const struct dentry_operations *op)
 		dentry->d_flags |= DCACHE_OP_HASH;
 	if (op->d_compare)
 		dentry->d_flags |= DCACHE_OP_COMPARE;
-	if (op->d_revalidate)
+	if (op->d_revalidate || op->d_revalidate_name)
 		dentry->d_flags |= DCACHE_OP_REVALIDATE;
 	if (op->d_weak_revalidate)
 		dentry->d_flags |= DCACHE_OP_WEAK_REVALIDATE;
diff --git a/fs/namei.c b/fs/namei.c
index e56ff39a79bc..84df0ddd20db 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -853,11 +853,16 @@ static bool try_to_unlazy_next(struct nameidata *nd, struct dentry *dentry)
 	return false;
 }
 
-static inline int d_revalidate(struct dentry *dentry, unsigned int flags)
+static inline int d_revalidate(struct dentry *dentry,
+			       const struct qstr *name,
+			       unsigned int flags)
 {
-	if (unlikely(dentry->d_flags & DCACHE_OP_REVALIDATE))
+
+	if (unlikely(dentry->d_flags & DCACHE_OP_REVALIDATE)) {
+		if (dentry->d_op->d_revalidate_name)
+			return dentry->d_op->d_revalidate_name(dentry, name, flags);
 		return dentry->d_op->d_revalidate(dentry, flags);
-	else
+	} else
 		return 1;
 }
 
@@ -1565,7 +1570,7 @@ static struct dentry *lookup_dcache(const struct qstr *name,
 {
 	struct dentry *dentry = d_lookup(dir, name);
 	if (dentry) {
-		int error = d_revalidate(dentry, flags);
+		int error = d_revalidate(dentry, name, flags);
 		if (unlikely(error <= 0)) {
 			if (!error)
 				d_invalidate(dentry);
@@ -1636,19 +1641,19 @@ static struct dentry *lookup_fast(struct nameidata *nd)
 		if (read_seqcount_retry(&parent->d_seq, nd->seq))
 			return ERR_PTR(-ECHILD);
 
-		status = d_revalidate(dentry, nd->flags);
+		status = d_revalidate(dentry, &nd->last, nd->flags);
 		if (likely(status > 0))
 			return dentry;
 		if (!try_to_unlazy_next(nd, dentry))
 			return ERR_PTR(-ECHILD);
 		if (status == -ECHILD)
 			/* we'd been told to redo it in non-rcu mode */
-			status = d_revalidate(dentry, nd->flags);
+			status = d_revalidate(dentry, &nd->last, nd->flags);
 	} else {
 		dentry = __d_lookup(parent, &nd->last);
 		if (unlikely(!dentry))
 			return NULL;
-		status = d_revalidate(dentry, nd->flags);
+		status = d_revalidate(dentry, &nd->last, nd->flags);
 	}
 	if (unlikely(status <= 0)) {
 		if (!status)
@@ -1676,7 +1681,7 @@ static struct dentry *__lookup_slow(const struct qstr *name,
 	if (IS_ERR(dentry))
 		return dentry;
 	if (unlikely(!d_in_lookup(dentry))) {
-		int error = d_revalidate(dentry, flags);
+		int error = d_revalidate(dentry, name, flags);
 		if (unlikely(error <= 0)) {
 			if (!error) {
 				d_invalidate(dentry);
@@ -3421,7 +3426,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		if (d_in_lookup(dentry))
 			break;
 
-		error = d_revalidate(dentry, nd->flags);
+		error = d_revalidate(dentry, &nd->last, nd->flags);
 		if (likely(error > 0))
 			break;
 		if (error)
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 6b351e009f59..b6188f2e8950 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -127,6 +127,7 @@ enum dentry_d_lock_class
 
 struct dentry_operations {
 	int (*d_revalidate)(struct dentry *, unsigned int);
+	int (*d_revalidate_name)(struct dentry *, const struct qstr *, unsigned int);
 	int (*d_weak_revalidate)(struct dentry *, unsigned int);
 	int (*d_hash)(const struct dentry *, struct qstr *);
 	int (*d_compare)(const struct dentry *,
-- 
2.41.0

