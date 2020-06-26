Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 962C420B1D9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jun 2020 14:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgFZM6f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jun 2020 08:58:35 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:37428 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgFZM6e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jun 2020 08:58:34 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jonw9-0000t5-MR; Fri, 26 Jun 2020 06:58:33 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jonw8-00012a-S0; Fri, 26 Jun 2020 06:58:33 -0600
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
Date:   Fri, 26 Jun 2020 07:54:05 -0500
In-Reply-To: <87pn9mgfc2.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Fri, 26 Jun 2020 07:51:41 -0500")
Message-ID: <875zbegf82.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jonw8-00012a-S0;;;mid=<875zbegf82.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19e4bFa6lXeyH+JJbVszaKhHimRlwSNGdg=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,XMNoVowels,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa06 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 381 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 11 (2.8%), b_tie_ro: 9 (2.4%), parse: 1.18 (0.3%),
         extract_message_metadata: 11 (2.9%), get_uri_detail_list: 1.08 (0.3%),
         tests_pri_-1000: 14 (3.8%), tests_pri_-950: 1.35 (0.4%),
        tests_pri_-900: 1.07 (0.3%), tests_pri_-90: 99 (25.9%), check_bayes:
        97 (25.5%), b_tokenize: 8 (2.1%), b_tok_get_all: 7 (1.8%),
        b_comp_prob: 3.2 (0.8%), b_tok_touch_all: 75 (19.6%), b_finish: 1.14
        (0.3%), tests_pri_0: 230 (60.3%), check_dkim_signature: 0.76 (0.2%),
        check_dkim_adsp: 2.8 (0.7%), poll_dns_idle: 0.63 (0.2%), tests_pri_10:
        2.2 (0.6%), tests_pri_500: 7 (1.8%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 03/14] umh: Rename the user mode driver helpers for clarity
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Now that the functionality of umh_setup_pipe and
umh_clean_and_save_pid has changed their names are too specific and
don't make much sense.  Instead name them  umd_setup and umd_cleanup
for the functional role in setting up user mode drivers.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/umh.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/umh.c b/kernel/umh.c
index e6b9d6636850..0ffe0a08cdde 100644
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
@@ -470,7 +470,7 @@ static int umh_pipe_setup(struct subprocess_info *info, struct cred *new)
 	return 0;
 }
 
-static void umh_clean_and_save_pid(struct subprocess_info *info)
+static void umd_cleanup(struct subprocess_info *info)
 {
 	struct umh_info *umh_info = info->data;
 
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

