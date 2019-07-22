Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3298C6FECA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2019 13:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbfGVLg2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jul 2019 07:36:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:44222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728034AbfGVLg2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jul 2019 07:36:28 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E0C621911;
        Mon, 22 Jul 2019 11:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563795387;
        bh=u2xdH9vPzm3N90GaSs29mBOh59aLxdszGBqjOjoonbQ=;
        h=From:To:Cc:Subject:Date:From;
        b=YjQPJfzFBXPrWC0sYUQDSzYvgp/7Cc1zZ56C+Q+ATN+GOaN0wiD+mtwnZXir6LWhE
         cC5rV+DumN6JV3xJckJBTtiuNnIlP77Q/YD9utQtfO0gYNikeghaqvvfvYhTcEJMVm
         IsvJ+MCMcFWNVw0xmTrRwXzYdhT4mSCsCexDeTC0=
From:   Jeff Layton <jlayton@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     amir73il@gmail.com, viro@zeniv.linux.org.uk, bfields@fieldses.org
Subject: [PATCH] locks: revise generic_add_lease tracepoint
Date:   Mon, 22 Jul 2019 07:36:25 -0400
Message-Id: <20190722113625.27412-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that check_conflicting_open uses inode->i_readcount instead of
the dentry->d_count to detect opens for read, revise the tracepoint
to display that value instead.

Also, fl is never NULL, so no need to check for that in the fast
assign section.

Cc: Amir Goldstein <amir73il@gmail.com>
Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/trace/events/filelock.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/trace/events/filelock.h b/include/trace/events/filelock.h
index 4b735923f2ff..c705e4944a50 100644
--- a/include/trace/events/filelock.h
+++ b/include/trace/events/filelock.h
@@ -176,7 +176,7 @@ TRACE_EVENT(generic_add_lease,
 	TP_STRUCT__entry(
 		__field(unsigned long, i_ino)
 		__field(int, wcount)
-		__field(int, dcount)
+		__field(int, rcount)
 		__field(int, icount)
 		__field(dev_t, s_dev)
 		__field(fl_owner_t, fl_owner)
@@ -188,16 +188,16 @@ TRACE_EVENT(generic_add_lease,
 		__entry->s_dev = inode->i_sb->s_dev;
 		__entry->i_ino = inode->i_ino;
 		__entry->wcount = atomic_read(&inode->i_writecount);
-		__entry->dcount = d_count(fl->fl_file->f_path.dentry);
+		__entry->rcount = atomic_read(&inode->i_readcount);
 		__entry->icount = atomic_read(&inode->i_count);
-		__entry->fl_owner = fl ? fl->fl_owner : NULL;
-		__entry->fl_flags = fl ? fl->fl_flags : 0;
-		__entry->fl_type = fl ? fl->fl_type : 0;
+		__entry->fl_owner = fl->fl_owner;
+		__entry->fl_flags = fl->fl_flags;
+		__entry->fl_type = fl->fl_type;
 	),
 
-	TP_printk("dev=0x%x:0x%x ino=0x%lx wcount=%d dcount=%d icount=%d fl_owner=0x%p fl_flags=%s fl_type=%s",
+	TP_printk("dev=0x%x:0x%x ino=0x%lx wcount=%d rcount=%d icount=%d fl_owner=0x%p fl_flags=%s fl_type=%s",
 		MAJOR(__entry->s_dev), MINOR(__entry->s_dev),
-		__entry->i_ino, __entry->wcount, __entry->dcount,
+		__entry->i_ino, __entry->wcount, __entry->rcount,
 		__entry->icount, __entry->fl_owner,
 		show_fl_flags(__entry->fl_flags),
 		show_fl_type(__entry->fl_type))
-- 
2.21.0

