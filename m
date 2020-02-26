Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 736751703F4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 17:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgBZQPO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 11:15:14 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56956 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727746AbgBZQPO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 11:15:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582733713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=zbql1kVgqCWhrElPMYBBCs9TKzQ7a0c/Z0nt5++LsTQ=;
        b=MniZHCORYMQYbPGaRW7QMiPMUyC5R9YhQq7ZA5j5e+/pkBixKR2fB7v0hNNkzjMjlJDkRs
        DOgHuOL5NwfPfc+GNFzLnnWfmxwoPSVdmnaIv6YxjGkCOfwQ2FWSckaRx23dKbgh57TXbZ
        g6T3tP7I0DJoepglD7bx1Z9Dp3NIuk4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-yAhhoutbM-yxRwr1YGnfRQ-1; Wed, 26 Feb 2020 11:15:07 -0500
X-MC-Unique: yAhhoutbM-yxRwr1YGnfRQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70751107B272;
        Wed, 26 Feb 2020 16:15:05 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E290160BE1;
        Wed, 26 Feb 2020 16:15:02 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 01/11] fs/dcache: Fix incorrect accounting of negative dentries
Date:   Wed, 26 Feb 2020 11:13:54 -0500
Message-Id: <20200226161404.14136-2-longman@redhat.com>
In-Reply-To: <20200226161404.14136-1-longman@redhat.com>
References: <20200226161404.14136-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The nr_dentry_negative counter only tracks the number of negative
dentries in lru lists, not when they are in shrink lists. In
both __d_clear_type_and_inode() and __d_instantiate(), only the
DCACHE_LRU_LIST flag is checked. Though it is highly unlikely that
the DCACHE_SHRINK_LIST flag may be set, it is still possible. Fix that
by checking the DCACHE_SHRINK_LIST flag as well to make sure that the
accounting is correct.

The negative dentry test is also moved from __d_instantiate() to
__d_set_inode_and_type() to cover more cases.

Fixes: af0c9af1b3f6 ("fs/dcache: Track & report number of negative dentries")

Signed-off-by: Waiman Long <longman@redhat.com>
---
 fs/dcache.c            | 13 +++++++------
 include/linux/dcache.h |  9 +++++++++
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index b280e07e162b..c17b538bf41c 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -315,6 +315,12 @@ static inline void __d_set_inode_and_type(struct dentry *dentry,
 {
 	unsigned flags;
 
+	/*
+	 * Decrement negative dentry count if it was in the LRU list.
+	 */
+	if (unlikely(d_in_lru(dentry) && d_is_negative(dentry)))
+		this_cpu_dec(nr_dentry_negative);
+
 	dentry->d_inode = inode;
 	flags = READ_ONCE(dentry->d_flags);
 	flags &= ~(DCACHE_ENTRY_TYPE | DCACHE_FALLTHRU);
@@ -329,7 +335,7 @@ static inline void __d_clear_type_and_inode(struct dentry *dentry)
 	flags &= ~(DCACHE_ENTRY_TYPE | DCACHE_FALLTHRU);
 	WRITE_ONCE(dentry->d_flags, flags);
 	dentry->d_inode = NULL;
-	if (dentry->d_flags & DCACHE_LRU_LIST)
+	if (d_in_lru(dentry))
 		this_cpu_inc(nr_dentry_negative);
 }
 
@@ -1919,11 +1925,6 @@ static void __d_instantiate(struct dentry *dentry, struct inode *inode)
 	WARN_ON(d_in_lookup(dentry));
 
 	spin_lock(&dentry->d_lock);
-	/*
-	 * Decrement negative dentry count if it was in the LRU list.
-	 */
-	if (dentry->d_flags & DCACHE_LRU_LIST)
-		this_cpu_dec(nr_dentry_negative);
 	hlist_add_head(&dentry->d_u.d_alias, &inode->i_dentry);
 	raw_write_seqcount_begin(&dentry->d_seq);
 	__d_set_inode_and_type(dentry, inode, add_flags);
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index c1488cc84fd9..2762ca2508f9 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -369,6 +369,15 @@ static inline void d_lookup_done(struct dentry *dentry)
 	}
 }
 
+/*
+ * Dentry is in a LRU list, not a shrink list.
+ */
+static inline bool d_in_lru(struct dentry *dentry)
+{
+	return (dentry->d_flags & (DCACHE_SHRINK_LIST | DCACHE_LRU_LIST))
+		== DCACHE_LRU_LIST;
+}
+
 extern void dput(struct dentry *);
 
 static inline bool d_managed(const struct dentry *dentry)
-- 
2.18.1

