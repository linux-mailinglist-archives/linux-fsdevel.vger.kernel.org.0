Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC60F24C431
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Aug 2020 19:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730476AbgHTRKC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Aug 2020 13:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730400AbgHTRGy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Aug 2020 13:06:54 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25654C061348
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Aug 2020 10:05:53 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id m88so1974356qtd.15
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Aug 2020 10:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Iv89Xj9r4G2AFHTvNFTUszt55oudaNNsbG7Jzt5MM3M=;
        b=JAoLsfvQ4br/TgUsmWn9DiWKTa+gHnJlRKDqSlFzX5V673qRD69mVU//vMYNLqeytr
         rhFyPscW3spdsfTlmOmV0nDCn+n1FekpqqrNOrpaPaUUDFPyK2yaaGgjnubuGAFXfgOZ
         4RN2pffxWbl/Vt9OuWgk4OiLFRcn+ZneSYLa3l8/scg3+pGjlXbiE0IEgtCx62jc46ib
         dtjdcsceajNguBonA3n67SB27pzahfP4nEEXTjzZUXBgq6Cze40JodWRpNDL1p68sZMo
         4pt1nbmOJkkOV9mUv901MxLQQu5ovydCHcUgt1ALfMQw7OjMdo6PynVY+OtkRA0EdKUh
         uRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Iv89Xj9r4G2AFHTvNFTUszt55oudaNNsbG7Jzt5MM3M=;
        b=BTRb16wZpqf1+I2Qv18/lYqRMAaZhS5E+vmoOd1Max0eWriLQMzIqvFWf/Kh8gfDZd
         k8tSyon3VoASC1qHNWn10lpM+dfjrOv00G2zh3ew9kQATO6qCFrKGzgTpc9rhuFI1hjD
         BicN0je29XZWKDhvRTVMHU1UgE2a4LRw2Q23INW6wcr+bAlPpLYQCZV5fiMZKPs6TFJS
         wcYCstvT0rnlwSGaMyvvhAA0skJgsp5bcqxQSdqHR6ZWFSLAWcyhXhV385pmseocWcqh
         B3hbHJ2yJOtyGLOJnuI+yNu8i9TovzUvkaHvGPJWQyEFqZ7tGW3ytIuKVuLEQjVT4wGT
         edhw==
X-Gm-Message-State: AOAM530ehCMlnMXB9L9WB0yoC+kH9EEobDkVWIPlcyLTrYF7WH2QQHLb
        18kOZNwWb1j7J89iHMZQ0PN9IyfEmnSWfXE=
X-Google-Smtp-Source: ABdhPJyAeDAmjp/cOMLYBlzKs+yr6QsVC8gvT2N9bGSimDFXyKsgrBOjYXHKDZ2UXbzrYoObhj6uF80NWOzZdd4=
X-Received: from ckennelly28.nyc.corp.google.com ([2620:0:1003:1003:3e52:82ff:fe5a:a91a])
 (user=ckennelly job=sendgmr) by 2002:a05:6214:1910:: with SMTP id
 er16mr3766114qvb.228.1597943152055; Thu, 20 Aug 2020 10:05:52 -0700 (PDT)
Date:   Thu, 20 Aug 2020 13:05:40 -0400
In-Reply-To: <20200820170541.1132271-1-ckennelly@google.com>
Message-Id: <20200820170541.1132271-2-ckennelly@google.com>
Mime-Version: 1.0
References: <20200820170541.1132271-1-ckennelly@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH v3 1/2] fs/binfmt_elf: Use PT_LOAD p_align values for suitable
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
 fs/binfmt_elf.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 13d053982dd73..a980dc3704639 100644
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
@@ -421,6 +422,24 @@ static int elf_read(struct file *file, void *buf, size_t len, loff_t pos)
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
+			if (!is_power_of_2(cmds[i].p_align))
+				continue;
+			alignment = max(alignment, cmds[i].p_align);
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
@@ -1086,6 +1106,9 @@ static int load_elf_binary(struct linux_binprm *bprm)
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

