Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8042D1B64A2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 21:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgDWTmV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 15:42:21 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:43650 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbgDWTmV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 15:42:21 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jRhjo-0007Ai-2Q; Thu, 23 Apr 2020 13:42:20 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jRhjm-0003pV-SR; Thu, 23 Apr 2020 13:42:19 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20200419141057.621356-1-gladkov.alexey@gmail.com>
        <87ftcv1nqe.fsf@x220.int.ebiederm.org>
Date:   Thu, 23 Apr 2020 14:39:10 -0500
In-Reply-To: <87ftcv1nqe.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Wed, 22 Apr 2020 11:36:41 -0500")
Message-ID: <87368uxa8x.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jRhjm-0003pV-SR;;;mid=<87368uxa8x.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19AlV3Q6ga6LG7nofoG7B8nBnQL9mK/87k=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4993]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;LKML <linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 402 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (2.9%), b_tie_ro: 10 (2.5%), parse: 1.48
        (0.4%), extract_message_metadata: 17 (4.1%), get_uri_detail_list: 1.73
        (0.4%), tests_pri_-1000: 16 (4.0%), tests_pri_-950: 1.31 (0.3%),
        tests_pri_-900: 1.07 (0.3%), tests_pri_-90: 110 (27.4%), check_bayes:
        109 (27.0%), b_tokenize: 10 (2.6%), b_tok_get_all: 6 (1.6%),
        b_comp_prob: 1.89 (0.5%), b_tok_touch_all: 86 (21.5%), b_finish: 0.94
        (0.2%), tests_pri_0: 230 (57.2%), check_dkim_signature: 0.52 (0.1%),
        check_dkim_adsp: 2.3 (0.6%), poll_dns_idle: 0.74 (0.2%), tests_pri_10:
        2.1 (0.5%), tests_pri_500: 7 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v2 1/2] proc: Use PIDTYPE_TGID in next_tgid
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Combine the pid_task and thes test has_group_leader_pid into a single
dereference by using pid_task(PIDTYPE_TGID).

This makes the code simpler and proof against needing to even think
about any shenanigans that de_thread might get up to.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/proc/base.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 2868bff1a142..a48b4d4056a9 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3360,20 +3360,8 @@ static struct tgid_iter next_tgid(struct pid_namespace *ns, struct tgid_iter ite
 	pid = find_ge_pid(iter.tgid, ns);
 	if (pid) {
 		iter.tgid = pid_nr_ns(pid, ns);
-		iter.task = pid_task(pid, PIDTYPE_PID);
-		/* What we to know is if the pid we have find is the
-		 * pid of a thread_group_leader.  Testing for task
-		 * being a thread_group_leader is the obvious thing
-		 * todo but there is a window when it fails, due to
-		 * the pid transfer logic in de_thread.
-		 *
-		 * So we perform the straight forward test of seeing
-		 * if the pid we have found is the pid of a thread
-		 * group leader, and don't worry if the task we have
-		 * found doesn't happen to be a thread group leader.
-		 * As we don't care in the case of readdir.
-		 */
-		if (!iter.task || !has_group_leader_pid(iter.task)) {
+		iter.task = pid_task(pid, PIDTYPE_TGID);
+		if (!iter.task) {
 			iter.tgid += 1;
 			goto retry;
 		}
-- 
2.20.1

