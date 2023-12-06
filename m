Return-Path: <linux-fsdevel+bounces-4980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4AB806C44
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 11:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1EDD1C20A91
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 10:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5FE2F847
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 10:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s5NfzDY6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDBF137
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 02:30:41 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-db539ab8e02so5342125276.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Dec 2023 02:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701858641; x=1702463441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJAfBJe//jMp144Bh2ybimjx6ISuOne+BJIc9JPDue0=;
        b=s5NfzDY6S0KcpnPU5ek/CTs7xvn0+fFhbf/dLr7qSR9E9uxw/sN5Ztfq9MmjD9ByvO
         Dcp9McBlxJLZhbBO1PMbBI8Y0GCxvzSkyaGgb5DbfV3wCpkvqJ6o05aCdJ39Um3CJWv3
         1oGxoT0ric7Ezm5vcLv7pylzl5/FxcPSGn30BWNSjXcW9slLphriIG9ARdRjzGj8oiuB
         x3sqT6Z6Xrbv0swjaBFH7zkggGqkjUsdSWZTxoSpVsKxflb9+TKLo0xsmINhH7s6T0Lg
         wNJYeZpVfkidV3cpGt9eGfKepmuTHxslAlk3pNkK4ufuxwTsFwvLJfkpeli/pn7+fnvX
         AbWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701858641; x=1702463441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oJAfBJe//jMp144Bh2ybimjx6ISuOne+BJIc9JPDue0=;
        b=Xnk7vDqmoE6Kx0V0WRK6240tPWtWuqAAyBP+evXpZ/WKS0H5LqFffwRUrzL7+KrJL7
         tpyvg6a6svVLOBlG+BKDACApM4uOze+scMazIOzC1QOTe74kdsm5KJb1YBl4M8as8jOA
         XciDvNtC2DMx/CiqmpnfZqx+qsOJ0BfOOaQudZJ9c6UlLB/1VmNyXncs9od4REcWwMCK
         +CwtFiRYQ7IhvZHQJ3Eg0gkyoHoJprg8BKxh5j/T6HkP9sIb3mf0lEKkG2oOrIuJ6nyo
         XwxUIUmARmnV6R7ORDbuwZugE6+YrxjiMeTLQaSJZ6b53WwiO6mzLxr5tW7ipeOsP6Qo
         e9CQ==
X-Gm-Message-State: AOJu0YwLPtf7AxK4d6CvMQthvhNAx5/p3n0Mm6OSJSmIrPI+6Ir+Io3h
	Nk3zV1FxXyLUcWzuSPDxly0fg/uRzjKnaj9nPhuaVg==
X-Google-Smtp-Source: AGHT+IFsrLqiAiOECeAi7vlVllrb2MVHSSJ0Sh4PmyzU4danP7PT/4yH1PAFrlzNyaMRm/sQgpHe+/mNLpSaLyYq/Oc=
X-Received: by 2002:a25:c7cd:0:b0:db5:45f4:ec83 with SMTP id
 w196-20020a25c7cd000000b00db545f4ec83mr416954ybe.43.1701858640812; Wed, 06
 Dec 2023 02:30:40 -0800 (PST)
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
 <CAJuCfpG=seLkKbMRjwuWNQozGSQmP-JqKVUuCGRqMqxND2u18A@mail.gmail.com> <3ba0015b-b36e-449a-8445-0f6272694db5@redhat.com>
In-Reply-To: <3ba0015b-b36e-449a-8445-0f6272694db5@redhat.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 6 Dec 2023 02:30:28 -0800
Message-ID: <CAJuCfpFPtbZuD53o+jOac97qA6MnK4jTEe5qNrZsH5v-m62oZA@mail.gmail.com>
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

