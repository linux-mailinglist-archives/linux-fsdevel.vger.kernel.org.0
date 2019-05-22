Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7220C267E0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2019 18:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730046AbfEVQQd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 May 2019 12:16:33 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37447 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730028AbfEVQQc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 May 2019 12:16:32 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <jlu@pengutronix.de>)
        id 1hTTum-00021Z-0g; Wed, 22 May 2019 18:16:28 +0200
Received: from jlu by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <jlu@pengutronix.de>)
        id 1hTTul-0000As-83; Wed, 22 May 2019 18:16:27 +0200
From:   Jan Luebbe <jlu@pengutronix.de>
To:     Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>
Cc:     kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jan Luebbe <jlu@pengutronix.de>
Subject: [PATCH] proc: report eip and esp for all threads when coredumping
Date:   Wed, 22 May 2019 18:16:14 +0200
Message-Id: <20190522161614.628-1-jlu@pengutronix.de>
X-Mailer: git-send-email 2.11.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: jlu@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit 0a1eb2d474ed ("fs/proc: Stop reporting eip and esp in
/proc/PID/stat") stopped reporting eip/esp and commit fd7d56270b52
("fs/proc: Report eip/esp in /prod/PID/stat for coredumping")
reintroduced the feature to fix a regression with userspace core dump
handlers (such as minicoredumper).

Because PF_DUMPCORE is only set for the primary thread, this didn't fix
the original problem for secondary threads. This commit checks
mm->core_state instead, as already done for /proc/<pid>/status in
task_core_dumping(). As we have a mm_struct available here anyway, this
seems to be a clean solution.

Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
---
 fs/proc/array.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index 2edbb657f859..b76b1e29fc36 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -462,7 +462,7 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 		 * a program is not able to use ptrace(2) in that case. It is
 		 * safe because the task has stopped executing permanently.
 		 */
-		if (permitted && (task->flags & PF_DUMPCORE)) {
+		if (permitted && (!!mm->core_state)) {
 			if (try_get_task_stack(task)) {
 				eip = KSTK_EIP(task);
 				esp = KSTK_ESP(task);
-- 
2.11.0

