Return-Path: <linux-fsdevel+bounces-35344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA309D4054
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 17:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA647282279
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 16:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F9113BAEE;
	Wed, 20 Nov 2024 16:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rn+IhqYI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755BD13AA31;
	Wed, 20 Nov 2024 16:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732120953; cv=none; b=cqJyD6iVCUVFg10fr+5dEvCqHSjV9g06tPxDSLAgWuFxwTeCMZ3wilbZ87jLFJZQclcHgLg7c8Tt7sZJjCXHMMgWsPoqhzfCl1Lzhmu/hK5+gGLTdt05bwgi4zShe0dZ2EN6/jap2WF+J1GAOODHx5nJIthvz45CbJ8JKa330Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732120953; c=relaxed/simple;
	bh=e6Qp6oBiUPlSxswotyKcOIKoPUzbc+hiUUbCKuI7KJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yj4BNbrtdixuKZKJMN9J9ripDDvkQC7lJAYNYvmDKq3liglJyecQpkzoUM8ViddC4q564yqnzPD3w6/bTw898fcqaDsozjFke2lym4Ep0pkAKVYsp4sRdnSF205lo+96BhZOlEEeiTzlho5NLTWyuMRCye/jV6W5AGO2RKntFts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rn+IhqYI; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa20c733e92so790253566b.0;
        Wed, 20 Nov 2024 08:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732120950; x=1732725750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FcZ/qVRFrTrPsl9wheVLwLdCEZFphqCBC9fFa8ajopI=;
        b=Rn+IhqYIelFUFS4Ba9qF2KaHYhSTlMazRmz2eDXyIF8HDyk+2i68a9a9Jms4TMmk88
         XvmuaYoTh4eSINxAk90HQNpuJyeOm9dTqEq31991gVVDroMKZ8Xr05HNg/tPWiTxYhlv
         p0TTLkgBVXscG9XfjpLrvAOKNCrJIo0FOtCXRlMSec7jIVGZKeBWcFG8AxRKyfrtMR1z
         0bUDbA67qoeglVJLK2DVyUF0auIFV9arKEi0aAnJgEC37wa5zvATpIiaWUUiJZ8tcOnZ
         2DT6y54FssCwPBjIaVjHSsF22AYMO9MzDVvnVupWNb4iszAX3wdaLOk8RUYtffo/P+1r
         4rew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732120950; x=1732725750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FcZ/qVRFrTrPsl9wheVLwLdCEZFphqCBC9fFa8ajopI=;
        b=SAOX9tXveKUZQNBpo7lqbpvvRfVQz8PHvhx07VsJqjCv0JLYjw+ZshSrL2Vzmukn2M
         8+OIb4mS0wGcJY9w31CO0RL43tf7GUsW5399QCDbLPM7sbrcqa+YV8AQ9fMJNzCaEs1R
         c4O5IQQS/viB6LkB4XnSpRqux744Vh9JaT10+cqN4GMdNoGGDj1YJpzRYzZt/vB8pIzv
         3NW6orJXg9GKudEkRMvTTAaU5Ex7NXnKBq/V/hqwjyEsJg5uIxRCJs8bxJjSgZl4il19
         ld59qGi8oNzVaITThSFwcbtoioc3mA20oUICVROsp1R4fensG5/nEKKEB6QsfBygMhIN
         eGYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCJrxx/UO8AarXyVeUrdEdXelSBtQw4UXXmXWyJHVCPNs7sf/MjllFQY0aBQsHak/82vh+hyBYvEGI2A==@vger.kernel.org, AJvYcCUKr1asp09UT8qC4sQrnzYsnzl37tGnjA0AJS8rL8wCeh5+e/zHNoxb3+dNYhk0I05IDjrhlO3bYeKu@vger.kernel.org, AJvYcCWKUmgVmUSZluqWuXefdQjW68HyOmaRD5JMLN8kyb1VMpYdK+LlTu9xeH5DtRfFhap0Rlu3XHNfle45UA==@vger.kernel.org, AJvYcCWuszp1pjgK7t8XCxE1yxwnazEQ+AAPrOoQTwsQCfi5hnQJ9lbXW2kHymIfDgLbHk5mreRvIQKw76iypto34Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKcVJ9nNpnZhDor/VarQiUKGwWtCLizE56nRwkXDzE4WJZl2XN
	T4w2wu8nT8IBcmyCisxWOc4HmSXeVtZIBO7bZk1RtphV0hoyXaaLPJikvH518ougGRnx3p17jwf
	gQEW04Oh/pHhlFUPOfo7QEpB/3lw=
X-Google-Smtp-Source: AGHT+IESXkPbNLJC+3RMgOX6j+HutEH0kyIIO5eXd31+9oHtDOGVK9zXOmSMvlelO3h+JPf71j6COjp4Ahjs7rPmPGw=
X-Received: by 2002:a17:906:4793:b0:a99:fb56:39cc with SMTP id
 a640c23a62f3a-aa4dd71e7famr354632666b.38.1732120949412; Wed, 20 Nov 2024
 08:42:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731684329.git.josef@toxicpanda.com> <2ddcc9f8d1fde48d085318a6b5a889289d8871d8.1731684329.git.josef@toxicpanda.com>
 <20241120160247.sdvonyxkpmf4wnt2@quack3>
In-Reply-To: <20241120160247.sdvonyxkpmf4wnt2@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 20 Nov 2024 17:42:18 +0100
Message-ID: <CAOQ4uxj4pwH2hfmNL0N=q8-rOF6d=-Z_yWLEwHQ671t1EvRn6A@mail.gmail.com>
Subject: Re: [PATCH v8 03/19] fsnotify: add helper to check if file is
 actually being watched
