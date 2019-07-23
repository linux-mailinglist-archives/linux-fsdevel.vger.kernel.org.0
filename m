Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E66B8718A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2019 14:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730526AbfGWMth (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jul 2019 08:49:37 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:46850 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726186AbfGWMth (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jul 2019 08:49:37 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 1C2922E14BD;
        Tue, 23 Jul 2019 15:49:33 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:10])
        by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id fmQPnrek3M-nWNePTP1;
        Tue, 23 Jul 2019 15:49:33 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1563886173; bh=zurua77u+0xi6TbhWif5eKYYbACOpA6ckuYdIyXtbcw=;
        h=Message-ID:Date:To:From:Subject;
        b=SxAiEfbMTe6g9rgjKAYpYyEw55A0/Cpf/8g/VkVC2mITNAE9pvdqSLU2VYWVp8Lkl
         0Pbz4BSHklhJhaDSvJbL/2kwJxymf9bSMWsd/Qj9XGAs1qI+mLpTe+FsKgU2gWpDM7
         PWIgws5dlKgyWtMCh/8WPswvwbcAOiLtGgIAc8wg=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:38b3:1cdf:ad1a:1fe1])
        by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id TrvRdaTa6V-nW6KTqe5;
        Tue, 23 Jul 2019 15:49:32 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH] mm/backing-dev: show state of all bdi_writeback in debugfs
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Tue, 23 Jul 2019 15:49:32 +0300
Message-ID: <156388617236.3608.2194886130557491278.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently /sys/kernel/debug/bdi/$maj:$min/stats shows only root bdi wb.
With CONFIG_CGROUP_WRITEBACK=y there is one for each memory cgroup.

This patch shows here state of each bdi_writeback in form:

<global state>

Id: 1
Cgroup: /
<root wb state>

Id: xxx
Cgroup: /path
<cgroup wb state>

Id: yyy
Cgroup: /path2
<cgroup wb state>

...

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 mm/backing-dev.c |  106 +++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 93 insertions(+), 13 deletions(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index e8e89158adec..3e752c4bafaf 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -45,7 +45,7 @@ static void bdi_debug_init(void)
 static int bdi_debug_stats_show(struct seq_file *m, void *v)
 {
 	struct backing_dev_info *bdi = m->private;
-	struct bdi_writeback *wb = &bdi->wb;
+	struct bdi_writeback *wb = v;
 	unsigned long background_thresh;
 	unsigned long dirty_thresh;
 	unsigned long wb_thresh;
@@ -65,43 +65,123 @@ static int bdi_debug_stats_show(struct seq_file *m, void *v)
 			nr_dirty_time++;
 	spin_unlock(&wb->list_lock);
 
-	global_dirty_limits(&background_thresh, &dirty_thresh);
-	wb_thresh = wb_calc_thresh(wb, dirty_thresh);
-
 #define K(x) ((x) << (PAGE_SHIFT - 10))
+
+	/* global state */
+	if (wb == &bdi->wb) {
+		global_dirty_limits(&background_thresh, &dirty_thresh);
+		wb_thresh = wb_calc_thresh(wb, dirty_thresh);
+		seq_printf(m,
+			   "BdiDirtyThresh:     %10lu kB\n"
+			   "DirtyThresh:        %10lu kB\n"
+			   "BackgroundThresh:   %10lu kB\n"
+			   "bdi_list:           %10u\n",
+			   K(wb_thresh),
+			   K(dirty_thresh),
+			   K(background_thresh),
+			   !list_empty(&bdi->bdi_list));
+	}
+
+	/* cgroup header */
+#ifdef CONFIG_CGROUP_WRITEBACK
+	if (bdi->capabilities & BDI_CAP_CGROUP_WRITEBACK) {
+		size_t buflen, len;
+		char *buf;
+
+		seq_printf(m, "\nId: %d\nCgroup: ", wb->memcg_css->id);
+		buflen = seq_get_buf(m, &buf);
+		if (buf) {
+			len = cgroup_path(wb->memcg_css->cgroup, buf, buflen);
+			seq_commit(m, len <= buflen ? len : -1);
+			seq_putc(m, '\n');
+		}
+	}
+#endif /* CONFIG_CGROUP_WRITEBACK */
+
 	seq_printf(m,
 		   "BdiWriteback:       %10lu kB\n"
 		   "BdiReclaimable:     %10lu kB\n"
-		   "BdiDirtyThresh:     %10lu kB\n"
-		   "DirtyThresh:        %10lu kB\n"
-		   "BackgroundThresh:   %10lu kB\n"
 		   "BdiDirtied:         %10lu kB\n"
 		   "BdiWritten:         %10lu kB\n"
 		   "BdiWriteBandwidth:  %10lu kBps\n"
+		   "BdiAvgWriteBwidth:  %10lu kBps\n"
 		   "b_dirty:            %10lu\n"
 		   "b_io:               %10lu\n"
 		   "b_more_io:          %10lu\n"
 		   "b_dirty_time:       %10lu\n"
-		   "bdi_list:           %10u\n"
 		   "state:              %10lx\n",
 		   (unsigned long) K(wb_stat(wb, WB_WRITEBACK)),
 		   (unsigned long) K(wb_stat(wb, WB_RECLAIMABLE)),
-		   K(wb_thresh),
-		   K(dirty_thresh),
-		   K(background_thresh),
 		   (unsigned long) K(wb_stat(wb, WB_DIRTIED)),
 		   (unsigned long) K(wb_stat(wb, WB_WRITTEN)),
 		   (unsigned long) K(wb->write_bandwidth),
+		   (unsigned long) K(wb->avg_write_bandwidth),
 		   nr_dirty,
 		   nr_io,
 		   nr_more_io,
 		   nr_dirty_time,
-		   !list_empty(&bdi->bdi_list), bdi->wb.state);
+		   wb->state);
 #undef K
 
 	return 0;
 }
-DEFINE_SHOW_ATTRIBUTE(bdi_debug_stats);
+
+static void *bdi_debug_stats_start(struct seq_file *m, loff_t *ppos)
+{
+	struct backing_dev_info *bdi = m->private;
+	struct bdi_writeback *wb;
+	loff_t pos = *ppos;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(wb, &bdi->wb_list, bdi_node)
+		if (pos-- == 0)
+			return wb;
+	return NULL;
+}
+
+static void *bdi_debug_stats_next(struct seq_file *m, void *v, loff_t *ppos)
+{
+	struct backing_dev_info *bdi = m->private;
+	struct bdi_writeback *wb = v;
+
+	list_for_each_entry_continue_rcu(wb, &bdi->wb_list, bdi_node) {
+		++*ppos;
+		return wb;
+	}
+	return NULL;
+}
+
+static void bdi_debug_stats_stop(struct seq_file *m, void *v)
+{
+	rcu_read_unlock();
+}
+
+static const struct seq_operations bdi_debug_stats_seq_ops = {
+	.start	= bdi_debug_stats_start,
+	.next	= bdi_debug_stats_next,
+	.stop	= bdi_debug_stats_stop,
+	.show	= bdi_debug_stats_show,
+};
+
+static int bdi_debug_stats_open(struct inode *inode, struct file *file)
+{
+	struct seq_file *m;
+	int ret;
+
+	ret = seq_open(file, &bdi_debug_stats_seq_ops);
+	if (!ret) {
+		m = file->private_data;
+		m->private = inode->i_private;
+	}
+	return ret;
+}
+
+static const struct file_operations bdi_debug_stats_fops = {
+	.open		= bdi_debug_stats_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
 
 static void bdi_debug_register(struct backing_dev_info *bdi, const char *name)
 {

