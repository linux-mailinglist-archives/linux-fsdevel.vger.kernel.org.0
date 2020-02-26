Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DED9917040F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 17:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbgBZQPv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 11:15:51 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60715 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728231AbgBZQPv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 11:15:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582733750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=WAJNmARdDy6U3AnNzgF1Y6hbeCE51bqcuKxWLiiANy0=;
        b=ieHfa08jsQvjNPSW/slmP7AE9Sjg9A0qxqbHZh61ub2c6WehybEWhSL7rYJ4JjftkQ8eal
        VPVsHTY/LxJEKjILtv+tgwUHdAMZ9GEfnZGdkKTyodZZlLYRHvv9x8yYhozXiIygBSFw+q
        lbBmwvIkbFOq9S7FETS5dvmNzRJub8A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-1xEJLjCZMlqeDisfGRA45A-1; Wed, 26 Feb 2020 11:15:46 -0500
X-MC-Unique: 1xEJLjCZMlqeDisfGRA45A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6BFF13E5;
        Wed, 26 Feb 2020 16:15:44 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3814260BE1;
        Wed, 26 Feb 2020 16:15:34 +0000 (UTC)
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
Subject: [PATCH 09/11] fs/dcache: Don't allow small values for dentry-dir-max
Date:   Wed, 26 Feb 2020 11:14:02 -0500
Message-Id: <20200226161404.14136-10-longman@redhat.com>
In-Reply-To: <20200226161404.14136-1-longman@redhat.com>
References: <20200226161404.14136-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A small value for "dentry-dir-max", e.g. < 10, will cause excessive
dentry count checking leading to noticeable performance degradation. In
order to make this sysctl parameter more foolproof, we are not going
to allow any positive integer value less than 256.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/admin-guide/sysctl/fs.rst | 10 +++++-----
 fs/dcache.c                             | 24 +++++++++++++++++++-----
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/fs.rst b/Documentation/admin-guide/sysctl/fs.rst
index 7274a7b34ee4..e09d851f9d42 100644
--- a/Documentation/admin-guide/sysctl/fs.rst
+++ b/Documentation/admin-guide/sysctl/fs.rst
@@ -71,11 +71,11 @@ in the directory.  No restriction is placed on the number of positive
 dentries as it is naturally limited by the number of files in the
 directory.
 
-The default value is 0 which means there is no limit.  Any non-negative
-value is allowed.  However, internal tracking is done on all dentry
-types. So the value given, if non-zero, should be larger than the
-number of files in a typical large directory in order to reduce the
-tracking overhead.
+The default value is 0 which means there is no limit.  Any positive
+integer value not less than 256 is also allowed.  However, internal
+tracking is done on all dentry types. So the value given, if non-zero,
+should be larger than the number of files in a typical large directory
+in order to reduce the tracking overhead.
 
 
 dentry-state
diff --git a/fs/dcache.c b/fs/dcache.c
index 0bd5d6974f75..f470763e7fb8 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -129,10 +129,14 @@ static DEFINE_PER_CPU(long, nr_dentry_negative);
  *
  * This is sysctl parameter "dentry-dir-max" which specifies a limit on
  * the maximum number of negative dentries that are allowed under any
- * given directory.
+ * given directory. The allowable value of "dentry-dir-max" is either
+ * 0, which means no limit, or 256 and up. A low value of "dentry-dir-max"
+ * will cause excessive dentry count checking affecting system performance.
  */
-int dcache_dentry_dir_max_sysctl __read_mostly;
+int dcache_dentry_dir_max_sysctl;
 EXPORT_SYMBOL_GPL(dcache_dentry_dir_max_sysctl);
+static int negative_dentry_dir_max __read_mostly;
+#define	DENTRY_DIR_MAX_MIN	0x100
 
 static LLIST_HEAD(negative_reclaim_list);
 static DEFINE_STATIC_KEY_FALSE(negative_reclaim_enable);
@@ -206,6 +210,16 @@ int proc_dcache_dentry_dir_max(struct ctl_table *ctl, int write,
 	if (!write || ret || (dcache_dentry_dir_max_sysctl == old))
 		return ret;
 
+	/*
+	 * A non-zero value must be >= DENTRY_DIR_MAX_MIN.
+	 */
+	if (dcache_dentry_dir_max_sysctl &&
+	   (dcache_dentry_dir_max_sysctl < DENTRY_DIR_MAX_MIN)) {
+		dcache_dentry_dir_max_sysctl = old;
+		return -EINVAL;
+	}
+
+	negative_dentry_dir_max = dcache_dentry_dir_max_sysctl;
 	if (!old && dcache_dentry_dir_max_sysctl)
 		static_branch_enable(&negative_reclaim_enable);
 	else if (old && !dcache_dentry_dir_max_sysctl)
@@ -1396,7 +1410,7 @@ static void reclaim_negative_dentry(struct dentry *parent, int *quota,
 				    struct list_head *dispose)
 {
 	struct dentry *child;
-	int limit = READ_ONCE(dcache_dentry_dir_max_sysctl);
+	int limit = READ_ONCE(negative_dentry_dir_max);
 	int cnt, npositive;
 
 	lockdep_assert_held(&parent->d_lock);
@@ -1405,7 +1419,7 @@ static void reclaim_negative_dentry(struct dentry *parent, int *quota,
 
 	/*
 	 * Compute # of negative dentries to be reclaimed
-	 * An extra 1/8 of dcache_dentry_dir_max_sysctl is added.
+	 * An extra 1/8 of negative_dentry_dir_max is added.
 	 */
 	if (cnt <= limit)
 		return;
@@ -1537,7 +1551,7 @@ static void negative_reclaim_workfn(struct work_struct *work)
 static void negative_reclaim_check(struct dentry *parent)
 	__releases(rcu)
 {
-	int limit = dcache_dentry_dir_max_sysctl;
+	int limit = negative_dentry_dir_max;
 	struct reclaim_dentry *dentry_node;
 
 	if (!limit)
-- 
2.18.1

