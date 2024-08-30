Return-Path: <linux-fsdevel+bounces-28083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A709667AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 19:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AECD1C23F1F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 17:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EA81BAEF0;
	Fri, 30 Aug 2024 17:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5FOBkzQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FDF1BAEC8;
	Fri, 30 Aug 2024 17:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725037854; cv=none; b=HM2KXzeCojIp5c7KDctNH6sil/2VlnB5VcRfQam9Gy+F0Z5IQeSG6Xlndxn+pSAAfAhKtJI1nCFDpjb53skx7HfExgs/3+5OEq+OdWUawqpyJjD2w2flK4Hnff1l+iv0ZOC30fajzJcoQxwAusqJJm6m6fMaSPmAj5Ybxt5DUUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725037854; c=relaxed/simple;
	bh=77x4awRdT9Y/eD2B9Y75VmTh/DpYuU329niKtHTqOxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e/Mbn9JlvpfBc7xi+IHgZhEcvtAjCsFTOO2vYh/We0/Mv7pUjHO4dGTpBkCjCX0vBSg1MtfbGaboKn/OD3eVezOKXOZMEggN3DAi9ht37D4LI1Q5tCwQD2a31rXKFGS2Ni9rvW/D0eguPjxFDp99RCTJ4B4oQJ+wgJjMnYJaj+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e5FOBkzQ; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a812b64d1cso62689185a.0;
        Fri, 30 Aug 2024 10:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725037852; x=1725642652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m22aemZpiQj+0DI+8D9LCjeFsoRiZWdwmvwgcVkCN90=;
        b=e5FOBkzQW3zfPL+pyuNqyE3uHmSeYg2zalshew3iGhmOTrVhpubAmWIn0UB77XxdoI
         A1+JiHEqX5Moekhgu9jD+LZbRSp08RBty8hEO8BBP+S5u/croHfNa/vBWFvVdcn/TEuN
         YXHQf6xFgMeAH53TAzhJLYTuFFv61cd1D1aw5nMfk6C0gkI0nzEucvrsWDcZD6gdIXoV
         G+2tXFugj5nzFNUwZ6YrAVf/aWGUVd0sHHsYlaXJge+wt3e4ugUPCDRCN/Qd9tGsDg7W
         XvmnKuDcNrm+LG4KLgRNoxcrKB1Klo24mNrgr+1Kq4Myj3ShlRjPFlfMBuntESSarQg8
         TXxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725037852; x=1725642652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m22aemZpiQj+0DI+8D9LCjeFsoRiZWdwmvwgcVkCN90=;
        b=gqNFFTbuQcuW1JFgjGA0dz/FAzPLyCpBNT+M3981+fvlBbe5YfwDWGZp8b+s3NoOne
         5x3E7uHy8WCRWZb/F/WUpNL/XKg0yD51sykjVOZPmU6yiZcK6lkM7QitHHAWm1ya+Yeq
         +NHkgwJ8hpwV08nKBfHHZMwq6rkTh9kBZ3rXXpLfXS3gbSYHso2s7QOpOodNrKbOzQPO
         gV8EBOyjH5lgXQc4q57JVeUbjP7lG0O4CH/ohjoGiMSR9d2fboXeyn45aMG4K7T5R4Za
         2Vs69dyZwUSbsg+HsoMkqG2AuG9ZI2omAZ3GVOtvEcAI3y+0VjdTEKCfXkppmzJFeOGi
         J96w==
