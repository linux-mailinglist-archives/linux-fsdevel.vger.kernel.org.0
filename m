Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4634F7B0975
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 17:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbjI0P7J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 11:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbjI0P7I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:59:08 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F3F9C
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Sep 2023 08:59:06 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-692eed30152so5345976b3a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Sep 2023 08:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695830346; x=1696435146; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=utRl+TWc9PyHN267mk74epV1Ewzm2gClJk4DlVuRtdw=;
        b=N+7UTSIkrjgen/hcP67BtWxn5uh01JT4Cq8qHUwatVEv3un+8Ldqb7RfvaWLFR1PNe
         kU6hp75pxseNvSo2+ywtkZxvAgpb7AKtYIsHHxFAqqbyioC5Qh6RkceTyOTbnpb5wZrV
         fwM/VPBLKkaxT27TUEviJfPkXBJJaY3Sh4Nvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695830346; x=1696435146;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=utRl+TWc9PyHN267mk74epV1Ewzm2gClJk4DlVuRtdw=;
        b=epGb1a+CHvJ04W8W6MtbGUpt2TKI7F+A8eiddxMfap07fxlGnwuaJ/BRTpq+3BXvvL
         NYslZM4Iy+cHnIDELLpW1bGNSNTrZ3HTRxtIAFM0brAz71bxO+Ct0ivJaCP3iPCyNCl9
         9pLt9eQpGjau98QarWg14SDrfN/f9FE3ahu6vUBg8Po4Jm7gn0h6cKLZzCVlhYLXlK+p
         6oJ6lOm7VmCtYaLXwQqT/Ka584IeRdUwd0xIwqd+R4J7MnwV4YDIZknJ9Wa/zDT4QSBe
         iLm6JZHIr3rj9yd6n4t7Wo8JJdQi3TpkXjJGUULxTOlSio2xAQ/6gJW2cuysj+KP6Vtj
         sa5A==
X-Gm-Message-State: AOJu0Yw/2wJyWXz0asB7F4RLlU+yvkKPqSU6CcbomO7/lvktOCza05z1
        aoFP7p94o5zNNc32B00aqvKp+A==
X-Google-Smtp-Source: AGHT+IGQQKE15BkC2Mvcl+UNkghrr3fsPU7wV1jTnHmm9/hYjYgN74+YUAsP+ZwmLl06l6zxGgj81Q==
X-Received: by 2002:a05:6a00:21cf:b0:68a:69ba:6791 with SMTP id t15-20020a056a0021cf00b0068a69ba6791mr2592928pfj.8.1695830346245;
        Wed, 27 Sep 2023 08:59:06 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x2-20020aa784c2000000b006884844dfcdsm11987898pfn.55.2023.09.27.08.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 08:59:05 -0700 (PDT)
Date:   Wed, 27 Sep 2023 08:59:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Ungerer <gerg@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, palmer@rivosinc.com,
        ebiederm@xmission.com, brauner@kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] binfmt_elf_fdpic: clean up debug warnings
Message-ID: <202309270858.680FCD9A85@keescook>
References: <20230927132933.3290734-1-gerg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230927132933.3290734-1-gerg@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 27, 2023 at 11:29:33PM +1000, Greg Ungerer wrote:
> The binfmt_elf_fdpic loader has some debug trace that can be enabled at
> build time. The recent 64-bit additions cause some warnings if that
> debug is enabled, such as:
> 
>     fs/binfmt_elf_fdpic.c: In function ‘elf_fdpic_map_file’:
>     fs/binfmt_elf_fdpic.c:46:33: warning: format ‘%x’ expects argument of type ‘unsigned int’, but argument 3 has type ‘Elf64_Addr’ {aka ‘long long unsigned int’} [-Wformat=]
>        46 | #define kdebug(fmt, ...) printk("FDPIC "fmt"\n" ,##__VA_ARGS__ )
>           |                                 ^~~~~~~~
>     ./include/linux/printk.h:427:25: note: in definition of macro ‘printk_index_wrap’
>       427 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
>           |                         ^~~~
> 
> Cast values to the largest possible type (which is equivilent to unsigned
> long long in this case) and use appropriate format specifiers to match.

It seems like these should all just be "unsigned long", yes?

-Kees

> 
> Fixes: b922bf04d2c1 ("binfmt_elf_fdpic: support 64-bit systems")
> Signed-off-by: Greg Ungerer <gerg@kernel.org>
> ---
>  fs/binfmt_elf_fdpic.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
> index 43b2a2851ba3..97c3e8551aac 100644
> --- a/fs/binfmt_elf_fdpic.c
> +++ b/fs/binfmt_elf_fdpic.c
> @@ -900,10 +900,12 @@ static int elf_fdpic_map_file(struct elf_fdpic_params *params,
>  	kdebug("- DYNAMIC[]: %lx", params->dynamic_addr);
>  	seg = loadmap->segs;
>  	for (loop = 0; loop < loadmap->nsegs; loop++, seg++)
> -		kdebug("- LOAD[%d] : %08x-%08x [va=%x ms=%x]",
> +		kdebug("- LOAD[%d] : %08llx-%08llx [va=%llx ms=%llx]",
>  		       loop,
> -		       seg->addr, seg->addr + seg->p_memsz - 1,
> -		       seg->p_vaddr, seg->p_memsz);
> +		       (unsigned long long) seg->addr,
> +		       (unsigned long long) seg->addr + seg->p_memsz - 1,
> +		       (unsigned long long) seg->p_vaddr,
> +		       (unsigned long long) seg->p_memsz);
>  
>  	return 0;
>  
> @@ -1082,9 +1084,10 @@ static int elf_fdpic_map_file_by_direct_mmap(struct elf_fdpic_params *params,
>  		maddr = vm_mmap(file, maddr, phdr->p_memsz + disp, prot, flags,
>  				phdr->p_offset - disp);
>  
> -		kdebug("mmap[%d] <file> sz=%lx pr=%x fl=%x of=%lx --> %08lx",
> -		       loop, phdr->p_memsz + disp, prot, flags,
> -		       phdr->p_offset - disp, maddr);
> +		kdebug("mmap[%d] <file> sz=%llx pr=%x fl=%x of=%llx --> %08lx",
> +		       loop, (unsigned long long) phdr->p_memsz + disp,
> +		       prot, flags, (unsigned long long) phdr->p_offset - disp,
> +		       maddr);
>  
>  		if (IS_ERR_VALUE(maddr))
>  			return (int) maddr;
> @@ -1146,8 +1149,9 @@ static int elf_fdpic_map_file_by_direct_mmap(struct elf_fdpic_params *params,
>  
>  #else
>  		if (excess > 0) {
> -			kdebug("clear[%d] ad=%lx sz=%lx",
> -			       loop, maddr + phdr->p_filesz, excess);
> +			kdebug("clear[%d] ad=%llx sz=%lx", loop,
> +			       (unsigned long long) maddr + phdr->p_filesz,
> +			       excess);
>  			if (clear_user((void *) maddr + phdr->p_filesz, excess))
>  				return -EFAULT;
>  		}
> -- 
> 2.25.1
> 

-- 
Kees Cook
