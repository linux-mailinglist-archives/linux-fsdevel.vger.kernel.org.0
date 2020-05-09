Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50B391CC42F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 May 2020 21:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbgEIToY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 May 2020 15:44:24 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:53380 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727938AbgEIToX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 May 2020 15:44:23 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jXVOY-0000ls-R6; Sat, 09 May 2020 13:44:22 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jXVOX-0006Xr-QE; Sat, 09 May 2020 13:44:22 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        <linux-fsdevel@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
        <87sgga6ze4.fsf@x220.int.ebiederm.org>
        <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
Date:   Sat, 09 May 2020 14:40:53 -0500
In-Reply-To: <87v9l4zyla.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Sat, 09 May 2020 14:40:17 -0500")
Message-ID: <87pnbczyka.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jXVOX-0006Xr-QE;;;mid=<87pnbczyka.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19q9NmVU84Mw9oy22ZcRjrINLYW7zrSIoA=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMGappySubj_01,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.5 XMGappySubj_01 Very gappy subject
        *  0.7 XMSubLong Long Subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa03 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 360 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.3 (1.2%), b_tie_ro: 2.9 (0.8%), parse: 1.09
        (0.3%), extract_message_metadata: 12 (3.5%), get_uri_detail_list: 1.82
        (0.5%), tests_pri_-1000: 11 (3.1%), tests_pri_-950: 1.06 (0.3%),
        tests_pri_-900: 0.82 (0.2%), tests_pri_-90: 56 (15.5%), check_bayes:
        55 (15.2%), b_tokenize: 6 (1.8%), b_tok_get_all: 7 (2.0%),
        b_comp_prob: 1.86 (0.5%), b_tok_touch_all: 36 (10.1%), b_finish: 0.70
        (0.2%), tests_pri_0: 262 (72.6%), check_dkim_signature: 0.38 (0.1%),
        check_dkim_adsp: 2.5 (0.7%), poll_dns_idle: 1.15 (0.3%), tests_pri_10:
        2.6 (0.7%), tests_pri_500: 7 (1.8%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 1/5] exec: Call cap_bprm_set_creds directly from prepare_binprm
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


The function cap_bprm_set_creds is the only instance of
security_bprm_set_creds that does something for the primary executable
file and for every interpreter the rest of the implementations of
security_bprm_set_creds do something only for the primary executable
file even if that file is a shell script.

The function cap_bprm_set_creds is also special in that it is called
even when CONFIG_SECURITY is unset.

So calling cap_bprm_set_creds separately to make these two cases explicit,
and allow future changes to take advantages of these differences
to simplify the code.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c                | 4 ++++
 include/linux/security.h | 2 +-
 security/commoncap.c     | 1 -
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index b0620d5ebc66..765bfd51a546 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1641,6 +1641,10 @@ int prepare_binprm(struct linux_binprm *bprm)
 		return retval;
 	bprm->called_set_creds = 1;
 
+	retval = cap_bprm_set_creds(bprm);
+	if (retval)
+		return retval;
+
 	memset(bprm->buf, 0, BINPRM_BUF_SIZE);
 	return kernel_read(bprm->file, bprm->buf, BINPRM_BUF_SIZE, &pos);
 }
diff --git a/include/linux/security.h b/include/linux/security.h
index a8d9310472df..c1aa1638429a 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -571,7 +571,7 @@ static inline int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 
 static inline int security_bprm_set_creds(struct linux_binprm *bprm)
 {
-	return cap_bprm_set_creds(bprm);
+	return 0;
 }
 
 static inline int security_bprm_check(struct linux_binprm *bprm)
diff --git a/security/commoncap.c b/security/commoncap.c
index f4ee0ae106b2..3757988abe42 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -1346,7 +1346,6 @@ static struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ptrace_traceme, cap_ptrace_traceme),
 	LSM_HOOK_INIT(capget, cap_capget),
 	LSM_HOOK_INIT(capset, cap_capset),
-	LSM_HOOK_INIT(bprm_set_creds, cap_bprm_set_creds),
 	LSM_HOOK_INIT(inode_need_killpriv, cap_inode_need_killpriv),
 	LSM_HOOK_INIT(inode_killpriv, cap_inode_killpriv),
 	LSM_HOOK_INIT(inode_getsecurity, cap_inode_getsecurity),
-- 
2.25.0

