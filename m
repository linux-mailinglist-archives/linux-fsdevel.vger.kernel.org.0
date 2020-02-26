Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA8CE170415
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 17:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgBZQQD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 11:16:03 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39281 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728734AbgBZQP6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 11:15:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582733756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=ywx1qIVqpeFVyk5FdbSzu1McnsKdZIvwvf+WZMVi7Zs=;
        b=BuqaloSov3HuKrUUTLwuz5jdJwGMVxZTCOSee7MjY6m7196phtfa7WO4SNVb7ijQv6S5IY
        yQuC0uR1ug8O36LGeIoTWaezF1V9eFkWjWxlI4TpJmijNkVp1TTMnE5gdD29dYYWXnXSa0
        UJjDG2uiDa4JksP+Aloux0+OCdEbgfQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-K7C2TJKJPyaLBrctJLBKxQ-1; Wed, 26 Feb 2020 11:15:53 -0500
X-MC-Unique: K7C2TJKJPyaLBrctJLBKxQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3873F800D6C;
        Wed, 26 Feb 2020 16:15:51 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CFD6F60BE1;
        Wed, 26 Feb 2020 16:15:47 +0000 (UTC)
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
Subject: [PATCH 11/11] fs/dcache: Track # of negative dentries reclaimed & killed
Date:   Wed, 26 Feb 2020 11:14:04 -0500
Message-Id: <20200226161404.14136-12-longman@redhat.com>
In-Reply-To: <20200226161404.14136-1-longman@redhat.com>
References: <20200226161404.14136-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The negative dentry reclaim process gave no visible indication that
it was being activated. In order to allow system administrator to
see if it is being activated as expected, two new debugfs variables
"negative_dentry_reclaimed" and "negative_dentry_killed" are now added
to report the total number of negative dentries that have been reclaimed
and killed. These debugfs variables are only added after the negative
dentry reclaim mechanism is activated for the first time.

In reality, the actual number may be slightly less than the reported
number as not all the negative dentries passed to shrink_dentry_list()
and __dentry_kill() can be successfully reclaimed.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 fs/dcache.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index fe48e00349c9..471b51316506 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -33,6 +33,7 @@
 #include <linux/rculist_bl.h>
 #include <linux/list_lru.h>
 #include <linux/jump_label.h>
+#include <linux/debugfs.h>
 #include "internal.h"
 #include "mount.h"
 
@@ -136,6 +137,8 @@ static DEFINE_PER_CPU(long, nr_dentry_negative);
 int dcache_dentry_dir_max_sysctl;
 EXPORT_SYMBOL_GPL(dcache_dentry_dir_max_sysctl);
 static int negative_dentry_dir_max __read_mostly;
+static unsigned long negative_dentry_reclaim_count;
+static atomic_t negative_dentry_kill_count;
 #define	DENTRY_DIR_MAX_MIN	0x100
 
 static LLIST_HEAD(negative_reclaim_list);
@@ -204,6 +207,7 @@ int proc_dcache_dentry_dir_max(struct ctl_table *ctl, int write,
 {
 	int old = dcache_dentry_dir_max_sysctl;
 	int ret;
+	static bool debugfs_file_created;
 
 	ret = proc_dointvec_minmax(ctl, write, buffer, lenp, ppos);
 
@@ -219,6 +223,14 @@ int proc_dcache_dentry_dir_max(struct ctl_table *ctl, int write,
 		return -EINVAL;
 	}
 
+	if (!debugfs_file_created) {
+		debugfs_create_ulong("negative_dentry_reclaimed", 0400, NULL,
+				     &negative_dentry_reclaim_count);
+		debugfs_create_u32("negative_dentry_killed", 0400, NULL,
+				   (u32 *)&negative_dentry_kill_count.counter);
+		debugfs_file_created = true;
+	}
+
 	negative_dentry_dir_max = dcache_dentry_dir_max_sysctl;
 	if (!old && dcache_dentry_dir_max_sysctl)
 		static_branch_enable(&negative_reclaim_enable);
@@ -1542,6 +1554,8 @@ static void negative_reclaim_workfn(struct work_struct *work)
 		kfree(dentry_node);
 		cond_resched();
 	}
+	if (quota < MAX_DENTRY_RECLAIM)
+		negative_dentry_reclaim_count += MAX_DENTRY_RECLAIM - quota;
 }
 
 /*
@@ -1609,6 +1623,7 @@ static void negative_reclaim_check(struct dentry *parent, struct dentry *child)
 			rcu_read_unlock();
 			__dentry_kill(child);
 			dput(parent);
+			atomic_inc(&negative_dentry_kill_count);
 			return;
 		}
 		spin_unlock(&child->d_lock);
-- 
2.18.1

