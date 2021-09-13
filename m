Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA24540844C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Sep 2021 07:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237122AbhIMGAx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Sep 2021 02:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237072AbhIMGAw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Sep 2021 02:00:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4BDC061574;
        Sun, 12 Sep 2021 22:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Q5g6HBLS9wMXdCb/wrDI9KH3R+0o9ydrgII9VUtQbLk=; b=cZ/Y6t0O3ixYHqgOKujGrkEcZq
        ZQfWjGQbbqkRcbfGvhtKVS9CZFx7jujqD7NEGw1VNeIbJV1hi37JaOjsRtPYB1ZlAhbZjoywedejj
        Fn5n+f6SkStf8BJohMHAf5CmbPh1c+QlpQEaSpWk4Am21cY3yTS5m+9ZrMYS/CvnbIfb41o9UyAOX
        4VyFOU5nSpteXCW54KXn71I7m+FSg4ZsjAcUbNJNoevanyWn5hDs5bdLtktNGCOBLcZQUyUAqWiCK
        qnpJhM5kAsrS8+9dOkMhKWatFMNu62jynxkcP0PudMT6p/RT0mX0Ba8iIp40TdBP5JkqlsOhEUVEe
        tN+MqwGQ==;
Received: from 089144214237.atnat0023.highway.a1.net ([89.144.214.237] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mPexl-00DDEh-B8; Mon, 13 Sep 2021 05:57:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/13] xfs: convert xfs_sysfs attrs to use ->seq_show
Date:   Mon, 13 Sep 2021 07:41:21 +0200
Message-Id: <20210913054121.616001-14-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210913054121.616001-1-hch@lst.de>
References: <20210913054121.616001-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Trivial conversion to the seq_file based sysfs attributes.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_stats.c | 24 +++++-------
 fs/xfs/xfs_stats.h |  2 +-
 fs/xfs/xfs_sysfs.c | 96 +++++++++++++++++++++++-----------------------
 3 files changed, 58 insertions(+), 64 deletions(-)

diff --git a/fs/xfs/xfs_stats.c b/fs/xfs/xfs_stats.c
index 20e0534a772c9..71e7a84ba0403 100644
--- a/fs/xfs/xfs_stats.c
+++ b/fs/xfs/xfs_stats.c
@@ -16,10 +16,9 @@ static int counter_val(struct xfsstats __percpu *stats, int idx)
 	return val;
 }
 
-int xfs_stats_format(struct xfsstats __percpu *stats, char *buf)
+void xfs_stats_format(struct xfsstats __percpu *stats, struct seq_file *sf)
 {
 	int		i, j;
-	int		len = 0;
 	uint64_t	xs_xstrat_bytes = 0;
 	uint64_t	xs_write_bytes = 0;
 	uint64_t	xs_read_bytes = 0;
@@ -58,13 +57,12 @@ int xfs_stats_format(struct xfsstats __percpu *stats, char *buf)
 	/* Loop over all stats groups */
 
 	for (i = j = 0; i < ARRAY_SIZE(xstats); i++) {
-		len += scnprintf(buf + len, PATH_MAX - len, "%s",
-				xstats[i].desc);
+		seq_printf(sf, "%s", xstats[i].desc);
+
 		/* inner loop does each group */
 		for (; j < xstats[i].endpoint; j++)
-			len += scnprintf(buf + len, PATH_MAX - len, " %u",
-					counter_val(stats, j));
-		len += scnprintf(buf + len, PATH_MAX - len, "\n");
+			seq_printf(sf, " %u", counter_val(stats, j));
+		seq_printf(sf, "\n");
 	}
 	/* extra precision counters */
 	for_each_possible_cpu(i) {
@@ -74,18 +72,14 @@ int xfs_stats_format(struct xfsstats __percpu *stats, char *buf)
 		defer_relog += per_cpu_ptr(stats, i)->s.defer_relog;
 	}
 
-	len += scnprintf(buf + len, PATH_MAX-len, "xpc %Lu %Lu %Lu\n",
+	seq_printf(sf, "xpc %Lu %Lu %Lu\n",
 			xs_xstrat_bytes, xs_write_bytes, xs_read_bytes);
-	len += scnprintf(buf + len, PATH_MAX-len, "defer_relog %llu\n",
-			defer_relog);
-	len += scnprintf(buf + len, PATH_MAX-len, "debug %u\n",
+	seq_printf(sf, "defer_relog %llu\n", defer_relog);
 #if defined(DEBUG)
-		1);
+	seq_printf(sf, "debug 1\n");
 #else
-		0);
+	seq_printf(sf, "debug 0\n");
 #endif
-
-	return len;
 }
 
 void xfs_stats_clearall(struct xfsstats __percpu *stats)
