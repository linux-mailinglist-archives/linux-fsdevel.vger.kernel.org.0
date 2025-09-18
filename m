Return-Path: <linux-fsdevel+bounces-62154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C177B85FA2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 18:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 780DD3B77A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 16:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936DF3191AE;
	Thu, 18 Sep 2025 16:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3y498dlP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6093161A6
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Sep 2025 16:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758212514; cv=none; b=Xf+zjzBICZEYjYapydXH3/TMXNOqzdRtnrlqfeJByD7kPu7gxF9/RkFUSd3Ve7ABB8g9lmExkD/YRjDL++mFJC3HASQAomnOjWD6+uYmw69EtQO6NdWcZP3VdVzT/IOFoUqlbvNUjW4dKsW6FQQHjhGmo0ZUYnrw7IWpLTQfZFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758212514; c=relaxed/simple;
	bh=yA/E+31mfmRX5zSkgMJKem9chZ9mbpn5a5q5vp1kbbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z8PY6/0/usWdihQ0G92cQ+kZZuPXJOoTcOx6qzGriDkUORKx1VKrnbl/wnShJgDkc6crqg8VIMa8kgk7VHlEyGyKRehnCiKLDu/HKza2a3YCCdrFvKSc5/Y+9O3AQL21sAVEhWsT7U4nhxfobir47Ul/lmIGJxMffIykY+1jr3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3y498dlP; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-265f460ae7bso194425ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Sep 2025 09:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758212511; x=1758817311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4zq2dMyLLMrIgM/EJawiXhuYjkCVdkX9qWZewoQWDw=;
        b=3y498dlPynjn+hsNaJWFtd0OSbhjfHSw7CbTm5dvcJx10gOOTXrrRNlnocTwYQrxvV
         pZlemzqo37phdHT7PaD80DigtqOsUI0bbiJZwrXsy/Hz6jH3X0Fx/niR+x302zxyXNjs
         cW7zYoXB3QOgVkPZiAdntK5I15QcRI9t1Sh6w2QSJR7aT9QwiD5lbANWhK1V/xo2LnYC
         Uw2Oksi+ihHNZipc7bgOiQsQFusAqHTqLiF+Xq29nzcUYGyP0GPBUQ62MqY56P6SAqL1
         Ogg3ItNTk1qlTqe8GFhYPV4MHaZ3PxI+dQmQiq9jNC7ENwtO5G8iwcmMHEJeY56q2kxj
         PoVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758212511; x=1758817311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O4zq2dMyLLMrIgM/EJawiXhuYjkCVdkX9qWZewoQWDw=;
        b=fHEKzBt6L0QXhec9CppglZ28QrMxodTjRUiEFGgZfVTi0K/b2RiZUH+yzsAhqeL8a1
         ED9qgQ/R2o8Noe0Q+2n+z9ycmj9ZksZma+GJ/KVMArDWX37xpj9Yso1eIfjOpUS7wajk
         lvyx1svF49M/CdxnJWTLm3rIHK3NLQJLQ9UcARVP23MrQDosIUWaN5DqpeXKNTuXojAG
         65b1dhOh9C72Md2olUj++rF90uvUlL3w3xdm31ekX4L5IRwTfJuANjdPsYuuYFaOlcEX
         juLtXYymb3cXHVrZsCVGVzIZ7IZxMpmjCOd8iCdBBBnRqfUxZeItvIx4WMNoxr5kbHce
         Y8gA==
X-Forwarded-Encrypted: i=1; AJvYcCX+dbrbu/Xch/abgcqKOG7flZebFjF47u4AvQqr3Anh63IHXUTbOsB+CO2CGqTv5CBuS69eKPck1ORj2m7+@vger.kernel.org
X-Gm-Message-State: AOJu0YzcACBjeMkNby+ISHkvjZ+WBjaYk0HhjgbXs9SIBsADxH+sCPUf
	5xMzi1U/Q+n7xn/jLvYk8uzXbOrabNLTvMoag48LDDcjZ90fQFlkILi+AsVbBxwEHUR1tOA7MQL
	emg/1XECrXE6p1FS7Rl08qCbusrbmSkPh991NAcn3
X-Gm-Gg: ASbGnctTW/VwPyaRs/LAqbQdY/rEqkoZtrkCmxq3tGywjwuC5by9yuOy+YQMOa4bWCm
	azpkyui4NxlHMbvVdEsTeUE4IzOJAmysWK1V6oslIurEi2B6tRX5ykdaIEFjwsFsjXlYp9YjBu7
	149Vzs8kJV8GYKwRONwr+KJryWmUEgmJYo6obnGywIct06/j+f0reFdFxhwqK8+eUYK3rbo3YVM
	7bAqPA6l0uPZwOm6dnwkxggnjBGRoWNoeADULV2Ytu1yi36K5YcHLr72HPlJh1y60n0TtKn9A==
X-Google-Smtp-Source: AGHT+IFlC6HK9lSCMyz3eoncLEZ6DknQiv6+TZj1j6OfBhBXkHIbDiGMqiVzGOHAcPzc8FPo2BNmxB8S1kYu1b9m2wI=
X-Received: by 2002:a17:902:e550:b0:24c:f4b1:baaf with SMTP id
 d9443c01a7336-26808a33cc5mr11201915ad.1.1758212510647; Thu, 18 Sep 2025
 09:21:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915163838.631445-1-kaleshsingh@google.com>
 <20250915163838.631445-3-kaleshsingh@google.com> <b9b949d4-279b-4894-a829-9649e5f3ea9a@lucifer.local>
