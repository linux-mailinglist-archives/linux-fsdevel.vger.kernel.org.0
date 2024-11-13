Return-Path: <linux-fsdevel+bounces-34659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D249C7482
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 15:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58275281C65
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 14:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B442A200B89;
	Wed, 13 Nov 2024 14:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XydvH+7x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477DD1FF7A4;
	Wed, 13 Nov 2024 14:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731508607; cv=none; b=uPdJWT9TliJux3Pg2OGFYGadVddaIlsvnNy4ecn7PwP6jqTb/vKuz+2kjJqnSBckN4eM7ZFDspeOg7exfkveXkGc2/UyIDJIMH2jY1+XO8w1DOg+fD3Bat6tPm4XNLQJaX5agSNHOcRU1z+PfnEEWfpVhlak4rsaGS1CxrXURuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731508607; c=relaxed/simple;
	bh=4ZOYAY9l9J0p+/pagouIG7S5TCj2naHI1ZJy9Dt8YLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ep2eMU0WFd+MF6+EJGCEqs5uHi5zI1sZVIVNMlstxp7ZGlL7IVPIKh32GVCCCr7ukbkHBIqm3yWp7bMgMQjCrf4D5Nv20i6/aBb2eVK71nreb8hpfxPPSyIEjtY+fKrjX/e6AHgNApK8UD3sv0Pe6BL7y4p6HVvccf8Nw/i9+Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XydvH+7x; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6cc1b20ce54so47718526d6.0;
        Wed, 13 Nov 2024 06:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731508604; x=1732113404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5TpO1rEDli92wfsqt+A461mrFCCbHcRm9Ir9kcXs4JU=;
        b=XydvH+7xyHsDmu2URrGPRxYFtb/LrDn4o5vsr5PlpoG71TNinbSyczAgN8A2chjdiG
         7Phje9nlfdnp6oTjW+XY7Iv6guQFViTX6cYMUxFjqSHaPsCaFLtU/LSF0TEtd7PCQRSd
         iG3pDSW0SSF5wJzI+Rz9XTxaHbBxm05g5cJXUuQ1OMAfYqwX/AJspwxMO0pEY7jG3zDr
         wkcJlRlrDW49Hp1aFXdIdKghASHl+UpBvHMRlsS2go0ICBAEJ7193nAd4NVGsTFGsYzA
         yhnSzbe+zXtmPSduazYR0xNepKckAIpaisbz1kn3kJfuZjkwbNnJlMJUEq5gXPR3NyuC
         mvMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731508604; x=1732113404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5TpO1rEDli92wfsqt+A461mrFCCbHcRm9Ir9kcXs4JU=;
        b=UbFqrtaKo80BBBIXB2bhvhdB7vHDjZwdziZzgCgRrjfcNf1uMN2Y9GiN7IBK2qk76l
         U1gGVz+7SYHmEQ3Fjx52jbZCixWkL9frYv6ITnCP4RRJ76BcSsFVQkJoCTBnu9jDzX93
         00H+V5ZFB5ZwPQJ214pBPLtTgqN7quPrOlEqbgAXZw/cU4ksffuhhRQwPbjq25ekmmMy
         BYTSDTAJuiFz9ckkJ9o7W3Z5/dm5wp2eajocbmDdF1m6nRe39SLEJHj8n/fr2Lacidyb
         ceW5l3mPFgNcbZ8e2lyNXu4Jg6aq3UIxhWPkl75VujPwIJAn+eDbg3IniAPoO0mvENcy
         Jj/A==
X-Forwarded-Encrypted: i=1; AJvYcCVNllex5CjnX4LL0+AN9k7KO4iI1VQpsrrv2uHCbnc1NZ1MACaDeA4RLNpJP7e7zd5hOY+4pzQRWt0szg==@vger.kernel.org, AJvYcCW2afoO0DNq/4VXpXzc0jjV1cjYOEunPNuxVx10H2lEyHF83oAo3QmeSHWRxjAherPn/C8pBl2j26jf2A==@vger.kernel.org, AJvYcCWoTYjrzMAwc/QLuH4Jier2eANN+5ysjvFLj2R3kS/WIAbWewT9YvXPDzQDgptyfoo81CA5epwgvhC11d5ZWQ==@vger.kernel.org, AJvYcCWxRkntwicpMMhN7Jv4877Gl+M7+yTjPW09BThuG1srbqrm1ChJ21+NcCpLvCgPdC+yudlKWib4ZvC0@vger.kernel.org
X-Gm-Message-State: AOJu0YwA33UVzvMYzPAjcPpFutpsoXdGbma5EtW9X9k1Rnu8wmneo9Gt
	EOSKUwaIkNXdqSiXeDIriHN+/WR65Lhq6xkoVDyaiGt3md1VuwyNokpmSdwo9b7HF82znUc7usq
	V4UCtLynZ6NmDgEEg0/D3pAnGC/k=
X-Google-Smtp-Source: AGHT+IHDM6yIlJ+rbWXJBsM1kdPByZi+pkkssJXLfoBLa9nCWP4173NtLKc4WYnD4Kt86lm779n87BvsYqF4dqhC3AQ=
X-Received: by 2002:a05:6214:4589:b0:6d3:9359:26ef with SMTP id
 6a1803df08f44-6d39e0f6663mr268917446d6.6.1731508604035; Wed, 13 Nov 2024
 06:36:44 -0800 (PST)
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
Date: Wed, 13 Nov 2024 15:36:33 +0100
Message-ID: <CAOQ4uxj01mrrPQMyygdyDAGpyA=K=SPH88E2tpY5RuSsqG9iiA@mail.gmail.com>
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

I would make this a bit more generic helper and the comment above
is truly clueless:

        /*
-        * we need a new file handle for the userspace program so it
can read even if it was
-        * originally opened O_WRONLY.
+        * We provide an fd for the userspace program, so it could access t=
he
+        * file without generating fanotify events itself.
         */
-       new_file =3D dentry_open(path,
-                              group->fanotify_data.f_flags | __FMODE_NONOT=
IFY,
-                              current_cred());
+       new_file =3D dentry_open_fmode(path, group->fanotify_data.f_flags,
+                                    FMODE_NONOTIFY, current_cred());



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

s/flags/f_flags

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

Get rid of another stale comment:

        /*
-        * Strip flags that either shouldn't be set by userspace like
-        * FMODE_NONOTIFY or that aren't relevant in determining struct
-        * open_flags like O_CLOEXEC.
+        * Strip flags that aren't relevant in determining struct open_flag=
s.
         */

With these changed, you can add:

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

With the f_flags typo fixed, this passed LTP sanity tests, but I am
going to test the NONOTIFY functionally some more.

Thanks,
Amir.

