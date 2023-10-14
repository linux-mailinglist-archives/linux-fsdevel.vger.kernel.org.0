Return-Path: <linux-fsdevel+bounces-358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2FE7C94A6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Oct 2023 14:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16AD72825D7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Oct 2023 12:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9D811CB4;
	Sat, 14 Oct 2023 12:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B665682
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Oct 2023 12:55:20 +0000 (UTC)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F8EB7;
	Sat, 14 Oct 2023 05:55:17 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R671e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0Vu5Ns.c_1697288111;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vu5Ns.c_1697288111)
          by smtp.aliyun-inc.com;
          Sat, 14 Oct 2023 20:55:12 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: tj@kernel.org,
	guro@fb.com,
	jack@suse.cz
Cc: lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	willy@infradead.org,
	joseph.qi@linux.alibaba.com
Subject: [PATCH v3] writeback, cgroup: switch inodes with dirty timestamps to release dying cgwbs
Date: Sat, 14 Oct 2023 20:55:11 +0800
Message-Id: <20231014125511.102978-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The cgwb cleanup routine will try to release the dying cgwb by switching
the attached inodes.  It fetches the attached inodes from wb->b_attached
list, omitting the fact that inodes only with dirty timestamps reside in
wb->b_dirty_time list, which is the case when lazytime is enabled.  This
causes enormous zombie memory cgroup when lazytime is enabled, as inodes
with dirty timestamps can not be switched to a live cgwb for a long time.

It is reasonable not to switch cgwb for inodes with dirty data, as
otherwise it may break the bandwidth restrictions.  However since the
writeback of inode metadata is not accounted for, let's also switch
inodes with dirty timestamps to avoid zombie memory and block cgroups
when laztytime is enabled.

Fixes: c22d70a162d3 ("writeback, cgroup: release dying cgwbs by switching attached inodes")
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
v3: fix spelling of "Fixes"; add "Reviewed-by" tag from Jan Kara
(Thanks!)

v1: https://lore.kernel.org/all/20231011084228.77615-1-jefflexu@linux.alibaba.com/
v2: https://lore.kernel.org/all/20231013055208.15457-1-jefflexu@linux.alibaba.com/
---
 fs/fs-writeback.c | 41 +++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index c1af01b2c42d..1767493dffda 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -613,6 +613,24 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
 	kfree(isw);
 }
 
+static bool isw_prepare_wbs_switch(struct inode_switch_wbs_context *isw,
+				   struct list_head *list, int *nr)
+{
+	struct inode *inode;
+
+	list_for_each_entry(inode, list, i_io_list) {
+		if (!inode_prepare_wbs_switch(inode, isw->new_wb))
+			continue;
+
+		isw->inodes[*nr] = inode;
+		(*nr)++;
+
+		if (*nr >= WB_MAX_INODES_PER_ISW - 1)
+			return true;
+	}
+	return false;
+}
+
 /**
  * cleanup_offline_cgwb - detach associated inodes
  * @wb: target wb
@@ -625,7 +643,6 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
 {
 	struct cgroup_subsys_state *memcg_css;
 	struct inode_switch_wbs_context *isw;
-	struct inode *inode;
 	int nr;
 	bool restart = false;
 
@@ -647,17 +664,17 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
 
 	nr = 0;
 	spin_lock(&wb->list_lock);
-	list_for_each_entry(inode, &wb->b_attached, i_io_list) {
-		if (!inode_prepare_wbs_switch(inode, isw->new_wb))
-			continue;
-
-		isw->inodes[nr++] = inode;
-
-		if (nr >= WB_MAX_INODES_PER_ISW - 1) {
-			restart = true;
-			break;
-		}
-	}
+	/*
+	 * In addition to the inodes that have completed writeback, also switch
+	 * cgwbs for those inodes only with dirty timestamps. Otherwise, those
+	 * inodes won't be written back for a long time when lazytime is
+	 * enabled, and thus pinning the dying cgwbs. It won't break the
+	 * bandwidth restrictions, as writeback of inode metadata is not
+	 * accounted for.
+	 */
+	restart = isw_prepare_wbs_switch(isw, &wb->b_attached, &nr);
+	if (!restart)
+		restart = isw_prepare_wbs_switch(isw, &wb->b_dirty_time, &nr);
 	spin_unlock(&wb->list_lock);
 
 	/* no attached inodes? bail out */
-- 
2.19.1.6.gb485710b


