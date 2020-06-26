Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C605020B1ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jun 2020 15:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbgFZNAm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jun 2020 09:00:42 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:38852 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgFZNAl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jun 2020 09:00:41 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jonyC-0001IF-Nk; Fri, 26 Jun 2020 07:00:40 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jonyB-0001W3-Q9; Fri, 26 Jun 2020 07:00:40 -0600
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
Date:   Fri, 26 Jun 2020 07:56:12 -0500
In-Reply-To: <87pn9mgfc2.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Fri, 26 Jun 2020 07:51:41 -0500")
Message-ID: <87imfef0k3.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jonyB-0001W3-Q9;;;mid=<87imfef0k3.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19PD/b9G3X6U/WuKoa1veDysmfv/xnL42o=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,T_TooManySym_02,XMNoVowels,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: ; sa04 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 460 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 12 (2.6%), b_tie_ro: 11 (2.3%), parse: 0.82
        (0.2%), extract_message_metadata: 10 (2.2%), get_uri_detail_list: 1.59
        (0.3%), tests_pri_-1000: 14 (3.1%), tests_pri_-950: 1.15 (0.3%),
        tests_pri_-900: 0.88 (0.2%), tests_pri_-90: 151 (32.9%), check_bayes:
        150 (32.6%), b_tokenize: 9 (2.0%), b_tok_get_all: 8 (1.7%),
        b_comp_prob: 2.3 (0.5%), b_tok_touch_all: 127 (27.5%), b_finish: 0.91
        (0.2%), tests_pri_0: 259 (56.3%), check_dkim_signature: 0.51 (0.1%),
        check_dkim_adsp: 2.1 (0.5%), poll_dns_idle: 0.59 (0.1%), tests_pri_10:
        1.99 (0.4%), tests_pri_500: 6 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 07/14] umd: Rename umd_info.cmdline umd_info.driver_name
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


The only thing supplied in the cmdline today is the driver name so
rename the field to clarify the code.

As this value is always supplied stop trying to handle the case of
a NULL cmdline.

Additionally since we now have a name we can count on use the
driver_name any place where the code is looking for a name
of the binary.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/umd.h         |  2 +-
 kernel/umd.c                | 11 ++++-------
 net/ipv4/bpfilter/sockopt.c |  2 +-
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/include/linux/umd.h b/include/linux/umd.h
index 4f61849e2031..6c3e00e0520b 100644
--- a/include/linux/umd.h
+++ b/include/linux/umd.h
@@ -4,7 +4,7 @@
 #include <linux/umh.h>
 
 struct umd_info {
-	const char *cmdline;
+	const char *driver_name;
 	struct file *pipe_to_umh;
 	struct file *pipe_from_umh;
 	struct list_head list;
diff --git a/kernel/umd.c b/kernel/umd.c
index aa1215faa8a1..bad2e8da7f96 100644
--- a/kernel/umd.c
+++ b/kernel/umd.c
@@ -67,9 +67,6 @@ static void umd_cleanup(struct subprocess_info *info)
  * @len: length of the blob
  * @info: information about usermode process (shouldn't be NULL)
  *
- * If info->cmdline is set it will be used as command line for the
- * user process, else "usermodehelper" is used.
- *
  * Returns either negative error or zero which indicates success
  * in executing a blob of bytes as a usermode process. In such
  * case 'struct umd_info *info' is populated with two pipes
@@ -79,7 +76,6 @@ static void umd_cleanup(struct subprocess_info *info)
  */
 int fork_usermode_blob(void *data, size_t len, struct umd_info *info)
 {
-	const char *cmdline = (info->cmdline) ? info->cmdline : "usermodehelper";
 	struct subprocess_info *sub_info;
 	char **argv = NULL;
 	struct file *file;
@@ -87,7 +83,7 @@ int fork_usermode_blob(void *data, size_t len, struct umd_info *info)
 	loff_t pos = 0;
 	int err;
 
-	file = shmem_kernel_file_setup("", len, 0);
+	file = shmem_kernel_file_setup(info->driver_name, len, 0);
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 
@@ -100,11 +96,12 @@ int fork_usermode_blob(void *data, size_t len, struct umd_info *info)
 	}
 
 	err = -ENOMEM;
-	argv = argv_split(GFP_KERNEL, cmdline, NULL);
+	argv = argv_split(GFP_KERNEL, info->driver_name, NULL);
 	if (!argv)
 		goto out;
 
-	sub_info = call_usermodehelper_setup("none", argv, NULL, GFP_KERNEL,
+	sub_info = call_usermodehelper_setup(info->driver_name, argv, NULL,
+					     GFP_KERNEL,
 					     umd_setup, umd_cleanup, info);
 	if (!sub_info)
 		goto out;
diff --git a/net/ipv4/bpfilter/sockopt.c b/net/ipv4/bpfilter/sockopt.c
index c0dbcc86fcdb..5050de28333d 100644
--- a/net/ipv4/bpfilter/sockopt.c
+++ b/net/ipv4/bpfilter/sockopt.c
@@ -70,7 +70,7 @@ static int __init bpfilter_sockopt_init(void)
 {
 	mutex_init(&bpfilter_ops.lock);
 	bpfilter_ops.stop = true;
-	bpfilter_ops.info.cmdline = "bpfilter_umh";
+	bpfilter_ops.info.driver_name = "bpfilter_umh";
 	bpfilter_ops.info.cleanup = &bpfilter_umh_cleanup;
 
 	return 0;
-- 
2.25.0

