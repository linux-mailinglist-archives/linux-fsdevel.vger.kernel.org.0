Return-Path: <linux-fsdevel+bounces-4832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 037FD804A2B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 07:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 312121C20D49
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 06:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908BCDF67
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 06:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EsROK7t2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DCDCA
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Dec 2023 20:46:25 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5d8d2b5d1b5so13124857b3.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Dec 2023 20:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701751585; x=1702356385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTwiqtihyMWEpX2uUmOeVlr01B75EdpPvzVSzPHU6u0=;
        b=EsROK7t2fvj77E3v8lpYat9bTzWtHVYaJcPb52a5KrlqsVq3JW81QWSCBdLY/dl0/D
         C/7art0rHcG5IuKUkPCCGUCe1haQxMMNOwgLPnnFb3PtRK0gEujjXCd3AE7pnkT9UjeM
         5poCjjwhoZGHum1E/4XJwFoD0Aeu5Wqx7p2NGF75Qom0a7y+t74kkxBZ7b3549VUBv8P
         sGevK4G7nvSRxShty3Z3I104eT/Qu/mczt/+EZElP7LIb7Dk/bBuFK8TD7C9KnU7Bn4w
         Rc6JUUS07y4PV5EzB+XpzCB4CeH7qB2shrpMoNoipHm3y0oUXBxmHGRyyKPP20EySsxr
         WjvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701751585; x=1702356385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PTwiqtihyMWEpX2uUmOeVlr01B75EdpPvzVSzPHU6u0=;
        b=Okg/CQjameIULO2fFCi2wS/Dhh7UpJeIEvdzyacT4Jb/Zs9v6A849frfFfPbFiO0Lh
         NScx5bnj3Sm93LhhKl+FsS83NlkS5Zhpe2eRK8fCXi+fDME4o0Zx+xWDCMHzQOYFBM3k
         Mj/sFtqenEaX011d8V6qSC5Pkq+4/lYCutWwKK9CcSlyCj5+R9klTlBJVfQBsROojds6
         4dv7Jt37Le9XInwnVaWvHZyR63WjCKSZjWofxr8TW//Ke5BkgseY0yo0r5t3S2dSNeZc
         4zIBWD5fGHq22wX8M2kgLSDCm/dks4dqhOiohgyTMwv3gr4yBN9kI1O2zFy2wWrPiwds
         v9Rg==
X-Gm-Message-State: AOJu0YzzdN482GvbIAgVXey6wgkKFau4EWQSjpSvoNDfcbAwTClp03aO
	i470+lo6KPHhbQkgx9ysHlvU8nJWfbzAWClUtInMfQ==
X-Google-Smtp-Source: AGHT+IHB79SbOHLU+JRoXQHpNdBkCdmYdjIJ60fLZnJBIH3FURvlK43Sy3u4VAUNLryAKQaKl4/7/lDz2Im56Eiua14=
X-Received: by 2002:a05:690c:8:b0:5d8:2f65:cf71 with SMTP id
 bc8-20020a05690c000800b005d82f65cf71mr2583688ywb.86.1701751584910; Mon, 04
 Dec 2023 20:46:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121171643.3719880-1-surenb@google.com> <20231121171643.3719880-6-surenb@google.com>
 <b3c882d2-0135-430c-8179-784f78be0902@arm.com> <a41c759f-78d8-44ed-b708-1bb737a8e6c1@redhat.com>
 <cb3d3b12-abf3-4eda-8d9a-944684d05505@arm.com> <ccdb1080-7a2e-4f98-a4e8-e864fa2db299@redhat.com>
 <CAJuCfpHS63bXkRGE1_G4z-2fDe72BeLka8t5ioSg2OXjbUrHXg@mail.gmail.com>
 <744be4e0-48e0-4c77-825c-711386dd205f@arm.com> <CAJuCfpHpbz4fWawmYU=B1D5pPE4+x0Wj0V-514Dja9UWcwiL9A@mail.gmail.com>
 <a52284a4-2b8c-4118-965d-04c472fbee05@redhat.com> <CAJuCfpEbxPksw3WtLWRT9mmGUCSZ431E4vaWMtbu8OrXmMxCdw@mail.gmail.com>
