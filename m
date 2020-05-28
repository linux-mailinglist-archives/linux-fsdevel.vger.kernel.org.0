Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DED91E66B4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 17:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404741AbgE1Prz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 11:47:55 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:50942 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404544AbgE1Pry (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 11:47:54 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jeKl6-0004W3-WE; Thu, 28 May 2020 09:47:53 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jeKl5-00075p-Nb; Thu, 28 May 2020 09:47:52 -0600
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
        <877dx822er.fsf_-_@x220.int.ebiederm.org>
        <87k10wysqz.fsf_-_@x220.int.ebiederm.org>
Date:   Thu, 28 May 2020 10:44:00 -0500
In-Reply-To: <87k10wysqz.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Thu, 28 May 2020 10:38:28 -0500")
Message-ID: <87r1v4xdxb.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jeKl5-00075p-Nb;;;mid=<87r1v4xdxb.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19VmBdjmZhr7D8UoDa9++wsyncidLVa1jw=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: ****
X-Spam-Status: No, score=4.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong,XMSubMetaSxObfu_03,XMSubMetaSx_00 autolearn=disabled
        version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 0; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa03 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 846 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.3 (0.5%), b_tie_ro: 3.0 (0.4%), parse: 1.16
        (0.1%), extract_message_metadata: 11 (1.2%), get_uri_detail_list: 2.5
        (0.3%), tests_pri_-1000: 11 (1.3%), tests_pri_-950: 1.03 (0.1%),
        tests_pri_-900: 0.86 (0.1%), tests_pri_-90: 365 (43.2%), check_bayes:
        363 (43.0%), b_tokenize: 11 (1.3%), b_tok_get_all: 185 (21.9%),
        b_comp_prob: 3.1 (0.4%), b_tok_touch_all: 161 (19.0%), b_finish: 0.77
        (0.1%), tests_pri_0: 441 (52.2%), check_dkim_signature: 0.46 (0.1%),
        check_dkim_adsp: 2.4 (0.3%), poll_dns_idle: 0.89 (0.1%), tests_pri_10:
        1.78 (0.2%), tests_pri_500: 6 (0.7%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 04/11] exec: Move uid/gid handling from creds_from_file into bprm_fill_uid
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


The logic in cap_bprm_creds_from_file is difficult to follow in part
because it handles both uids/gids and capabilities.  That difficulty
in following the code has resulted in several small bugs.  Move the
handling of uids/gids into bprm_fill_uid to make the code clearer.

A small bug is fixed where the ambient capabilities were unnecessarily
cleared when the presence of a ptracer or a shared fs_struct resulted
in the setuid or setgid not being honored.  This bug was not possible
to leave in place with the movement of the uids and gids handling
out of cap_bprm_repopultate_creds.

The rest of the bugs I have tried to make more apparent but left
in tact when moving the code into bprm_fill_uid.

Ref: ee67ae7ef6ff ("commoncap: Move cap_elevated calculation into bprm_set_creds")
Fixes: 58319057b784 ("capabilities: ambient capabilities")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c            | 49 ++++++++++++++++++++++++++++++++++++--------
 security/commoncap.c | 25 +++++++---------------
 2 files changed, 48 insertions(+), 26 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 091ff6269610..956ee3a0d824 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1590,21 +1590,23 @@ static void check_unsafe_exec(struct linux_binprm *bprm)
 static void bprm_fill_uid(struct linux_binprm *bprm)
 {
 	/* Handle suid and sgid on files */
+	struct cred *new = bprm->cred;
 	struct inode *inode;
 	unsigned int mode;
+	bool need_cap;
 	kuid_t uid;
 	kgid_t gid;
 
 	if (!mnt_may_suid(bprm->file->f_path.mnt))
-		return;
+		goto after_setid;
 
 	if (task_no_new_privs(current))
-		return;
+		goto after_setid;
 
 	inode = bprm->file->f_path.dentry->d_inode;
 	mode = READ_ONCE(inode->i_mode);
 	if (!(mode & (S_ISUID|S_ISGID)))
-		return;
+		goto after_setid;
 
 	/* Be careful if suid/sgid is set */
 	inode_lock(inode);
@@ -1616,19 +1618,50 @@ static void bprm_fill_uid(struct linux_binprm *bprm)
 	inode_unlock(inode);
 
 	/* We ignore suid/sgid if there are no mappings for them in the ns */
-	if (!kuid_has_mapping(bprm->cred->user_ns, uid) ||
-		 !kgid_has_mapping(bprm->cred->user_ns, gid))
-		return;
+	if (!kuid_has_mapping(new->user_ns, uid) ||
+	    !kgid_has_mapping(new->user_ns, gid))
+		goto after_setid;
 
 	if (mode & S_ISUID) {
 		bprm->per_clear = 1;
-		bprm->cred->euid = uid;
+		new->euid = uid;
 	}
 
 	if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)) {
 		bprm->per_clear = 1;
-		bprm->cred->egid = gid;
+		new->egid = gid;
+	}
+
+after_setid:
+	/* Will the new creds have multiple uids or gids? */
+	if (!uid_eq(new->euid, new->uid) || !gid_eq(new->egid, new->gid)) {
+		bprm->secureexec = 1;
+
+		/*
+		 * Is the root directory and working directory shared or is
+		 * the process traced and the tracing process does not have
+		 * CAP_SYS_PTRACE?
+		 *
+		 * In either case it is not safe to change the euid or egid
+		 * unless the current process has the appropriate cap and so
+		 * chaning the euid or egid was already possible.
+		 */
+		need_cap = bprm->unsafe & LSM_UNSAFE_SHARE ||
+			!ptracer_capable(current, new->user_ns);
+		if (need_cap && !uid_eq(new->euid, new->uid) &&
+		    (!ns_capable(new->user_ns, CAP_SETUID) ||
+		     (bprm->unsafe & LSM_UNSAFE_NO_NEW_PRIVS))) {
+			new->euid = new->uid;
+		}
+		if (need_cap && !gid_eq(new->egid, new->gid) &&
+		    (!ns_capable(new->user_ns, CAP_SETUID) ||
+		     (bprm->unsafe & LSM_UNSAFE_NO_NEW_PRIVS))) {
+			new->egid = new->gid;
+		}
 	}
