Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA6D7AF9B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 06:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjI0Etg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 00:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjI0Esw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 00:48:52 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598CF4237
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Sep 2023 20:42:25 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6907e44665bso9118734b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Sep 2023 20:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695786145; x=1696390945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=psNe55NiIGmm2xWNk7Y7WSenoVYReQWIa41A35qkMTo=;
        b=DMgt7E8zbjdDxpmCg9lVKkaaMN5PJ8SCsJBHXx4/bPe0fcnr4RiVcettQb2AyiHLJt
         WRYfU4rkd/G3iLCuExCN+SdDhRs6JghrEnjQNd6OpCYRqQr8S4xGdKG/Uyo1piDLPEN4
         IKGkUT2o5cda7EDvkdd5tYH44m2IAQYre1fi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695786145; x=1696390945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=psNe55NiIGmm2xWNk7Y7WSenoVYReQWIa41A35qkMTo=;
        b=TBYtQxctxiFGxnU1DUeU55QgSqqQ+B0tT0HkdrBjjzLX7JQvVapXdbT/z4NaEYPO9F
         wAnd1T7iBtT+oOLXKnVZnzzSX9RQvQ28sPLyCxWWVTcTbnMU+npjwyyeb0LlthR2+W7F
         3ThnPEm+QdS4Q14ja+sMioF4dcCJ2EHFkogABeTJjgpbVt26y6IscMMpNyj1Mgkw820u
         NXB7FI3FmvG5ERXyiwbVwONS2yH1/JiyGajiZOpQj8tSo/7Psfdfku9Ca+MGWRsO4qKj
         0YQe7O4PICI1VTtFU5FR+K4sXHqc7K5aiG/Zct8gvS2+BmP+v7iHZpfGq0t3kYIKB6Ev
         N6cg==
X-Gm-Message-State: AOJu0YxEWQP8qIVhfBZv99JqD8izZKJ42y9HMXaytxnQ3PZlgUBxt9Z2
        AoDDpfl6jIaghR7svDFhNfvtIg==
X-Google-Smtp-Source: AGHT+IH5EAvrsjyvsdjMBX+hRb48/9Odz2jhGyduyLfeui8bYT0jgwoq8H4vxWQ8plZNKiKb1c39bg==
X-Received: by 2002:a05:6a00:1745:b0:690:3b59:cc7a with SMTP id j5-20020a056a00174500b006903b59cc7amr1223964pfc.23.1695786144630;
        Tue, 26 Sep 2023 20:42:24 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l21-20020a62be15000000b0068fe5a5a566sm11050779pff.142.2023.09.26.20.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 20:42:24 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Eric Biederman <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Pedro Falcato <pedro.falcato@gmail.com>,
        Sebastian Ott <sebott@redhat.com>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v3 4/4] binfmt_elf: Use elf_load() for interpreter
Date:   Tue, 26 Sep 2023 20:42:21 -0700
Message-Id: <20230927034223.986157-4-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927033634.make.602-kees@kernel.org>
References: <20230927033634.make.602-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2946; i=keescook@chromium.org;
 h=from:subject; bh=ESjAlwugvTKH54m807EA0V7P1zfqWIUst+9ebRisI1g=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlE6SdTC81Lo/IK1HXDqbNXd8+1ZQdNAkLqgYld
 ib+qt6Vsy+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZROknQAKCRCJcvTf3G3A
 JtadEACKjgl6qtJqAh0AMdgrhwl3xNt5d2qNuR5potUxETk/BXU7u2GTXYtP2F9RDpOrkDiKZgs
 kHaZ+K0S58tXoM1EESrVf9DgwoH2Yiu3a5Wnx/9cSLQ39gLchJc9iacJBevN5PWRNSQGhPINVHD
 ppnkc1dc2MgRLHRWccbGhLJoWY9ypb0+DB2+c326VYEE9A6ZcH0XF2mBBGZWXFdJf5FqvPjjP7d
 3aH1zRNKNI0RS4QKXR0yRxvLTkQu1CHaVV2EUyc2z8A2QyuQlLPUE/1Sndgz+rJf4zaBAGoUu15
 xtdsaw1/9QllvwqXSugoOkXpIIDx4n8QOYsgxRkRVM1a+KkJy54IQyjYj7yhw+IlJhX1NVUKiwd
 5TyNEMzi/OHgIlQ0Zx61x8PDB9FHITdRrPmmhjgmSMl5lVf/iutiyYsdRdW/udNxhJwecomGd+V
 FPKrzpAU5XCcgfQavEm4SC012nzVWQXMKBChSTYtRcchUfBI8yKMx0vBF3AUzEGnUxkenFTBZCX
 501e3882lR4jnNHar/3lok+SU91dFINJ79VHpEjsURQH5gylPvdbtX+i1nqijpI8fY16XKQPVsO
 A9WZlk3iYIvwmclIZazzIknfX61fR/qhvIhhre1iOr1xSWFFYOOhAzzXr+/bT6hmLGWrqrb36DM i6jNABcOoxu5qhA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Handle arbitrary memsz>filesz in interpreter ELF segments, instead of
