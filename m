Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6863922F600
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 19:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729670AbgG0RDX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jul 2020 13:03:23 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50754 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729527AbgG0RDW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jul 2020 13:03:22 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06RH1nEt167389;
        Mon, 27 Jul 2020 17:02:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=RKuxFySxIOrswcS7HZJn86yQ5aSrouGMhrnBJ6qwKug=;
 b=KE9rVmmxrgg0F0B/r6KWm1pHHqXHwclbdyJDDYCpVyF4MLM713/EvNIju/DkhXVjQe/L
 pe+Lp6OuzdQnvu64n3ZSq9MN/uMJ8FSJ6mu4gBfWZg2Q7bw7HaXViJJD2Kn5FqdZx6Ob
 HxISVAtYmuXELEtAAzVvRPUDNwPsQwGahUwIAl0rlh74xzbZAbtjnhLb4ViYq7TH2XaA
 xz7FMbns1wDFC1l3NWCoFCNwGsUky7lM/WJmgzIwwqPvn9GYNVqRaOUOTT67ljE43YG4
 txmDHeLZu4R5xH1DErSYrvAbaYLEIvexFw0vig7T77KuwJAGlZsyunSJorS1FM9guLw7 QQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 32hu1jaru5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Jul 2020 17:02:15 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06RGgWHg055648;
        Mon, 27 Jul 2020 17:02:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 32hu5r9fc7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Jul 2020 17:02:15 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06RGuWGl111604;
        Mon, 27 Jul 2020 17:02:14 GMT
Received: from ca-qasparc-x86-2.us.oracle.com (ca-qasparc-x86-2.us.oracle.com [10.147.24.103])
        by userp3020.oracle.com with ESMTP id 32hu5r9f7r-5;
        Mon, 27 Jul 2020 17:02:14 +0000
From:   Anthony Yznaga <anthony.yznaga@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org
Cc:     mhocko@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org, arnd@arndb.de,
        ebiederm@xmission.com, keescook@chromium.org, gerg@linux-m68k.org,
        ktkhai@virtuozzo.com, christian.brauner@ubuntu.com,
        peterz@infradead.org, esyr@redhat.com, jgg@ziepe.ca,
        christian@kellner.me, areber@redhat.com, cyphar@cyphar.com,
        steven.sistare@oracle.com
Subject: [RFC PATCH 4/5] exec, elf: require opt-in for accepting preserved mem
Date:   Mon, 27 Jul 2020 10:11:26 -0700
Message-Id: <1595869887-23307-5-git-send-email-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9695 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0
 suspectscore=2 bulkscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007270117
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Don't copy preserved VMAs to the binary being exec'd unless the binary has
a "preserved-mem-ok" ELF note.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 fs/binfmt_elf.c         | 84 +++++++++++++++++++++++++++++++++++++++++++++++++
 fs/exec.c               | 17 +++++-----
 include/linux/binfmts.h |  7 ++++-
 3 files changed, 100 insertions(+), 8 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 6445a6dbdb1d..46248b7b0a75 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -683,6 +683,81 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
 	return error;
 }
 