+
+	new->suid = new->fsuid = new->euid;
+	new->sgid = new->fsgid = new->egid;
 }
 
 /*
diff --git a/security/commoncap.c b/security/commoncap.c
index 2bd1f24f3796..b39c7511862e 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -809,7 +809,7 @@ int cap_bprm_creds_from_file(struct linux_binprm *bprm)
 	/* Process setpcap binaries and capabilities for uid 0 */
 	const struct cred *old = current_cred();
 	struct cred *new = bprm->cred;
-	bool effective = false, has_fcap = false, is_setid;
+	bool effective = false, has_fcap = false;
 	int ret;
 	kuid_t root_uid;
 
@@ -828,31 +828,21 @@ int cap_bprm_creds_from_file(struct linux_binprm *bprm)
 	if (__cap_gained(permitted, new, old))
 		bprm->per_clear = 1;
 
-	/* Don't let someone trace a set[ug]id/setpcap binary with the revised
+	/* Don't let someone trace a setpcap binary with the revised
 	 * credentials unless they have the appropriate permit.
 	 *
 	 * In addition, if NO_NEW_PRIVS, then ensure we get no new privs.
 	 */
-	is_setid = __is_setuid(new, old) || __is_setgid(new, old);
-
-	if ((is_setid || __cap_gained(permitted, new, old)) &&
+	if (__cap_gained(permitted, new, old) &&
 	    ((bprm->unsafe & ~LSM_UNSAFE_PTRACE) ||
 	     !ptracer_capable(current, new->user_ns))) {
 		/* downgrade; they get no more than they had, and maybe less */
-		if (!ns_capable(new->user_ns, CAP_SETUID) ||
-		    (bprm->unsafe & LSM_UNSAFE_NO_NEW_PRIVS)) {
-			new->euid = new->uid;
-			new->egid = new->gid;
-		}
 		new->cap_permitted = cap_intersect(new->cap_permitted,
 						   old->cap_permitted);
 	}
 
-	new->suid = new->fsuid = new->euid;
-	new->sgid = new->fsgid = new->egid;
-
 	/* File caps or setid cancels ambient. */
-	if (has_fcap || is_setid)
+	if (has_fcap || __is_setuid(new, old) || __is_setgid(new, old))
 		cap_clear(new->cap_ambient);
 
 	/*
@@ -885,10 +875,9 @@ int cap_bprm_creds_from_file(struct linux_binprm *bprm)
 		return -EPERM;
 
 	/* Check for privilege-elevated exec. */
-	if (is_setid ||
-	    (!__is_real(root_uid, new) &&
-	     (effective ||
-	      __cap_grew(permitted, ambient, new))))
+	if (!__is_real(root_uid, new) &&
+	    (effective ||
+	     __cap_grew(permitted, ambient, new)))
 		bprm->secureexec = 1;
 
 	return 0;
-- 
2.25.0

