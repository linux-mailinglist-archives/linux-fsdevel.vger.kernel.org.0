Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B31625488
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Nov 2022 08:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbiKKHmn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Nov 2022 02:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233065AbiKKHmm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Nov 2022 02:42:42 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEB6748C5
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Nov 2022 23:42:40 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id d13-20020a17090a3b0d00b00213519dfe4aso4060701pjc.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Nov 2022 23:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DPlfHwSzNGfVHYFsMHE3q3XKtrEblxpPMeiSWifb33g=;
        b=M/tZlkQud5ba+2P9ogVpn++cTNC01PLRW0GjC9txFQf7MuZhwIJCk/ePeLQDSH1jqB
         ZN1h9AYoJriAQ8AZXELGghXus+BQgjW1r1wI5XaSaaSqgV9Av10rBZ6rbqL/RmYT/RlB
         HiN7umoR3s7s4zWOnO8f3vI9SKPm6HA56FVSLVY7RLb5udjWmAZ2hTbpZsGqgJQR7l9w
         ShqHDZca4tc1Hx8SLQPJnemY+17GR2xmWW0EZFAmtWXAHxTQzdnME9rwzZg2rxoDS+Oq
         62X4GrGE08o8N+1x9ud7dP4+jAT1WQkrcKqk21higRwdUfbv4m4ikDW8iO0TPw/BipH3
         HZ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DPlfHwSzNGfVHYFsMHE3q3XKtrEblxpPMeiSWifb33g=;
        b=781pjm4Xlikj3oFDE0cvzJnV/9jfGc/nuP2oVIDqq3fluXao8qhIRQwXJJBNDTnL/q
         VxMbRURnoNcgrj7EccmLboJP/Magh+BiyYFVUO+sQELfzQZLyqa4ZMs7QobEsSwj0wVQ
         QEBueMh3vLsgtQJNi/U60pxpkd9Of248xhqQJ/JVGopQJGXltQ8pnXdgv+94V5sokkp9
         Dl2TIFgrr1RogqlI0uMnk8tc9Rw6mfsxajKP3S5bKZfc3z8pqxdAu2BFrREulomxj6l+
         VRimipwGMimVUIWKtJWvd2rvfMxK+qI3EsrZK0hX9Za28AK1U2g5F4mhpZnunHYxoogI
         E/GA==
X-Gm-Message-State: ANoB5pmJqGQlXIGKUHz1oqVzmwJ7Q6k6V26+hYetKTtzkCFGP790320m
        2E/KTKtAh0gA76YUzS/DopTRng==
X-Google-Smtp-Source: AA0mqf75V+bKI3ndKFyRxVswKPnmqWnx1L92m9PZ4Nivy5nTo/hpytzrCxBKysGgwJDsN+cPBetHfw==
X-Received: by 2002:a17:902:e013:b0:186:9b23:a112 with SMTP id o19-20020a170902e01300b001869b23a112mr1531311plo.15.1668152559788;
        Thu, 10 Nov 2022 23:42:39 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:8b77:5448:ea74:27a])
        by smtp.gmail.com with ESMTPSA id z35-20020a631923000000b0043a1c0a0ab1sm799275pgl.83.2022.11.10.23.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 23:42:38 -0800 (PST)
Date:   Thu, 10 Nov 2022 23:42:34 -0800
From:   Fangrui Song <maskray@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Pedro Falcato <pedro.falcato@gmail.com>,
        Rich Felker <dalias@libc.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>, sam@gentoo.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] binfmt_elf: Allow .bss in any interp PT_LOAD
Message-ID: <20221111074234.xm5a6ota7ppdsto5@google.com>
References: <20221111061315.gonna.703-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20221111061315.gonna.703-kees@kernel.org>
X-Spam-Status: No, score=-15.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLACK,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

