Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48B1DDB4E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2019 06:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfD2EyG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 00:54:06 -0400
Received: from mga03.intel.com ([134.134.136.65]:28440 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbfD2EyF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 00:54:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Apr 2019 21:54:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,408,1549958400"; 
   d="scan'208";a="146566271"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga003.jf.intel.com with ESMTP; 28 Apr 2019 21:54:04 -0700
From:   ira.weiny@intel.com
To:     lsf-pc@lists.linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Michal Hocko <mhocko@suse.com>, Ira Weiny <ira.weiny@intel.com>
Subject: [RFC PATCH 01/10] fs/locks: Add trace_leases_conflict
Date:   Sun, 28 Apr 2019 21:53:50 -0700
Message-Id: <20190429045359.8923-2-ira.weiny@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190429045359.8923-1-ira.weiny@intel.com>
References: <20190429045359.8923-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 fs/locks.c                      | 20 ++++++++++++++-----
 include/trace/events/filelock.h | 35 +++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index eaa1cfaf73b0..4b66ed91fb53 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1528,11 +1528,21 @@ static void time_out_leases(struct inode *inode, struct list_head *dispose)
 
 static bool leases_conflict(struct file_lock *lease, struct file_lock *breaker)
 {
-	if ((breaker->fl_flags & FL_LAYOUT) != (lease->fl_flags & FL_LAYOUT))
-		return false;
-	if ((breaker->fl_flags & FL_DELEG) && (lease->fl_flags & FL_LEASE))
-		return false;
-	return locks_conflict(breaker, lease);
+	bool rc;
+
+	if ((breaker->fl_flags & FL_LAYOUT) != (lease->fl_flags & FL_LAYOUT)) {
+		rc = false;
+		goto trace;
+	}
+	if ((breaker->fl_flags & FL_DELEG) && (lease->fl_flags & FL_LEASE)) {
+		rc = false;
+		goto trace;
+	}
+
+	rc = locks_conflict(breaker, lease);
+trace:
+	trace_leases_conflict(rc, lease, breaker);
+	return rc;
 }
 
 static bool
diff --git a/include/trace/events/filelock.h b/include/trace/events/filelock.h
index fad7befa612d..4b735923f2ff 100644
--- a/include/trace/events/filelock.h
+++ b/include/trace/events/filelock.h
@@ -203,6 +203,41 @@ TRACE_EVENT(generic_add_lease,
 		show_fl_type(__entry->fl_type))
 );
 
+TRACE_EVENT(leases_conflict,
+	TP_PROTO(bool conflict, struct file_lock *lease, struct file_lock *breaker),
+
+	TP_ARGS(conflict, lease, breaker),
+
+	TP_STRUCT__entry(
+		__field(void *, lease)
+		__field(void *, breaker)
+		__field(unsigned int, l_fl_flags)
+		__field(unsigned int, b_fl_flags)
+		__field(unsigned char, l_fl_type)
+		__field(unsigned char, b_fl_type)
+		__field(bool, conflict)
+	),
+
+	TP_fast_assign(
+		__entry->lease = lease;
+		__entry->l_fl_flags = lease->fl_flags;
+		__entry->l_fl_type = lease->fl_type;
+		__entry->breaker = breaker;
+		__entry->b_fl_flags = breaker->fl_flags;
+		__entry->b_fl_type = breaker->fl_type;
+		__entry->conflict = conflict;
+	),
+
+	TP_printk("conflict %d: lease=0x%p fl_flags=%s fl_type=%s; breaker=0x%p fl_flags=%s fl_type=%s",
+		__entry->conflict,
+		__entry->lease,
+		show_fl_flags(__entry->l_fl_flags),
+		show_fl_type(__entry->l_fl_type),
+		__entry->breaker,
+		show_fl_flags(__entry->b_fl_flags),
+		show_fl_type(__entry->b_fl_type))
+);
+
 #endif /* _TRACE_FILELOCK_H */
 
 /* This part must be outside protection */
-- 
2.20.1

