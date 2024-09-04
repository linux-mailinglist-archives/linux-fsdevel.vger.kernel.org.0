Return-Path: <linux-fsdevel+bounces-28616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BDF96C66C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 20:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55D321F22151
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 18:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AE91E200D;
	Wed,  4 Sep 2024 18:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlDAQuAM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BDA12BEBB;
	Wed,  4 Sep 2024 18:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725474582; cv=none; b=SLYdNMz0XqqjDzkZYPQTrQVC5xcmt8SwYSzUx89aFi3cfk4IqL+RxmnsXhTPkr38V7fNMD2g0ikMTHxPCi4olI0Ec2lKHz4Wc8AiejpW9/FYjC1Qw5gEki/l4vijqkyESrTPGL9J5Cd8dUXLBueYQXJ6+OFMMl1yV62tfYCHoGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725474582; c=relaxed/simple;
	bh=X26618YqE/C/Q/4Ml7q06ULZiQUsw5VBadnMqw8gJ6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GqAGh8e6nfgD5zhaaFwDWTQE+1RUURc6p/F01v2ZVEOT1EZ2qHGzFWf9pePas1zZ/GODgCcL+fcln5qUWZ7goto6HE2XYGP4iV3ETRUPV7VUkNj6SJ18iCJsioD0IZS66nx/wo3UTXX8HSsbKgRhTr0CTAVlE4VkfrU7QyIuby0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OlDAQuAM; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7a80aeabb82so414267285a.0;
        Wed, 04 Sep 2024 11:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725474579; x=1726079379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ScRacpdIl9qJgI0g3gG8Dr/F+hKP5Jg96sd600ilJH0=;
        b=OlDAQuAMtnpYNoObnQx3pQDWbQt62LsnZ/nnP0E4O/+bX/xvBsxrBAaZoChC+hp5xv
         /eKh+rmqwJcmkUL3fP8vpPYLE3IP7paeYFCphUbAyalXfxd84OR4S3Y67zk/pR4SCmkk
         D9GKuFf1Bv7cmLUlXVXEZ+GbCLY6l0zWSyhMV8yeRRNXo7dN8xwJBBZCYsN2pG9qkHuN
         Jm/8Rznhi0T9evEjtVHH5wSj6mxcoRmU2mssGxjGYITittNCdR98yUso8G7IrBogAn4h
         ZZsdlvyTFfetice+naSXJvHJgIqOfYzCIT5GW7IwJCUE9vL6tcZTtczUxy6TCPv5s2C7
         s/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725474579; x=1726079379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ScRacpdIl9qJgI0g3gG8Dr/F+hKP5Jg96sd600ilJH0=;
        b=UYay5ukGEiSsH3XsNATzhvq8KKcfQQMkA/GuIyyvcJkrB0wbZ+0UHxzRaTcr1HNzbd
         DTsoCwOmHZj7hD81qYjY75J5RRW+9REC3uzbeXa0ZKTE739mmw0aRQ1NBVrOxjvgXF/L
         qovx+8St1hUyoj/DFEBgYfXGY+Y6oJ8a2FRC7jBf6096No33UBa6JQDY3AjgnNnqC+M6
         Hbw9zOn34KcgJk/8UDq9uOFzmxgZPLShSQBx9we+38tDqIvEWKYFwcIdo0+RwbMhxWmX
         DMNtWvLnZvWXxRfEGMVvifpEJY1XXZKwtDk8TUNS2aSFee0QHxK4UwPKOqHJU6dIaVMI
         K0Dw==
X-Forwarded-Encrypted: i=1; AJvYcCV3A2e6EFpGl61R1YsiZbf6mMxo+4OUzxRfqUUZtLA2a/mEqWBSwO/vTt+X+wj13n5cS4bq5+AkyotInQ/gKWWF6Q==@vger.kernel.org, AJvYcCVbnWI2wyuFustrQwPNuW7uSSFrnUt7fVNx8Z1kh9lRPWWz9/pKgbETYwc5Ja/b6rYuzBXpoR6j17c=@vger.kernel.org, AJvYcCWc52bOaBvRscYO89oqoBIjkEKG9BkyTH3dIWC4lgOSunwTN5SbBo1ygeU4i/9TYt3zzlopy6RkrY1Vjnm7@vger.kernel.org, AJvYcCWmPb7CtsUB7NyHQYScCXf2Y8WDlwzUXsZvNLF3TrTqmQ5xNdxaRREtERFDU2fwvLSQVpX5fKK58KU2@vger.kernel.org, AJvYcCX8951TmDx8b/tRy6DyWtxYt1ruZNjaUiuv30FVw56ZPJZ5T1VjenfuO7ivNz5B3gnAN6Jkq6AI1KDPSdliKw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzE4ljDhadHCrurWJcj2Ais3OmFSsAySbO+upaiRXou/F1TidLM
	XT17F+kmIKR0ykN7+sc6RE2LFFdFw2c22dNpK/R3RoTov04nZGr/8IqCtz89nNZHrSnj9ffLzwl
	BCZK/U8VXCR2aksNzci6hNY9Eo9c=
