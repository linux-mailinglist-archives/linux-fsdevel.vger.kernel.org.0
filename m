Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11F7F2A8A83
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Nov 2020 00:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732250AbgKEXLm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Nov 2020 18:11:42 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:37880 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732046AbgKEXLm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Nov 2020 18:11:42 -0500
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id CA14A402A1;
        Thu,  5 Nov 2020 23:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1604617902; bh=mjfzQlgSUryYIi0w+/VNAw26FTSsKPnANnJpopYIHFM=;
        h=From:To:Cc:Subject:Date:From;
        b=V4cEfPHHohGc3T4AMKXaIT6sexWMwj4S7OJVxAZGNDJeisko3y+HcN6VFfXB3zLaz
         h8F10SDqv6iS4g57H5Ijq4iMEGKFSpC0dbghVQnAgpegJHBN4IEZcJ2QQnsIYXTVqc
         RyPLsSOJxcQ143ISet8YgbdZWDE4pIMTBOau4Emq6+y4kdxQe82JA/cuh1ehI7LKdD
         fUMVTF1Vkwekq+Y/9Z5rL/0KR0iLwHH94Eh6HEHYDjZABpVfArk8tU7CtrTU5ormsn
         qsPdFMgky+RWC7V6yMsk77UNQCTDd3M3LZzwiNnq3WoxslhfLAHJ4ttWaYwDowNpDc
         Flyx0BinY3NmQ==
Received: from vineetg-Latitude-7400.internal.synopsys.com (unknown [10.13.183.89])
        by mailhost.synopsys.com (Postfix) with ESMTP id 5DD60A005E;
        Thu,  5 Nov 2020 23:11:36 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michel Lespinasse <walken@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        John Johansen <john.johansen@canonical.com>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [RFC] proc: get_wchan() stack unwind only makes sense for sleeping/non-self tasks
Date:   Thu,  5 Nov 2020 15:11:32 -0800
Message-Id: <20201105231132.2130132-1-vgupta@synopsys.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Most architectures currently check this in their get_wchan() implementation
(ARC doesn't hence this patch). However doing this in core code shows
the semantics better so move the check one level up (eventually remove
the boiler-plate code from arches)

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>

 #	tools/perf/arch/arc/util/
---
 fs/proc/array.c | 4 +++-
 fs/proc/base.c  | 6 ++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index 65ec2029fa80..081fade5a361 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -519,8 +519,10 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 		unlock_task_sighand(task, &flags);
 	}
 
-	if (permitted && (!whole || num_threads < 2))
+	if (task != current && task->state != TASK_RUNNING &&
+	    permitted && (!whole || num_threads < 2))
 		wchan = get_wchan(task);
+
 	if (!whole) {
 		min_flt = task->min_flt;
 		maj_flt = task->maj_flt;
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 0f707003dda5..abd7ec6324c5 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -385,13 +385,15 @@ static const struct file_operations proc_pid_cmdline_ops = {
 static int proc_pid_wchan(struct seq_file *m, struct pid_namespace *ns,
 			  struct pid *pid, struct task_struct *task)
 {
-	unsigned long wchan;
+	unsigned long wchan = 0;
 	char symname[KSYM_NAME_LEN];
 
 	if (!ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS))
 		goto print0;
 
-	wchan = get_wchan(task);
+	if (task != current && task->state != TASK_RUNNING)
+		wchan = get_wchan(task);
+
 	if (wchan && !lookup_symbol_name(wchan, symname)) {
 		seq_puts(m, symname);
 		return 0;
-- 
2.25.1

