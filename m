Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E31B27FF7B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Oct 2020 14:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732109AbgJAMvL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Oct 2020 08:51:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43260 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731952AbgJAMvL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Oct 2020 08:51:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601556669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=KuEPiPqwrU1nozzMuEM2Hx1gat7Ms2KYCBvRSAWzPec=;
        b=UuKBGi9NN+w1OFR/XcBrSIjEaSv7ZCIIH6ZP1nOLxdX1YGnYVm1a+TedRxAHv+QpOW/UBc
        Tzpo+qYI48n/dvCmU2K+0vxSvKWlQoZSDFvLsebwV0ozI86sbg15DHUUoptpDVSoRlQWyS
        elK8SvgXnh7Z9OU8pb+p0XD7JT23iB8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-hIvtJjgfP8CKoMnyjPvxxg-1; Thu, 01 Oct 2020 08:51:07 -0400
X-MC-Unique: hIvtJjgfP8CKoMnyjPvxxg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 792331040C21;
        Thu,  1 Oct 2020 12:51:06 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-115-202.rdu2.redhat.com [10.10.115.202])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0CC1E19C59;
        Thu,  1 Oct 2020 12:51:05 +0000 (UTC)
From:   Qian Cai <cai@redhat.com>
To:     David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] pipe: Fix memory leaks in create_pipe_files()
Date:   Thu,  1 Oct 2020 08:50:55 -0400
Message-Id: <20201001125055.5042-1-cai@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Calling pipe2() with O_NOTIFICATION_PIPE could results in memory leaks
in an error path or CONFIG_WATCH_QUEUE=n. Plug them.

unreferenced object 0xc00000141114a0d8 (size 992):
  comm "trinity-c61", pid 1353192, jiffies 4296255779 (age 25989.560s)
  hex dump (first 32 bytes):
    80 11 00 00 e8 03 00 00 00 00 00 00 00 00 00 00  ................
    ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
  backtrace:
    [<00000000abff13d7>] kmem_cache_alloc+0x1b4/0x470
    [<000000009502e5d5>] alloc_inode+0xd0/0x130
    [<00000000ca1c1a21>] new_inode_pseudo+0x1c/0x80
new_inode_pseudo at fs/inode.c:932
    [<000000000c01d1d6>] create_pipe_files+0x48/0x2d0
get_pipe_inode at fs/pipe.c:874
(inlined by) create_pipe_files at fs/pipe.c:914
    [<00000000d13ff4c4>] __do_pipe_flags+0x50/0x120
__do_pipe_flags at fs/pipe.c:965
    [<0000000003941e42>] do_pipe2+0x3c/0x100
do_pipe2 at fs/pipe.c:1013
    [<00000000a006b818>] sys_pipe2+0x1c/0x30
__se_sys_pipe2 at fs/pipe.c:1028
    [<00000000a6925b55>] system_call_exception+0xf8/0x1d0
    [<000000001c6b0740>] system_call_common+0xe8/0x218
unreferenced object 0xc000001f575ce600 (size 512):
  comm "trinity-c61", pid 1353192, jiffies 4296255779 (age 25989.560s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 ad 4e ad de  .............N..
    ff ff ff ff 00 00 00 00 ff ff ff ff ff ff ff ff  ................
  backtrace:
    [<00000000d74d5e3a>] kmem_cache_alloc_trace+0x1c4/0x2d0
    [<0000000061cbc9cb>] alloc_pipe_info+0x88/0x2c0
kmalloc at include/linux/slab.h:554
(inlined by) kzalloc at include/linux/slab.h:666
(inlined by) alloc_pipe_info at fs/pipe.c:793
    [<00000000efd6129c>] create_pipe_files+0x6c/0x2d0
get_pipe_inode at fs/pipe.c:883
(inlined by) create_pipe_files at fs/pipe.c:914
    [<00000000d13ff4c4>] __do_pipe_flags+0x50/0x120
    [<0000000003941e42>] do_pipe2+0x3c/0x100
    [<00000000a006b818>] sys_pipe2+0x1c/0x30
    [<00000000a6925b55>] system_call_exception+0xf8/0x1d0
    [<000000001c6b0740>] system_call_common+0xe8/0x218
unreferenced object 0xc000000d94f20400 (size 1024):
  comm "trinity-c61", pid 1353192, jiffies 4296255779 (age 25989.560s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000e60ee00f>] __kmalloc+0x1e4/0x330
    [<00000000130e8cc8>] alloc_pipe_info+0x154/0x2c0
kmalloc_array at include/linux/slab.h:594
(inlined by) kcalloc at include/linux/slab.h:605
(inlined by) alloc_pipe_info at fs/pipe.c:810
    [<00000000efd6129c>] create_pipe_files+0x6c/0x2d0
    [<00000000d13ff4c4>] __do_pipe_flags+0x50/0x120
    [<0000000003941e42>] do_pipe2+0x3c/0x100
    [<00000000a006b818>] sys_pipe2+0x1c/0x30
    [<00000000a6925b55>] system_call_exception+0xf8/0x1d0
    [<000000001c6b0740>] system_call_common+0xe8/0x218

Fixes: c73be61cede5 ("pipe: Add general notification queue support")
Signed-off-by: Qian Cai <cai@redhat.com>
---
 fs/pipe.c                   | 11 +++++------
 include/linux/watch_queue.h |  6 ++++++
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 60dbee457143..f5d74ba1bf8c 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -913,19 +913,18 @@ int create_pipe_files(struct file **res, int flags)
 {
 	struct inode *inode = get_pipe_inode();
 	struct file *f;
+	int error;
 
 	if (!inode)
 		return -ENFILE;
 
 	if (flags & O_NOTIFICATION_PIPE) {
-#ifdef CONFIG_WATCH_QUEUE
-		if (watch_queue_init(inode->i_pipe) < 0) {
+		error = watch_queue_init(inode->i_pipe);
+		if (error) {
+			free_pipe_info(inode->i_pipe);
 			iput(inode);
-			return -ENOMEM;
+			return error;
 		}
-#else
-		return -ENOPKG;
-#endif
 	}
 
 	f = alloc_file_pseudo(inode, pipe_mnt, "",
diff --git a/include/linux/watch_queue.h b/include/linux/watch_queue.h
index 5e08db2adc31..c994d1b2cdba 100644
--- a/include/linux/watch_queue.h
+++ b/include/linux/watch_queue.h
@@ -122,6 +122,12 @@ static inline void remove_watch_list(struct watch_list *wlist, u64 id)
  */
 #define watch_sizeof(STRUCT) (sizeof(STRUCT) << WATCH_INFO_LENGTH__SHIFT)
 
+#else
+static inline int watch_queue_init(struct pipe_inode_info *pipe)
+{
+	return -ENOPKG;
+}
+
 #endif
 
 #endif /* _LINUX_WATCH_QUEUE_H */

base-commit: 60e720931556fc1034d0981460164dcf02697679
-- 
2.28.0

