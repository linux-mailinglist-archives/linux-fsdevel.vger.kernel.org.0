Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2216D1CB7A7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 20:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgEHSvp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 May 2020 14:51:45 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:54374 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbgEHSvp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 May 2020 14:51:45 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jX861-0001Zv-3H; Fri, 08 May 2020 12:51:41 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jX860-00051f-83; Fri, 08 May 2020 12:51:40 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        <linux-fsdevel@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
        <87sgga6ze4.fsf@x220.int.ebiederm.org>
Date:   Fri, 08 May 2020 13:48:13 -0500
In-Reply-To: <87sgga6ze4.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Fri, 08 May 2020 13:43:31 -0500")
Message-ID: <87sgga5klu.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jX860-00051f-83;;;mid=<87sgga5klu.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/r6VtbU/6OvvVnJg0JFfeLOIy36zxgBMI=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,XMNoVowels autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa05 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 420 ms - load_scoreonly_sql: 0.11 (0.0%),
        signal_user_changed: 12 (2.8%), b_tie_ro: 10 (2.4%), parse: 1.27
        (0.3%), extract_message_metadata: 13 (3.0%), get_uri_detail_list: 1.28
        (0.3%), tests_pri_-1000: 15 (3.6%), tests_pri_-950: 1.45 (0.3%),
        tests_pri_-900: 1.12 (0.3%), tests_pri_-90: 57 (13.6%), check_bayes:
        55 (13.2%), b_tokenize: 7 (1.7%), b_tok_get_all: 8 (1.8%),
        b_comp_prob: 2.9 (0.7%), b_tok_touch_all: 33 (8.0%), b_finish: 1.09
        (0.3%), tests_pri_0: 269 (63.9%), check_dkim_signature: 1.11 (0.3%),
        check_dkim_adsp: 3.1 (0.7%), poll_dns_idle: 0.51 (0.1%), tests_pri_10:
        2.1 (0.5%), tests_pri_500: 45 (10.7%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 6/6] exec: Set the point of no return sooner
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Make the code more robust by marking the point of no return sooner.
This ensures that future code changes don't need to worry about how
they return errors if they are past this point.

This results in no actual change in behavior as __do_execve_file does
not force SIGSEGV when there is a pending fatal signal pending past
the point of no return.  Further the only error returns from de_thread
and exec_mmap that can occur result in fatal signals being pending.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 443eb960f9a0..b0620d5ebc66 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1304,6 +1304,11 @@ int begin_new_exec(struct linux_binprm * bprm)
 	struct task_struct *me = current;
 	int retval;
 
+	/*
+	 * Ensure all future errors are fatal.
+	 */
+	bprm->point_of_no_return = true;
+
 	/*
 	 * Make this the only thread in the thread group.
 	 */
@@ -1326,13 +1331,6 @@ int begin_new_exec(struct linux_binprm * bprm)
 	if (retval)
 		goto out;
 
-	/*
-	 * With the new mm installed it is completely impossible to
-	 * fail and return to the original process.  If anything from
-	 * here on returns an error, the check in __do_execve_file()
-	 * will SEGV current.
-	 */
-	bprm->point_of_no_return = true;
 	bprm->mm = NULL;
 
 #ifdef CONFIG_POSIX_TIMERS
-- 
2.20.1

