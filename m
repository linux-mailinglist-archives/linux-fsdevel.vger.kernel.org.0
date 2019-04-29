Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 233F6DB56
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2019 06:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbfD2Eyx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 00:54:53 -0400
Received: from mga03.intel.com ([134.134.136.65]:28445 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727162AbfD2EyJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 00:54:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Apr 2019 21:54:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,408,1549958400"; 
   d="scan'208";a="146566299"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga003.jf.intel.com with ESMTP; 28 Apr 2019 21:54:08 -0700
From:   ira.weiny@intel.com
To:     lsf-pc@lists.linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Michal Hocko <mhocko@suse.com>, Ira Weiny <ira.weiny@intel.com>
Subject: [RFC PATCH 06/10] fs/locks: Add longterm lease traces
Date:   Sun, 28 Apr 2019 21:53:55 -0700
Message-Id: <20190429045359.8923-7-ira.weiny@intel.com>
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
 fs/locks.c                      |  5 +++++
 include/trace/events/filelock.h | 37 ++++++++++++++++++++++++++++++++-
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/fs/locks.c b/fs/locks.c
index ae508d192223..58c6d7a411b6 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2136,6 +2136,8 @@ static int do_fcntl_add_lease(unsigned int fd, struct file *filp, long arg)
 	}
 	new->fa_fd = fd;
 
+	trace_take_longterm_lease(fl);
+
 	error = vfs_setlease(filp, arg, &fl, (void **)&new);
 	if (fl)
 		locks_free_lock(fl);
@@ -3118,6 +3120,8 @@ bool page_set_longterm_lease(struct page *page)
 		kref_get(&existing_fl->gup_ref);
 	}
 
+	trace_take_longterm_lease(existing_fl);
+
 	spin_unlock(&ctx->flc_lock);
 	percpu_up_read(&file_rwsem);
 
@@ -3153,6 +3157,7 @@ void page_remove_longterm_lease(struct page *page)
 	percpu_down_read(&file_rwsem);
 	spin_lock(&ctx->flc_lock);
 	found = find_longterm_lease(inode);
+	trace_release_longterm_lease(found);
 	if (found)
 		kref_put(&found->gup_ref, release_longterm_lease);
 	spin_unlock(&ctx->flc_lock);
diff --git a/include/trace/events/filelock.h b/include/trace/events/filelock.h
index 4b735923f2ff..c6f39f03cb8b 100644
--- a/include/trace/events/filelock.h
+++ b/include/trace/events/filelock.h
@@ -27,7 +27,8 @@
 		{ FL_SLEEP,		"FL_SLEEP" },			\
 		{ FL_DOWNGRADE_PENDING,	"FL_DOWNGRADE_PENDING" },	\
 		{ FL_UNLOCK_PENDING,	"FL_UNLOCK_PENDING" },		\
-		{ FL_OFDLCK,		"FL_OFDLCK" })
+		{ FL_OFDLCK,		"FL_OFDLCK" },			\
+		{ FL_LONGTERM,		"FL_LONGTERM" })
 
 #define show_fl_type(val)				\
 	__print_symbolic(val,				\
@@ -238,6 +239,40 @@ TRACE_EVENT(leases_conflict,
 		show_fl_type(__entry->b_fl_type))
 );
 
+DECLARE_EVENT_CLASS(longterm_lease,
+	TP_PROTO(struct file_lock *fl),
+
+	TP_ARGS(fl),
+
+	TP_STRUCT__entry(
+		__field(void *, fl)
+		__field(void *, owner)
+		__field(unsigned int, fl_flags)
+		__field(unsigned int, cnt)
+		__field(unsigned char, fl_type)
+	),
+
+	TP_fast_assign(
+		__entry->fl = fl;
+		__entry->owner = fl ? fl->fl_owner : NULL;
+		__entry->fl_flags = fl ? fl->fl_flags : 0;
+		__entry->cnt = fl ? kref_read(&fl->gup_ref) : 0;
+		__entry->fl_type = fl ? fl->fl_type : 0;
+	),
+
+	TP_printk("owner=0x%p fl=%p(%d) fl_flags=%s fl_type=%s",
+		__entry->owner, __entry->fl, __entry->cnt,
+		show_fl_flags(__entry->fl_flags),
+		show_fl_type(__entry->fl_type))
+);
+DEFINE_EVENT(longterm_lease, take_longterm_lease,
+	TP_PROTO(struct file_lock *fl),
+	TP_ARGS(fl));
+DEFINE_EVENT(longterm_lease, release_longterm_lease,
+	TP_PROTO(struct file_lock *fl),
+	TP_ARGS(fl));
+
+
 #endif /* _TRACE_FILELOCK_H */
 
 /* This part must be outside protection */
-- 
2.20.1

