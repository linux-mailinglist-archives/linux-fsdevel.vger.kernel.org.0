Return-Path: <linux-fsdevel+bounces-36104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA369DBBA1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 18:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C412B20E93
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 17:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978FD1C07E2;
	Thu, 28 Nov 2024 17:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWANCEqQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D3D9463;
	Thu, 28 Nov 2024 17:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732813619; cv=none; b=NqvefSNeUvqHlG6Bsgp9XfR30hSgeBx1a8rX95YVa2tf1pGrKO6isQr9PTZ3PxS84UN/Ely8sFDmkalfAUvK3qG1uD0XJkJSXXxa5RYo3vXMZeY4hvQt6JhHlnRsdr3H9aaaDPDrXGLyaATH7GLEL50zyQuWCgN9dxCXFVLrgHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732813619; c=relaxed/simple;
	bh=SEHlJifrN0Cs6lY+UEiGhN9+PywenO1OmSKs5+KtEpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dKp1aNoZXqCvW7lwJg3Dpzr5ussPHgFzOV7pP2RjDKx5N4ZLR0pvypewpYtkmdEbHXlyVR7USJyELV+nmvsXuYOA4JXPHwhEpPTKtDU27OxlOec9OGwoY3a+fb8k4mrzDLiNtW0gm8a2aViDF0gkgaMz9ebQlOHtUPDHMP2J9qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWANCEqQ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa53a971480so133976566b.1;
        Thu, 28 Nov 2024 09:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732813615; x=1733418415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWQ8VbEdvjXMUcHdgYXIjQKdG5RqS9Dcs74tC/QMmZ0=;
        b=PWANCEqQXl6sTrA9NAshVRxNSVDRU+klDQIWhnnJK6Smc+R2egG2WXugFgnQq7MKWO
         pT4ATw9aNqNaZJsvkMwjjFkFfOjGR/+gWwGAiZ0/3lDHPv1vSfhRiW5oLrf0pWx8ToXr
         RfG0pGBtO5fTWEBWwBg3dwpEIRxIC7YWQbZbRvYfATJYb0AlC76jOKPOBRBLy2UyI/hZ
         P/fEMhyYHjWGU5H33b2cXNGzGk84Kf5vNPanfXfWHdHtuC5m8QkDL+iKgtQJcgsldUL0
         ZPfer3NKdOiR5iH77vw/H2MKG582C4wp43LVMeQe8YowVnAnwYTQy+Fp5XZI00YImh3X
         udrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732813615; x=1733418415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nWQ8VbEdvjXMUcHdgYXIjQKdG5RqS9Dcs74tC/QMmZ0=;
        b=cfbt58NVWHQou+5IuMwS2aXNMonPNdfWgtsWQNougGIjZ2v9Tf52HMXKBlAaWQ9SdH
         TwnhGodvZVHPXhQZWISk9iPS37fK40DKVX2Uak330nH7/u/O7+LTIixeyUsB/yTG9Xen
         5OsJbTdaGojFgPw8D9lEjlRyXr3gL6RCg4dnIaIkEwRkPH4Dmh5TOzppO93+fkKqaEe8
         AWBMbg3nHYRNWHL6NmQQB9Y+LjtD7pLOLwoduxG0KLAoq/djzPqoFPtKHWbvgkcg7EEc
         skYG6vZzy/xtj0SUUklLDLcCNaGdaldR3Oum43q9c9nVu5hLQWKlPTUWfst/HUdwBSgG
         gf0g==
X-Forwarded-Encrypted: i=1; AJvYcCUb4Gi5VYqiiYb6Fv8OS2svrffkjoD4nfaKzJL1hKZU9rCrN7LL8FXMjGS9W1PkRyQ8djWo8VgrqnzkM2Ew@vger.kernel.org, AJvYcCV8ZV2BVf7EPqgf/u6tljOP50wEVlnylcwNQvBQHPTy0il3iR4rOQ7Gi5kZ6pPZvBe+GBu98oCEBRwv@vger.kernel.org, AJvYcCWjtoVLOQeYkCVFG6cwqojokPZ80pOO515IE/a7iPbrojrFEteVzeQ5pKTfNeQG7a/zW7GoThAY/s/yPbNU@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4Hj/fjtOYYHRGZAl/HIyr4KTBjS2Ple/Dq454WrDA0IY1UEEm
	JmHrn2Tnj+naRHRWgp/8sDqwjzyltCxmicYsfA1PxitdXJ/jD+sIMVprZuGCoXs/pqUiaPwoaSi
	X8Nt1k3DZyO2B1tfl5H/A6gpjGF4=
X-Gm-Gg: ASbGncsx/Kv1HBq0K0MAGBSzuIqfR/yovXS/UC8gjDeFhrxLAEut9fxxl/N8K3VPJVl
	50GW+Cl0mqMyoaQBj/HfpNgk/MtHPAf4=
