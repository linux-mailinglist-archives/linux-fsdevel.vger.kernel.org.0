Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B1255FA27
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jun 2022 10:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbiF2ILb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jun 2022 04:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbiF2ILa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jun 2022 04:11:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5757A3BBD4;
        Wed, 29 Jun 2022 01:11:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D430361D41;
        Wed, 29 Jun 2022 08:11:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3E6C34114;
        Wed, 29 Jun 2022 08:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656490285;
        bh=6+OrsmtGCc1gPtA2wNdANS55mU+2HXL463A3lXrw9FU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BFoXsKUQMu1HS/gKZE4wvEGJWCN3tEsEL/iaE9b19lWEm4coU9qlXRp+VexJTYRsG
         /nJXLIkMghFDjQ0RcXgO55R55SartSPlau7AlPQgjy/PkLFONfd4c3dOQp5LIbZjH1
         M1Dub6tNazNaCZdd987WNvxrqUDRGynjUwBlPVIaFrgqbOxlYlXPpaIxaTvGL0z3sc
         N31uQJ+ZAz5cC4LCZhjFDqwAnbqPEycHRj6sZaTZSnhGpGVUiRWBlAn5tX1d5u5VJL
         7/2NtkypWWfRycKWXQ0LDkmX/Y1WvZte4KQKOBNXz3sTTklzR9v+jzNHFa3Hiy5q9k
         4HSbmvPNgqapg==
Date:   Wed, 29 Jun 2022 10:11:19 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH v5 bpf-next 5/5] bpf/selftests: Add a selftest for
 bpf_getxattr
Message-ID: <20220629081119.ddqvfn3al36fl27q@wittgenstein>
References: <20220628161948.475097-1-kpsingh@kernel.org>
 <20220628161948.475097-6-kpsingh@kernel.org>
 <20220628173344.h7ihvyl6vuky5xus@wittgenstein>
 <CACYkzJ5ij9rth_v3KQrCVYsQr2STBEWq1EAzkDb5D06CoRRSjA@mail.gmail.com>
 <CAADnVQ+mokn3Yo492Zng=Gtn_LgT-T1XLth5BXyKZXFno-3ZDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAADnVQ+mokn3Yo492Zng=Gtn_LgT-T1XLth5BXyKZXFno-3ZDg@mail.gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 28, 2022 at 03:28:42PM -0700, Alexei Starovoitov wrote:
> On Tue, Jun 28, 2022 at 10:52 AM KP Singh <kpsingh@kernel.org> wrote:
> >
> > On Tue, Jun 28, 2022 at 7:33 PM Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > On Tue, Jun 28, 2022 at 04:19:48PM +0000, KP Singh wrote:
> > > > A simple test that adds an xattr on a copied /bin/ls and reads it back
> > > > when the copied ls is executed.
> > > >
> > > > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > > > ---
> > > >  .../testing/selftests/bpf/prog_tests/xattr.c  | 54 +++++++++++++++++++
> >
> > [...]
> >
> > > > +SEC("lsm.s/bprm_committed_creds")
> > > > +void BPF_PROG(bprm_cc, struct linux_binprm *bprm)
> > > > +{
> > > > +     struct task_struct *current = bpf_get_current_task_btf();
> > > > +     char dir_xattr_value[64] = {0};
> > > > +     int xattr_sz = 0;
> > > > +
> > > > +     xattr_sz = bpf_getxattr(bprm->file->f_path.dentry,
> > > > +                             bprm->file->f_path.dentry->d_inode, XATTR_NAME,
> > > > +                             dir_xattr_value, 64);
> > >
> > > Yeah, this isn't right. You're not accounting for the caller's userns
> > > nor for the idmapped mount. If this is supposed to work you will need a
> > > variant of vfs_getxattr() that takes the mount's idmapping into account
> > > afaict. See what needs to happen after do_getxattr().
> >
> > Thanks for taking a look.
> >
> > So, If I understand correctly, we don't need xattr_permission (and
> > other checks in
> > vfs_getxattr) here as the BPF programs run as CAP_SYS_ADMIN.
> >
> > but...
> >
> > So, Is this bit what's missing then?
> >
> > error = vfs_getxattr(mnt_userns, d, kname, ctx->kvalue, ctx->size);
> > if (error > 0) {
> >     if ((strcmp(kname, XATTR_NAME_POSIX_ACL_ACCESS) == 0) ||
> > (strcmp(kname, XATTR_NAME_POSIX_ACL_DEFAULT) == 0))
> >         posix_acl_fix_xattr_to_user(mnt_userns, d_inode(d),
> >             ctx->kvalue, error);
> 
> That will not be correct.
> posix_acl_fix_xattr_to_user checking current_user_ns()
> is checking random tasks that happen to be running
> when lsm hook got invoked.
> 
> KP,
> we probably have to document clearly that neither 'current*'
> should not be used here.
> xattr_permission also makes little sense in this context.
> If anything it can be a different kfunc if there is a use case,
> but I don't see it yet.
> bpf-lsm prog calling __vfs_getxattr is just like other lsm-s that
> call it directly. It's the kernel that is doing its security thing.

Right, but LSMs usually only retrieve their own xattr namespace (ima,
selinux, smack) or they calculate hashes for xattrs based on the raw
filesystem xattr values (evm).

But this new bpf_getxattr() is different. It allows to retrieve _any_
xattr in any security hook it can be attached to. So someone can write a
bpf program that retrieves filesystem capabilites or posix acls. And
these are xattrs that require higher-level vfs involvement to be
sensible in most contexts.

So looking at:

SEC("lsm.s/bprm_committed_creds")
void BPF_PROG(bprm_cc, struct linux_binprm *bprm)
{
	struct task_struct *current = bpf_get_current_task_btf();
	char dir_xattr_value[64] = {0};
	int xattr_sz = 0;

	xattr_sz = bpf_getxattr(bprm->file->f_path.dentry,
				bprm->file->f_path.dentry->d_inode, XATTR_NAME,
				dir_xattr_value, 64);

	if (xattr_sz <= 0)
		return;

	if (!bpf_strncmp(dir_xattr_value, sizeof(XATTR_VALUE), XATTR_VALUE))
		result = 1;
}

This hooks a bpf-lsm program to the security_bprm_committed_creds()
hook. It then retrieves the extended attributes of the file to be
executed. The hook currently always retrieves the raw filesystem values.

But for example any XATTR_NAME_CAPS filesystem capabilities that
might've been stored will be taken into account during exec. And both
the idmapping of the mount and the caller matter when determing whether
they are used or not.

But the current implementation of bpf_getxattr() just ignores both. It
will always retrieve the raw filesystem values. So if one invokes this
hook they're not actually retrieving the values as they are seen by
fs/exec.c. And I'm wondering why that is ok? And even if this is ok for
some use-cases it might very well become a security issue in others if
access decisions are always based on the raw values.

I'm not well-versed in this so bear with me, please.
