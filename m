Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9837B2A7E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 05:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbjI2DZB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 23:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbjI2DYv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 23:24:51 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203E51B2
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Sep 2023 20:24:43 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5859a7d6556so408964a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Sep 2023 20:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695957882; x=1696562682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1N2/5RenlXFMtuBqo/+f8Vcn16/Uj2Iw7MwFuqiNorY=;
        b=gHYyAdOoo9+Uq0fM+3FDoaZjk+aghJ6WPsGkXPszGftW8VjFFXzy5d93L9aLeFwAyd
         ni2RloEREBWicKL8qFOb2QZyUIzcTVsLW+9zzyU9fq5euZ9xVNh3PaRWTcV5nw//82Pq
         yL9rgN+tzJFgm0KSeoLGYfnpud/KR5kuELKag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695957882; x=1696562682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1N2/5RenlXFMtuBqo/+f8Vcn16/Uj2Iw7MwFuqiNorY=;
        b=QVRMp4aRPuRwcwE5DS11dx8R7z8Ae682r8lyxrkpVEThTpsDf4H9hhWc7VqT3W5jOT
         3Yc7GxLwrWWZHhv+qMv7Oc8flhNRTzm2iyykYapGYo7Hu5/XUlEaUvjEFQnhc4XQARv2
         dFmkEXi3r+edUHepmBCzcDv+UVJTlODDCCDqvXskXFT7bVnu+PCZO/ecaoCwY4wO7uy3
         M8drgYm4y5dbuVEOLDKrAPDZxjSwvsKAwLuW5NNrj0rt9doOu3ARoCgzakyGDLfAe4fC
         pK4mH6v/qeJveU+obalPfukR8+ibNBdtJ056rXWRo8ViVGTyHJ7YyPpVLabVPk5dTC8R
         nBqA==
X-Gm-Message-State: AOJu0Yx2JU+PgtXVu6PCsN0BwyWWFX82CuWKPgsjrpMk9IwiqqrtUbO5
        uSNsmerIQM0CLpJ2oPghFKSQ2A==
X-Google-Smtp-Source: AGHT+IFuiY5V1hPcrjWZ+wALbwRJ0bkGU805RDV1GGRAKG36PeI1WQG0N/Q94yXBG5u0guRkQHN2ew==
X-Received: by 2002:a05:6a21:6d90:b0:162:d056:9f52 with SMTP id wl16-20020a056a216d9000b00162d0569f52mr2317143pzb.14.1695957882509;
        Thu, 28 Sep 2023 20:24:42 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d12-20020a17090a498c00b0026b3ed37ddcsm297774pjh.32.2023.09.28.20.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 20:24:39 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Eric Biederman <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Sebastian Ott <sebott@redhat.com>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Pedro Falcato <pedro.falcato@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v4 5/6] binfmt_elf: Only report padzero() errors when PROT_WRITE
Date:   Thu, 28 Sep 2023 20:24:33 -0700
Message-Id: <20230929032435.2391507-5-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230929031716.it.155-kees@kernel.org>
References: <20230929031716.it.155-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3206; i=keescook@chromium.org;
 h=from:subject; bh=jt1fmczJcOormxbVcL/G+gA6YgAS2bIpzH9lxZKP6J8=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlFkNyRwIKy/9+p28ZJ729vcNHK8Gg7yPfE0ByN
 6nvj7/qVLeJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZRZDcgAKCRCJcvTf3G3A
 JjvTD/0efjaJu1+PNkM8NRGdk1dsGyZJ0dd4tY+8HW5FWR8J7niOASg788NVSLqFFUmdhaHRjmO
 Lj56b26Bw9GOyQXHYda5l7wqDTMXm6RIMUYBjTHTuUu3K8IYicpe/vidGvDuun74TWC6gT0TcQS
 JBtpkVYUzN9Quzlr+hjKY4YwSAMa+50O1SYTdUGqwmckLYkIpbbwVLAo7r/VX4KL73ojipa0uZL
 U4Z96HcimN4eOgUTJL+Z0t4VxznrtCujhN04154vNUcC1vzmWqEyPkrIaegDJh86UloTxqH/Esa
 mEVSbpK9HjAWKRRsvhfOPp2btfPm3150XfvwHXXipw4qVDOWOWYhb7tHCVoYriEG/H0nn5qroT1
 PIRndidx60sCNBiIR++8QGxeZhVypD2rtBlFMJYxk8hREnuCOUIUakD1s4SmYoqYAa/N6j10yfn
 USW7wazw7KE0x/SHGyklD7+FJFIHi/dFaGRXo6PdpXd2O8m/Fnh82Px9LxMZldJtVxrwmm2YcUb
 AIegTgqbd3pR1GCUvhncdf3yEUBwywr6llI4pfc2Bpc4oznxAVKNeJoY5hIrwCbXVKuO54wkBIg
 dP9Sl+hc6k26DlLVynWraFAeBWkU+QBlgtEZI18h+WBXWKlb9zkdhbKOcrAovas3JG4CcT3Onsb u68NsqyzQBTv3nw==
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

