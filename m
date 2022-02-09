Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80CD14B0237
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Feb 2022 02:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbiBJB23 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 20:28:29 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbiBJB14 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 20:27:56 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49145220D8
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 17:27:48 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id b17-20020a9d4791000000b005a17fc2dfc1so2806586otf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Feb 2022 17:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Hjlwdk5trlzj8qSdguarlORx/hk0MjaXWZb21Ayv6A=;
        b=GNjddWZx6MNqLZhKaA7JOoOwX4kTFQMRmFgB5bgDOh2TTIHbrsCuaFFdxpGI+3svFg
         sxr3QyTmqwGyr9jyD0m6WlyjWXSpwOdwdczbJZ3vFINYGCCV9uzCunTXmI7JubtCxu5T
         c5TWgeMXrP/tIvai5C00wRftVh80Iy/oNUr4Lrbii6LGAvCJxBzBoAVc6K74Z6oQcfpV
         yvc8hk52JIisIPHjdJgvVgFn1fT55TDN7JA8iL18z7V1alfEof8Kk+K8mr70BfKHZdQC
         da1262fH/VmaJ0o5MKH0/889qrscy4IXZGdwrkFCT7HHo4RP5h0eapEFysHuznse+RA6
         wISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Hjlwdk5trlzj8qSdguarlORx/hk0MjaXWZb21Ayv6A=;
        b=xnwm58207Jy2+fTeXhZptuqcljL1SxiNFLIyHcdZpawCrOeGv8eaxvpEpda7UgJzSp
         HHt0ePcbmJ3cmblhNgDCTIFL2fg8A3AOWuvYYKG6ObZlRk79OkzwKbp/LnokGASZJ/2w
         HHnoOVf2D8upJxjwyqGOqo7kP33h2NekzWSu6+zMjvx1y7H6f+FNJuWm2hTURfqRsW38
         Ru7D8wnmpkl8T4J9O3SMbvVQtYf5WaxZzZ3OsQDNOO58BvOBCwk2gaPxbpQ5VuO8MD1s
         5jqfxD+bbDDwHlw45dWyUiJzzLmI87yD0IYANqt6uZXu4WzcXVIFEuUovyfmY7kn73kq
         bljw==
X-Gm-Message-State: AOAM530nyQDPXoxAg1y1sQhnTBLXJgTm/KyoFNrNb9TKICBxtrHzJHqo
        OL4o6T1h5dlnI+p50EGPMdm6A9Ob95Ivm7e6xZC+XtkXgFw1AQ==
X-Google-Smtp-Source: ABdhPJwSGDDja2EMc/0N9J0XeyraPkY34Q4J4FqkeetHMajiiyNRLPhBVAS5FtyJKtHPTYi4g/PoWKRvSCHlouJxx+g=
X-Received: by 2002:a05:6902:124f:: with SMTP id t15mr5277630ybu.640.1644449979726;
 Wed, 09 Feb 2022 15:39:39 -0800 (PST)
MIME-Version: 1.0
References: <20220209225758.476724-1-mcgrof@kernel.org> <CAA5qM4BBHj44NgH2210nfZCBru0NV04gd1t8Yp7Et6M7LmJK-w@mail.gmail.com>
 <YgROSgDA3keJowks@bombadil.infradead.org>
In-Reply-To: <YgROSgDA3keJowks@bombadil.infradead.org>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Wed, 9 Feb 2022 15:39:29 -0800
Message-ID: <CAA5qM4C2g6=6mWsQW4vkbSV0ykEjBgNYGp8oVFKtQfKFn5OFjA@mail.gmail.com>
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

