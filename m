Return-Path: <linux-fsdevel+bounces-64342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E1634BE17DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 07:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 795894ED40E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 05:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4F92A1CF;
	Thu, 16 Oct 2025 05:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BPE3gqlm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893F321CC7B
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Oct 2025 05:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760591137; cv=none; b=sjq83JpvB+P1ofVsajACu5yzxzhTHtymKolzd4GsSClvT4Y9uLVG5QUbRex/p1JnKywOhpRuJ9RirePLeScZY3gOVVCwTtWYVljs/YITun8F1A/vIXtdpXiQbJoSDgwbfbVDTLPjlBKowtyinddlgRKCy7+Izd+0BDZ3PdnMN4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760591137; c=relaxed/simple;
	bh=v/niRFXGHLbuHdz9SVJ/KCn6aLK8QZaKQTmiLUVJvaw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GoWcpv8tLyOGKUFG/Rj6b42xbHu4/uhRXo4xMf3FsaNYiK0hMa5oNDeoORRs+EXXCZDDCSKZ22lAuK/zjDD2H6hPv4YOWaJHCXACokJXt/aG9Ze64pznB7M1FpjFp+8MDoq5jN6Wfb7ed5YO9clotVWWZJBvWkHiSlo0jtK+ADA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BPE3gqlm; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-781421f5bf5so3389037b3.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 22:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760591134; x=1761195934; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SL78+SZbXELe5OjpiYZ40otsTW6VBbAoBUm1tT/or+E=;
        b=BPE3gqlmQf+4JlGxMT7EW2MW0GM5EFCnc6GDMGjXh/G5oRjtztsh9oMVU00h20CBqQ
         IyY1rF330o3VZzVb7qjj6NltbD9EvEYrxoqcF2fQDhMyFzsGcBmTE7WObD6P+viqa85U
         v5QBqzupTD4aoxHlK1kEsFk+D3AyHMYoP9S0yV5tiPXymD82uR4Fwh67Uj98fbrs4wsd
         xU5Ao4N24rPCeJVVnmbXKrX1wfHcsRRJdCEjbD6CGEDlY2KELLYAG/P0gp01BWBj5k/G
         31dAxzlFE6XmcxHpAYtcr1M+LHdyskdXQovGGS6rqX7n0/+Qj7NUDYEAuTJYrA2lbzVO
         ZasQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760591134; x=1761195934;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SL78+SZbXELe5OjpiYZ40otsTW6VBbAoBUm1tT/or+E=;
        b=QIZns4sdnr/FcdvYesN9V/GjaI6XdjVHqS+lKV9pei/rGx9TccF6upspbcKq3ZVqnz
         SPC4B9yDFuAi4j6nMG23uKp6+Pv6NOoMmrH7O7g/fDcIBKfaOWXJUOh2Pl6upAqxaMZA
         peZ24nXv3G1GQV9UsYs3uEHB8rAy26U3dJwPwlmL88XEOvO5TpTlkwcJ9nnIhIhpm4xM
         pR4jupkA1NrTspXLqu3czW0FW+8+q/mrYw9eLhBsIExTKQj233vwMevlyO2WER0lnSiu
         fMoA/1csuKdWAmAluu+GfrvIXo6f9+fUX14JbusWtji9aJ5XwqC3yVinTndLTQN+AhFT
         90bg==
X-Forwarded-Encrypted: i=1; AJvYcCVdwjnD6Vqh4M4bmx9aDCKQuEKAemqhYn+grEZ11SRQnlUoBLiANxWgg8blVJ7nEXsOElGEOb1BD4CZ+lQR@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4gg+A8zGW4HIVTabZVplymXU7CkP/r/ybR66hYp8x5yOYy5cB
	vpUAzgDA2UuEuCwOKqxLyrfqJapB6aH1QJr8ShlevV1WhDlomb082PoHvuCHhMMtuA==
