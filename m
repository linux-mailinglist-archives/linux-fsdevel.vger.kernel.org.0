Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A614E7F95
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Mar 2022 07:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbiCZGiN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Mar 2022 02:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbiCZGiC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Mar 2022 02:38:02 -0400
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24946FEB;
        Fri, 25 Mar 2022 23:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.jp; i=@amazon.co.jp; q=dns/txt;
  s=amazon201209; t=1648276585; x=1679812585;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6PEhA6oGECn3FrZ2m6dP23u1ukbFy/X2U/ncH/ZyHIg=;
  b=k4Rwe03Q7Qi0zQXE8OT8JIxDQd7nnM/Ksvvs/QfgMtFnZ+G/TXrJ5xIS
   /AMU8I75DoTqi6iCDoVpBd1XHH+qsXmofk19yr8nLV4hrAQPdC+l4fm+d
   1a5qCv2YXUbDHfwtGI6ZIgdPYH5ebZWhL/06dYp9XFcJo1JX15+eZoKi1
   s=;
X-IronPort-AV: E=Sophos;i="5.90,211,1643673600"; 
   d="scan'208";a="184695645"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-ca048aa0.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP; 26 Mar 2022 06:36:24 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1d-ca048aa0.us-east-1.amazon.com (Postfix) with ESMTPS id 1A29981466;
        Sat, 26 Mar 2022 06:36:21 +0000 (UTC)
Received: from EX13D04ANC001.ant.amazon.com (10.43.157.89) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Sat, 26 Mar 2022 06:36:20 +0000
Received: from 88665a182662.ant.amazon.com (10.43.162.228) by
 EX13D04ANC001.ant.amazon.com (10.43.157.89) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Sat, 26 Mar 2022 06:36:17 +0000
From:   Kuniyuki Iwashima <kuniyu@amazon.co.jp>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
CC:     Kuniyuki Iwashima <kuniyu@amazon.co.jp>,
        Kuniyuki Iwashima <kuni1840@gmail.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <syzbot+19480160ef25c9ffa29d@syzkaller.appspotmail.com>,
        "Soheil Hassas Yeganeh" <soheil@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Sridhar Samudrala" <sridhar.samudrala@intel.com>,
        Alexander Duyck <alexander.h.duyck@intel.com>
Subject: [PATCH] list: Fix another data-race around ep->rdllist.
Date:   Sat, 26 Mar 2022 15:35:58 +0900
Message-ID: <20220326063558.89906-1-kuniyu@amazon.co.jp>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.43.162.228]
X-ClientProxiedBy: EX13D23UWC003.ant.amazon.com (10.43.162.81) To
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

syzbot had reported another race around ep->rdllist.  ep_poll() calls
list_empty_careful() locklessly to check if the list is empty or not
by testing rdllist->prev == rdllist->next.

When the list does not have any nodes, the next and prev arguments of
__list_add() is the same head pointer.  Thus the write to head->prev
there is racy with lockless list_empty_careful() and needs WRITE_ONCE()
to avoid store-tearing.

Note that the reader side is already fixed in the patch [0].

[0]: https://lore.kernel.org/mm-commits/20220326031647.DD24EC004DD@smtp.kernel.org/

BUG: KCSAN: data-race in do_epoll_ctl / do_epoll_wait

write to 0xffff888103e43058 of 8 bytes by task 1799 on cpu 0:
 __list_add include/linux/list.h:72 [inline]
 list_add_tail include/linux/list.h:102 [inline]
 ep_insert fs/eventpoll.c:1542 [inline]
 do_epoll_ctl+0x1331/0x1880 fs/eventpoll.c:2141
 __do_sys_epoll_ctl fs/eventpoll.c:2192 [inline]
 __se_sys_epoll_ctl fs/eventpoll.c:2183 [inline]
 __x64_sys_epoll_ctl+0xc2/0xf0 fs/eventpoll.c:2183
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

read to 0xffff888103e43058 of 8 bytes by task 1802 on cpu 1:
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

value changed: 0xffff888103e43050 -> 0xffff88812d515498

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 1802 Comm: syz-fuzzer Not tainted 5.17.0-rc8-syzkaller-00003-g56e337f2cf13-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011

Fixes: e59d3c64cba6 ("epoll: eliminate unnecessary lock for zero timeout")
Fixes: c5a282e9635e ("fs/epoll: reduce the scope of wq lock in epoll_wait()")
Fixes: bf3b9f6372c4 ("epoll: Add busy poll support to epoll with socket fds.")
Reported-by: syzbot+19480160ef25c9ffa29d@syzkaller.appspotmail.com
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.co.jp>
---
CC: Soheil Hassas Yeganeh <soheil@google.com>
CC: Davidlohr Bueso <dave@stgolabs.net>
CC: Sridhar Samudrala <sridhar.samudrala@intel.com>
CC: Alexander Duyck <alexander.h.duyck@intel.com>
---
 include/linux/list.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/list.h b/include/linux/list.h
index dd6c2041d..2eaadc84a 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -69,10 +69,10 @@ static inline void __list_add(struct list_head *new,
 	if (!__list_add_valid(new, prev, next))
 		return;
 
-	next->prev = new;
 	new->next = next;
 	new->prev = prev;
 	WRITE_ONCE(prev->next, new);
+	WRITE_ONCE(next->prev, new);
 }
 
 /**
-- 
2.30.2

