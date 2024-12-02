Return-Path: <linux-fsdevel+bounces-36230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4C89DFD87
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 10:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC4A4282C67
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 09:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5EE1FA84A;
	Mon,  2 Dec 2024 09:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="qjrOpDKi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward203a.mail.yandex.net (forward203a.mail.yandex.net [178.154.239.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D801F949
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Dec 2024 09:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733132800; cv=none; b=tgUOR50/vaSxSRwrw0/1GX2vEZ/so7DFZG45wpfG1ZuPiEiNnKHWTn6jQx95zvBKbIGferjX1JRu1jiLFB+lBqwg3Jp1+jEeVFmQxEEXW7dYH3t+goTkPRjXW0M5vyPPURKQLwSZVLpWZ/z1AEaRGF1IWfi6IH2776oJwLdU3fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733132800; c=relaxed/simple;
	bh=vh0ec8OjidZYnLyILeTGDgFfc8qn2Z/5TwVnzPPs0gw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pF1EeEzs/kXi8FcSqjDOGS/oPrE7lkiZZ+4QwaHlt+9wIenvy6LzEsWY/dkKrD7NOovf+2nEebZhdZ+29PnctMs00+DTpDd1bbQZhaWOdXNHmghcqiGIdOl7izy9McxGlYe+SIu6kGoHXnaN+qGIY0XSpXwmGWXXdNaV+G01t3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=qjrOpDKi; arc=none smtp.client-ip=178.154.239.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d103])
	by forward203a.mail.yandex.net (Yandex) with ESMTPS id B7FA064172
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Dec 2024 12:40:23 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:26bf:0:640:efa0:0])
	by forward103a.mail.yandex.net (Yandex) with ESMTPS id 05E6360E4B;
	Mon,  2 Dec 2024 12:40:16 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id Eeajf1qOiiE0-7bIeXwt2;
	Mon, 02 Dec 2024 12:40:15 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1733132415; bh=+3eoasJ2+W8u4jDRwthmE7pkDtyyD8cK4MURm1Ha7p4=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=qjrOpDKipEUoscpB18mBZog7XbHx5ciz20b1uMoJZ17eva85dcR4llP2C3jzbqmqK
	 gXrFjVAh6b/vCTF94V2MrLvPUMjpDF92kgOQLiU+gmJJ+G/PWzl4r2YDTbiIh75Ve0
	 lJAkGjYvKSvuOTTy2zykpeXRXAPUDO5ThXNBhOGg=
Authentication-Results: mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+404b4b745080b6210c6c@syzkaller.appspotmail.com
Subject: [PATCH v2] netfs: fix kernel BUG in iov_iter_revert()
Date: Mon,  2 Dec 2024 12:39:43 +0300
Message-ID: <20241202093943.227786-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot has reported the following splat triggered by fault injection:

kernel BUG at lib/iov_iter.c:624!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 UID: 0 PID: 5767 Comm: repro Not tainted 6.12.0-rc4-syzkaller-00261-g850925a8133c #0
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-3.fc41 04/01/2014
RIP: 0010:iov_iter_revert+0x420/0x590
Code: 42 80 3c 20 00 48 8b 1c 24 74 08 48 89 df e8 17 07 43 fd 4c 89 2b e9 04 01 00 00 45 85 ed 48 8b 3c 24 75 16 e8 41 48 d9 fc 90 <0f> 0b 41 83 fd 05 48 8b 3c 24 0f 84 58 01 00 00 48 89 f8 48 c1 e8
RSP: 0018:ffffc90002f4f740 EFLAGS: 00010293
RAX: ffffffff84bba22f RBX: 000000000001e098 RCX: ffff888026309cc0
RDX: 0000000000000000 RSI: ffffffff8f098180 RDI: ffff888024f92df0
RBP: 0000000000000000 R08: 0000000000000001 R09: ffffffff84bb9f14
R10: 0000000000000004 R11: ffff888026309cc0 R12: dffffc0000000000
R13: 0000000000000000 R14: ffff888024f92de0 R15: fffffffffffe1f68
FS:  00007f2c11757600(0000) GS:ffff888062800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000557cafd1eb48 CR3: 0000000024e1a000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 ? __die_body+0x5f/0xb0
 ? die+0x9e/0xc0
 ? do_trap+0x15a/0x3a0
 ? iov_iter_revert+0x420/0x590
 ? do_error_trap+0x1dc/0x2c0
 ? iov_iter_revert+0x420/0x590
 ? __pfx_do_error_trap+0x10/0x10
 ? handle_invalid_op+0x34/0x40
 ? iov_iter_revert+0x420/0x590
 ? exc_invalid_op+0x38/0x50
 ? asm_exc_invalid_op+0x1a/0x20
 ? iov_iter_revert+0x104/0x590
 ? iov_iter_revert+0x41f/0x590
 ? iov_iter_revert+0x420/0x590
 netfs_reset_iter+0xce/0x130
 netfs_read_subreq_terminated+0x1fe/0xad0
 netfs_read_to_pagecache+0x628/0x900
 netfs_readahead+0x7e9/0x9d0
 ? __pfx_netfs_readahead+0x10/0x10
 ? blk_start_plug+0x70/0x1b0
 read_pages+0x180/0x840
 ? __pfx_read_pages+0x10/0x10
 ? filemap_add_folio+0x26d/0x650
 ? __pfx_filemap_add_folio+0x10/0x10
 ? rcu_read_lock_any_held+0xb7/0x160
 ? __pfx_rcu_read_lock_any_held+0x10/0x10
 ? __pfx_proc_fail_nth_write+0x10/0x10
 page_cache_ra_unbounded+0x774/0x8a0
 force_page_cache_ra+0x280/0x2f0
 generic_fadvise+0x522/0x830
 ? __pfx_generic_fadvise+0x10/0x10
 ? lockdep_hardirqs_on_prepare+0x43d/0x780
 ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
 ? vfs_fadvise+0x99/0xc0
 __x64_sys_readahead+0x1ac/0x230
 do_syscall_64+0xf3/0x230
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2c116736a9
Code: 5c c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 4f 37 0d 00 f7 d8 64 89 01 48
RSP: 002b:00007ffc78181c88 EFLAGS: 00000246 ORIG_RAX: 00000000000000bb
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f2c116736a9
RDX: 000800000000000d RSI: 0000000000000005 RDI: 0000000000000006
RBP: 00000000004029d8 R08: 00007ffc78181658 R09: 00007f0038363735
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffc78181cb0
R13: 00007ffc78181ec8 R14: 0000000000401120 R15: 00007f2c1178ca80
 </TASK>

