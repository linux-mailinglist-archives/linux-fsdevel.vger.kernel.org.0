Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3862C20B1D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jun 2020 14:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgFZM5o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jun 2020 08:57:44 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:53108 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgFZM5n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jun 2020 08:57:43 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jonvK-0005QT-Q7; Fri, 26 Jun 2020 06:57:42 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jonvI-0000uA-N6; Fri, 26 Jun 2020 06:57:42 -0600
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
Date:   Fri, 26 Jun 2020 07:53:13 -0500
In-Reply-To: <87pn9mgfc2.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Fri, 26 Jun 2020 07:51:41 -0500")
Message-ID: <87h7uygf9i.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jonvI-0000uA-N6;;;mid=<87h7uygf9i.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19SUUWxyqnwUtgTAxvRWgD8/3YyIFZ7M1g=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMNoVowels autolearn=disabled
        version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4998]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa01 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 423 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 3.8 (0.9%), b_tie_ro: 2.6 (0.6%), parse: 1.44
        (0.3%), extract_message_metadata: 10 (2.3%), get_uri_detail_list: 1.40
        (0.3%), tests_pri_-1000: 12 (2.8%), tests_pri_-950: 1.05 (0.2%),
        tests_pri_-900: 0.84 (0.2%), tests_pri_-90: 166 (39.2%), check_bayes:
        165 (38.9%), b_tokenize: 6 (1.5%), b_tok_get_all: 7 (1.7%),
        b_comp_prob: 1.45 (0.3%), b_tok_touch_all: 147 (34.7%), b_finish: 0.67
        (0.2%), tests_pri_0: 219 (51.6%), check_dkim_signature: 0.42 (0.1%),
        check_dkim_adsp: 2.3 (0.6%), poll_dns_idle: 0.91 (0.2%), tests_pri_10:
        1.74 (0.4%), tests_pri_500: 5 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 01/14] umh: Capture the pid in umh_pipe_setup
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


The pid in struct subprocess_info is only used by umh_clean_and_save_pid to
write the pid into umh_info.

Instead always capture the pid on struct umh_info in umh_pipe_setup, removing
code that is specific to user mode drivers from the common user path of
user mode helpers.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/umh.h | 1 -
 kernel/umh.c        | 5 ++---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/umh.h b/include/linux/umh.h
index 0c08de356d0d..aae16a0ebd0f 100644
--- a/include/linux/umh.h
+++ b/include/linux/umh.h
@@ -25,7 +25,6 @@ struct subprocess_info {
 	struct file *file;
 	int wait;
 	int retval;
-	pid_t pid;
 	int (*init)(struct subprocess_info *info, struct cred *new);
 	void (*cleanup)(struct subprocess_info *info);
 	void *data;
diff --git a/kernel/umh.c b/kernel/umh.c
index 79f139a7ca03..c2a582b3a2bf 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -102,7 +102,6 @@ static int call_usermodehelper_exec_async(void *data)
 
 	commit_creds(new);
 
-	sub_info->pid = task_pid_nr(current);
 	if (sub_info->file) {
 		retval = do_execve_file(sub_info->file,
 					sub_info->argv, sub_info->envp);
@@ -468,6 +467,7 @@ static int umh_pipe_setup(struct subprocess_info *info, struct cred *new)
 
 	umh_info->pipe_to_umh = to_umh[1];
 	umh_info->pipe_from_umh = from_umh[0];
+	umh_info->pid = task_pid_nr(current);
 	return 0;
 }
 
@@ -476,13 +476,12 @@ static void umh_clean_and_save_pid(struct subprocess_info *info)
 	struct umh_info *umh_info = info->data;
 
 	/* cleanup if umh_pipe_setup() was successful but exec failed */
-	if (info->pid && info->retval) {
+	if (info->retval) {
 		fput(umh_info->pipe_to_umh);
 		fput(umh_info->pipe_from_umh);
 	}
 
 	argv_free(info->argv);
-	umh_info->pid = info->pid;
 }
 
 /**
-- 
2.25.0
