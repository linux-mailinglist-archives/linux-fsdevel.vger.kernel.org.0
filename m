Return-Path: <linux-fsdevel+bounces-4404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4797FF2BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 15:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B31FAB207F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2364851008
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXFH6GC4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606593C694;
	Thu, 30 Nov 2023 14:06:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4BBCC433C8;
	Thu, 30 Nov 2023 14:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701353161;
	bh=Uxb8lq8gQHpjrno1KoUwg1Mus2BJGIAIKr4LDCZRUNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fXFH6GC4ec+qG45QCOxHIa7R+/kEhagCw+QYo9IaZmHN4naDQl9a+72pdSrS9y61w
	 dPPw+2YkiAVNC5XfuOtK8joEFE7mCCmo4a3sqfprj6+tjY4Epemz2n6nEeuVJ3HbEB
	 WY1TzV+YzZUJZzZC/Pl868iTHzZp0F0zWFUFh17nlw8PvAM9vWfHFpCH/RPKo8Mdsu
	 ND/sMLJXGzwbHwE82YKWjsjkGkWeK2VSnWqvt1RPU50ojF8fof4vZO00nZMxz1JplS
	 sYHtUB/AAbkfbgrpBldubTOhddobm4aSsjgKGr9eNkIbhFosXiS1mxFxKi9FFx2PM1
	 R1khGriFf0JRQ==
Date: Thu, 30 Nov 2023 15:05:56 +0100
From: Christian Brauner <brauner@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, paul@paul-moore.com,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, keescook@chromium.org,
	kernel-team@meta.com, sargun@sargun.me
Subject: Re: [PATCH v11 bpf-next 03/17] bpf: introduce BPF token object
Message-ID: <20231130-schaukeln-knurren-7fddaf4c0494@brauner>
References: <20231127190409.2344550-1-andrii@kernel.org>
 <20231127190409.2344550-4-andrii@kernel.org>
 <CAEf4BzauJjmqMdgqBrsvmXjATj4s6Om94BV471LwwdmJpx3PjQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzauJjmqMdgqBrsvmXjATj4s6Om94BV471LwwdmJpx3PjQ@mail.gmail.com>

On Tue, Nov 28, 2023 at 04:05:36PM -0800, Andrii Nakryiko wrote:
> On Mon, Nov 27, 2023 at 11:06 AM Andrii Nakryiko <andrii@kernel.org> wrote:
> >
> > Add new kind of BPF kernel object, BPF token. BPF token is meant to
> > allow delegating privileged BPF functionality, like loading a BPF
> > program or creating a BPF map, from privileged process to a *trusted*
> > unprivileged process, all while having a good amount of control over which
> > privileged operations could be performed using provided BPF token.
> >
> > This is achieved through mounting BPF FS instance with extra delegation
> > mount options, which determine what operations are delegatable, and also
> > constraining it to the owning user namespace (as mentioned in the
> > previous patch).
> >
> > BPF token itself is just a derivative from BPF FS and can be created
> > through a new bpf() syscall command, BPF_TOKEN_CREATE, which accepts BPF
> > FS FD, which can be attained through open() API by opening BPF FS mount
> > point. Currently, BPF token "inherits" delegated command, map types,
> > prog type, and attach type bit sets from BPF FS as is. In the future,
> > having an BPF token as a separate object with its own FD, we can allow
> > to further restrict BPF token's allowable set of things either at the
> > creation time or after the fact, allowing the process to guard itself
> > further from unintentionally trying to load undesired kind of BPF
> > programs. But for now we keep things simple and just copy bit sets as is.
> >
> > When BPF token is created from BPF FS mount, we take reference to the
> > BPF super block's owning user namespace, and then use that namespace for
> > checking all the {CAP_BPF, CAP_PERFMON, CAP_NET_ADMIN, CAP_SYS_ADMIN}
> > capabilities that are normally only checked against init userns (using
> > capable()), but now we check them using ns_capable() instead (if BPF
> > token is provided). See bpf_token_capable() for details.
> >
> > Such setup means that BPF token in itself is not sufficient to grant BPF
> > functionality. User namespaced process has to *also* have necessary
> > combination of capabilities inside that user namespace. So while
> > previously CAP_BPF was useless when granted within user namespace, now
> > it gains a meaning and allows container managers and sys admins to have
> > a flexible control over which processes can and need to use BPF
> > functionality within the user namespace (i.e., container in practice).
> > And BPF FS delegation mount options and derived BPF tokens serve as
> > a per-container "flag" to grant overall ability to use bpf() (plus further
> > restrict on which parts of bpf() syscalls are treated as namespaced).
> >
> > Note also, BPF_TOKEN_CREATE command itself requires ns_capable(CAP_BPF)
> > within the BPF FS owning user namespace, rounding up the ns_capable()
> > story of BPF token.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  include/linux/bpf.h            |  41 +++++++
> >  include/uapi/linux/bpf.h       |  37 ++++++
> >  kernel/bpf/Makefile            |   2 +-
> >  kernel/bpf/inode.c             |  17 ++-
> >  kernel/bpf/syscall.c           |  17 +++
> >  kernel/bpf/token.c             | 209 +++++++++++++++++++++++++++++++++
> >  tools/include/uapi/linux/bpf.h |  37 ++++++
> >  7 files changed, 350 insertions(+), 10 deletions(-)
> >  create mode 100644 kernel/bpf/token.c
> >
> 
> [...]
> 
> > +int bpf_token_create(union bpf_attr *attr)
> > +{
> > +       struct bpf_mount_opts *mnt_opts;
> > +       struct bpf_token *token = NULL;
> > +       struct user_namespace *userns;
> > +       struct inode *inode;
> > +       struct file *file;
> > +       struct path path;
> > +       struct fd f;
> > +       umode_t mode;
> > +       int err, fd;
> > +
> > +       f = fdget(attr->token_create.bpffs_fd);
> > +       if (!f.file)
> > +               return -EBADF;
> > +
> > +       path = f.file->f_path;
> > +       path_get(&path);
> > +       fdput(f);
> > +
> > +       if (path.dentry != path.mnt->mnt_sb->s_root) {
> > +               err = -EINVAL;
> > +               goto out_path;
> > +       }
> > +       if (path.mnt->mnt_sb->s_op != &bpf_super_ops) {
> > +               err = -EINVAL;
> > +               goto out_path;
> > +       }
> > +       err = path_permission(&path, MAY_ACCESS);
> > +       if (err)
> > +               goto out_path;
> > +
> > +       userns = path.dentry->d_sb->s_user_ns;
> > +       /*
> > +        * Enforce that creators of BPF tokens are in the same user
> > +        * namespace as the BPF FS instance. This makes reasoning about
> > +        * permissions a lot easier and we can always relax this later.
> > +        */
> > +       if (current_user_ns() != userns) {
> > +               err = -EPERM;
> > +               goto out_path;
> > +       }

I should note that the reason I'm saying it makes reasoning about
permissions easier is that this here guarantees that:

file->f_cred->user_ns == file->f_path.dentry->d_sb->s_user_ns

So cases where you would need to check that you have permissions in the
openers userns are equivalent to checking permissions in the token's and
therefore bpffs' userns.

> 
> Hey Christian,
> 
> I've added stricter userns check as discussed on previous revision,
> and a few lines above fixed BPF FS root check (path.dentry !=
> path.mnt->mnt_sb->s_root). Hopefully that addresses the remaining
> concerns you've had.
> 
> I'd appreciate it if you could take another look to double check if
> I'm not messing anything up, and if it all looks good, can I please
> get an ack from you? Thank you!

I'll take a look.