This happens just because 'netfs_prepare_read_iterator()' may return
-ENOMEM (which is actually triggered by the fault injection) but such
a cases are not consistently handled in 'netfs_read_to_pagecache()'.
So wrap 'netfs_prepare_read_iterator()' to handle all possible
-ENOMEM cases and mark the corresponding subrequest as cancelled.

Reported-by: syzbot+404b4b745080b6210c6c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=404b4b745080b6210c6c
Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Tested-by: syzbot+404b4b745080b6210c6c@syzkaller.appspotmail.com
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: adjusted to match 6.13.0-rc1
---
 fs/netfs/buffered_read.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 7ac34550c403..4404f3c6ec3e 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -95,7 +95,7 @@ static size_t netfs_load_buffer_from_ra(struct netfs_io_request *rreq,
 }
 
 /*
- * netfs_prepare_read_iterator - Prepare the subreq iterator for I/O
+ * __netfs_prepare_read_iterator - Prepare the subreq iterator for I/O
  * @subreq: The subrequest to be set up
  *
  * Prepare the I/O iterator representing the read buffer on a subrequest for
@@ -109,7 +109,7 @@ static size_t netfs_load_buffer_from_ra(struct netfs_io_request *rreq,
  * [!] NOTE: This must be run in the same thread as ->issue_read() was called
  * in as we access the readahead_control struct.
  */
-static ssize_t netfs_prepare_read_iterator(struct netfs_io_subrequest *subreq)
+static ssize_t __netfs_prepare_read_iterator(struct netfs_io_subrequest *subreq)
 {
 	struct netfs_io_request *rreq = subreq->rreq;
 	size_t rsize = subreq->len;
@@ -174,6 +174,21 @@ static ssize_t netfs_prepare_read_iterator(struct netfs_io_subrequest *subreq)
 	return subreq->len;
 }
 
+/* Wrap the above by handling possible -ENOMEM and
+ * marking the corresponding subrequest as cancelled.
+ */
+static inline ssize_t netfs_prepare_read_iterator(struct netfs_io_subrequest *subreq)
+{
+	struct netfs_io_request *rreq = subreq->rreq;
+	ssize_t slice = __netfs_prepare_read_iterator(subreq);
+
+	if (unlikely(slice < 0)) {
+		atomic_dec(&rreq->nr_outstanding);
+		netfs_put_subrequest(subreq, false, netfs_sreq_trace_put_cancel);
+	}
+	return slice;
+}
+
 static enum netfs_io_source netfs_cache_prepare_read(struct netfs_io_request *rreq,
 						     struct netfs_io_subrequest *subreq,
 						     loff_t i_size)
@@ -285,9 +300,7 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq)
 			}
 
 			slice = netfs_prepare_read_iterator(subreq);
-			if (slice < 0) {
-				atomic_dec(&rreq->nr_outstanding);
-				netfs_put_subrequest(subreq, false, netfs_sreq_trace_put_cancel);
+			if (unlikely(slice < 0)) {
 				ret = slice;
 				break;
 			}
@@ -302,6 +315,10 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq)
 			trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
 			netfs_stat(&netfs_n_rh_zero);
 			slice = netfs_prepare_read_iterator(subreq);
+			if (unlikely(slice < 0)) {
+				ret = slice;
+				break;
+			}
 			__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
 			netfs_read_subreq_terminated(subreq, 0, false);
 			goto done;
@@ -310,6 +327,10 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq)
 		if (source == NETFS_READ_FROM_CACHE) {
 			trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
 			slice = netfs_prepare_read_iterator(subreq);
+			if (unlikely(slice < 0)) {
+				ret = slice;
+				break;
+			}
 			netfs_read_cache_to_pagecache(rreq, subreq);
 			goto done;
 		}
-- 
2.47.1