In-Reply-To: <b9b949d4-279b-4894-a829-9649e5f3ea9a@lucifer.local>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Thu, 18 Sep 2025 09:21:38 -0700
X-Gm-Features: AS18NWAYPdlcxekctlncfZ3d1WQ-3G8qwe2w-BXw3QK6BhXELyZM1noQBKTdurg
Message-ID: <CAC_TJvf9wp+c1iE6SHLwKQm3JNeKKLUPe2yrhmu7Wvqxdf0aoQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] mm/selftests: add max_vma_count tests
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, minchan@kernel.org, david@redhat.com, 
	Liam.Howlett@oracle.com, rppt@kernel.org, pfalcato@suse.de, 
	kernel-team@android.com, android-mm@google.com, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, 
	Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Jann Horn <jannh@google.com>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 7:42=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Mon, Sep 15, 2025 at 09:36:33AM -0700, Kalesh Singh wrote:
> > Add a new selftest to verify that the max VMA count limit is correctly
> > enforced.
> >
> > This test suite checks that various VMA operations (mmap, mprotect,
> > munmap, mremap) succeed or fail as expected when the number of VMAs is
> > close to the sysctl_max_map_count limit.
> >
> > The test works by first creating a large number of VMAs to bring the
> > process close to the limit, and then performing various operations that
> > may or may not create new VMAs. The test then verifies that the
> > operations that would exceed the limit fail, and that the operations
> > that do not exceed the limit succeed.
> >
> > NOTE: munmap is special as it's allowed to temporarily exceed the limit
> > by one for splits as this will decrease back to the limit once the unma=
p
> > succeeds.
> >
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> > Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Cc: Mike Rapoport <rppt@kernel.org>
> > Cc: Minchan Kim <minchan@kernel.org>
> > Cc: Pedro Falcato <pfalcato@suse.de>
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > ---
> >
> > Changes in v2:
> >  - Add tests, per Liam (note that the do_brk_flags() path is not easily
> >    tested from userspace, so it's not included here). Exceeding the lim=
it there
> >    should be uncommon.
> >
> >  tools/testing/selftests/mm/Makefile           |   1 +
> >  .../selftests/mm/max_vma_count_tests.c        | 709 ++++++++++++++++++
>
> If you add a new file, update MAINTAINERS. Should put in MEMORY MAPPING s=
ection.
>
> >  tools/testing/selftests/mm/run_vmtests.sh     |   5 +
>
> You're missing a .gitignore.
>
> >  3 files changed, 715 insertions(+)
> >  create mode 100644 tools/testing/selftests/mm/max_vma_count_tests.c
> >
> > diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selfte=
sts/mm/Makefile
> > index d13b3cef2a2b..00a4b04eab06 100644
> > --- a/tools/testing/selftests/mm/Makefile
> > +++ b/tools/testing/selftests/mm/Makefile
> > @@ -91,6 +91,7 @@ TEST_GEN_FILES +=3D transhuge-stress
> >  TEST_GEN_FILES +=3D uffd-stress
> >  TEST_GEN_FILES +=3D uffd-unit-tests
> >  TEST_GEN_FILES +=3D uffd-wp-mremap
> > +TEST_GEN_FILES +=3D max_vma_count_tests
> >  TEST_GEN_FILES +=3D split_huge_page_test
> >  TEST_GEN_FILES +=3D ksm_tests
> >  TEST_GEN_FILES +=3D ksm_functional_tests
> > diff --git a/tools/testing/selftests/mm/max_vma_count_tests.c b/tools/t=
esting/selftests/mm/max_vma_count_tests.c
> > new file mode 100644
> > index 000000000000..c8401c03425c
> > --- /dev/null
> > +++ b/tools/testing/selftests/mm/max_vma_count_tests.c
> > @@ -0,0 +1,709 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright 2025 Google LLC
> > + */
> > +#define _GNU_SOURCE
> > +
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <sys/mman.h>
> > +#include <unistd.h>
> > +#include <errno.h>
> > +#include <stdbool.h>
> > +#include <linux/prctl.h>  /* Definition of PR_* constants */
> > +#include <sys/prctl.h>
> > +
> > +#include "../kselftest.h"
> > +
> > +static int get_max_vma_count(void);
> > +static bool set_max_vma_count(int val);
> > +static int get_current_vma_count(void);
> > +static bool is_current_vma_count(const char *msg, int expected);
> > +static bool is_test_area_mapped(const char *msg);
> > +static void print_surrounding_maps(const char *msg);
> > +
> > +/* Globals initialized in test_suite_setup() */
> > +static int MAX_VMA_COUNT;
> > +static int ORIGINAL_MAX_VMA_COUNT;
> > +static int PAGE_SIZE;
> > +static int GUARD_SIZE;
> > +static int TEST_AREA_SIZE;
> > +static int EXTRA_MAP_SIZE;
> > +
> > +static int MAX_VMA_COUNT;
> > +
> > +static int NR_EXTRA_MAPS;
> > +
> > +static char *TEST_AREA;
> > +static char *EXTRA_MAPS;
> > +
> > +#define DEFAULT_MAX_MAP_COUNT        65530
> > +#define TEST_AREA_NR_PAGES   3
> > +/* 1 before test area + 1 after test area + 1 after extra mappings */
> > +#define NR_GUARDS            3
> > +#define TEST_AREA_PROT               (PROT_NONE)
> > +#define EXTRA_MAP_PROT               (PROT_NONE)
> > +
> > +/**
> > + * test_suite_setup - Set up the VMA layout for VMA count testing.
> > + *
> > + * Sets up the following VMA layout:
> > + *
> > + * +----- base_addr
> > + * |
> > + * V
> > + * +--------------+----------------------+--------------+-------------=
---+--------------+----------------+--------------+-----+----------------+-=
-------------+
> > + * |  Guard Page  |                      |  Guard Page  |  Extra Map 1=
   | Unmapped Gap |  Extra Map 2   | Unmapped Gap | ... |  Extra Map N   | =
Unmapped Gap |
> > + * |  (unmapped)  |      TEST_AREA       |  (unmapped)  | (mapped page=
)  |  (1 page)    | (mapped page)  |  (1 page)    | ... | (mapped page)  | =
 (1 page)    |
> > + * |   (1 page)   | (unmapped, 3 pages)  |   (1 page)   |    (1 page) =
   |              |    (1 page)    |              |     |    (1 page)    | =
             |
> > + * +--------------+----------------------+--------------+-------------=
---+--------------+----------------+--------------+-----+----------------+-=
-------------+
>
> I have no idea what a 'guard page' is here. You're not using MADV_GUARD_I=
NSTALL so it's presumably an arbitrary PROT_NONE page or something?

I've changed this to "hole" per David's earlier feedbac.

>
> > + * ^              ^                      ^              ^             =
                                                     ^
> > + * |              |                      |              |             =
                                                     |
> > + * +--GUARD_SIZE--+                      |              +-- EXTRA_MAPS=
 points here             Sufficient EXTRA_MAPS to ---+
> > + *    (PAGE_SIZE) |                      |                            =
                             reach MAX_VMA_COUNT
> > + *                |                      |
> > + *                +--- TEST_AREA_SIZE ---+
> > + *                |   (3 * PAGE_SIZE)    |
> > + *                ^
> > + *                |
> > + *                +-- TEST_AREA starts here
>
> Can we make this vertical, it's obv >80 chars and it's kind of hard to re=
ad.

Will do.

>
> Also isn't this hugely convoluted? Do we really need to set up such a
> complicated set of VMAs for every test?

I thought about playing with max_map_count to achieve the needed
conditions for each test. But since this is global lowering it too
significantly will introduce issues in other system processes while
running the test (if the new max count) is lower than the current of
any process.

We only set this up once for all the tests.

>
> > + *
> > + * Populates TEST_AREA and other globals required for the tests.
> > + * If successful, the current VMA count will be MAX_VMA_COUNT - 1.
> > + *
> > + * Return: true on success, false on failure.
> > + */
> > +static bool test_suite_setup(void)
> > +{
> > +     int initial_vma_count;
> > +     size_t reservation_size;
> > +     void *base_addr =3D NULL;
> > +     char *ptr =3D NULL;
> > +
> > +     ksft_print_msg("Setting up vma_max_count test suite...\n");
> > +
> > +     /* Initialize globals */
> > +     PAGE_SIZE =3D sysconf(_SC_PAGESIZE);
> > +     TEST_AREA_SIZE =3D TEST_AREA_NR_PAGES * PAGE_SIZE;
> > +     GUARD_SIZE =3D PAGE_SIZE;
> > +     EXTRA_MAP_SIZE =3D PAGE_SIZE;
> > +     MAX_VMA_COUNT =3D get_max_vma_count();
>
> Dude we are not COBOL programmers :) What is it with these capitalised va=
riable
> names?
>
> This is really horrible, please don't do that. And why on earth are you u=
sing
> globals like this.

My intention was to avoid passing a ton of parameters to each test. I
guess I could have thread them through some struct as well :)

