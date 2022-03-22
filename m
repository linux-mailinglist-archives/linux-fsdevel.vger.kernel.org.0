Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44AD24E358B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 01:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbiCVAaT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Mar 2022 20:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234272AbiCVAaS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Mar 2022 20:30:18 -0400
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB18F361A85;
        Mon, 21 Mar 2022 17:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.jp; i=@amazon.co.jp; q=dns/txt;
  s=amazon201209; t=1647908932; x=1679444932;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z1/Lf01ROKGSKNl7HGZbZ1PwqeyhtCw4pQnh4qOJV1o=;
  b=goHa8vW8O/L5Ngmo0JEZmZkEjF7NNaHxHL+zQGDRcjpg0GURk3EoaWlQ
   BOvLbENejDU+xO8G7q/6BVVybe027bD3jsHKwFL7DvDgHLBKHF7dK8h7x
   97bTnE0pLNttRR0R/xrrffvaTlq/6+Mb23TXgWkBjdbdvGahicXmX2W1/
   s=;
X-IronPort-AV: E=Sophos;i="5.90,200,1643673600"; 
   d="scan'208";a="204241028"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-2d7489a4.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP; 22 Mar 2022 00:28:50 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1a-2d7489a4.us-east-1.amazon.com (Postfix) with ESMTPS id D0E9497D1A;
        Tue, 22 Mar 2022 00:28:47 +0000 (UTC)
Received: from EX13D04ANC001.ant.amazon.com (10.43.157.89) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Tue, 22 Mar 2022 00:28:46 +0000
Received: from 88665a182662.ant.amazon.com (10.43.160.180) by
 EX13D04ANC001.ant.amazon.com (10.43.157.89) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Tue, 22 Mar 2022 00:28:42 +0000
From:   Kuniyuki Iwashima <kuniyu@amazon.co.jp>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Kuniyuki Iwashima <kuniyu@amazon.co.jp>,
        Kuniyuki Iwashima <kuni1840@gmail.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <syzbot+bdd6e38a1ed5ee58d8bd@syzkaller.appspotmail.com>,
        "Soheil Hassas Yeganeh" <soheil@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Sridhar Samudrala" <sridhar.samudrala@intel.com>,
        Alexander Duyck <alexander.h.duyck@intel.com>
Subject: [PATCH 2/2] list: Fix a data-race around ep->rdllist.
Date:   Tue, 22 Mar 2022 09:26:53 +0900
Message-ID: <20220322002653.33865-3-kuniyu@amazon.co.jp>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220322002653.33865-1-kuniyu@amazon.co.jp>
References: <20220322002653.33865-1-kuniyu@amazon.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.43.160.180]
X-ClientProxiedBy: EX13D45UWA004.ant.amazon.com (10.43.160.151) To
 EX13D04ANC001.ant.amazon.com (10.43.157.89)
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ep_poll() first calls ep_events_available() with no lock held and
checks if ep->rdllist is empty by list_empty_careful(), which reads
rdllist->prev.  Thus all accesses to it need some protection to avoid
store/load-tearing.

Note INIT_LIST_HEAD_RCU() already has the annotation for both prev
and next.

Commit bf3b9f6372c4 ("epoll: Add busy poll support to epoll with
socket fds.") added the first lockless ep_events_available(), and
commit c5a282e9635e ("fs/epoll: reduce the scope of wq lock in
epoll_wait()") made some ep_events_available() calls lockless and
added single call under a lock, finally commit e59d3c64cba6 ("epoll:
eliminate unnecessary lock for zero timeout") made the last
ep_events_available() lockless.

BUG: KCSAN: data-race in do_epoll_wait / do_epoll_wait

write to 0xffff88810480c7d8 of 8 bytes by task 1802 on cpu 0:
 INIT_LIST_HEAD include/linux/list.h:38 [inline]
 list_splice_init include/linux/list.h:492 [inline]
 ep_start_scan fs/eventpoll.c:622 [inline]
 ep_send_events fs/eventpoll.c:1656 [inline]
 ep_poll fs/eventpoll.c:1806 [inline]
 do_epoll_wait+0x4eb/0xf40 fs/eventpoll.c:2234
 do_epoll_pwait fs/eventpoll.c:2268 [inline]
 __do_sys_epoll_pwait fs/eventpoll.c:2281 [inline]
 __se_sys_epoll_pwait+0x12b/0x240 fs/eventpoll.c:2275
 __x64_sys_epoll_pwait+0x74/0x80 fs/eventpoll.c:2275
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

read to 0xffff88810480c7d8 of 8 bytes by task 1799 on cpu 1:
 list_empty_careful include/linux/list.h:329 [inline]
 ep_events_available fs/eventpoll.c:381 [inline]
 ep_poll fs/eventpoll.c:1797 [inline]
 do_epoll_wait+0x279/0xf40 fs/eventpoll.c:2234
 do_epoll_pwait fs/eventpoll.c:2268 [inline]
 __do_sys_epoll_pwait fs/eventpoll.c:2281 [inline]
 __se_sys_epoll_pwait+0x12b/0x240 fs/eventpoll.c:2275
 __x64_sys_epoll_pwait+0x74/0x80 fs/eventpoll.c:2275
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

value changed: 0xffff88810480c7d0 -> 0xffff888103c15098

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 1799 Comm: syz-fuzzer Tainted: G        W         5.17.0-rc7-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011

Fixes: e59d3c64cba6 ("epoll: eliminate unnecessary lock for zero timeout")
Fixes: c5a282e9635e ("fs/epoll: reduce the scope of wq lock in epoll_wait()")
Fixes: bf3b9f6372c4 ("epoll: Add busy poll support to epoll with socket fds.")
Reported-by: syzbot+bdd6e38a1ed5ee58d8bd@syzkaller.appspotmail.com
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.co.jp>
---
CC: Soheil Hassas Yeganeh <soheil@google.com>
CC: Davidlohr Bueso <dave@stgolabs.net>
CC: Sridhar Samudrala <sridhar.samudrala@intel.com>
CC: Alexander Duyck <alexander.h.duyck@intel.com>
---
 include/linux/list.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/list.h b/include/linux/list.h
index dd6c2041d..d7d2bfa1a 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -35,7 +35,7 @@
 static inline void INIT_LIST_HEAD(struct list_head *list)
 {
 	WRITE_ONCE(list->next, list);
-	list->prev = list;
+	WRITE_ONCE(list->prev, list);
 }
 
 #ifdef CONFIG_DEBUG_LIST
@@ -306,7 +306,7 @@ static inline int list_empty(const struct list_head *head)
 static inline void list_del_init_careful(struct list_head *entry)
 {
 	__list_del_entry(entry);
-	entry->prev = entry;
+	WRITE_ONCE(entry->prev, entry);
 	smp_store_release(&entry->next, entry);
 }
 
@@ -326,7 +326,7 @@ static inline void list_del_init_careful(struct list_head *entry)
 static inline int list_empty_careful(const struct list_head *head)
 {
 	struct list_head *next = smp_load_acquire(&head->next);
-	return list_is_head(next, head) && (next == head->prev);
+	return list_is_head(next, head) && (next == READ_ONCE(head->prev));
 }
 
 /**
-- 
2.30.2

