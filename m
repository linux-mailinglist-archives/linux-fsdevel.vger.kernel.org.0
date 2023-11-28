Return-Path: <linux-fsdevel+bounces-4017-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA357FB554
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 10:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56199B2164E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 09:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AFA3EA65;
	Tue, 28 Nov 2023 09:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJwYOtVA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E16310A32;
	Tue, 28 Nov 2023 09:13:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 199F1C433C7;
	Tue, 28 Nov 2023 09:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701162818;
	bh=T7hBcwa5USfiGcIefyizkPkv6zBH40PIfTtTgfhZNF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UJwYOtVA5kHN61FW963/B374fpDkxQjGELwNAD17FSh7hRvIH2y5ThXOYt9XnQpUo
	 6fyPrwOkuCfxyIWyYrSCzatAFjdtRTD+lf4T5G0wcUSZBoijtd+MZlCNs5w8opkM24
	 VEiZ1bUaWz8099EwvTDpFD4HwR7vChnR9zouZCu3QtRAbz72QRV1XUH0JQGxY5P9mk
	 6/Odm4UKynVzBHiEqIJpr1aUo0a72A6psPMEaJqztID48EuSZ+NZYBFccU4Mv5h4AT
	 BqdbJcq8J0uAPGHcDIswLB1sW/yT3YSgd0QPYrN+Q/xXTT3obCAdWxOayIlI0dhikx
	 QJb23zyjsl1zw==
Date: Tue, 28 Nov 2023 10:13:31 +0100
From: Christian Brauner <brauner@kernel.org>
To: Song Liu <song@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
	ebiggers@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
	viro@zeniv.linux.org.uk, casey@schaufler-ca.com, amir73il@gmail.com,
	kpsingh@kernel.org, roberto.sassu@huawei.com
Subject: Re: [PATCH v13 bpf-next 1/6] bpf: Add kfunc bpf_get_file_xattr
Message-ID: <20231128-hermachen-westen-74b7951e8e38@brauner>
References: <20231123233936.3079687-1-song@kernel.org>
 <20231123233936.3079687-2-song@kernel.org>
 <20231124-heilung-wohnumfeld-6b7797c4d41a@brauner>
 <CAPhsuW7BFzsBv48xgbY4-2xhG1-GazBuQq_pnaUrJqY1q_H27w@mail.gmail.com>
 <20231127-auffiel-wutentbrannt-7b8b3efb09e4@brauner>
 <CAPhsuW4qP=VYhQ8BTOA3WFhu2LW+cjQ0YtdAVcj-kY_3r4yjnA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW4qP=VYhQ8BTOA3WFhu2LW+cjQ0YtdAVcj-kY_3r4yjnA@mail.gmail.com>

On Mon, Nov 27, 2023 at 10:05:23AM -0800, Song Liu wrote:
> Hi Christian,
> 
> Thanks again for your comments.
> 
> On Mon, Nov 27, 2023 at 2:50 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> [...]
> > >
> > > AFAICT, the XATTR_USER_PREFIX above is equivalent to the prefix
> > > check in xattr_permission().
> > >
> > > For inode_permission(), I think it is not required because we already
> > > have the "struct file" of  the target file. Did I misunderstand something
> > > here?
> >
> > I had overlooked that you don't allow writing xattrs. But there's still
> > some issues:
> >
> > So if you look at the system call interface:
> >
> > fgetxattr(fd)
> > -> getxattr()
> >    -> do_getxattr()
> >       -> vfs_getxattr()
> >          -> xattr_permission()
> >          -> __vfs_getxattr()
> >
> > and io_uring:
> >
> > do_getxattr()
> > -> vfs_getxattr()
> >    -> xattr_permission()
> >    -> __vfs_getxattr()
> >
> > you can see that xattr_permission() is a _read/write-time check_, not an
> > open check. That's because the read/write permissions may depend on what
> > xattr is read/written. Since you don't know what xattr will be
> > read/written at open-time.
> >
> > So there needs to be a good reason for bpf_get_file_xattr() to deviate
> > from the system call and io_uring interface. And I'd like to hear it,
> > please. :)
> >
> > I think I might see the argument because you document the helper as "may
> > only be called from BPF LSM function" in which case you're trying to say
> > that bpf_get_file_xattr() is equivalent to a call to __vfs_getxattr()
> > from an LSM to get at it's own security xattr.
> >
> > But if that's the case you really should have a way to verify that these
> > helpers are only callable from a specific BPF context. Because you
> > otherwise omit read/write-time permission checking when retrieving
> > xattrs which is a potentialy security issue and may be abused by a BPF
> > program to skip permission checks that are otherwise enforced.
> 
> What do you mean by "a specific BPF context"? Current implementation
> makes sure the helper only works on LSM hooks with "struct file *" in the
> argument list. Specifically, we can only use them from the following hooks:
> 
>     security_binder_transfer_file
>     security_bprm_creds_from_file
>     security_file_permission
>     security_file_alloc_security
>     security_file_free_security
>     security_file_ioctl
>     security_mmap_file
>     security_file_lock
>     security_file_fcntl
>     security_file_set_fowner
>     security_file_receive
>     security_file_open
>     security_file_truncate
>     security_kernel_read_file
>     security_kernel_post_read_file

Ok, good!

> Note that, we disallow pointer-walking with the kfunc, so the kfunc is not
> allowed from hooks with indirect access to "struct file". For example, we
> cannot use it with security_bprm_creds_for_exec(struct linux_binprm *bprm)
> as this hook only has bprm, and calling bpf_get_file_xattr(bprm->file) is
> not allowed.

Great.

> 
> > Is there a way for BPF to enforce/verify that a function is only called
> > from a specific BPF program? It should be able to recognize that, no?
> > And then refuse to load that BPF program if a helper is called outside
> > it's intended context.
> 
> Similarly, I am not quite sure what you mean by "a specific BPF program".
> My answer to this is probably the same as above.

Yes, this is exactly what I meant.

> 
> Going back to xattr_permission itself. AFAICT, it does 3 checks:
> 
> 1. MAY_WRITE check;
> 2. prefix check;
> 3. inode_permission().
> 
> We don't need MAY_WRITE check as bpf_get_file_xattr is read only.
> We have the prefix check embedded in bpf_get_file_xattr():
> 
>        if (strncmp(name__str, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN))
>                return -EPERM;
> 
> inode_permission() is a little trickier here, which checks against idmap.
> However, I don't think the check makes sense in the context of LSM.
> In this case, we have two processes: one security daemon, which
> owns the BPF LSM program, and a process being monitored.
> idmap here, from file_mnt_idmap(file), is the idmap from the being
> monitored process. However, whether the BPF LSM program have the
> permission to read the xattr should be determined by the security
> daemon.
> 
> Overall, we can technically add xattr_permission() check here. But I
> don't think that's the right check for the LSM use case.
> 
> Does this make sense? Did I miss or misunderstand something?

If the helper is only callable from an LSM context then this should be
fine.