only supporting it in the last segment (which is expected to be the
BSS).

Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
Reported-by: Pedro Falcato <pedro.falcato@gmail.com>
Closes: https://lore.kernel.org/lkml/20221106021657.1145519-1-pedro.falcato@gmail.com/
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/binfmt_elf.c | 46 +---------------------------------------------
 1 file changed, 1 insertion(+), 45 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index b939cfe3215c..74af5c8319a0 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -635,8 +635,6 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
 	struct elf_phdr *eppnt;
 	unsigned long load_addr = 0;
 	int load_addr_set = 0;
-	unsigned long last_bss = 0, elf_bss = 0;
-	int bss_prot = 0;
 	unsigned long error = ~0UL;
 	unsigned long total_size;
 	int i;
@@ -673,7 +671,7 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
 			else if (no_base && interp_elf_ex->e_type == ET_DYN)
 				load_addr = -vaddr;
 
-			map_addr = elf_map(interpreter, load_addr + vaddr,
+			map_addr = elf_load(interpreter, load_addr + vaddr,
 					eppnt, elf_prot, elf_type, total_size);
 			total_size = 0;
 			error = map_addr;
@@ -699,51 +697,9 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
 				error = -ENOMEM;
 				goto out;
 			}
-
-			/*
-			 * Find the end of the file mapping for this phdr, and
-			 * keep track of the largest address we see for this.
-			 */
-			k = load_addr + eppnt->p_vaddr + eppnt->p_filesz;
-			if (k > elf_bss)
-				elf_bss = k;
-
-			/*
-			 * Do the same thing for the memory mapping - between
-			 * elf_bss and last_bss is the bss section.
-			 */
-			k = load_addr + eppnt->p_vaddr + eppnt->p_memsz;
-			if (k > last_bss) {
-				last_bss = k;
-				bss_prot = elf_prot;
-			}
 		}
 	}
 
-	/*
-	 * Now fill out the bss section: first pad the last page from
-	 * the file up to the page boundary, and zero it from elf_bss
-	 * up to the end of the page.
-	 */
-	if (padzero(elf_bss, bss_prot)) {
-		error = -EFAULT;
-		goto out;
-	}
-	/*
-	 * Next, align both the file and mem bss up to the page size,
-	 * since this is where elf_bss was just zeroed up to, and where
-	 * last_bss will end after the vm_brk_flags() below.
-	 */
-	elf_bss = ELF_PAGEALIGN(elf_bss);
-	last_bss = ELF_PAGEALIGN(last_bss);
-	/* Finally, if there is still more bss to allocate, do it. */
-	if (last_bss > elf_bss) {
-		error = vm_brk_flags(elf_bss, last_bss - elf_bss,
-				bss_prot & PROT_EXEC ? VM_EXEC : 0);
-		if (error)
-			goto out;
-	}
-
 	error = load_addr;
 out:
 	return error;
-- 
2.34.1

