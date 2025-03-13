Return-Path: <linux-fsdevel+bounces-43898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE922A5F632
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 14:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B775917F5F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 13:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B63E267B84;
	Thu, 13 Mar 2025 13:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1NGxhMM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26009267F69;
	Thu, 13 Mar 2025 13:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741873343; cv=none; b=pbJTuuQpmmQz9XIAgx4ICiUDifTHF6ZuKhqwnyTAvz6M5JalB+8gMjXggUZeo2EDj+1SwFx8NsNTwqUpEdXOjuYjWSTE89FjdzzL5zvFh+H6EppksWRnjNCdrhRoV96FN0wbS/9nYkWUu3Q9YvN+FCkP8CHrqHY4QlihQe/beGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741873343; c=relaxed/simple;
	bh=vUkq154MmTaNbeX5y7IT9dR2ZPaTMgiIWHfWmT6YVTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=entJbOoxBvzG3ThUE2AdAomKlZvecrQUdfvKRYOeD7tuizqzJmiOhTSDuI5gkEdSzuewNexWcqc1RepfZIWQffI9pAVfn/a+7VmnDHvbU/hBWQ+a34TK9fdwgEOHUn6BN94PHTwKISFxaxnBL8kg8pDzj40xClk/MBbG7z4UjzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1NGxhMM; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac2b10bea16so193654666b.0;
        Thu, 13 Mar 2025 06:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741873340; x=1742478140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wBLvcn2Uam1JAy1524VS7X2idt5McDCng0CemJjL7a0=;
        b=F1NGxhMMa3f9IUx3PUVpb8pvSeOEVILer4e+L8lUR7C0Lva0KvxuELtuayCYwatZ+W
         4NeiPfBoU8k2jTxqDOI0eosgvazWzv+mn3p8YE9z2RlZQjyQ+EjnXNnn5hUN1KazjtrO
         yc1QdRNcNWiNUI2mGkB2dX1OADh5TOn75jvobe26hGP1aA34p0BLyHkitswviA/eV+vP
         txZvOeddD4AuSED12n8lAaEugjzUY5mKQqyewpK2n49EJQWkSOM+Il2j1hQYnG965bJA
         aJ5QW0rYac1aBiHDjpvbl5dGImhufJcd16d9EsOoQNhbzZ8nDs5hlKt6q7wv+wnDYEx+
         U0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741873340; x=1742478140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wBLvcn2Uam1JAy1524VS7X2idt5McDCng0CemJjL7a0=;
        b=AWbJzWEX54Kpncoe6qhUvKeYi1eEcB1AKJZWMxJzIDwyKSHxeEk3VxtLSGpvJWHnfn
         OHPap+Q/iLAjggvi60Opw0wdu5gYc+6E4CkvhrH44pc0K5kJd/nuaoFIFOS+Pu2OJeWM
         02rwhwGPrIgy8Z9MAgXxum6ZEChSi9nZ4jqvh//aFF0Epigrmf9+EyqJQMgwICEdd5dD
         Uo5hX/43veUUXZKOURkEfTXlp0A1oqS9X5UwunJjf16G/Y7gDbFR5igJyhgczX+vNP6N
         DvmKzO1dp5TKxGdBpd0uXluxypbisYIEum4NUbECtSsYhU1Ovt8nvXJcUZ1AUvLw0+P8
         dOYw==
X-Forwarded-Encrypted: i=1; AJvYcCU/PrtS2ZOtLYEyqlVqo58/Fh2+NktxMqKDzClRASBd7f09fk3kadcsuEH+8fEMviAsEdkYWWyIpZoZjLw9@vger.kernel.org, AJvYcCXRYsJszs8IW8+U+K419vyeIS+n3n5MLBnefnuA+gY8IiVwrR5jIW7WJcbb8oKkNcVBIUC24vLukUOCVFH+@vger.kernel.org
X-Gm-Message-State: AOJu0YzmUwrr/ugNJ01+JCuZsLf4eDI2Mv0/ACqEIqv0SZAqJ6Sln4/b
	Wux+8oho8dlirPPTI00dyZPppzqf32jgAaFB83/n7KP558ekyZ8JDoIFX51HjZYlP+gnBfPAFnA
	nhbx/avJmomME5PLbN/7QLo8aios=
X-Gm-Gg: ASbGncu0OiF0C6x4kVeazTS54qLwHTUQF5q0eSco8uwNyxLrGAXlMPicOjshXySAMSQ
	gk/SjKVUnq7+gsTK2DFYQg7FgVMN+uTvbxbvC6FSoAtx2a1L2+/FTN6BJ17tVSo4kA/6i652tMt
	m57fAack8lX8I6fA6UjTHxBR+2bNYDDY+J/83i
