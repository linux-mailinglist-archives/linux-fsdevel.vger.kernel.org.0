Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B72E44625DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 23:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234825AbhK2WoS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 17:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234306AbhK2Wnp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:43:45 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094BFC0F4B2B;
        Mon, 29 Nov 2021 12:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=JXqZmOQKoVb2eKYvWHTAwPv6IRDyNkg72B7fX/jYykE=; b=T2bijWwQpATijat6pZOSc7wllv
        0YosQ/eigSSB/p6fEudk51XPg4/CZnSusC2h3MLhWcp0zWmQwMbeDSgP22jYmX89eBGhq1BELMzFH
        W2gel2nJsQE2hdxMW8pwivdNUp6rt84oGHVakrTPHdxTmqoYcKB43r8IpGAen0VJOou/sg/gS4XrV
        /VNAr56l6aBqW+SKf98hpFTiisSfmu7kVE6G4ZnGTetGKhctX4wHSEHMjrDXMQSv3eKT1KjzlMqlH
        iY+xL4Qs92dqjhv/tRO/3u8jmPTwKVGf2DAv5x5TQ0Mhbsm/ImuELTvV4hg3IDHoY6oYX4atj7YVj
        IC+nCYHA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mrngl-002XZa-3l; Mon, 29 Nov 2021 20:55:51 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        keescook@chromium.org, yzaikin@google.com, nixiaoming@huawei.com,
        ebiederm@xmission.com, steve@sk2.org,
        mcgrof@bombadil.infradead.org, mcgrof@kernel.org,
        andriy.shevchenko@linux.intel.com, jlayton@kernel.org,
        bfields@fieldses.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] fs: move dcache sysctls to its own file
Date:   Mon, 29 Nov 2021 12:55:42 -0800
Message-Id: <20211129205548.605569-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211129205548.605569-1-mcgrof@kernel.org>
References: <20211129205548.605569-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The kernel/sysctl.c is a kitchen sink where everyone leaves
their dirty dishes, this makes it very difficult to maintain.

To help with this maintenance let's start by moving sysctls to
places where they actually belong. The proc sysctl maintainers
do not want to know what sysctl knobs you wish to add for your own
piece of code, we just care about the core logic.

So move the dcache sysctl clutter out of kernel/sysctl.c.
This is a small one-off entry, perhaps later we can simplify
this representation, but for now we use the helpers we have.
We won't know how we can simplify this further untl we're
fully done with the cleanup.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/dcache.c            | 32 +++++++++++++++++++++++++++++---
 include/linux/dcache.h | 10 ----------
 include/linux/fs.h     |  2 --
 kernel/sysctl.c        |  7 -------
 4 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index cf871a81f4fd..0eef1102f460 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -115,9 +115,17 @@ static inline struct hlist_bl_head *in_lookup_hash(const struct dentry *parent,
 	return in_lookup_hashtable + hash_32(hash, IN_LOOKUP_SHIFT);
 }
 
+struct dentry_stat_t {
+	long nr_dentry;
+	long nr_unused;
+	long age_limit;		/* age in seconds */
+	long want_pages;	/* pages requested by system */
+	long nr_negative;	/* # of unused negative dentries */
+	long dummy;		/* Reserved for future use */
+};
 
 /* Statistics gathering. */
-struct dentry_stat_t dentry_stat = {
+static struct dentry_stat_t dentry_stat = {
 	.age_limit = 45,
 };
 
@@ -167,14 +175,32 @@ static long get_nr_dentry_negative(void)
 	return sum < 0 ? 0 : sum;
 }
 
-int proc_nr_dentry(struct ctl_table *table, int write, void *buffer,
-		   size_t *lenp, loff_t *ppos)
+static int proc_nr_dentry(struct ctl_table *table, int write, void *buffer,
+			  size_t *lenp, loff_t *ppos)
 {
 	dentry_stat.nr_dentry = get_nr_dentry();
 	dentry_stat.nr_unused = get_nr_dentry_unused();
 	dentry_stat.nr_negative = get_nr_dentry_negative();
 	return proc_doulongvec_minmax(table, write, buffer, lenp, ppos);
 }
+
+static struct ctl_table fs_dcache_sysctls[] = {
+	{
+		.procname	= "dentry-state",
+		.data		= &dentry_stat,
+		.maxlen		= 6*sizeof(long),
+		.mode		= 0444,
+		.proc_handler	= proc_nr_dentry,
+	},
+	{ }
+};
+
+static int __init init_fs_dcache_sysctls(void)
+{
+	register_sysctl_init("fs", fs_dcache_sysctls);
+	return 0;
+}
+fs_initcall(init_fs_dcache_sysctls);
 #endif
 
 /*
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 9e23d33bb6f1..f5bba51480b2 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -61,16 +61,6 @@ extern const struct qstr empty_name;
 extern const struct qstr slash_name;
 extern const struct qstr dotdot_name;
 
-struct dentry_stat_t {
-	long nr_dentry;
-	long nr_unused;
-	long age_limit;		/* age in seconds */
-	long want_pages;	/* pages requested by system */
-	long nr_negative;	/* # of unused negative dentries */
-	long dummy;		/* Reserved for future use */
-};
-extern struct dentry_stat_t dentry_stat;
-
 /*
  * Try to keep struct dentry aligned on 64 byte cachelines (this will
  * give reasonable cacheline footprint with larger lines without the
diff --git a/include/linux/fs.h b/include/linux/fs.h
index adb74ecaf686..edec0692f943 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3590,8 +3590,6 @@ ssize_t simple_attr_write(struct file *file, const char __user *buf,
 			  size_t len, loff_t *ppos);
 
 struct ctl_table;
-int proc_nr_dentry(struct ctl_table *table, int write,
-		  void *buffer, size_t *lenp, loff_t *ppos);
 int __init list_bdev_fs_names(char *buf, size_t size);
 
 #define __FMODE_EXEC		((__force int) FMODE_EXEC)
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index a94d24595fa3..dbd267d0f014 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2900,13 +2900,6 @@ static struct ctl_table vm_table[] = {
 };
 
 static struct ctl_table fs_table[] = {
-	{
-		.procname	= "dentry-state",
-		.data		= &dentry_stat,
-		.maxlen		= 6*sizeof(long),
-		.mode		= 0444,
-		.proc_handler	= proc_nr_dentry,
-	},
 	{
 		.procname	= "overflowuid",
 		.data		= &fs_overflowuid,
-- 
2.33.0