To: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
	brauner@kernel.org, torvalds@linux-foundation.org, viro@zeniv.linux.org.uk, 
	linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
	linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 5:02=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 15-11-24 10:30:16, Josef Bacik wrote:
> > From: Amir Goldstein <amir73il@gmail.com>
> >
> > So far, we set FMODE_NONOTIFY_ flags at open time if we know that there
> > are no permission event watchers at all on the filesystem, but lack of
> > FMODE_NONOTIFY_ flags does not mean that the file is actually watched.
> >
> > To make the flags more accurate we add a helper that checks if the
> > file's inode, mount, sb or parent are being watched for a set of events=
.
> >
> > This is going to be used for setting FMODE_NONOTIFY_HSM only when the
> > specific file is actually watched for pre-content events.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> I did some changes here as well. See below:
>
> > -/* Are there any inode/mount/sb objects that are interested in this ev=
ent? */
> > -static inline bool fsnotify_object_watched(struct inode *inode, __u32 =
mnt_mask,
> > -                                        __u32 mask)
> > +/* Are there any inode/mount/sb objects that watch for these events? *=
/
> > +static inline __u32 fsnotify_object_watched(struct inode *inode, __u32=
 mnt_mask,
> > +                                         __u32 events_mask)
> >  {
> >       __u32 marks_mask =3D READ_ONCE(inode->i_fsnotify_mask) | mnt_mask=
 |
> >                          READ_ONCE(inode->i_sb->s_fsnotify_mask);
> >
> > -     return mask & marks_mask & ALL_FSNOTIFY_EVENTS;
> > +     return events_mask & marks_mask;
> >  }
> >
> > +/* Are there any inode/mount/sb/parent objects that watch for these ev=
ents? */
> > +__u32 fsnotify_file_object_watched(struct file *file, __u32 events_mas=
k)
> > +{
> > +     struct dentry *dentry =3D file->f_path.dentry;
> > +     struct dentry *parent;
> > +     __u32 marks_mask, mnt_mask =3D
> > +             READ_ONCE(real_mount(file->f_path.mnt)->mnt_fsnotify_mask=
);
> > +
> > +     marks_mask =3D fsnotify_object_watched(d_inode(dentry), mnt_mask,
> > +                                          events_mask);
> > +
> > +     if (likely(!(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED)))
> > +             return marks_mask;
> > +
> > +     parent =3D dget_parent(dentry);
> > +     marks_mask |=3D fsnotify_inode_watches_children(d_inode(parent));
> > +     dput(parent);
> > +
> > +     return marks_mask & events_mask;
> > +}
> > +EXPORT_SYMBOL_GPL(fsnotify_file_object_watched);
>
> I find it confusing that fsnotify_object_watched() does not take parent
> into account while fsnotify_file_object_watched() does. Furthermore the
> naming doesn't very well reflect the fact we are actually returning a mas=
k
> of events. I've ended up dropping this helper (it's used in a single plac=
e
> anyway) and instead doing the same directly in file_set_fsnotify_mode().
>
> @@ -658,6 +660,27 @@ void file_set_fsnotify_mode(struct file *file)
>                 file->f_mode |=3D FMODE_NONOTIFY | FMODE_NONOTIFY_PERM;
>                 return;
>         }
> +
> +       /*
> +        * OK, there are some pre-content watchers. Check if anybody can =
be
> +        * watching for pre-content events on *this* file.
> +        */
> +       mnt_mask =3D READ_ONCE(real_mount(file->f_path.mnt)->mnt_fsnotify=
_mask);
> +       if (likely(!(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED) &&
> +           !fsnotify_object_watched(d_inode(dentry), mnt_mask,
> +                                    FSNOTIFY_PRE_CONTENT_EVENTS))) {
> +               file->f_mode |=3D FMODE_NONOTIFY | FMODE_NONOTIFY_PERM;
> +               return;
> +       }
> +
> +       /* Even parent is not watching for pre-content events on this fil=
e? */
> +       parent =3D dget_parent(dentry);
> +       p_mask =3D fsnotify_inode_watches_children(d_inode(parent));
> +       dput(parent);
> +       if (!(p_mask & FSNOTIFY_PRE_CONTENT_EVENTS)) {
> +               file->f_mode |=3D FMODE_NONOTIFY | FMODE_NONOTIFY_PERM;
> +               return;
> +       }
>  }
>

Nice!

Note that I had a "hidden motive" for future optimization when I changed
return value of fsnotify_object_watched() to a mask -

I figured that while we are doing the checks above, we can check for the
same price the mask ALL_FSNOTIFY_PERM_EVENTS
then we get several answers for the same price:
1. Is the specific file watched by HSM?
2. Is the specific file watched by open permission events?
3. Is the specific file watched by post-open FAN_ACCESS_PERM?

If the answers are No, No, No, we get some extra optimization
in the (uncommon) use case that there are permission event watchers
on some random inodes in the filesystem.

If the answers are Yes, Yes, No, or No, Yes, No we can return a special
value from file_set_fsnotify_mode() to indicate that permission events
are needed ONLY for fsnotify_open_perm() hook, but not thereafter.

This would implement the semantic change of "respect FAN_ACCESS_PERM
only if it existed at open time" that can save a lot of unneeded cycles in
the very hot read/write path, for example, when watcher only cares about
FAN_OPEN_EXEC_PERM.

I wasn't sure that any of this was worth the effort at this time, but
just in case
this gives you ideas of other useful optimizations we can do with the
object combined marks_mask if we get it for free.

Thanks,
Amir.

