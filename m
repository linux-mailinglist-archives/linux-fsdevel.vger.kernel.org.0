Return-Path: <linux-fsdevel+bounces-5634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1612D80E78F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 10:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5548282B2F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 09:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39971584E3;
	Tue, 12 Dec 2023 09:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdjOFL+x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D18D219F2;
	Tue, 12 Dec 2023 09:27:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE993C433C7;
	Tue, 12 Dec 2023 09:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702373272;
	bh=5RJMKCoYxnXkUiYpXUAFHsON2DTSXvEYzJ4lN4kFgpY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mdjOFL+xi9mY1oQO4/sZfC+28BYlkluFsERL3SXPZ6u1xo72k6ikvJWT/ZO9Au8Pf
	 jKZ2CC5GIv0b8//Q7MYezJmbUeqmjEuaFXc6eDEuohpSJlAxqMNSRedCfRq+rn8bdS
	 3TrYQqMMSiAkSvlTHooXRl1LFOLWFCF/jtP4pjV5YD0juXKcJanf0HiAYzx9VXgpMN
	 22O59I6dIkNdr/Gy185/HEJqESdYGGmreJLugrki3uieIXNm4WUvCmc+pnVb1KizcG
	 JlwzCI9AJysIBGuv/o0/EHjzmmwfFtwVVGh8HWpz69Ss/+FULH9Lo1kU/7so9ZAvSV
	 nVnS6VjoyQjfw==
Date: Tue, 12 Dec 2023 10:27:47 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Andrei Vagin <avagin@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	overlayfs <linux-unionfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] fs/proc: show correct device and inode numbers in
 /proc/pid/maps
Message-ID: <20231212-brokkoli-trinken-1581d1e99d6a@brauner>
References: <20231211193048.580691-1-avagin@google.com>
 <CAOQ4uxik0=0F-6CLRsuaOheFjwWF-B-Q5iEQ6qJbRszL52HeQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxik0=0F-6CLRsuaOheFjwWF-B-Q5iEQ6qJbRszL52HeQQ@mail.gmail.com>