Errors with padzero() should be caught unless we're expecting a
pathological (non-writable) segment. Report -EFAULT only when PROT_WRITE
is present.

Additionally add some more documentation to padzero(), elf_map(), and
elf_load().

Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
Suggested-by: Eric Biederman <ebiederm@xmission.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/binfmt_elf.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index f8b4747f87ed..22027b0a5923 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -110,19 +110,19 @@ static struct linux_binfmt elf_format = {
 
 #define BAD_ADDR(x) (unlikely((unsigned long)(x) >= TASK_SIZE))
 
-/* We need to explicitly zero any fractional pages
-   after the data section (i.e. bss).  This would
-   contain the junk from the file that should not
-   be in memory
+/*
+ * We need to explicitly zero any trailing portion of the page that follows
+ * p_filesz when it ends before the page ends (e.g. bss), otherwise this
+ * memory will contain the junk from the file that should not be present.
  */
-static int padzero(unsigned long elf_bss)
+static int padzero(unsigned long address)
 {
 	unsigned long nbyte;
 
-	nbyte = ELF_PAGEOFFSET(elf_bss);
+	nbyte = ELF_PAGEOFFSET(address);
 	if (nbyte) {
 		nbyte = ELF_MIN_ALIGN - nbyte;
-		if (clear_user((void __user *) elf_bss, nbyte))
+		if (clear_user((void __user *)address, nbyte))
 			return -EFAULT;
 	}
 	return 0;
@@ -348,6 +348,11 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
 	return 0;
 }
 
+/*
+ * Map "eppnt->p_filesz" bytes from "filep" offset "eppnt->p_offset"
+ * into memory at "addr". (Note that p_filesz is rounded up to the
+ * next page, so any extra bytes from the file must be wiped.)
+ */
 static unsigned long elf_map(struct file *filep, unsigned long addr,
 		const struct elf_phdr *eppnt, int prot, int type,
 		unsigned long total_size)
@@ -387,6 +392,11 @@ static unsigned long elf_map(struct file *filep, unsigned long addr,
 	return(map_addr);
 }
 
+/*
+ * Map "eppnt->p_filesz" bytes from "filep" offset "eppnt->p_offset"
+ * into memory at "addr". Memory from "p_filesz" through "p_memsz"
+ * rounded up to the next page is zeroed.
+ */
 static unsigned long elf_load(struct file *filep, unsigned long addr,
 		const struct elf_phdr *eppnt, int prot, int type,
 		unsigned long total_size)
@@ -404,8 +414,12 @@ static unsigned long elf_load(struct file *filep, unsigned long addr,
 			zero_end = map_addr + ELF_PAGEOFFSET(eppnt->p_vaddr) +
 				eppnt->p_memsz;
 
-			/* Zero the end of the last mapped page */
-			padzero(zero_start);
+			/*
+			 * Zero the end of the last mapped page but ignore
+			 * any errors if the segment isn't writable.
+			 */
+			if (padzero(zero_start) && (prot & PROT_WRITE))
+				return -EFAULT;
 		}
 	} else {
 		map_addr = zero_start = ELF_PAGESTART(addr);
-- 
2.34.1

