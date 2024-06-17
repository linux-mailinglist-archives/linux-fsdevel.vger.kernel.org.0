Return-Path: <linux-fsdevel+bounces-21816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF2290ADA9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 14:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE614285F9B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 12:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4E91953B7;
	Mon, 17 Jun 2024 12:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9UxqEI0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED7F195387;
	Mon, 17 Jun 2024 12:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718626164; cv=none; b=isRuK01EobrVpkffAITYzBB4Kty9Q7/dWZ2Dmv1IbhhlesGIP6AgqrnMCVooAVHf2V/nAnoz8akrNKKLSa0Fbn+wal6L//4tQsK2sAH5VFimm53nusXbRNYo4oaFtvq8M0DWj2OXIsSAbPHZD9usk63fpelnwP+hocu+3tOMJMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718626164; c=relaxed/simple;
	bh=/gFndJ0TcyXllsSPb7CaJemK93EcIqv5fi1nTc1sBlo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tMpAduE+CEuAOjanY60nN2V1LmUWG9Fdd4G7t4FTT+7jFq+dTwN/NOpFhMqK9A9Zeksv99anFfatoUU4R8kyb0395SDVfzr5zVYWZxnalDBQwEBLC+Br4I9zJg2zr6qjWdHj3wAA9Oti4QvCORR4org/7HYT7VmMrsEXNVCjRN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R9UxqEI0; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7979198531fso320768085a.0;
        Mon, 17 Jun 2024 05:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718626161; x=1719230961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UjnEoquzo9Lk2KRmH+XQyjN0aGvb5l6weKjYhKoEUUk=;
        b=R9UxqEI0dcSsAm6oB3LQpl9q/2+IlIpRArP/JPOXBH/AbgNCvTg3lcuN+HoAIBSKU4
         lCGZ3sDAKNQD0phfgRdrSH9N4tRT3z/hCn6yjT3ace2vWB4I73sZ6eQeCiLkdzx2iTtH
         LUXgnqq0sczcuqe9pQ67Tsm+Zl8+foYegfQATw2phf9dGsTOg5AhaxDCPjdvNk99yw7H
         pS5AC10TcoIet3VmDSPlyGM7qAPYA+4GB9cXea2xIe1TBWMLgNEczi03VnsNQfH3QWcK
         UGXs1r9y+K0UBiY5ION6J0oi7hb42acxW4xbUSbcDdHzs6kp45qh4K3AgA2C4h7gTfE0
         3CiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718626161; x=1719230961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UjnEoquzo9Lk2KRmH+XQyjN0aGvb5l6weKjYhKoEUUk=;
        b=PqLbTUvUDa9Va2cYodmPYtOBsHhiBvnHXQ3ajd/mLQjmmAm/V7xjSjq6JsgDvCX+N2
         14weMvOz2uMdC737xTsLKWUhoXsHUzkQ4x4HbZl01YnDwM4eheSgQXyc8TBrtBq5uaJw
         wc9Kb/AY/SQHpUd2yFj3nZKyOpVXRWY+K6onXqkAkZDR21I+2bU9EJ/Fh8VRkh2h8km4
         XO7UXiQm6ONgcfsszhXzu8krEM8Pgk1APGskbT4Pz8OiihqnYGtqoTr0A7NAJGudAuPg
         l8ebwyd3KORJaolCHQA+SXQWiLuDsccxtcKosNhMkeQJ+rLdwUeCJqfTaX/NIeD6PzwH
         q+Kw==
X-Forwarded-Encrypted: i=1; AJvYcCV0zgpRBwJSc4AnSz1YFGTi2Xv2GS2BEcK5+hsNzxK0QtHAZ+pCfft2tAkyS6Rc1e8Vs0+BoBHJPuS9tklkQyJ1UhEtfbGWGp3ujuIiTcZkIpGuMJgrAWW8wtrKBhJLpdZJmPpf3DN6fYvp1o2P+9phDJ52u6LpM3D1sKVJYn09++VJ9QiG5g==
X-Gm-Message-State: AOJu0YzuEUnXDxvw/G/k0YEbvn+6+p2U3Obr7PaBE3fMWA5w1bUofhWU
	WwqCTrL6QRYEBIaZ9b3vPle33tG1dfTVv/fEmJ167SMyaC8DV5kLTUqM85pOyB3VJjqsJ48Pmgu
	+5gdEQLs1d/SnUZaWTuPrElFwrt4=
X-Google-Smtp-Source: AGHT+IGC6gJTPFUpeTBWZHvXEWPldOelBDHsw67xc0ymSDYjHFSPBn6kpD8WkNTjHbWBLj3NLVjUB4bhKcNwPIPO0bU=
X-Received: by 2002:a05:620a:1927:b0:795:4e07:833 with SMTP id
 af79cd13be357-798d26b4a6fmr1074839885a.71.1718626161127; Mon, 17 Jun 2024
 05:09:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171817619547.14261.975798725161704336@noble.neil.brown.name>
 <20240615-fahrrad-bauordnung-a349bacd8c82@brauner> <20240617093745.nhnc7e7efdldnjzl@quack3>
