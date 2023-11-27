Return-Path: <linux-fsdevel+bounces-3920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 433D27F9DEF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 11:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83FD0B20F4E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 10:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB4118C24;
	Mon, 27 Nov 2023 10:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ftMg0vzH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE32882D;
	Mon, 27 Nov 2023 10:50:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A62C433C7;
	Mon, 27 Nov 2023 10:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701082237;
	bh=3AYPU0frHlMPVrdGxo06XIPS+4pu4DqK6g4kMCoC8ss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ftMg0vzHLhGm6NyG3Ds3de8VbM6wW771lfXbrFlS8CZF9b9u+ilwF8ghBZiFGXZbm
	 k+qFiD29r0tMlFI5s4FprIs69Uc67o5J8S6hSZGVCXmlPFCJYGzpf1dyhWZTX28R7E
	 NmWCKw4fH665hmfbFeqMk9cRpG14RwUtRnuaHO+NlZEpa/hl/f6AcuZ0XVg1CFplpQ
	 AhHy3JmGDvDm4yhZUgQdBbMYpVtXQEYdZ+4IwkfjmcAWUjsa0cGne1jc5+oVw4wSFa
	 leRxcjTgketq59GOV2GhK5O1WUFzKUUeNLpGcm/XFxgxg8Eo+LqQTUBlGdqCHkPD0A
	 1c1ObzE5KQpqw==
Date: Mon, 27 Nov 2023 11:50:31 +0100
From: Christian Brauner <brauner@kernel.org>
To: Song Liu <song@kernel.org>, ast@kernel.org, daniel@iogearbox.net
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
	ebiggers@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
	viro@zeniv.linux.org.uk, casey@schaufler-ca.com, amir73il@gmail.com,
	kpsingh@kernel.org, roberto.sassu@huawei.com
Subject: Re: [PATCH v13 bpf-next 1/6] bpf: Add kfunc bpf_get_file_xattr
Message-ID: <20231127-auffiel-wutentbrannt-7b8b3efb09e4@brauner>
References: <20231123233936.3079687-1-song@kernel.org>
 <20231123233936.3079687-2-song@kernel.org>
 <20231124-heilung-wohnumfeld-6b7797c4d41a@brauner>
 <CAPhsuW7BFzsBv48xgbY4-2xhG1-GazBuQq_pnaUrJqY1q_H27w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW7BFzsBv48xgbY4-2xhG1-GazBuQq_pnaUrJqY1q_H27w@mail.gmail.com>

