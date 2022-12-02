Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2027163FEA6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Dec 2022 04:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbiLBDPD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Dec 2022 22:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbiLBDPC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Dec 2022 22:15:02 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23CCD49F1
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Dec 2022 19:15:01 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id y4so3502576plb.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Dec 2022 19:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oqF8S2h0QfjDSY5BvnG3c6kD+5Es8xPoCcPiNLRGmBY=;
        b=Fa9mz0Dc6OvnCQeV7mKMdOpv3bANXuvSDuKqWT3mNGilaa1aLiwU9tzK3gTdi8BZky
         Cf0VI8AV20LH/YIcZ6jLe8d6/czcA1UOmuGjwbdXzUiSo8n7rS5e3Ry32FZz/xTHuLO5
         0Ix+RcHs/mJFGnXMcEnClcHbpqtpvcErX7N50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oqF8S2h0QfjDSY5BvnG3c6kD+5Es8xPoCcPiNLRGmBY=;
        b=mRuu+MZ3ncFGATV5hZqCByLKjQCd2k2khZdnjWmvtkz4Wiu1sL0M5Oaw7KZfQC2lOC
         8Cfz2eDq/a0jOYHi8II/P8Jp2JwHJJX9stEv9QOe0iLA/Ga2ZfLcSYvHzP1+vDqCSg3i
         1QEkbhutzQO+OyKa2aXKlmZ1OeuNTWbz1X2OwiNLVtix6vYCqok3q8tSCwuyDhMkQauS
         hMxz00R8RpFFiwAWsRaLc1ukVbAsyEniG4k+Af0CYhH+k38A0zsPA8HexhZ6+D7nG7OL
         DbCDxKIbTo343GDJPgsY5xHRu5rv7RxkFKqjQSZBTzUahtDf2YwailXN4CNbV3X9bxUA
         2Yeg==
X-Gm-Message-State: ANoB5pm/1Gah4LQGVLr6tfEvi9E+7Nhvx3M/WUE8TpIWCrUk/VHB7oPt
        w2Xvu03nWt1CJ50SM8Ql4pmjW1ducoY+3cgJ
X-Google-Smtp-Source: AA0mqf7a/WwRWd061ZWQpdBuig0WFuxxmWOGrWFK6efQfuyV8RpxQuBfw6dN3ZvaaAfMbtN90FNMcQ==
X-Received: by 2002:a17:902:ef44:b0:189:6793:644f with SMTP id e4-20020a170902ef4400b001896793644fmr34274294plx.38.1669950901280;
        Thu, 01 Dec 2022 19:15:01 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 65-20020a620544000000b00575448ab0e9sm3924741pff.123.2022.12.01.19.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 19:15:00 -0800 (PST)
Date:   Thu, 1 Dec 2022 19:14:59 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Wang Yufen <wangyufen@huawei.com>
Cc:     viro@zeniv.linux.org.uk, ebiederm@xmission.com,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] binfmt: Fix error return code in load_elf_fdpic_binary()
Message-ID: <202212011914.792F2FE@keescook>
References: <1669945261-30271-1-git-send-email-wangyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1669945261-30271-1-git-send-email-wangyufen@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 02, 2022 at 09:41:01AM +0800, Wang Yufen wrote:
> Fix to return a negative error code from create_elf_fdpic_tables()
> instead of 0.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Wang Yufen <wangyufen@huawei.com>

Thanks for the catch! Yeah, it looks like this has been wrong for a long
time. :)

-Kees

> ---
>  fs/binfmt_elf_fdpic.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
> index 08d0c87..9ce5e1f 100644
> --- a/fs/binfmt_elf_fdpic.c
> +++ b/fs/binfmt_elf_fdpic.c
> @@ -434,8 +434,9 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
>  	current->mm->start_stack = current->mm->start_brk + stack_size;
>  #endif
>  
> -	if (create_elf_fdpic_tables(bprm, current->mm,
> -				    &exec_params, &interp_params) < 0)
> +	retval = create_elf_fdpic_tables(bprm, current->mm, &exec_params,
> +					 &interp_params);
> +	if (retval < 0)
>  		goto error;
>  
>  	kdebug("- start_code  %lx", current->mm->start_code);
> -- 
> 1.8.3.1
> 

-- 
Kees Cook
