Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFDFF4BDFA0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Feb 2022 18:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379893AbiBUQJc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Feb 2022 11:09:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232866AbiBUQJc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Feb 2022 11:09:32 -0500
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C973117ABB;
        Mon, 21 Feb 2022 08:09:08 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id w63so14105881ybe.10;
        Mon, 21 Feb 2022 08:09:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UPYIn5XH+Em7FNXY5/X3cEIDgDhAxKowlxKqkc3z4TQ=;
        b=nHtcdIWaI9nm+NaG1XfQh1eN8+usbpPzEOjeNe9TA9XuQitiQ/qvKHodxGb6/Rxie7
         7C7oQniWOgGcJdItTxCyjAooToPRK0G4We/gcWuk+EtI0+5FkBVEnAq9WLy2KrTaGR6k
         QUgBiPvgLMOC0vOd7FhtprVFXcuxTKigPCwU2eJiQ+Ha2wKTy4qWnAeagkaq37v/7ILB
         9UD1e/Drxb5aPgwOrtb6siAC5s8FV4yPmD3QKw1vyMk8afsEUKnJd3Yi4a4Xnd/tsA8H
         ErxIGtefwdiwlDPN/uqOk+rM1AeUYBmFzWXFotquqkIT/VJGJLBr6hiWAX6D/USWKGDG
         g74A==
X-Gm-Message-State: AOAM530FMDTV+RP5y9fSuFTOazgQQ/1Ym0neGTbkF+18KWu3YJqlZLWw
        mL0M1eIuYN7kcGspVih8UDkB/IcUPDCc4SK7CQk=
X-Google-Smtp-Source: ABdhPJxCMRPqJ4fex71EVtbTpYHpZhtL3689hPo+XpK5QiFhRPKh4Gio7k8CZx14XtU5ACTiHyDwZRueeQzB/GM1b4I=
X-Received: by 2002:a25:7d81:0:b0:624:43b7:ed70 with SMTP id
 y123-20020a257d81000000b0062443b7ed70mr14262808ybc.365.1645459748028; Mon, 21
 Feb 2022 08:09:08 -0800 (PST)
MIME-Version: 1.0
References: <20220220060053.13647-1-tangmeng@uniontech.com>
In-Reply-To: <20220220060053.13647-1-tangmeng@uniontech.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Feb 2022 17:08:52 +0100
Message-ID: <CAJZ5v0gowqO1fTdDYqhRJ38bSMpKb8bUFE-=P7GSmVaFdeVyDg@mail.gmail.com>
Subject: Re: [PATCH 05/11] kernel/acpi: move acpi_video_flags sysctl to its
 own file
To:     tangmeng <tangmeng@uniontech.com>
Cc:     "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, nizhen@uniontech.com,
        zhanglianjie@uniontech.com, nixiaoming@huawei.com,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Feb 20, 2022 at 7:01 AM tangmeng <tangmeng@uniontech.com> wrote:
>
> kernel/sysctl.c is a kitchen sink where everyone leaves their dirty
> dishes, this makes it very difficult to maintain.
>
> To help with this maintenance let's start by moving sysctls to places
> where they actually belong.  The proc sysctl maintainers do not want to
> know what sysctl knobs you wish to add for your own piece of code, we
> just care about the core logic.
>
> All filesystem syctls now get reviewed by fs folks. This commit
> follows the commit of fs, move the acpi_video_flags sysctl to its
> own file, arch/x86/kernel/acpi/sleep.c.
>
> Signed-off-by: tangmeng <tangmeng@uniontech.com>

Do you want me to take this or does it depend on the rest of the series?

> ---
>  arch/x86/kernel/acpi/sleep.c | 21 ++++++++++++++++++++-
>  include/linux/acpi.h         |  1 -
>  kernel/sysctl.c              |  9 ---------
>  3 files changed, 20 insertions(+), 11 deletions(-)
>
> diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
> index 1e97f944b47d..256f3c065605 100644
> --- a/arch/x86/kernel/acpi/sleep.c
> +++ b/arch/x86/kernel/acpi/sleep.c
> @@ -20,7 +20,26 @@
>  #include "../../realmode/rm/wakeup.h"
>  #include "sleep.h"
>
> -unsigned long acpi_realmode_flags;
> +static unsigned long acpi_realmode_flags;
> +#ifdef CONFIG_SYSCTL
> +static struct ctl_table kern_acpi_table[] = {
> +       {
> +               .procname       = "acpi_video_flags",
> +               .data           = &acpi_realmode_flags,
> +               .maxlen         = sizeof(unsigned long),
> +               .mode           = 0644,
> +               .proc_handler   = proc_doulongvec_minmax,
> +       },
> +       { }
> +};
> +
> +static __init int kernel_acpi_sysctls_init(void)
> +{
> +       register_sysctl_init("kernel", kern_acpi_table);
> +       return 0;
> +}
> +late_initcall(kernel_acpi_sysctls_init);
> +#endif /* CONFIG_SYSCTL */
>
>  #if defined(CONFIG_SMP) && defined(CONFIG_64BIT)
>  static char temp_stack[4096];
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 6274758648e3..4f1d9cf579f5 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -349,7 +349,6 @@ static inline bool acpi_sci_irq_valid(void)
>  }
>
>  extern int sbf_port;
> -extern unsigned long acpi_realmode_flags;
>
>  int acpi_register_gsi (struct device *dev, u32 gsi, int triggering, int polarity);
>  int acpi_gsi_to_irq (u32 gsi, unsigned int *irq);
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index e6d99bbf9a9d..62499e3207aa 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -1973,15 +1973,6 @@ static struct ctl_table kern_table[] = {
>                 .proc_handler   = proc_dointvec,
>         },
>  #endif
> -#if    defined(CONFIG_ACPI_SLEEP) && defined(CONFIG_X86)
> -       {
> -               .procname       = "acpi_video_flags",
> -               .data           = &acpi_realmode_flags,
> -               .maxlen         = sizeof (unsigned long),
> -               .mode           = 0644,
> -               .proc_handler   = proc_doulongvec_minmax,
> -       },
> -#endif
>  #ifdef CONFIG_SYSCTL_ARCH_UNALIGN_NO_WARN
>         {
>                 .procname       = "ignore-unaligned-usertrap",
> --
> 2.20.1
>
>
>
