Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12A8E3AD332
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jun 2021 21:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbhFRT5l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Jun 2021 15:57:41 -0400
Received: from mxout04.lancloud.ru ([45.84.86.114]:34662 "EHLO
        mxout04.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbhFRT5j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Jun 2021 15:57:39 -0400
X-Greylist: delayed 586 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Jun 2021 15:57:39 EDT
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 8F48220A02FF
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH] fuse: fix unfreezable tasks
To:     Miklos Szeredi <miklos@szeredi.hu>, <linux-fsdevel@vger.kernel.org>
CC:     Ildar Kamaletdinov <i.kamaletdinov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <fc097829-b4f1-5d8d-fd71-d204c79480dc@omp.ru>
Date:   Fri, 18 Jun 2021 22:45:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ildar Kamaletdinov <i.kamaletdinov@omp.ru>

It could be impossible to freeze the fuse task in request_wait_answer()
when it calls wait_event_killable() with the FR_FINISHED flag because
the fuse daemon could be frozen before the task, so it simply can't
finish a request. E.g. it could be impossible to freeze while doing
poll() on a fuse FS:

[   90.468003] (0)[]Freezing of tasks aborted after 6.507 seconds
[   90.468793] (0)[1649:kworker/u8:18]qtaround::mt::A D
[   90.468830]    0  1590   1102 0x00400009
[   90.468850] (0)[1649:kworker/u8:18]Call trace:
[   90.468887] (0)[1649:kworker/u8:18][<ffffff82a7685a44>] __switch_to+0xd8/0xf4
[   90.468929] (0)[1649:kworker/u8:18][<ffffff82a851fa9c>] __schedule+0x75c/0x964
[   90.468964] (0)[1649:kworker/u8:18][<ffffff82a851fd14>] schedule+0x70/0x90
[   90.468995] (0)[1649:kworker/u8:18][<ffffff82a79fec00>] __fuse_request_send+0x228/0x3a4
[   90.469031] (0)[1649:kworker/u8:18][<ffffff82a79feeec>] fuse_simple_request+0x170/0x1c4
[   90.469068] (0)[1649:kworker/u8:18][<ffffff82a7a070e0>] fuse_file_poll+0x164/0x1c8
[   90.469107] (0)[1649:kworker/u8:18][<ffffff82a7851050>] do_sys_poll+0x2f4/0x5a0
[   90.469142] (0)[1649:kworker/u8:18][<ffffff82a78518f4>] do_restart_poll+0x4c/0x90
[   90.469178] (0)[1649:kworker/u8:18][<ffffff82a76bb32c>] sys_restart_syscall+0x18/0x20
[   90.469213] (0)[1649:kworker/u8:18][<ffffff82a76835c0>] el0_svc_naked+0x34/0x38
[   90.469457] (3)[647:dsme-server]Restarting tasks ...

Use freezer_do_not_count() to tell freezer to ignore the task while it
waits for event.

[Sergey: added #include <linux/freezer.h>, cleaned up the patch description]

Link: https://bugzilla.kernel.org/show_bug.cgi?id=198879
Fixes: 7d3a07fcb8a0 (fuse: don't mess with blocking signals)
Signed-off-by: Ildar Kamaletdinov <i.kamaletdinov@omp.ru>
Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
This patch is against the Linus' repo -- I didn't find a tag suitable for
the fixes in Miklos Szeredi's FUSE repo. :-(

 fs/fuse/dev.c |    3 +++
 1 file changed, 3 insertions(+)

Index: linux/fs/fuse/dev.c
===================================================================
--- linux.orig/fs/fuse/dev.c
+++ linux/fs/fuse/dev.c
@@ -8,6 +8,7 @@
 
 #include "fuse_i.h"
 
+#include <linux/freezer.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/poll.h>
@@ -386,9 +387,11 @@ static void request_wait_answer(struct f
 	}
 
 	if (!test_bit(FR_FORCE, &req->flags)) {
+		freezer_do_not_count();
 		/* Only fatal signals may interrupt this */
 		err = wait_event_killable(req->waitq,
 					test_bit(FR_FINISHED, &req->flags));
+		freezer_count();
 		if (!err)
 			return;
 