X-Gm-Gg: ASbGncv9dUMB1bIl6izv/MA0+wL+VBg5Jild0SApnR/ZV07LrZs+MbOk0juF1C2C960
	Xp2VmbvkS4PiZWlCvnk54RcvM9xmY4YZDRnTwziVMd0fyF6x7Xcu8YhkQDxedb7FpR08cAIeGln
	ApK7FiM3lCxjnDCE0QzGAfAhSkxhiD7dPS2mdiX6R/saB+rjmIdzXlJvvcFgwJhCyq3BPGn7lBN
	GwtIfO+0waorDxS2njdkHpufDv/dUdkizJKzPcostDEcfmFf1+hXvpRncKjDxwHabbMWbV70qSh
	l6+PuLxFrDgnQPPtcNSLTKCoe+77jBMXPkP81ktKosI6SxabNUDxL74+RDbvGCTESk/yZP2nI4o
	XMt+X8xu7WLwyZdHhrDhis94P7m2O1UgWiHTsH6yWs/wDbXdm6z/dsXYSgK71kVwLmWoTmHed64
	O4FFTpY6wnt6S8pWKWGbSGrYVzR/qkYAeYZwQaxasLApPs/qWPnl1C8T9sknChWxQwMEx7r68Sb
	aZuhHrYREVHeHU=
X-Google-Smtp-Source: AGHT+IGKHjTCfZs9WliaOHICesM+L1X3EuoBynLJInRo210xgEeIFS6mewEtS3BfqWgQnxUg9wNNRQ==
X-Received: by 2002:a05:690c:670b:b0:783:116b:fc5 with SMTP id 00721157ae682-783116b1024mr9954377b3.33.1760591134146;
        Wed, 15 Oct 2025 22:05:34 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7828d7b9deesm4928007b3.26.2025.10.15.22.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 22:05:32 -0700 (PDT)
Date: Wed, 15 Oct 2025 22:05:20 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Kalesh Singh <kaleshsingh@google.com>
cc: Hugh Dickins <hughd@google.com>, akpm@linux-foundation.org, 
    minchan@kernel.org, lorenzo.stoakes@oracle.com, david@redhat.com, 
    Liam.Howlett@oracle.com, rppt@kernel.org, pfalcato@suse.de, 
    kernel-team@android.com, android-mm@google.com, stable@vger.kernel.org, 
    SeongJae Park <sj@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
    Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
    Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, 
    Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
    Jann Horn <jannh@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
    Masami Hiramatsu <mhiramat@kernel.org>, 
    Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
    Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
    Juri Lelli <juri.lelli@redhat.com>, 
    Vincent Guittot <vincent.guittot@linaro.org>, 
    Dietmar Eggemann <dietmar.eggemann@arm.com>, 
    Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
    Valentin Schneider <vschneid@redhat.com>, Shuah Khan <shuah@kernel.org>, 
    linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
    linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
    linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 1/5] mm: fix off-by-one error in VMA count limit
 checks