(+ sam@gentoo.org from Pedro Falcato's patch)

On 2022-11-10, Kees Cook wrote:
>Traditionally, only the final PT_LOAD for load_elf_interp() supported
>having p_memsz > p_filesz. Recently, lld's construction of musl's
>libc.so on PowerPC64 started having two PT_LOAD program headers with
>p_memsz > p_filesz.
>
>As the least invasive change possible, check for p_memsz > p_filesz for
>each PT_LOAD in load_elf_interp.
>
>Reported-by: Rich Felker <dalias@libc.org>
>Link: https://maskray.me/blog/2022-11-05-lld-musl-powerpc64
>Cc: Pedro Falcato <pedro.falcato@gmail.com>
>Cc: Fangrui Song <maskray@google.com>
>Cc: Alexander Viro <viro@zeniv.linux.org.uk>
>Cc: Eric Biederman <ebiederm@xmission.com>
>Cc: linux-fsdevel@vger.kernel.org
>Cc: linux-mm@kvack.org
>Signed-off-by: Kees Cook <keescook@chromium.org>
>---
>v2: I realized we need to retain the final padding call.
>v1: https://lore.kernel.org/linux-hardening/20221111055747.never.202-kees@kernel.org/
>---
> fs/binfmt_elf.c | 18 ++++++++++++++----
> 1 file changed, 14 insertions(+), 4 deletions(-)
>
>diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
>index 528e2ac8931f..0a24bbbef1d6 100644
>--- a/fs/binfmt_elf.c
>+++ b/fs/binfmt_elf.c
>@@ -673,15 +673,25 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
> 				last_bss = k;
> 				bss_prot = elf_prot;
> 			}
>+
>+			/*
>+			 * Clear any p_memsz > p_filesz area up to the end
>+			 * of the page to wipe anything left over from the
>+			 * loaded file contents.
>+			 */
>+			if (last_bss > elf_bss && padzero(elf_bss))

Missing {

But after fixing this, I get a musl ld.so error.

>+				error = -EFAULT;
>+				goto out;
>+			}
> 		}
> 	}
>
> 	/*
>-	 * Now fill out the bss section: first pad the last page from
>-	 * the file up to the page boundary, and zero it from elf_bss
>-	 * up to the end of the page.
>+	 * Finally, pad the last page from the file up to the page boundary,
>+	 * and zero it from elf_bss up to the end of the page, if this did
>+	 * not already happen with the last PT_LOAD.
> 	 */
>-	if (padzero(elf_bss)) {
>+	if (last_bss == elf_bss && padzero(elf_bss)) {
> 		error = -EFAULT;
> 		goto out;
> 	}
>-- 
>2.34.1
>

I added a new section to https://maskray.me/blog/2022-11-05-lld-musl-powerpc64
Copying here:

To test that the kernel ELF loader can handle more RW `PT_LOAD` program headers, we can create an executable with more RW `PT_LOAD` program headers with `p_filesz < p_memsz`.
We can place a read-only section after `.bss` followed by a `SHT_NOBITS` `SHF_ALLOC|SHF_WRITE` section. The read-only section will form a read-only `PT_LOAD` while the RW section will form a RW `PT_LOAD`.

```text
#--- a.c
#include <assert.h>
#include <stdio.h>

extern const char toc[];
char nobits0[0] __attribute__((section(".nobits0")));
char nobits1[0] __attribute__((section(".nobits1")));

int main(void) {
   assert(toc[4096-1] == 0);
   for (int i = 0; i < 1024; i++)
     assert(nobits0[i] == 0);
   nobits0[0] = nobits0[1024-1] = 1;
   for (int i = 0; i < 4096; i++)
     assert(nobits1[i] == 0);
   nobits1[0] = nobits1[4096-1] = 1;

   puts("hello");
}

#--- toc.s
.section .toc,"aw",@nobits
.globl toc
toc:
.space 4096

.section .ro0,"a"; .byte 255
.section .nobits0,"aw",@nobits; .space 1024
.section .ro1,"a"; .byte 255
.section .nobits1,"aw",@nobits; .space 4096

#--- a.lds
SECTIONS { .ro0 : {} .nobits0 : {} .ro1 : {} .nobits1 : {} } INSERT AFTER .bss;
```

```sh
split-file a.txt a
path/to/musl-gcc -Wl,--dynamic-linker=/lib/libc.so a/a.c a/a.lds -o toy
```

split-file is a utility in llvm-project.
