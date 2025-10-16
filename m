Return-Path: <linux-fsdevel+bounces-64384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A84BE4D2B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 19:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B554586167
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 17:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58A92C08C4;
	Thu, 16 Oct 2025 17:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TZSpIPKv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD7821CC71
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Oct 2025 17:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760635204; cv=none; b=DIbuC20kGb1pZ6K6tyTJvZ05lnTzIWNatej7Ah50QbZ6///G91bAZEA055ymMzR0R00VIOxJOmvWMTJ6oRDJb7t7djeh1FVD+d1/axl3dCCWLhT6DBsGsku80VRJ9pgEAVFEeV0Ms7oO5+mbAgZSOF5oSp6Bx83fowfRv1pp1Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760635204; c=relaxed/simple;
	bh=wV2nVp2Z9PJTYtTI61t8QluhPdPzWwIOzCfvg/vaIN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UtPwaRAiXAbkiLSF08lPps/N1pIfd9g/IXOnnKdwv/y5Zz5WHl0b/v99oGnvrRV15z8PhIieYCNCdCCgwdyHSxM80gWZEliY+B57S5lHnoh1ijAa+K/JIY8DVuHqI/Y+p5OiSl5fe+3gSB2fyenPlVOqpt+cf5SMa4Ouazaq3p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TZSpIPKv; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2681645b7b6so8795ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Oct 2025 10:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760635201; x=1761240001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oar3IC5PlLSvEtc/2ze2EFC5XBWzyZXV5aWJayEgfz0=;
        b=TZSpIPKvNpdslBjEAaZl5W97OupDyI51RAShrrXS97pg4qWeap0CwdqU3Jhcpd3YOU
         gcsVvfCDKILWBgULXDTTX9VhweX6SZpjeIbzrgD4j0txWrX+3ZfseO6mxdON8LxwtUUP
         6KE0uBkDU84GhqerujnaGBlNaETib59Xx6+kbRkamDgmMgDRfdeZTtYfhA/XZiSSSgrr
         3x4VPjvd1Y4xafRSMshayDoufRlMALXi4TX4fDrCkD3M/6fvXP58hKk5FqKtdfzh7oUy
         ZlTPAfCqEZU0ha+hmDD4W9wwPT8GzqKcRviAnNlI07iV6O4O7IKULndcclNnBpCRIkOh
         pyNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760635201; x=1761240001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oar3IC5PlLSvEtc/2ze2EFC5XBWzyZXV5aWJayEgfz0=;
        b=i/AjKBUU/44QtNtYVxGB+jyejdZuoHddc+uAN/F8bc8+NfI4dW+nUWkyvjZZbD+G9n
         m7Qr8y0tUZH0TOySAUnE+iWtKcFjjmMORIWHSUu16Yt+C8xpVbA/eFHsF4/aGaKRjS2q
         Y81g6+xQ5nryqbb7GlVCwftz3zmJ/B+U/kNit83lsCrXPkJnaoPr1u2x6nblQr+Jwl0K
         8jmwsSKoOv/qydrc/scdV3aQjjAwgJpQXfZK9v7lTzZZZpbRBkI6HIC7+JfO1GwBfvK/
         lxt8am8nrS/iusrA8YikNz8yWSgStAJqW6d4F6NI1m6tpS3y5goxV96qe+DS3bYZ9dF4
         jajw==
X-Forwarded-Encrypted: i=1; AJvYcCWlA7P82LD5wpzjBHDoYzztca51osKUMbFoxpIPk3CrlxTCZ8/bxlCACVtZJOJFXrNEm/lEKbjcDKGxeLXX@vger.kernel.org
X-Gm-Message-State: AOJu0YzdfmCHgck2EDWu8/lFEP2bjigeK6MskINlVZ/MN/qYJWpVc8S9
	qOvB6+4dEkRafnZcQvl7zSgka3eHegskqblsa3WarJQH7AJmOMpAzWDaK5rLsYm5L/+pJ8ixTsr
	vzryxWvqgUEjZ0HZkURESlDscETHKI4xOkL0U587a
