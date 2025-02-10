Return-Path: <linux-fsdevel+bounces-41391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA323A2EC4F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 13:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21059163AED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 12:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CF22206A4;
	Mon, 10 Feb 2025 12:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNplEuSY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814761F3D41;
	Mon, 10 Feb 2025 12:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739189265; cv=none; b=bqAD15s396VVQG/q0FjZVSvvhVmJTgJZ6sVe3VgUbg58vf6bTNlL5AG0Jx2VwiyLy+1dOZWMplHaZrlb9UshhtPH5P6jkZe1ZwUJnZ2EMR5z5cp/+BjiwraKPfGL44r+VshcTmHo3GWTyZEZyw0sth8YZJSea1ms8y9cWfqTvYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739189265; c=relaxed/simple;
	bh=s181Jubq9d+h3pMYKA+D/39Slev57NIU5oQbDQHj7eQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUkiBB4guLmQVKjKM+sxJTgElr/BFKsKZEuBWGkS/npIZmwLDvEYcLxrWkuxsbGgoui6S5+/0ifkzM+bdJmBEKlry3SgQjLcZB+Lm5nA5bArOD+EkK56mwXQjMgGTqKt9I4Pk5JvakUgAtYAAILJ14edPfKGy15j5B9RnrsoAcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNplEuSY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D46C4CED1;
	Mon, 10 Feb 2025 12:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739189264;
	bh=s181Jubq9d+h3pMYKA+D/39Slev57NIU5oQbDQHj7eQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bNplEuSYbUNSonnGwwBdorihaBhFzzZl6ltXZCcpz8PSyHAhQ+P2dQ2kZmkhRrQpx
	 yiUckDyiUQSobrg3TXQbhc4lqkWaA0WCPeR4K1dWymQTP1Wz3gTTZo6YLSY4CDNmsC
	 g7WoDP28um2UrSnkp6ToI5VeIIsO0e/0QZGx2UamXuQ768pRPcbC1gsnWEgKu8ifGj
	 63nzAH0IOW+LgkOpJaJSfN75oIYWOqd98LQUVvJyhxmaL1eC8rRljVMVgE71wLnJiy
	 c2n0Hjz7RujS9RzZeyTGjfqJoCeZ/QFpAYdi7R0wCuqRI9l+4mU6Bj/YAlw//9GOX5
	 BNv+NEU8dvP+A==
Date: Mon, 10 Feb 2025 13:07:41 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-unionfs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, 
	Mike Baynton <mike@mbaynton.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] fs: support O_PATH fds with FSCONFIG_SET_FD
Message-ID: <20250210-modehaus-unfertig-5935435cabfb@brauner>
References: <20250207-work-overlayfs-v1-0-611976e73373@kernel.org>
 <20250207-work-overlayfs-v1-1-611976e73373@kernel.org>
 <CAOQ4uxg4pCP9EL20vO=X1rwkJ8gVXXzeSDvsxkretH_3hm_nJg@mail.gmail.com>
 <CAOQ4uxhM5j-99ckPzyubdzg66_WBo_39b4_RJKGfVneqnNbxtA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhM5j-99ckPzyubdzg66_WBo_39b4_RJKGfVneqnNbxtA@mail.gmail.com>

