Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA9022CBEA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 19:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgGXRUb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 13:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgGXRUa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 13:20:30 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C30C0619D3
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2020 10:20:30 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id q7so6421428qtq.14
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2020 10:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IP2qzQ0kBQKVB32LO+oN88QxnZJT0sW8a2ViufOQFgg=;
        b=vHfiLahnORV8Mgzz/bB6y1WEWJGOiMoOdmyjw0j5lDyRuwUP6p0zp44Af9L9uhCx0j
         VUCeSS8G4lqXx4BxAPD7RVi87A155zHhlDCcZ6fkJ1kj8Otfn9ympj6TdEX09utbHa2v
         rivBFNYBSgFh4OopMGUgdlNq6pZBc3/pkru8DviJ9rgHvEK3p4xDhlURVfCTOdJ2hex1
         BIPNNLcg+9WZKZ7cxIeyZW4pDh1gb6VROcP9ULS0Wrt6dBlU0ZIjjnQIl/da44FHx4GA
         7LDU6+Df1krma+8qoX+MVawGkmU/XY1Ghc6ivIfamSAOxwg1mNDEbQu6nZG4i5ow/fhQ
         MOeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IP2qzQ0kBQKVB32LO+oN88QxnZJT0sW8a2ViufOQFgg=;
        b=HttBRaW7gIj/tgKSeNjPee7boW7obfSAGWldqATi2leic1WRniZNMTNeUPsn6DspHW
         1JYCw9/h+RCYW/JnbeEzAZDd71Q7ej4xxRzRZmFbPxGmBifxA4u9MDpdzWJ8lDGSTJuC
         sx64YUGTGYDoV9uZot6F4Ajg1hjUn8Z+nyzgLSUIu4jDv66WwbukMPlAZb+3fFBQe9OR
         4/okYrpBLGwA8YGC+se/F6XDamoCNFPqsCB5MsK76xgrxhIWCrDTbbMDHQFa9X/UADtx
         mb73eLrCLZXhM+GuXZwhiU2AeuilSyEqGr97buj9DNtpyfQ5IF2NMrfw71Yi/PpqOvNr
         GZEg==
X-Gm-Message-State: AOAM53332bZPM/7E05jjdIRa8WdbiJgelBEQXvenBitbP3wM6eXEG+dS
        WQpNEqN/5EkUHWAAhsH/3DaIN+YGPlfbgV0=
X-Google-Smtp-Source: ABdhPJyZThuJVZdmQqMDtzLbWwFTQjCM1XIfrvE9C7Og3e6GrQ5DsYrsRk+AFDkdpz9Tnf4eTL0jz4bGa0rvBhc=
X-Received: by 2002:ad4:424a:: with SMTP id l10mr10810463qvq.29.1595611229246;
 Fri, 24 Jul 2020 10:20:29 -0700 (PDT)
Date:   Fri, 24 Jul 2020 13:20:16 -0400
In-Reply-To: <20200724172016.608742-1-ckennelly@google.com>
Message-Id: <20200724172016.608742-2-ckennelly@google.com>
Mime-Version: 1.0
References: <20200724172016.608742-1-ckennelly@google.com>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH 1/1] fs/binfmt_elf: Use PT_LOAD p_align values for suitable
 start address.
From:   Chris Kennelly <ckennelly@google.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>,
        Song Liu <songliubraving@fb.com>,
        David Rientjes <rientjes@google.com>,
        Ian Rogers <irogers@google.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Chris Kennelly <ckennelly@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The current ELF loading mechancism provides page-aligned mappings.  This
can lead to the program being loaded in a way unsuitable for
file-backed, transparent huge pages when handling PIE executables.

Tested: verified program with -Wl,-z,max-page-size=0x200000 loading
Signed-off-by: Chris Kennelly <ckennelly@google.com>
---
 fs/binfmt_elf.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index f4713ea76e827..83fadf66d25ef 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -418,6 +418,25 @@ static int elf_read(struct file *file, void *buf, size_t len, loff_t pos)
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
@@ -883,6 +902,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		int elf_prot, elf_flags;
 		unsigned long k, vaddr;
 		unsigned long total_size = 0;
+		unsigned long alignment;
 
 		if (elf_ppnt->p_type != PT_LOAD)
 			continue;
@@ -960,6 +980,10 @@ static int load_elf_binary(struct linux_binprm *bprm)
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
2.28.0.rc0.105.gf9edc3c819-goog