X-Gm-Gg: ASbGncv+B1jPRIFWIIzpYwHe9WIvhYb81pja9Lk2kZTWsEcWC9LYztUwPZxnHxmqldX
	jYi/MDZoQVKbPedtzXfauZ4mzntF0utYxSEY+A0t0lENqNybR+sDIvRcM6jjgzwYO+AP4gjMSZG
	LLyZFNjcsLlOo27+PkSKH7WXkuGbKwtBai2K6in/o05yz5iRc7YlgkjKXLe5WKEdMb5psAc8y7K
	vYjtjWqM/8umSsMLei9CcUo68VhlAjfSPla0xlX6Y5ZrwTWnbh5yQp029HtEEqUgFHgN9Wl4Zms
	CR6q8BEcZySJ+tYTZhx2Ff6u
X-Google-Smtp-Source: AGHT+IGaLBYMUVA3dp2bngz8sd3zdctlajyDpg4Q5ej9rYFdWUESUT7d4RcwGFB4ciRjNT7T8e6kC8pvy75+YgR2Dh8=
X-Received: by 2002:a17:902:fc87:b0:290:cd63:e922 with SMTP id
 d9443c01a7336-290cd63eff9mr828755ad.15.1760635200981; Thu, 16 Oct 2025
 10:20:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013235259.589015-1-kaleshsingh@google.com>
 <20251013235259.589015-2-kaleshsingh@google.com> <144f3ee6-1a5f-57fc-d5f8-5ce54a3ac139@google.com>
 <CAC_TJvdLxPRC5r+Ae+h2Zmc68B5+s40+413Xo4SjvXH2x2F6hg@mail.gmail.com> <af0618c0-03c5-9133-bb14-db8ddb72b8de@google.com>
In-Reply-To: <af0618c0-03c5-9133-bb14-db8ddb72b8de@google.com>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Thu, 16 Oct 2025 10:19:49 -0700
X-Gm-Features: AS18NWDUcYhiaJ_iuWpblZjVBlLRKBf3hDw80qWBei6Spqkt0F1pWUwG8jn-Ias
Message-ID: <CAC_TJvdy4qCaLAW09ViC5vPbj4XC7_P+9Jjj_kYSU6d+=r70yw@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] mm: fix off-by-one error in VMA count limit checks
To: Hugh Dickins <hughd@google.com>
Cc: akpm@linux-foundation.org, minchan@kernel.org, lorenzo.stoakes@oracle.com, 
	david@redhat.com, Liam.Howlett@oracle.com, rppt@kernel.org, pfalcato@suse.de, 
	kernel-team@android.com, android-mm@google.com, stable@vger.kernel.org, 
	SeongJae Park <sj@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Jann Horn <jannh@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, 
	Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 10:05=E2=80=AFPM Hugh Dickins <hughd@google.com> wr=
