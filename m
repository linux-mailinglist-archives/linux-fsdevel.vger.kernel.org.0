Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D982055F31A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jun 2022 04:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiF2CGC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 22:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiF2CGC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 22:06:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D00313B9
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 19:06:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2DD161CD5
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jun 2022 02:06:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B467C341CD
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jun 2022 02:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656468360;
        bh=yeRtEYj3O6KnXD0oglwNrZqwWft8eIsSOQWcZxB/5ao=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oK5jp22sauBVcqNhrqG7+re6dBSIv4AKrO9uYD8pI+3VE/ymxH7lqG0js6oMSVTuv
         b3b2JaXdlwQn2rDvMB/ekT+4h6EivlgxoNuf4q4JPDH8S3qsbCaG9K5Qw9BRAgWnGS
         TREc/CHbkAaAPRSi5tm1nm5q+4BNR+QqYsl8u//dqm1tGDHn3CTnZ8Rkj/5DdhTQ9V
         tXBmH2vPBaEtHxl0kxgvu0a7Sl4ohZLT6V6xJzq1tTC9EbeC//wsX+HygWWkXD1aX7
         ElcxihsGYypnDykWZQCTSU4X+iq+NwvWnmF7INiHGU7TuN99Ds7W42Dof2d3Wg9R3n
         +Lc1nuUwOVz6A==
Received: by mail-yb1-f182.google.com with SMTP id i15so25462140ybp.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 19:06:00 -0700 (PDT)
X-Gm-Message-State: AJIora9e/+DNw5iGTfm1d4SmebxNaVahlIbm5mjwGfb5PB11b8KLs5//
        Xd4u28X370AuhxkXvYA10hqLIkMWAAj0bsDeJm3qww==
X-Google-Smtp-Source: AGRyM1uRfCuPyw11G+Dcn5pqeNsBDEc9dA7sdA6DFOimt5cYndumgW/+XXAbWVSQCf3vPHyES5JZbJ47zzVFgAU7grU=
X-Received: by 2002:a25:e056:0:b0:66c:9462:c9b1 with SMTP id
 x83-20020a25e056000000b0066c9462c9b1mr931215ybg.65.1656468359356; Tue, 28 Jun
 2022 19:05:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220628161948.475097-1-kpsingh@kernel.org> <20220628171325.ccbylrqhygtf2dlx@wittgenstein>
 <CACYkzJ4kWFwC82EAhtEYcMBPNe49zXd+uPBt1i09mVwLnoh0Bw@mail.gmail.com>
 <CACYkzJ766xv-9+jLg9mNZtdbLN3n=J+Y5ep4BjpS+vzv2B2auQ@mail.gmail.com>
 <20220629013636.GL1098723@dread.disaster.area> <CACYkzJ7dyY7m8gmHkhWQ0CCLLbq9BaYBzMnjV2eWADYoys9T8w@mail.gmail.com>
