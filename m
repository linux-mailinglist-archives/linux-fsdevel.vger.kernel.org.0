Return-Path: <linux-fsdevel+bounces-28618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC1B96C6C4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 20:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6326B1C21ADF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 18:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74401E493A;
	Wed,  4 Sep 2024 18:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GuOKfnA8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306591D2225;
	Wed,  4 Sep 2024 18:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725475780; cv=none; b=bR0KAQks2QOjlVtRCLf8ElLhf4qhzhVVsJNEYRl//aGCjV3wYyB10NZIw37iITRxWlyuF6+vxCRvrByKgsO7MYZyz63fknkuQcrqAXGFrdZMNwsWZvglXaUTNvR5ug0P6Q0owbaJaqLHYfFNv3X9Y080kgAygYihUVOHPRf2EVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725475780; c=relaxed/simple;
	bh=wW6OYeBgpBQckkEkC5ph/irnKeS8AutAYEw4Wku250I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QqLbHP2blKZq3TLFGhSCMa0VkD0FkzTFoYBlLI6pYK8rgcSayB151piGwG7LsWBAbJ4u8tY2YBzGjp26dD9TBuN1FFmDyjTJ3sBcI4b0WRXvalWAqErajAjyYhbpucgww9fOZme3p+3oU/FICqL54RsdJaA9d11fd/UFWyoMV/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GuOKfnA8; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a86a37208b2so844757366b.0;
        Wed, 04 Sep 2024 11:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725475776; x=1726080576; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9UJGJlakrQ0yQUYCaxf68sWI1TU77re99WJAbQe+40=;
        b=GuOKfnA8+oE3rAGEUtT7nH//qqxPmtFbaHUoLm+s0mCsoX9t/+yWjeWS1cZpQxfdJz
         IN5BlKIDT1fQAAUMWEfnKuL6ZA4Pf/tSYwTcYdx7+6gcCRZmzpw2xegPV13PeFhSBiuK
         TIHOSh1zXodfRcwEKN5HxwWrSj4651CVUUxKpxxGR8vS3OYE5SvU3w0EGraUgF4DAyTA
         Seic7JTKYUECzZb1mrnncWnE2VRldUvJ19hD3vOLl4ld/k7OLQ1xrtHB5MEhZos4z0xu
         fsSR1bX4A9UPuTKjEdzPorHL6rodUnlFPFwMb4UDVatjHxcu3iF4dAx9miJWqK7R8Zhb
         z52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725475776; x=1726080576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L9UJGJlakrQ0yQUYCaxf68sWI1TU77re99WJAbQe+40=;
        b=Kt20kVmQttYc+ZsqeQ6V9hcHHj6yVoevn//gFZiak2llv+RrNVI3eg5GKUcjll/JF/
         4KZKiVijcQeiOg9l7UOuYKjjzLe1ABaR+KKatP99l514IubAv8spvVmgwyjsQEqewLtl
         uTc0zMY1EjU7VkFwPlysjPgeJ5hbCwx/OXvgxz9sHNz+5zvJqhwJp/Wo00G6CV537kgU
         +qUy0Orr+BbmQ/VASQRmbMxuO5TraUbF0CCUSI8QZZ2j/Kei1r6MJJs75K1tyc858eFs
         laKQP+lp7nDsSp4GACnDiJoMyvILSWknYeqn1EIy3ipRg4YpG6SxOKlGNoEPGzx5Qb7E
         E2Pg==
