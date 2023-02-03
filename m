Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7CFB68A41A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Feb 2023 22:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbjBCVDR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Feb 2023 16:03:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233378AbjBCVCQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Feb 2023 16:02:16 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2013CADB81;
        Fri,  3 Feb 2023 13:00:57 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 095CB35221;
        Fri,  3 Feb 2023 21:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1675458056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VpQKRYpxWNfqxnOUxnmAMhcMM61o+m01/yxS25IM//E=;
        b=qzU6sZq3+ncLeGpn1Yyl+tBreVsZXCJD5DDIi8TcHuuqa6mBE6Ab+hRHwZPVsMjTgklGQN
        FFA8rLsCK6CA7kW4Cab4Rgrc2DVExbOOMwn4Zw76Ipi3I+uCpgVicfixhZ2CgN4/Atd9If
        Z2oTpfeHR3wqvJNxdEs+GHszkFm9zmk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1675458056;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VpQKRYpxWNfqxnOUxnmAMhcMM61o+m01/yxS25IM//E=;
        b=g1/Xcs1XoBhIFjs7NnvkjC43OTaJlJDv7mX1Am3OWMGtLI36JHFG44pv9CHVVN2+r199F5
        scQWCIBvrH/5O3DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8D1A71358A;
        Fri,  3 Feb 2023 21:00:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id R1PVFQd23WPtJgAAMHmgww
        (envelope-from <krisman@suse.de>); Fri, 03 Feb 2023 21:00:55 +0000
From:   Gabriel Krisman Bertazi <krisman@suse.de>
To:     viro@zeniv.linux.org.uk, tytso@mit.edu, jaegeuk@kernel.org,
        ebiggers@kernel.org, jack@suse.cz
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH v2 1/7] fs: Expose name under lookup to d_revalidate hook
Date:   Fri,  3 Feb 2023 18:00:33 -0300
Message-Id: <20230203210039.16289-2-krisman@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230203210039.16289-1-krisman@suse.de>
References: <20230203210039.16289-1-krisman@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/dcache.c            |  2 +-
 fs/namei.c             | 23 ++++++++++++++---------
 include/linux/dcache.h |  1 +
 3 files changed, 16 insertions(+), 10 deletions(-)

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
index 309ae6fc8c99..525d31cc3b85 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -850,11 +850,16 @@ static bool try_to_unlazy_next(struct nameidata *nd, struct dentry *dentry)
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
 
@@ -1562,7 +1567,7 @@ static struct dentry *lookup_dcache(const struct qstr *name,
 {
 	struct dentry *dentry = d_lookup(dir, name);
 	if (dentry) {
-		int error = d_revalidate(dentry, flags);
+		int error = d_revalidate(dentry, name, flags);
 		if (unlikely(error <= 0)) {
 			if (!error)
 				d_invalidate(dentry);
@@ -1631,19 +1636,19 @@ static struct dentry *lookup_fast(struct nameidata *nd)
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
@@ -1671,7 +1676,7 @@ static struct dentry *__lookup_slow(const struct qstr *name,
 	if (IS_ERR(dentry))
 		return dentry;
 	if (unlikely(!d_in_lookup(dentry))) {
-		int error = d_revalidate(dentry, flags);
+		int error = d_revalidate(dentry, name, flags);
 		if (unlikely(error <= 0)) {
 			if (!error) {
 				d_invalidate(dentry);
@@ -3342,7 +3347,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
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
2.35.3

