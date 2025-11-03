Return-Path: <linux-fsdevel+bounces-66865-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDA3C2E7F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 00:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D281189AF40
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 23:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF1830E846;
	Mon,  3 Nov 2025 23:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QVEsPW/j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACE32FE582
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Nov 2025 23:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762214323; cv=none; b=H1JaxWKif27YDaF431j7y0eD/8tGqyNLmEFG9pi2PEU6fEIPa/WDtQJE7VaTAOFE/BTixdTNMENjpK6DDmLgOdzOKDwitaafxFry2M1MS1vBMJYnG7Z4YeLj6qjBbOUN/MNnxjzlZK1ibjSzrFIIj9xyqJQmFMi3mA7NBAugOGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762214323; c=relaxed/simple;
	bh=+GjPBbS4tzsC0uAErgpZoYbDYAoVZCtoNhVMyqS5aak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fYBsAkRACZvMLcT2Fy0VEX/+g7gPtfIA4ELR12yzvksHkAnNRxeStp9768Bd1M83YNrn+S3PpLrRdlVlY950pXr54BxFbpHzsBH7xmvvHhehdaZJ1Ry05clFF1rsDTYeNrn1l8b6Stoy1Mx0RE40TitHQSkO2vO+j9q/uiC7BD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QVEsPW/j; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-295c64cb951so93565ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Nov 2025 15:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762214321; x=1762819121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UiaumAf9uKaq/47KUh0x3Zq3WXVBAjDWrX0gtHKtIa0=;
        b=QVEsPW/jD/HZgfftOEifqiw5dvFekHCVoADUXunIIMxI9umfm3yHkT4hKw3qZeQqUN
         UNTIFYDGE/amfzXM06cR7QWGGIIcwqsWQ1szWPdUlKW8wJCtYMRyzUbtAN1iIaOcdXdy
         Rv8Ghrxeo8ftSL/5tMAosiYzL7G+zL0SMNuYdGC3dlzQn/hdO4hj753g+u656QqtW7yI
         88t9CpLjJZyikwbPPHXokowV7Dm/jBQucMCKOcnTBEUiAHEAKiMtj1r5TytMqSv96cum
         IDNWlXpOhIzQEnZ/NoQ+n5gk6ZGBC8QqqBzP3xYM1n98AN9nrpvBcU/hSkvIE6f5NaIZ
         rRTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762214321; x=1762819121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UiaumAf9uKaq/47KUh0x3Zq3WXVBAjDWrX0gtHKtIa0=;
        b=JkyhzrIuT4YmyHKg/DT6+l+cV594694L0WnX9sCI+n+aKAFZJN5qZPMzSH1X0/iiTY
         OF4WmTcKdCMUCIX+yOlBXodt6IDvLgV4WhxrTN0QpKm0MovHYCrnwDR9LU+aspZlx9Os
         M8vu7Awyfn6vwFkC6Nw0l525gYAWTJxXuj0RNUlrS9/OPKS6jQGLFXHvuN19YY0s/iDM
         +m/7wAkQZV6PQhvFrDW5lyUAMU6UKGhoVKz/0TzHtlEHBId4et7w+Go3cY7rhi/uxWPy
         B5zy+USVGMj1z/y3ro+SLHeeGruq8BjVQuG2iT3EUJ6TnqIacpBcXqk8MuSLrctbg719
         6cmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLP/OTGWSlBjemz8VJb5RLUGFP0TBTfrYWu4qkQo6iaU+HWpGnvfV2f8Q5dqVYE+vp8vS425QRV7MS5NPZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzIEFw+rxER4PgL9ae5oeLd8ulRMPrfE2j83qXA4vsGjsmYYXUt
	ktmvcdTbwucXWHtTpYYXqe0JbZBCybDGa8QV+N8otBJMJhOog/bglzD5p0MRCH5foizv/U2YIaX
	HrczWOgVtOspHvcqc6jgUNHE380K5xBY7XVo8QX2x
