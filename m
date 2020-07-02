Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0EE2212A0C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jul 2020 18:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgGBQrk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jul 2020 12:47:40 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:40524 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgGBQri (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jul 2020 12:47:38 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jr2N7-00020u-HP; Thu, 02 Jul 2020 10:47:37 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jr2N6-0007up-De; Thu, 02 Jul 2020 10:47:37 -0600
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
Date:   Thu,  2 Jul 2020 11:41:27 -0500
Message-Id: <20200702164140.4468-3-ebiederm@xmission.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <87y2o1swee.fsf_-_@x220.int.ebiederm.org>
References: <87y2o1swee.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1jr2N6-0007up-De;;;mid=<20200702164140.4468-3-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/s0b3BYl1kTk80Mm/H1N4bnuhOkqxEowc=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa07 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 443 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 11 (2.5%), b_tie_ro: 10 (2.2%), parse: 0.94
        (0.2%), extract_message_metadata: 14 (3.3%), get_uri_detail_list: 1.69
        (0.4%), tests_pri_-1000: 25 (5.7%), tests_pri_-950: 1.21 (0.3%),
        tests_pri_-900: 1.05 (0.2%), tests_pri_-90: 143 (32.4%), check_bayes:
        142 (32.0%), b_tokenize: 9 (2.0%), b_tok_get_all: 27 (6.2%),
        b_comp_prob: 2.2 (0.5%), b_tok_touch_all: 100 (22.5%), b_finish: 1.01
        (0.2%), tests_pri_0: 225 (50.9%), check_dkim_signature: 0.53 (0.1%),
        check_dkim_adsp: 2.2 (0.5%), poll_dns_idle: 0.57 (0.1%), tests_pri_10:
        2.4 (0.5%), tests_pri_500: 15 (3.4%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v3 03/16] umh: Rename the user mode driver helpers for clarity
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that the functionality of umh_setup_pipe and
umh_clean_and_save_pid has changed their names are too specific and
don't make much sense.  Instead name them  umd_setup and umd_cleanup
for the functional role in setting up user mode drivers.

v1: https://lkml.kernel.org/r/875zbegf82.fsf_-_@x220.int.ebiederm.org
v2: https://lkml.kernel.org/r/87tuyt63x3.fsf_-_@x220.int.ebiederm.org
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/umh.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/umh.c b/kernel/umh.c
index e6b9d6636850..26c3d493f168 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -429,7 +429,7 @@ struct subprocess_info *call_usermodehelper_setup_file(struct file *file,
 	return sub_info;
 }
 
-static int umh_pipe_setup(struct subprocess_info *info, struct cred *new)
+static int umd_setup(struct subprocess_info *info, struct cred *new)
 {
 	struct umh_info *umh_info = info->data;
 	struct file *from_umh[2];
@@ -470,11 +470,11 @@ static int umh_pipe_setup(struct subprocess_info *info, struct cred *new)
 	return 0;
 }
 
-static void umh_clean_and_save_pid(struct subprocess_info *info)
+static void umd_cleanup(struct subprocess_info *info)
 {
 	struct umh_info *umh_info = info->data;
 
-	/* cleanup if umh_pipe_setup() was successful but exec failed */
+	/* cleanup if umh_setup() was successful but exec failed */
 	if (info->retval) {
 		fput(umh_info->pipe_to_umh);
 		fput(umh_info->pipe_from_umh);
@@ -520,8 +520,8 @@ int fork_usermode_blob(void *data, size_t len, struct umh_info *info)
 	}
 
 	err = -ENOMEM;
-	sub_info = call_usermodehelper_setup_file(file, umh_pipe_setup,
-						  umh_clean_and_save_pid, info);
+	sub_info = call_usermodehelper_setup_file(file, umd_setup, umd_cleanup,
+						  info);
 	if (!sub_info)
 		goto out;
 
-- 
2.25.0

