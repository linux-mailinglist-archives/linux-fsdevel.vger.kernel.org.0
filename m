Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA37212A16
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jul 2020 18:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgGBQrw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jul 2020 12:47:52 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:34936 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbgGBQrv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jul 2020 12:47:51 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jr2NK-0007Ys-Fb; Thu, 02 Jul 2020 10:47:50 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jr2NJ-0007up-8r; Thu, 02 Jul 2020 10:47:50 -0600
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
Date:   Thu,  2 Jul 2020 11:41:30 -0500
Message-Id: <20200702164140.4468-6-ebiederm@xmission.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <87y2o1swee.fsf_-_@x220.int.ebiederm.org>
References: <87y2o1swee.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1jr2NJ-0007up-8r;;;mid=<20200702164140.4468-6-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+09M3K8mTppqgipEcpT6jrElPx558U4MQ=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa07 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 803 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 9 (1.1%), b_tie_ro: 7 (0.9%), parse: 1.87 (0.2%),
        extract_message_metadata: 24 (3.0%), get_uri_detail_list: 4.5 (0.6%),
        tests_pri_-1000: 38 (4.7%), tests_pri_-950: 1.28 (0.2%),
        tests_pri_-900: 1.10 (0.1%), tests_pri_-90: 351 (43.7%), check_bayes:
        349 (43.4%), b_tokenize: 13 (1.6%), b_tok_get_all: 7 (0.9%),
        b_comp_prob: 2.7 (0.3%), b_tok_touch_all: 322 (40.1%), b_finish: 1.00
        (0.1%), tests_pri_0: 362 (45.0%), check_dkim_signature: 0.76 (0.1%),
        check_dkim_adsp: 2.1 (0.3%), poll_dns_idle: 0.54 (0.1%), tests_pri_10:
        2.3 (0.3%), tests_pri_500: 8 (1.0%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v3 06/16] umd: For clarity rename umh_info umd_info
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This structure is only used for user mode drivers so change
the prefix from umh to umd to make that clear.

v1: https://lkml.kernel.org/r/87o8p6f0kw.fsf_-_@x220.int.ebiederm.org
v2: https://lkml.kernel.org/r/878sg563po.fsf_-_@x220.int.ebiederm.org
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/bpfilter.h        |  2 +-
 include/linux/usermode_driver.h |  6 +++---
 kernel/usermode_driver.c        | 20 ++++++++++----------
 net/ipv4/bpfilter/sockopt.c     |  2 +-
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/linux/bpfilter.h b/include/linux/bpfilter.h
index d6d6206052a6..ec9972d822e0 100644
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
diff --git a/include/linux/usermode_driver.h b/include/linux/usermode_driver.h
index c5f6dc950227..7131ea611bab 100644
--- a/include/linux/usermode_driver.h
+++ b/include/linux/usermode_driver.h
@@ -17,14 +17,14 @@ static inline void exit_umh(struct task_struct *tsk)
 }
 #endif
 
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
 
 #endif /* __LINUX_USERMODE_DRIVER_H__ */
diff --git a/kernel/usermode_driver.c b/kernel/usermode_driver.c
index 5b05863af855..e73550e946d6 100644
--- a/kernel/usermode_driver.c
+++ b/kernel/usermode_driver.c
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
 
 	/* cleanup if umh_setup() was successful but exec failed */
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

