Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09EA37B0101
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 11:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjI0Jwf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 05:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjI0Jwe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:52:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5C1E6;
        Wed, 27 Sep 2023 02:52:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FDACC433C8;
        Wed, 27 Sep 2023 09:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695808352;
        bh=VXPzy64VO8OMYFUF9Lq8/LYWzjxp4777wpEdNLgLPO4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B0kcuppnDszjLUg3fyRSEmD/DynnfjEI9CetLkZBEVjlIKPs54E16VYC8A3X2L5Vx
         ko+aCD21e/lSSbzEC6mM7Z5RFMPEeP3snEA4ocOy856bLuZR3BtzaIs1Ep9yteBr+W
         lqStjHeI7rxXxxNUWY7lCp8+7No3QqMcRz0cTKXKo9TZT/7arsD+IK9h6yiRMyj/9g
         nDgydlSmzGKAHUeMJ/0mvx8NxNSu+ZyOUIwH7AqcIlgICz5oFeIZuvbhcRHEoE2gbK
         Vzt2nbHHqjl3YeWhdQEdfGeIcjcS3UXCSgIf2XSuTFhJTCv3Rofp28i/TTj9BJyU6k
         qa9XVKeSC2tFA==
Date:   Wed, 27 Sep 2023 11:52:27 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, keescook@chromium.org,
        lennart@poettering.net, kernel-team@meta.com, sargun@sargun.me
Subject: Re: [PATCH v5 bpf-next 03/13] bpf: introduce BPF token object
Message-ID: <20230927-kaution-ventilator-33a41ee74d63@brauner>
References: <20230919214800.3803828-1-andrii@kernel.org>
 <20230919214800.3803828-4-andrii@kernel.org>
 <20230926-augen-biodiesel-fdb05e859aac@brauner>
 <CAEf4BzaH64kkccc1P-hqQj6Mccr3Q6x059G=A95d=KfU=yBMJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEf4BzaH64kkccc1P-hqQj6Mccr3Q6x059G=A95d=KfU=yBMJQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > > +#define BPF_TOKEN_INODE_NAME "bpf-token"
> > > +
> > > +/* Alloc anon_inode and FD for prepared token.
> > > + * Returns fd >= 0 on success; negative error, otherwise.
> > > + */
> > > +int bpf_token_new_fd(struct bpf_token *token)
> > > +{
> > > +     return anon_inode_getfd(BPF_TOKEN_INODE_NAME, &bpf_token_fops, token, O_CLOEXEC);
> >
> > It's unnecessary to use the anonymous inode infrastructure for bpf
> > tokens. It adds even more moving parts and makes reasoning about it even
> > harder. Just keep it all in bpffs. IIRC, something like the following
> > (broken, non-compiling draft) should work:
> >
> > /* bpf_token_file - get an unlinked file living in bpffs */
> > struct file *bpf_token_file(...)
> > {
> >         inode = bpf_get_inode(bpffs_mnt->mnt_sb, dir, mode);
> >         inode->i_op = &bpf_token_iop;
> >         inode->i_fop = &bpf_token_fops;
> >
> >         // some other stuff you might want or need
> >
> >         res = alloc_file_pseudo(inode, bpffs_mnt, "bpf-token", O_RDWR, &bpf_token_fops);
> > }
> >
> > Now set your private data that you might need, reserve an fd, install
> > the file into the fdtable and return the fd. You should have an unlinked
> > bpffs file that serves as your bpf token.
> 
> Just to make sure I understand. You are saying that instead of having
> `struct bpf_token *` and passing that into internal APIs
> (bpf_token_capable() and bpf_token_allow_xxx()), I should just pass
> around `struct super_block *` representing BPF FS instance? Or `struct
> bpf_mount_opts *` maybe? Or 'struct vfsmount *'? (Any preferences
> here?). Is that right?

No, that's not what I meant.

So, what you're doing right now to create a bpf token file descriptor is:

return anon_inode_getfd(BPF_TOKEN_INODE_NAME, &bpf_token_fops, token, O_CLOEXEC);

which is using the anonymous inode infrastructure. That is an entirely
different filesystems (glossing over details) that is best leveraged for
stuff like kvm fds and other stuff that doesn't need or have its own
filesytem implementation.

But you do have your own filesystem implementation so why abuse another
one to create bpf token fds when they can just be created directly from
the bpffs instance.

IOW, everything stays the same apart from the fact that bpf token fds
are actually file descriptors referring to a detached bpffs file instead
of an anonymous inode file. IOW, bpf tokens are actual bpffs objects
tied to a bpffs instance.

**BROKEN BROKEN BROKEN AND UGLY**

int bpf_token_create(union bpf_attr *attr)
{
        struct inode *inode;
        struct path path;
        struct bpf_mount_opts *mnt_opts;
        struct bpf_token *token;
        struct fd fd;
        int fd, ret;
        struct file *file;

        fd = fdget(attr->token_create.bpffs_path_fd);
        if (!fd.file)
                goto cleanup;

        if (fd.file->f_path->dentry != fd.file->f_path->dentry->d_sb->s_root)
                goto cleanup;

        inode = bpf_get_inode(fd.file->f_path->mnt->mnt_sb, NULL, 1234123412341234);
        if (!inode)
                goto cleanup;

        fd = get_unused_fd_flags(O_RDWR | O_CLOEXEC);
        if (fd < 0)
                goto cleanup;

        clear_nlink(inode); /* make sure it is unlinked */

        file = alloc_file_pseudo(inode, fd.file->f_path->mnt, "bpf-token", O_RDWR, &&bpf_token_fops);
        if (IS_ERR(file))
                goto cleanup;

        token = bpf_token_alloc();
        if (!token)
                goto cleanup;

        /* remember bpffs owning userns for future ns_capable() checks */
        token->userns = get_user_ns(path.dentry->d_sb->s_user_ns);

        mnt_opts = path.dentry->d_sb->s_fs_info;
        token->allowed_cmds = mnt_opts->delegate_cmds;
        token->allowed_maps = mnt_opts->delegate_maps;
        token->allowed_progs = mnt_opts->delegate_progs;
        token->allowed_attachs = mnt_opts->delegate_attachs;

        file->private_data = token;
        fd_install(fd, file);
        return fd;

cleanup:
        // cleanup stuff here
        return -SOME_ERROR;
}