X-Forwarded-Encrypted: i=1; AJvYcCUdo8dFXKA9mfpN4h5TZpbvcZlJ1D9IFgpvV9kxkel3njGIxj1dfSC0N7Fl22qvXq7yYjCsZPWwYNYIGhZS@vger.kernel.org, AJvYcCWxA9db6KzPiHli8XJOPS/frZN/RVBbX1W6Bs3auAGgZ6dl935chFPSu9LwoMkIjJ6+XoeUHBErSy2V9cVbBw==@vger.kernel.org, AJvYcCX5EETe7AFkrn+MTteqcd9LzTbpsuGHMSnyrULzY5xQ4ycD19EMdvfvZyCdyxjA+tdQ9NWiw7k9DTA=@vger.kernel.org, AJvYcCXZorYNs7c715rMxtYus30K7mQFwT2wyzQKtZTiRKPQjD8D7ArrJYaTRWwgnPttLOO75lquwjqGMq1gxLBu0myG3Q==@vger.kernel.org, AJvYcCXg/lltuDcQ7UBweAZYrTBqQweyfx42KflJ+nhZHi23BIBpTM64O7/TkyqMlc3V/PcLzZef1onvWswe@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvv8HBNDTt8fu8/rDN+PB7spFSoO7j3lg3HTPkFLDwHrS/WjTp
	TxKQO5U9oBA7IGimFdFfAJkOSGm5fxUyyZxvkK5cIQMCbp8eDYcUd8O1zNY1AYUoSxMCNkRpFMo
	obWHNHaZwPUa3J9g7C3F/WQKcReA=
X-Google-Smtp-Source: AGHT+IFiy5ZgKngfuId1l5QoqvXMu004sTLyuhO900bVIDkVXDUUxF01S6jdIKQcwTC//HK6Z/vhWR6WlKpSSP/q6Vk=
X-Received: by 2002:a05:620a:1a1a:b0:7a2:c2a:c9f8 with SMTP id
 af79cd13be357-7a804187309mr806207185a.1.1725037851328; Fri, 30 Aug 2024
 10:10:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828-exportfs-u64-mount-id-v3-0-10c2c4c16708@cyphar.com>
 <20240828103706.2393267-1-cyphar@cyphar.com> <20240828103706.2393267-2-cyphar@cyphar.com>
In-Reply-To: <20240828103706.2393267-2-cyphar@cyphar.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 30 Aug 2024 19:10:39 +0200
Message-ID: <CAOQ4uxjzpoUtH9OGYmj8K4FF0V4J8vi1W6Ry0Po1RoZ70vQ_fA@mail.gmail.com>
Subject: Re: [PATCH xfstests v1 2/2] open_by_handle: add tests for u64 mount ID
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