In-Reply-To: <20240617093745.nhnc7e7efdldnjzl@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 17 Jun 2024 15:09:09 +0300
Message-ID: <CAOQ4uxiN3JnH-oJTw63rTR_B8oPBfB7hWyun0Hsb3ZX3AORf2g@mail.gmail.com>
Subject: Re: [PATCH v2] VFS: generate FS_CREATE before FS_OPEN when
 ->atomic_open used.
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, NeilBrown <neilb@suse.de>, James Clark <james.clark@arm.com>, 
	ltp@lists.linux.it, linux-nfs@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 12:37=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Sat 15-06-24 07:35:42, Christian Brauner wrote:
> > On Wed, 12 Jun 2024 17:09:55 +1000, NeilBrown wrote:
> > > When a file is opened and created with open(..., O_CREAT) we get
> > > both the CREATE and OPEN fsnotify events and would expect them in tha=
t
> > > order.   For most filesystems we get them in that order because
> > > open_last_lookups() calls fsnofify_create() and then do_open() (from
> > > path_openat()) calls vfs_open()->do_dentry_open() which calls
> > > fsnotify_open().
> > >
> > > [...]
> >
> > Applied to the vfs.fixes branch of the vfs/vfs.git tree.
> > Patches in the vfs.fixes branch should appear in linux-next soon.
> >
> > Please report any outstanding bugs that were missed during review in a
> > new review to the original patch series allowing us to drop it.
> >
> > It's encouraged to provide Acked-bys and Reviewed-bys even though the
> > patch has now been applied. If possible patch trailers will be updated.
> >
> > Note that commit hashes shown below are subject to change due to rebase=
,
> > trailer updates or similar. If in doubt, please check the listed branch=
.
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> > branch: vfs.fixes
> >
> > [1/1] VFS: generate FS_CREATE before FS_OPEN when ->atomic_open used.
> >       https://git.kernel.org/vfs/vfs/c/7536b2f06724
>
> I have reviewed the patch you've committed since I wasn't quite sure whic=
h
> changes you're going to apply after your discussion with Amir. And I have
> two comments:
>
> @@ -1085,8 +1080,17 @@ EXPORT_SYMBOL(file_path);
>   */
>  int vfs_open(const struct path *path, struct file *file)
>  {
> +       int ret;
> +
>         file->f_path =3D *path;
> -       return do_dentry_open(file, NULL);
> +       ret =3D do_dentry_open(file, NULL);
> +       if (!ret)
> +               /*
> +                * Once we return a file with FMODE_OPENED, __fput() will=
 call
> +                * fsnotify_close(), so we need fsnotify_open() here for =
symmetry.
> +                */
> +               fsnotify_open(file);

Please add { } around multi line indented text.

> +       return ret;
>  }
>
> AFAICT this will have a side-effect that now fsnotify_open() will be
> generated even for O_PATH open. It is true that fsnotify_close() is getti=
ng
> generated for them already and we should strive for symmetry. Conceptuall=
y
> it doesn't make sense to me to generate fsnotify events for O_PATH
> opens/closes but maybe I miss something. Amir, any opinion here?

Good catch!

I agree that we do not need OPEN nor CLOSE events for O_PATH.
I suggest to solve it with:

@@ -915,7 +929,7 @@ static int do_dentry_open(struct file *f,
        f->f_sb_err =3D file_sample_sb_err(f);

        if (unlikely(f->f_flags & O_PATH)) {
-               f->f_mode =3D FMODE_PATH | FMODE_OPENED;
+               f->f_mode =3D FMODE_PATH | FMODE_OPENED | __FMODE_NONOTIFY;
                f->f_op =3D &empty_fops;
                return 0;
        }

>
> @@ -3612,6 +3612,9 @@ static int do_open(struct nameidata *nd,
>         int acc_mode;
>         int error;
>
> +       if (file->f_mode & FMODE_OPENED)
> +               fsnotify_open(file);
> +
>         if (!(file->f_mode & (FMODE_OPENED | FMODE_CREATED))) {
>                 error =3D complete_walk(nd);
>                 if (error)
>
> Frankly, this works but looks as an odd place to put this notification to=
.
> Why not just placing it just next to where fsnotify_create() is generated
> in open_last_lookups()? Like:
>
>         if (open_flag & O_CREAT)
>                 inode_lock(dir->d_inode);
>         else
>                 inode_lock_shared(dir->d_inode);
>         dentry =3D lookup_open(nd, file, op, got_write);
> -       if (!IS_ERR(dentry) && (file->f_mode & FMODE_CREATED))
> -               fsnotify_create(dir->d_inode, dentry);
> +       if (!IS_ERR(dentry)) {
> +               if (file->f_mode & FMODE_CREATED)
> +                       fsnotify_create(dir->d_inode, dentry);
> +               if (file->f_mode & FMODE_OPENED)
> +                       fsnotify_open(file);
> +       }
>         if (open_flag & O_CREAT)
>                 inode_unlock(dir->d_inode);
>         else
>                 inode_unlock_shared(dir->d_inode);
>
> That looks like a place where it is much more obvious this is for
> atomic_open() handling? Now I admit I'm not really closely familiar with
> the atomic_open() paths so maybe I miss something and do_open() is better=
.

It looks nice, but I think it is missing the fast lookup case without O_CRE=
AT
(i.e. goto finish_lookup).

Thanks,
Amir.

