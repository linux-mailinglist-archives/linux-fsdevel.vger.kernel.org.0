Return-Path: <linux-fsdevel+bounces-28328-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B78969636
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 09:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBD981F23DF4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 07:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BD6200116;
	Tue,  3 Sep 2024 07:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hP4JbxC5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94441CCEF9;
	Tue,  3 Sep 2024 07:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725350076; cv=none; b=ujysdYb+kZqlqGWg+wQz2h5fMwS9aUVUkxCtM59s0uyJ6ZL6vHOgizCPIdxY5aJ24u2v+5z+U6a82ptVTCcPR8T4MwA6hE8/7cyNM8BAi7S77j+4DyS5ZC3Vohrcrb1ZN1NB2+R+e5cfehP/yuqOO1PHlxEh5xcdldYqUO1uRA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725350076; c=relaxed/simple;
	bh=8d5alI3TLhOYwnx2NrP9LQS/Df3yxkjn+fz4hxc7LrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R/7opzf6ntf6mKBp1Sem8B0e2wPFZ1gerZ6HXREOSv71EW8t25SxOuFuNnLACqWL2wnFCf7YGb04JIlBmJieMcUxMNkq7EyPip0R5IVGzwF6+HFXhE9tnrKYwkBV4szocWwcavUmgE6y12YyCn6CrOQ1gaNQ3W/RmZXKqErQrwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hP4JbxC5; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6c35b545b41so18137166d6.1;
        Tue, 03 Sep 2024 00:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725350072; x=1725954872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fomXVmXiFKhcu/vzfVM0LdMGqu50I/F26QA2OqSH32Y=;
        b=hP4JbxC5Ycq1GVbDjVrWoXIx6z/HIdIH3T8XX3OZ+jDGivCfVE/vm3miUz0Hi6S9WC
         M79M4wAmb4E9ZDOKMs9hR/hqhhd3Xd91HfhcEfX2mSx0Y9l5E/TucXcxLnVwsfP0WMxz
         CAZxmVGfmt3IezhnURkR2nH4zGp+wvC2AOgUnBmtbQb2qjnVgpCxVPdknFIiUc6GGhqd
         S4vpwLTh1/wJHke+dL8dSxwA7iQUsZidUZbNc8q9gn3Pzoq7tvGD9+k9Y1lDF1uAsEQd
         6NCGD9WNRwHTdbI5KHky31eAdKROfv6pE70NX95mcbIS8UQX6ATGDnxJpz5GmRZzgllR
         M7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725350072; x=1725954872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fomXVmXiFKhcu/vzfVM0LdMGqu50I/F26QA2OqSH32Y=;
        b=HDnntTG/yWYpjTSC7hlqsiiupF+CZnDSY+oz+d+Ih3SWmw/4CPhiviDk6Wyru+SHOg
         JeEOH77UNVIqZYxFQ79i0riWiCWqNkmlCXw4njxkrF08yOFtO/j5BiUVGqHQ5bHDcdD4
         tK+hmrkpVbLYFNznZEiXNSNk0wNZ7eFDFk9sDZyyH0Avz6lK+7L6+8sW+068E/IgY4L8
         wWoJ0xjv//TTOQxNVB4zoC617VBGEPc7wEMWagS6g8H90Z60AHB0fY5VE8O0mm7aUMAF
         E8k6NKfcA/aphbMsmjoEgxjnXff8gq44lNnG6zdqKz1SB6py0IIh3FurtyXrEVal2Se4
         JprA==
X-Forwarded-Encrypted: i=1; AJvYcCU5/HXY9px2xuBMniqB8Pfm5SKV3VHUt6lm97aZrG45obrrik+Nqyh5tfwqFxynWbJecTZ81SqLBNfsraPgMA==@vger.kernel.org, AJvYcCVc+6fo1TOu++Forq8dtgeKTgNeMMOSQ/+jX6+VGkaLaVD5kDsSyuX3+yVJCSWqU8V1ya3bhZU1hYk=@vger.kernel.org, AJvYcCWJJ1VRZVJK0EO3Ohq/hDTjHbQ/xqSMZjhe6pAOSESQ61L45Tj8aA9R4oJcFgdVDpMXwxuWJigUbKm/@vger.kernel.org, AJvYcCWR5G/TtVtp6yXZjgp+Tv4RZxxkOsM+qMezAlqrPxDEpOzEdXnVHrPHjh6z1rnK6fc4Eg8xuV8aWTb0uZDmV4FnOg==@vger.kernel.org, AJvYcCWhT6mf63TYwxuNe9Uf7sskPJQzoMOnAkZ8wb5Goh67d2Zrouvf1eJa2nzcVIM7rylv02vwGdw/zCQR8qhZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxhG6nfVwp6EjlifJX0gmN8Nm8VICRogGI3LF5pxO2ooOCjEsNs
	nxSjzwHA3RxrJKJPAlTqhwDwk9h7GS4s5Fylv0Okq3f5fsSJLM+3MOgWcBg8LmkP3jFyFV6GkEs
	5jXs81FvZU2od7HlcdZYETkesHyYWYIfYqQOiLw==
X-Google-Smtp-Source: AGHT+IGzXLsIEHDbgMyGT+A08yC4JUWzWxGh88B25wAb1Ou+JNdpZ2wR9VfJec6imJMUOtwHITpi+KkYncaNWiMSjmY=
X-Received: by 2002:a05:6214:4a81:b0:6c3:6b35:ac73 with SMTP id
 6a1803df08f44-6c36b35ad26mr91108986d6.11.1725350071854; Tue, 03 Sep 2024
 00:54:31 -0700 (PDT)
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
Date: Tue, 3 Sep 2024 09:54:20 +0200
Message-ID: <CAOQ4uxi291jBJ5ycZgiicVebjkcRQjhXJRgOgvSPBV4-TOcQvA@mail.gmail.com>
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

This fails build on top of latest for-next branch with commit
873e36c9 - statx.h: update to latest kernel UAPI

It can be fixed by changing to use the private xfstests_statx()
implementation, same as in stat_test.c.

I am not sure how elegant this is, but that's the easy fix.

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

This verbose print breaks all existing "exportfs" tests which do not
expect it in the golden output.

I understand that silently ignoring the failure is not good, but I also
would like to add this test coverage to all the existing tests.

One solution is to resurrect the command line option -M from v1,
but instead of meaning "test unique mount id" let it mean
"do not allow to skip unique mount id" test.

Then you can add a new test that runs open_by_handle -M, but also
implement a helper _require_unique_mntid similar to _require_btime
which is needed for the new test to run only on new kernels.

I'm sorry for this complication, but fstest is a testsuite that runs on
disto and stable kernels as well and we need to allow test coverage
of new features along with stability of the test env.

Thanks,
Amir.

