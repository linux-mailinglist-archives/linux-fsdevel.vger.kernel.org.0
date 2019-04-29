Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41CF4DB4A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2019 06:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfD2Ey3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 00:54:29 -0400
Received: from mga03.intel.com ([134.134.136.65]:28446 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727243AbfD2EyK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 00:54:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Apr 2019 21:54:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,408,1549958400"; 
   d="scan'208";a="146566315"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga003.jf.intel.com with ESMTP; 28 Apr 2019 21:54:09 -0700
From:   ira.weiny@intel.com
To:     lsf-pc@lists.linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Michal Hocko <mhocko@suse.com>, Ira Weiny <ira.weiny@intel.com>
Subject: [RFC PATCH 09/10] fs/locks: Add tracepoint for SIGBUS on LONGTERM expiration
Date:   Sun, 28 Apr 2019 21:53:58 -0700
Message-Id: <20190429045359.8923-10-ira.weiny@intel.com>
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

---
 fs/locks.c                      | 1 +
 include/trace/events/filelock.h | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/locks.c b/fs/locks.c
index c77eee081d11..42b96bfc71fa 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1592,6 +1592,7 @@ static void time_out_leases(struct inode *inode, struct list_head *dispose)
 			if (fl->fl_flags & FL_LONGTERM) {
 				tsk = find_task_by_vpid(fl->fl_pid);
 				fl->fl_break_time = 1 + jiffies + lease_break_time * HZ;
+				trace_longterm_sigbus(fl);
 				lease_modify_longterm(fl, F_UNLCK, dispose);
 				kill_pid(tsk->thread_pid, SIGBUS, 0);
 			} else {
diff --git a/include/trace/events/filelock.h b/include/trace/events/filelock.h
index c6f39f03cb8b..626386dbe599 100644
--- a/include/trace/events/filelock.h
+++ b/include/trace/events/filelock.h
@@ -271,7 +271,9 @@ DEFINE_EVENT(longterm_lease, take_longterm_lease,
 DEFINE_EVENT(longterm_lease, release_longterm_lease,
 	TP_PROTO(struct file_lock *fl),
 	TP_ARGS(fl));
-
+DEFINE_EVENT(longterm_lease, longterm_sigbus,
+	TP_PROTO(struct file_lock *fl),
+	TP_ARGS(fl));
 
 #endif /* _TRACE_FILELOCK_H */
 
-- 
2.20.1

