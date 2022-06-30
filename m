Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE39D560F65
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 05:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbiF3DDF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jun 2022 23:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiF3DDE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jun 2022 23:03:04 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483F937018;
        Wed, 29 Jun 2022 20:03:03 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id lw20so36344997ejb.4;
        Wed, 29 Jun 2022 20:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6g2G4kTu/cl5EOpn/9908zjA20ML111IqszPL34SQHc=;
        b=cq8nQhgHTWRfnjPvnp47nEu0wC7Zo8l/UDK9csc4hfUXpTzavddyGNLV85YF50DH9N
         QB7b5VOH165slHnZ2GX/6X0wv5+doEof9EMAZbBOUL8uqzyQqpC8irHDJMChMpyUZEE8
         usoQGvm51sfMIGSQOqEqXy8hQykdDrQ6B1MVPYh6yOXc0DAW5XrCok0Vazxj5UJ+/jMy
         T7cXLmzTcFaB8SwC8kfLbklgETQO1NbjYTc1hZUitP+/jlJkl4YTiDJLxqYFfzZMyMIR
         Mx0PvGNJug5wAj8Ac1kHPsOIUI7VrFE2AD2ixLrMrkYG4DTe0IFiC18xDdotCaH4R2S+
         5N1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6g2G4kTu/cl5EOpn/9908zjA20ML111IqszPL34SQHc=;
        b=GggUrKnmE5HnBL56jAArauW/pGAZxeglEJJiWz8Hly25vHu6V9j1OfPeOmpMB2MFXq
         YH9Sbo6CkC/983MHo8x1VpxJHrWX+J4zcQmSvnqf2L0dBNLYcAjijEyxgZgg0z0wD/3d
         zmRc/5HIsovHnmYXBjOGcO06qryVqWJzW6GoSy2JEZT97qqcSujolTVGDWRPzXSQ45jb
         CbioS72Bu3N/P+e/fUDnPvnoAKwzyqcdUZAcYpv1r7u6ZtCKoeW1z/Vv+o0cVCIuPpf0
         kaK03bK4lbUPVAWIm6fv4cxmhN7R9N1xsrueSpSekS/nkoFuhKd3oSDSD++QLZl1qIUy
         RBIg==
X-Gm-Message-State: AJIora+BuQtmkzknm4L+cTU7pZT8hCwWoP4fcZnnwiqGSmgMvrJyVSFZ
        xzpzpQXjzWpp367VBHdYnmsSJuMEjYbfnwElOUY=
X-Google-Smtp-Source: AGRyM1uUKy1ILCS5Z7cF3IglEgNZiZpcnSeExUI3rDBA9z2ARLajtjfeiiV/qevOWqQkJGdslzbWyITcYVCZLSekg5M=
X-Received: by 2002:a17:907:6e03:b0:726:a6a3:7515 with SMTP id
 sd3-20020a1709076e0300b00726a6a37515mr6682210ejc.676.1656558181723; Wed, 29
 Jun 2022 20:03:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220628161948.475097-1-kpsingh@kernel.org> <20220628161948.475097-6-kpsingh@kernel.org>
 <20220628173344.h7ihvyl6vuky5xus@wittgenstein> <CACYkzJ5ij9rth_v3KQrCVYsQr2STBEWq1EAzkDb5D06CoRRSjA@mail.gmail.com>
 <CAADnVQ+mokn3Yo492Zng=Gtn_LgT-T1XLth5BXyKZXFno-3ZDg@mail.gmail.com>
 <20220629081119.ddqvfn3al36fl27q@wittgenstein> <20220629095557.oet6u2hi7msit6ff@wittgenstein>
