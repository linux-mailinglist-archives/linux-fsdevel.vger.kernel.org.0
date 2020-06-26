Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E62720B1D5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jun 2020 14:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbgFZM6I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jun 2020 08:58:08 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:44602 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgFZM6H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jun 2020 08:58:07 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jonvi-0004XM-O4; Fri, 26 Jun 2020 06:58:06 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jonvh-0000yy-VN; Fri, 26 Jun 2020 06:58:06 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
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
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200625095725.GA3303921@kroah.com>
        <778297d2-512a-8361-cf05-42d9379e6977@i-love.sakura.ne.jp>
        <20200625120725.GA3493334@kroah.com>
        <20200625.123437.2219826613137938086.davem@davemloft.net>
        <CAHk-=whuTwGHEPjvtbBvneHHXeqJC=q5S09mbPnqb=Q+MSPMag@mail.gmail.com>
        <87pn9mgfc2.fsf_-_@x220.int.ebiederm.org>
Date:   Fri, 26 Jun 2020 07:53:38 -0500
In-Reply-To: <87pn9mgfc2.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Fri, 26 Jun 2020 07:51:41 -0500")
Message-ID: <87bll6gf8t.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jonvh-0000yy-VN;;;mid=<87bll6gf8t.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/hYgRW94GEIJHA4ld8uSe8eXZ3hfqsimw=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMNoVowels autolearn=disabled
        version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa03 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 390 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.5 (1.1%), b_tie_ro: 3.0 (0.8%), parse: 1.07
        (0.3%), extract_message_metadata: 10 (2.7%), get_uri_detail_list: 1.39
        (0.4%), tests_pri_-1000: 11 (2.9%), tests_pri_-950: 0.96 (0.2%),
        tests_pri_-900: 0.84 (0.2%), tests_pri_-90: 117 (29.9%), check_bayes:
        115 (29.5%), b_tokenize: 6 (1.6%), b_tok_get_all: 7 (1.8%),
        b_comp_prob: 1.78 (0.5%), b_tok_touch_all: 97 (24.9%), b_finish: 0.78
        (0.2%), tests_pri_0: 232 (59.5%), check_dkim_signature: 0.37 (0.1%),
        check_dkim_adsp: 2.5 (0.6%), poll_dns_idle: 0.94 (0.2%), tests_pri_10:
        2.9 (0.7%), tests_pri_500: 7 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 02/14] umh: Move setting PF_UMH into umh_pipe_setup
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
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

