Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210684E3582
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 01:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234273AbiCVAaL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Mar 2022 20:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234272AbiCVAaG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Mar 2022 20:30:06 -0400
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DF53612DC;
        Mon, 21 Mar 2022 17:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.jp; i=@amazon.co.jp; q=dns/txt;
  s=amazon201209; t=1647908917; x=1679444917;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=agOxzUqDGtqlNdjLm8hNhKlsl9t7+j3Z8uIT1bwF42g=;
  b=pzZ2mISk0Q/TIEOZrxCoSBwiNcGO1r4L61hSSW57qK47RWfwyJ/HBCQ8
   iMgqFsls6ryxRjrDom+UO0Xh5vjgP7dv890/kNlDIie8GZtAGZshK8Dxv
   M57O0/z9F+Xy9SDGihhRBKda0AqIvVaSbX1z5CyS+HLCKkyErOHRVYhwP
   I=;
X-IronPort-AV: E=Sophos;i="5.90,200,1643673600"; 
   d="scan'208";a="183375656"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-9a235a16.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP; 22 Mar 2022 00:28:33 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1d-9a235a16.us-east-1.amazon.com (Postfix) with ESMTPS id 52DCA81537;
        Tue, 22 Mar 2022 00:28:31 +0000 (UTC)
Received: from EX13D04ANC001.ant.amazon.com (10.43.157.89) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Tue, 22 Mar 2022 00:28:30 +0000
Received: from 88665a182662.ant.amazon.com (10.43.160.180) by
 EX13D04ANC001.ant.amazon.com (10.43.157.89) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Tue, 22 Mar 2022 00:28:26 +0000
From:   Kuniyuki Iwashima <kuniyu@amazon.co.jp>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Kuniyuki Iwashima <kuniyu@amazon.co.jp>,
        Kuniyuki Iwashima <kuni1840@gmail.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 1/2] pipe: Make poll_usage boolean and annotate its access.
Date:   Tue, 22 Mar 2022 09:26:52 +0900
Message-ID: <20220322002653.33865-2-kuniyu@amazon.co.jp>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220322002653.33865-1-kuniyu@amazon.co.jp>
References: <20220322002653.33865-1-kuniyu@amazon.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.43.160.180]
X-ClientProxiedBy: EX13D45UWA004.ant.amazon.com (10.43.160.151) To
 EX13D04ANC001.ant.amazon.com (10.43.157.89)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

pipe_poll() runs locklessly and assigns 1 to poll_usage.  Once poll_usage
is set to 1, it never changes in other places.  However, concurrent writes
of a value trigger KCSAN, so let's make KCSAN happy.

BUG: KCSAN: data-race in pipe_poll / pipe_poll

write to 0xffff8880042f6678 of 4 bytes by task 174 on cpu 3:
 pipe_poll (fs/pipe.c:656)
 ep_item_poll.isra.0 (./include/linux/poll.h:88 fs/eventpoll.c:853)
 do_epoll_wait (fs/eventpoll.c:1692 fs/eventpoll.c:1806 fs/eventpoll.c:2234)
 __x64_sys_epoll_wait (fs/eventpoll.c:2246 fs/eventpoll.c:2241 fs/eventpoll.c:2241)
 do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:113)

write to 0xffff8880042f6678 of 4 bytes by task 177 on cpu 1:
 pipe_poll (fs/pipe.c:656)
 ep_item_poll.isra.0 (./include/linux/poll.h:88 fs/eventpoll.c:853)
 do_epoll_wait (fs/eventpoll.c:1692 fs/eventpoll.c:1806 fs/eventpoll.c:2234)
 __x64_sys_epoll_wait (fs/eventpoll.c:2246 fs/eventpoll.c:2241 fs/eventpoll.c:2241)
 do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:113)

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 177 Comm: epoll_race Not tainted 5.17.0-58927-gf443e374ae13 #6
Hardware name: Red Hat KVM, BIOS 1.11.0-2.amzn2 04/01/2014

Fixes: 3b844826b6c6 ("pipe: avoid unnecessary EPOLLET wakeups under normal loads")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.co.jp>
---
CC: Linus Torvalds <torvalds@linux-foundation.org>

Note that the message is false positive for now, so the Fixes tag might not
be necessary.
---
 fs/pipe.c                 | 2 +-
 include/linux/pipe_fs_i.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 9648ac151..e9f8290f8 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -653,7 +653,7 @@ pipe_poll(struct file *filp, poll_table *wait)
 	unsigned int head, tail;
 
 	/* Epoll has some historical nasty semantics, this enables them */
-	pipe->poll_usage = 1;
+	WRITE_ONCE(pipe->poll_usage, true);
 
 	/*
 	 * Reading pipe state only -- no need for acquiring the semaphore.
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index c00c618ef..cb0fd633a 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -71,7 +71,7 @@ struct pipe_inode_info {
 	unsigned int files;
 	unsigned int r_counter;
 	unsigned int w_counter;
-	unsigned int poll_usage;
+	bool poll_usage;
 	struct page *tmp_page;
 	struct fasync_struct *fasync_readers;
 	struct fasync_struct *fasync_writers;
-- 
2.30.2

