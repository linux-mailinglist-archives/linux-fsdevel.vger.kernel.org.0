Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 274D320B1F9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jun 2020 15:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgFZNB6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jun 2020 09:01:58 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:55842 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgFZNB5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jun 2020 09:01:57 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jonzK-0006Ae-3B; Fri, 26 Jun 2020 07:01:50 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jonzI-0003nF-M0; Fri, 26 Jun 2020 07:01:49 -0600
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
Date:   Fri, 26 Jun 2020 07:57:20 -0500
In-Reply-To: <87pn9mgfc2.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Fri, 26 Jun 2020 07:51:41 -0500")
Message-ID: <877dvuf0i7.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jonzI-0003nF-M0;;;mid=<877dvuf0i7.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/X1UDdam5YyzIfpuHDC02AqAm2Ry6xNYc=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMNoVowels,XMSlimDrugH
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.0 XMSlimDrugH Weight loss drug headers
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa06 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 858 ms - load_scoreonly_sql: 0.17 (0.0%),
        signal_user_changed: 12 (1.4%), b_tie_ro: 10 (1.2%), parse: 1.46
        (0.2%), extract_message_metadata: 29 (3.4%), get_uri_detail_list: 1.69
        (0.2%), tests_pri_-1000: 28 (3.2%), tests_pri_-950: 1.75 (0.2%),
        tests_pri_-900: 1.44 (0.2%), tests_pri_-90: 277 (32.3%), check_bayes:
        275 (32.0%), b_tokenize: 14 (1.6%), b_tok_get_all: 8 (0.9%),
        b_comp_prob: 3.1 (0.4%), b_tok_touch_all: 241 (28.1%), b_finish: 1.04
        (0.1%), tests_pri_0: 487 (56.7%), check_dkim_signature: 1.04 (0.1%),
        check_dkim_adsp: 15 (1.7%), poll_dns_idle: 12 (1.4%), tests_pri_10:
        3.2 (0.4%), tests_pri_500: 12 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 09/14] umh: Stop calling do_execve_file
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


With the user mode driver code changed to not set subprocess_info.file
there are no more users of subproces_info.file.  Remove this field
from struct subprocess_info and remove the only user in
call_usermodehelper_exec_async that would call do_execve_file instead
of do_execve if file was set.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/umh.h |  1 -
 kernel/umh.c        | 10 +++-------
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/include/linux/umh.h b/include/linux/umh.h
index 73173c4a07e5..244aff638220 100644
--- a/include/linux/umh.h
+++ b/include/linux/umh.h
@@ -22,7 +22,6 @@ struct subprocess_info {
 	const char *path;
 	char **argv;
 	char **envp;
-	struct file *file;
 	int wait;
 	int retval;
 	int (*init)(struct subprocess_info *info, struct cred *new);
diff --git a/kernel/umh.c b/kernel/umh.c
index 3e4e453d45c8..6ca2096298b9 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -98,13 +98,9 @@ static int call_usermodehelper_exec_async(void *data)
 
 	commit_creds(new);
 
-	if (sub_info->file)
-		retval = do_execve_file(sub_info->file,
-					sub_info->argv, sub_info->envp);
-	else
-		retval = do_execve(getname_kernel(sub_info->path),
-				   (const char __user *const __user *)sub_info->argv,
-				   (const char __user *const __user *)sub_info->envp);
+	retval = do_execve(getname_kernel(sub_info->path),
+			   (const char __user *const __user *)sub_info->argv,
+			   (const char __user *const __user *)sub_info->envp);
 out:
 	sub_info->retval = retval;
 	/*
-- 
2.25.0

