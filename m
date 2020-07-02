Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8678212A43
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jul 2020 18:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgGBQsj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jul 2020 12:48:39 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:35290 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgGBQsh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jul 2020 12:48:37 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jr2O4-0007e6-OQ; Thu, 02 Jul 2020 10:48:36 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jr2Nx-0007up-Jp; Thu, 02 Jul 2020 10:48:30 -0600
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
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Thu,  2 Jul 2020 11:41:40 -0500
Message-Id: <20200702164140.4468-16-ebiederm@xmission.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <87y2o1swee.fsf_-_@x220.int.ebiederm.org>
References: <87y2o1swee.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1jr2Nx-0007up-Jp;;;mid=<20200702164140.4468-16-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18OB1SGxTOeo4/dzJbPeWbHPytle+s5LkM=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01
        autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa02 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 396 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.5 (1.1%), b_tie_ro: 3.1 (0.8%), parse: 1.17
        (0.3%), extract_message_metadata: 12 (3.0%), get_uri_detail_list: 1.63
        (0.4%), tests_pri_-1000: 11 (2.9%), tests_pri_-950: 1.04 (0.3%),
        tests_pri_-900: 0.84 (0.2%), tests_pri_-90: 160 (40.5%), check_bayes:
        159 (40.1%), b_tokenize: 6 (1.5%), b_tok_get_all: 6 (1.6%),
        b_comp_prob: 1.84 (0.5%), b_tok_touch_all: 142 (35.7%), b_finish: 0.79
        (0.2%), tests_pri_0: 192 (48.6%), check_dkim_signature: 0.40 (0.1%),
        check_dkim_adsp: 2.4 (0.6%), poll_dns_idle: 0.96 (0.2%), tests_pri_10:
        2.5 (0.6%), tests_pri_500: 7 (1.8%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v3 16/16] umd: Stop using split_argv
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is exactly one argument so there is nothing to split.  All
split_argv does now is cause confusion and avoid the need for a cast
when passing a "const char *" string to call_usermodehelper_setup.

So avoid confusion and the possibility of an odd driver name causing
problems by just using a fixed argv array with a cast in the call to
call_usermodehelper_setup.

v1: https://lkml.kernel.org/r/87sged3a9n.fsf_-_@x220.int.ebiederm.org
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/usermode_driver.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/kernel/usermode_driver.c b/kernel/usermode_driver.c
index cd136f86f799..0b35212ffc3d 100644
--- a/kernel/usermode_driver.c
+++ b/kernel/usermode_driver.c
@@ -160,27 +160,21 @@ static void umd_cleanup(struct subprocess_info *info)
 int fork_usermode_driver(struct umd_info *info)
 {
 	struct subprocess_info *sub_info;
-	char **argv = NULL;
+	const char *argv[] = { info->driver_name, NULL };
 	int err;
 
 	if (WARN_ON_ONCE(info->tgid))
 		return -EBUSY;
 
 	err = -ENOMEM;
-	argv = argv_split(GFP_KERNEL, info->driver_name, NULL);
-	if (!argv)
-		goto out;
-
-	sub_info = call_usermodehelper_setup(info->driver_name, argv, NULL,
-					     GFP_KERNEL,
+	sub_info = call_usermodehelper_setup(info->driver_name,
+					     (char **)argv, NULL, GFP_KERNEL,
 					     umd_setup, umd_cleanup, info);
 	if (!sub_info)
 		goto out;
 
 	err = call_usermodehelper_exec(sub_info, UMH_WAIT_EXEC);
 out:
-	if (argv)
-		argv_free(argv);
 	return err;
 }
 EXPORT_SYMBOL_GPL(fork_usermode_driver);
-- 
2.25.0

