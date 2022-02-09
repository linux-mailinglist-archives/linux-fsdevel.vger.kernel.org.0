Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280604B0114
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Feb 2022 00:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbiBIXQT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 18:16:19 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbiBIXQO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 18:16:14 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC233E05658E
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 15:16:04 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id c6so10501017ybk.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Feb 2022 15:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7etZJgkWakHfL36iIdz/AHMhYaAqfI1x274kurjmpLw=;
        b=B+vJAxlfFKHnplnMo/XXu+hTMkgE0s3/YGCGEhQ8nbcRKYi18AnPngX2A4c29EiKkV
         vHoTyCdAqajWiIZ0Q+op0/oFOCp0Lj1XpGoqJVSYtX3ZPlLHWhtOTe/xFsNSmJCsPVvk
         R1ktrPyWW8uOZbC+Vtr8lNPNe3jiUg/sBWP0yh5QblAv+ykNA0xNXG78pOjNw3cTZ/Tf
         TRkZfUpxDk4gSbJ+BMHBYvw/mDcqBFWAQdeJ97KNU6+kjoc8YBkM7yjdoylI4A3S703e
         GLy8WCNZCBx6PbcOM/eUfP4rVpwtfdur8JjNwsy1bsCmbGNuQyEgcQebn/CUPY/WShRD
         +N2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7etZJgkWakHfL36iIdz/AHMhYaAqfI1x274kurjmpLw=;
        b=biy0cYhAYY4H8UqpomGoW7E8jvLIbGUiUqNdLg3mPkKOntsLyLxnNKJ1sPGNU57Ies
         O8WJmFO0lhq20FzWyUwuuYwuinNVoUKIhJ+qOXdyEdPtt2ptaPx7uLPwaDjo9/AlAHlc
         XE/qx4rX/f3LawMnNKstMFuk4C1B8iqvElfVthvi8w7DO3PPkHdrrQfyKY37lMFX2iSg
         ux/Zb1QeraqkZYbkkS64zJR0Ds0SbKfxQL6f9xBUmgYl1x/UQPgPHQm9BcxSTe6bkBPy
         g0OSQnFhE3OtRqSoIfYC7/IgFgh+zb3SCh4CgR1xHaYwFfKkMAdBNZr9OPD9lWSUzbsX
         bTxA==
X-Gm-Message-State: AOAM531JqWmlCk2acx1OSbflXOCzrtKWr4CanS4rpkGABaPo4zZE0bEC
        zT2RpGAI3ZQc1/Rb9SU63msH6XH1Pg1rDeUzJW7tEQ2vxd8UTg==
X-Google-Smtp-Source: ABdhPJyLHX/D0/otB5+CEfgEzJyZ/HggkcAoYO0e815gKdy5qFuwBa0IKQBvPZjQcyr5ZY6R1c2eLuYcQ57jhobG0kk=
X-Received: by 2002:a25:45:: with SMTP id 66mr4618497yba.102.1644448563935;
 Wed, 09 Feb 2022 15:16:03 -0800 (PST)
MIME-Version: 1.0
References: <20220209225758.476724-1-mcgrof@kernel.org>
In-Reply-To: <20220209225758.476724-1-mcgrof@kernel.org>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Wed, 9 Feb 2022 15:15:53 -0800
Message-ID: <CAA5qM4BBHj44NgH2210nfZCBru0NV04gd1t8Yp7Et6M7LmJK-w@mail.gmail.com>
Subject: Re: [PATCH v2] fs: move binfmt_misc sysctl to its own file as built-in
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>, nixiaoming@huawei.com,
        Eric Biederman <ebiederm@xmission.com>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        patches@lists.linux.dev,
        Domenico Andreoli <domenico.andreoli@linux.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 9, 2022 at 2:58 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> This is the second attempt to move binfmt_misc sysctl to its
> own file. The issue with the first move was that we moved
> the binfmt_misc sysctls to the binfmt_misc module, but the
> way things work on some systems is that the binfmt_misc
> module will load if the sysctl is present. If we don't force
> the sysctl on, the module won't load. The proper thing to do
> is to register the sysctl if the module was built or the
> binfmt_misc code was built-in, we do this by using the helper
> IS_ENABLED() now.
>
> The rationale for the move:
>
> kernel/sysctl.c is a kitchen sink where everyone leaves their dirty
> dishes, this makes it very difficult to maintain.
>
> To help with this maintenance let's start by moving sysctls to places
> where they actually belong.  The proc sysctl maintainers do not want to
> know what sysctl knobs you wish to add for your own piece of code, we
> just care about the core logic.
>
> This moves the binfmt_misc sysctl to its own file to help remove clutter
> from kernel/sysctl.c.
>
> Cc: Domenico Andreoli <domenico.andreoli@linux.com>
> Cc: Tong Zhang <ztong0001@gmail.com>
> Reviewed-by: Tong Zhang <ztong0001@gmail.com>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>
> Andrew,
>
> If we get tested-by from Domenico and Tong I think this is ready.
>
> Demenico, Tong, can you please test this patch? Linus' tree
> should already have all the prior work reverted as Domenico requested
> so this starts fresh.
>
>  fs/file_table.c |  2 ++
>  kernel/sysctl.c | 13 -------------
>  2 files changed, 2 insertions(+), 13 deletions(-)
>
> diff --git a/fs/file_table.c b/fs/file_table.c
> index 57edef16dce4..4969021fa676 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -119,6 +119,8 @@ static struct ctl_table fs_stat_sysctls[] = {
>  static int __init init_fs_stat_sysctls(void)
>  {
>         register_sysctl_init("fs", fs_stat_sysctls);
> +       if (IS_ENABLED(CONFIG_BINFMT_MISC))
> +               register_sysctl_mount_point("fs/binfmt_misc");
>         return 0;
>  }
>  fs_initcall(init_fs_stat_sysctls);
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 241cfc6bc36f..788b9a34d5ab 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -2735,17 +2735,6 @@ static struct ctl_table vm_table[] = {
>         { }
>  };
>
> -static struct ctl_table fs_table[] = {
> -#if defined(CONFIG_BINFMT_MISC) || defined(CONFIG_BINFMT_MISC_MODULE)
> -       {
> -               .procname       = "binfmt_misc",
> -               .mode           = 0555,
> -               .child          = sysctl_mount_point,
> -       },
> -#endif
> -       { }
> -};
> -
>  static struct ctl_table debug_table[] = {
>  #ifdef CONFIG_SYSCTL_EXCEPTION_TRACE
>         {
> @@ -2765,7 +2754,6 @@ static struct ctl_table dev_table[] = {
>
>  DECLARE_SYSCTL_BASE(kernel, kern_table);
>  DECLARE_SYSCTL_BASE(vm, vm_table);
> -DECLARE_SYSCTL_BASE(fs, fs_table);
>  DECLARE_SYSCTL_BASE(debug, debug_table);
>  DECLARE_SYSCTL_BASE(dev, dev_table);
>
> @@ -2773,7 +2761,6 @@ int __init sysctl_init_bases(void)
>  {
>         register_sysctl_base(kernel);
>         register_sysctl_base(vm);
> -       register_sysctl_base(fs);
>         register_sysctl_base(debug);
>         register_sysctl_base(dev);
>
> --
> 2.34.1
>

Hi Luis,
Thanks for posting.
I checked the master branch just now and the fix is already in, see
commit b42bc9a3c511("Fix regression due to "fs: move binfmt_misc
sysctl to its own file"")
I have tested it yesterday on a debian machine and it appears to be ok.
- Tong