On Wed, Feb 9, 2022 at 3:29 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Wed, Feb 09, 2022 at 03:15:53PM -0800, Tong Zhang wrote:
> > On Wed, Feb 9, 2022 at 2:58 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > >
> > > This is the second attempt to move binfmt_misc sysctl to its
> > > own file. The issue with the first move was that we moved
> > > the binfmt_misc sysctls to the binfmt_misc module, but the
> > > way things work on some systems is that the binfmt_misc
> > > module will load if the sysctl is present. If we don't force
> > > the sysctl on, the module won't load. The proper thing to do
> > > is to register the sysctl if the module was built or the
> > > binfmt_misc code was built-in, we do this by using the helper
> > > IS_ENABLED() now.
> > >
> > > The rationale for the move:
> > >
> > > kernel/sysctl.c is a kitchen sink where everyone leaves their dirty
> > > dishes, this makes it very difficult to maintain.
> > >
> > > To help with this maintenance let's start by moving sysctls to places
> > > where they actually belong.  The proc sysctl maintainers do not want to
> > > know what sysctl knobs you wish to add for your own piece of code, we
> > > just care about the core logic.
> > >
> > > This moves the binfmt_misc sysctl to its own file to help remove clutter
> > > from kernel/sysctl.c.
> > >
> > > Cc: Domenico Andreoli <domenico.andreoli@linux.com>
> > > Cc: Tong Zhang <ztong0001@gmail.com>
> > > Reviewed-by: Tong Zhang <ztong0001@gmail.com>
> > > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > > ---
> > >
> > > Andrew,
> > >
> > > If we get tested-by from Domenico and Tong I think this is ready.
> > >
> > > Demenico, Tong, can you please test this patch? Linus' tree
> > > should already have all the prior work reverted as Domenico requested
> > > so this starts fresh.
> > >
> > >  fs/file_table.c |  2 ++
> > >  kernel/sysctl.c | 13 -------------
> > >  2 files changed, 2 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/fs/file_table.c b/fs/file_table.c
> > > index 57edef16dce4..4969021fa676 100644
> > > --- a/fs/file_table.c
> > > +++ b/fs/file_table.c
> > > @@ -119,6 +119,8 @@ static struct ctl_table fs_stat_sysctls[] = {
> > >  static int __init init_fs_stat_sysctls(void)
> > >  {
> > >         register_sysctl_init("fs", fs_stat_sysctls);
> > > +       if (IS_ENABLED(CONFIG_BINFMT_MISC))
> > > +               register_sysctl_mount_point("fs/binfmt_misc");
> > >         return 0;
> > >  }
> > >  fs_initcall(init_fs_stat_sysctls);
> > > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > > index 241cfc6bc36f..788b9a34d5ab 100644
> > > --- a/kernel/sysctl.c
> > > +++ b/kernel/sysctl.c
> > > @@ -2735,17 +2735,6 @@ static struct ctl_table vm_table[] = {
> > >         { }
> > >  };
> > >
> > > -static struct ctl_table fs_table[] = {
> > > -#if defined(CONFIG_BINFMT_MISC) || defined(CONFIG_BINFMT_MISC_MODULE)
> > > -       {
> > > -               .procname       = "binfmt_misc",
> > > -               .mode           = 0555,
> > > -               .child          = sysctl_mount_point,
> > > -       },
> > > -#endif
> > > -       { }
> > > -};
> > > -
> > >  static struct ctl_table debug_table[] = {
> > >  #ifdef CONFIG_SYSCTL_EXCEPTION_TRACE
> > >         {
> > > @@ -2765,7 +2754,6 @@ static struct ctl_table dev_table[] = {
> > >
> > >  DECLARE_SYSCTL_BASE(kernel, kern_table);
> > >  DECLARE_SYSCTL_BASE(vm, vm_table);
> > > -DECLARE_SYSCTL_BASE(fs, fs_table);
> > >  DECLARE_SYSCTL_BASE(debug, debug_table);
> > >  DECLARE_SYSCTL_BASE(dev, dev_table);
> > >
> > > @@ -2773,7 +2761,6 @@ int __init sysctl_init_bases(void)
> > >  {
> > >         register_sysctl_base(kernel);
> > >         register_sysctl_base(vm);
> > > -       register_sysctl_base(fs);
> > >         register_sysctl_base(debug);
> > >         register_sysctl_base(dev);
> > >
> > > --
> > > 2.34.1
> > >
> >
> > Hi Luis,
> > Thanks for posting.
> > I checked the master branch just now and the fix is already in, see
> > commit b42bc9a3c511("Fix regression due to "fs: move binfmt_misc
> > sysctl to its own file"")
> > I have tested it yesterday on a debian machine and it appears to be ok.
>
> The "fix" was to vert the original effort. This patch continues with the
> effort and does it properly. As such it is a change which needs to be
> tested. I'd appreciate if you can test.
>
>  Luis

Tested-by: Tong Zhang<ztong0001@gmail.com>
