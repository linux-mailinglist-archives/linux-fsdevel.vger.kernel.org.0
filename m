Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D913D50EC5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 16:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbfFXOmS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 10:42:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:50442 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729030AbfFXOmF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 10:42:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E2F7CAF7C;
        Mon, 24 Jun 2019 14:42:03 +0000 (UTC)
From:   Roman Penyaev <rpenyaev@suse.de>
Cc:     Roman Penyaev <rpenyaev@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 12/14] epoll: support mapping for epfd when polled from userspace
Date:   Mon, 24 Jun 2019 16:41:49 +0200
Message-Id: <20190624144151.22688-13-rpenyaev@suse.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190624144151.22688-1-rpenyaev@suse.de>
References: <20190624144151.22688-1-rpenyaev@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

User has to mmap user_header and user_index vmalloce'd pointers in order
to consume events from userspace.  Also we do not let any copies of vma
on fork().

Signed-off-by: Roman Penyaev <rpenyaev@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 fs/eventpoll.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 1d4a76ff5dff..34239564bdfb 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1447,11 +1447,47 @@ static void ep_show_fdinfo(struct seq_file *m, struct file *f)
 }
 #endif
 
+static int ep_eventpoll_mmap(struct file *filep, struct vm_area_struct *vma)
+{
+	struct eventpoll *ep = vma->vm_file->private_data;
+	size_t size;
+	int rc;
+
+	if (!ep_polled_by_user(ep))
+		return -EOPNOTSUPP;
+
+	size = vma->vm_end - vma->vm_start;
+	if (!vma->vm_pgoff && size > ep->header_length)
+		return -ENXIO;
+	if (vma->vm_pgoff && ep->header_length != (vma->vm_pgoff << PAGE_SHIFT))
+		/* Index ring starts exactly after the header */
+		return -ENXIO;
+	if (vma->vm_pgoff && size > ep->index_length)
+		return -ENXIO;
+
+	/*
+	 * vm_pgoff is used *only* for indication, what is mapped: user header
+	 * or user index ring.  Sizes are checked above.
+	 */
+	if (!vma->vm_pgoff)
+		rc = remap_vmalloc_range_partial(vma, vma->vm_start,
+						 ep->user_header, size);
+	else
+		rc = remap_vmalloc_range_partial(vma, vma->vm_start,
+						 ep->user_index, size);
+	if (likely(!rc))
+		/* No copies for forks(), please */
+		vma->vm_flags |= VM_DONTCOPY;
+
+	return rc;
+}
+
 /* File callbacks that implement the eventpoll file behaviour */
 static const struct file_operations eventpoll_fops = {
 #ifdef CONFIG_PROC_FS
 	.show_fdinfo	= ep_show_fdinfo,
 #endif
+	.mmap		= ep_eventpoll_mmap,
 	.release	= ep_eventpoll_release,
 	.poll		= ep_eventpoll_poll,
 	.llseek		= noop_llseek,
-- 
2.21.0

