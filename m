Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97D94C0204
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Feb 2022 20:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235202AbiBVT1U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Feb 2022 14:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235205AbiBVT1S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Feb 2022 14:27:18 -0500
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BD15FF2;
        Tue, 22 Feb 2022 11:26:51 -0800 (PST)
Received: by mail-yb1-f178.google.com with SMTP id c6so43391464ybk.3;
        Tue, 22 Feb 2022 11:26:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=auass86NnK6jgtGXzsQPs02Y0ugTrnRk/+rq5sZjjoE=;
        b=tnXt0drz4oyHqanGTC/G0/XVBpX2k9URAu7PGNTAkjSoY98K8i1FgD3w6ThUYNnFMV
         ujviuIhHMMeOFN6Y6tmn8vZ+WkGeCRlHHGep+6C616n+9dMUY0bifchW4MvqzChN4bIe
         mYObiCaNZHLSI6E7eZRCPxhbUMG+Oajdhm+mgQfH7js9OywheTWSskobOPVuJEBxGZuV
         NR5wImdPbpODqOcOdPWMsrNrOARXlFPyB7ZGPoiKl4XWOmulzHDq+yOZ/CdfQpNAwF/k
         Vys21OScFu4dgkQRX0wGl28ZnqTBAxqM2jhO1r4TtEsGdB9uSvZoR7GUdxsj7krIPFmX
         QZSw==
X-Gm-Message-State: AOAM533yJTdXFm/cPfVhFU123huT34drauCSapsddmXiaGKbX/DqYGjk
        FFQ27CTGzw3q54ESV1uObN5EC1lOb583qMxAAK8=
X-Google-Smtp-Source: ABdhPJwZ1WMVROHVQg+WnFqspJgmHubD1xUjLhp8RmdEZsXXdJfhaaImSHrprnZcMpG9AXvygfIb3A5gWxm+wwqcFWY=
X-Received: by 2002:a25:da16:0:b0:624:64e1:35b with SMTP id
 n22-20020a25da16000000b0062464e1035bmr14904008ybf.153.1645558010965; Tue, 22
 Feb 2022 11:26:50 -0800 (PST)
MIME-Version: 1.0
References: <20220220060053.13647-1-tangmeng@uniontech.com>
 <CAJZ5v0gowqO1fTdDYqhRJ38bSMpKb8bUFE-=P7GSmVaFdeVyDg@mail.gmail.com> <62143e02.1c69fb81.b7ae3.ddfeSMTPIN_ADDED_BROKEN@mx.google.com>
In-Reply-To: <62143e02.1c69fb81.b7ae3.ddfeSMTPIN_ADDED_BROKEN@mx.google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Feb 2022 20:26:39 +0100
Message-ID: <CAJZ5v0gst95Mm_PP8oMrPAWh+xudkeds3V8sARPcbFeF9ksC9A@mail.gmail.com>
Subject: Re: [PATCH 05/11] kernel/acpi: move acpi_video_flags sysctl to its
 own file
To:     tangmeng <tangmeng@uniontech.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
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

On Tue, Feb 22, 2022 at 2:36 AM tangmeng <tangmeng@uniontech.com> wrote:
>
> On 2022/2/22 00:08, Rafael J. Wysocki wrote:
> > On Sun, Feb 20, 2022 at 7:01 AM tangmeng <tangmeng@uniontech.com> wrote:
> >>
> >> kernel/sysctl.c is a kitchen sink where everyone leaves their dirty
> >> dishes, this makes it very difficult to maintain.
> >>
> >> To help with this maintenance let's start by moving sysctls to places
> >> where they actually belong.  The proc sysctl maintainers do not want to
> >> know what sysctl knobs you wish to add for your own piece of code, we
> >> just care about the core logic.
> >>
> >> All filesystem syctls now get reviewed by fs folks. This commit
> >> follows the commit of fs, move the acpi_video_flags sysctl to its
> >> own file, arch/x86/kernel/acpi/sleep.c.
> >>
> >> Signed-off-by: tangmeng <tangmeng@uniontech.com>
> >
> > Do you want me to take this or does it depend on the rest of the series?
> >
>
> All current commits that move sysctl to its own file will be queued on
> to the new sysctl-next, I used that tree for further sysctl changes.
>
> git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git sysctl-next
>
> So, it depend on the rest of the series. And my series of commits need
> to be merged into the sysctl-next branch first together.

