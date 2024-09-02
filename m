Return-Path: <linux-fsdevel+bounces-28272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D463F968CC9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 19:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31A1FB227C0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 17:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8321C62B2;
	Mon,  2 Sep 2024 17:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6uvSwql"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBDA19F129;
	Mon,  2 Sep 2024 17:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725297685; cv=none; b=gtgEC7G46ckup/+58RuuJLVxPJS6v7b/WbYUMILK+q/gpjo4G5PFwbfPumjZPGxEX4csZLSADdlmHIRXs9Ry7fAe7yqeoSGQs2aq8wfNjUl+HNsrzgaUryG/u6NbUP4e2Td3d5VHLKUd+FtBY/v1+0oB9gjFKXLECTQklyWo0B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725297685; c=relaxed/simple;
	bh=lVTupkyU01N0oKof3u8/y4ywmsHOJ1uSbRiW8VrMlbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qKH+v1jgOQnGpuk8EE39A7FGyrjPBzxXpm6Jk7QzPeP73oSaOsdRpnH8iigGEMdiICRx8+l6eAomTsD1T6BblyGhes6Gqt6Hb19vO9rXTCA8uc7ZtWCN0y7nDqOOluQFRVksM8FAyj4FxmI9//ap7Sy5HIHSrzwm0JqBALpIiHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6uvSwql; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5e16cb56d4aso792954eaf.1;
        Mon, 02 Sep 2024 10:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725297682; x=1725902482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aa3bPBG2YKua0DEj/+QUuBgK0XcF9v60/0tk2S/AulE=;
        b=Q6uvSwql70kgMcMi59TVRpCYu6zrFwpO5FovGgj56JiJDlviMK2qmt0rlZCHT+jno2
         xLLK2BSX+lh4hsMQR2Ck/KcZHynawP6kP+YtyaqDHRuXrO4KzzNvak72AhHAHxKYMho2
         1Cfrm2FU7fdmayDVA9NMvc6FjjBFrlzvVdp8LHIRaHYvi8O918b8Qyl1hNvRKuDwCc0S
         +kgyczgRanZrZQj6j63iB7riRMF37iMwuQmUlHMTFQBz6FdBj4zB1i9EQeTCuAHDydms
         lw9ASlCOgrKSSvPQ28/jG77gowonxawWQTHCD0gnOSM+RUDV9YleZyd/GWmg46Gru/Ku
         e0gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725297682; x=1725902482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aa3bPBG2YKua0DEj/+QUuBgK0XcF9v60/0tk2S/AulE=;
        b=kLMSMNmcuAmdgas7zxYiIYU+2kFkaCiPiDn3tluv2V21a2xmQ3lF9zHVu+LNPboH3z
         WWOKzOFWfP0cGEvF01z0SJv7qKIOntx1hjP9qXPNrG3SbnaAoS3ZhnhQqor8mlmeCVAr
         aL58AMPDpmPmY2eECEuwXfYhkwATKZPGukusK2KVljCKKRw5KUgaFz0SfcqvihAYehg3
         gOwlI5i421avE8OlE2hYqVaBdVprNHBDwaG4J98HUtyISG67YU7QyOAwr1E9Xt0QmWzt
         ULj6DCdmRsVp1Nm2CoJi7wuLnZ6c4mI65yPmeyQX+zF+uBJBezJ9E3lhRoyYZj6ow1t5
         8Yww==