X-Google-Smtp-Source: AGHT+IFZsoGNSDYLQa6vTS2JV4JwQxRJDWlRt4KfY3J5QfCjMg2n66+/Idb7fucFkckCWow14kxWTN8GyDRosH2HYJI=
X-Received: by 2002:a17:906:3103:b0:aa5:2c5f:95b0 with SMTP id
 a640c23a62f3a-aa580ef327amr515350766b.8.1732813615124; Thu, 28 Nov 2024
 09:06:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114-fragt-rohre-28b21496ecbc@brauner> <20241128-work-pidfs-v1-0-80f267639d98@kernel.org>
In-Reply-To: <20241128-work-pidfs-v1-0-80f267639d98@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 28 Nov 2024 18:06:44 +0100
Message-ID: <CAOQ4uxj7-kxT-OrhYuCHr7hCQVwrExTVDrg5SXwZdDnx-wJoSA@mail.gmail.com>
Subject: Re: [PATCH RFC 0/2] pidfs: file handle preliminaries
To: Christian Brauner <brauner@kernel.org>
Cc: Erin Shepherd <erin.shepherd@e43.eu>, Jeff Layton <jlayton@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 1:34=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> Hey,
>
> This reworks the inode number allocation for pidfs in order to support
> file handles properly.
>
> Recently we received a patchset that aims to enable file handle encoding
> and decoding via name_to_handle_at(2) and open_by_handle_at(2).
>
> A crucical step in the patch series is how to go from inode number to
> struct pid without leaking information into unprivileged contexts. The
> issue is that in order to find a struct pid the pid number in the
> initial pid namespace must be encoded into the file handle via
> name_to_handle_at(2). This can be used by containers using a separate
> pid namespace to learn what the pid number of a given process in the
> initial pid namespace is. While this is a weak information leak it could
> be used in various exploits and in general is an ugly wart in the
> design.
>
> To solve this problem a new way is needed to lookup a struct pid based
> on the inode number allocated for that struct pid. The other part is to
> remove the custom inode number allocation on 32bit systems that is also
> an ugly wart that should go away.
>
> So, a new scheme is used that I was discusssing with Tejun some time
> back. A cyclic ida is used for the lower 32 bits and a the high 32 bits
> are used for the generation number. This gives a 64 bit inode number
> that is unique on both 32 bit and 64 bit. The lower 32 bit number is
> recycled slowly and can be used to lookup struct pids.
>
> So after applying the pidfs file handle series at
> https://lore.kernel.org/r/20241101135452.19359-1-erin.shepherd@e43.eu on
> top of the patches here we should be able to simplify encoding and
> decoding to something like:
>
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index e71294d3d607..a38b833a2d38 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -78,7 +78,7 @@ void pidfs_remove_pid(struct pid *pid)
>  }
>
>  /* Find a struct pid based on the inode number. */
> -static __maybe_unused struct pid *pidfs_ino_get_pid(u64 ino)
> +static struct pid *pidfs_ino_get_pid(u64 ino)
>  {
>         ino_t pid_ino =3D pidfs_ino(ino);
>         u32 gen =3D pidfs_gen(ino);
> @@ -475,49 +475,37 @@ static const struct dentry_operations pidfs_dentry_=
operations =3D {
>         .d_prune        =3D stashed_dentry_prune,
>  };
>
> -#define PIDFD_FID_LEN 3
> -
> -struct pidfd_fid {
> -       u64 ino;
> -       s32 pid;
> -} __packed;
> -
> -static int pidfs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
> +static int pidfs_encode_fh(struct inode *inode, __u32 *fh, int *max_len,
>                            struct inode *parent)
>  {
>         struct pid *pid =3D inode->i_private;
> -       struct pidfd_fid *fid =3D (struct pidfd_fid *)fh;
>
> -       if (*max_len < PIDFD_FID_LEN) {
> -               *max_len =3D PIDFD_FID_LEN;
> +       if (*max_len < 2) {
> +               *max_len =3D 2;
>                 return FILEID_INVALID;
>         }
>
> -       fid->ino =3D pid->ino;
> -       fid->pid =3D pid_nr(pid);
> -       *max_len =3D PIDFD_FID_LEN;
> +       *max_len =3D 2;
> +       *(u64 *)fh =3D pid->ino;
>         return FILEID_INO64_GEN;

Semantic remark:
        /*
         * 64 bit inode number, 32 bit generation number.
         */
        FILEID_INO64_GEN =3D 0x81,

filesystems are free to abuse the constants and return whatever id they wan=
t
(e.g. shmem_encode_fh()), but if you want to play by the rules, this would =
be
either:
        /*
         * 64 bit unique kernfs id
         */
        FILEID_KERNFS =3D 0xfe,

or:
        /*
         * 32bit inode number, 32 bit generation number.
         */
        FILEID_INO32_GEN =3D 1,

which is at least sometimes correct.
or define:
        /*
         * 64 bit inode number.
         */
        FILEID_INO64 =3D 0x80,


Thanks,
Amir.

