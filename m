Return-Path: <linux-fsdevel+bounces-34600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D759C6AF3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 09:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CA20B23306
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 08:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B0D18B497;
	Wed, 13 Nov 2024 08:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYC1iKbc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B636B230999;
	Wed, 13 Nov 2024 08:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731487870; cv=none; b=pobJZgu9Kaet08gNzMBwnb5qSf2LtUcF+fVcj7I3gusKLpVGvIBnp3F208B+B1GQL4+vd/Yz6Yf7XCo4X3dWXmVYHnefFLjcpQbeat3gofsQH+UZWnYKP86XFf2Q1vcEoHPaNwBSuoZAtKXkf8yWRLy21hKtErffQRU3y3JmuAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731487870; c=relaxed/simple;
	bh=vMXm5H6fZUQULjLgteD9QfuqP2pNpj0rYbCg/ZDUQnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l+lt0AkgxJs2ipe1irTL45bTcw4s7xQaYRylzSkLXXu5H/KCXAtSqETTov6wOXe7ntrKLtV5kqOxqCyjp5yBDvzH/+Pk1/JwHDwzZKKEssr9SNI0MhOwwO9B0iQj/IL9gauW3Wk3cHRRBHMptBbVknKd2H1YxG+A72Q8WFoEGWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WYC1iKbc; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-46089a6849bso45727921cf.3;
        Wed, 13 Nov 2024 00:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731487867; x=1732092667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ybXyojIgfEt1kNw22/DBLy4j99prnhZqAaMZR54A+Gg=;
        b=WYC1iKbcVL76B1OkhzYSFCYelGrneol3JTd3xItJPwajmmddkjsaydfefVovqZ4Uul
         4XYTPoGj9VveGYPoQ4isU45niJRiCPatCWiyLsRLIDmIbN9Wd4usxuPpGj/XEONHMEM7
         HNWELhW3sEySDaBGuw5w/ZU5nXJVpnDf8tS+E1G5mz0SWie4pt2Z9TM7MJlYELszp61K
         Km3RRCWXP+zeCvy7xkPmCZefq1Vf9Ak8BmmDS9gvZfJ7c9QCAZuTo2n5tbxuzqXXbLJZ
         EeJKAadxhVc3rYwKGWfVVol3MSGfb5SQI39jPpusWo8d9T9KTD0UChArhnfdmKPUY/cL
         O4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731487867; x=1732092667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ybXyojIgfEt1kNw22/DBLy4j99prnhZqAaMZR54A+Gg=;
        b=nDDx1qmoS10RPk+5Z5A+1OiHN/kyrfcqkYMguX1swjl6d8VslxJxcrHJjoBmMZDWKY
         K2Q2cdS004re5DfZajVY3GIxRTlYw++GO7Y4uYtrUk2BNYHvdkqblu18xmCtJsnu2989
         pzRXdXxAAd/Oaftm0ouxFyKFqbgiCGiYQ1ExLaZzx/kC00FlHJz+YyNRMxCpUmmjmX7O
         GefmYyL1t6cPey03N/Q2rv7OGXUwsailV0g/se5FUz6RIztiBeBEbB/6KFMo2Uya+QR2
         HIZVRFVE2xTxj4k/0oo7YGcKEoO0mphQP2nZRsPmVH/Sp+XjyO3HF5qQrStdXSlJNNhv
         Cm2A==
X-Forwarded-Encrypted: i=1; AJvYcCUete6eV/CuLv0tG9r5QJc1Eb/P8/FxSURh5uHmMmAJanctnIog4B0I8A5mK5zy/o3+Sp9Dj4V1vbtEtw==@vger.kernel.org, AJvYcCXOYOoYHgaejzqfzulbcqiqgCssudSOXz88NyF8tL72SYZOy0DPSfGYwYW8EmdaIPD+GYAhStG+slnf@vger.kernel.org, AJvYcCXTZh9ojKVNcy4rOXDXIgNvlNJyIGSdhVZW12qipz6YzWnRfioyD6m79pVWWM1FbPjFuP5hyOKLYBe8uQ==@vger.kernel.org, AJvYcCXf1WKnFSBfyL0QUYvrgpU9v7yUSiyQQU7g6or9UmmfBemxFpijXmdqCaqPDwYu3Z337cMarSrY48oDeQWvZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwqRCmRm6dwQ/FD+6cl25aihxaxY+uoPzpFaqR4bf8ejyxtLKki
	J7RS3Vq/JGlO/6s9XpAqmj/2aRKa+rvXOK6RalSV58agw6iiR2/Cky8Rmj8DVHzKbUmwnsvEXiR
	Oye7pqJCFdFxEyzp/M7jK7sffvRc=