On Tue, Dec 12, 2023 at 07:51:31AM +0200, Amir Goldstein wrote:
> +fsdevel, +overlayfs, +brauner, +miklos
> 
> On Mon, Dec 11, 2023 at 9:30 PM Andrei Vagin <avagin@google.com> wrote:
> >
> > Device and inode numbers in /proc/pid/maps have to match numbers returned by
> > statx for the same files.
> 
> That statement may be true for regular files.
> It is not true for block/char as far as I know.
> 
> I think that your fix will break that by displaying the ino/dev
> of the block/char reference inode and not their backing rdev inode.
> 
> >
> > /proc/pid/maps shows device and inode numbers of vma->vm_file-s. Here is
> > an issue. If a mapped file is on a stackable file system (e.g.,
> > overlayfs), vma->vm_file is a backing file whose f_inode is on the
> > underlying filesystem. To show correct numbers, we need to get a user
> > file and shows its numbers. The same trick is used to show file paths in
> > /proc/pid/maps.
> 
> For the *same* trick, see my patch below.
> 
> >
> > But it isn't the end of this story. A file system can manipulate inode numbers
> > within the getattr callback (e.g., ovl_getattr), so vfs_getattr must be used to
> > get correct numbers.
> 
> This explanation is inaccurate, because it mixes two different overlayfs
> traits which are unrelated.
> It is true that a filesystem *can* manipulate st_dev in a way that will not
> match i_ino and it is true that overlayfs may do that in some non-default
> configurations (see [1]), but this is not the reason that you are seeing
> mismatches ino/dev in /proc/<pid>/maps.
> 
> [1] https://docs.kernel.org/filesystems/overlayfs.html#inode-properties
> 
> The reason is that the vma->vm_file is a special internal backing file
> which is not otherwise exposed to userspace.
> Please see my suggested fix below.
> 
> >
> > Cc: Amir Goldstein <amir73il@gmail.com>
> > Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>
> > Signed-off-by: Andrei Vagin <avagin@google.com>
> > ---
> >  fs/proc/task_mmu.c | 20 +++++++++++++++++---
> >  1 file changed, 17 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index 435b61054b5b..abbf96c091ad 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -273,9 +273,23 @@ show_map_vma(struct seq_file *m, struct vm_area_struct *vma)
> >         const char *name = NULL;
> >
> >         if (file) {
> > -               struct inode *inode = file_inode(vma->vm_file);
> > -               dev = inode->i_sb->s_dev;
> > -               ino = inode->i_ino;
> > +               const struct path *path;
> > +               struct kstat stat;
> > +
> > +               path = file_user_path(file);
> > +               /*
> > +                * A file system can manipulate inode numbers within the
> > +                * getattr callback (e.g. ovl_getattr).
> > +                */
> > +               if (!vfs_getattr_nosec(path, &stat, STATX_INO, AT_STATX_DONT_SYNC)) {
> 
> Should you prefer to keep this solution it should be constrained to
> regular files.

It's also very dicy calling into the filesystem from procfs. You might
hang the system if you end up talking to a hung NFS server or something.
What locks does show_map_vma() hold? And is it safe to call helpers that
might generate io?

> 
> > +                       dev = stat.dev;
> > +                       ino = stat.ino;
> > +               } else {
> > +                       struct inode *inode = d_backing_inode(path->dentry);
> 
> d_inode() please.
> d_backing_inode()/d_backing_dentry() are relics of an era that never existed
> (i.e. union mounts).
> 
> > +
> > +                       dev = inode->i_sb->s_dev;
> > +                       ino = inode->i_ino;
> > +               }
> >                 pgoff = ((loff_t)vma->vm_pgoff) << PAGE_SHIFT;
> >         }
> >
> 
> Would you mind trying this alternative (untested) patch?
> I think it is preferred, because it is simpler.
> 
> Thanks,
> Amir.
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index ef2eb12906da..5328266be6b5 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -273,7 +273,8 @@ show_map_vma(struct seq_file *m, struct vm_area_struct *vma)
>         const char *name = NULL;
> 
>         if (file) {
> -               struct inode *inode = file_inode(vma->vm_file);
> +               struct inode *inode = file_user_inode(vma->vm_file);
> +
>                 dev = inode->i_sb->s_dev;
>                 ino = inode->i_ino;
>                 pgoff = ((loff_t)vma->vm_pgoff) << PAGE_SHIFT;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 900d0cd55b50..d78412c6fd47 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2581,20 +2581,28 @@ struct file *backing_file_open(const struct
> path *user_path, int flags,
>  struct path *backing_file_user_path(struct file *f);
> 
>  /*
> - * file_user_path - get the path to display for memory mapped file
> - *
>   * When mmapping a file on a stackable filesystem (e.g., overlayfs), the file
>   * stored in ->vm_file is a backing file whose f_inode is on the underlying
> - * filesystem.  When the mapped file path is displayed to user (e.g. via
> - * /proc/<pid>/maps), this helper should be used to get the path to display
> - * to the user, which is the path of the fd that user has requested to map.
> + * filesystem.  When the mapped file path and inode number are displayed to
> + * user (e.g. via /proc/<pid>/maps), these helper should be used to get the
> + * path and inode number to display to the user, which is the path of the fd
> + * that user has requested to map and the inode number that would be returned
> + * by fstat() on that same fd.
>   */
> +/* Get the path to display in /proc/<pid>/maps */
>  static inline const struct path *file_user_path(struct file *f)
>  {
>         if (unlikely(f->f_mode & FMODE_BACKING))
>                 return backing_file_user_path(f);
>         return &f->f_path;
>  }
> +/* Get the inode whose inode number to display in /proc/<pid>/maps */
> +static inline const struct path *file_user_inode(struct file *f)
> +{
> +       if (unlikely(f->f_mode & FMODE_BACKING))
> +               return d_inode(backing_file_user_path(f)->dentry);
> +       return file_inode(f);
> +}

Way better imho.