On Fri, Nov 24, 2023 at 09:07:33AM -0800, Song Liu wrote:
> On Fri, Nov 24, 2023 at 12:44 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Thu, Nov 23, 2023 at 03:39:31PM -0800, Song Liu wrote:
> > > It is common practice for security solutions to store tags/labels in
> > > xattrs. To implement similar functionalities in BPF LSM, add new kfunc
> > > bpf_get_file_xattr().
> > >
> > > The first use case of bpf_get_file_xattr() is to implement file
> > > verifications with asymmetric keys. Specificially, security applications
> > > could use fsverity for file hashes and use xattr to store file signatures.
> > > (kfunc for fsverity hash will be added in a separate commit.)
> > >
> > > Currently, only xattrs with "user." prefix can be read with kfunc
> > > bpf_get_file_xattr(). As use cases evolve, we may add a dedicated prefix
> > > for bpf_get_file_xattr().
> > >
> > > To avoid recursion, bpf_get_file_xattr can be only called from LSM hooks.
> > >
> > > Signed-off-by: Song Liu <song@kernel.org>
> > > ---
> >
> > Looks ok to me. But see below for a question.
> >
> > If you ever allow the retrieval of additional extended attributes
> > through bfs_get_file_xattr() or other bpf interfaces we would like to be
> > Cced, please. The xattr stuff is (/me looks for suitable words)...
> >
> > Over the last months we've moved POSIX_ACL retrieval out of these
> > low-level functions. They now have a dedicated api. The same is going to
> > happen for fscaps as well.
> >
> > But even with these out of the way we would want the bpf helpers to
> > always maintain an allowlist of retrievable attributes.
> 
> Agreed. We will be very specific which attributes are available to bpf
> helpers/kfuncs.
> 
> >
> > >  kernel/trace/bpf_trace.c | 63 ++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 63 insertions(+)
> > >
> > > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > > index f0b8b7c29126..55758a6fbe90 100644
> > > --- a/kernel/trace/bpf_trace.c
> > > +++ b/kernel/trace/bpf_trace.c
> > > @@ -24,6 +24,7 @@
> > >  #include <linux/key.h>
> > >  #include <linux/verification.h>
> > >  #include <linux/namei.h>
> > > +#include <linux/fileattr.h>
> > >
> > >  #include <net/bpf_sk_storage.h>
> > >
> > > @@ -1431,6 +1432,68 @@ static int __init bpf_key_sig_kfuncs_init(void)
> > >  late_initcall(bpf_key_sig_kfuncs_init);
> > >  #endif /* CONFIG_KEYS */
> > >
> > > +/* filesystem kfuncs */
> > > +__bpf_kfunc_start_defs();
> > > +
> > > +/**
> > > + * bpf_get_file_xattr - get xattr of a file
> > > + * @file: file to get xattr from
> > > + * @name__str: name of the xattr
> > > + * @value_ptr: output buffer of the xattr value
> > > + *
> > > + * Get xattr *name__str* of *file* and store the output in *value_ptr*.
> > > + *
> > > + * For security reasons, only *name__str* with prefix "user." is allowed.
> > > + *
> > > + * Return: 0 on success, a negative value on error.
> > > + */
> > > +__bpf_kfunc int bpf_get_file_xattr(struct file *file, const char *name__str,
> > > +                                struct bpf_dynptr_kern *value_ptr)
> > > +{
> > > +     struct dentry *dentry;
> > > +     u32 value_len;
> > > +     void *value;
> > > +
> > > +     if (strncmp(name__str, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN))
> > > +             return -EPERM;
> > > +
> > > +     value_len = __bpf_dynptr_size(value_ptr);
> > > +     value = __bpf_dynptr_data_rw(value_ptr, value_len);
> > > +     if (!value)
> > > +             return -EINVAL;
> > > +
> > > +     dentry = file_dentry(file);
> > > +     return __vfs_getxattr(dentry, dentry->d_inode, name__str, value, value_len);
> >
> > By calling __vfs_getxattr() from bpf_get_file_xattr() you're skipping at
> > least inode_permission() from xattr_permission(). I'm probably just
> > missing or forgot the context. But why is that ok?
> 
> AFAICT, the XATTR_USER_PREFIX above is equivalent to the prefix
> check in xattr_permission().
> 
> For inode_permission(), I think it is not required because we already
> have the "struct file" of  the target file. Did I misunderstand something
> here?

I had overlooked that you don't allow writing xattrs. But there's still
some issues:

So if you look at the system call interface:

fgetxattr(fd)
-> getxattr()
   -> do_getxattr()
      -> vfs_getxattr()
         -> xattr_permission()
         -> __vfs_getxattr()

and io_uring:

do_getxattr()
-> vfs_getxattr()
   -> xattr_permission()
   -> __vfs_getxattr()

you can see that xattr_permission() is a _read/write-time check_, not an
open check. That's because the read/write permissions may depend on what
xattr is read/written. Since you don't know what xattr will be
read/written at open-time.

So there needs to be a good reason for bpf_get_file_xattr() to deviate
from the system call and io_uring interface. And I'd like to hear it,
please. :)

I think I might see the argument because you document the helper as "may
only be called from BPF LSM function" in which case you're trying to say
that bpf_get_file_xattr() is equivalent to a call to __vfs_getxattr()
from an LSM to get at it's own security xattr.

But if that's the case you really should have a way to verify that these
helpers are only callable from a specific BPF context. Because you
otherwise omit read/write-time permission checking when retrieving
xattrs which is a potentialy security issue and may be abused by a BPF
program to skip permission checks that are otherwise enforced.

Is there a way for BPF to enforce/verify that a function is only called
from a specific BPF program? It should be able to recognize that, no?
And then refuse to load that BPF program if a helper is called outside
it's intended context.

