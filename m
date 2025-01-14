Return-Path: <linux-fsdevel+bounces-39121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4064A10282
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 09:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B99C6164793
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 08:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BA628EC61;
	Tue, 14 Jan 2025 08:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o9F2GWD7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57376284A75
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 08:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736845163; cv=none; b=gyiY1SfQEri378Qm7iHuGK5g3+m1l4bzh+aOs4ko7x7aBTfMuRzyz/9mo9TyOzrvXSE+jqKbtE8Pwfnh3QXSnP6EmRdkYJ2fOEGMaf8qHO/h7oGY0sN1rHdB0MeRs5WWcom5WX2n3ib8keeH3uk2Gck+gzyQ46vofFJXeffH05U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736845163; c=relaxed/simple;
	bh=X7CRPxR/Gj7N+XoABpeS3s3Vtw/1BQPH+MuT9frEswo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sUPwOAySV2Eo4ILwgCKnQA+Fo3MQfQNSVfz+RSExnqXO7tZLkaj2Nmh2HuEWhVEGIAnj18zrBqyzkfNGUnj0W5zwVsIZR9SrLkOKXgBdNCrbVXStB1Wp5MWSbKkir2HrEgOTRee0AuJwvmk10TUUttciofpNgwFDcq/+kzRehj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o9F2GWD7; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3061513d353so25007121fa.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 00:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736845159; x=1737449959; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U8HXJRKnTZGboy95pO/9JnjE6Jd71KaWxJVmRTB2UL8=;
        b=o9F2GWD7l8SoQp8nDA0NNrdyZbXXoreEP+mU4Vl05HD001Ci1hJFzsBR8fSAgDfpU8
         P+a1rocW4Nv4l27WRNMzNhb2zNoUEP4ifIoAU75tM5ZOLRlE9aLazrT+RPNkB8S5BVx7
         C7Zi5ebMCgTMDYBv2I+nmcNGmvST2X3Iq52NHHQpWnZUBRaQn2xdFqdEXjpEdl0mD9tq
         pB/Iu/XJ2rPUZGK82zX6396P1yjQ8t6UyHA9Ma1YTYrIMHXSbnui8lMNN5yVrQcDkmO/
         hgu1V9PSgWbZC7kafa0zyMxkl+yroyGVihL8UQVTS5HQ4pJ7DToktmzhiDCa3EY1/Tbn
         BC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736845159; x=1737449959;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U8HXJRKnTZGboy95pO/9JnjE6Jd71KaWxJVmRTB2UL8=;
        b=awSDdjPzs9a5jlxQHeJyGEiWzl4SgWPTEtgPkhNBgvzRhyd29pR17i/1yzF7j5i5Js
         NUsp2N0WbGG1ak9N+CyYKanpjZ9WQPSs67VmNaxhLa5dZ54VpYj+3oNZum5+bqu7wpk3
         maVHZwCefVsK0pq7yOnODQ+jXkoPuEXIhBUO/A2AqNkU0Ebvi2mKFXQb+E2r5eIQn2iG
         sgD8/5wSIuEjGVymcXR4u+oh8TGjkxChIfGzZMJvIPox5IeFoKaUhpcFkbAkRvzD2iWp
         2b5TEb9yfcTCRFhA1FGqDiQhwDCACYpJiNm/hqtn0byAL3a6SGNkrh8KxRQzULxUCkYJ
         Gi4A==
X-Forwarded-Encrypted: i=1; AJvYcCUakLgAr2xSSjjruSwNRN6sE6kGt8IQ6N8D6X+41E2quaPC/+1TRCP8UwrCH4/TlrA8tdC9U6G0Of9Fngwl@vger.kernel.org
X-Gm-Message-State: AOJu0YwiNQ0rvvVm+Mzfrq4EsO9CDCjkO+fSXdhcClDfi9YFGTb0ErMq
	mjavug5+bZllHxYRxHjlJxtsIj4qyJZIEG/ll7oDMbeuzID86AFioYskp8HZzPtp1hbguwUxZTi
	IYIoUyt9q+VXCQJJvUSGVjIz2OfLJJDyaCBa8
X-Gm-Gg: ASbGncuOZloMa+kUP8b9XAaXSBqC1jd0PCYcxJ1HzLBJ9AALDgxPj61UG8YWOCKFHC8
	wTO2W7bFz9XPsCI+nXki4PsKfHYPzOn8eaDpYEXd0qd+Go9TNe+5tmKtb2f7O3QHqnPpOHQ==
