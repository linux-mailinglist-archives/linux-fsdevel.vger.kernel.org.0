Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E378F212A0A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jul 2020 18:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgGBQrf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jul 2020 12:47:35 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:40458 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgGBQre (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jul 2020 12:47:34 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jr2N3-0001zy-Gv; Thu, 02 Jul 2020 10:47:33 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jr2N2-0007up-1q; Thu, 02 Jul 2020 10:47:33 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <greg@kroah.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Thu,  2 Jul 2020 11:41:26 -0500
Message-Id: <20200702164140.4468-2-ebiederm@xmission.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <87y2o1swee.fsf_-_@x220.int.ebiederm.org>
References: <87y2o1swee.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1jr2N2-0007up-1q;;;mid=<20200702164140.4468-2-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+jPq6B6h2L+fNEpd8hr+00cdsdDq0BKp4=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa04 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 1067 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 10 (1.0%), b_tie_ro: 9 (0.9%), parse: 0.97 (0.1%),
         extract_message_metadata: 14 (1.3%), get_uri_detail_list: 1.65 (0.2%),
         tests_pri_-1000: 24 (2.3%), tests_pri_-950: 1.15 (0.1%),
        tests_pri_-900: 0.97 (0.1%), tests_pri_-90: 250 (23.5%), check_bayes:
        249 (23.3%), b_tokenize: 9 (0.8%), b_tok_get_all: 6 (0.6%),
        b_comp_prob: 2.3 (0.2%), b_tok_touch_all: 228 (21.4%), b_finish: 0.88
        (0.1%), tests_pri_0: 753 (70.5%), check_dkim_signature: 0.58 (0.1%),
        check_dkim_adsp: 3.6 (0.3%), poll_dns_idle: 0.74 (0.1%), tests_pri_10:
        2.1 (0.2%), tests_pri_500: 7 (0.7%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v3 02/16] umh: Move setting PF_UMH into umh_pipe_setup
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I am separating the code specific to user mode drivers from the code
for ordinary user space helpers.  Move setting of PF_UMH from
call_usermodehelper_exec_async which is core user mode helper code
into umh_pipe_setup which is user mode driver code.

The code is equally as easy to write in one location as the other and
the movement minimizes the impact of the user mode driver code on the
core of the user mode helper code.

Setting PF_UMH unconditionally is harmless as an action will only
happen if it is paired with an entry on umh_list.

v1: https://lkml.kernel.org/r/87bll6gf8t.fsf_-_@x220.int.ebiederm.org
v2: https://lkml.kernel.org/r/87zh8l63xs.fsf_-_@x220.int.ebiederm.org
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/umh.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/umh.c b/kernel/umh.c
index c2a582b3a2bf..e6b9d6636850 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -102,12 +102,10 @@ static int call_usermodehelper_exec_async(void *data)
 
 	commit_creds(new);
 
-	if (sub_info->file) {
+	if (sub_info->file)
 		retval = do_execve_file(sub_info->file,
 					sub_info->argv, sub_info->envp);
-		if (!retval)
-			current->flags |= PF_UMH;
-	} else
+	else
 		retval = do_execve(getname_kernel(sub_info->path),
 				   (const char __user *const __user *)sub_info->argv,
 				   (const char __user *const __user *)sub_info->envp);
@@ -468,6 +466,7 @@ static int umh_pipe_setup(struct subprocess_info *info, struct cred *new)
 	umh_info->pipe_to_umh = to_umh[1];
 	umh_info->pipe_from_umh = from_umh[0];
 	umh_info->pid = task_pid_nr(current);
+	current->flags |= PF_UMH;
 	return 0;
 }
 
-- 
2.25.0

