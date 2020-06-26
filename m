Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A11D20B208
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jun 2020 15:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgFZNEB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jun 2020 09:04:01 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:57038 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgFZNEB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jun 2020 09:04:01 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1joo1P-0006V9-NM; Fri, 26 Jun 2020 07:03:59 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1joo1I-0004C2-T9; Fri, 26 Jun 2020 07:03:59 -0600
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
Date:   Fri, 26 Jun 2020 07:59:26 -0500
In-Reply-To: <87pn9mgfc2.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Fri, 26 Jun 2020 07:51:41 -0500")
Message-ID: <87h7uydlu9.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1joo1I-0004C2-T9;;;mid=<87h7uydlu9.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19I8th5N1uVHflkbTv/aQF4J+cXFi6hY+o=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,NO_DNS_FOR_FROM,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 NO_DNS_FOR_FROM DNS: Envelope sender has no MX or A DNS records
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa01 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 6018 ms - load_scoreonly_sql: 0.25 (0.0%),
        signal_user_changed: 8 (0.1%), b_tie_ro: 4.7 (0.1%), parse: 2.2 (0.0%),
         extract_message_metadata: 19 (0.3%), get_uri_detail_list: 2.3 (0.0%),
        tests_pri_-1000: 5 (0.1%), compile_eval: 28 (0.5%), tests_pri_-950:
        1.67 (0.0%), tests_pri_-900: 1.44 (0.0%), tests_pri_-90: 99 (1.7%),
        check_bayes: 96 (1.6%), b_tokenize: 10 (0.2%), b_tok_get_all: 9 (0.2%),
         b_comp_prob: 1.76 (0.0%), b_tok_touch_all: 72 (1.2%), b_finish: 1.09
        (0.0%), tests_pri_0: 5865 (97.5%), check_dkim_signature: 0.65 (0.0%),
        check_dkim_adsp: 5465 (90.8%), poll_dns_idle: 5461 (90.8%),
        tests_pri_10: 2.0 (0.0%), tests_pri_500: 9 (0.1%), rewrite_mail: 0.00
        (0.0%)
Subject: [PATCH 13/14] bpfilter: Take advantage of the facilities of struct pid
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Instead of relying on the exit_umh cleanup callback use the fact a
struct pid can be tested to see if a process still exists, and that
struct pid has a wait queue that notifies when the process dies.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/bpfilter.h     |  3 ++-
 net/bpfilter/bpfilter_kern.c | 15 +++++----------
 net/ipv4/bpfilter/sockopt.c  | 15 ++++++++-------
 3 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/include/linux/bpfilter.h b/include/linux/bpfilter.h
index 4b43d2240172..8073ddce73b1 100644
--- a/include/linux/bpfilter.h
+++ b/include/linux/bpfilter.h
@@ -10,6 +10,8 @@ int bpfilter_ip_set_sockopt(struct sock *sk, int optname, char __user *optval,
 			    unsigned int optlen);
 int bpfilter_ip_get_sockopt(struct sock *sk, int optname, char __user *optval,
 			    int __user *optlen);
+void bpfilter_umh_cleanup(struct umd_info *info);
+
 struct bpfilter_umh_ops {
 	struct umd_info info;
 	/* since ip_getsockopt() can run in parallel, serialize access to umh */
@@ -18,7 +20,6 @@ struct bpfilter_umh_ops {
 		       char __user *optval,
 		       unsigned int optlen, bool is_set);
 	int (*start)(void);
-	bool stop;
 };
 extern struct bpfilter_umh_ops bpfilter_ops;
 #endif
diff --git a/net/bpfilter/bpfilter_kern.c b/net/bpfilter/bpfilter_kern.c
index b73dedeb6dbf..91474884ddb7 100644
--- a/net/bpfilter/bpfilter_kern.c
+++ b/net/bpfilter/bpfilter_kern.c
@@ -18,10 +18,11 @@ static void shutdown_umh(void)
 	struct umd_info *info = &bpfilter_ops.info;
 	struct pid *tgid = info->tgid;
 