X-Forwarded-Encrypted: i=1; AJvYcCUjUqbWBbshtxFCjaoJxa9Q6Ntr1hR5+Zq8ySgwigQ+Agy3p5LevU0JslCXIbBre/tW+aDX3G5jQCfHbVVjdQ==@vger.kernel.org, AJvYcCWD5nwuSHvpZUaKW2krbaOBaWdiqnuTS6mfx5lgqwpCKI+1zZ/VHvYDjGS//mcf2+e8flPfN+P3oUUlX6EP@vger.kernel.org, AJvYcCWxYpZHsClpq9t6Kv8YP5v+9wrl0XjRgrh906jVjuhlxHou54hZ1DjSLdg57hcLZd/Hg9wZ1oq7vPmq2fcm+UL7lQ==@vger.kernel.org, AJvYcCXSuKMPeQEpir1Wv6FBUNFTUsVxHFkaEXN3Sa+EqAhXEdarEpS28157H9sDrWmf/y51hPclmWRefAFB@vger.kernel.org, AJvYcCXW34cBbZvqrbpnfK1pUfQAIzONPfiKZ/GHIt9sOeypE1OY0FJbMBujjvcV20mLPyecnFeSgFKMBeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXCY202wGQh+hh0ZvrlFkx/eVI9TGv+yH4Vq5xqmuENHGDY02o
	NPKHuXqGfo4+AVYFrXq17l1B9UzRpMFfploT7RcasR5fBtL/lHjoVXC33mQO1aBbhin0jv1YuNI
	m+F+igLGs3uArH+5E/rF00kop7c0=
X-Google-Smtp-Source: AGHT+IH5iaQ/fJ8KMiIlFTaNIfC3paJhX6nEmgs8RNGq0rLg0j/Mgp6sjU0uPzcZvqCFb9T+NABT3o/nKrlntwByPhQ=
X-Received: by 2002:a05:6870:700d:b0:278:294:b547 with SMTP id
 586e51a60fabf-2780294b78dmr2726228fac.1.1725297682474; Mon, 02 Sep 2024
 10:21:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828-exportfs-u64-mount-id-v3-0-10c2c4c16708@cyphar.com>
 <20240902164554.928371-1-cyphar@cyphar.com> <20240902164554.928371-2-cyphar@cyphar.com>
In-Reply-To: <20240902164554.928371-2-cyphar@cyphar.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 2 Sep 2024 19:21:09 +0200
Message-ID: <CAOQ4uxgS6DvsbUsEoM1Vr2wcd_7Bj=xFXMAy4z9PphTu+G6RaQ@mail.gmail.com>
Subject: Re: [PATCH xfstests v2 2/2] open_by_handle: add tests for u64 mount ID
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: fstests@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Alexander Aring <alex.aring@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Christoph Hellwig <hch@infradead.org>, 
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 6:46=E2=80=AFPM Aleksa Sarai <cyphar@cyphar.com> wro=
te:
>
> Now that open_by_handle_at(2) can return u64 mount IDs, do some tests to
> make sure they match properly as part of the regular open_by_handle
> tests.
>
> Link: https://lore.kernel.org/all/20240828-exportfs-u64-mount-id-v3-0-10c=
2c4c16708@cyphar.com/
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> ---
> v2:
> - Remove -M argument and always do the mount ID tests. [Amir Goldstein]
> - Do not error out if the kernel doesn't support STATX_MNT_ID_UNIQUE
>   or AT_HANDLE_MNT_ID_UNIQUE. [Amir Goldstein]
> - v1: <https://lore.kernel.org/all/20240828103706.2393267-1-cyphar@cyphar=
.com/>

Looks good.

You may add:

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

It'd be nice to get a verification that this is indeed tested on the latest
upstream and does not regress the tests that run the open_by_handle program=
.

Thanks,
Amir.

