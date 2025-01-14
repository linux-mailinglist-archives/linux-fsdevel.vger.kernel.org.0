Return-Path: <linux-fsdevel+bounces-39123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC416A102D4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 10:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A139B1887B05
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 09:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D24622DC4B;
	Tue, 14 Jan 2025 09:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="axDTZv9u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50F722DC22
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 09:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736846143; cv=none; b=AHAm7eGlbtFUNCktHN8j6x0cOvHPyWo/diMoY4GdbLHDVhhPeyBYfK0o4m3bg80Szj4XA1btj0z+uUCpkA35tIy7TC9wemdf+h0M/extJhM4AbFzWxqatA1fhmsmdooWEXfG9x2+cq7VENY1TdKc2s+i4VqqNox15LRyxUOZaOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736846143; c=relaxed/simple;
	bh=rDh9eh0kYeMAJG41fHofk0sbVUDz4s+QhR8WZeIbnAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LC7LTHJp2pP7eQYEtamGw2cROMaGiG1csyKc3nHhH+Deq4dyEmx/0wXbG605/5C3YEdDKBauYhUZEMnKeJhNmEKZKh7Lw3K+QzG1nq9oIWaleo9H2+mvaIs4fUYEURnw8G6XJLE8xV4ayZb3t5SFhAs+Ykv/6z4I629GFuWYSOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=axDTZv9u; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30613037309so25635451fa.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 01:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736846140; x=1737450940; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PU9jDjS3EKreNh/3y7h/s76+QMb8kIneaatpj3HfJJ8=;
        b=axDTZv9ukqaLg82LJTkI8MS64hvdlgA44UVmwlFGS+uZmqaGu0z1DLz8RB9VHS/TJH
         D4mESSfKD7b2uc2fmDQTx1h1BBk3oVpxuTNKOqKPJ8FkiRe2/R3cxBcdS7gGf3gOEYbf
         /iMOsux43MqMIjdDG760QQk3yR3IDanfLfWi1VZUvIezYhM4qdjyPAsUsb7TB8r7w5ve
         w7oWQY2pSLe9AXAq6159jzTwFUkpv0m/rmroQtAjXIBDUYdA29PoSeXrxUMo2VXCGWyp
         OlJ8/eWScD/sAny8LQZGUTiccD+LIijHlieWOpKKviXfdQZ6J5/32spjWhq7uOKl4Ge4
         iJjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736846140; x=1737450940;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PU9jDjS3EKreNh/3y7h/s76+QMb8kIneaatpj3HfJJ8=;
        b=n7pEGs0acgzskW0jxlr3dNPkkUzgJME/pQzijMJaFafW5IlHFBEc5TYVTL03kv93Ts
         25O8CV7XTR805PQYne+U7QU2vetKXmXwAWszdDWhYIYFIX0iOgAvr8TmhDuN3HX1UtiD
         2MR9hswMEYOKs1/K4r7ER/OPYFhxa9KSjx/WH/3O3oWzwbby3QsF+KMgjK6ivtuMTaA8
         DFlru7al7eHq3pNvOnM3HhiHcW/eJlvu1oN/f4NSTQiRV+odde4lsBrnjFcZwzX2Iglp
         oEyC67Z3x/ArHDt/GSakwG/TE1tNTIiOip8KMaFt6Eukc7pktnBkO5D9DHxZolJltwnE
         PVYw==
X-Forwarded-Encrypted: i=1; AJvYcCVw8fi18IPDeqpX6kjJkF77DFJI4jRrDyRTtnCT8cKY3IUnKrxZkTjejbtt+H7gzHrg5TryrIiyQ+YpZBKQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyE70eZNpp8+cm4s2c3U3r/7PW7ox0wrspKk7XP3acJ2K1pRwq0
	q/zkeI3BXYSXlhai703JPUwWvMoo/LwVcRxOE8i6WPxL6/5o/VIxCwm/F//o0sWQAtcqePvi9Zh
	0FDPjjRACGwvuASn2pMIolNd8hdWrH277t6++
X-Gm-Gg: ASbGncsJV7hd+BG+zNE3EXmC81roPuiXd2Kkj/Ldqw3KyS+O2acHkFcEyOP8vqLYcml
	6Faa5mUsjZQzytRKsZERPJXf99MpxX95dFUhW8EhZ6grlugjs0dkgj4Fk0AtrCrY5R8wScA==
X-Google-Smtp-Source: AGHT+IG7q7p56cLQrXudvQLIKgNyrObYkouGvIO+uE9TTepUhhEBhvVuAEL+fOuv5LwNNVlWEqJ8gjR318dJo+qL9Nw=
X-Received: by 2002:a05:651c:19ac:b0:2ff:cfbb:c893 with SMTP id
 38308e7fff4ca-305f459ab20mr76724551fa.6.1736846139701; Tue, 14 Jan 2025
 01:15:39 -0800 (PST)
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
Date: Tue, 14 Jan 2025 10:15:28 +0100
X-Gm-Features: AbW1kvar_DVbRprcruFTOeA3ThPr4U7dDnbMvzcYy_l8DdJmQkFwUNPv35gkSLA
Message-ID: <CACT4Y+YVy3OqiG=HD4TcERCHqS7XrNUwMgJtjM-HLC_-kA5rdw@mail.gmail.com>
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
>
> While the Google syzbot dashboard has improved remarkably since 2018,
> particularly in the past couple of years, thanks to the people who did
> that!

And, thanks, Darrick!
Most credit goes to Aleksandr Nogikh, who worked on improvements in
the past years.
We don't always have cycles to implement everything immediately, but
we are listening.

>  It's nice that I can fire off patches at the bot and it'll test
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