In-Reply-To: <CACYkzJ7dyY7m8gmHkhWQ0CCLLbq9BaYBzMnjV2eWADYoys9T8w@mail.gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Wed, 29 Jun 2022 04:05:48 +0200
X-Gmail-Original-Message-ID: <CACYkzJ70uqVJr5EnM0i03Lu+zkuSsXOXcOLQoUS6HZPqH=skpQ@mail.gmail.com>
Message-ID: <CACYkzJ70uqVJr5EnM0i03Lu+zkuSsXOXcOLQoUS6HZPqH=skpQ@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 0/5] Add bpf_getxattr
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christian Brauner <brauner@kernel.org>, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 29, 2022 at 4:00 AM KP Singh <kpsingh@kernel.org> wrote:
>
> On Wed, Jun 29, 2022 at 3:36 AM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Tue, Jun 28, 2022 at 07:21:42PM +0200, KP Singh wrote:
> > > On Tue, Jun 28, 2022 at 7:20 PM KP Singh <kpsingh@kernel.org> wrote:
> > > > On Tue, Jun 28, 2022 at 7:13 PM Christian Brauner <brauner@kernel.org> wrote:
> > > > > On Tue, Jun 28, 2022 at 04:19:43PM +0000, KP Singh wrote:
> > > > > > v4 -> v5
> > > > > >
> > > > > > - Fixes suggested by Andrii
> > > > > >
> > > > > > v3 -> v4
> > > > > >
> > > > > > - Fixed issue incorrect increment of arg counter
> > > > > > - Removed __weak and noinline from kfunc definiton
> > > > > > - Some other minor fixes.
> > > > > >
> > > > > > v2 -> v3
> > > > > >
> > > > > > - Fixed missing prototype error
> > > > > > - Fixes suggested by other Joanne and Kumar.
> > > > > >
> > > > > > v1 -> v2
> > > > > >
> > > > > > - Used kfuncs as suggested by Alexei
> > > > > > - Used Benjamin Tissoires' patch from the HID v4 series to add a
> > > > > >   sleepable kfunc set (I sent the patch as a part of this series as it
> > > > > >   seems to have been dropped from v5) and acked it. Hope this is okay.
> > > > > > - Added support for verifying string constants to kfuncs
> > > > >
> > > > > Hm, I mean this isn't really giving any explanation as to why you are
> > > > > doing this. There's literally not a single sentence about the rationale?
> > > > > Did you accidently forget to put that into the cover letter? :)
> > > >
> > > >
> > > > Yes, actually I did forget to copy paste :)
> > > >
> > > > Foundation for building more complex security policies using the
> > > > BPF LSM as presented in LSF/MM/BPF:
> > > >
> > > > http://vger.kernel.org/bpfconf2022_material/lsfmmbpf2022-xattr.pdf\
> > >
> > > And my copy paste skills are getting worse (with the back-slash removed):
> > >
> > > http://vger.kernel.org/bpfconf2022_material/lsfmmbpf2022-xattr.pdf
> >
> > There's literally zero information in that link, so I still have no
> > clue on what this does and how it interacts with filesystem xattr
> > code.
>
> This is literally a wrapper around __vfs_getxattr which is an exported
> symbol. So, the interaction with the xattr code is the same as
> __vfs_getxattr interacts currently.
>
> ssize_t bpf_getxattr(struct dentry *dentry, struct inode *inode,
> const char *name, void *value, int value__sz)
> {
> return __vfs_getxattr(dentry, inode, name, value, value__sz);
> }
>
> The reason for the wrapper is that the BPF verifier offers
> extra checks on the arguments passed.
>
> https://lore.kernel.org/bpf/20210325015240.1550074-1-kafai@fb.com/T/
>
> has more information on the kfunc support.
>
> >
> > So for those of us who have zero clue as to what you are trying to
> > do, please write a cover letter containing a non-zero amount of
> > information.  i.e.  a description of the problem, the threat model
> > being addressed, the design of the infrastructure that needs this
> > hook, document assumptions that have been made (e.g. for
> > accessing inode metadata atomically from random bpf contexts), what
>
> The intention is to use this in BPF programs which can only be loaded
> with CAP_SYS_ADMIN.
> We are currently planning on limiting the usage of this kfunc
> to the sleepable LSM hooks listed here:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/kernel/bpf/bpf_lsm.c#n169
>
> > xattr namespace(s) this hook should belong/be constrained to,
> > whether you're going to ask for a setxattr hook next, etc.
>
> Fair point, I will resend the series with the details.
>
> >
> > At minimum this is going to need a bunch of documentation for people
> > to understand how to use this - where can I find that?
>
> There are a bunch of examples in selftests on how to use kfuncs in BPF
> and we added a selftests (there is a simple selftests added with this patch
> too).
>
> As to how we will use xattrs to create security policies or use this
> functionality for
> logging, this is work in progress.

In any case, I will update the cover letter with some use-cases
we ideated over in LSF/MM/BPF in the next version.

- KP

>
> Cheers,
> - KP
>
> >
> > Cheers,
> >
> > Dave.
> > --
> > Dave Chinner
> > david@fromorbit.com
