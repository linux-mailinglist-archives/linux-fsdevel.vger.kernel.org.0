Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83F80234B36
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jul 2020 20:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387857AbgGaSiC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jul 2020 14:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387724AbgGaShu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jul 2020 14:37:50 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7BFC061757
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2020 11:37:49 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id h10so21648170qtc.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2020 11:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zM3dgZxHGwtay7ZIQFv5BfEN+wOLWmAIUQFsf0Z3VmM=;
        b=BFtthBoRgol9XG317wAbOOs8b3fmBcxnN4gRYza0RdTrAsjfH3ZwO3XGL+rCXTtCZ4
         F95dChkyhFDXLdpt1lGuZLUOpz/r7lH4pM472mxsHfNpc/YAhxPS2LG2Yt+AQ6vUZ2nG
         q5dzLReYFQw5ZNt5VCCiKG17ZCMVs/5OIqgITys2e16+h7LA4NQIZwXcOZ0bigIsBn43
         +hhYBgkK4U4pdRnEEpP6mgN4dvfKgzuUt4el9T0LEdioVrYohOwN2cJQNc8pPqKzjug+
         VyEi2Q1pRgqkXgNvd5yQrTrhhaMy8Yx/AjjGaDTZlgqlfKP84hr5gHxIP7NHpi3Z8pzv
         ek+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zM3dgZxHGwtay7ZIQFv5BfEN+wOLWmAIUQFsf0Z3VmM=;
        b=P2g83WUS8C2HQyWZcr5l7oZ350MVcNVOBk5vxHAIEzQnNw3W51Vg1S4HBKwS34Pow/
         OvgbfBMGEx6hknzRg2k2BvZaXgY92k8GHeypVeX17dSO6cawU5//bexIx2T9m+rY2NEs
         dsWv6XqpUx72hMXD1bQNDSZOTeu+DkdIcQWAhi54L2oq8iiD5z7DXiGk5MPzieZPXOI7
         JKtHSSVg2VOxQ9lBXmdjDnrats0kKmEH6Krh5+c4NTU/m0s9jP49MzkUXoqB3v1AqFpK
         iQq/aTGUFDvUqIL9A3WZjynkwmBk0ahY/tt96ZnTsukofyJyCYNbYUjjSQduuEBD0dz3
         NmMA==
X-Gm-Message-State: AOAM533x91AvpKVQKyyHR1XdTX8fYTO380hKCBsImVdFJvTxloXtrqI5
        XaeWzIGb130eEENQI8HFBwD+5HKSKlBzrVA=
X-Google-Smtp-Source: ABdhPJw4wK2solpSAa9OS8kiQw3oru0YdaMJ2eowgQYyITB1BZNtnL6yi4fCRgDUasoEcAIU5TCh2fggQDEOMMY=
X-Received: by 2002:a0c:fa85:: with SMTP id o5mr5404015qvn.91.1596220669093;
 Fri, 31 Jul 2020 11:37:49 -0700 (PDT)
Date:   Fri, 31 Jul 2020 14:37:43 -0400
In-Reply-To: <20200731183745.1669355-1-ckennelly@google.com>
Message-Id: <20200731183745.1669355-2-ckennelly@google.com>
Mime-Version: 1.0
References: <20200731183745.1669355-1-ckennelly@google.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH 1/2 v2] fs/binfmt_elf: Use PT_LOAD p_align values for suitable
 start address.
From:   Chris Kennelly <ckennelly@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Song Liu <songliubraving@fb.com>
Cc:     David Rientjes <rientjes@google.com>,
        Ian Rogers <irogers@google.com>,
        Hugh Dickens <hughd@google.com>,
        Andrew Morton <akpm@google.com>,
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
 fs/binfmt_elf.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 9fe3b51c116a6..24e80302b497d 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -421,6 +421,25 @@ static int elf_read(struct file *file, void *buf, size_t len, loff_t pos)
 	return 0;
 }
 
+static unsigned long maximum_alignment(struct elf_phdr *cmds, int nr)
+{
+	unsigned long alignment = 0;
+	int i;
+
+	for (i = 0; i < nr; i++) {
+		if (cmds[i].p_type == PT_LOAD) {
+			/* skip non-power of two alignments */
+			if (cmds[i].p_align & (cmds[i].p_align - 1))
+				continue;
+			if (cmds[i].p_align > alignment)
+				alignment = cmds[i].p_align;
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
@@ -1008,6 +1027,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		int elf_prot, elf_flags;
 		unsigned long k, vaddr;
 		unsigned long total_size = 0;
+		unsigned long alignment;
 
 		if (elf_ppnt->p_type != PT_LOAD)
 			continue;
@@ -1086,6 +1106,10 @@ static int load_elf_binary(struct linux_binprm *bprm)
 				load_bias = ELF_ET_DYN_BASE;
 				if (current->flags & PF_RANDOMIZE)
 					load_bias += arch_mmap_rnd();
+				alignment = maximum_alignment(
+					elf_phdata, elf_ex->e_phnum);
+				if (alignment)
+					load_bias &= ~(alignment - 1);
 				elf_flags |= MAP_FIXED;
 			} else
 				load_bias = 0;
-- 
2.28.0.163.g6104cc2f0b6-goog