X-Google-Smtp-Source: AGHT+IFjrTcn2Nl8Jm42zC+nOk5DdmCuYbOp7mgw/wKk4+vHky9YoHVu3h7Kf5yfbco1n3D/5ZEPdvXUNIVHagN523c=
X-Received: by 2002:a0c:be92:0:b0:6c5:e6c:d5f8 with SMTP id
 6a1803df08f44-6c50e6cd64amr75851596d6.19.1725474579279; Wed, 04 Sep 2024
 11:29:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828-exportfs-u64-mount-id-v3-0-10c2c4c16708@cyphar.com> <20240904175639.2269694-1-cyphar@cyphar.com>
In-Reply-To: <20240904175639.2269694-1-cyphar@cyphar.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 4 Sep 2024 20:29:27 +0200
Message-ID: <CAOQ4uxi5KdtD02gazgJfvUKktev39Y+otAZat=H22tKrW16ZrQ@mail.gmail.com>
Subject: Re: [PATCH xfstests v3 1/2] open_by_handle: verify u32 and u64 mount IDs
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

On Wed, Sep 4, 2024 at 7:57=E2=80=AFPM Aleksa Sarai <cyphar@cyphar.com> wro=
te:
>
> Now that open_by_handle_at(2) can return u64 mount IDs, do some tests to
> make sure they match properly as part of the regular open_by_handle
> tests. Also, add automatic tests for the old u32 mount IDs as well.
>
> By default, we do mount ID checks but silently skip the tests if the
> syscalls are not supported by the running kernel (to ensure the tests
> continue to work for old kernels). We will add some tests explicitly
> checking the new features (with no silent skipping) in a future patch.
>
> The u32 mount ID tests require STATX_MNT_ID (Linux 5.8), while the u64
> mount ID tests require STATX_MNT_ID_UNIQUE (Linux 6.9) and
> AT_HANDLE_MNT_ID_UNIQUE (linux-next).
>
> Link: https://lore.kernel.org/all/20240828-exportfs-u64-mount-id-v3-0-10c=
2c4c16708@cyphar.com/
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
> Changed in v3:
> - Make skipping completely silent in regular open_by_handle mode. [Amir G=
oldstein]
> - Re-add -M to turn skipping into errors and add a new test that uses
>   -M, but is skipped on older kernels. [Amir Goldstein]
> - v2: <https://lore.kernel.org/all/20240902164554.928371-1-cyphar@cyphar.=
com/>
> Changed in v2:
> - Remove -M argument and always do the mount ID tests. [Amir Goldstein]
> - Do not error out if the kernel doesn't support STATX_MNT_ID_UNIQUE
>   or AT_HANDLE_MNT_ID_UNIQUE. [Amir Goldstein]
> - v1: <https://lore.kernel.org/all/20240828103706.2393267-1-cyphar@cyphar=
.com/>
> ---
>  src/open_by_handle.c | 132 +++++++++++++++++++++++++++++++++----------
>  1 file changed, 103 insertions(+), 29 deletions(-)
>
> diff --git a/src/open_by_handle.c b/src/open_by_handle.c
> index 0f74ed08b1f0..920ec7d9170b 100644
> --- a/src/open_by_handle.c
> +++ b/src/open_by_handle.c
> @@ -87,6 +87,15 @@ Examples:
>  #include <errno.h>
>  #include <linux/limits.h>
>  #include <libgen.h>
> +#include <stdint.h>
> +#include <stdbool.h>
> +
> +#include <sys/stat.h>
> +#include "statx.h"
> +
> +#ifndef AT_HANDLE_MNT_ID_UNIQUE
> +#      define AT_HANDLE_MNT_ID_UNIQUE 0x001
> +#endif
>
>  #define MAXFILES 1024
>
> @@ -108,6 +117,7 @@ void usage(void)
>         fprintf(stderr, "open_by_handle -a <test_dir> [N] - write data to=
 test files after open by handle\n");
>         fprintf(stderr, "open_by_handle -l <test_dir> [N] - create hardli=
nks to test files, drop caches and try to open by handle\n");
>         fprintf(stderr, "open_by_handle -u <test_dir> [N] - unlink (hardl=
inked) test files, drop caches and try to open by handle\n");
> +       fprintf(stderr, "open_by_handle -U <test_dir> [N] - verify the mo=
unt ID returned with AT_HANDLE_MNT_ID_UNIQUE is correct\n");
>         fprintf(stderr, "open_by_handle -d <test_dir> [N] - unlink test f=
iles and hardlinks, drop caches and try to open by handle\n");
>         fprintf(stderr, "open_by_handle -m <test_dir> [N] - rename test f=
iles, drop caches and try to open by handle\n");
>         fprintf(stderr, "open_by_handle -p <test_dir>     - create/delete=
 and try to open by handle also test_dir itself\n");
> @@ -118,6 +128,94 @@ void usage(void)
>         exit(EXIT_FAILURE);
>  }
>
> +static int do_name_to_handle_at(const char *fname, struct file_handle *f=
h,
> +                               int bufsz)
> +{
> +       int ret;
> +       int mntid_short;
> +
> +       static bool skip_mntid, skip_mntid_unique;
> +
> +       uint64_t statx_mntid_short =3D 0, statx_mntid_unique =3D 0;
> +       struct statx statxbuf;
> +
> +       /* Get both the short and unique mount id. */
> +       if (!skip_mntid) {
> +               if (xfstests_statx(AT_FDCWD, fname, 0, STATX_MNT_ID, &sta=
txbuf) < 0) {
> +                       fprintf(stderr, "%s: statx(STATX_MNT_ID): %m\n", =
fname);
> +                       return EXIT_FAILURE;
> +               }
> +               if (!(statxbuf.stx_mask & STATX_MNT_ID))
> +                       skip_mntid =3D true;
> +               else
> +                       statx_mntid_short =3D statxbuf.stx_mnt_id;
> +       }
> +
> +       if (!skip_mntid_unique) {
> +               if (xfstests_statx(AT_FDCWD, fname, 0, STATX_MNT_ID_UNIQU=
E, &statxbuf) < 0) {
> +                       fprintf(stderr, "%s: statx(STATX_MNT_ID_UNIQUE): =
%m\n", fname);
> +                       return EXIT_FAILURE;
> +               }
> +               /*
> +                * STATX_MNT_ID_UNIQUE was added fairly recently in Linux=
 6.8, so if the
> +                * kernel doesn't give us a unique mount ID just skip it.
> +                */
> +               if (!(statxbuf.stx_mask & STATX_MNT_ID_UNIQUE))
> +                       skip_mntid_unique =3D true;
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
> +       if (!skip_mntid) {
> +               if (mntid_short !=3D (int) statx_mntid_short) {
> +                       fprintf(stderr, "%s: name_to_handle_at returned a=
 different mount ID to STATX_MNT_ID: %u !=3D %lu\n", fname, mntid_short, st=
atx_mntid_short);
> +                       return EXIT_FAILURE;
> +               }
> +       }
> +
> +       if (!skip_mntid_unique) {
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
> +                       /* EINVAL means AT_HANDLE_MNT_ID_UNIQUE is not su=
pported */
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
> @@ -130,7 +228,7 @@ int main(int argc, char **argv)
>         char    fname2[PATH_MAX];
>         char    *test_dir;
>         char    *mount_dir;
> -       int     mount_fd, mount_id;
> +       int     mount_fd;
>         char    *infile =3D NULL, *outfile =3D NULL;
>         int     in_fd =3D 0, out_fd =3D 0;
>         int     numfiles =3D 1;
> @@ -305,21 +403,9 @@ int main(int argc, char **argv)
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
> +                       if (ret)
>                                 return EXIT_FAILURE;
> -                       }
>                 }
>                 if (keepopen) {
>                         /* Open without close to keep unlinked files arou=
nd */
> @@ -347,21 +433,9 @@ int main(int argc, char **argv)
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
> +                       if (ret)
>                                 return EXIT_FAILURE;
> -                       }
>                 }
>                 if (out_fd) {
>                         ret =3D write(out_fd, (char *)&dir_handle, sizeof=
(*handle));
> --
> 2.46.0
>