>
>  src/open_by_handle.c | 128 +++++++++++++++++++++++++++++++++----------
>  1 file changed, 99 insertions(+), 29 deletions(-)
>
> diff --git a/src/open_by_handle.c b/src/open_by_handle.c
> index d9c802ca9bd1..0ad591da632e 100644
> --- a/src/open_by_handle.c
> +++ b/src/open_by_handle.c
> @@ -86,10 +86,16 @@ Examples:
>  #include <errno.h>
>  #include <linux/limits.h>
>  #include <libgen.h>
> +#include <stdint.h>
> +#include <stdbool.h>
>
>  #include <sys/stat.h>
>  #include "statx.h"
>
> +#ifndef AT_HANDLE_MNT_ID_UNIQUE
> +#      define AT_HANDLE_MNT_ID_UNIQUE 0x001
> +#endif
> +
>  #define MAXFILES 1024
>
>  struct handle {
> @@ -120,6 +126,94 @@ void usage(void)
>         exit(EXIT_FAILURE);
>  }
>
> +int do_name_to_handle_at(const char *fname, struct file_handle *fh, int =
bufsz)
> +{
> +       int ret;
> +       int mntid_short;
> +
> +       static bool skip_mntid_unique;
> +
> +       uint64_t statx_mntid_short =3D 0, statx_mntid_unique =3D 0;
> +       struct statx statxbuf;
> +
> +       /* Get both the short and unique mount id. */
> +       if (statx(AT_FDCWD, fname, 0, STATX_MNT_ID, &statxbuf) < 0) {
> +               fprintf(stderr, "%s: statx(STATX_MNT_ID): %m\n", fname);
> +               return EXIT_FAILURE;
> +       }
> +       if (!(statxbuf.stx_mask & STATX_MNT_ID)) {
> +               fprintf(stderr, "%s: no STATX_MNT_ID in stx_mask\n", fnam=
e);
> +               return EXIT_FAILURE;
> +       }
> +       statx_mntid_short =3D statxbuf.stx_mnt_id;
> +
> +       if (!skip_mntid_unique) {
> +               if (statx(AT_FDCWD, fname, 0, STATX_MNT_ID_UNIQUE, &statx=
buf) < 0) {
> +                       fprintf(stderr, "%s: statx(STATX_MNT_ID_UNIQUE): =
%m\n", fname);
> +                       return EXIT_FAILURE;
> +               }
> +               /*
> +                * STATX_MNT_ID_UNIQUE was added fairly recently in Linux=
 6.8, so if the
> +                * kernel doesn't give us a unique mount ID just skip it.
> +                */
> +               if ((skip_mntid_unique |=3D !(statxbuf.stx_mask & STATX_M=
NT_ID_UNIQUE)))
> +                       printf("statx(STATX_MNT_ID_UNIQUE) not supported =
by running kernel -- skipping unique mount ID test\n");
> +               else
> +                       statx_mntid_unique =3D statxbuf.stx_mnt_id;
> +       }
> +
> +       fh->handle_bytes =3D bufsz;
> +       ret =3D name_to_handle_at(AT_FDCWD, fname, fh, &mntid_short, 0);
> +       if (bufsz < fh->handle_bytes) {
> +               /* Query the filesystem required bufsz and the file handl=
e */
> +               if (ret !=3D -1 || errno !=3D EOVERFLOW) {
> +                       fprintf(stderr, "%s: unexpected result from name_=
to_handle_at: %d (%m)\n", fname, ret);
> +                       return EXIT_FAILURE;
> +               }
> +               ret =3D name_to_handle_at(AT_FDCWD, fname, fh, &mntid_sho=
rt, 0);
> +       }
> +       if (ret < 0) {
> +               fprintf(stderr, "%s: name_to_handle: %m\n", fname);
> +               return EXIT_FAILURE;
> +       }
> +
> +       if (mntid_short !=3D (int) statx_mntid_short) {
> +               fprintf(stderr, "%s: name_to_handle_at returned a differe=
nt mount ID to STATX_MNT_ID: %u !=3D %lu\n", fname, mntid_short, statx_mnti=
d_short);
> +               return EXIT_FAILURE;
> +       }
> +
> +       if (!skip_mntid_unique && statx_mntid_unique !=3D 0) {
> +               struct handle dummy_fh;
> +               uint64_t mntid_unique =3D 0;
> +
> +               /*
> +                * Get the unique mount ID. We don't need to get another =
copy of the
> +                * handle so store it in a dummy struct.
> +                */
> +               dummy_fh.fh.handle_bytes =3D fh->handle_bytes;
> +               ret =3D name_to_handle_at(AT_FDCWD, fname, &dummy_fh.fh, =
(int *) &mntid_unique, AT_HANDLE_MNT_ID_UNIQUE);
> +               if (ret < 0) {
> +                       if (errno !=3D EINVAL) {
> +                               fprintf(stderr, "%s: name_to_handle_at(AT=
_HANDLE_MNT_ID_UNIQUE): %m\n", fname);
> +                               return EXIT_FAILURE;
> +                       }
> +                       /*
> +                        * EINVAL means AT_HANDLE_MNT_ID_UNIQUE is not su=
pported, so skip
> +                        * the check in that case.
> +                        */
> +                       printf("name_to_handle_at(AT_HANDLE_MNT_ID_UNIQUE=
) not supported by running kernel -- skipping unique mount ID test\n");
> +                       skip_mntid_unique =3D true;
> +               } else {
> +                       if (mntid_unique !=3D statx_mntid_unique) {
> +                               fprintf(stderr, "%s: name_to_handle_at(AT=
_HANDLE_MNT_ID_UNIQUE) returned a different mount ID to STATX_MNT_ID_UNIQUE=
: %lu !=3D %lu\n", fname, mntid_unique, statx_mntid_unique);
> +                               return EXIT_FAILURE;
> +                       }
> +               }
> +       }
> +
> +       return 0;
> +}
> +
>  int main(int argc, char **argv)
>  {
>         int     i, c;
> @@ -132,7 +226,7 @@ int main(int argc, char **argv)
>         char    fname2[PATH_MAX];
>         char    *test_dir;
>         char    *mount_dir;
> -       int     mount_fd, mount_id;
> +       int     mount_fd;
>         char    *infile =3D NULL, *outfile =3D NULL;
>         int     in_fd =3D 0, out_fd =3D 0;
>         int     numfiles =3D 1;
> @@ -307,21 +401,9 @@ int main(int argc, char **argv)
>                                 return EXIT_FAILURE;
>                         }
>                 } else {
> -                       handle[i].fh.handle_bytes =3D bufsz;
> -                       ret =3D name_to_handle_at(AT_FDCWD, fname, &handl=
e[i].fh, &mount_id, 0);
> -                       if (bufsz < handle[i].fh.handle_bytes) {
> -                               /* Query the filesystem required bufsz an=
d the file handle */
> -                               if (ret !=3D -1 || errno !=3D EOVERFLOW) =
{
> -                                       fprintf(stderr, "Unexpected resul=
t from name_to_handle_at(%s)\n", fname);
> -                                       return EXIT_FAILURE;
> -                               }
> -                               ret =3D name_to_handle_at(AT_FDCWD, fname=
, &handle[i].fh, &mount_id, 0);
> -                       }
> -                       if (ret < 0) {
> -                               strcat(fname, ": name_to_handle");
> -                               perror(fname);
> +                       ret =3D do_name_to_handle_at(fname, &handle[i].fh=
, bufsz);
> +                       if (ret < 0)
>                                 return EXIT_FAILURE;
> -                       }
>                 }
>                 if (keepopen) {
>                         /* Open without close to keep unlinked files arou=
nd */
> @@ -349,21 +431,9 @@ int main(int argc, char **argv)
>                                 return EXIT_FAILURE;
>                         }
>                 } else {
> -                       dir_handle.fh.handle_bytes =3D bufsz;
> -                       ret =3D name_to_handle_at(AT_FDCWD, test_dir, &di=
r_handle.fh, &mount_id, 0);
> -                       if (bufsz < dir_handle.fh.handle_bytes) {
> -                               /* Query the filesystem required bufsz an=
d the file handle */
> -                               if (ret !=3D -1 || errno !=3D EOVERFLOW) =
{
> -                                       fprintf(stderr, "Unexpected resul=
t from name_to_handle_at(%s)\n", dname);
> -                                       return EXIT_FAILURE;
> -                               }
> -                               ret =3D name_to_handle_at(AT_FDCWD, test_=
dir, &dir_handle.fh, &mount_id, 0);
> -                       }
> -                       if (ret < 0) {
> -                               strcat(dname, ": name_to_handle");
> -                               perror(dname);
> +                       ret =3D do_name_to_handle_at(test_dir, &dir_handl=
e.fh, bufsz);
> +                       if (ret < 0)
>                                 return EXIT_FAILURE;
> -                       }
>                 }
>                 if (out_fd) {
>                         ret =3D write(out_fd, (char *)&dir_handle, sizeof=
(*handle));
> --
> 2.46.0
>

