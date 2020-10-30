Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D2729FDCE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 07:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbgJ3G2P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 02:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgJ3G2M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 02:28:12 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99260C0613D2
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2020 23:28:10 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id h64so5313759ybc.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2020 23:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=bWMjUjDke7pBpB9uHk2we86RqTYCbGgwv7HBCqDmkBk=;
        b=BGIzhBaOQzCy918fMVC4TFa10N0YhlADR/ixgTvZJMqd3+rJFhMvD8EirCJS6J3i9R
         AAD479c7ZJCnmD6A8FGxmfrSIMCARnD1WmwAdivVHYl9oWbcmwDX3X9Cwiwr1Mf3cy4F
         +gP+Z3Nn8DClAFt3hRzPQtyGtLNkIfR/iqz/vp1kXBWPGVPBexqPnlYHiFxEAsLXOSaP
         q7UQit63yJDiVv6sKfVUYDmp1gOtetgj1mpeTv0qdVCGrRdT0hl+QF4ekmkFIM6T38hi
         3ukU+5A8Ng7JvYsYIkhow3forXhlR773Mt50lN42juLKtIqY1leNDQrCFQN3/3Fbd9C7
         plKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=bWMjUjDke7pBpB9uHk2we86RqTYCbGgwv7HBCqDmkBk=;
        b=nQ6KHpEGn5nR6x8buSBLrQJUX8THG4JJeqgtlPR440S0iM8PwHI7//dCpZJIvo3nms
         ftstPwlmvG9SB9YzQ8sLnJ01+G5DAcBHBJpmjaNnj1D/ylg7Lj41KY05xEcCSFG3bLJq
         eNeF/rY7oBaL3dV6N624YkhavHC52949gHkmAS16kaOWt/JgnZMYPsVw24/PqPTNWrpa
         h4KrxJzNdoch/1r+Kjzg9GiydHHZaQtLZCUswfoEO1C8De1ezMP1NvwGZabpo8D/v5rY
         9gVy1sBpWlZ1m+wuagciAq5Z5MvVsP1Fz1fUXJ29HGs5Ra0kZ2+3FZxZ/Adrtzx70iGo
         SmAw==
X-Gm-Message-State: AOAM530VI+4qxiLt6zuA5qvbbQ0bjE6DndOVT5HgO3AjS/YzTzwCblji
        vTptU0t4j8SBP1cD6pS7VSRk0isUlvm3qILEr6vkrsQowGf0zhOolq402fNfkXLMvyghG3AqC58
        NFLEPTQqj7DwTIYAo4V6yYSDvqsmJOWypnDjMS3+D2Nj2blPzq+geOepRAKnu5CeTFI88RKzROA
        ==
X-Google-Smtp-Source: ABdhPJyjWoN7g18PEOSVgNYJa5w0pnzBX5Eojzcj2juAqLdSFphueziCdTrqvkmCh247cBGnJLIxsOP+ddDg
Sender: "amistry via sendgmr" <amistry@nandos.syd.corp.google.com>
X-Received: from nandos.syd.corp.google.com ([2401:fa00:9:14:725a:fff:fe46:72ab])
 (user=amistry job=sendgmr) by 2002:a25:740e:: with SMTP id
 p14mr1380333ybc.401.1604039289538; Thu, 29 Oct 2020 23:28:09 -0700 (PDT)
Date:   Fri, 30 Oct 2020 17:27:54 +1100
Message-Id: <20201030172731.1.I7782b0cedb705384a634cfd8898eb7523562da99@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH] proc: Provide details on indirect branch speculation
From:   Anand K Mistry <amistry@google.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     asteinhauser@google.com, joelaf@google.com, tglx@linutronix.de,
        Anand K Mistry <amistry@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@kernel.org>, NeilBrown <neilb@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Similar to speculation store bypass, show information about the indirect
branch speculation mode of a task in /proc/$pid/status.

Signed-off-by: Anand K Mistry <amistry@google.com>
---

 Documentation/filesystems/proc.rst |  2 ++
 fs/proc/array.c                    | 28 ++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 533c79e8d2cd..710dd69614b9 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -210,6 +210,7 @@ read the file /proc/PID/status::
   NoNewPrivs:     0
   Seccomp:        0
   Speculation_Store_Bypass:       thread vulnerable
+  Speculation_Indirect_Branch:    conditional enabled
   voluntary_ctxt_switches:        0
   nonvoluntary_ctxt_switches:     1
 
@@ -292,6 +293,7 @@ It's slow but very precise.
  NoNewPrivs                  no_new_privs, like prctl(PR_GET_NO_NEW_PRIV, ...)
  Seccomp                     seccomp mode, like prctl(PR_GET_SECCOMP, ...)
  Speculation_Store_Bypass    speculative store bypass mitigation status
+ Speculation_Indirect_Branch indirect branch speculation mode
  Cpus_allowed                mask of CPUs on which this process may run
  Cpus_allowed_list           Same as previous, but in "list format"
  Mems_allowed                mask of memory nodes allowed to this process
diff --git a/fs/proc/array.c b/fs/proc/array.c
index 65ec2029fa80..ce4fa948c9dd 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -368,6 +368,34 @@ static inline void task_seccomp(struct seq_file *m, struct task_struct *p)
 		seq_puts(m, "vulnerable");
 		break;
 	}
+
+	seq_puts(m, "\nSpeculation_Indirect_Branch:\t");
+	switch (arch_prctl_spec_ctrl_get(p, PR_SPEC_INDIRECT_BRANCH)) {
+	case -EINVAL:
+		seq_puts(m, "unsupported");
+		break;
+	case PR_SPEC_NOT_AFFECTED:
+		seq_puts(m, "not affected");
+		break;
+	case PR_SPEC_PRCTL | PR_SPEC_FORCE_DISABLE:
+		seq_puts(m, "conditional force disabled");
+		break;
+	case PR_SPEC_PRCTL | PR_SPEC_DISABLE:
+		seq_puts(m, "conditional disabled");
+		break;
+	case PR_SPEC_PRCTL | PR_SPEC_ENABLE:
+		seq_puts(m, "conditional enabled");
+		break;
+	case PR_SPEC_ENABLE:
+		seq_puts(m, "always enabled");
+		break;
+	case PR_SPEC_DISABLE:
+		seq_puts(m, "always disabled");
+		break;
+	default:
+		seq_puts(m, "unknown");
+		break;
+	}
 	seq_putc(m, '\n');
 }
 
-- 
2.29.1.341.ge80a0c044ae-goog