X-Forwarded-Encrypted: i=1; AJvYcCU4LUnBeoC2IQZeuI/gBP+CFumQ0gP8gwAzj93Sf7ArAnChdNeB1SpNZDLb3ChKKL37xLSdP9gVVMFqgsfuTQ==@vger.kernel.org, AJvYcCUGHu9LOo+0P7p2EZZksbtNg4hgXuy2L0Ax9SQCrZjWmlqfeA+43UyyFGuYCEOZJ8USUSGU3+moaeY=@vger.kernel.org, AJvYcCUWNMYpsJyejWaJC7r6yTqKzUfTt3bp6QCVTdUge0LVLGDyI4bO6GK0OR8EV1hVReRq69tzUqxJL9QE6W9rmwjAEQ==@vger.kernel.org, AJvYcCUn+2D5IxnfoEB5dIKohj3egXk2wcCTML6FNNZL9idqiUroIeb7Wc31Al48R/ZDvOGFQwUEhI38zGs7@vger.kernel.org, AJvYcCX6hijqySJnjnbLBks2pGdRKR0NjdQJVTtXs2xoNse2z4Hgbm2SE0veHmgnTf0blk0s9CKL27cXiGFMBsUS@vger.kernel.org
X-Gm-Message-State: AOJu0YzCBHb2qo8ZuJbzNBgN64SN8MOtDMlg4ZhSNFffkNtx3165n1sJ
	vhp6m8K0yuZRUUKl5cI75QVcx8xsjo8JC3Dd3j/H6MtAwTrMh9PfEOEXWPKQPvNlDDptRg/xhBi
	BzPMJgSSxRIIILWh805DkUnAt/2Y=
X-Google-Smtp-Source: AGHT+IFzzdPINSuShLLq57GFSf9ydxygvEuUpGnACp11/vQT/GGIjnMdkiLC4X3yLwJ/ZuK2vTPRCPI8+IeFzlnUYvA=
X-Received: by 2002:a17:907:6d23:b0:a7a:aa35:408c with SMTP id
 a640c23a62f3a-a897f77fa9amr1656478266b.8.1725475775439; Wed, 04 Sep 2024
 11:49:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828-exportfs-u64-mount-id-v3-0-10c2c4c16708@cyphar.com>
 <20240904175639.2269694-1-cyphar@cyphar.com> <20240904175639.2269694-2-cyphar@cyphar.com>
In-Reply-To: <20240904175639.2269694-2-cyphar@cyphar.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 4 Sep 2024 20:49:19 +0200
Message-ID: <CAOQ4uxj0X2GJLvB=HyR7_kr=SvqQ0dGapVnf9Ft1hWcaXXCJVw@mail.gmail.com>
Subject: Re: [PATCH xfstests v3 2/2] generic/756: test name_to_handle_at(AT_HANDLE_MNT_ID_UNIQUE)
 explicitly
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
> In order to make sure we are actually testing AT_HANDLE_MNT_ID_UNIQUE,
> add a test (based on generic/426) which runs the open_by_handle in a
> mode where it will error out if there is a problem with getting mount
> IDs. The test is skipped if the kernel doesn't support the necessary
> features.
>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>