-	if (bpfilter_ops.stop)
-		return;
-
-	kill_pid_info(SIGKILL, SEND_SIG_PRIV, tgid);
+	if (tgid) {
+		kill_pid_info(SIGKILL, SEND_SIG_PRIV, tgid);
+		wait_event(tgid->wait_pidfd, !pid_task(tgid, PIDTYPE_TGID));
+		bpfilter_umh_cleanup(info);
+	}
 }
 
 static void __stop_umh(void)
@@ -77,7 +78,6 @@ static int start_umh(void)
 	err = fork_usermode_driver(&bpfilter_ops.info);
 	if (err)
 		return err;
-	bpfilter_ops.stop = false;
 	pr_info("Loaded bpfilter_umh pid %d\n", pid_nr(bpfilter_ops.info.tgid));
 
 	/* health check that usermode process started correctly */
@@ -100,16 +100,11 @@ static int __init load_umh(void)
 		return err;
 
 	mutex_lock(&bpfilter_ops.lock);
-	if (!bpfilter_ops.stop) {
-		err = -EFAULT;
-		goto out;
-	}
 	err = start_umh();
 	if (!err && IS_ENABLED(CONFIG_INET)) {
 		bpfilter_ops.sockopt = &__bpfilter_process_sockopt;
 		bpfilter_ops.start = &start_umh;
 	}
-out:
 	mutex_unlock(&bpfilter_ops.lock);
 	if (err)
 		umd_unload_blob(&bpfilter_ops.info);
diff --git a/net/ipv4/bpfilter/sockopt.c b/net/ipv4/bpfilter/sockopt.c
index 56cbc43145f6..9455eb9cec78 100644
--- a/net/ipv4/bpfilter/sockopt.c
+++ b/net/ipv4/bpfilter/sockopt.c
@@ -12,16 +12,14 @@
 struct bpfilter_umh_ops bpfilter_ops;
 EXPORT_SYMBOL_GPL(bpfilter_ops);
 
-static void bpfilter_umh_cleanup(struct umd_info *info)
+void bpfilter_umh_cleanup(struct umd_info *info)
 {
-	mutex_lock(&bpfilter_ops.lock);
-	bpfilter_ops.stop = true;
 	fput(info->pipe_to_umh);
 	fput(info->pipe_from_umh);
 	put_pid(info->tgid);
 	info->tgid = NULL;
-	mutex_unlock(&bpfilter_ops.lock);
 }
+EXPORT_SYMBOL_GPL(bpfilter_umh_cleanup);
 
 static int bpfilter_mbox_request(struct sock *sk, int optname,
 				 char __user *optval,
@@ -39,7 +37,11 @@ static int bpfilter_mbox_request(struct sock *sk, int optname,
 			goto out;
 		}
 	}
-	if (bpfilter_ops.stop) {
+	if (bpfilter_ops.info.tgid &&
+	    !pid_has_task(bpfilter_ops.info.tgid, PIDTYPE_TGID))
+		bpfilter_umh_cleanup(&bpfilter_ops.info);
+
+	if (!bpfilter_ops.info.tgid) {
 		err = bpfilter_ops.start();
 		if (err)
 			goto out;
@@ -70,9 +72,8 @@ int bpfilter_ip_get_sockopt(struct sock *sk, int optname, char __user *optval,
 static int __init bpfilter_sockopt_init(void)
 {
 	mutex_init(&bpfilter_ops.lock);
-	bpfilter_ops.stop = true;
+	bpfilter_ops.info.tgid = NULL;
 	bpfilter_ops.info.driver_name = "bpfilter_umh";
-	bpfilter_ops.info.cleanup = &bpfilter_umh_cleanup;
 
 	return 0;
 }
-- 
2.25.0

