Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8A37706F9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 19:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjHDRX0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 13:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjHDRXZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 13:23:25 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3974698;
        Fri,  4 Aug 2023 10:23:24 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fb4146e8fcso14639335e9.0;
        Fri, 04 Aug 2023 10:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691169803; x=1691774603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o8gADuiK/ShCeRt5VVNqfT87ZmatM5Y8Hl/O5iaVWq8=;
        b=oLa3IjoUEykKezHiIEXrPqXTtPLUyQL6UuZs/E5dFSNp0Yl6o7v7XXoaXbHd9bPb1Q
         xaKbBLOrDMKOZWIhaErgf1zqP9BNibJjQTOC6uLW6yQRQbRw/8CH/lqkUEm1dAYgyXNW
         OXlX6cJX25ahUV1nLcHbbD6liiWnG3OVV+2/OnqmYp146YN/RnGrrm/V+7M8chrUbvjl
         WxUtFHORxjZHwclVje5SM1oH/c3AwlRMFN5t6MzhRDJcCnFsa1H0SrK3FXeuawfJt94T
         mJtu4ggjtiuDJmDQrKy3sS/sMQ3pRn6Y4hpeyZ29kUXYP+2x0gzABSj6F/IpdYQkIGhw
         Kqew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691169803; x=1691774603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o8gADuiK/ShCeRt5VVNqfT87ZmatM5Y8Hl/O5iaVWq8=;
        b=ZQBJaWCmSgJPUo6ccy2V3IYGkPPsM/Fpr5Yos4qQcqbBQ2QuHT2oJwPWS416GRQS9H
         j6PAfsdphH1PKWd8em8kpEjN3bM8u8cpwN+Aa9349EBqb1CUhekSRKmD7gmasDLOGGXM
         6qCts3fLhugZd/Uk/Up1fN4DlrSQkOo/ZAKB01QyqB8vWjnl5dwfZda8tOR7ibyuZ+tK
         CGN93yXIGgQicCs1MDZ5aYjEXIbzKo1+d+1AhIW/URNeWHYKpM5w33w2g1RBv8eLQCuw
         TNjxwBOx8TR0/kwkPcL6FEqPR12BBshp8/stM73K8th23ecd+23B7LF74lcSOt5brhJb
         ZuJg==
X-Gm-Message-State: AOJu0Yxq1cldD+3oSMy1100Swzb5unWxET+IpnrOsEh+PuV9sxWbaLGM
        bbkpIYbjk+3DBuuZ5Xvurw==
X-Google-Smtp-Source: AGHT+IEBtyiCIzgK0yIXCgAkMuGSyJif1rx6WNwBW+8P1ihmjffU0s0vkIsFLvsCzdHvsifdShe2lQ==
X-Received: by 2002:a05:600c:210e:b0:3fe:215e:44a0 with SMTP id u14-20020a05600c210e00b003fe215e44a0mr277446wml.18.1691169802990;
        Fri, 04 Aug 2023 10:23:22 -0700 (PDT)
Received: from p183 ([46.53.252.19])
        by smtp.gmail.com with ESMTPSA id f10-20020a7bc8ca000000b003fe1afb99b5sm5751275wml.0.2023.08.04.10.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 10:23:22 -0700 (PDT)
Date:   Fri, 4 Aug 2023 20:23:20 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     akpm@linux-foundation.org, mhiramat@kernel.org, arnd@kernel.org,
        ndesaulniers@google.com, sfr@canb.auug.org.au,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH RFC bootconfig] 1/2] fs/proc: Add /proc/cmdline_load for
 boot loader arguments
Message-ID: <db2617d2-589d-47c1-a0cc-e8aeca58710a@p183>
References: <197cba95-3989-4d2f-a9f1-8b192ad08c49@paulmck-laptop>
 <20230728033701.817094-1-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230728033701.817094-1-paulmck@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 27, 2023 at 08:37:00PM -0700, Paul E. McKenney wrote:
> In kernels built with CONFIG_BOOT_CONFIG_FORCE=y, /proc/cmdline will
> show all kernel boot parameters, both those supplied by the boot loader
> and those embedded in the kernel image.  This works well for those who
> just want to see all of the kernel boot parameters, but is not helpful to
> those who need to see only those parameters supplied by the boot loader.
> This is especially important when these parameters are presented to the
> boot loader by automation that might gather them from diverse sources.
> 
> Therefore, provide a /proc/cmdline_load file that shows only those kernel
> boot parameters supplied by the boot loader.

> +static int cmdline_load_proc_show(struct seq_file *m, void *v)
> +{
> +	seq_puts(m, boot_command_line);
> +	seq_putc(m, '\n');
> +	return 0;
> +}
> +
>  static int __init proc_cmdline_init(void)
>  {
>  	struct proc_dir_entry *pde;
> @@ -19,6 +27,11 @@ static int __init proc_cmdline_init(void)
>  	pde = proc_create_single("cmdline", 0, NULL, cmdline_proc_show);
>  	pde_make_permanent(pde);
>  	pde->size = saved_command_line_len + 1;
> +	if (IS_ENABLED(CONFIG_BOOT_CONFIG_FORCE)) {
> +		pde = proc_create_single("cmdline_load", 0, NULL, cmdline_load_proc_show);
> +		pde_make_permanent(pde);
> +		pde->size = strnlen(boot_command_line, COMMAND_LINE_SIZE) + 1;
> +	}

Please add it as separate fs/proc/cmdline_load.c file so that name of
the file matches name of the /proc file.

The name "cmdline_load" is kind of non-descriptive. Mentioning "bootloader"
somewhere should improve things.
