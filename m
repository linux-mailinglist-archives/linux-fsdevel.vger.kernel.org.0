Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33011CC5AB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2019 00:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731599AbfJDWLS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Oct 2019 18:11:18 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44385 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731595AbfJDWLR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Oct 2019 18:11:17 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id x94M92mN024853
        for <linux-fsdevel@vger.kernel.org>; Fri, 4 Oct 2019 15:11:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=xKwMmV5/lRZ5KOHFX9m6ZN94W9gYSkTsv8TGeCtH98A=;
 b=W/qOGGD7uKt5aA6bFogb3ZYuR04+jvI5XkukXG/hnsmGzKcpgKdOLKxZ1L+U2b1ELNDu
 RqoXJBbfbdBhsTR0ieHdUIdn/K0SHAvJcWBGqpNK2mkeatWf9V97FzE6BuhcW6i0kCnI
 CzdslRNn2Ph4HRUa57nDbADChKbbkg2cRVY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 2ve1ud3d55-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Oct 2019 15:11:14 -0700
Received: from 2401:db00:30:6012:face:0:17:0 (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 4 Oct 2019 15:11:09 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 5E25F1841D558; Fri,  4 Oct 2019 15:11:07 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <tj@kernel.org>, Jan Kara <jack@suse.cz>,
        Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH] cgroup, blkcg: prevent dirty inodes to pin dying memory cgroups
Date:   Fri, 4 Oct 2019 15:11:04 -0700
Message-ID: <20191004221104.646711-1-guro@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-04_13:2019-10-03,2019-10-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 mlxlogscore=761 clxscore=1015 impostorscore=0 suspectscore=2
 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1910040185
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a RFC patch, which is not intended to be merged as is,
but hopefully will start a discussion which can result in a good
solution for the described problem.

--

We've noticed that the number of dying cgroups on our production hosts
tends to grow with the uptime. This time it's caused by the writeback
code.

An inode which is getting dirty for the first time is associated
with the wb structure (look at __inode_attach_wb()). It can later
be switched to another wb under some conditions (e.g. some other
cgroup is writing a lot of data to the same inode), but generally
stays associated up to the end of life of the inode structure.

The problem is that the wb structure holds a reference to the original
memory cgroup. So if the inode was dirty once, it has a good chance
to pin down the original memory cgroup.

An example from the real life: some service runs periodically and
updates rpm packages. Each time in a new memory cgroup. Installed
.so files are heavily used by other cgroups, so corresponding inodes
tend to stay alive for a long. So do pinned memory cgroups.
In production I've seen many hosts with 1-2 thousands of dying
cgroups.

This is not the first problem with the dying memory cgroups. As
always, the problem is with their relative size: memory cgroups
are large objects, easily 100x-1000x larger that inodes. So keeping
a couple of thousands of dying cgroups in memory without a good reason
(what we easily do with inodes) is quite costly (and is measured
in tens and hundreds of Mb).

One possible approach to this problem is to switch inodes associated
with dying wbs to the root wb. Switching is a best effort operation
which can fail silently, so unfortunately we can't run once over a
list of associated inodes (even if we'd have such a list). So we
really have to scan all inodes.

In the proposed patch I schedule a work on each memory cgroup
deletion, which is probably too often. Alternatively, we can do it
periodically under some conditions (e.g. the number of dying memory
cgroups is larger than X). So it's basically a gc run.

I wonder if there are any better ideas?

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 fs/fs-writeback.c | 29 +++++++++++++++++++++++++++++
 mm/memcontrol.c   |  5 +++++
 2 files changed, 34 insertions(+)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 542b02d170f8..4bbc9a200b2c 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -545,6 +545,35 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
 	up_read(&bdi->wb_switch_rwsem);
 }
 
+static void reparent_dirty_inodes_one_sb(struct super_block *sb, void *arg)
+{
+	struct inode *inode, *next;
+
+	spin_lock(&sb->s_inode_list_lock);
+	list_for_each_entry_safe(inode, next, &sb->s_inodes, i_sb_list) {
+		spin_lock(&inode->i_lock);
+		if (inode->i_state & (I_NEW | I_FREEING | I_WILL_FREE)) {
+			spin_unlock(&inode->i_lock);
+			continue;
+		}
+
+		if (inode->i_wb && wb_dying(inode->i_wb)) {
+			spin_unlock(&inode->i_lock);
+			inode_switch_wbs(inode, root_mem_cgroup->css.id);
+			continue;
+		}
+
+		spin_unlock(&inode->i_lock);
+	}
+	spin_unlock(&sb->s_inode_list_lock);
+
+}
+
+void reparent_dirty_inodes(struct work_struct *work)
+{
+	iterate_supers(reparent_dirty_inodes_one_sb, NULL);
+}
+
 /**
  * wbc_attach_and_unlock_inode - associate wbc with target inode and unlock it
  * @wbc: writeback_control of interest
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 9ec5e12486a7..ea8bc8d1403b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4911,6 +4911,9 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 	return 0;
 }
 
+extern void reparent_dirty_inodes(struct work_struct *w);
+static DECLARE_WORK(dirty_work, reparent_dirty_inodes);
+
 static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
@@ -4934,6 +4937,8 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 	memcg_offline_kmem(memcg);
 	wb_memcg_offline(memcg);
 
+	schedule_work(&dirty_work);
+
 	drain_all_stock(memcg);
 
 	mem_cgroup_id_put(memcg);
-- 
2.21.0