+#define NOTES_SZ			SZ_1K
+#define PRESERVED_MEM_OK_STRING		"preserved-mem-ok"
+#define SZ_PRESERVED_MEM_OK_STRING	sizeof(PRESERVED_MEM_OK_STRING)
+
+static int parse_elf_note(struct linux_binprm *bprm, const char *data, size_t *off, size_t datasz)
+{
+	const struct elf_note *nhdr;
+	const char *name;
+	size_t o;
+
+	o = *off;
+	datasz -= o;
+
+	if (datasz < sizeof(*nhdr))
+		return -ENOEXEC;
+
+	nhdr = (const struct elf_note *)(data + o);
+	o += sizeof(*nhdr);
+	datasz -= sizeof(*nhdr);
+
+	/*
+	 * Currently only the preserved-mem-ok elf note is of interest.
+	 */
+	if (nhdr->n_type != 0x07c1feed)
+		goto next;
+
+	if (nhdr->n_namesz > SZ_PRESERVED_MEM_OK_STRING)
+		return -ENOEXEC;
+
+	name =  data + o;
+	if (datasz < SZ_PRESERVED_MEM_OK_STRING ||
+	    strncmp(name, PRESERVED_MEM_OK_STRING, SZ_PRESERVED_MEM_OK_STRING))
+		return -ENOEXEC;
+
+	bprm->accepts_preserved_mem = 1;
+
+next:
+	o += roundup(nhdr->n_namesz, 4) + roundup(nhdr->n_descsz, 4);
+	*off = o;
+
+	return 0;
+}
+
+static int parse_elf_notes(struct linux_binprm *bprm, struct elf_phdr *phdr)
+{
+	char *notes;
+	size_t notes_sz;
+	size_t off = 0;
+	int ret;
+
+	if (!phdr)
+		return 0;
+
+	notes_sz = phdr->p_filesz;
+	if ((notes_sz > NOTES_SZ) || (notes_sz < sizeof(struct elf_note)))
+		return -ENOEXEC;
+
+	notes = kvmalloc(notes_sz, GFP_KERNEL);
+	if (!notes)
+		return -ENOMEM;
+
+	ret = elf_read(bprm->file, notes, notes_sz, phdr->p_offset);
+	if (ret < 0)
+		goto out;
+
+	while (off < notes_sz) {
+		ret = parse_elf_note(bprm, notes, &off, notes_sz);
+		if (ret)
+			break;
+	}
+out:
+	kvfree(notes);
+	return ret;
+}
+
 /*
  * These are the functions used to load ELF style executables and shared
  * libraries.  There is no binary dependent code anywhere else.
@@ -801,6 +876,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	unsigned long error;
 	struct elf_phdr *elf_ppnt, *elf_phdata, *interp_elf_phdata = NULL;
 	struct elf_phdr *elf_property_phdata = NULL;
+	struct elf_phdr *elf_notes_phdata = NULL;
 	unsigned long elf_bss, elf_brk;
 	int bss_prot = 0;
 	int retval, i;
@@ -909,6 +985,10 @@ static int load_elf_binary(struct linux_binprm *bprm)
 				executable_stack = EXSTACK_DISABLE_X;
 			break;
 
+		case PT_NOTE:
+			elf_notes_phdata = elf_ppnt;
+			break;
+
 		case PT_LOPROC ... PT_HIPROC:
 			retval = arch_elf_pt_proc(elf_ex, elf_ppnt,
 						  bprm->file, false,
@@ -970,6 +1050,10 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	if (retval)
 		goto out_free_dentry;
 
+	retval = parse_elf_notes(bprm, elf_notes_phdata);
+	if (retval)
+		goto out_free_dentry;
+
 	/* Flush all traces of the currently running executable */
 	retval = begin_new_exec(bprm);
 	if (retval)
diff --git a/fs/exec.c b/fs/exec.c
index 1de09c4eef00..b2b046fec1f8 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1088,10 +1088,11 @@ static int vma_dup_some(struct mm_struct *old_mm, struct mm_struct *new_mm)
  * On success, this function returns with the mutex
  * exec_update_mutex locked.
  */
-static int exec_mmap(struct mm_struct *mm)
+static int exec_mmap(struct linux_binprm *bprm)
 {
 	struct task_struct *tsk;
 	struct mm_struct *old_mm, *active_mm;
+	struct mm_struct *mm = bprm->mm;
 	int ret;
 
 	/* Notify parent that we're no longer interested in the old VM */
@@ -1118,11 +1119,13 @@ static int exec_mmap(struct mm_struct *mm)
 			mutex_unlock(&tsk->signal->exec_update_mutex);
 			return -EINTR;
 		}
-		ret = vma_dup_some(old_mm, mm);
-		if (ret) {
-			mmap_read_unlock(old_mm);
-			mutex_unlock(&tsk->signal->exec_update_mutex);
-			return ret;
+		if (bprm->accepts_preserved_mem) {
+			ret = vma_dup_some(old_mm, mm);
+			if (ret) {
+				mmap_read_unlock(old_mm);
+				mutex_unlock(&tsk->signal->exec_update_mutex);
+				return ret;
+			}
 		}
 	}
 
@@ -1386,7 +1389,7 @@ int begin_new_exec(struct linux_binprm * bprm)
 	 * Release all of the old mmap stuff
 	 */
 	acct_arg_size(bprm, 0);
-	retval = exec_mmap(bprm->mm);
+	retval = exec_mmap(bprm);
 	if (retval)
 		goto out;
 
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 4a20b7517dd0..6a66589454c8 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -41,7 +41,12 @@ struct linux_binprm {
 		 * Set when errors can no longer be returned to the
 		 * original userspace.
 		 */
-		point_of_no_return:1;
+		point_of_no_return:1,
+		/*
+		 * Set if the binary being exec'd will accept memory marked
+		 * for preservation by the outgoing process.
+		 */
+		accepts_preserved_mem:1;
 #ifdef __alpha__
 	unsigned int taso:1;
 #endif
-- 
1.8.3.1