X-Google-Smtp-Source: AGHT+IGWBSsc+O/YuFhR0njb/WLjHHgpbm1hSTx2SbTnF9ieqhehKsU8LlMbq7GD6Xb0rr+23dIp/4C9LhfLOGYsDpc=
X-Received: by 2002:a17:907:9815:b0:ac3:115f:453a with SMTP id
 a640c23a62f3a-ac3115f4b06mr311008966b.36.1741873340065; Thu, 13 Mar 2025
 06:42:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313123159.1315079-1-mjguzik@gmail.com>
In-Reply-To: <20250313123159.1315079-1-mjguzik@gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 13 Mar 2025 14:42:08 +0100
X-Gm-Features: AQ5f1Jp2-UxP4o98nSzqpUXcu1D_gn-dVfmJJSDDOaJ5GCHtpweyY4kgroxH8mo
Message-ID: <CAGudoHGqnCJb+=DgO7Y3yxO2q=MU+QBJ2m9_EqUr+b_nPycudw@mail.gmail.com>
Subject: Re: [PATCH] fs: consistently deref the files table with rcu_access_pointer()
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 1:32=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> ... except when the table is known to be only used by one thread.
>
> A file pointer can get installed at any moment despite the ->file_lock
> being held since the following:
> 8a81252b774b53e6 ("fs/file.c: don't acquire files->file_lock in fd_instal=
l()")
>
> Accesses subject to such a race can in principle suffer load tearing.
>
> While here redo the comment in dup_fd() as it only covered a race against
> files showing up, still assuming fd_install() takes the lock.
>
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
>
> I confirmed the possiblity of the problem with this:
> https://lwn.net/Articles/793253/#Load%20Tearing
>
> Granted, the article being 6 years old might mean some magic was added
> by now to prevent this particular problem.
>
> While technically this classifies as a bugfix, given that nothing blew
> up and this is more of a "just in case" change, I don't think this
> warrants any backports. Thus I'm not adding a Fixes: tag to prevent this
> from being picked by autosel.
>
>  fs/file.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
>
> diff --git a/fs/file.c b/fs/file.c
> index 6c159ede55f1..52010ecb27b8 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -423,17 +423,25 @@ struct files_struct *dup_fd(struct files_struct *ol=
df, struct fd_range *punch_ho
>         old_fds =3D old_fdt->fd;
>         new_fds =3D new_fdt->fd;
>
> +       /*
> +        * We may be racing against fd allocation from other threads usin=
g this
> +        * files_struct, despite holding ->file_lock.
> +        *
> +        * alloc_fd() might have already claimed a slot, while fd_install=
()
> +        * did not populate it yet. Note the latter operates locklessly, =
so
> +        * the file can show up as we are walking the array below.
> +        *
> +        * At the same time we know no files will disappear as all other
> +        * operations take the lock.
> +        *
> +        * Instead of trying to placate userspace racing with itself, we
> +        * ref the file if we see it and mark the fd slot as unused other=
wise.
> +        */
>         for (i =3D open_files; i !=3D 0; i--) {
> -               struct file *f =3D *old_fds++;
> +               struct file *f =3D rcu_access_pointer(*old_fds++);

sigh, that happens to work but is technically bogus -- I thought I did
rcu_deference, but instead had rcu_access_pointer in my fingers from
the assert thing. Thanks for Mathieu for noticing.

That is to say the patch has to s/rcu_access_pointer/rcu_dereference.

However, willy suggested also adding the check. So perhaps this can
instead use the _check variant with lockdep_is_held(&fdt->file_lock)
as the argument.

I don't have an opinion on this bit -- the accesses are next to the
lock acquire, so perhaps this only serves an uglifier.

That said, if you want the assert, I'll post a v2. Otherwise please
run the sed :->

>                 if (f) {
>                         get_file(f);
>                 } else {
> -                       /*
> -                        * The fd may be claimed in the fd bitmap but not=
 yet
> -                        * instantiated in the files array if a sibling t=
hread
> -                        * is partway through open().  So make sure that =
this
> -                        * fd is available to the new process.
> -                        */
>                         __clear_open_fd(open_files - i, new_fdt);
>                 }
>                 rcu_assign_pointer(*new_fds++, f);
> @@ -684,7 +692,7 @@ struct file *file_close_fd_locked(struct files_struct=
 *files, unsigned fd)
>                 return NULL;
>
>         fd =3D array_index_nospec(fd, fdt->max_fds);
> -       file =3D fdt->fd[fd];
> +       file =3D rcu_access_pointer(fdt->fd[fd]);
>         if (file) {
>                 rcu_assign_pointer(fdt->fd[fd], NULL);
>                 __put_unused_fd(files, fd);
> @@ -1252,7 +1260,7 @@ __releases(&files->file_lock)
>          */
>         fdt =3D files_fdtable(files);
>         fd =3D array_index_nospec(fd, fdt->max_fds);
> -       tofree =3D fdt->fd[fd];
> +       tofree =3D rcu_access_pointer(fdt->fd[fd]);
>         if (!tofree && fd_is_open(fd, fdt))
>                 goto Ebusy;
>         get_file(file);
> --
> 2.43.0
>


--=20
Mateusz Guzik <mjguzik gmail.com>