In-Reply-To: <20220629095557.oet6u2hi7msit6ff@wittgenstein>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 29 Jun 2022 20:02:50 -0700
Message-ID: <CAADnVQ+HhhQdcz_u8kP45Db_gUK+pOYg=jObZpLtdin=v_t9tw@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 5/5] bpf/selftests: Add a selftest for bpf_getxattr
To:     Christian Brauner <brauner@kernel.org>
Cc:     KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 29, 2022 at 2:56 AM Christian Brauner <brauner@kernel.org> wrote:
>
> On Wed, Jun 29, 2022 at 10:11:19AM +0200, Christian Brauner wrote:
> > On Tue, Jun 28, 2022 at 03:28:42PM -0700, Alexei Starovoitov wrote:
> > > On Tue, Jun 28, 2022 at 10:52 AM KP Singh <kpsingh@kernel.org> wrote:
> > > >
> > > > On Tue, Jun 28, 2022 at 7:33 PM Christian Brauner <brauner@kernel.org> wrote:
> > > > >
> > > > > On Tue, Jun 28, 2022 at 04:19:48PM +0000, KP Singh wrote:
> > > > > > A simple test that adds an xattr on a copied /bin/ls and reads it back
> > > > > > when the copied ls is executed.
> > > > > >
> > > > > > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > > > > > ---
> > > > > >  .../testing/selftests/bpf/prog_tests/xattr.c  | 54 +++++++++++++++++++
> > > >
> > > > [...]
> > > >
> > > > > > +SEC("lsm.s/bprm_committed_creds")
> > > > > > +void BPF_PROG(bprm_cc, struct linux_binprm *bprm)
> > > > > > +{
> > > > > > +     struct task_struct *current = bpf_get_current_task_btf();
> > > > > > +     char dir_xattr_value[64] = {0};
> > > > > > +     int xattr_sz = 0;
> > > > > > +
> > > > > > +     xattr_sz = bpf_getxattr(bprm->file->f_path.dentry,
> > > > > > +                             bprm->file->f_path.dentry->d_inode, XATTR_NAME,
> > > > > > +                             dir_xattr_value, 64);
> > > > >
> > > > > Yeah, this isn't right. You're not accounting for the caller's userns
> > > > > nor for the idmapped mount. If this is supposed to work you will need a
> > > > > variant of vfs_getxattr() that takes the mount's idmapping into account
> > > > > afaict. See what needs to happen after do_getxattr().
> > > >
> > > > Thanks for taking a look.
> > > >
> > > > So, If I understand correctly, we don't need xattr_permission (and
> > > > other checks in
> > > > vfs_getxattr) here as the BPF programs run as CAP_SYS_ADMIN.
> > > >
> > > > but...
> > > >
> > > > So, Is this bit what's missing then?
> > > >
> > > > error = vfs_getxattr(mnt_userns, d, kname, ctx->kvalue, ctx->size);
> > > > if (error > 0) {
> > > >     if ((strcmp(kname, XATTR_NAME_POSIX_ACL_ACCESS) == 0) ||
> > > > (strcmp(kname, XATTR_NAME_POSIX_ACL_DEFAULT) == 0))
> > > >         posix_acl_fix_xattr_to_user(mnt_userns, d_inode(d),
> > > >             ctx->kvalue, error);
> > >
> > > That will not be correct.
> > > posix_acl_fix_xattr_to_user checking current_user_ns()
> > > is checking random tasks that happen to be running
> > > when lsm hook got invoked.
> > >
> > > KP,
> > > we probably have to document clearly that neither 'current*'
> > > should not be used here.
> > > xattr_permission also makes little sense in this context.
> > > If anything it can be a different kfunc if there is a use case,
> > > but I don't see it yet.
> > > bpf-lsm prog calling __vfs_getxattr is just like other lsm-s that
> > > call it directly. It's the kernel that is doing its security thing.
> >
> > Right, but LSMs usually only retrieve their own xattr namespace (ima,
> > selinux, smack) or they calculate hashes for xattrs based on the raw
> > filesystem xattr values (evm).
> >
> > But this new bpf_getxattr() is different. It allows to retrieve _any_
> > xattr in any security hook it can be attached to. So someone can write a
> > bpf program that retrieves filesystem capabilites or posix acls. And
> > these are xattrs that require higher-level vfs involvement to be
> > sensible in most contexts.
> >
> > So looking at:
> >
> > SEC("lsm.s/bprm_committed_creds")
> > void BPF_PROG(bprm_cc, struct linux_binprm *bprm)
> > {
> >       struct task_struct *current = bpf_get_current_task_btf();
> >       char dir_xattr_value[64] = {0};
> >       int xattr_sz = 0;
> >
> >       xattr_sz = bpf_getxattr(bprm->file->f_path.dentry,
> >                               bprm->file->f_path.dentry->d_inode, XATTR_NAME,
> >                               dir_xattr_value, 64);
> >
> >       if (xattr_sz <= 0)
> >               return;
> >
> >       if (!bpf_strncmp(dir_xattr_value, sizeof(XATTR_VALUE), XATTR_VALUE))
> >               result = 1;
> > }
> >
> > This hooks a bpf-lsm program to the security_bprm_committed_creds()
> > hook. It then retrieves the extended attributes of the file to be
> > executed. The hook currently always retrieves the raw filesystem values.
> >
> > But for example any XATTR_NAME_CAPS filesystem capabilities that
> > might've been stored will be taken into account during exec. And both
> > the idmapping of the mount and the caller matter when determing whether
> > they are used or not.
> >
> > But the current implementation of bpf_getxattr() just ignores both. It
> > will always retrieve the raw filesystem values. So if one invokes this
> > hook they're not actually retrieving the values as they are seen by
> > fs/exec.c. And I'm wondering why that is ok? And even if this is ok for
> > some use-cases it might very well become a security issue in others if
> > access decisions are always based on the raw values.
> >
> > I'm not well-versed in this so bear with me, please.
>
> If this is really just about retrieving the "security.bpf" xattr and no
> other xattr then the bpf_getxattr() variant should somehow hard-code
> that to ensure that no other xattrs can be retrieved, imho.

All of these restrictions look very artificial to me.
Especially the part "might very well become a security issue"
just doesn't click.
We're talking about bpf-lsm progs here that implement security.
Can somebody implement a poor bpf-lsm that doesn't enforce
any actual security? Sure. It's a code.
No one complains about the usage of EXPORT_SYMBOL(__vfs_getxattr)
in the existing LSMs like selinux.
No one complains about its usage in out of tree LSMs.
Is that a security issue? Of course not.
__vfs_getxattr is a kernel mechanism that LSMs use to implement
the security features they need.
__vfs_getxattr as kfunc here is pretty much the same as EXPORT_SYMBOL
with a big difference that it's EXPORT_SYMBOL_GPL.
BPF land doesn't have an equivalent of non-gpl export and is not going
to get one.