X-Google-Smtp-Source: AGHT+IFBrfXQjTCkQPe4lwAc7PKO7knKqlZWmbapahrCNZ9X4yKTYmSvJNyTl2Dazx088ITWw0ve2s6iPmsqRoKVlow=
X-Received: by 2002:a05:622a:17c5:b0:461:2150:d59c with SMTP id
 d75a77b69052e-4634b498484mr29491901cf.9.1731487867334; Wed, 13 Nov 2024
 00:51:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731433903.git.josef@toxicpanda.com> <141e2cc2dfac8b2f49c1c8d219dd7c20925b2cef.1731433903.git.josef@toxicpanda.com>
 <CAHk-=wjkBEch_Z9EMbup2bHtbtt7aoj-o5V6Nara+VxeUtckGw@mail.gmail.com>
 <CAOQ4uxiiFsu-cG89i_PA+kqUp8ycmewhuD9xJBgpuBy5AahG5Q@mail.gmail.com>
 <CAHk-=wijFZtUxsunOVN5G+FMBJ+8A-+p5TOURv2h=rbtO44egw@mail.gmail.com>
 <20241113001251.GF3387508@ZenIV> <CAHk-=wg02AubUBZ5DxLra7b5w2+hxawdipPqEHemg=Lf8b1TDA@mail.gmail.com>
 <CAHk-=wgVzOQDNASK8tU3JoZHUgp7BMTmuo2Njmqh4NvEMYTrCw@mail.gmail.com>
 <20241113011954.GG3387508@ZenIV> <20241113043003.GH3387508@ZenIV>
In-Reply-To: <20241113043003.GH3387508@ZenIV>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 13 Nov 2024 09:50:55 +0100
Message-ID: <CAOQ4uxi9KWb39BYBEhOJgex7v5pinj3VoEia5TzWH2O_Box=DQ@mail.gmail.com>
Subject: Re: [PATCH v7 05/18] fsnotify: introduce pre-content permission events
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Josef Bacik <josef@toxicpanda.com>, 
	kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	brauner@kernel.org, linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-mm@kvack.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 5:30=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Wed, Nov 13, 2024 at 01:19:54AM +0000, Al Viro wrote:
