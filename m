Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B996262E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Nov 2022 21:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbiKKU1m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Nov 2022 15:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234080AbiKKU1l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Nov 2022 15:27:41 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71FC748E9
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Nov 2022 12:27:39 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id o13so5221316pgu.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Nov 2022 12:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VenKawNdI6vht+/5rGH39TnWAPmNSDWBqV+Ma0YasTE=;
        b=qXOnXYoTn4MSk0EEKJLu2DIgcOrdHYPGnG+66FDnWf4OaNHtkc86/ZqlshCEMMCMtd
         OZe+obHgSI5aGVhVhTMCJ/lVvo1UFUcE7L2BLR86uoK6XFXVekh+1NAB8cN7s4jRseTm
         S1mkUrP+IUQ237XG/8l+Bf/TgR/0E8xXhhCyE9nQhqnehDZo2g6jHd/U7XvyzyWN1J6g
         aiOjtL7Ho0/UAvsz0U6JuBD+tMmZ48xM91UO5SBuGphPW2kD2mWCDSRCTA0HBQc7FP50
         dlkr6wGL28un/msWyOjl1ktz2CYnWNx8nNo2b+qCejCD9dAaGo8TwAOwr9avK/138r1f
         UvXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VenKawNdI6vht+/5rGH39TnWAPmNSDWBqV+Ma0YasTE=;
        b=7VhD2Ia16KLrQokpqFX5TaPisF00qGEAC+O/jUPFp7Qys1GIojW0D/YbIDG+8xn0d8
         OsDPXMPzvRC/Fdgh4C1fMYEJGXOFy8LLOSHtW2swWkOsn5WHSEGvxc6xPuf0q4YxFuu3
         nn8VEHsXQz1xRnH+savsA0w74RviuDXjcuZSx1pVwNfqsPwfidw9Jk9HhSofegZdlkpJ
         QQf4kmwMqZDm/BWpPWWl8u5rGPjH7kqJWHvP8tWADAAx1OtOoSxKe/gm9OfTJjvKXf+g
         HlCg8FtDU7Bj57eisJBcd4Lwfepe/XuhEScUt6V7xpndHvLGzkQPccJUORwo5uIMj8/B
         SunQ==
X-Gm-Message-State: ANoB5plThMUBHgmfyB/c5X2BGcfObnLKyqclLvUhpH9nBR/joiuyofKC
        2qhzRZxIXCF7/ASipSr84e9ZYQ==
X-Google-Smtp-Source: AA0mqf7p+q950DoxxPAxQxTUsalRqJn9q8r0sFdVKzATt8Xe3HgzH38KcItMCpO/f3fIGxvOkGA0xg==
X-Received: by 2002:a63:4e53:0:b0:434:aa69:bba2 with SMTP id o19-20020a634e53000000b00434aa69bba2mr2910064pgl.567.1668198459215;
        Fri, 11 Nov 2022 12:27:39 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:8b77:5448:ea74:27a])
        by smtp.gmail.com with ESMTPSA id c2-20020a17090a108200b002137d3da760sm5251776pja.39.2022.11.11.12.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 12:27:38 -0800 (PST)
Date:   Fri, 11 Nov 2022 12:27:34 -0800
From:   Fangrui Song <maskray@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Pedro Falcato <pedro.falcato@gmail.com>,
        Rich Felker <dalias@libc.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>, sam@gentoo.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] binfmt_elf: Allow .bss in any interp PT_LOAD
Message-ID: <20221111202734.m5gk6vr4e5zd25lk@google.com>
References: <20221111061315.gonna.703-kees@kernel.org>
 <20221111074234.xm5a6ota7ppdsto5@google.com>
 <202211111211.93ED8B4B@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <202211111211.93ED8B4B@keescook>
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

