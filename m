Return-Path: <linux-fsdevel+bounces-34793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5170F9C8CAD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 15:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E399FB2F10E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 14:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192ACBA53;
	Thu, 14 Nov 2024 14:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZSWk4VW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEBF2BAEF;
	Thu, 14 Nov 2024 14:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731593794; cv=none; b=XBxb45PJNraCYafJZ5Ch35F81jY2Q5yvtD+EKKVyBbml2jabhl2gKPzzxSmS/7kuJDQhH1DJzPBcSrwDoekGzjkhoqQinXp7pjIC9QkMrBzd+xf8MA0PyThKwXQ/SbxR6g+rih8SQ8E4kND8Mih86Xg+Nq1vwg9bP+mfL+QnoFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731593794; c=relaxed/simple;
	bh=8sAvdc8wyZI/7KPkZZEqmG8oX49PlB533Ukf6K+rw7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QptXBgBkmAqpajbm4EGlfULcYQlL3tTbbwYcoc3+dV0Mx3ebHfcS2vThUYW9jNqJZetpRsaPWkpYpbuvqDikgpoCpEwkXPLRCb8MgoUPUlHAhdxhle8HPrFYTnwYPnPboDQE9LAAquHoM3Dt/Q6eL6KJmQjwVXfwhoxCbD5tTjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZSWk4VW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08C6C4CECD;
	Thu, 14 Nov 2024 14:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731593794;
	bh=8sAvdc8wyZI/7KPkZZEqmG8oX49PlB533Ukf6K+rw7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LZSWk4VWBVDlTHt4IovWDbPZvgaK4OS9qiEbhAk0QiISiaL4sSKbEbsoV7PsWrACr
	 5jZU4pV+Wr6VDJF1V7DqJXknMoUsepOwn5Qk9Ykw5JT16tET7ALaDBfXaflMP5v0RD
	 kZzNqf2N3xEmKrdVyIdoRXe4AmQO4vMb1hO6Etnv3YEwcqqSSzbORrQU/onV6njPxC
	 pl7UALeEq+rLW0Sysx6O2osbp/wFebs5wt1EyzHSLwgMBa0jw843ez7oCr9JyJnJNs
	 pcgrM/oujABLsPpJT5SVzaq092P6wvfeC9z2rQDN/7sYzD93SInD5oQdDiH/N918Iu
	 rj02ctprzKzEQ==
Date: Thu, 14 Nov 2024 15:16:28 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Erin Shepherd <erin.shepherd@e43.eu>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 2/3] exportfs: allow fs to disable CAP_DAC_READ_SEARCH
 check
Message-ID: <20241114-stuhl-verzaubern-0a3c711b221d@brauner>
References: <20241113-pidfs_fh-v2-0-9a4d28155a37@e43.eu>
 <20241113-pidfs_fh-v2-2-9a4d28155a37@e43.eu>
 <CAOQ4uxgoT34WXFYncvPCZHwd2y3viaXjR=j08jM9c3x20Ar8Tg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgoT34WXFYncvPCZHwd2y3viaXjR=j08jM9c3x20Ar8Tg@mail.gmail.com>