>
> (Again) use the self test harness please :)

Let me rework it with the harness ...
>
> > +
> > +     MAX_VMA_COUNT =3D get_max_vma_count();
> > +     if (MAX_VMA_COUNT < 0) {
> > +             ksft_print_msg("Failed to read /proc/sys/vm/max_map_count=
\n");
> > +             return false;
> > +     }
> > +
> > +     /*
> > +      * If the current limit is higher than the kernel default,
> > +      * we attempt to lower it to the default to ensure the test
> > +      * can run with a reliably known boundary.
> > +      */
> > +     ORIGINAL_MAX_VMA_COUNT =3D 0;
> > +
> > +     if (MAX_VMA_COUNT > DEFAULT_MAX_MAP_COUNT) {
> > +             ORIGINAL_MAX_VMA_COUNT =3D MAX_VMA_COUNT;
> > +
> > +             ksft_print_msg("Max VMA count is %d, lowering to default =
%d for test...\n",
> > +                             MAX_VMA_COUNT, DEFAULT_MAX_MAP_COUNT);
> > +
> > +             if (!set_max_vma_count(DEFAULT_MAX_MAP_COUNT)) {
> > +                     ksft_print_msg("WARNING: Failed to lower max_map_=
count to %d (requires root)n",
> > +                                     DEFAULT_MAX_MAP_COUNT);
>
> Probably partly a product of you not using the harness, but you're violat=
ing the
> max chars per line all over the place.
>
> checkpatch.pl kinda has a fit with this file, can we just try and keep it=
 to ~80 chars please?
>
> > +                     ksft_print_msg("Skipping test. Please run as root=
: limit needs adjustment\n");
> > +
> > +                     MAX_VMA_COUNT =3D ORIGINAL_MAX_VMA_COUNT;
> > +
> > +                     return false;
> > +             }
> > +
> > +             /* Update MAX_VMA_COUNT for the test run */
> > +             MAX_VMA_COUNT =3D DEFAULT_MAX_MAP_COUNT;
> > +     }
> > +
> > +     initial_vma_count =3D get_current_vma_count();
> > +     if (initial_vma_count < 0) {
> > +             ksft_print_msg("Failed to read /proc/self/maps\n");
> > +             return false;
> > +     }
> > +
> > +     /*
> > +      * Calculate how many extra mappings we need to create to reach
> > +      * MAX_VMA_COUNT - 1 (excluding test area).
> > +      */
> > +     NR_EXTRA_MAPS =3D MAX_VMA_COUNT - 1 - initial_vma_count;
> > +
> > +     if (NR_EXTRA_MAPS < 1) {
> > +             ksft_print_msg("Not enough available maps to run test\n")=
;
> > +             ksft_print_msg("max_vma_count=3D%d, current_vma_count=3D%=
d\n",
> > +                             MAX_VMA_COUNT, initial_vma_count);
> > +             return false;
> > +     }
> > +
> > +     /*
> > +      * Reserve space for:
> > +      * - Extra mappings with a 1-page gap after each (NR_EXTRA_MAPS *=
 2)
> > +      * - The test area itself (TEST_AREA_NR_PAGES)
> > +      * - The guard pages (NR_GUARDS)
> > +      */
> > +     reservation_size =3D ((NR_EXTRA_MAPS * 2) +
> > +                             TEST_AREA_NR_PAGES + NR_GUARDS) * PAGE_SI=
ZE;
> > +
> > +     base_addr =3D mmap(NULL, reservation_size, PROT_NONE,
> > +                     MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
> > +     if (base_addr =3D=3D MAP_FAILED) {
> > +             ksft_print_msg("Failed tommap initial reservation\n");
> > +             return false;
> > +     }
> > +
> > +     if (munmap(base_addr, reservation_size) =3D=3D -1) {
> > +             ksft_print_msg("Failed to munmap initial reservation\n");
> > +             return false;
> > +     }
> > +
> > +     /* Get the addr of the test area */
> > +     TEST_AREA =3D (char *)base_addr + GUARD_SIZE;
> > +
> > +     /*
> > +      * Get the addr of the region for extra mappings:
> > +      *     test area + 1 guard.
> > +      */
> > +     EXTRA_MAPS =3D TEST_AREA + TEST_AREA_SIZE + GUARD_SIZE;
> > +
> > +     /* Create single-page mappings separated by unmapped pages */
> > +     ptr =3D EXTRA_MAPS;
> > +     for (int i =3D 0; i < NR_EXTRA_MAPS; ++i) {
> > +             if (mmap(ptr, PAGE_SIZE, EXTRA_MAP_PROT,
> > +                     MAP_PRIVATE|MAP_ANONYMOUS|MAP_FIXED_NOREPLACE,
> > +                     -1, 0) =3D=3D MAP_FAILED) {
> > +                     perror("mmap in fill loop");
> > +                     ksft_print_msg("Failed on mapping #%d of %d\n", i=
 + 1,
> > +                                     NR_EXTRA_MAPS);
> > +                     return false;
> > +             }
> > +
> > +             /* Advance pointer by 2 to leave a gap */
> > +             ptr +=3D (2 * EXTRA_MAP_SIZE);
> > +     }
> > +
> > +     if (!is_current_vma_count("test_suite_setup", MAX_VMA_COUNT - 1))
> > +             return false;
> > +
> > +     ksft_print_msg("vma_max_count test suite setup done.\n");
> > +
> > +     return true;
> > +}
>
> I mean it'll be fixed by the test harness, but even in test code let's pl=
ease
> not write MASSIVE functions that do a million things. It's not really rea=
dable.

I'll try breaking this up in the next revision.

>
> > +
> > +static void test_suite_teardown(void)
> > +{
> > +     if (ORIGINAL_MAX_VMA_COUNT && MAX_VMA_COUNT !=3D ORIGINAL_MAX_VMA=
_COUNT) {
> > +             if (!set_max_vma_count(ORIGINAL_MAX_VMA_COUNT))
> > +                     ksft_print_msg("Failed to restore max_map_count t=
o %d\n",
> > +                                     ORIGINAL_MAX_VMA_COUNT);
> > +     }
> > +}
> > +
> > +/* --- Test Helper Functions --- */
> > +static bool mmap_anon(void)
> > +{
> > +     void *addr =3D  mmap(NULL, PAGE_SIZE, PROT_READ,
> > +                        MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
> > +
> > +     /*
> > +      * Handle cleanup here as the runner doesn't track where this,
> > +      *mapping is located.
> > +      */
> > +     if (addr !=3D MAP_FAILED)
> > +             munmap(addr, PAGE_SIZE);
> > +
> > +     return addr !=3D MAP_FAILED;
> > +}
> > +
> > +static inline bool __mprotect(char *addr, int size)
> > +{
> > +     int new_prot =3D ~TEST_AREA_PROT & (PROT_READ | PROT_WRITE | PROT=
_EXEC);
> > +
> > +     return mprotect(addr, size, new_prot) =3D=3D 0;
> > +}
> > +
> > +static bool mprotect_nosplit(void)
> > +{
> > +     return __mprotect(TEST_AREA, TEST_AREA_SIZE);
> > +}
> > +
> > +static bool mprotect_2way_split(void)
> > +{
> > +     return __mprotect(TEST_AREA, TEST_AREA_SIZE - PAGE_SIZE);
> > +}
> > +
> > +static bool mprotect_3way_split(void)
> > +{
> > +     return __mprotect(TEST_AREA + PAGE_SIZE, PAGE_SIZE);
> > +}
> > +
> > +static inline bool __munmap(char *addr, int size)
> > +{
> > +     return munmap(addr, size) =3D=3D 0;
> > +}
> > +
> > +static bool munmap_nosplit(void)
> > +{
> > +     return __munmap(TEST_AREA, TEST_AREA_SIZE);
> > +}
> > +
> > +static bool munmap_2way_split(void)
> > +{
> > +     return __munmap(TEST_AREA, TEST_AREA_SIZE - PAGE_SIZE);
> > +}
> > +
> > +static bool munmap_3way_split(void)
> > +{
> > +     return __munmap(TEST_AREA + PAGE_SIZE, PAGE_SIZE);
> > +}
> > +
> > +/* mremap accounts for the worst case to fail early */
> > +static const int MREMAP_REQUIRED_VMA_SLOTS =3D 6;
> > +
> > +static bool mremap_dontunmap(void)
> > +{
> > +     void *new_addr;
> > +
> > +     /*
> > +      * Using MREMAP_DONTUNMAP will create a new mapping without
> > +      * removing the old one, consuming one VMA slot.
> > +      */
> > +     new_addr =3D mremap(TEST_AREA, TEST_AREA_SIZE, TEST_AREA_SIZE,
> > +                       MREMAP_MAYMOVE | MREMAP_DONTUNMAP, NULL);
> > +
> > +     if (new_addr !=3D MAP_FAILED)
> > +             munmap(new_addr, TEST_AREA_SIZE);
> > +
> > +     return new_addr !=3D MAP_FAILED;
> > +}
> > +
> > +struct test {
> > +     const char *name;
> > +     bool (*test)(void);
> > +      /* How many VMA slots below the limit this test needs to start? =
*/
> > +     int vma_slots_needed;
> > +     bool expect_success;
> > +};
> > +
> > +/* --- Test Cases --- */
> > +struct test tests[] =3D {
> > +     {
> > +             .name =3D "mmap_at_1_below_vma_count_limit",
> > +             .test =3D mmap_anon,
> > +             .vma_slots_needed =3D 1,
> > +             .expect_success =3D true,
> > +     },
> > +     {
> > +             .name =3D "mmap_at_vma_count_limit",
> > +             .test =3D mmap_anon,
> > +             .vma_slots_needed =3D 0,
> > +             .expect_success =3D false,
> > +     },
> > +     {
> > +             .name =3D "mprotect_nosplit_at_1_below_vma_count_limit",
> > +             .test =3D mprotect_nosplit,
> > +             .vma_slots_needed =3D 1,
> > +             .expect_success =3D true,
> > +     },
> > +     {
> > +             .name =3D "mprotect_nosplit_at_vma_count_limit",
> > +             .test =3D mprotect_nosplit,
> > +             .vma_slots_needed =3D 0,
> > +             .expect_success =3D true,
> > +     },
> > +     {
> > +             .name =3D "mprotect_2way_split_at_1_below_vma_count_limit=
",
> > +             .test =3D mprotect_2way_split,
> > +             .vma_slots_needed =3D 1,
> > +             .expect_success =3D true,
> > +     },
> > +     {
> > +             .name =3D "mprotect_2way_split_at_vma_count_limit",
> > +             .test =3D mprotect_2way_split,
> > +             .vma_slots_needed =3D 0,
> > +             .expect_success =3D false,
> > +     },
> > +     {
> > +             .name =3D "mprotect_3way_split_at_2_below_vma_count_limit=
",
> > +             .test =3D mprotect_3way_split,
> > +             .vma_slots_needed =3D 2,
> > +             .expect_success =3D true,
> > +     },
> > +     {
> > +             .name =3D "mprotect_3way_split_at_1_below_vma_count_limit=
",
> > +             .test =3D mprotect_3way_split,
> > +             .vma_slots_needed =3D 1,
> > +             .expect_success =3D false,
> > +     },
> > +     {
> > +             .name =3D "mprotect_3way_split_at_vma_count_limit",
> > +             .test =3D mprotect_3way_split,
> > +             .vma_slots_needed =3D 0,
> > +             .expect_success =3D false,
> > +     },
> > +     {
> > +             .name =3D "munmap_nosplit_at_1_below_vma_count_limit",
> > +             .test =3D munmap_nosplit,
> > +             .vma_slots_needed =3D 1,
> > +             .expect_success =3D true,
> > +     },
> > +     {
> > +             .name =3D "munmap_nosplit_at_vma_count_limit",
> > +             .test =3D munmap_nosplit,
> > +             .vma_slots_needed =3D 0,
> > +             .expect_success =3D true,
> > +     },
> > +     {
> > +             .name =3D "munmap_2way_split_at_1_below_vma_count_limit",
> > +             .test =3D munmap_2way_split,
> > +             .vma_slots_needed =3D 1,
> > +             .expect_success =3D true,
> > +     },
> > +     {
> > +             .name =3D "munmap_2way_split_at_vma_count_limit",
> > +             .test =3D munmap_2way_split,
> > +             .vma_slots_needed =3D 0,
> > +             .expect_success =3D true,
> > +     },
> > +     {
> > +             .name =3D "munmap_3way_split_at_2_below_vma_count_limit",
> > +             .test =3D munmap_3way_split,
> > +             .vma_slots_needed =3D 2,
> > +             .expect_success =3D true,
> > +     },
> > +     {
> > +             .name =3D "munmap_3way_split_at_1_below_vma_count_limit",
> > +             .test =3D munmap_3way_split,
> > +             .vma_slots_needed =3D 1,
> > +             .expect_success =3D true,
> > +     },
> > +     {
> > +             .name =3D "munmap_3way_split_at_vma_count_limit",
> > +             .test =3D munmap_3way_split,
> > +             .vma_slots_needed =3D 0,
> > +             .expect_success =3D false,
> > +     },
> > +     {
> > +             .name =3D "mremap_dontunmap_at_required_vma_count_capcity=
",
> > +             .test =3D mremap_dontunmap,
> > +             .vma_slots_needed =3D MREMAP_REQUIRED_VMA_SLOTS,
> > +             .expect_success =3D true,
> > +     },
> > +     {
> > +             .name =3D "mremap_dontunmap_at_1_below_required_vma_count=
_capacity",
> > +             .test =3D mremap_dontunmap,
> > +             .vma_slots_needed =3D MREMAP_REQUIRED_VMA_SLOTS - 1,
> > +             .expect_success =3D false,
> > +     },
>
> This is horrible. We don't need to do it this way.
>
> Use the kselftest_harness please. See the guard_regions.c test for an exa=
mple of
> how to use it.

Will do, thanks for the reference.

>
> > +};
> > +
> > +/* --- Test Runner --- */
> > +int main(int argc, char **argv)
> > +{
> > +     int num_tests =3D ARRAY_SIZE(tests);
> > +     int failed_tests =3D 0;
> > +
> > +     ksft_set_plan(num_tests);
> > +
> > +     if (!test_suite_setup() !=3D 0) {
> > +             if (MAX_VMA_COUNT > DEFAULT_MAX_MAP_COUNT)
> > +                     ksft_exit_skip("max_map_count too high and cannot=
 be lowered\n"
> > +                                     "Please rerun as root.\n");
> > +             else
> > +                     ksft_exit_fail_msg("Test suite setup failed. Abor=
ting.\n");
> > +
> > +     }
> > +
> > +     for (int i =3D 0; i < num_tests; i++) {
> > +             int maps_to_unmap =3D tests[i].vma_slots_needed;
> > +             const char *name =3D tests[i].name;
> > +             bool test_passed;
> > +
> > +             errno =3D 0;
> > +
> > +             /* 1. Setup: TEST_AREA mapping */
> > +             if (mmap(TEST_AREA, TEST_AREA_SIZE, TEST_AREA_PROT,
> > +                     MAP_PRIVATE|MAP_ANONYMOUS|MAP_FIXED, -1, 0)
> > +                             =3D=3D MAP_FAILED) {
> > +                     ksft_test_result_fail(
> > +                             "%s: Test setup failed to map TEST_AREA\n=
",
> > +                             name);
> > +                     maps_to_unmap =3D 0;
> > +                     goto fail;
> > +             }
> > +
> > +             /* Label TEST_AREA to ease debugging */
> > +             if (prctl(PR_SET_VMA, PR_SET_VMA_ANON_NAME, TEST_AREA,
> > +                     TEST_AREA_SIZE, "TEST_AREA")) {
> > +                     ksft_print_msg("WARNING: [%s] prctl(PR_SET_VMA) f=
ailed\n",
> > +                                     name);
> > +                     ksft_print_msg(
> > +                             "Continuing without named TEST_AREA mappi=
ng\n");
> > +             }
> > +
> > +             /* 2. Setup: Adjust VMA count based on test requirements =
*/
> > +             if (maps_to_unmap > NR_EXTRA_MAPS) {
> > +                     ksft_test_result_fail(
> > +                             "%s: Test setup failed: Invalid VMA slots=
 required %d\n",
> > +                             name, tests[i].vma_slots_needed);
> > +                     maps_to_unmap =3D 0;
> > +                     goto fail;
> > +             }
> > +
> > +             /* Unmap extra mappings, accounting for the 1-page gap */
> > +             for (int j =3D 0; j < maps_to_unmap; j++)
> > +                     munmap(EXTRA_MAPS + (j * 2 * EXTRA_MAP_SIZE),
> > +                             EXTRA_MAP_SIZE);
> > +
> > +             /*
> > +              * 3. Verify the preconditions.
> > +              *
> > +              *    Sometimes there isn't an easy way to determine the =
cause
> > +              *    of the test failure.
> > +              *    e.g. an mprotect ENOMEM may be due to trying to pro=
tect
> > +              *         unmapped area or due to hitting MAX_VMA_COUNT =
limit.
> > +              *
> > +              *    We verify the preconditions of the test to ensure a=
ny
> > +              *    expected failures are from the expected cause and n=
ot
> > +              *    coincidental.
> > +              */
> > +             if (!is_current_vma_count(name,
> > +                     MAX_VMA_COUNT - tests[i].vma_slots_needed))
> > +                     goto fail;
> > +
> > +             if (!is_test_area_mapped(name))
> > +                     goto fail;
> > +
> > +             /* 4. Run the test */
> > +             test_passed =3D (tests[i].test() =3D=3D tests[i].expect_s=
uccess);
> > +             if (test_passed) {
> > +                     ksft_test_result_pass("%s\n", name);
> > +             } else {
> > +fail:
> > +                     failed_tests++;
> > +                     ksft_test_result_fail(
> > +                             "%s: current_vma_count=3D%d,max_vma_count=
=3D%d: errno: %d (%s)\n",
> > +                             name, get_current_vma_count(), MAX_VMA_CO=
UNT,
> > +                             errno, strerror(errno));
> > +                     print_surrounding_maps(name);
> > +             }
> > +
> > +             /* 5. Teardown: Unmap TEST_AREA. */
> > +             munmap(TEST_AREA, TEST_AREA_SIZE);
> > +
> > +             /* 6. Teardown: Restore extra mappings to test suite base=
line */
> > +             for (int j =3D 0; j < maps_to_unmap; j++) {
> > +                     /* Remap extra mappings, accounting for the gap *=
/
> > +                     mmap(EXTRA_MAPS + (j * 2 * EXTRA_MAP_SIZE),
> > +                             EXTRA_MAP_SIZE, EXTRA_MAP_PROT,
> > +                             MAP_PRIVATE|MAP_ANONYMOUS|MAP_FIXED_NOREP=
LACE,
> > +                             -1, 0);
> > +             }
> > +     }
> > +
> > +     test_suite_teardown();
> > +
> > +     if (failed_tests > 0)
> > +             ksft_exit_fail();
> > +     else
> > +             ksft_exit_pass();
> > +}
> > +
> > +/* --- Utilities --- */
> > +
> > +static int get_max_vma_count(void)
> > +{
> > +     int max_count;
> > +     FILE *f;
> > +
> > +     f =3D fopen("/proc/sys/vm/max_map_count", "r");
> > +     if (!f)
> > +             return -1;
> > +
> > +     if (fscanf(f, "%d", &max_count) !=3D 1)
> > +             max_count =3D -1;
> > +
> > +
> > +     fclose(f);
> > +
> > +     return max_count;
> > +}
> > +
> > +static bool set_max_vma_count(int val)
> > +{
> > +     FILE *f;
> > +     bool success =3D false;
> > +
> > +     f =3D fopen("/proc/sys/vm/max_map_count", "w");
> > +     if (!f)
> > +             return false;
> > +
> > +     if (fprintf(f, "%d", val) > 0)
> > +             success =3D true;
> > +
> > +     fclose(f);
> > +     return success;
> > +}
> > +
> > +static int get_current_vma_count(void)
> > +{
> > +     char line[1024];
> > +     int count =3D 0;
> > +     FILE *f;
> > +
> > +     f =3D fopen("/proc/self/maps", "r");
> > +     if (!f)
> > +             return -1;
> > +
> > +     while (fgets(line, sizeof(line), f)) {
> > +             if (!strstr(line, "[vsyscall]"))
> > +                     count++;
> > +     }
> > +
> > +     fclose(f);
> > +
> > +     return count;
> > +}
> > +
> > +static bool is_current_vma_count(const char *msg, int expected)
> > +{
> > +     int current =3D get_current_vma_count();
> > +
> > +     if (current =3D=3D expected)
> > +             return true;
> > +
> > +     ksft_print_msg("%s: vma count is %d, expected %d\n", msg, current=
,
> > +                     expected);
> > +     return false;
> > +}
> > +
> > +static bool is_test_area_mapped(const char *msg)
> > +{
> > +     unsigned long search_start =3D (unsigned long)TEST_AREA;
> > +     unsigned long search_end =3D search_start + TEST_AREA_SIZE;
> > +     bool found =3D false;
> > +     char line[1024];
> > +     FILE *f;
> > +
> > +     f =3D fopen("/proc/self/maps", "r");
> > +     if (!f) {
> > +             ksft_print_msg("failed to open /proc/self/maps\n");
> > +             return false;
> > +     }
> > +
> > +     while (fgets(line, sizeof(line), f)) {
> > +             unsigned long start, end;
> > +
> > +             if (sscanf(line, "%lx-%lx", &start, &end) !=3D 2)
> > +                     continue;
> > +
> > +             /* Check for an exact match of the range */
> > +             if (start =3D=3D search_start && end =3D=3D search_end) {
> > +                     found =3D true;
> > +                     break;
> > +             } else if (start > search_end) {
> > +                     /*
> > +                      *Since maps are sorted, if we've passed the end,=
 we
> > +                      * can stop searching.
> > +                      */
> > +                     break;
> > +             }
> > +     }
> > +
>
> There's helpers for this kind of thing in vm_util.h, let's not duplicate
> code. Also you can use the proc query ioctl thingy (also helpers for that=
 in
> vm_util.h) rather than having to spelunk /proc/$pid/maps.

Thanks I'll use the helpers there instead.

>
> > +     fclose(f);
> > +
> > +     if (found)
> > +             return true;
> > +
> > +     /* Not found */
> > +     ksft_print_msg(
> > +             "%s: TEST_AREA is not mapped as a single contiguous block=
.\n",
> > +             msg);
> > +     print_surrounding_maps(msg);
> > +
> > +     return false;
> > +}
> > +
> > +static void print_surrounding_maps(const char *msg)
>
> WHy are you printing a bunch of noise in a test?

This is only printed in the failure case, it makes debugging much
easier. I can update it to a TH_LOG() instead once it's moved to the
test harness.

Thanks,
Kalesh
>
> > +{
> > +     unsigned long search_start =3D (unsigned long)TEST_AREA;
> > +     unsigned long search_end =3D search_start + TEST_AREA_SIZE;
> > +     unsigned long start;
> > +     unsigned long end;
> > +     char line[1024] =3D {};
> > +     int line_idx =3D 0;
> > +     int first_match_idx =3D -1;
> > +     int last_match_idx =3D -1;
> > +     FILE *f;
> > +
> > +     f =3D fopen("/proc/self/maps", "r");
> > +     if (!f)
> > +             return;
> > +
> > +     if (msg)
> > +             ksft_print_msg("%s\n", msg);
> > +
> > +     ksft_print_msg("--- Surrounding VMA entries for TEST_AREA (%p) --=
-\n",
> > +                     TEST_AREA);
> > +
> > +     /* First pass: Read all lines and find the range of matching entr=
ies */
> > +     fseek(f, 0, SEEK_SET); /* Rewind file */
> > +     while (fgets(line, sizeof(line), f)) {
> > +             if (sscanf(line, "%lx-%lx", &start, &end) !=3D 2) {
> > +                     line_idx++;
> > +                     continue;
> > +             }
> > +
> > +             /* Check for any overlap */
> > +             if (start < search_end && end > search_start) {
> > +                     if (first_match_idx =3D=3D -1)
> > +                             first_match_idx =3D line_idx;
> > +                     last_match_idx =3D line_idx;
> > +             } else if (start > search_end) {
> > +                     /*
> > +                      * Since maps are sorted, if we've passed the end=
, we
> > +                      * can stop searching.
> > +                      */
> > +                     break;
> > +             }
> > +
> > +             line_idx++;
> > +     }
> > +
> > +     if (first_match_idx =3D=3D -1) {
> > +             ksft_print_msg("TEST_AREA (%p) is not currently mapped.\n=
",
> > +                             TEST_AREA);
> > +     } else {
> > +             /* Second pass: Print the relevant lines */
> > +             fseek(f, 0, SEEK_SET); /* Rewind file */
> > +             line_idx =3D 0;
> > +             while (fgets(line, sizeof(line), f)) {
> > +                     /* Print 2 lines before the first match */
> > +                     if (line_idx >=3D first_match_idx - 2 &&
> > +                             line_idx < first_match_idx)
> > +                             ksft_print_msg("   %s", line);
> > +
> > +                     /* Print all matching TEST_AREA entries */
> > +                     if (line_idx >=3D first_match_idx &&
> > +                             line_idx <=3D last_match_idx)
> > +                             ksft_print_msg(">> %s", line);
> > +
> > +                     /* Print 2 lines after the last match */
> > +                     if (line_idx > last_match_idx &&
> > +                             line_idx <=3D last_match_idx + 2)
> > +                             ksft_print_msg("   %s", line);
> > +
> > +                     line_idx++;
> > +             }
> > +     }
> > +
> > +     ksft_print_msg("-------------------------------------------------=
-\n");
> > +
> > +     fclose(f);
> > +}
> > diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/=
selftests/mm/run_vmtests.sh
> > index 471e539d82b8..3794b50ec280 100755
> > --- a/tools/testing/selftests/mm/run_vmtests.sh
> > +++ b/tools/testing/selftests/mm/run_vmtests.sh
> > @@ -49,6 +49,8 @@ separated by spaces:
> >       test madvise(2) MADV_GUARD_INSTALL and MADV_GUARD_REMOVE options
> >  - madv_populate
> >       test memadvise(2) MADV_POPULATE_{READ,WRITE} options
> > +- max_vma_count
> > +     tests for max vma_count
> >  - memfd_secret
> >       test memfd_secret(2)
> >  - process_mrelease
> > @@ -417,6 +419,9 @@ fi # VADDR64
> >  # vmalloc stability smoke test
> >  CATEGORY=3D"vmalloc" run_test bash ./test_vmalloc.sh smoke
> >
> > +# test operations against max vma count limit
> > +CATEGORY=3D"max_vma_count" run_test ./max_vma_count_tests
> > +
> >  CATEGORY=3D"mremap" run_test ./mremap_dontunmap
> >
> >  CATEGORY=3D"hmm" run_test bash ./test_hmm.sh smoke
> > --
> > 2.51.0.384.g4c02a37b29-goog
> >