In-Reply-To: <CAC_TJvdLxPRC5r+Ae+h2Zmc68B5+s40+413Xo4SjvXH2x2F6hg@mail.gmail.com>
Message-ID: <af0618c0-03c5-9133-bb14-db8ddb72b8de@google.com>
References: <20251013235259.589015-1-kaleshsingh@google.com> <20251013235259.589015-2-kaleshsingh@google.com> <144f3ee6-1a5f-57fc-d5f8-5ce54a3ac139@google.com> <CAC_TJvdLxPRC5r+Ae+h2Zmc68B5+s40+413Xo4SjvXH2x2F6hg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463770367-1513627236-1760591132=:18627"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463770367-1513627236-1760591132=:18627
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 14 Oct 2025, Kalesh Singh wrote:
> On Mon, Oct 13, 2025 at 11:28=E2=80=AFPM Hugh Dickins <hughd@google.com> =
wrote:
> >
> > Sorry for letting you go so far before speaking up (I had to test what
> > I believed to be true, and had hoped that meanwhile one of your many
> > illustrious reviewers would say so first, but no): it's a NAK from me.
> >
> > These are not off-by-ones: at the point of these checks, it is not
> > known whether an additional map/vma will have to be added, or the
> > addition will be merged into an existing map/vma.  So the checks
> > err on the lenient side, letting you get perhaps one more than the
> > sysctl said, but not allowing any more than that.
> >
> > Which is all that matters, isn't it? Limiting unrestrained growth.
> >
> > In this patch you're proposing to change it from erring on the
> > lenient side to erring on the strict side - prohibiting merges
> > at the limit which have been allowed for many years.
> >
> > Whatever one thinks about the merits of erring on the lenient versus
> > erring on the strict side, I see no reason to make this change now,
> > and most certainly not with a Fixes Cc: stable. There is no danger
> > in the current behaviour; there is danger in prohibiting what was
> > allowed before.
> >
> > As to the remainder of your series: I have to commend you for doing
> > a thorough and well-presented job, but I cannot myself see the point in
> > changing 21 files for what almost amounts to a max_map_count subsystem.
> > I call it misdirected effort, not at all to my taste, which prefers the
> > straightforward checks already there; but accept that my taste may be
> > out of fashion, so won't stand in the way if others think it worthwhile=
=2E
>=20
> Hi Hugh,
>=20
> Thanks for the detailed review and for taking the time to test the behavi=
or.
>=20
> You've raised a valid point. I wasn't aware of the history behind the
> lenient check for merges. The lack of a comment, like the one that
> exists for exceeding the limit in munmap(), led me to misinterpret
> this as an off-by-one bug. The convention makes sense if we consider
> potential merges.

Yes, a comment there would be helpful (and I doubt it's worth more
than adding a comment); but I did not understand at all, Liam's
suggestion for the comment "to state that the count may not change".

>=20
> If it was in-fact the intended behavior, then I agree we should keep
> it lenient. It would mean though, that munmap() being able to free a
> VMA if a split is required (by permitting exceeding the limit by 1)
> would not work in the case where we have already exceeded the limit. I
> find this to be inconsistent but this is also the current behavior ...

You're saying that once we go one over the limit, say with a new mmap,
an munmap check makes it impossible to munmap that or any other vma?

If that's so, I do agree with you, that's nasty, and I would hate any
new code to behave that way.  In code that's survived as long as this
without troubling anyone, I'm not so sure: but if it's easily fixed
(a more lenient check at the munmap end?) that would seem worthwhile.

Ah, but reading again, you say "if a split is required": I guess
munmapping the whole vma has no problem; and it's fine for a middle
munmap, splitting into three before munmapping the middle, to fail.
I suppose it would be nicer if munmaping start or end succeeeded,
but I don't think that matters very much in this case.

>=20
> I will drop this patch and the patch that introduces the
> vma_count_remaining() helper, as I see your point about it potentially
> being unnecessary overhead.
>=20
> Regarding your feedback on the rest of the series, I believe the 3
> remaining patches are still valuable on their own.
>=20
>  - The selftest adds a comprehensive tests for VMA operations at the
> sysctl_max_map_count limit. This will self-document the exact behavior
> expected, including the leniency for potential merges that you
> highlighted, preventing the kind of misunderstanding that led to my
> initial patch.
>=20
>  - The rename of mm_struct->map_count to vma_count, is a
> straightforward cleanup for code clarity that makes the purpose of the
> field more explicit.
>=20
>  - The tracepoint adds needed observability for telemetry, allowing us
> to see when processes are failing in the field due to VMA count limit.
>=20
> The  selftest, is what  makes up a large portion of the diff you
> sited, and with vma_count_remaining() gone the series will not touch
> nearly as many files.
>=20
> Would this be an acceptable path forward?

Possibly, if others like it: my concern was to end a misunderstanding
(I'm generally much too slow to get involved in cleanups).

Though given that the sysctl is named "max_map_count", I'm not very
keen on renaming everything else from map_count to vma_count
(and of course I'm not suggesting to rename the sysctl).

Hugh
---1463770367-1513627236-1760591132=:18627--