On Wed, Aug 28, 2024 at 12:37=E2=80=AFPM Aleksa Sarai <cyphar@cyphar.com> w=
rote:
>
> Now that open_by_handle_at(2) can return u64 mount IDs, do some tests to
> make sure they match properly as part of the regular open_by_handle
> tests.
>
> Link: https://lore.kernel.org/all/20240801-exportfs-u64-mount-id-v3-0-be5=
d6283144a@cyphar.com/
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> ---
>  src/open_by_handle.c | 123 ++++++++++++++++++++++++++++++++-----------
>  tests/generic/426    |   1 +
>  2 files changed, 93 insertions(+), 31 deletions(-)
>
> diff --git a/src/open_by_handle.c b/src/open_by_handle.c
> index d9c802ca9bd1..cbd68aeadac1 100644
> --- a/src/open_by_handle.c
> +++ b/src/open_by_handle.c
> @@ -86,10 +86,15 @@ Examples:
>  #include <errno.h>
>  #include <linux/limits.h>
>  #include <libgen.h>
> +#include <stdint.h>
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
> @@ -99,7 +104,7 @@ struct handle {
>
>  void usage(void)
>  {
> -       fprintf(stderr, "usage: open_by_handle [-cludmrwapknhs] [<-i|-o> =
<handles_file>] <test_dir> [num_files]\n");
> +       fprintf(stderr, "usage: open_by_handle [-cludMmrwapknhs] [<-i|-o>=
 <handles_file>] <test_dir> [num_files]\n");
>         fprintf(stderr, "\n");
>         fprintf(stderr, "open_by_handle -c <test_dir> [N] - create N test=
 files under test_dir, try to get file handles and exit\n");
>         fprintf(stderr, "open_by_handle    <test_dir> [N] - get file hand=
les of test files, drop caches and try to open by handle\n");
> @@ -111,6 +116,7 @@ void usage(void)
>         fprintf(stderr, "open_by_handle -l <test_dir> [N] - create hardli=
nks to test files, drop caches and try to open by handle\n");
>         fprintf(stderr, "open_by_handle -u <test_dir> [N] - unlink (hardl=
inked) test files, drop caches and try to open by handle\n");
>         fprintf(stderr, "open_by_handle -d <test_dir> [N] - unlink test f=
iles and hardlinks, drop caches and try to open by handle\n");
> +       fprintf(stderr, "open_by_handle -M <test_dir> [N] - confirm that =
the mount id returned by name_to_handle_at matches the mount id in statx\n"=
);
>         fprintf(stderr, "open_by_handle -m <test_dir> [N] - rename test f=
iles, drop caches and try to open by handle\n");
>         fprintf(stderr, "open_by_handle -p <test_dir>     - create/delete=
 and try to open by handle also test_dir itself\n");
>         fprintf(stderr, "open_by_handle -i <handles_file> <test_dir> [N] =
- read test files handles from file and try to open by handle\n");
> @@ -120,6 +126,81 @@ void usage(void)
>         exit(EXIT_FAILURE);
>  }
>
> +int do_name_to_handle_at(const char *fname, struct file_handle *fh, int =
bufsz,
> +                        int checkmountid)
> +{
> +       int ret;
> +       int mntid_short;
> +
> +       uint64_t mntid_unique;
> +       uint64_t statx_mntid_short =3D 0, statx_mntid_unique =3D 0;
> +       struct handle dummy_fh;
> +
> +       if (checkmountid) {
> +               struct statx statxbuf;
> +
> +               /* Get both the short and unique mount id. */
> +               if (statx(AT_FDCWD, fname, 0, STATX_MNT_ID, &statxbuf) < =
0) {
> +                       fprintf(stderr, "%s: statx(STATX_MNT_ID): %m\n", =
fname);
> +                       return EXIT_FAILURE;
> +               }
> +               if (!(statxbuf.stx_mask & STATX_MNT_ID)) {
> +                       fprintf(stderr, "%s: no STATX_MNT_ID in stx_mask\=
n", fname);
> +                       return EXIT_FAILURE;
> +               }
> +               statx_mntid_short =3D statxbuf.stx_mnt_id;
> +
> +               if (statx(AT_FDCWD, fname, 0, STATX_MNT_ID_UNIQUE, &statx=
buf) < 0) {
> +                       fprintf(stderr, "%s: statx(STATX_MNT_ID_UNIQUE): =
%m\n", fname);
> +                       return EXIT_FAILURE;

This failure will break the test on LTS kernels  - we don't want that.
Instead I think you should:
- drop the -M option
- get statx_mntid_unique here IF kernel supports STATX_MNT_ID_UNIQUE
and then...

> +               }
> +               if (!(statxbuf.stx_mask & STATX_MNT_ID_UNIQUE)) {
> +                       fprintf(stderr, "%s: no STATX_MNT_ID_UNIQUE in st=
x_mask\n", fname);
> +                       return EXIT_FAILURE;
> +               }
> +               statx_mntid_unique =3D statxbuf.stx_mnt_id;
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
> +       if (checkmountid) {
> +               if (mntid_short !=3D (int) statx_mntid_short) {
> +                       fprintf(stderr, "%s: name_to_handle_at returned a=
 different mount ID to STATX_MNT_ID: %u !=3D %lu\n", fname, mntid_short, st=
atx_mntid_short);
> +                       return EXIT_FAILURE;
> +               }
> +
> +               /*
> +                * Get the unique mount ID. We don't need to get another =
copy of the
> +                * handle so store it in a dummy struct.
> +                */
> +               dummy_fh.fh.handle_bytes =3D fh->handle_bytes;
> +               if (name_to_handle_at(AT_FDCWD, fname, &dummy_fh.fh, (int=
 *) &mntid_unique, AT_HANDLE_MNT_ID_UNIQUE) < 0) {
> +                       fprintf(stderr, "%s: name_to_handle_at(AT_HANDLE_=
MNT_ID_UNIQUE): %m\n", fname);
> +                       return EXIT_FAILURE;
> +               }
> +
> +               if (mntid_unique !=3D statx_mntid_unique) {
> +                       fprintf(stderr, "%s: name_to_handle_at(AT_HANDLE_=
MNT_ID_UNIQUE) returned a different mount ID to STATX_MNT_ID_UNIQUE: %lu !=
=3D %lu\n", fname, mntid_unique, statx_mntid_unique);
> +                       return EXIT_FAILURE;
> +               }

- check statx_mntid_unique here IFF statx_mntid_unique is set
- always check statx_mntid_short (what could be a reason to not check it?)

> +       }
> +
> +       return 0;
> +}
> +
>  int main(int argc, char **argv)
>  {
>         int     i, c;
> @@ -132,19 +213,20 @@ int main(int argc, char **argv)
>         char    fname2[PATH_MAX];
>         char    *test_dir;
>         char    *mount_dir;
> -       int     mount_fd, mount_id;
> +       int     mount_fd;
>         char    *infile =3D NULL, *outfile =3D NULL;
>         int     in_fd =3D 0, out_fd =3D 0;
>         int     numfiles =3D 1;
>         int     create =3D 0, delete =3D 0, nlink =3D 1, move =3D 0;
>         int     rd =3D 0, wr =3D 0, wrafter =3D 0, parent =3D 0;
>         int     keepopen =3D 0, drop_caches =3D 1, sleep_loop =3D 0;
> +       int     checkmountid =3D 0;
>         int     bufsz =3D MAX_HANDLE_SZ;
>
>         if (argc < 2)
>                 usage();
>
> -       while ((c =3D getopt(argc, argv, "cludmrwapknhi:o:sz")) !=3D -1) =
{
> +       while ((c =3D getopt(argc, argv, "cludMmrwapknhi:o:sz")) !=3D -1)=
 {
>                 switch (c) {
>                 case 'c':
>                         create =3D 1;
> @@ -172,6 +254,9 @@ int main(int argc, char **argv)
>                         delete =3D 1;
>                         nlink =3D 0;
>                         break;
> +               case 'M':
> +                       checkmountid =3D 1;
> +                       break;
>                 case 'm':
>                         move =3D 1;
>                         break;
> @@ -307,21 +392,9 @@ int main(int argc, char **argv)
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
, bufsz, checkmountid);
> +                       if (ret < 0)
>                                 return EXIT_FAILURE;
> -                       }
>                 }
>                 if (keepopen) {
>                         /* Open without close to keep unlinked files arou=
nd */
> @@ -349,21 +422,9 @@ int main(int argc, char **argv)
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
e.fh, bufsz, checkmountid);
> +                       if (ret < 0)
>                                 return EXIT_FAILURE;
> -                       }
>                 }
>                 if (out_fd) {
>                         ret =3D write(out_fd, (char *)&dir_handle, sizeof=
(*handle));
> diff --git a/tests/generic/426 b/tests/generic/426
> index 25909f220e1e..df481c58562c 100755
> --- a/tests/generic/426
> +++ b/tests/generic/426
> @@ -51,6 +51,7 @@ test_file_handles $testdir -d
>  # Check non-stale handles to linked files
>  create_test_files $testdir
>  test_file_handles $testdir
> +test_file_handles $testdir -M

I see no reason to add option -M and add a second invocation.

Something I am missing?

Thanks,
Amir.