On Fri, Feb 07, 2025 at 07:09:44PM +0100, Amir Goldstein wrote:
> On Fri, Feb 7, 2025 at 6:39 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Fri, Feb 7, 2025 at 4:46 PM Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > Let FSCONFIG_SET_FD handle O_PATH file descriptors. This is particularly
> > > useful in the context of overlayfs where layers can be specified via
> > > file descriptors instead of paths. But userspace must currently use
> > > non-O_PATH file desriptors which is often pointless especially if
> > > the file descriptors have been created via open_tree(OPEN_TREE_CLONE).
> > >
> >
> > Shall we?
> > Fixes: a08557d19ef41 ("ovl: specify layers via file descriptors")
> >
> > I think that was the intention of the API and we are not far enough to fix
> > it in 6.12.y.
> >
> 
> Oh it's not in 6.12. it's in 6.13, so less important to backport I guess.
> 
> Thanks,
> Amir.
> 
> >
> > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > ---
> > >  fs/fs_parser.c             | 12 +++++++-----
> > >  fs/fsopen.c                |  7 +++++--
> > >  fs/overlayfs/params.c      | 10 ++++++----
> > >  include/linux/fs_context.h |  1 +
> > >  include/linux/fs_parser.h  |  6 +++---
> > >  5 files changed, 22 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/fs/fs_parser.c b/fs/fs_parser.c
> > > index e635a81e17d9..35aaea224007 100644
> > > --- a/fs/fs_parser.c
> > > +++ b/fs/fs_parser.c
> > > @@ -310,15 +310,17 @@ int fs_param_is_fd(struct p_log *log, const struct fs_parameter_spec *p,
> > >  }
> > >  EXPORT_SYMBOL(fs_param_is_fd);
> > >
> > > -int fs_param_is_file_or_string(struct p_log *log,
> > > -                              const struct fs_parameter_spec *p,
> > > -                              struct fs_parameter *param,
> > > -                              struct fs_parse_result *result)
> > > +int fs_param_is_raw_file_or_string(struct p_log *log,
> >
> > Besides being too long of a helper name I do not think
> > that it correctly reflects the spirit of the question.
> >
> > The arguments for overlayfs upperdir/workdir/lowerdir+/datadir+
> > need to be *a path*, either a path string, or an O_PATH fd and
> > maybe later on also dirfd+name.
> >
> > I imagine that if other filesystems would want to use this parser
> > helper they would need it for the same purpose.
> >
> > Can we maybe come up with a name that better reflects that
> > intention?
> >
> > > +                                  const struct fs_parameter_spec *p,
> > > +                                  struct fs_parameter *param,
> > > +                                  struct fs_parse_result *result)
> > >  {
> > >         switch (param->type) {
> > >         case fs_value_is_string:
> > >                 return fs_param_is_string(log, p, param, result);
> > >         case fs_value_is_file:
> > > +               fallthrough;
> > > +       case fs_value_is_raw_file:
> > >                 result->uint_32 = param->dirfd;
> > >                 if (result->uint_32 <= INT_MAX)
> > >                         return 0;
> > > @@ -328,7 +330,7 @@ int fs_param_is_file_or_string(struct p_log *log,
> > >         }
> > >         return fs_param_bad_value(log, param);
> > >  }
> > > -EXPORT_SYMBOL(fs_param_is_file_or_string);
> > > +EXPORT_SYMBOL(fs_param_is_raw_file_or_string);
> > >
> > >  int fs_param_is_uid(struct p_log *log, const struct fs_parameter_spec *p,
> > >                     struct fs_parameter *param, struct fs_parse_result *result)
> > > diff --git a/fs/fsopen.c b/fs/fsopen.c
> > > index 094a7f510edf..3b5fc9f1f774 100644
> > > --- a/fs/fsopen.c
> > > +++ b/fs/fsopen.c
> > > @@ -451,11 +451,14 @@ SYSCALL_DEFINE5(fsconfig,
> > >                 param.size = strlen(param.name->name);
> > >                 break;
> > >         case FSCONFIG_SET_FD:
> > > -               param.type = fs_value_is_file;
> > >                 ret = -EBADF;
> > > -               param.file = fget(aux);
> > > +               param.file = fget_raw(aux);
> > >                 if (!param.file)
> > >                         goto out_key;
> > > +               if (param.file->f_mode & FMODE_PATH)
> > > +                       param.type = fs_value_is_raw_file;
> > > +               else
> > > +                       param.type = fs_value_is_file;
> > >                 param.dirfd = aux;
> >
> > Here it even shouts more to me that the distinction is not needed.
> >
> > If the parameter would be defined as
> > fsparam_path_description("workdir",   Opt_workdir),
> > and we set param.type = fs_value_is_path_fd;
> > unconditional to f_mode & FMODE_PATH, because we
> > do not care if fd is O_PATH or not for the purpose of this parameter
> > we only care that the parameter *can* be resolved to a path
> > and *how* to resolve it to a path, and the answer to those questions
> > does not change depending on _mode & FMODE_PATH.
> >
> > I admit that that's a very long rant about a mostly meaningless nuance,
> > and I was also not very involved in the development of the new mount API
> > so there may be things about it that I don't understand, so feel free to
> > dismiss this rant and add my Ack if you do not share my concerns.

So the reason I originally carried this distinction into the api was
that autofs can't use O_PATH fds. It needs a fully functional pipe. And
I was worried that just enabling them would break it. That's probably
not an issue because the code checks if (!(pipe->f_mode & FMODE_CAN_WRITE))
which isn't set for FMODE_PATH/O_PATH file descriptors. So that's
probably safe. So I agree we could erradicate this distinction for now.

