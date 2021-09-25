Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFBD3418380
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Sep 2021 19:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbhIYRRN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Sep 2021 13:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbhIYRRM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Sep 2021 13:17:12 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5A1C061570;
        Sat, 25 Sep 2021 10:15:38 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id 145so11687757pfz.11;
        Sat, 25 Sep 2021 10:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/ndZDpgXoGYSrMIqwsoxI/qJvS1PzxSuaEBYmEb4KVo=;
        b=KKN8Jc0M40Pzm1dDZFmxGXXuCzenuh3pOcv4QB/RUYl7m/gbTNFqHQ3FERVdwdTHMt
         2Gd/IMJX7NJXNlWjmUbnVnPR90BkgJCMwR/tF7QvNdKLndFokY1j/UJcqey1DkcGWOpF
         MkROw1lsUdpazQ20cIYYk0aCSHPbmxmU2blcLMqN9j/70ZjXVbH/WEZSZUDD8gf1vMHe
         Y6GADEIXTqgWgAr9tQkjm78/nGqN2fZ7E6Ch1GomkMzYx2QYlPYPovONniVFuonvpTaI
         ICJz9tsCQGGCPrCCncy0uR/O0g9VmcqU/k6xM3vp181MWi3DC3tt3kycCWe1o17Z3Dmg
         nWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/ndZDpgXoGYSrMIqwsoxI/qJvS1PzxSuaEBYmEb4KVo=;
        b=5GbUNE2uV7iqCXwhU85bweEN1lq5uxY/704nXrse4G2x12OxPlDgfca7u28uPfauTU
         bTdznbK/Ng2Wxf7v5AkI3jcYy+XkL9/wYD1e51WHgYxwmvHy3sPRYT44oWzu7BhHNps0
         9bY+Bx4TZz/27quIiwueCVwsUSQ5CR1speeV33kBH8oR4bLm/AXnrLTi70PdVd8G9SMp
         1DkPy4nOVCgT0d4m94Jpu1eEsa+tbQxz2m2J2QV3jx/y5kpbrfUbafQydx2cKcX4DcFp
         EtGXGWwBu3LX4IFuEVqnDyFLlLlwSOaffWTY4B7q2OlA4p++zPBhQGQ2r30ozoyanWmh
         eYoA==
X-Gm-Message-State: AOAM530Wh8LW4OCiAPSgdUwHcfLwmFTq+C8b8FloMHndj1vqSdsV8iWU
        pSvhSJzuDLt8QVJpzCKIeGg=
X-Google-Smtp-Source: ABdhPJw7dhLBbS1XFa4U5Nd+vFm5UT4EmDcklnYQv+NTzqULnCPEFZlhkayID6fB/LismB7Wnr9TFA==
X-Received: by 2002:aa7:980a:0:b0:43e:670:8505 with SMTP id e10-20020aa7980a000000b0043e06708505mr15292333pfl.74.1632590137517;
        Sat, 25 Sep 2021 10:15:37 -0700 (PDT)
Received: from nuc10.aws.cis.local (d50-92-229-34.bchsia.telus.net. [50.92.229.34])
        by smtp.gmail.com with ESMTPSA id s90sm14901299pjd.12.2021.09.25.10.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Sep 2021 10:15:37 -0700 (PDT)
From:   Rustam Kovhaev <rkovhaev@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, binutils@sourceware.org,
        gdb-patches@sourceware.org, Rustam Kovhaev <rkovhaev@gmail.com>
Subject: [RFC][PATCH] coredump: save timestamp in ELF core
Date:   Sat, 25 Sep 2021 10:15:07 -0700
Message-Id: <20210925171507.1081788-1-rkovhaev@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Alexander and linux-fsdevel@,

I would like to propose saving a new note with timestamp in core file.
I do not know whether this is a good idea or not, and I would appreciate
your feedback.

Sometimes (unfortunately) I have to review windows user-space cores in
windbg, and there is one feature I would like to have in gdb.
In windbg there is a .time command that prints timestamp when core was
taken.

This might sound like a fixed problem, kernel's core_pattern can have
%t, and there are user-space daemons that write timestamp in the
report/journal file (apport/systemd-coredump), and sometimes it is
possible to correctly guess timestamp from btime/mtime file attribute,
and all of the above does indeed solve the problem most of the time.

But quite often, especially while researching hangs and not crashes,
when dump is written by gdb/gcore, I get only core.PID file and some
application log for research and there is no way to figure out when
exactly the core was taken.