X-Google-Smtp-Source: AGHT+IFZmkyK832OVNDKmKWyEqMKNHphvQbXtOzmBD/mb3nOKjYlKwBMr12/4F69kOBsaRcRDHREk+6fMKjQZAEjt+w=
X-Received: by 2002:a05:651c:1504:b0:300:33b1:f0d7 with SMTP id
 38308e7fff4ca-305f459a922mr73594371fa.5.1736845159331; Tue, 14 Jan 2025
 00:59:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <42BD15B5-3C6C-437E-BF52-E22E6F200513@m.fudan.edu.cn>
 <20250113-herzhaft-desolat-e4d191b82bdf@brauner> <Z4U89Wfyaz2fLbCt@casper.infradead.org>
 <20250113180830.GM6156@frogsfrogsfrogs>
In-Reply-To: <20250113180830.GM6156@frogsfrogsfrogs>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 14 Jan 2025 09:59:08 +0100
X-Gm-Features: AbW1kvZMHdcSEpp-qzmxny6EDpOp3_L2wFrabqRDE2H8VBwWPR25zAkiQFkWt4o
Message-ID: <CACT4Y+ZJawZEAxsygR8tH=CcOBiVRaVt+RdzwhHYfZYHQdcHdg@mail.gmail.com>
Subject: Re: Bug: INFO_ task hung in lock_two_nondirectories
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, Christian Brauner <brauner@kernel.org>, 
	Kun Hu <huk23@m.fudan.edu.cn>, Andrey Konovalov <andreyknvl@gmail.com>, jack@suse.cz, 
	jlayton@redhat.com, tytso@mit.edu, adilger.kernel@dilger.ca, 
	david@fromorbit.com, bfields@redhat.com, viro@zeniv.linux.org.uk, 
	christian.brauner@ubuntu.com, hch@lst.de, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 Jan 2025 at 19:08, Darrick J. Wong <djwong@kernel.org> wrote:
>
> On Mon, Jan 13, 2025 at 04:19:01PM +0000, Matthew Wilcox wrote:
> > On Mon, Jan 13, 2025 at 03:38:57PM +0100, Christian Brauner wrote:
> > > On Sun, Jan 12, 2025 at 06:00:24PM +0800, Kun Hu wrote:
> > > > Hello,
> > > >
> > > > When using our customized fuzzer tool to fuzz the latest Linux kernel, the following crash (43s)
> > > > was triggered.
> > >
> > > I think we need to come to an agreement at LSFMM or somewhere else that
> > > we will by default ingore but reports from non-syzbot fuzzers. Because
> > > we're all wasting time on them.
>
> No need to wait until LSFMM, I already agree with the premise of
> deprioritizing/ignoring piles of reports that come in all at once with
> very little analysis, an IOCCC-esque reproducer, and no effort on the
> part of the reporter to do *anything* about the bug.

+1

It would be good to publish it somewhere on kernel.org (Documentation/
or people.kernel.org).
We could include the link to our guidelines for external reporters
(where we ask to not test old kernels, reporting dups, not including
essential info, and other silly things):
https://github.com/google/syzkaller/blob/master/docs/linux/reporting_kernel_bugs.mdThere
is unfortunately no way to make people read all docs on the internet
beforehand, but at least it's handy to have a link to an existing doc
to give to people.

> While the Google syzbot dashboard has improved remarkably since 2018,
> particularly in the past couple of years, thanks to the people who did
> that!  It's nice that I can fire off patches at the bot and it'll test
> them.  That said, I don't perceive Google management to be funding much
> of anyone to solve the problems that their fuzzer uncovers.
>
> This is to say nothing of the people who are coyly running their own
> instances of syzbot sans dashboard and expecting me to download random
> crap from Google Drive.  Hell no, I don't do that kind of thing in 2025.
>
> > I think it needs to be broader than that to also include "AI generated
> > bug reports" (while not excluding AI-translated bug reports); see
> >
> > https://daniel.haxx.se/blog/2024/01/02/the-i-in-llm-stands-for-intelligence/
> >
> > so really, any "automated bug report" system is out of bounds unless
> > previously arranged with the developers who it's supposed to be helping.
>
> Agree.  That's been my stance since syzbot first emerged in 2017-18.
>
> > We need to write that down somewhere in Documentation/process/ so we
> > can point misguided people at it.
> >
> > We should also talk about how some parts of the kernel are basically
> > unmaintained and unused, and that automated testing should be focused
> > on parts of the kernel that are actually used.  A report about being
> > able to crash a stock configuration of ext4 is more useful than being
> > able to crash an unusual configuration of ufs.
>
> Or maybe we should try to make fuse + iouring fast enough that we can
> kick all these old legacy drivers out to userspace. ;)
>
> > Distinguishing between warnings, BUG()s and actual crashes would also
> > be a useful thing to put in this document.
>
> Yes.  And also state that panic_on_warn=1 is a signal that you wanted
> fail(over) fast mode.
>
> --D