On 2022-11-11, Kees Cook wrote:
>On Thu, Nov 10, 2022 at 11:42:34PM -0800, Fangrui Song wrote:
>> (+ sam@gentoo.org from Pedro Falcato's patch)
>>
>> On 2022-11-10, Kees Cook wrote:
>> > Traditionally, only the final PT_LOAD for load_elf_interp() supported
>> > having p_memsz > p_filesz. Recently, lld's construction of musl's
>> > libc.so on PowerPC64 started having two PT_LOAD program headers with
>> > p_memsz > p_filesz.
>> >
>> > As the least invasive change possible, check for p_memsz > p_filesz for
>> > each PT_LOAD in load_elf_interp.
>> >
>> > Reported-by: Rich Felker <dalias@libc.org>
>> > Link: https://maskray.me/blog/2022-11-05-lld-musl-powerpc64
>> > Cc: Pedro Falcato <pedro.falcato@gmail.com>
>> > Cc: Fangrui Song <maskray@google.com>
>> > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
>> > Cc: Eric Biederman <ebiederm@xmission.com>
>> > Cc: linux-fsdevel@vger.kernel.org
>> > Cc: linux-mm@kvack.org
>> > Signed-off-by: Kees Cook <keescook@chromium.org>
>> > ---
>> > v2: I realized we need to retain the final padding call.
>> > v1: https://lore.kernel.org/linux-hardening/20221111055747.never.202-kees@kernel.org/
>> > ---
>> > fs/binfmt_elf.c | 18 ++++++++++++++----
>> > 1 file changed, 14 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
>> > index 528e2ac8931f..0a24bbbef1d6 100644
>> > --- a/fs/binfmt_elf.c
>> > +++ b/fs/binfmt_elf.c
>> > @@ -673,15 +673,25 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
>> > 				last_bss = k;
>> > 				bss_prot = elf_prot;
>> > 			}
>> > +
>> > +			/*
>> > +			 * Clear any p_memsz > p_filesz area up to the end
>> > +			 * of the page to wipe anything left over from the
>> > +			 * loaded file contents.
>> > +			 */
>> > +			if (last_bss > elf_bss && padzero(elf_bss))
>>
>> Missing {
>>
>> But after fixing this, I get a musl ld.so error.
>>
>> > +				error = -EFAULT;
>> > +				goto out;
>> > +			}
>> > 		}
>> > 	}
>> >
>> > 	/*
>> > -	 * Now fill out the bss section: first pad the last page from
>> > -	 * the file up to the page boundary, and zero it from elf_bss
>> > -	 * up to the end of the page.
>> > +	 * Finally, pad the last page from the file up to the page boundary,
>> > +	 * and zero it from elf_bss up to the end of the page, if this did
>> > +	 * not already happen with the last PT_LOAD.
>> > 	 */
>> > -	if (padzero(elf_bss)) {
>> > +	if (last_bss == elf_bss && padzero(elf_bss)) {
>> > 		error = -EFAULT;
>> > 		goto out;
>> > 	}
>> > --
>> > 2.34.1
>> >
>>
>> I added a new section to https://maskray.me/blog/2022-11-05-lld-musl-powerpc64
>> Copying here:
>>
>> To test that the kernel ELF loader can handle more RW `PT_LOAD` program headers, we can create an executable with more RW `PT_LOAD` program headers with `p_filesz < p_memsz`.
>> We can place a read-only section after `.bss` followed by a `SHT_NOBITS` `SHF_ALLOC|SHF_WRITE` section. The read-only section will form a read-only `PT_LOAD` while the RW section will form a RW `PT_LOAD`.
>>
>> ```text
>> #--- a.c
>> #include <assert.h>
>> #include <stdio.h>
>>
>> extern const char toc[];
>> char nobits0[0] __attribute__((section(".nobits0")));
>> char nobits1[0] __attribute__((section(".nobits1")));
>>
>> int main(void) {
>>   assert(toc[4096-1] == 0);
>>   for (int i = 0; i < 1024; i++)
>>     assert(nobits0[i] == 0);
>>   nobits0[0] = nobits0[1024-1] = 1;
>>   for (int i = 0; i < 4096; i++)
>>     assert(nobits1[i] == 0);
>>   nobits1[0] = nobits1[4096-1] = 1;
>>
>>   puts("hello");
>> }
>>
>> #--- toc.s
>> .section .toc,"aw",@nobits
>> .globl toc
>> toc:
>> .space 4096
>>
>> .section .ro0,"a"; .byte 255
>> .section .nobits0,"aw",@nobits; .space 1024
>> .section .ro1,"a"; .byte 255
>> .section .nobits1,"aw",@nobits; .space 4096
>>
>> #--- a.lds
>> SECTIONS { .ro0 : {} .nobits0 : {} .ro1 : {} .nobits1 : {} } INSERT AFTER .bss;
>> ```
>>
>> ```sh
>> split-file a.txt a
>> path/to/musl-gcc -Wl,--dynamic-linker=/lib/libc.so a/a.c a/a.lds -o toy
>> ```
>>
>> split-file is a utility in llvm-project.
>
>Where is a.txt? Also, it'd be nice to have this without needing the
>musl-gcc.

Sorry for the unclear description. I rewrite it.
(`char nobits0[0] __attribute__((section(".nobits0")));` is not effective. It's SHT_PROGBITS and makes the output section SHT_PROGBITS.
The new example addresses the deficiency.)



Create some files. If you have split-file (a [test utility](https://llvm.org/docs/TestingGuide.html#extra-files) from llvm-project), you may place the following content into `a.txt`.

```text
#--- a.c
#include <assert.h>
#include <stdio.h>

extern const char toc[];
extern char nobits0[], nobits1[];

int main(void) {
   assert(toc[4096-1] == 0);
   for (int i = 0; i < 1024; i++) {
     assert(nobits0[i] == 0);
     nobits0[i] = 1;
   }
   for (int i = 0; i < 8192; i++) {
     assert(nobits1[i] == 0);
     nobits1[i] = 1;
   }

   puts("hello");
}

#--- toc.s
.globl toc, nobits0, nobits1

.section .toc,"aw",@nobits; toc: .space 4096

.section .ro0,"a"; .byte 255
.section .nobits0,"aw",@nobits; nobits0: .space 1024
.section .ro1,"a"; .byte 255
.section .nobits1,"aw",@nobits; nobits1: .space 8192

#--- a.lds
SECTIONS { .ro0 : {} .nobits0 : {} .ro1 : {} .nobits1 : {} } INSERT AFTER .bss;
```

Then run:
```sh
split-file a.txt a
path/to/musl-gcc -Wl,--dynamic-linker=/lib/libc.so a/a.c a/a.lds -o toy
```

Note: when a `SHT_NOBITS` section is followed by another section, the `SHT_NOBITS` section behaves as if it occupies the file offset range. This is because ld.lld does not implement a file size optimization.


For this simple example, using glibc based gcc works as well (musl provides __assert_fail and puts referenced by the executable):

gcc -Wl,--dynamic-linker=/lib/libc.so a/a.c a/a.lds -o toy
