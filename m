Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 511E724E3F1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Aug 2020 01:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgHUXi7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 19:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbgHUXiz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 19:38:55 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DAE9C061755
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 16:38:55 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id b1so2413320qto.17
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 16:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=wTTHOHLUpSJsOh9SXDMCY9S+w0wdFVpDu5cnszimX/A=;
        b=tLmds5awKD+FJoYN96kwnKij9GFM/pG0TOWm3XWwY7RIPcUjATUDrfyrJrQHJCIuzC
         1XkCFnYfVOwG4ca9Ki81zRk1PhWizTWjfLzpUDIPranMwe2BF7S7EkBFFJOPFd4Fsowu
         mI5rukKBOLTTHJ4/nYEbTb880O4uHKMJEgSXs3YGPYNRJX05+3Nt942vNchy7zJ9wRCQ
         AHQPoZRCMKnAF7feD2eHbZyckVSJJNYAXEC1gJLDzthOagDsvKQweXy0SYabreDRZB8u
         RQfpslAk12zxgl0x4N4FK0656RUYGMeudH2TuA63k+nFdKUF0RsEKAtOhy/2bPsy54B1
         N87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wTTHOHLUpSJsOh9SXDMCY9S+w0wdFVpDu5cnszimX/A=;
        b=MpsILJVEzLWsk8M8qAuVpqw9oiVje4EvlVGzwukYmu2g7XnpZedikWcuWt4Q9+6aZD
         sa+ZSVkNx3fV1N+aFeD7iQGqzvNAXMPIGPnMfJuvpow6MVjy/1VsScLXURHEWSHb5v0O
         DbkFa6PUPbxUEbC5TedmmPHIsIm0S9k50GlRJAq6FUvKqF2YVcJ1Ysd2dgPzxrN8+nvm
         O4vDlvU2z856X/+Fe3s6I1ay5JhjyAvcgcZUAZmkVAqKk0zas6beiOGpl3KYpCFEMnO/
         YCPAXDOCiFuTy7aq+vjBRBXeJqNIUP9vi51obS+1+KfnANok3nBWnK+9yRhkkLuKSOX+
         kvqA==
X-Gm-Message-State: AOAM5318C+c91F3+OaeSw52OyQ6Q5Agb05FJQHjtf9/iayric7NK227E
        /OUSrTuIjdTYrUbZ0QF13r/mtUJgZ7rmIaw=
X-Google-Smtp-Source: ABdhPJy4/FIHmfbB1ei2uKSt3zT5fgTFGlHdwFHL+MIq3vrWnFAajV1NZ4y5+CZc6pq3XXE0PYqMN2s1gQsfAUc=
X-Received: from ckennelly28.nyc.corp.google.com ([2620:0:1003:1003:3e52:82ff:fe5a:a91a])
 (user=ckennelly job=sendgmr) by 2002:a05:6214:184b:: with SMTP id
 d11mr4672334qvy.21.1598053133560; Fri, 21 Aug 2020 16:38:53 -0700 (PDT)
Date:   Fri, 21 Aug 2020 19:38:47 -0400
In-Reply-To: <20200821233848.3904680-1-ckennelly@google.com>
Message-Id: <20200821233848.3904680-2-ckennelly@google.com>
Mime-Version: 1.0
References: <20200821233848.3904680-1-ckennelly@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH v4 1/2] fs/binfmt_elf: Use PT_LOAD p_align values for suitable
 start address.
From:   Chris Kennelly <ckennelly@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Song Liu <songliubraving@fb.com>
Cc:     David Rientjes <rientjes@google.com>,
        Ian Rogers <irogers@google.com>,
        Hugh Dickens <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Fangrui Song <maskray@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chris Kennelly <ckennelly@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The current ELF loading mechancism provides page-aligned mappings.  This
can lead to the program being loaded in a way unsuitable for
file-backed, transparent huge pages when handling PIE executables.

For binaries built with increased alignment, this limits the number of
bits usable for ASLR, but provides some randomization over using fixed
load addresses/non-PIE binaries.

Tested: verified program with -Wl,-z,max-page-size=0x200000 loading
Signed-off-by: Chris Kennelly <ckennelly@google.com>
---
 fs/binfmt_elf.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 13d053982dd73..96370e3e36872 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/fs.h>
+#include <linux/log2.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
 #include <linux/errno.h>
@@ -421,6 +422,26 @@ static int elf_read(struct file *file, void *buf, size_t len, loff_t pos)
 	return 0;
 }
 
+static unsigned long maximum_alignment(struct elf_phdr *cmds, int nr)
+{
+	unsigned long alignment = 0;
+	int i;
+
+	for (i = 0; i < nr; i++) {
+		if (cmds[i].p_type == PT_LOAD) {
+			unsigned long p_align = cmds[i].p_align;
+
+			/* skip non-power of two alignments as invalid */
+			if (!is_power_of_2(p_align))
+				continue;
+			alignment = max(alignment, p_align);
+		}
+	}
+
+	/* ensure we align to at least one page */
+	return ELF_PAGEALIGN(alignment);
+}
+
 /**
  * load_elf_phdrs() - load ELF program headers
  * @elf_ex:   ELF header of the binary whose program headers should be loaded
@@ -1008,6 +1029,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		int elf_prot, elf_flags;
 		unsigned long k, vaddr;
 		unsigned long total_size = 0;
+		unsigned long alignment;
 
 		if (elf_ppnt->p_type != PT_LOAD)
 			continue;
@@ -1086,6 +1108,9 @@ static int load_elf_binary(struct linux_binprm *bprm)
 				load_bias = ELF_ET_DYN_BASE;
 				if (current->flags & PF_RANDOMIZE)
 					load_bias += arch_mmap_rnd();
+				alignment = maximum_alignment(elf_phdata, elf_ex->e_phnum);
+				if (alignment)
+					load_bias &= ~(alignment - 1);
 				elf_flags |= MAP_FIXED;
 			} else
 				load_bias = 0;
-- 
2.28.0.297.g1956fa8f8d-goog

