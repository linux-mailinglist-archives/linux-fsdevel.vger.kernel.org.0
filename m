Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70CDB170405
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 17:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbgBZQPi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 11:15:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51956 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728373AbgBZQPh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 11:15:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582733737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=plSY3/ieBBIb+uqAgd5rkUQMsog86fQPx4J35UFU/bc=;
        b=E5B24mbs4NAB4uNAp+xMnYWDt2c/RQyY3O1OtCOwDUvym0yILB+SVahps7umRKAptHFGTE
        M95aDP1cMFMdn4yLqeIZ/OQrctHVDCcqnthYJjolz9+egTWDUlQKuZvF2Db91jQKOIPY4H
        Gu/BfcLmqQrSUYDVA6JLIm1vzsk/5Po=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-Hj-vPNxaMieEVX_Boex0rg-1; Wed, 26 Feb 2020 11:15:33 -0500
X-MC-Unique: Hj-vPNxaMieEVX_Boex0rg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 289DADBF2;
        Wed, 26 Feb 2020 16:15:31 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 536B860BE1;
        Wed, 26 Feb 2020 16:15:25 +0000 (UTC)
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
Subject: [PATCH 07/11] fs/dcache: Add static key negative_reclaim_enable
Date:   Wed, 26 Feb 2020 11:14:00 -0500
Message-Id: <20200226161404.14136-8-longman@redhat.com>
In-Reply-To: <20200226161404.14136-1-longman@redhat.com>
References: <20200226161404.14136-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a static_key negative_reclaim_enable to optimize the default case
where negative dentry directory limit "dentry-dir-max" is not set.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 fs/dcache.c     | 30 ++++++++++++++++++++++++++++--
 kernel/sysctl.c |  3 ++-
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index c5364c2ed5d8..149c0a6c1a6e 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -32,6 +32,7 @@
 #include <linux/bit_spinlock.h>
 #include <linux/rculist_bl.h>
 #include <linux/list_lru.h>
+#include <linux/jump_label.h>
 #include "internal.h"
 #include "mount.h"
 
@@ -134,11 +135,13 @@ int dcache_dentry_dir_max_sysctl __read_mostly;
 EXPORT_SYMBOL_GPL(dcache_dentry_dir_max_sysctl);
 
 static LLIST_HEAD(negative_reclaim_list);
+static DEFINE_STATIC_KEY_FALSE(negative_reclaim_enable);
 static void negative_reclaim_check(struct dentry *parent);
 static void negative_reclaim_workfn(struct work_struct *work);
 static DECLARE_WORK(negative_reclaim_work, negative_reclaim_workfn);
 
 #if defined(CONFIG_SYSCTL) && defined(CONFIG_PROC_FS)
+proc_handler proc_dcache_dentry_dir_max;
 
 /*
  * Here we resort to our own counters instead of using generic per-cpu counters
@@ -188,6 +191,27 @@ int proc_nr_dentry(struct ctl_table *table, int write, void __user *buffer,
 	dentry_stat.nr_negative = get_nr_dentry_negative();
 	return proc_doulongvec_minmax(table, write, buffer, lenp, ppos);
 }
+
+/*
+ * Sysctl proc handler for dcache_dentry_dir_max_sysctl
+ */
+int proc_dcache_dentry_dir_max(struct ctl_table *ctl, int write,
+			       void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	int old = dcache_dentry_dir_max_sysctl;
+	int ret;
+
+	ret = proc_dointvec_minmax(ctl, write, buffer, lenp, ppos);
+
+	if (!write || ret || (dcache_dentry_dir_max_sysctl == old))
+		return ret;
+
+	if (!old && dcache_dentry_dir_max_sysctl)
+		static_branch_enable(&negative_reclaim_enable);
+	else if (old && !dcache_dentry_dir_max_sysctl)
+		static_branch_disable(&negative_reclaim_enable);
+	return 0;
+}
 #endif
 
 /*
@@ -876,7 +900,8 @@ void dput(struct dentry *dentry)
 		if (likely(retain_dentry(dentry))) {
 			struct dentry *neg_parent = NULL;
 
-			if (d_is_negative(dentry)) {
+			if (static_branch_unlikely(&negative_reclaim_enable) &&
+			    d_is_negative(dentry)) {
 				neg_parent = dentry->d_parent;
 				rcu_read_lock();
 			}
@@ -886,7 +911,8 @@ void dput(struct dentry *dentry)
 			 * Negative dentry reclaim check is only done when
 			 * a negative dentry is being put into a LRU list.
 			 */
-			if (neg_parent)
+			if (static_branch_unlikely(&negative_reclaim_enable) &&
+			    neg_parent)
 				negative_reclaim_check(neg_parent);
 			return;
 		}
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index cd0a83ff1029..9a4b0a1376e8 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -119,6 +119,7 @@ extern unsigned int sysctl_nr_open_min, sysctl_nr_open_max;
 extern int sysctl_nr_trim_pages;
 #endif
 extern int dcache_dentry_dir_max_sysctl;
+extern proc_handler proc_dcache_dentry_dir_max;
 
 /* Constants used for minimum and  maximum */
 #ifdef CONFIG_LOCKUP_DETECTOR
@@ -1956,7 +1957,7 @@ static struct ctl_table fs_table[] = {
 		.data		= &dcache_dentry_dir_max_sysctl,
 		.maxlen		= sizeof(dcache_dentry_dir_max_sysctl),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
+		.proc_handler	= proc_dcache_dentry_dir_max,
 		.extra1		= &zero,
 	},
 	{ }
-- 
2.18.1

