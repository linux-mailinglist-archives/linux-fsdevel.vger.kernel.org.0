Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A4E4B013B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Feb 2022 00:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiBIX32 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 18:29:28 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:49802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiBIX3V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 18:29:21 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24D4E0553C8
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 15:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5NwJOZMijv7M6Y2itRp6HHYyS8EhHMthVxLHqVb96bA=; b=Xyf+OGA39+L1q9fC584O33I3cN
        6ncaF5sl8twzrzL9g1T4okXDILiJGBL8iYwHVSYvbwMK1Wgy3pRAZLWVkEsF84lqVmUiadX270RVD
        MoJPSlPaFoU3uJOlXSDAJ+tHAVfl29oVon4mdsvBtq9zmx1IR+eRSoxyCiyn/Q6SQkg21pulAejdp
        HcxxBav+3bU3zI/QfP9OT0X7VtrdxDaKqd5AKKfOSF3sQKvu+hdg+bS1Rnx4dsQa2OswzgfxnKfEE
        3099hHeQ7emnXpwDDg7HhI4Zwngu727MH8nkETMvFSMVPLDBzwWKDnca5RMZP/7wPz/RUDD3ru50t
        yF/jO5mQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHwOg-00231H-E3; Wed, 09 Feb 2022 23:29:14 +0000
Date:   Wed, 9 Feb 2022 15:29:14 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>, nixiaoming@huawei.com,
        Eric Biederman <ebiederm@xmission.com>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        patches@lists.linux.dev,
        Domenico Andreoli <domenico.andreoli@linux.com>
Subject: Re: [PATCH v2] fs: move binfmt_misc sysctl to its own file as
 built-in
Message-ID: <YgROSgDA3keJowks@bombadil.infradead.org>
References: <20220209225758.476724-1-mcgrof@kernel.org>
 <CAA5qM4BBHj44NgH2210nfZCBru0NV04gd1t8Yp7Et6M7LmJK-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA5qM4BBHj44NgH2210nfZCBru0NV04gd1t8Yp7Et6M7LmJK-w@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 09, 2022 at 03:15:53PM -0800, Tong Zhang wrote:
> On Wed, Feb 9, 2022 at 2:58 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > This is the second attempt to move binfmt_misc sysctl to its
> > own file. The issue with the first move was that we moved
> > the binfmt_misc sysctls to the binfmt_misc module, but the
> > way things work on some systems is that the binfmt_misc
> > module will load if the sysctl is present. If we don't force
> > the sysctl on, the module won't load. The proper thing to do
> > is to register the sysctl if the module was built or the
> > binfmt_misc code was built-in, we do this by using the helper
> > IS_ENABLED() now.
> >
> > The rationale for the move:
> >
> > kernel/sysctl.c is a kitchen sink where everyone leaves their dirty
> > dishes, this makes it very difficult to maintain.
> >
> > To help with this maintenance let's start by moving sysctls to places
> > where they actually belong.  The proc sysctl maintainers do not want to
> > know what sysctl knobs you wish to add for your own piece of code, we
> > just care about the core logic.
> >
> > This moves the binfmt_misc sysctl to its own file to help remove clutter
> > from kernel/sysctl.c.
> >
> > Cc: Domenico Andreoli <domenico.andreoli@linux.com>
> > Cc: Tong Zhang <ztong0001@gmail.com>
> > Reviewed-by: Tong Zhang <ztong0001@gmail.com>
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > ---
> >
> > Andrew,
> >
> > If we get tested-by from Domenico and Tong I think this is ready.
> >
> > Demenico, Tong, can you please test this patch? Linus' tree
> > should already have all the prior work reverted as Domenico requested
> > so this starts fresh.
> >
> >  fs/file_table.c |  2 ++
> >  kernel/sysctl.c | 13 -------------
> >  2 files changed, 2 insertions(+), 13 deletions(-)
> >
> > diff --git a/fs/file_table.c b/fs/file_table.c
> > index 57edef16dce4..4969021fa676 100644
> > --- a/fs/file_table.c
> > +++ b/fs/file_table.c
> > @@ -119,6 +119,8 @@ static struct ctl_table fs_stat_sysctls[] = {
> >  static int __init init_fs_stat_sysctls(void)
> >  {
> >         register_sysctl_init("fs", fs_stat_sysctls);
> > +       if (IS_ENABLED(CONFIG_BINFMT_MISC))
> > +               register_sysctl_mount_point("fs/binfmt_misc");
> >         return 0;
> >  }
> >  fs_initcall(init_fs_stat_sysctls);
> > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > index 241cfc6bc36f..788b9a34d5ab 100644
> > --- a/kernel/sysctl.c
> > +++ b/kernel/sysctl.c
> > @@ -2735,17 +2735,6 @@ static struct ctl_table vm_table[] = {
> >         { }
> >  };
> >
> > -static struct ctl_table fs_table[] = {
> > -#if defined(CONFIG_BINFMT_MISC) || defined(CONFIG_BINFMT_MISC_MODULE)
> > -       {
> > -               .procname       = "binfmt_misc",
> > -               .mode           = 0555,
> > -               .child          = sysctl_mount_point,
> > -       },
> > -#endif
> > -       { }
> > -};
> > -
> >  static struct ctl_table debug_table[] = {
> >  #ifdef CONFIG_SYSCTL_EXCEPTION_TRACE
> >         {
> > @@ -2765,7 +2754,6 @@ static struct ctl_table dev_table[] = {
> >
> >  DECLARE_SYSCTL_BASE(kernel, kern_table);
> >  DECLARE_SYSCTL_BASE(vm, vm_table);
> > -DECLARE_SYSCTL_BASE(fs, fs_table);
> >  DECLARE_SYSCTL_BASE(debug, debug_table);
> >  DECLARE_SYSCTL_BASE(dev, dev_table);
> >
> > @@ -2773,7 +2761,6 @@ int __init sysctl_init_bases(void)
> >  {
> >         register_sysctl_base(kernel);
> >         register_sysctl_base(vm);
> > -       register_sysctl_base(fs);
> >         register_sysctl_base(debug);
> >         register_sysctl_base(dev);
> >
> > --
> > 2.34.1
> >
> 
> Hi Luis,
> Thanks for posting.
> I checked the master branch just now and the fix is already in, see
> commit b42bc9a3c511("Fix regression due to "fs: move binfmt_misc
> sysctl to its own file"")
> I have tested it yesterday on a debian machine and it appears to be ok.

The "fix" was to vert the original effort. This patch continues with the
effort and does it properly. As such it is a change which needs to be
tested. I'd appreciate if you can test.

 Luis