diff --git a/fs/xfs/xfs_stats.h b/fs/xfs/xfs_stats.h
index 43ffba74f045e..6bf80565893cf 100644
--- a/fs/xfs/xfs_stats.h
+++ b/fs/xfs/xfs_stats.h
@@ -156,7 +156,7 @@ struct xfsstats {
 	(offsetof(struct __xfsstats, member) / (int)sizeof(uint32_t))
 
 
-int xfs_stats_format(struct xfsstats __percpu *stats, char *buf);
+void xfs_stats_format(struct xfsstats __percpu *stats, struct seq_file *sf);
 void xfs_stats_clearall(struct xfsstats __percpu *stats);
 extern struct xstats xfsstats;
 
diff --git a/fs/xfs/xfs_sysfs.c b/fs/xfs/xfs_sysfs.c
index 18dc5eca6c045..efa2aa07f1865 100644
--- a/fs/xfs/xfs_sysfs.c
+++ b/fs/xfs/xfs_sysfs.c
@@ -16,7 +16,7 @@
 
 struct xfs_sysfs_attr {
 	struct attribute attr;
-	ssize_t (*show)(struct kobject *kobject, char *buf);
+	void (*show)(struct kobject *kobject, struct seq_file *sf);
 	ssize_t (*store)(struct kobject *kobject, const char *buf,
 			 size_t count);
 };
@@ -36,15 +36,17 @@ to_attr(struct attribute *attr)
 
 #define ATTR_LIST(name) &xfs_sysfs_attr_##name.attr
 
-STATIC ssize_t
-xfs_sysfs_object_show(
+STATIC int
+xfs_sysfs_object_seq_show(
 	struct kobject		*kobject,
 	struct attribute	*attr,
-	char			*buf)
+	struct seq_file		*sf)
 {
 	struct xfs_sysfs_attr *xfs_attr = to_attr(attr);
 
-	return xfs_attr->show ? xfs_attr->show(kobject, buf) : 0;
+	if (xfs_attr->show)
+		xfs_attr->show(kobject, sf);
+	return 0;
 }
 
 STATIC ssize_t
@@ -60,8 +62,8 @@ xfs_sysfs_object_store(
 }
 
 static const struct sysfs_ops xfs_sysfs_ops = {
-	.show = xfs_sysfs_object_show,
-	.store = xfs_sysfs_object_store,
+	.seq_show	= xfs_sysfs_object_seq_show,
+	.store		= xfs_sysfs_object_store,
 };
 
 static struct attribute *xfs_mp_attrs[] = {
@@ -100,12 +102,12 @@ bug_on_assert_store(
 	return count;
 }
 
-STATIC ssize_t
+STATIC void
 bug_on_assert_show(
 	struct kobject		*kobject,
-	char			*buf)
+	struct seq_file		*sf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", xfs_globals.bug_on_assert ? 1 : 0);
+	seq_printf(sf, "%d\n", xfs_globals.bug_on_assert ? 1 : 0);
 }
 XFS_SYSFS_ATTR_RW(bug_on_assert);
 
@@ -130,12 +132,12 @@ log_recovery_delay_store(
 	return count;
 }
 
-STATIC ssize_t
+STATIC void
 log_recovery_delay_show(
 	struct kobject	*kobject,
-	char		*buf)
+	struct seq_file	*sf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", xfs_globals.log_recovery_delay);
+	seq_printf(sf, "%d\n", xfs_globals.log_recovery_delay);
 }
 XFS_SYSFS_ATTR_RW(log_recovery_delay);
 
@@ -160,12 +162,12 @@ mount_delay_store(
 	return count;
 }
 
-STATIC ssize_t
+STATIC void
 mount_delay_show(
 	struct kobject	*kobject,
-	char		*buf)
+	struct seq_file	*sf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", xfs_globals.mount_delay);
+	seq_printf(sf, "%d\n", xfs_globals.mount_delay);
 }
 XFS_SYSFS_ATTR_RW(mount_delay);
 
@@ -183,12 +185,12 @@ always_cow_store(
 	return count;
 }
 
-static ssize_t
+static void
 always_cow_show(
 	struct kobject	*kobject,
-	char		*buf)
+	struct seq_file	*sf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", xfs_globals.always_cow);
+	seq_printf(sf, "%d\n", xfs_globals.always_cow);
 }
 XFS_SYSFS_ATTR_RW(always_cow);
 
@@ -219,12 +221,12 @@ pwork_threads_store(
 	return count;
 }
 
-STATIC ssize_t
+STATIC void
 pwork_threads_show(
 	struct kobject	*kobject,
-	char		*buf)
+	struct seq_file	*sf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", xfs_globals.pwork_threads);
+	 seq_printf(sf, "%d\n", xfs_globals.pwork_threads);
 }
 XFS_SYSFS_ATTR_RW(pwork_threads);
 #endif /* DEBUG */
@@ -258,14 +260,12 @@ to_xstats(struct kobject *kobject)
 	return container_of(kobj, struct xstats, xs_kobj);
 }
 