I have posted a RFC patch to gdb-patches too [1] and I am copying
gdb-patches@ and binutils@ on this RFC.
Thank you!

[1] https://sourceware.org/pipermail/gdb-patches/2021-July/181163.html

Signed-off-by: Rustam Kovhaev <rkovhaev@gmail.com>
---
 fs/binfmt_elf.c          | 30 ++++++++++++++++++++++++++++++
 include/uapi/linux/elf.h |  1 +
 2 files changed, 31 insertions(+)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 69d900a8473d..f54ada303959 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1594,6 +1594,18 @@ static void fill_siginfo_note(struct memelfnote *note, user_siginfo_t *csigdata,
 	fill_note(note, "CORE", NT_SIGINFO, sizeof(*csigdata), csigdata);
 }
 
+static int fill_time_note(struct memelfnote *note)
+{
+	time64_t *time;
+
+	time = kvmalloc(sizeof(*time), GFP_KERNEL);
+	if (ZERO_OR_NULL_PTR(time))
+		return -ENOMEM;
+	*time = ktime_get_real_seconds();
+	fill_note(note, "CORE", NT_TIME, sizeof(*time), time);
+	return 0;
+}
+
 #define MAX_FILE_NOTE_SIZE (4*1024*1024)
 /*
  * Format of NT_FILE note:
@@ -1704,6 +1716,7 @@ struct elf_note_info {
 	struct memelfnote signote;
 	struct memelfnote auxv;
 	struct memelfnote files;
+	struct memelfnote time;
 	user_siginfo_t csigdata;
 	size_t size;
 	int thread_notes;
@@ -1877,6 +1890,9 @@ static int fill_note_info(struct elfhdr *elf, int phdrs,
 	if (fill_files_note(&info->files) == 0)
 		info->size += notesize(&info->files);
 
+	if (fill_time_note(&info->time) == 0)
+		info->size += notesize(&info->time);
+
 	return 1;
 }
 
@@ -1910,6 +1926,9 @@ static int write_note_info(struct elf_note_info *info,
 		if (first && info->files.data &&
 				!writenote(&info->files, cprm))
 			return 0;
+		if (first && info->time.data &&
+				!writenote(&info->time, cprm))
+			return 0;
 
 		for (i = 1; i < info->thread_notes; ++i)
 			if (t->notes[i].data &&
@@ -1937,6 +1956,7 @@ static void free_note_info(struct elf_note_info *info)
 	}
 	kfree(info->psinfo.data);
 	kvfree(info->files.data);
+	kvfree(info->time.data);
 }
 
 #else
@@ -1984,6 +2004,7 @@ static int elf_dump_thread_status(long signr, struct elf_thread_status *t)
 struct elf_note_info {
 	struct memelfnote *notes;
 	struct memelfnote *notes_files;
+	struct memelfnote *note_time;
 	struct elf_prstatus *prstatus;	/* NT_PRSTATUS */
 	struct elf_prpsinfo *psinfo;	/* NT_PRPSINFO */
 	struct list_head thread_list;
@@ -2074,6 +2095,12 @@ static int fill_note_info(struct elfhdr *elf, int phdrs,
 	if (info->prstatus->pr_fpvalid)
 		fill_note(info->notes + info->numnote++,
 			  "CORE", NT_PRFPREG, sizeof(*info->fpu), info->fpu);
+
+	if (fill_time_note(info->notes + info->numnote) == 0) {
+		info->note_time = info->notes + info->numnote;
+		info->numnote++;
+	}
+
 	return 1;
 }
 
@@ -2122,6 +2149,9 @@ static void free_note_info(struct elf_note_info *info)
 	if (info->notes_files)
 		kvfree(info->notes_files->data);
 
+	if (info->note_time)
+		kvfree(info->note_time->data);
+
 	kfree(info->prstatus);
 	kfree(info->psinfo);
 	kfree(info->notes);
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index 61bf4774b8f2..e9256b8b8da9 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -375,6 +375,7 @@ typedef struct elf64_shdr {
 #define NT_PRPSINFO	3
 #define NT_TASKSTRUCT	4
 #define NT_AUXV		6
+#define NT_TIME		9
 /*
  * Note to userspace developers: size of NT_SIGINFO note may increase
  * in the future to accomodate more fields, don't assume it is fixed!
-- 
2.30.2

