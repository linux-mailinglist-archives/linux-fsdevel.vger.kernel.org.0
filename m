Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63C0A170411
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 17:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgBZQPz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 11:15:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28200 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727113AbgBZQPy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 11:15:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582733754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=GUkVDGXeY3ZWzjteqVo5pUlFA8rYYrLY++MrI/DOw0Y=;
        b=NMUAcpxG/Sag8zN1j6HB3Ly6ZmbnpD8kKQFLIlZXJlH11s1xaLSO5/BVj6wiDvcWN4wm6S
        LZX0lgOCxQfA+ZHHWF6Lg9SOzod+1iX3YUxelWHcweSNa8rTNHIBiUJBq78q+BxfgCQPJi
        apMB5dghZPXtGlq6G6oidFrSRcxxNGM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-SqNXyJ2kPl6nm_SNBbhjtQ-1; Wed, 26 Feb 2020 11:15:49 -0500
X-MC-Unique: SqNXyJ2kPl6nm_SNBbhjtQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2287802573;
        Wed, 26 Feb 2020 16:15:47 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0CCA160BE1;
        Wed, 26 Feb 2020 16:15:44 +0000 (UTC)
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
Subject: [PATCH 10/11] fs/dcache: Kill off dentry as last resort
Date:   Wed, 26 Feb 2020 11:14:03 -0500
Message-Id: <20200226161404.14136-11-longman@redhat.com>
In-Reply-To: <20200226161404.14136-1-longman@redhat.com>
References: <20200226161404.14136-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In the unlikely case that an out-of-control application is generating
negative dentries faster than what the negative dentry reclaim process
can get rid of, we will have to kill the negative dentry directly as
the last resort.

The current threshold for killing negative dentry is the maximum of 4
times dentry-dir-max and 10,000 within a directory.

On a 32-vcpu VM, a 30-thread parallel negative dentry generation problem
was run. Without this patch, the negative dentry reclaim process was
overwhelmed by the negative dentry generator and the number of negative
dentries kept growing. With this patch applied with a "dentry-dir-max"
of 10,000. The number of negative dentries never went beyond 40,000.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 fs/dcache.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index f470763e7fb8..fe48e00349c9 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -140,7 +140,7 @@ static int negative_dentry_dir_max __read_mostly;
 
 static LLIST_HEAD(negative_reclaim_list);
 static DEFINE_STATIC_KEY_FALSE(negative_reclaim_enable);
-static void negative_reclaim_check(struct dentry *parent);
+static void negative_reclaim_check(struct dentry *parent, struct dentry *child);
 static void negative_reclaim_workfn(struct work_struct *work);
 static DECLARE_WORK(negative_reclaim_work, negative_reclaim_workfn);
 
@@ -927,7 +927,7 @@ void dput(struct dentry *dentry)
 			 */
 			if (static_branch_unlikely(&negative_reclaim_enable) &&
 			    neg_parent)
-				negative_reclaim_check(neg_parent);
+				negative_reclaim_check(neg_parent, dentry);
 			return;
 		}
 
@@ -1548,10 +1548,12 @@ static void negative_reclaim_workfn(struct work_struct *work)
  * Check the parent to see if it has too many negative dentries and queue
  * it up for the negative dentry reclaim work function to handle it.
  */
-static void negative_reclaim_check(struct dentry *parent)
+static void negative_reclaim_check(struct dentry *parent, struct dentry *child)
 	__releases(rcu)
 {
 	int limit = negative_dentry_dir_max;
+	int kill_threshold = max(4 * limit, 10000);
+	int ncnt = read_dentry_nnegative(parent);
 	struct reclaim_dentry *dentry_node;
 
 	if (!limit)
@@ -1560,16 +1562,16 @@ static void negative_reclaim_check(struct dentry *parent)
 	/*
 	 * These checks are racy before spin_lock().
 	 */
-	if (!can_reclaim_dentry(parent->d_flags) ||
-	    (parent->d_flags & DCACHE_RECLAIMING) ||
-	    (read_dentry_nnegative(parent) <= limit))
+	if ((!can_reclaim_dentry(parent->d_flags) ||
+	    (parent->d_flags & DCACHE_RECLAIMING) || (ncnt <= limit)) &&
+	    (ncnt < kill_threshold))
 		goto rcu_unlock_out;
 
 	spin_lock(&parent->d_lock);
+	ncnt = read_dentry_nnegative(parent);
 	if (!can_reclaim_dentry(parent->d_flags) ||
 	    (parent->d_flags & DCACHE_RECLAIMING) ||
-	    (read_dentry_nnegative(parent) <= limit) ||
-	    !d_is_dir(parent))
+	    (ncnt <= limit) || !d_is_dir(parent))
 		goto unlock_out;
 
 	dentry_node = kzalloc(sizeof(*dentry_node), GFP_NOWAIT);
@@ -1592,6 +1594,25 @@ static void negative_reclaim_check(struct dentry *parent)
 	return;
 
 unlock_out:
+	/*
+	 * In the unlikely case that an out-of-control application is
+	 * generating negative dentries faster than what the negative
+	 * dentry reclaim process can get rid of, we will have to kill
+	 * the negative dentry directly as the last resort.
+	 *
+	 * N.B. __dentry_kill() releases both the parent and child's d_lock.
+	 */
+	if (unlikely(ncnt >= kill_threshold)) {
+		spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
+		if (can_reclaim_dentry(child->d_flags) &&
+		    !child->d_lockref.count && (child->d_parent == parent)) {
+			rcu_read_unlock();
+			__dentry_kill(child);
+			dput(parent);
+			return;
+		}
+		spin_unlock(&child->d_lock);
+	}
 	spin_unlock(&parent->d_lock);
 rcu_unlock_out:
 	rcu_read_unlock();
-- 
2.18.1