> > On Tue, Nov 12, 2024 at 04:38:42PM -0800, Linus Torvalds wrote:
> > > Looking at that locking code in fadvise() just for the f_mode use doe=
s
> > > make me think this would be a really good cleanup.
> > >
> > > I note that our fcntl code seems buggy as-is, because while it does
> > > use f_lock for assignments (good), it clearly does *not* use them for
> > > reading.
> > >
> > > So it looks like you can actually read inconsistent values.
> > >
> > > I get the feeling that f_flags would want WRITE_ONCE/READ_ONCE in
> > > _addition_ to the f_lock use it has.
> >
> > AFAICS, fasync logics is the fishy part - the rest should be sane.
> >
> > > The f_mode thing with fadvise() smells like the same bug. Just becaus=
e
> > > the modifications are serialized wrt each other doesn't mean that
> > > readers are then automatically ok.
> >
> > Reads are also under ->f_lock in there, AFAICS...
> >
> > Another thing in the vicinity is ->f_mode modifications after the calls
> > of anon_inode_getfile() in several callers - probably ought to switch
> > those to anon_inode_getfile_fmode().  That had been discussed back in
> > April when the function got merged, but "convert to using it" followup
> > series hadn't materialized...
>
> While we are at it, there's is a couple of kludges I really hate -
> mixing __FMODE_NONOTIFY and __FMODE_EXEC with O_... flags.
>
> E.g. for __FMODE_NONOTIFY all it takes is switching fanotify from
> anon_inode_getfd() to anon_inode_getfile_fmode() and adding
> a dentry_open_nonotify() to be used by fanotify on the other path.
> That's it - no more weird shit in OPEN_FMODE(), etc.
>
> For __FMODE_EXEC it might get trickier (nfs is the main consumer),
> but I seriously suspect that something like "have path_openat()
> check op->acc_mode & MAY_EXEC and set FMODE_EXEC in ->f_mode
> right after struct file allocation" would make a good starting
> point; yes, it would affect uselib(2), but... I've no idea whether
> it wouldn't be the right thing to do; would be hard to test.
>
> Anyway, untested __FMODE_NONOTIFY side of it:
>
> diff --git a/fs/fcntl.c b/fs/fcntl.c
> index 22dd9dcce7ec..ebd1c82bfb6b 100644
> --- a/fs/fcntl.c
> +++ b/fs/fcntl.c
> @@ -1161,10 +1161,10 @@ static int __init fcntl_init(void)
>          * Exceptions: O_NONBLOCK is a two bit define on parisc; O_NDELAY
>          * is defined as O_NONBLOCK on some platforms and not on others.
>          */
> -       BUILD_BUG_ON(21 - 1 /* for O_RDONLY being 0 */ !=3D
> +       BUILD_BUG_ON(20 - 1 /* for O_RDONLY being 0 */ !=3D
>                 HWEIGHT32(
>                         (VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDELAY)) |
> -                       __FMODE_EXEC | __FMODE_NONOTIFY));
> +                       __FMODE_EXEC));
>
>         fasync_cache =3D kmem_cache_create("fasync_cache",
>                                          sizeof(struct fasync_struct), 0,
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fano=
tify_user.c
> index 9644bc72e457..43fbf29ef03a 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -101,8 +101,7 @@ static void __init fanotify_sysctls_init(void)
>   *
>   * Internal and external open flags are stored together in field f_flags=
 of
>   * struct file. Only external open flags shall be allowed in event_f_fla=
gs.
> - * Internal flags like FMODE_NONOTIFY, FMODE_EXEC, FMODE_NOCMTIME shall =
be
> - * excluded.
> + * Internal flags like FMODE_EXEC shall be excluded.
>   */
>  #define        FANOTIFY_INIT_ALL_EVENT_F_BITS                          (=
 \
>                 O_ACCMODE       | O_APPEND      | O_NONBLOCK    | \
> @@ -262,8 +261,8 @@ static int create_fd(struct fsnotify_group *group, co=
nst struct path *path,
>          * we need a new file handle for the userspace program so it can =
read even if it was
>          * originally opened O_WRONLY.
>          */
> -       new_file =3D dentry_open(path,
> -                              group->fanotify_data.f_flags | __FMODE_NON=
OTIFY,
> +       new_file =3D dentry_open_nonotify(path,
> +                              group->fanotify_data.f_flags,
>                                current_cred());
>         if (IS_ERR(new_file)) {
>                 /*
> @@ -1404,6 +1403,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags,=
 unsigned int, event_f_flags)
>         unsigned int fid_mode =3D flags & FANOTIFY_FID_BITS;
>         unsigned int class =3D flags & FANOTIFY_CLASS_BITS;
>         unsigned int internal_flags =3D 0;
> +       struct file *file;
>
>         pr_debug("%s: flags=3D%x event_f_flags=3D%x\n",
>                  __func__, flags, event_f_flags);
> @@ -1472,7 +1472,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags,=
 unsigned int, event_f_flags)
>             (!(fid_mode & FAN_REPORT_NAME) || !(fid_mode & FAN_REPORT_FID=
)))
>                 return -EINVAL;
>
> -       f_flags =3D O_RDWR | __FMODE_NONOTIFY;
> +       f_flags =3D O_RDWR;
>         if (flags & FAN_CLOEXEC)
>                 f_flags |=3D O_CLOEXEC;
>         if (flags & FAN_NONBLOCK)
> @@ -1550,10 +1550,18 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flag=
s, unsigned int, event_f_flags)
>                         goto out_destroy_group;
>         }
>
> -       fd =3D anon_inode_getfd("[fanotify]", &fanotify_fops, group, f_fl=
ags);
> +       fd =3D get_unused_fd_flags(flags);
>         if (fd < 0)
>                 goto out_destroy_group;
>
> +       file =3D anon_inode_getfile_fmode("[fanotify]", &fanotify_fops, g=
roup,
> +                                       f_flags, FMODE_NONOTIFY);
> +       if (IS_ERR(file)) {
> +               fd =3D PTR_ERR(file);
> +               put_unused_fd(fd);
> +               goto out_destroy_group;
> +       }
> +       fd_install(fd, file);
>         return fd;
>
>  out_destroy_group:
> diff --git a/fs/open.c b/fs/open.c
> index acaeb3e25c88..04cb581528ff 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -1118,6 +1118,23 @@ struct file *dentry_open(const struct path *path, =
int flags,
>  }
>  EXPORT_SYMBOL(dentry_open);
>
> +struct file *dentry_open_nonotify(const struct path *path, int flags,
> +                        const struct cred *cred)
> +{
> +       struct file *f =3D alloc_empty_file(flags, cred);
> +       if (!IS_ERR(f)) {
> +               int error;
> +
> +               f->f_mode |=3D FMODE_NONOTIFY;
> +               error =3D vfs_open(path, f);
> +               if (error) {
> +                       fput(f);
> +                       f =3D ERR_PTR(error);
> +               }
> +       }
> +       return f;
> +}
> +
>  /**
>   * dentry_create - Create and open a file
>   * @path: path to create
> @@ -1215,7 +1232,7 @@ inline struct open_how build_open_how(int flags, um=
ode_t mode)
>  inline int build_open_flags(const struct open_how *how, struct open_flag=
s *op)
>  {
>         u64 flags =3D how->flags;
> -       u64 strip =3D __FMODE_NONOTIFY | O_CLOEXEC;
> +       u64 strip =3D O_CLOEXEC;
>         int lookup_flags =3D 0;
>         int acc_mode =3D ACC_MODE(flags);
>
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index e3c603d01337..18888d601550 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2731,6 +2731,8 @@ struct file *dentry_open(const struct path *path, i=
nt flags,
>  struct file *dentry_create(const struct path *path, int flags, umode_t m=
ode,
>                            const struct cred *cred);
>  struct path *backing_file_user_path(struct file *f);
> +struct file *dentry_open_nonotify(const struct path *path, int flags,
> +                        const struct cred *creds);
>
>  /*
>   * When mmapping a file on a stackable filesystem (e.g., overlayfs), the=
 file
> @@ -3620,11 +3622,9 @@ struct ctl_table;
>  int __init list_bdev_fs_names(char *buf, size_t size);
>
>  #define __FMODE_EXEC           ((__force int) FMODE_EXEC)
> -#define __FMODE_NONOTIFY       ((__force int) FMODE_NONOTIFY)
>
>  #define ACC_MODE(x) ("\004\002\006\006"[(x)&O_ACCMODE])
> -#define OPEN_FMODE(flag) ((__force fmode_t)(((flag + 1) & O_ACCMODE) | \
> -                                           (flag & __FMODE_NONOTIFY)))
> +#define OPEN_FMODE(flag) ((__force fmode_t)(((flag + 1) & O_ACCMODE)))
>
>  static inline bool is_sxid(umode_t mode)
>  {
> diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/=
fcntl.h
> index 80f37a0d40d7..613475285643 100644
> --- a/include/uapi/asm-generic/fcntl.h
> +++ b/include/uapi/asm-generic/fcntl.h
> @@ -6,7 +6,6 @@
>
>  /*
>   * FMODE_EXEC is 0x20
> - * FMODE_NONOTIFY is 0x4000000
>   * These cannot be used by userspace O_* until internal and external ope=
n
>   * flags are split.
>   * -Eric Paris

Nice. I will take it for a test drive.

Thanks,
Amir.