-STATIC ssize_t
+STATIC void
 stats_show(
 	struct kobject	*kobject,
-	char		*buf)
+	struct seq_file	*sf)
 {
-	struct xstats	*stats = to_xstats(kobject);
-
-	return xfs_stats_format(stats->xs_stats, buf);
+	return xfs_stats_format(to_xstats(kobject)->xs_stats, sf);
 }
 XFS_SYSFS_ATTR_RO(stats);
 
@@ -313,10 +313,10 @@ to_xlog(struct kobject *kobject)
 	return container_of(kobj, struct xlog, l_kobj);
 }
 
-STATIC ssize_t
+STATIC void
 log_head_lsn_show(
 	struct kobject	*kobject,
-	char		*buf)
+	struct seq_file	*sf)
 {
 	int cycle;
 	int block;
@@ -327,28 +327,28 @@ log_head_lsn_show(
 	block = log->l_curr_block;
 	spin_unlock(&log->l_icloglock);
 
-	return snprintf(buf, PAGE_SIZE, "%d:%d\n", cycle, block);
+	seq_printf(sf, "%d:%d\n", cycle, block);
 }
 XFS_SYSFS_ATTR_RO(log_head_lsn);
 
-STATIC ssize_t
+STATIC void
 log_tail_lsn_show(
 	struct kobject	*kobject,
-	char		*buf)
+	struct seq_file	*sf)
 {
 	int cycle;
 	int block;
 	struct xlog *log = to_xlog(kobject);
 
 	xlog_crack_atomic_lsn(&log->l_tail_lsn, &cycle, &block);
-	return snprintf(buf, PAGE_SIZE, "%d:%d\n", cycle, block);
+	seq_printf(sf, "%d:%d\n", cycle, block);
 }
 XFS_SYSFS_ATTR_RO(log_tail_lsn);
 
-STATIC ssize_t
+STATIC void
 reserve_grant_head_show(
 	struct kobject	*kobject,
-	char		*buf)
+	struct seq_file	*sf)
 
 {
 	int cycle;
@@ -356,21 +356,21 @@ reserve_grant_head_show(
 	struct xlog *log = to_xlog(kobject);
 
 	xlog_crack_grant_head(&log->l_reserve_head.grant, &cycle, &bytes);
-	return snprintf(buf, PAGE_SIZE, "%d:%d\n", cycle, bytes);
+	seq_printf(sf, "%d:%d\n", cycle, bytes);
 }
 XFS_SYSFS_ATTR_RO(reserve_grant_head);
 
-STATIC ssize_t
+STATIC void
 write_grant_head_show(
 	struct kobject	*kobject,
-	char		*buf)
+	struct seq_file	*sf)
 {
 	int cycle;
 	int bytes;
 	struct xlog *log = to_xlog(kobject);
 
 	xlog_crack_grant_head(&log->l_write_head.grant, &cycle, &bytes);
-	return snprintf(buf, PAGE_SIZE, "%d:%d\n", cycle, bytes);
+	seq_printf(sf, "%d:%d\n", cycle, bytes);
 }
 XFS_SYSFS_ATTR_RO(write_grant_head);
 
@@ -412,10 +412,10 @@ err_to_mp(struct kobject *kobject)
 	return container_of(kobj, struct xfs_mount, m_error_kobj);
 }
 
-static ssize_t
+static void
 max_retries_show(
 	struct kobject	*kobject,
-	char		*buf)
+	struct seq_file	*sf)
 {
 	int		retries;
 	struct xfs_error_cfg *cfg = to_error_cfg(kobject);
@@ -425,7 +425,7 @@ max_retries_show(
 	else
 		retries = cfg->max_retries;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", retries);
+	seq_printf(sf, "%d\n", retries);
 }
 
 static ssize_t
@@ -453,10 +453,10 @@ max_retries_store(
 }
 XFS_SYSFS_ATTR_RW(max_retries);
 
-static ssize_t
+static void
 retry_timeout_seconds_show(
 	struct kobject	*kobject,
-	char		*buf)
+	struct seq_file	*sf)
 {
 	int		timeout;
 	struct xfs_error_cfg *cfg = to_error_cfg(kobject);
@@ -466,7 +466,7 @@ retry_timeout_seconds_show(
 	else
 		timeout = jiffies_to_msecs(cfg->retry_timeout) / MSEC_PER_SEC;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", timeout);
+	seq_printf(sf, "%d\n", timeout);
 }
 
 static ssize_t
@@ -497,14 +497,14 @@ retry_timeout_seconds_store(
 }
 XFS_SYSFS_ATTR_RW(retry_timeout_seconds);
 
-static ssize_t
+static void
 fail_at_unmount_show(
 	struct kobject	*kobject,
-	char		*buf)
+	struct seq_file	*sf)
 {
 	struct xfs_mount	*mp = err_to_mp(kobject);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", mp->m_fail_unmount);
+	seq_printf(sf, "%d\n", mp->m_fail_unmount);
 }
 
 static ssize_t
-- 
2.30.2

