Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6C3212A24
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jul 2020 18:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgGBQsJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jul 2020 12:48:09 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:35030 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbgGBQsD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jul 2020 12:48:03 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jr2NW-0007aH-G7; Thu, 02 Jul 2020 10:48:02 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jr2NV-0007up-Hq; Thu, 02 Jul 2020 10:48:02 -0600
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
Date:   Thu,  2 Jul 2020 11:41:33 -0500
Message-Id: <20200702164140.4468-9-ebiederm@xmission.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <87y2o1swee.fsf_-_@x220.int.ebiederm.org>
References: <87y2o1swee.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1jr2NV-0007up-Hq;;;mid=<20200702164140.4468-9-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+qCe/uJWiysTAvzGD8HMu4YhLe3N90a7c=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMSlimDrugH
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.0 XMSlimDrugH Weight loss drug headers
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa06 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 363 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 11 (3.0%), b_tie_ro: 10 (2.6%), parse: 1.53
        (0.4%), extract_message_metadata: 20 (5.6%), get_uri_detail_list: 2.6
        (0.7%), tests_pri_-1000: 23 (6.4%), tests_pri_-950: 1.34 (0.4%),
        tests_pri_-900: 1.09 (0.3%), tests_pri_-90: 82 (22.4%), check_bayes:
        80 (22.0%), b_tokenize: 9 (2.5%), b_tok_get_all: 7 (2.1%),
        b_comp_prob: 2.3 (0.6%), b_tok_touch_all: 58 (15.9%), b_finish: 0.95
        (0.3%), tests_pri_0: 210 (57.8%), check_dkim_signature: 0.60 (0.2%),
        check_dkim_adsp: 2.1 (0.6%), poll_dns_idle: 0.45 (0.1%), tests_pri_10:
        2.5 (0.7%), tests_pri_500: 7 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v3 09/16] umh: Stop calling do_execve_file
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

v1: https://lkml.kernel.org/r/877dvuf0i7.fsf_-_@x220.int.ebiederm.org
v2: https://lkml.kernel.org/r/87r1tx4p2a.fsf_-_@x220.int.ebiederm.org
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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