OK, so please feel free to add

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to this patch.

> >> ---
> >>   arch/x86/kernel/acpi/sleep.c | 21 ++++++++++++++++++++-
> >>   include/linux/acpi.h         |  1 -
> >>   kernel/sysctl.c              |  9 ---------
> >>   3 files changed, 20 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
> >> index 1e97f944b47d..256f3c065605 100644
> >> --- a/arch/x86/kernel/acpi/sleep.c
> >> +++ b/arch/x86/kernel/acpi/sleep.c
> >> @@ -20,7 +20,26 @@
> >>   #include "../../realmode/rm/wakeup.h"
> >>   #include "sleep.h"
> >>
> >> -unsigned long acpi_realmode_flags;
> >> +static unsigned long acpi_realmode_flags;
> >> +#ifdef CONFIG_SYSCTL
> >> +static struct ctl_table kern_acpi_table[] = {
> >> +       {
> >> +               .procname       = "acpi_video_flags",
> >> +               .data           = &acpi_realmode_flags,
> >> +               .maxlen         = sizeof(unsigned long),
> >> +               .mode           = 0644,
> >> +               .proc_handler   = proc_doulongvec_minmax,
> >> +       },
> >> +       { }
> >> +};
> >> +
> >> +static __init int kernel_acpi_sysctls_init(void)
> >> +{
> >> +       register_sysctl_init("kernel", kern_acpi_table);
> >> +       return 0;
> >> +}
> >> +late_initcall(kernel_acpi_sysctls_init);
> >> +#endif /* CONFIG_SYSCTL */
> >>
> >>   #if defined(CONFIG_SMP) && defined(CONFIG_64BIT)
> >>   static char temp_stack[4096];
> >> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> >> index 6274758648e3..4f1d9cf579f5 100644
> >> --- a/include/linux/acpi.h
> >> +++ b/include/linux/acpi.h
> >> @@ -349,7 +349,6 @@ static inline bool acpi_sci_irq_valid(void)
> >>   }
> >>
> >>   extern int sbf_port;
> >> -extern unsigned long acpi_realmode_flags;
> >>
> >>   int acpi_register_gsi (struct device *dev, u32 gsi, int triggering, int polarity);
> >>   int acpi_gsi_to_irq (u32 gsi, unsigned int *irq);
> >> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> >> index e6d99bbf9a9d..62499e3207aa 100644
> >> --- a/kernel/sysctl.c
> >> +++ b/kernel/sysctl.c
> >> @@ -1973,15 +1973,6 @@ static struct ctl_table kern_table[] = {
> >>                  .proc_handler   = proc_dointvec,
> >>          },
> >>   #endif
> >> -#if    defined(CONFIG_ACPI_SLEEP) && defined(CONFIG_X86)
> >> -       {
> >> -               .procname       = "acpi_video_flags",
> >> -               .data           = &acpi_realmode_flags,
> >> -               .maxlen         = sizeof (unsigned long),
> >> -               .mode           = 0644,
> >> -               .proc_handler   = proc_doulongvec_minmax,
> >> -       },
> >> -#endif
> >>   #ifdef CONFIG_SYSCTL_ARCH_UNALIGN_NO_WARN
> >>          {
> >>                  .procname       = "ignore-unaligned-usertrap",
> >> --
> >> 2.20.1
> >>
> >>
> >>
> >
>
>