ote:
>
> On Tue, 14 Oct 2025, Kalesh Singh wrote:
> > On Mon, Oct 13, 2025 at 11:28=E2=80=AFPM Hugh Dickins <hughd@google.com=
> wrote:
> > >
> > > Sorry for letting you go so far before speaking up (I had to test wha=
t
> > > I believed to be true, and had hoped that meanwhile one of your many
> > > illustrious reviewers would say so first, but no): it's a NAK from me=
.
> > >
> > > These are not off-by-ones: at the point of these checks, it is not
> > > known whether an additional map/vma will have to be added, or the
> > > addition will be merged into an existing map/vma.  So the checks
> > > err on the lenient side, letting you get perhaps one more than the
> > > sysctl said, but not allowing any more than that.
> > >
> > > Which is all that matters, isn't it? Limiting unrestrained growth.
> > >
> > > In this patch you're proposing to change it from erring on the
> > > lenient side to erring on the strict side - prohibiting merges
> > > at the limit which have been allowed for many years.
> > >
> > > Whatever one thinks about the merits of erring on the lenient versus
> > > erring on the strict side, I see no reason to make this change now,
> > > and most certainly not with a Fixes Cc: stable. There is no danger
> > > in the current behaviour; there is danger in prohibiting what was
> > > allowed before.
> > >
> > > As to the remainder of your series: I have to commend you for doing
> > > a thorough and well-presented job, but I cannot myself see the point =
in
> > > changing 21 files for what almost amounts to a max_map_count subsyste=
m.
> > > I call it misdirected effort, not at all to my taste, which prefers t=
he
> > > straightforward checks already there; but accept that my taste may be
> > > out of fashion, so won't stand in the way if others think it worthwhi=
le.
> >
> > Hi Hugh,
> >
> > Thanks for the detailed review and for taking the time to test the beha=
vior.
> >
> > You've raised a valid point. I wasn't aware of the history behind the
> > lenient check for merges. The lack of a comment, like the one that
> > exists for exceeding the limit in munmap(), led me to misinterpret
> > this as an off-by-one bug. The convention makes sense if we consider
> > potential merges.
>
> Yes, a comment there would be helpful (and I doubt it's worth more
> than adding a comment); but I did not understand at all, Liam's
> suggestion for the comment "to state that the count may not change".
>
> >
> > If it was in-fact the intended behavior, then I agree we should keep
> > it lenient. It would mean though, that munmap() being able to free a
> > VMA if a split is required (by permitting exceeding the limit by 1)
> > would not work in the case where we have already exceeded the limit. I
> > find this to be inconsistent but this is also the current behavior ...
>
> You're saying that once we go one over the limit, say with a new mmap,
> an munmap check makes it impossible to munmap that or any other vma?
>
> If that's so, I do agree with you, that's nasty, and I would hate any
> new code to behave that way.  In code that's survived as long as this
> without troubling anyone, I'm not so sure: but if it's easily fixed
> (a more lenient check at the munmap end?) that would seem worthwhile.
>
> Ah, but reading again, you say "if a split is required": I guess
> munmapping the whole vma has no problem; and it's fine for a middle
> munmap, splitting into three before munmapping the middle, to fail.
> I suppose it would be nicer if munmaping start or end succeeeded,
> but I don't think that matters very much in this case.
>

Yes, your understanding is correct. I meant that currently, we allow
for an munmap() requiring a single split to succeed even if it will
temporarily exceed the limit by one, as immediately after we will be
removing one of those VMAs. However, if the process has already
exceeded the limit, say, due to a non-merging mmap(), then an munmap()
requiring a split will fail. It's not a big issue, but I found it
inconsistent that this succeeds in some cases and not in others.

> >
> > I will drop this patch and the patch that introduces the
> > vma_count_remaining() helper, as I see your point about it potentially
> > being unnecessary overhead.
> >
> > Regarding your feedback on the rest of the series, I believe the 3
> > remaining patches are still valuable on their own.
> >
> >  - The selftest adds a comprehensive tests for VMA operations at the
> > sysctl_max_map_count limit. This will self-document the exact behavior
> > expected, including the leniency for potential merges that you
> > highlighted, preventing the kind of misunderstanding that led to my
> > initial patch.
> >
> >  - The rename of mm_struct->map_count to vma_count, is a
> > straightforward cleanup for code clarity that makes the purpose of the
> > field more explicit.
> >
> >  - The tracepoint adds needed observability for telemetry, allowing us
> > to see when processes are failing in the field due to VMA count limit.
> >
> > The  selftest, is what  makes up a large portion of the diff you
> > sited, and with vma_count_remaining() gone the series will not touch
> > nearly as many files.
> >
> > Would this be an acceptable path forward?
>
> Possibly, if others like it: my concern was to end a misunderstanding
> (I'm generally much too slow to get involved in cleanups).
>
> Though given that the sysctl is named "max_map_count", I'm not very
> keen on renaming everything else from map_count to vma_count
> (and of course I'm not suggesting to rename the sysctl).

I still believe vma_count is a clearer name for the field, given some
existing comments already refer to it as vma count. The inconsistency
between vma_count and sysctl_max_map_count can be abstracted away; and
the sysctl made non-global.
I'll wait for feedback form others on how to proceed.

Thanks for the thorough review and discussion.

-- Kalesh

>
> Hugh

