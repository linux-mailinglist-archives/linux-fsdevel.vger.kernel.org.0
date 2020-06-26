Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0637F20B1E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jun 2020 15:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgFZNAO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jun 2020 09:00:14 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:38462 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgFZNAN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jun 2020 09:00:13 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jonxj-0001Ak-Ri; Fri, 26 Jun 2020 07:00:12 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jonxi-0001K5-NZ; Fri, 26 Jun 2020 07:00:11 -0600
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
Date:   Fri, 26 Jun 2020 07:55:43 -0500
In-Reply-To: <87pn9mgfc2.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Fri, 26 Jun 2020 07:51:41 -0500")
Message-ID: <87o8p6f0kw.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jonxi-0001K5-NZ;;;mid=<87o8p6f0kw.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+XaSdtOcDxUVXsGzU5t0OKek4lrBb4cbg=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMNoVowels autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa04 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 475 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 10 (2.0%), b_tie_ro: 8 (1.8%), parse: 1.09 (0.2%),
         extract_message_metadata: 12 (2.5%), get_uri_detail_list: 2.4 (0.5%),
        tests_pri_-1000: 14 (2.9%), tests_pri_-950: 1.17 (0.2%),
        tests_pri_-900: 0.98 (0.2%), tests_pri_-90: 105 (22.1%), check_bayes:
        104 (21.8%), b_tokenize: 12 (2.5%), b_tok_get_all: 8 (1.7%),
        b_comp_prob: 2.4 (0.5%), b_tok_touch_all: 78 (16.4%), b_finish: 0.83
        (0.2%), tests_pri_0: 321 (67.6%), check_dkim_signature: 0.61 (0.1%),
        check_dkim_adsp: 2.3 (0.5%), poll_dns_idle: 0.55 (0.1%), tests_pri_10:
        1.82 (0.4%), tests_pri_500: 5 (1.1%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 06/14] umd: For clarity rename umh_info umd_info
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


This structure is only used for user mode drivers so change
the prefix from umh to umd to make that clear.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/bpfilter.h    |  2 +-
 include/linux/umd.h         |  6 +++---
 kernel/umd.c                | 20 ++++++++++----------
 net/ipv4/bpfilter/sockopt.c |  2 +-
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/linux/bpfilter.h b/include/linux/bpfilter.h
index b42e44e29033..4b43d2240172 100644
--- a/include/linux/bpfilter.h
+++ b/include/linux/bpfilter.h
@@ -11,7 +11,7 @@ int bpfilter_ip_set_sockopt(struct sock *sk, int optname, char __user *optval,
 int bpfilter_ip_get_sockopt(struct sock *sk, int optname, char __user *optval,
 			    int __user *optlen);
 struct bpfilter_umh_ops {
-	struct umh_info info;
+	struct umd_info info;
 	/* since ip_getsockopt() can run in parallel, serialize access to umh */
 	struct mutex lock;
 	int (*sockopt)(struct sock *sk, int optname,
diff --git a/include/linux/umd.h b/include/linux/umd.h
index 3f8c5743202b..4f61849e2031 100644
--- a/include/linux/umd.h
+++ b/include/linux/umd.h
@@ -3,14 +3,14 @@
 
 #include <linux/umh.h>
 
-struct umh_info {
+struct umd_info {
 	const char *cmdline;
 	struct file *pipe_to_umh;
 	struct file *pipe_from_umh;
 	struct list_head list;
-	void (*cleanup)(struct umh_info *info);
+	void (*cleanup)(struct umd_info *info);
 	pid_t pid;
 };
-int fork_usermode_blob(void *data, size_t len, struct umh_info *info);
+int fork_usermode_blob(void *data, size_t len, struct umd_info *info);
 
 #endif /* __LINUX_UMD_H__ */
diff --git a/kernel/umd.c b/kernel/umd.c
index 8efaa84b6aa1..aa1215faa8a1 100644
--- a/kernel/umd.c
+++ b/kernel/umd.c
@@ -11,7 +11,7 @@ static DEFINE_MUTEX(umh_list_lock);
 
 static int umd_setup(struct subprocess_info *info, struct cred *new)
 {
-	struct umh_info *umh_info = info->data;
+	struct umd_info *umd_info = info->data;
 	struct file *from_umh[2];
 	struct file *to_umh[2];
 	int err;
@@ -43,21 +43,21 @@ static int umd_setup(struct subprocess_info *info, struct cred *new)
 		return err;
 	}
 
-	umh_info->pipe_to_umh = to_umh[1];
-	umh_info->pipe_from_umh = from_umh[0];
-	umh_info->pid = task_pid_nr(current);
+	umd_info->pipe_to_umh = to_umh[1];
+	umd_info->pipe_from_umh = from_umh[0];
+	umd_info->pid = task_pid_nr(current);
 	current->flags |= PF_UMH;
 	return 0;
 }
 
 static void umd_cleanup(struct subprocess_info *info)
 {
-	struct umh_info *umh_info = info->data;
+	struct umd_info *umd_info = info->data;
 
 	/* cleanup if umh_pipe_setup() was successful but exec failed */
 	if (info->retval) {
-		fput(umh_info->pipe_to_umh);
-		fput(umh_info->pipe_from_umh);
+		fput(umd_info->pipe_to_umh);
+		fput(umd_info->pipe_from_umh);
 	}
 }
 
@@ -72,12 +72,12 @@ static void umd_cleanup(struct subprocess_info *info)
  *
  * Returns either negative error or zero which indicates success
  * in executing a blob of bytes as a usermode process. In such
- * case 'struct umh_info *info' is populated with two pipes
+ * case 'struct umd_info *info' is populated with two pipes
  * and a pid of the process. The caller is responsible for health
  * check of the user process, killing it via pid, and closing the
  * pipes when user process is no longer needed.
  */
-int fork_usermode_blob(void *data, size_t len, struct umh_info *info)
+int fork_usermode_blob(void *data, size_t len, struct umd_info *info)
 {
 	const char *cmdline = (info->cmdline) ? info->cmdline : "usermodehelper";
 	struct subprocess_info *sub_info;
@@ -126,7 +126,7 @@ EXPORT_SYMBOL_GPL(fork_usermode_blob);
 
 void __exit_umh(struct task_struct *tsk)
 {
-	struct umh_info *info;
+	struct umd_info *info;
 	pid_t pid = tsk->pid;
 
 	mutex_lock(&umh_list_lock);
diff --git a/net/ipv4/bpfilter/sockopt.c b/net/ipv4/bpfilter/sockopt.c
index 0480918bfc7c..c0dbcc86fcdb 100644
--- a/net/ipv4/bpfilter/sockopt.c
+++ b/net/ipv4/bpfilter/sockopt.c
@@ -12,7 +12,7 @@
 struct bpfilter_umh_ops bpfilter_ops;
 EXPORT_SYMBOL_GPL(bpfilter_ops);
 
-static void bpfilter_umh_cleanup(struct umh_info *info)
+static void bpfilter_umh_cleanup(struct umd_info *info)
 {
 	mutex_lock(&bpfilter_ops.lock);
 	bpfilter_ops.stop = true;
-- 
2.25.0

