Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2C87B2A7D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 05:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbjI2DY6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 23:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbjI2DYo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 23:24:44 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA471AB
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Sep 2023 20:24:40 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-7742da399a2so624677985a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Sep 2023 20:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695957880; x=1696562680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7JCtI6Mw9jLbpCfzTWeYqaol0MCiq7teZQqSoN5bxO4=;
        b=PAEZ/ez4XM+Nfd7IxqcYrATv76QfWiEkrKWgea+lJzL31QWfywvX55Hr196SMSWJv2
         H+tdJI+HyacXvcIeNp6Xwg12Gxfp9T1WzOP7CBBIDiCRmh3z9klBb8Zqmb62ID6ugxzS
         /Bxt6UgTKJOkP4uKTqSctiHKw+9ZTNqwBg3ts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695957880; x=1696562680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7JCtI6Mw9jLbpCfzTWeYqaol0MCiq7teZQqSoN5bxO4=;
        b=QxuVWqAX/Tjg+eIxKWt56vjlc8HjvzyMLx8u1hEOlWUrfwG3BZbQA8ri5usSSm9Hbt
         4wkRGyqcHm9O1WzIDBq/zBaQeXvj9oQwfVqbHhLRwfdyWo+vrrkMHf1fV8njVliEeAmC
         wLltO1UYvReVt/0sHwECz6LxxwhVEiOxHYHdLt7sLQaB+UallguyjaBFETzS+EgmaAX0
         YR/mQiuqR1rhqBeroQGGmicmcliWTDWegtVDlghlMR9C/jSzE564LccQV3VuLWHxeMDC
         H7OH1ZmkvSiw6X7rHoAogwRH7jsBAF/itax0+xpGO9XX1xHCUpvfboP5HTWZ8wmSdEc1
         uwzg==
X-Gm-Message-State: AOJu0YzAcQ5OO4/ORPMHA2cAMf2IArjGdKHFMwIzL+ZoLDTpVETeVToJ
        2XdtaSCMp+a27c5uuafNuzi8+g==
X-Google-Smtp-Source: AGHT+IELcqZMMKb1td/vncjB5sH12I54PHU5TdsvQyhNwOMv+fB/QBhAjEGhxQYK020wITjebfX9sQ==
X-Received: by 2002:a05:620a:e9d:b0:772:6443:daf3 with SMTP id w29-20020a05620a0e9d00b007726443daf3mr2738735qkm.66.1695957879917;
        Thu, 28 Sep 2023 20:24:39 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id du14-20020a056a002b4e00b00690fe1c928esm10256201pfb.91.2023.09.28.20.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 20:24:36 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Eric Biederman <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Pedro Falcato <pedro.falcato@gmail.com>,
        Sebastian Ott <sebott@redhat.com>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v4 3/6] binfmt_elf: Use elf_load() for interpreter
Date:   Thu, 28 Sep 2023 20:24:31 -0700
Message-Id: <20230929032435.2391507-3-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230929031716.it.155-kees@kernel.org>
References: <20230929031716.it.155-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2936; i=keescook@chromium.org;
 h=from:subject; bh=8mN64ZnApkL7mlS3J3j8M/PeeHjiU24xpvEFIwO52Sc=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlFkNyQ5p5E4Tg789OjEFFGvDw6hy8O/CboaqJO
 +gn/YtsP02JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZRZDcgAKCRCJcvTf3G3A
 JlfrD/0UmFIiwvqM26CPsRIStoMfmoWWLE+1T0+B6VIpoHHYl6fxgrYIk1GMjuaGbD0RwF9QP+t
 BqcWROGSbE7jtsk5rW33lmv5P4kATjv1E8P0xTh6YLwy/qmxm1iBcqH7A7aIp5rT/ZZxmRWS7z/
 KaumFG9s9XzIzz7vNtyCpYAslNBn7Ct0D760d/KdyUyF0tRcwUZGbbqsCSJ3qDlqi9Oh48d8rqr
 zVrOdBbcoN0GFz2NFhwg1g0iypiVC72gYNSKuCVuYoSflzMWmk+MWWz+KoGHh8QQyufk09tUrRt
 7e7QzVJPtxRfKGiVSBnbT7mPxw87BCa7B1z+sX5Sj7D4++z7rbKsnwJGiOeSn9hRsn3zwU/bHKg
 2VugFFQ+5/llgN3z58QGPu56dO6ydWYCZeneBcrQoNc1xhZyz8M2IpA5m0iJS719hxg22R2fW1p
 xaQITu1kMm0y6BxdReD/XHhw3eM0HzXWV9ltG8nLrJXOVz5Ve3z1wcEusMGPOh07NsX6dEfXDJv
 XYtMF21/+UxnZ3eYxaWMHimE+Qo2DtB694DxSqJhwRK4FB4KUShHOAsbSQTcGSzXCx13gP3vhF0
 S8eSoWkYBz90zkFWSPCcyq4F9jfXjVmVgHQgU/leUKWz2vDzeEVdmX04CQNaCQPS6MFWyGJaKml bTMeDeMtwCCfvfQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 0214d5a949fc..db47cb802f89 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -622,8 +622,6 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
 	struct elf_phdr *eppnt;
 	unsigned long load_addr = 0;
 	int load_addr_set = 0;
-	unsigned long last_bss = 0, elf_bss = 0;
-	int bss_prot = 0;
 	unsigned long error = ~0UL;
 	unsigned long total_size;
 	int i;
@@ -660,7 +658,7 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
 			else if (no_base && interp_elf_ex->e_type == ET_DYN)
 				load_addr = -vaddr;
 
-			map_addr = elf_map(interpreter, load_addr + vaddr,
+			map_addr = elf_load(interpreter, load_addr + vaddr,
 					eppnt, elf_prot, elf_type, total_size);
 			total_size = 0;
 			error = map_addr;
@@ -686,51 +684,9 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
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
-	if (padzero(elf_bss)) {
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