X-Gm-Gg: ASbGncth7H9fUxJGGSs1oEPHrA+LL8FZxdaJSMIiVAmXjvrlMyyjglnyY/+PJ+lMVMu
	Rf7XfFya4RdPLJszX31O8iZ1iJnxzk3zaFuGnA9QjYlXLaNduPsazqpl3rbA33pgktptzKzNUrh
	dY5h2a47bXT/jfknt7yKk1+X5jf/DCK5qzcFhI40faJB/Ejwu+4TiMtaTDt9I2k9Y6lQrYmwuLh
	YTubjWzFINSV4NsvLfFlrnbcfZqYuOXzvd5kwC6TBcwtiNvAruk/rxs9n1SLqEDW/ZEhUgdmdDd
	9MJiyRhsY3QujMqrXTJa4xFkxwI=
X-Google-Smtp-Source: AGHT+IHt6j/O2+BVT8RrxCXQhlHMInI33IDskTKx+bVIyN+3SBdebf/1pf/skkswodcwqLLeaarZnJrY3sFQZRZnnO4=
X-Received: by 2002:a17:902:ec81:b0:290:d7fd:6297 with SMTP id
 d9443c01a7336-295fd265e91mr2024145ad.2.1762214320623; Mon, 03 Nov 2025
 15:58:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028212528.681081-1-kaleshsingh@google.com>
 <20251028212528.681081-3-kaleshsingh@google.com> <6c34ce4e-1212-4dd0-8b7c-6af952dda3cb@kernel.org>
In-Reply-To: <6c34ce4e-1212-4dd0-8b7c-6af952dda3cb@kernel.org>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Mon, 3 Nov 2025 15:58:28 -0800
X-Gm-Features: AWmQ_blqxq78jLq4HTBbisYrdSqGuPCxohmpOKASM-NgBeXlVoTSRESehr_wOXs
Message-ID: <CAC_TJvf+KwdFF3BO1bO2Jje1igbbM4pdy3-V5rY+fdciwmUEfA@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] mm/selftests: add max_vma_count tests
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: akpm@linux-foundation.org, minchan@kernel.org, lorenzo.stoakes@oracle.com, 
	david@redhat.com, Liam.Howlett@oracle.com, rppt@kernel.org, pfalcato@suse.de, 
	rostedt@goodmis.org, hughd@google.com, kernel-team@android.com, 
	android-mm@google.com, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Jann Horn <jannh@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 9:13=E2=80=AFAM David Hildenbrand (Red Hat)
<david@kernel.org> wrote:
>
> On 28.10.25 22:24, Kalesh Singh wrote:
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
>
> [...]
>
> No capacity to review the tests in detail :(

Appreciate you taking a look :)

>
> > +
> > diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/=
selftests/mm/run_vmtests.sh
> > index d9173f2312b7..a85db61e6a92 100755
> > --- a/tools/testing/selftests/mm/run_vmtests.sh
> > +++ b/tools/testing/selftests/mm/run_vmtests.sh
> > @@ -49,6 +49,8 @@ separated by spaces:
> >       test madvise(2) MADV_GUARD_INSTALL and MADV_GUARD_REMOVE options
> >   - madv_populate
> >       test memadvise(2) MADV_POPULATE_{READ,WRITE} options
> > +- max_vma_count
> > +     tests for max vma_count
> >   - memfd_secret
> >       test memfd_secret(2)
> >   - process_mrelease
> > @@ -426,6 +428,9 @@ fi # VADDR64
> >   # vmalloc stability smoke test
> >   CATEGORY=3D"vmalloc" run_test bash ./test_vmalloc.sh smoke
> >
> > +# test operations against max vma count limit
> > +CATEGORY=3D"max_vma_count" run_test ./max_vma_count_tests
>
> I'd just call it CATEGORY=3D"vma" or "vma_handling".
>
> Which makes me wodnering whether "vma_merge" falls into the same category=
.
>
> Smalls like mremap test is similar.
>
> Point is that "CATEGORY" stops being really useful if we end up having a
> separate category for each test, right? :)

I agree making both use a "vma" category seem more helpful. I'll wait
for others' feedback before resending.

Thanks,
Kalesh
>
> --
> Cheers
>
> David