On Thu, Nov 14, 2024 at 07:37:19AM +0100, Amir Goldstein wrote:
> On Wed, Nov 13, 2024 at 8:11 PM Erin Shepherd <erin.shepherd@e43.eu> wrote:
> >
> > For pidfs, there is no reason to restrict file handle decoding by
> > CAP_DAC_READ_SEARCH. Introduce an export_ops flag that can indicate
> > this
> >
> > Signed-off-by: Erin Shepherd <erin.shepherd@e43.eu>
> > ---
> >  fs/fhandle.c             | 36 +++++++++++++++++++++---------------
> >  include/linux/exportfs.h |  3 +++
> >  2 files changed, 24 insertions(+), 15 deletions(-)
> >
> > diff --git a/fs/fhandle.c b/fs/fhandle.c
> > index 82df28d45cd70a7df525f50bbb398d646110cd99..056116e58f43983bc7bb86da170fb554c7a2fac7 100644
> > --- a/fs/fhandle.c
> > +++ b/fs/fhandle.c
> > @@ -235,26 +235,32 @@ static int do_handle_to_path(struct file_handle *handle, struct path *path,
> >         return 0;
> >  }
> >
> > -/*
> > - * Allow relaxed permissions of file handles if the caller has the
> > - * ability to mount the filesystem or create a bind-mount of the
> > - * provided @mountdirfd.
> > - *
> > - * In both cases the caller may be able to get an unobstructed way to
> > - * the encoded file handle. If the caller is only able to create a
> > - * bind-mount we need to verify that there are no locked mounts on top
> > - * of it that could prevent us from getting to the encoded file.
> > - *
> > - * In principle, locked mounts can prevent the caller from mounting the
> > - * filesystem but that only applies to procfs and sysfs neither of which
> > - * support decoding file handles.
> > - */
> >  static inline bool may_decode_fh(struct handle_to_path_ctx *ctx,
> >                                  unsigned int o_flags)
> >  {
> >         struct path *root = &ctx->root;
> > +       struct export_operations *nop = root->mnt->mnt_sb->s_export_op;
> > +
> > +       if (nop && nop->flags & EXPORT_OP_UNRESTRICTED_OPEN)
> > +               return true;
> > +
> > +       if (capable(CAP_DAC_READ_SEARCH))
> > +               return true;
> >
> >         /*
> > +        * Allow relaxed permissions of file handles if the caller has the
> > +        * ability to mount the filesystem or create a bind-mount of the
> > +        * provided @mountdirfd.
> > +        *
> > +        * In both cases the caller may be able to get an unobstructed way to
> > +        * the encoded file handle. If the caller is only able to create a
> > +        * bind-mount we need to verify that there are no locked mounts on top
> > +        * of it that could prevent us from getting to the encoded file.
> > +        *
> > +        * In principle, locked mounts can prevent the caller from mounting the
> > +        * filesystem but that only applies to procfs and sysfs neither of which
> > +        * support decoding file handles.
> > +        *
> >          * Restrict to O_DIRECTORY to provide a deterministic API that avoids a
> >          * confusing api in the face of disconnected non-dir dentries.
> >          *
> > @@ -293,7 +299,7 @@ static int handle_to_path(int mountdirfd, struct file_handle __user *ufh,
> >         if (retval)
> >                 goto out_err;
> >
> > -       if (!capable(CAP_DAC_READ_SEARCH) && !may_decode_fh(&ctx, o_flags)) {
> > +       if (!may_decode_fh(&ctx, o_flags)) {
> >                 retval = -EPERM;
> >                 goto out_path;
> >         }
> > diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> > index 893a1d21dc1c4abc7e52325d7a4cf0adb407f039..459508b53e77ed0597cee217ffe3d82cc7cc11a4 100644
> > --- a/include/linux/exportfs.h
> > +++ b/include/linux/exportfs.h
> > @@ -247,6 +247,9 @@ struct export_operations {
> >                                                 */
> >  #define EXPORT_OP_FLUSH_ON_CLOSE       (0x20) /* fs flushes file data on close */
> >  #define EXPORT_OP_ASYNC_LOCK           (0x40) /* fs can do async lock request */
> > +#define EXPORT_OP_UNRESTRICTED_OPEN    (0x80) /* FS allows open_by_handle_at
> > +                                                 without CAP_DAC_READ_SEARCH
> > +                                               */
> 
> Don't love the name, but I wonder, isn't SB_NOUSER already a good
> enough indication that CAP_DAC_READ_SEARCH is irrelevant?
> 
> Essentially, mnt_fd is the user's proof that they can access the mount
> and CAP_DAC_READ_SEARCH is the legacy "proof" that the user can
> reach from mount the inode by path lookup.
> 
> Which reminds me, what is the mnt_fd expected for opening a pidfd
> file by handle?

int pidfd_self = pidfd_open(getpid(), 0);
open_by_handle_at(pidfd_self, ...);

is sufficient.