On Wed, Dec 6, 2023 at 1:21=E2=80=AFAM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 05.12.23 05:46, Suren Baghdasaryan wrote:
> > On Mon, Dec 4, 2023 at 10:44=E2=80=AFAM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> >>
> >> On Mon, Dec 4, 2023 at 10:27=E2=80=AFAM David Hildenbrand <david@redha=
t.com> wrote:
> >>>
> >>> On 04.12.23 17:35, Suren Baghdasaryan wrote:
> >>>> On Mon, Dec 4, 2023 at 1:27=E2=80=AFAM Ryan Roberts <ryan.roberts@ar=
m.com> wrote:
> >>>>>
> >>>>> On 04/12/2023 04:09, Suren Baghdasaryan wrote:
> >>>>>> On Sat, Dec 2, 2023 at 2:11=E2=80=AFAM David Hildenbrand <david@re=
dhat.com> wrote:
> >>>>>>>
> >>>>>>> On 02.12.23 09:04, Ryan Roberts wrote:
> >>>>>>>> On 01/12/2023 20:47, David Hildenbrand wrote:
> >>>>>>>>> On 01.12.23 10:29, Ryan Roberts wrote:
> >>>>>>>>>> On 21/11/2023 17:16, Suren Baghdasaryan wrote:
> >>>>>>>>>>> Add tests for new UFFDIO_MOVE ioctl which uses uffd to move s=
ource
> >>>>>>>>>>> into destination buffer while checking the contents of both a=
fter
> >>>>>>>>>>> the move. After the operation the content of the destination =
buffer
> >>>>>>>>>>> should match the original source buffer's content while the s=
ource
> >>>>>>>>>>> buffer should be zeroed. Separate tests are designed for PMD =
aligned and
> >>>>>>>>>>> unaligned cases because they utilize different code paths in =
the kernel.
> >>>>>>>>>>>
> >>>>>>>>>>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> >>>>>>>>>>> ---
> >>>>>>>>>>>      tools/testing/selftests/mm/uffd-common.c     |  24 +++
> >>>>>>>>>>>      tools/testing/selftests/mm/uffd-common.h     |   1 +
> >>>>>>>>>>>      tools/testing/selftests/mm/uffd-unit-tests.c | 189 +++++=
++++++++++++++
> >>>>>>>>>>>      3 files changed, 214 insertions(+)
> >>>>>>>>>>>
> >>>>>>>>>>> diff --git a/tools/testing/selftests/mm/uffd-common.c
> >>>>>>>>>>> b/tools/testing/selftests/mm/uffd-common.c
> >>>>>>>>>>> index fb3bbc77fd00..b0ac0ec2356d 100644
> >>>>>>>>>>> --- a/tools/testing/selftests/mm/uffd-common.c
> >>>>>>>>>>> +++ b/tools/testing/selftests/mm/uffd-common.c
> >>>>>>>>>>> @@ -631,6 +631,30 @@ int copy_page(int ufd, unsigned long off=
set, bool wp)
> >>>>>>>>>>>          return __copy_page(ufd, offset, false, wp);
> >>>>>>>>>>>      }
> >>>>>>>>>>>      +int move_page(int ufd, unsigned long offset, unsigned l=
ong len)
> >>>>>>>>>>> +{
> >>>>>>>>>>> +    struct uffdio_move uffdio_move;
> >>>>>>>>>>> +
> >>>>>>>>>>> +    if (offset + len > nr_pages * page_size)
> >>>>>>>>>>> +        err("unexpected offset %lu and length %lu\n", offset=
, len);
> >>>>>>>>>>> +    uffdio_move.dst =3D (unsigned long) area_dst + offset;
> >>>>>>>>>>> +    uffdio_move.src =3D (unsigned long) area_src + offset;
> >>>>>>>>>>> +    uffdio_move.len =3D len;
> >>>>>>>>>>> +    uffdio_move.mode =3D UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES;
> >>>>>>>>>>> +    uffdio_move.move =3D 0;
> >>>>>>>>>>> +    if (ioctl(ufd, UFFDIO_MOVE, &uffdio_move)) {
> >>>>>>>>>>> +        /* real retval in uffdio_move.move */
> >>>>>>>>>>> +        if (uffdio_move.move !=3D -EEXIST)
> >>>>>>>>>>> +            err("UFFDIO_MOVE error: %"PRId64,
> >>>>>>>>>>> +                (int64_t)uffdio_move.move);
> >>>>>>>>>>
> >>>>>>>>>> Hi Suren,
> >>>>>>>>>>
> >>>>>>>>>> FYI this error is triggering in mm-unstable (715b67adf4c8):
> >>>>>>>>>>
> >>>>>>>>>> Testing move-pmd on anon... ERROR: UFFDIO_MOVE error: -16 (err=
no=3D16,
> >>>>>>>>>> @uffd-common.c:648)
> >>>>>>>>>>
> >>>>>>>>>> I'm running in a VM on Apple M2 (arm64). I haven't debugged an=
y further, but
> >>>>>>>>>> happy to go deeper if you can direct.
> >>>>>>>>>
> >>>>>>>>> Does it trigger reliably? Which pagesize is that kernel using?
> >>>>>>>>
> >>>>>>>> Yep, although very occasionally it fails with EAGAIN. 4K kernel;=
 see other email
> >>>>>>>> for full config.
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>> I can spot that uffd_move_pmd_test()/uffd_move_pmd_handle_fault=
() uses
> >>>>>>>>> default_huge_page_size(), which reads the default hugetlb size.
> >>>>>>>>
> >>>>>>>> My kernel command line is explicitly seting the default huge pag=
e size to 2M.
> >>>>>>>>
> >>>>>>>
> >>>>>>> Okay, so that likely won't affect it.
> >>>>>>>
> >>>>>>> I can only guess that it has to do with the alignment of the virt=
ual
> >>>>>>> area we are testing with, and that we do seem to get more odd pat=
terns
> >>>>>>> on arm64.
> >>>>>>>
> >>>>>>> uffd_move_test_common() is a bit more elaborate, but if we aligne=
d the
> >>>>>>> src+start area up, surely "step_count" cannot be left unmodified?
> >>>>>>>
> >>>>>>> So assuming we get either an unaligned source or an unaligned dst=
 from
> >>>>>>> mmap(), I am not convinced that we won't be moving areas that are=
 not
> >>>>>>> necessarily fully backed by PMDs and maybe don't even fall into t=
he VMA
> >>>>>>> of interest?
> >>>>>>>
> >>>>>>> Not sure if that could trigger the THP splitting issue, though.
> >>>>>>>
> >>>>>>> But I just quickly scanned that test setup, could be I am missing
> >>>>>>> something. It might make sense to just print the mmap'ed range an=
d the
> >>>>>>> actual ranges we are trying to move. Maybe something "obvious" ca=
n be
> >>>>>>> observed.
> >>>>>>
> >>>>>> I was able to reproduce the issue on an Android device and after
> >>>>>> implementing David's suggestions to split the large folio and afte=
r
> >>>>>> replacing default_huge_page_size() with read_pmd_pagesize(), the
> >>>>>> move-pmd test started working for me. Ryan, could you please apply
> >>>>>> attached patches (over mm-unstable) and try the test again?
> >>>>>
> >>>>> Yep, all fixed with those patches!
> >>>>
> >>>> Great! Thanks for testing and confirming. I'll post an updated
> >>>> patchset later today and will ask Andrew to replace the current one
> >>>> with it.
> >>>> I'll also look into the reasons we need to split PMD on ARM64 in thi=
s
> >>>> test. It's good that this happened and we were able to test the PMD
> >>>> split path but I'm curious about the reason. It's possible my addres=
s
> >>>> alignment calculations are  somehow incorrect.
> >>>
> >>> I only skimmed the diff briefly, but likely you also want to try
> >>> splitting in move_pages_pte(), if you encounter an already-pte-mapped=
 THP.
> >>
> >> Huh, good point. I might be able to move the folio splitting code into
> >> pte-mapped case and do a retry after splitting. That should minimize
> >> the additional code required. Will do and post a new set shortly.
> >> Thanks!
> >
> > Was planning to post an update today but need some more time. Will try
> > to send it tomorrow.
>
> It would be great to have tests that cover these cases (having to
> PTE-map a PMD-mapped THP, and stumbling over an already-PTE-mapped one).

Agree. Let me post the new version so that mm-unstable does not
produce these failures and will start working on covering additional
cases in the tests. The new patchset is almost ready, just finishing
final tests.

>
> --
> Cheers,
>
> David / dhildenb
>

