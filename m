Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39706FFEF5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 May 2023 04:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239544AbjELCZj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 May 2023 22:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbjELCZi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 May 2023 22:25:38 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA995276
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 May 2023 19:25:37 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba6939e78a0so10147740276.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 May 2023 19:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683858336; x=1686450336;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dVrdsQc/biAwpt188V4iZWfS19eaXCE07QPOY9kbdyc=;
        b=GQ8UVH9IygDETvgeENJQeoTFRl8IK6C71cn0eEf8SRe+fcNkVbogqZTEV5spZj3AYl
         QZY1fCTKrPPA3LJqQI2S73wLreGYzUHXWf6jF0T3V0Qu2J4n42ehYtbxn6HfNim8BzQ1
         XB9T4j5TtAct937a1GogPDZ/VyvmPySCrq9ascVSC6HrVysL7S+Dup0RfS+TdHzyffYu
         +BWPKv5kR//I9uGLkkmM1C3DClzHSfgrHLothXTbfzQ5CPksh3m7s891AsCXvqTXm/Y2
         A1ieQSQhQR+UsriiFUS5QNIen/0Zzln7A3aNqNaK8dDOFZlLywHR3jGaZiAOcllmGMaW
         5X+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683858336; x=1686450336;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dVrdsQc/biAwpt188V4iZWfS19eaXCE07QPOY9kbdyc=;
        b=lWBs0UchCpHkE87O1YCI+ARw9wkLw9er4Lbn7SFpj1QqObOfrda11xK9DOj/yTW/Kj
         N20Yn4jXDlHEx1nxpHUUtunbh+SvBG9jN6inO/MzGKRX8ujDYh9RZMU/AzjeIRuYV/wd
         JpL833NS34+s66tZANijgFVaDbb9H4OFA935ZgzXgrCpUqDlOzJkt7N/oRsp4H8LBODc
         DiEgJTfgA4GGSDvuzvzn69VUSmN5kVHRNQJ7OZMGJUGMlrNPoZqOsWjXrUqg1aZ+vUUM
         E9twfGLFeiRo2HrKTKtEis013cEWBU7YvQgONkk94Oh3tCEeRuYKG5X0kSlEKYfyNTCO
         Niwg==
X-Gm-Message-State: AC+VfDzQU79wMsHjYDoXZujnYnv8qMXaO9FpZzUVPIcekTb+WgKu9ssU
        pLsEEeElf3ChqQ78j2GW9H5R06XbozDO
X-Google-Smtp-Source: ACHHUZ6PjgAnQ4yHVTWsepQlN0qPo9uDN+LDYTHYcGjsv2wb8UltmdJTc0fhG08ccIWbq0MSRLcoxeq80x19
X-Received: from meowing-l.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3eba])
 (user=maskray job=sendgmr) by 2002:a05:690c:10c:b0:55c:a5db:869 with SMTP id
 bd12-20020a05690c010c00b0055ca5db0869mr19325168ywb.4.1683858336753; Thu, 11
 May 2023 19:25:36 -0700 (PDT)
Date:   Fri, 12 May 2023 02:25:28 +0000
Mime-Version: 1.0
Message-ID: <20230512022528.3430327-1-maskray@google.com>
Subject: [PATCH] coredump, vmcore: Set p_align to 4 for PT_NOTE
From:   Fangrui Song <maskray@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, linux-fsdevel@vger.kernel.org,
        kexec@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Tools like readelf/llvm-readelf use p_align to parse a PT_NOTE program
header as an array of 4-byte entries or 8-byte entries. Currently, there
are workarounds[1] in place for Linux to treat p_align==0 as 4. However,
it would be more appropriate to set the correct alignment so that tools
do not have to rely on guesswork. FreeBSD coredumps set p_align to 4 as
well.

[1]: https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=82ed9683ec099d8205dc499ac84febc975235af6
[2]: https://reviews.llvm.org/D150022
---
 fs/binfmt_elf.c       | 2 +-
 fs/binfmt_elf_fdpic.c | 2 +-
 fs/proc/vmcore.c      | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 1033fbdfdbec..44b4c42ab8e8 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1517,7 +1517,7 @@ static void fill_elf_note_phdr(struct elf_phdr *phdr, int sz, loff_t offset)
 	phdr->p_filesz = sz;
 	phdr->p_memsz = 0;
 	phdr->p_flags = 0;
-	phdr->p_align = 0;
+	phdr->p_align = 4;
 }
 
 static void fill_note(struct memelfnote *note, const char *name, int type,
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 05a1471d5283..d76ad3d4f676 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -1269,7 +1269,7 @@ static inline void fill_elf_note_phdr(struct elf_phdr *phdr, int sz, loff_t offs
 	phdr->p_filesz = sz;
 	phdr->p_memsz = 0;
 	phdr->p_flags = 0;
-	phdr->p_align = 0;
+	phdr->p_align = 4;
 	return;
 }
 
diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 03f5963914a1..cb80a7703d58 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -877,7 +877,7 @@ static int __init merge_note_headers_elf64(char *elfptr, size_t *elfsz,
 	phdr.p_offset  = roundup(note_off, PAGE_SIZE);
 	phdr.p_vaddr   = phdr.p_paddr = 0;
 	phdr.p_filesz  = phdr.p_memsz = phdr_sz;
-	phdr.p_align   = 0;
+	phdr.p_align   = 4;
 
 	/* Add merged PT_NOTE program header*/
 	tmp = elfptr + sizeof(Elf64_Ehdr);
@@ -1068,7 +1068,7 @@ static int __init merge_note_headers_elf32(char *elfptr, size_t *elfsz,
 	phdr.p_offset  = roundup(note_off, PAGE_SIZE);
 	phdr.p_vaddr   = phdr.p_paddr = 0;
 	phdr.p_filesz  = phdr.p_memsz = phdr_sz;
-	phdr.p_align   = 0;
+	phdr.p_align   = 4;
 
 	/* Add merged PT_NOTE program header*/
 	tmp = elfptr + sizeof(Elf32_Ehdr);
-- 
2.40.1.606.ga4b1b128d6-goog