Apart from one minor nits below, you may add:

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  common/rc             | 24 ++++++++++++++++
>  src/open_by_handle.c  | 63 ++++++++++++++++++++++++++++++++++-------
>  tests/generic/756     | 65 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/756.out |  5 ++++
>  4 files changed, 147 insertions(+), 10 deletions(-)
>  create mode 100755 tests/generic/756
>  create mode 100644 tests/generic/756.out
>
> diff --git a/common/rc b/common/rc
> index 9da9fe188297..0beaf2ff1126 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -5178,6 +5178,30 @@ _require_fibmap()
>         rm -f $file
>  }
>
> +_require_statx_unique_mountid()
> +{
> +       # statx(STATX_MNT_ID=3D0x1000) was added in Linux 5.8.
> +       # statx(STATX_MNT_ID_UNIQUE=3D0x4000) was added in Linux 6.9.
> +       # We only need to check the latter.
> +
> +       export STATX_MNT_ID_UNIQUE=3D0x4000
> +       local statx_mask=3D$(
> +               ${XFS_IO_PROG} -c "statx -m $STATX_MNT_ID_UNIQUE -r" "$TE=
ST_DIR" |
> +               sed -En 's/stat\.mask =3D (0x[0-9a-f]+)/\1/p'
> +       )
> +
> +       [[ $(( statx_mask & STATX_MNT_ID_UNIQUE )) =3D=3D $((STATX_MNT_ID=
_UNIQUE)) ]] ||
> +               _notrun "statx does not support STATX_MNT_ID_UNIQUE on th=
is kernel"
> +}
> +
> +_require_open_by_handle_unique_mountid()
> +{
> +       _require_test_program "open_by_handle"
> +
> +       $here/src/open_by_handle -C AT_HANDLE_MNT_ID_UNIQUE 2>&1 \
> +               || _notrun "name_to_handle_at does not support AT_HANDLE_=
MNT_ID_UNIQUE"
> +}
> +
>  _try_wipe_scratch_devs()
>  {
>         test -x "$WIPEFS_PROG" || return 0
> diff --git a/src/open_by_handle.c b/src/open_by_handle.c
> index 920ec7d9170b..b5c1a30abbbc 100644
> --- a/src/open_by_handle.c
> +++ b/src/open_by_handle.c
> @@ -106,9 +106,11 @@ struct handle {
>
>  void usage(void)
>  {
> -       fprintf(stderr, "usage: open_by_handle [-cludmrwapknhs] [<-i|-o> =
<handles_file>] <test_dir> [num_files]\n");
> +       fprintf(stderr, "usage: open_by_handle [-cludmMrwapknhs] [<-i|-o>=
 <handles_file>] <test_dir> [num_files]\n");
> +       fprintf(stderr, "       open_by_handle -C <feature>\n");
>         fprintf(stderr, "\n");
>         fprintf(stderr, "open_by_handle -c <test_dir> [N] - create N test=
 files under test_dir, try to get file handles and exit\n");
> +       fprintf(stderr, "open_by_handle -c <test_dir> [N] - create N test=
 files under test_dir, try to get file handles and exit\n");
>         fprintf(stderr, "open_by_handle    <test_dir> [N] - get file hand=
les of test files, drop caches and try to open by handle\n");
>         fprintf(stderr, "open_by_handle -n <test_dir> [N] - get file hand=
les of test files and try to open by handle without drop caches\n");
>         fprintf(stderr, "open_by_handle -k <test_dir> [N] - get file hand=
les of files that are kept open, drop caches and try to open by handle\n");
> @@ -117,19 +119,23 @@ void usage(void)
>         fprintf(stderr, "open_by_handle -a <test_dir> [N] - write data to=
 test files after open by handle\n");
>         fprintf(stderr, "open_by_handle -l <test_dir> [N] - create hardli=
nks to test files, drop caches and try to open by handle\n");
>         fprintf(stderr, "open_by_handle -u <test_dir> [N] - unlink (hardl=
inked) test files, drop caches and try to open by handle\n");
> -       fprintf(stderr, "open_by_handle -U <test_dir> [N] - verify the mo=
unt ID returned with AT_HANDLE_MNT_ID_UNIQUE is correct\n");

I guess this was not supposed to be in the first patch

>         fprintf(stderr, "open_by_handle -d <test_dir> [N] - unlink test f=
iles and hardlinks, drop caches and try to open by handle\n");
>         fprintf(stderr, "open_by_handle -m <test_dir> [N] - rename test f=
iles, drop caches and try to open by handle\n");
> +       fprintf(stderr, "open_by_handle -M <test_dir> [N] - do not silent=
ly skip the mount ID verifications\n");
>         fprintf(stderr, "open_by_handle -p <test_dir>     - create/delete=
 and try to open by handle also test_dir itself\n");
>         fprintf(stderr, "open_by_handle -i <handles_file> <test_dir> [N] =
- read test files handles from file and try to open by handle\n");
>         fprintf(stderr, "open_by_handle -o <handles_file> <test_dir> [N] =
- get file handles of test files and write handles to file\n");
>         fprintf(stderr, "open_by_handle -s <test_dir> [N] - wait in sleep=
 loop after opening files by handle to keep them open\n");
>         fprintf(stderr, "open_by_handle -z <test_dir> [N] - query filesys=
tem required buffer size\n");
> +       fprintf(stderr, "\n");
> +       fprintf(stderr, "open_by_handle -C <feature>      - check if <fea=
ture> is supported by the kernel.\n");
> +       fprintf(stderr, "  <feature> can be any of the following values:\=
n");
> +       fprintf(stderr, "  - AT_HANDLE_MNT_ID_UNIQUE\n");
>         exit(EXIT_FAILURE);
>  }
>
>  static int do_name_to_handle_at(const char *fname, struct file_handle *f=
h,
> -                               int bufsz)
> +                               int bufsz, bool force_check_mountid)
>  {
>         int ret;
>         int mntid_short;
> @@ -145,10 +151,15 @@ static int do_name_to_handle_at(const char *fname, =
struct file_handle *fh,
>                         fprintf(stderr, "%s: statx(STATX_MNT_ID): %m\n", =
fname);
>                         return EXIT_FAILURE;
>                 }
> -               if (!(statxbuf.stx_mask & STATX_MNT_ID))
> +               if (!(statxbuf.stx_mask & STATX_MNT_ID)) {
> +                       if (force_check_mountid) {
> +                               fprintf(stderr, "%s: statx(STATX_MNT_ID) =
not supported by running kernel\n", fname);
> +                               return EXIT_FAILURE;
> +                       }
>                         skip_mntid =3D true;
> -               else
> +               } else {
>                         statx_mntid_short =3D statxbuf.stx_mnt_id;
> +               }
>         }
>
>         if (!skip_mntid_unique) {
> @@ -160,10 +171,15 @@ static int do_name_to_handle_at(const char *fname, =
struct file_handle *fh,
>                  * STATX_MNT_ID_UNIQUE was added fairly recently in Linux=
 6.8, so if the
>                  * kernel doesn't give us a unique mount ID just skip it.
>                  */
> -               if (!(statxbuf.stx_mask & STATX_MNT_ID_UNIQUE))
> +               if (!(statxbuf.stx_mask & STATX_MNT_ID_UNIQUE)) {
> +                       if (force_check_mountid) {
> +                               fprintf(stderr, "%s: statx(STATX_MNT_ID_U=
NIQUE) not supported by running kernel\n", fname);
> +                               return EXIT_FAILURE;
> +                       }
>                         skip_mntid_unique =3D true;
> -               else
> +               } else {
>                         statx_mntid_unique =3D statxbuf.stx_mnt_id;
> +               }
>         }
>
>         fh->handle_bytes =3D bufsz;
> @@ -204,6 +220,10 @@ static int do_name_to_handle_at(const char *fname, s=
truct file_handle *fh,
>                                 return EXIT_FAILURE;
>                         }
>                         /* EINVAL means AT_HANDLE_MNT_ID_UNIQUE is not su=
pported */
> +                       if (force_check_mountid) {
> +                               fprintf(stderr, "%s: name_to_handle_at(AT=
_HANDLE_MNT_ID_UNIQUE) not supported by running kernel\n", fname);
> +                               return EXIT_FAILURE;
> +                       }
>                         skip_mntid_unique =3D true;
>                 } else {
>                         if (mntid_unique !=3D statx_mntid_unique) {
> @@ -216,6 +236,22 @@ static int do_name_to_handle_at(const char *fname, s=
truct file_handle *fh,
>         return 0;
>  }
>
> +static int check_feature(const char *feature)
> +{
> +       if (!strcmp(feature, "AT_HANDLE_MNT_ID_UNIQUE")) {
> +               int ret =3D name_to_handle_at(AT_FDCWD, ".", NULL, NULL, =
AT_HANDLE_MNT_ID_UNIQUE);
> +               /* If AT_HANDLE_MNT_ID_UNIQUE is supported, we get EFAULT=
. */
> +               if (ret < 0 && errno =3D=3D EINVAL) {
> +                       fprintf(stderr, "name_to_handle_at(AT_HANDLE_MNT_=
ID_UNIQUE) not supported by running kernel\n");
> +                       return EXIT_FAILURE;
> +               }
> +               return 0;
> +       }
> +
> +       fprintf(stderr, "unknown feature name '%s'\n", feature);
> +       return EXIT_FAILURE;
> +}
> +
>  int main(int argc, char **argv)
>  {
>         int     i, c;
> @@ -235,16 +271,20 @@ int main(int argc, char **argv)
>         int     create =3D 0, delete =3D 0, nlink =3D 1, move =3D 0;
>         int     rd =3D 0, wr =3D 0, wrafter =3D 0, parent =3D 0;
>         int     keepopen =3D 0, drop_caches =3D 1, sleep_loop =3D 0;
> +       int force_check_mountid =3D 0;
>         int     bufsz =3D MAX_HANDLE_SZ;
>
>         if (argc < 2)
>                 usage();
>
> -       while ((c =3D getopt(argc, argv, "cludmrwapknhi:o:sz")) !=3D -1) =
{
> +       while ((c =3D getopt(argc, argv, "cC:ludmMrwapknhi:o:sz")) !=3D -=
1) {
>                 switch (c) {
>                 case 'c':
>                         create =3D 1;
>                         break;
> +               case 'C':
> +                       /* Check kernel feature support. */
> +                       return check_feature(optarg);
>                 case 'w':
>                         /* Write data before open_by_handle_at() */
>                         wr =3D 1;
> @@ -271,6 +311,9 @@ int main(int argc, char **argv)
>                 case 'm':
>                         move =3D 1;
>                         break;
> +               case 'M':
> +                       force_check_mountid =3D 1;
> +                       break;
>                 case 'p':
>                         parent =3D 1;
>                         break;
> @@ -403,7 +446,7 @@ int main(int argc, char **argv)
>                                 return EXIT_FAILURE;
>                         }
>                 } else {
> -                       ret =3D do_name_to_handle_at(fname, &handle[i].fh=
, bufsz);
> +                       ret =3D do_name_to_handle_at(fname, &handle[i].fh=
, bufsz, force_check_mountid);
>                         if (ret)
>                                 return EXIT_FAILURE;
>                 }
> @@ -433,7 +476,7 @@ int main(int argc, char **argv)
>                                 return EXIT_FAILURE;
>                         }
>                 } else {
> -                       ret =3D do_name_to_handle_at(test_dir, &dir_handl=
e.fh, bufsz);
> +                       ret =3D do_name_to_handle_at(test_dir, &dir_handl=
e.fh, bufsz, force_check_mountid);
>                         if (ret)
>                                 return EXIT_FAILURE;
>                 }
> diff --git a/tests/generic/756 b/tests/generic/756
> new file mode 100755
> index 000000000000..c7a82cfd25f4
> --- /dev/null
> +++ b/tests/generic/756
> @@ -0,0 +1,65 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2017 CTERA Networks. All Rights Reserved.
> +# Copyright (C) 2024 Aleksa Sarai <cyphar@cyphar.com>
> +#
> +# FS QA Test No. 756
> +#
> +# Check stale handles pointing to unlinked files and non-stale handles p=
ointing
> +# to linked files while verifying that u64 mount IDs are correctly retur=
ned.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick exportfs
> +
> +# Import common functions.
> +. ./common/filter
> +
> +
> +# Modify as appropriate.
> +_require_test
> +# _require_exportfs and  already requires open_by_handle, but let's not =
count on it
> +_require_test_program "open_by_handle"
> +_require_exportfs
> +# We need both STATX_MNT_ID_UNIQUE and AT_HANDLE_MNT_ID_UNIQUE.
> +_require_statx_unique_mountid
> +_require_open_by_handle_unique_mountid
> +
> +NUMFILES=3D1024
> +testdir=3D$TEST_DIR/$seq-dir
> +mkdir -p $testdir
> +
> +# Create empty test files in test dir
> +create_test_files()
> +{
> +       local dir=3D$1
> +
> +       mkdir -p $dir
> +       rm -f $dir/*
> +       $here/src/open_by_handle -c $dir $NUMFILES
> +}
> +
> +# Test encode/decode file handles
> +test_file_handles()
> +{
> +       local dir=3D$1
> +       local opt=3D$2
> +
> +       echo test_file_handles $* | _filter_test_dir
> +       $here/src/open_by_handle $opt $dir $NUMFILES
> +}
> +
> +# Check stale handles to deleted files
> +create_test_files $testdir
> +test_file_handles $testdir -Md
> +
> +# Check non-stale handles to linked files
> +create_test_files $testdir
> +test_file_handles $testdir -M
> +
> +# Check non-stale handles to files that were hardlinked and original del=
eted
> +create_test_files $testdir
> +test_file_handles $testdir -Ml
> +test_file_handles $testdir -Mu
> +
> +status=3D0
> +exit
> diff --git a/tests/generic/756.out b/tests/generic/756.out
> new file mode 100644
> index 000000000000..48aed88d87b9
> --- /dev/null
> +++ b/tests/generic/756.out
> @@ -0,0 +1,5 @@
> +QA output created by 756
> +test_file_handles TEST_DIR/756-dir -Md
> +test_file_handles TEST_DIR/756-dir -M
> +test_file_handles TEST_DIR/756-dir -Ml
> +test_file_handles TEST_DIR/756-dir -Mu
> --
> 2.46.0
>