In-Reply-To: <CAJuCfpEbxPksw3WtLWRT9mmGUCSZ431E4vaWMtbu8OrXmMxCdw@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 4 Dec 2023 20:46:11 -0800
Message-ID: <CAJuCfpG=seLkKbMRjwuWNQozGSQmP-JqKVUuCGRqMqxND2u18A@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] selftests/mm: add UFFDIO_MOVE ioctl test
To: David Hildenbrand <david@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, akpm@linux-foundation.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org, 
	aarcange@redhat.com, lokeshgidra@google.com, peterx@redhat.com, 
	hughd@google.com, mhocko@suse.com, axelrasmussen@google.com, rppt@kernel.org, 
	willy@infradead.org, Liam.Howlett@oracle.com, jannh@google.com, 
	zhangpeng362@huawei.com, bgeffon@google.com, kaleshsingh@google.com, 
	ngeoffray@google.com, jdduke@google.com, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 10:44=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Mon, Dec 4, 2023 at 10:27=E2=80=AFAM David Hildenbrand <david@redhat.c=
om> wrote:
> >
> > On 04.12.23 17:35, Suren Baghdasaryan wrote:
> > > On Mon, Dec 4, 2023 at 1:27=E2=80=AFAM Ryan Roberts <ryan.roberts@arm=
.com> wrote:
> > >>
> > >> On 04/12/2023 04:09, Suren Baghdasaryan wrote:
> > >>> On Sat, Dec 2, 2023 at 2:11=E2=80=AFAM David Hildenbrand <david@red=
hat.com> wrote:
> > >>>>
> > >>>> On 02.12.23 09:04, Ryan Roberts wrote:
> > >>>>> On 01/12/2023 20:47, David Hildenbrand wrote:
> > >>>>>> On 01.12.23 10:29, Ryan Roberts wrote:
> > >>>>>>> On 21/11/2023 17:16, Suren Baghdasaryan wrote:
> > >>>>>>>> Add tests for new UFFDIO_MOVE ioctl which uses uffd to move so=
urce
> > >>>>>>>> into destination buffer while checking the contents of both af=
ter
> > >>>>>>>> the move. After the operation the content of the destination b=
uffer
> > >>>>>>>> should match the original source buffer's content while the so=
urce
> > >>>>>>>> buffer should be zeroed. Separate tests are designed for PMD a=
ligned and
> > >>>>>>>> unaligned cases because they utilize different code paths in t=
he kernel.
> > >>>>>>>>
> > >>>>>>>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > >>>>>>>> ---
> > >>>>>>>>     tools/testing/selftests/mm/uffd-common.c     |  24 +++
> > >>>>>>>>     tools/testing/selftests/mm/uffd-common.h     |   1 +
> > >>>>>>>>     tools/testing/selftests/mm/uffd-unit-tests.c | 189 +++++++=
++++++++++++
> > >>>>>>>>     3 files changed, 214 insertions(+)
> > >>>>>>>>
> > >>>>>>>> diff --git a/tools/testing/selftests/mm/uffd-common.c
> > >>>>>>>> b/tools/testing/selftests/mm/uffd-common.c
> > >>>>>>>> index fb3bbc77fd00..b0ac0ec2356d 100644
> > >>>>>>>> --- a/tools/testing/selftests/mm/uffd-common.c
> > >>>>>>>> +++ b/tools/testing/selftests/mm/uffd-common.c
> > >>>>>>>> @@ -631,6 +631,30 @@ int copy_page(int ufd, unsigned long offs=
et, bool wp)
> > >>>>>>>>         return __copy_page(ufd, offset, false, wp);
> > >>>>>>>>     }
> > >>>>>>>>     +int move_page(int ufd, unsigned long offset, unsigned lon=
g len)
> > >>>>>>>> +{
> > >>>>>>>> +    struct uffdio_move uffdio_move;
> > >>>>>>>> +
> > >>>>>>>> +    if (offset + len > nr_pages * page_size)
> > >>>>>>>> +        err("unexpected offset %lu and length %lu\n", offset,=
 len);
> > >>>>>>>> +    uffdio_move.dst =3D (unsigned long) area_dst + offset;
> > >>>>>>>> +    uffdio_move.src =3D (unsigned long) area_src + offset;
> > >>>>>>>> +    uffdio_move.len =3D len;
> > >>>>>>>> +    uffdio_move.mode =3D UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES;
> > >>>>>>>> +    uffdio_move.move =3D 0;
> > >>>>>>>> +    if (ioctl(ufd, UFFDIO_MOVE, &uffdio_move)) {
> > >>>>>>>> +        /* real retval in uffdio_move.move */
> > >>>>>>>> +        if (uffdio_move.move !=3D -EEXIST)
> > >>>>>>>> +            err("UFFDIO_MOVE error: %"PRId64,
> > >>>>>>>> +                (int64_t)uffdio_move.move);
> > >>>>>>>
> > >>>>>>> Hi Suren,
> > >>>>>>>
> > >>>>>>> FYI this error is triggering in mm-unstable (715b67adf4c8):
> > >>>>>>>
> > >>>>>>> Testing move-pmd on anon... ERROR: UFFDIO_MOVE error: -16 (errn=
o=3D16,
> > >>>>>>> @uffd-common.c:648)
> > >>>>>>>
> > >>>>>>> I'm running in a VM on Apple M2 (arm64). I haven't debugged any=
 further, but
> > >>>>>>> happy to go deeper if you can direct.
> > >>>>>>
> > >>>>>> Does it trigger reliably? Which pagesize is that kernel using?
> > >>>>>
> > >>>>> Yep, although very occasionally it fails with EAGAIN. 4K kernel; =
see other email
> > >>>>> for full config.
> > >>>>>
> > >>>>>>
> > >>>>>> I can spot that uffd_move_pmd_test()/uffd_move_pmd_handle_fault(=
) uses
> > >>>>>> default_huge_page_size(), which reads the default hugetlb size.
> > >>>>>
> > >>>>> My kernel command line is explicitly seting the default huge page=
 size to 2M.
> > >>>>>
> > >>>>
> > >>>> Okay, so that likely won't affect it.
> > >>>>
> > >>>> I can only guess that it has to do with the alignment of the virtu=
al
> > >>>> area we are testing with, and that we do seem to get more odd patt=
erns
> > >>>> on arm64.
> > >>>>
> > >>>> uffd_move_test_common() is a bit more elaborate, but if we aligned=
 the
> > >>>> src+start area up, surely "step_count" cannot be left unmodified?
> > >>>>
> > >>>> So assuming we get either an unaligned source or an unaligned dst =
from
> > >>>> mmap(), I am not convinced that we won't be moving areas that are =
not
> > >>>> necessarily fully backed by PMDs and maybe don't even fall into th=
e VMA
> > >>>> of interest?
> > >>>>
> > >>>> Not sure if that could trigger the THP splitting issue, though.
> > >>>>
> > >>>> But I just quickly scanned that test setup, could be I am missing
> > >>>> something. It might make sense to just print the mmap'ed range and=
 the
> > >>>> actual ranges we are trying to move. Maybe something "obvious" can=
 be
> > >>>> observed.
> > >>>
> > >>> I was able to reproduce the issue on an Android device and after
> > >>> implementing David's suggestions to split the large folio and after
> > >>> replacing default_huge_page_size() with read_pmd_pagesize(), the
> > >>> move-pmd test started working for me. Ryan, could you please apply
> > >>> attached patches (over mm-unstable) and try the test again?
> > >>
> > >> Yep, all fixed with those patches!
> > >
> > > Great! Thanks for testing and confirming. I'll post an updated
> > > patchset later today and will ask Andrew to replace the current one
> > > with it.
> > > I'll also look into the reasons we need to split PMD on ARM64 in this
> > > test. It's good that this happened and we were able to test the PMD
> > > split path but I'm curious about the reason. It's possible my address
> > > alignment calculations are  somehow incorrect.
> >
> > I only skimmed the diff briefly, but likely you also want to try
> > splitting in move_pages_pte(), if you encounter an already-pte-mapped T=
HP.
>
> Huh, good point. I might be able to move the folio splitting code into
> pte-mapped case and do a retry after splitting. That should minimize
> the additional code required. Will do and post a new set shortly.
> Thanks!

Was planning to post an update today but need some more time. Will try
to send it tomorrow.

>
> >
> > --
> > Cheers,
> >
> > David / dhildenb
> >

