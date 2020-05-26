Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 184A41C5B46
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 17:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730128AbgEEPc3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 11:32:29 -0400
Received: from smtp-8fa8.mail.infomaniak.ch ([83.166.143.168]:44549 "EHLO
        smtp-8fa8.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730088AbgEEPc3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 11:32:29 -0400
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 49GkHZ5J2gzlhdsY;
        Tue,  5 May 2020 17:32:26 +0200 (CEST)
Received: from localhost (unknown [94.23.54.103])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 49GkHZ1fSRzlsT3N;
        Tue,  5 May 2020 17:32:26 +0200 (CEST)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mickael.salaun@ssi.gouv.fr>,
        Mimi Zohar <zohar@linux.ibm.com>,
        =?UTF-8?q?Philippe=20Tr=C3=A9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v5 6/6] ima: add policy support for the new file open MAY_OPENEXEC flag
Date:   Tue,  5 May 2020 17:31:56 +0200
Message-Id: <20200505153156.925111-7-mic@digikod.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200505153156.925111-1-mic@digikod.net>
References: <20200505153156.925111-1-mic@digikod.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mimi Zohar <zohar@linux.ibm.com>

The kernel has no way of differentiating between a file containing data
or code being opened by an interpreter.  The proposed O_MAYEXEC
openat2(2) flag bridges this gap by defining and enabling the
MAY_OPENEXEC flag.

This patch adds IMA policy support for the new MAY_OPENEXEC flag.

Example:
measure func=FILE_CHECK mask=^MAY_OPENEXEC
appraise func=FILE_CHECK appraise_type=imasig mask=^MAY_OPENEXEC

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Link: https://lore.kernel.org/r/1588167523-7866-3-git-send-email-zohar@linux.ibm.com
---
 Documentation/ABI/testing/ima_policy |  2 +-
 security/integrity/ima/ima_main.c    |  3 ++-
 security/integrity/ima/ima_policy.c  | 15 +++++++++++----
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index cd572912c593..caca46125fe0 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -31,7 +31,7 @@ Description:
 				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
 				[KEXEC_CMDLINE] [KEY_CHECK]
 			mask:= [[^]MAY_READ] [[^]MAY_WRITE] [[^]MAY_APPEND]
-			       [[^]MAY_EXEC]
+			       [[^]MAY_EXEC] [[^]MAY_OPENEXEC]
 			fsmagic:= hex value
 			fsuuid:= file system UUID (e.g 8bcbe394-4f13-4144-be8e-5aa9ea2ce2f6)
 			uid:= decimal value
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 9d0abedeae77..c80cdaf13626 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -438,7 +438,8 @@ int ima_file_check(struct file *file, int mask)
 
 	security_task_getsecid(current, &secid);
 	return process_measurement(file, current_cred(), secid, NULL, 0,
-				   mask & (MAY_READ | MAY_WRITE | MAY_EXEC |
+				   mask & (MAY_READ | MAY_WRITE |
+					   MAY_EXEC | MAY_OPENEXEC |
 					   MAY_APPEND), FILE_CHECK);
 }
 EXPORT_SYMBOL_GPL(ima_file_check);
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index c334e0dc6083..f54cbc55498d 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -406,7 +406,8 @@ static bool ima_match_keyring(struct ima_rule_entry *rule,
  * @cred: a pointer to a credentials structure for user validation
  * @secid: the secid of the task to be validated
  * @func: LIM hook identifier
- * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
+ * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC |
+ *			    MAY_OPENEXEC)
  * @keyring: keyring name to check in policy for KEY_CHECK func
  *
  * Returns true on rule match, false on failure.
@@ -527,7 +528,8 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  *        being made
  * @secid: LSM secid of the task to be validated
  * @func: IMA hook identifier
- * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
+ * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC |
+ *			    MAY_OPENEXEC)
  * @pcr: set the pcr to extend
  * @template_desc: the template that should be used for this rule
  * @keyring: the keyring name, if given, to be used to check in the policy.
@@ -1089,6 +1091,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 				entry->mask = MAY_READ;
 			else if (strcmp(from, "MAY_APPEND") == 0)
 				entry->mask = MAY_APPEND;
+			else if (strcmp(from, "MAY_OPENEXEC") == 0)
+				entry->mask = MAY_OPENEXEC;
 			else
 				result = -EINVAL;
 			if (!result)
@@ -1420,14 +1424,15 @@ const char *const func_tokens[] = {
 
 #ifdef	CONFIG_IMA_READ_POLICY
 enum {
-	mask_exec = 0, mask_write, mask_read, mask_append
+	mask_exec = 0, mask_write, mask_read, mask_append, mask_openexec
 };
 
 static const char *const mask_tokens[] = {
 	"^MAY_EXEC",
 	"^MAY_WRITE",
 	"^MAY_READ",
-	"^MAY_APPEND"
+	"^MAY_APPEND",
+	"^MAY_OPENEXEC"
 };
 
 void *ima_policy_start(struct seq_file *m, loff_t *pos)
@@ -1516,6 +1521,8 @@ int ima_policy_show(struct seq_file *m, void *v)
 			seq_printf(m, pt(Opt_mask), mt(mask_read) + offset);
 		if (entry->mask & MAY_APPEND)
 			seq_printf(m, pt(Opt_mask), mt(mask_append) + offset);
+		if (entry->mask & MAY_OPENEXEC)
+			seq_printf(m, pt(Opt_mask), mt(mask_openexec) + offset);
 		seq_puts(m, " ");
 	}
 
-- 
2.26.2

