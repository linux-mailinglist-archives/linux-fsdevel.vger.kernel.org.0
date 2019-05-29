Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0E72D84C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 10:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbfE2Iz5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 04:55:57 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:52978 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfE2Iz5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 04:55:57 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1hVuNH-0004Bz-1T; Wed, 29 May 2019 10:55:55 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Jan Luebbe <jlu@pengutronix.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andy Lutomirski <luto@kernel.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCHv2] fs/proc: allow reporting eip/esp for all coredumping threads
References: <20190522161614.628-1-jlu@pengutronix.de>
        <875zpzif8v.fsf@linutronix.de>
        <20190525143220.e771b7915d17f22dad1438fa@linux-foundation.org>
        <87d0k5f1g7.fsf@linutronix.de>
Date:   Wed, 29 May 2019 10:55:53 +0200
Message-ID: <87y32p7i7a.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
the original problem for secondary threads. Allow reporting the eip/esp
for all threads by checking for PF_EXITING as well. This is set for all
the other threads when they are killed. coredump_wait() waits for all
the tasks to become inactive before proceeding to invoke the core the
core dumper.

Reported-by: Jan Luebbe <jlu@pengutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 This is a rework of Jan's v1 patch that allows accessing eip/esp of all
 the threads without risk of the task still executing on a CPU.

 fs/proc/array.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index 2edbb657f859..55180501b915 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -462,7 +462,7 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 		 * a program is not able to use ptrace(2) in that case. It is
 		 * safe because the task has stopped executing permanently.
 		 */
-		if (permitted && (task->flags & PF_DUMPCORE)) {
+		if (permitted && (task->flags & (PF_EXITING|PF_DUMPCORE))) {
 			if (try_get_task_stack(task)) {
 				eip = KSTK_EIP(task);
 				esp = KSTK_ESP(task);
-- 
2.11.0
