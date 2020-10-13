Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8557D28CFCE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Oct 2020 16:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388294AbgJMOGa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Oct 2020 10:06:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33652 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388236AbgJMOG0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Oct 2020 10:06:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602597985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5qT8jquoQOvD8a7SF5l/rxB3mSNwZ5S4wf/Z1Ex1Krk=;
        b=C4g3fhac4/EUbQRJFosbmEcUMu6QtoiCvjATzMu4MtjFkweEvgX8otLmwrsgQt1pVsBbXm
        yekwKhym70O/kfc2BfKHiNXuJeHHlndbEO83GvngH+77eHQaaI446RV6zYJbBId54IQqJJ
        ocakZvhV6JCniMcK8NcGRsXbtfJSnbI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-XJGwe52cPvKPEYN1yPVNBg-1; Tue, 13 Oct 2020 10:06:23 -0400
X-MC-Unique: XJGwe52cPvKPEYN1yPVNBg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0DDD5805722;
        Tue, 13 Oct 2020 14:06:22 +0000 (UTC)
Received: from lithium.redhat.com (ovpn-112-43.ams2.redhat.com [10.36.112.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 77A015C1C2;
        Tue, 13 Oct 2020 14:06:20 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        christian.brauner@ubuntu.com, containers@lists.linux-foundation.org
Subject: [PATCH 1/2] fs, close_range: add flag CLOSE_RANGE_CLOEXEC
Date:   Tue, 13 Oct 2020 16:06:08 +0200
Message-Id: <20201013140609.2269319-2-gscrivan@redhat.com>
In-Reply-To: <20201013140609.2269319-1-gscrivan@redhat.com>
References: <20201013140609.2269319-1-gscrivan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When the flag CLOSE_RANGE_CLOEXEC is set, close_range doesn't
immediately close the files but it sets the close-on-exec bit.

Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
---
 fs/file.c                        | 56 ++++++++++++++++++++++----------
 include/uapi/linux/close_range.h |  3 ++
 2 files changed, 42 insertions(+), 17 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 21c0893f2f1d..ad4ebee41e09 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -672,6 +672,17 @@ int __close_fd(struct files_struct *files, unsigned fd)
 }
 EXPORT_SYMBOL(__close_fd); /* for ksys_close() */
 
+static unsigned int __get_max_fds(struct files_struct *cur_fds)
+{
+	unsigned int max_fds;
+
+	rcu_read_lock();
+	/* cap to last valid index into fdtable */
+	max_fds = files_fdtable(cur_fds)->max_fds;
+	rcu_read_unlock();
+	return max_fds;
+}
+
 /**
  * __close_range() - Close all file descriptors in a given range.
  *
@@ -683,27 +694,23 @@ EXPORT_SYMBOL(__close_fd); /* for ksys_close() */
  */
 int __close_range(unsigned fd, unsigned max_fd, unsigned int flags)
 {
-	unsigned int cur_max;
+	unsigned int cur_max = UINT_MAX;
 	struct task_struct *me = current;
 	struct files_struct *cur_fds = me->files, *fds = NULL;
 
-	if (flags & ~CLOSE_RANGE_UNSHARE)
+	if (flags & ~(CLOSE_RANGE_UNSHARE | CLOSE_RANGE_CLOEXEC))
 		return -EINVAL;
 
 	if (fd > max_fd)
 		return -EINVAL;
 
-	rcu_read_lock();
-	cur_max = files_fdtable(cur_fds)->max_fds;
-	rcu_read_unlock();
-
-	/* cap to last valid index into fdtable */
-	cur_max--;
-
 	if (flags & CLOSE_RANGE_UNSHARE) {
 		int ret;
 		unsigned int max_unshare_fds = NR_OPEN_MAX;
 
+		/* cap to last valid index into fdtable */
+		cur_max = __get_max_fds(cur_fds) - 1;
+
 		/*
 		 * If the requested range is greater than the current maximum,
 		 * we're closing everything so only copy all file descriptors
@@ -724,16 +731,31 @@ int __close_range(unsigned fd, unsigned max_fd, unsigned int flags)
 			swap(cur_fds, fds);
 	}
 
-	max_fd = min(max_fd, cur_max);
-	while (fd <= max_fd) {
-		struct file *file;
+	if (flags & CLOSE_RANGE_CLOEXEC) {
+		struct fdtable *fdt;
 
-		file = pick_file(cur_fds, fd++);
-		if (!file)
-			continue;
+		spin_lock(&cur_fds->file_lock);
+		fdt = files_fdtable(cur_fds);
+		cur_max = fdt->max_fds - 1;
+		max_fd = min(max_fd, cur_max);
+		while (fd <= max_fd)
+			__set_close_on_exec(fd++, fdt);
+		spin_unlock(&cur_fds->file_lock);
+	} else {
+		/* Initialize cur_max if needed.  */
+		if (cur_max == UINT_MAX)
+			cur_max = __get_max_fds(cur_fds) - 1;
+		max_fd = min(max_fd, cur_max);
+		while (fd <= max_fd) {
+			struct file *file;
 
-		filp_close(file, cur_fds);
-		cond_resched();
+			file = pick_file(cur_fds, fd++);
+			if (!file)
+				continue;
+
+			filp_close(file, cur_fds);
+			cond_resched();
+		}
 	}
 
 	if (fds) {
diff --git a/include/uapi/linux/close_range.h b/include/uapi/linux/close_range.h
index 6928a9fdee3c..2d804281554c 100644
--- a/include/uapi/linux/close_range.h
+++ b/include/uapi/linux/close_range.h
@@ -5,5 +5,8 @@
 /* Unshare the file descriptor table before closing file descriptors. */
 #define CLOSE_RANGE_UNSHARE	(1U << 1)
 
+/* Set the FD_CLOEXEC bit instead of closing the file descriptor. */
+#define CLOSE_RANGE_CLOEXEC	(1U << 2)
+
 #endif /* _UAPI_LINUX_CLOSE_RANGE_H */
 
-- 
2.26.2

