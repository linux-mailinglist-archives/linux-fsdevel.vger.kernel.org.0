Return-Path: <linux-fsdevel+bounces-41407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD909A2EEF3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 14:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAF2B3A35BC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 13:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCDF230D07;
	Mon, 10 Feb 2025 13:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmyAbXzi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC3023099E;
	Mon, 10 Feb 2025 13:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739195718; cv=none; b=owqnERdq576Ep6tm6eOdXj7AJmnifRrheQ8OmDiVfxtDbxwuPG4q5yAk6uEFRQ5TQZ+cEqphKSnVX7ZoBMe2MwM1z74O6V6d6ugvTvl25q7Q1CJuKDzgmfMVOqGYrGOr4Ps1w093iRFamXgJS3yfibJgldUJnYZXDoRNmIdW3n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739195718; c=relaxed/simple;
	bh=bPCMAk+P4O3r4JMhqHW+cBZGX57aPQ3MXzkvM8woBQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K69yDcWMBBfJ+7a8uYE5swDMjBAVQL/i8DkrJVr3jrjyYw2BUx7tIYZ6Lx37Om3pBxOeAzziKBh/nU3s7NjIvgU5cdM2xrsKgqW8zu94y4WdmODwGVmKSjwFk/UiVTtPY72R73JrIW1+QaFA/dfH0eiOcYF7HcOZlkxdpCnYEjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmyAbXzi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E55DDC4CEDF;
	Mon, 10 Feb 2025 13:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739195716;
	bh=bPCMAk+P4O3r4JMhqHW+cBZGX57aPQ3MXzkvM8woBQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dmyAbXzik0gcwKokg5/d/ZCMtnzQJXFlNtK598hHT2aGhkGye2UkZtF5zuZ2TZZu3
	 nb0z/+jRyP/qzKT16MI/qdTH0XuTdYdPJEqAt3k/248HW6r0UaelPAc7xEMHIjplO0
	 RKv1U50oOHH2OvMdlcpbrRcj7pF2PTrE8icFCCPCeekaVJFMHqh8KXRZHtwy+frbkK
	 VQXBPEUBWbHZ30lxiSUMG1/jTVgZSnKJNDSd2utHGMOkt7NRtbM0kcg4MEDpJ5fh0I
	 VlkNEwVr0pbvGrJcESg7jjrobw7db217zCvh4AbvYVxQYQC+c+kDZZ7+nzeD9CqTIV
	 7RaZbwZquWGhg==
Date: Mon, 10 Feb 2025 14:55:12 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-unionfs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, 
	Mike Baynton <mike@mbaynton.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] fs: support O_PATH fds with FSCONFIG_SET_FD
Message-ID: <20250210-deppen-zwielicht-306b01568a17@brauner>
References: <20250210-work-overlayfs-v2-0-ed2a949b674b@kernel.org>
 <20250210-work-overlayfs-v2-1-ed2a949b674b@kernel.org>
 <CAOQ4uxgzv-k2hL5pecxt=+2AyRkdr+LGvm9wYYuWxs9LQyyN2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgzv-k2hL5pecxt=+2AyRkdr+LGvm9wYYuWxs9LQyyN2Q@mail.gmail.com>

On Mon, Feb 10, 2025 at 02:26:56PM +0100, Amir Goldstein wrote:
> On Mon, Feb 10, 2025 at 1:39 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > Let FSCONFIG_SET_FD handle O_PATH file descriptors. This is particularly
> > useful in the context of overlayfs where layers can be specified via
> > file descriptors instead of paths. But userspace must currently use
> > non-O_PATH file desriptors which is often pointless especially if
> > the file descriptors have been created via open_tree(OPEN_TREE_CLONE).
> >
> > Fixes: a08557d19ef41 ("ovl: specify layers via file descriptors")
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  fs/autofs/autofs_i.h | 2 ++
> >  fs/fsopen.c          | 2 +-
> >  2 files changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/autofs/autofs_i.h b/fs/autofs/autofs_i.h
> > index 77c7991d89aa..23cea74f9933 100644
> > --- a/fs/autofs/autofs_i.h
> > +++ b/fs/autofs/autofs_i.h
> > @@ -218,6 +218,8 @@ void autofs_clean_ino(struct autofs_info *);
> >
> >  static inline int autofs_check_pipe(struct file *pipe)
> >  {
> > +       if (pipe->f_mode & FMODE_PATH)
> > +               return -EINVAL;
> >         if (!(pipe->f_mode & FMODE_CAN_WRITE))
> >                 return -EINVAL;
> 
> I thought you said the above check is redundant due to the lower check.

It is but that's only obvious to people quite familiar with VFS code.
So I like the explicitly check here.

> 
> In any case feel free to add
> 
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> 
> >         if (!S_ISFIFO(file_inode(pipe)->i_mode))
> > diff --git a/fs/fsopen.c b/fs/fsopen.c
> > index 094a7f510edf..1aaf4cb2afb2 100644
> > --- a/fs/fsopen.c
> > +++ b/fs/fsopen.c
> > @@ -453,7 +453,7 @@ SYSCALL_DEFINE5(fsconfig,
> >         case FSCONFIG_SET_FD:
> >                 param.type = fs_value_is_file;
> >                 ret = -EBADF;
> > -               param.file = fget(aux);
> > +               param.file = fget_raw(aux);
> >                 if (!param.file)
> >                         goto out_key;
> >                 param.dirfd = aux;
> >
> > --
> > 2.47.2
> >

