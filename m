Return-Path: <linux-fsdevel+bounces-50449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5399CACC4D7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 13:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDAAC3A53E3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 11:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FDA22DA1B;
	Tue,  3 Jun 2025 11:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b="DZKV+ntn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28C522CBFE
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Jun 2025 11:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748948543; cv=none; b=gN4Mkjw/cRWbiZa2FxE0EueSC6WChMfHsZ5bzwT0RQ1/K5/xi+K4UOeTfPycrcc2ORUU6xXFk7NDZqgVdH/aDGoDezxO89A8yqejr2Udd15rfNQf7KNE2fJZZUjQ3amNBPfeMMTsLfZfKxq2b1TRQXvBrMQUBAYnC2E7XpAbIxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748948543; c=relaxed/simple;
	bh=4OwhPU8PmZXLIES8OlaL1HaQcml5eEwod58uyNHAxfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=hNjequ0Vpx2TgtIjU5OTqRYLh5mezRfNdFchDk6XibpI0CY3ZHyJ+BMQnOAxdgLwOQIvp/BuNraY0AK1oEKZF3Sb7sQ2otDAJ0snyFNjKr/kk3Y6fC9DS3n1/W3A+bqQOsN4g1m8clTRUcnDYJAZDJLo4BmLCG9tjLpteN3do84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com; spf=pass smtp.mailfrom=omnibond.com; dkim=pass (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b=DZKV+ntn; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omnibond.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-23228b9d684so57500485ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Jun 2025 04:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20230601.gappssmtp.com; s=20230601; t=1748948540; x=1749553340; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0AL/tnRY5FxE2mxqlmfauIyQ9pNc6F6OIql6rQ6Wujw=;
        b=DZKV+ntnxpQhJKuXGv8Q0x12mgWe9SN6VJg+r3Kr+iknVPf8FDddtbVqvcAE4YWg57
         yqeAKjxSpU5dfUJn4ZVU9MxYe41otOI0xNZ69s+FNL6JcQlqr9U2Ce7uA/XqTv9wbV+W
         M62zbbZhkvjShrbFwqPUSoY5iZqqSK9yg14uhdvFiSruXg2qzcR6uTXn7EccpJrO3K9n
         0rqHTEVGKx8XLYVy9houA9aD4fVybLTbqNohxvd3kEvgv4fDePSfUMRFBjtgF2wqcNGJ
         kDVmIRr9TGBZP+g2/Ws0bRZivFQ/tEj7FhM1WEI5MKSuudVTbx87GE4Ujsy2XtqXa77N
         GzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748948540; x=1749553340;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0AL/tnRY5FxE2mxqlmfauIyQ9pNc6F6OIql6rQ6Wujw=;
        b=EKlS0pnmfG8Gum4bN4ZwcaE10tspsseIw4a8LSpEVQ0gpfiZpnSeAn8xK/jJhDUVln
         6r+WQpQW2roMtnnIAo78JOjlwmPAZYEg7yUl95qZeG8C7eqjT351KktmSK7gVjBPE8hp
         9HE0av40ics0WuEQfydhddYk+TXYDG07hemGPJT473zVo2E4SiVX/MSF53PPkY+GU3+U
         xUAgX5sNVqmfowyjc8e+vwebiYP2FEfOqa8aA4VXpLHEGew1+ZnbNrgbgFNA4CxK/Xt4
         CBtgNI16pOJLmgTL4IN9FCI+P4ff8zjLTZV3NAzjbu2F1kQsHJbk7xjh1pxFbs5aYHw7
         I6eQ==
X-Forwarded-Encrypted: i=1; AJvYcCVw6/XaGi7Q9YzYXsivbnl29ovow6EWIyxnoe1VtMItXTlua9CcTCkmYHECuAsguTcH/gx7MHWIBVaFERBf@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd4tZvXDssOvt0IucAPzn3bVzhz1YQZoZdipMXUKixc3AElXRH
	wdCwk8wA4yrezE2VvTGxCVMCcpaOCcZNr2uK4bvjgfulKZ5JTJ0zokeBJNl7v7N8mCHo8DPRYNm
	pLhqXyo1NfTRrkM/+P2jP33yqDXN6mU1QE0CIjKEC
X-Gm-Gg: ASbGncvCNSO0VteJDEFACBHKbt0ciM+G2UDOYJOW5xf1RbBQlZP4ITKBPCBrm1BpCjU
	fIbdheLZei1jOhXhxTsw0+YjPkPJ6Vixb876AQ/BrXLekGSr91kVRmtzYZzIon/E5khioV58hse
	5njP8TkEbsxQnIy0K/giV1na3WyqsLVHmwwGBkjMGZDI+mrQOGlk6nbys=
X-Google-Smtp-Source: AGHT+IFv48iQt+0TG0Ext/2NlUi37NuSKvD/R7pezp3NKQrIfp1KKJSFDaq52dBcBMpfcxxggrjCARk/0B5m0qST8Gk=
X-Received: by 2002:a17:90b:1844:b0:311:a314:c2cf with SMTP id
 98e67ed59e1d1-31250451032mr22158405a91.30.1748948540179; Tue, 03 Jun 2025
 04:02:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOg9mSTuYsfCEi458Nt-X2==JOe9doLnzhoHEdqr9g_enSZLiQ@mail.gmail.com>
 <2025060303-handrail-prologue-3b3b@gregkh>
In-Reply-To: <2025060303-handrail-prologue-3b3b@gregkh>
From: Mike Marshall <hubcap@omnibond.com>
Date: Tue, 3 Jun 2025 07:02:09 -0400
X-Gm-Features: AX0GCFuY6CgHp3kmnmiC4OoErCj0B4g2qgzMpXyrLEtrmNUVyIDyn3oa-hBfL5I
Message-ID: <CAOg9mSS3NAxisK8b7mTkpW88btaQgAvW2umh5y6vhjbh6kVawQ@mail.gmail.com>
Subject: Re: important orangefs merge conflict request...
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mike Marshall <hubcap@omnibond.com>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg...

>> Sure, what is the upstream git commit id of the patch?

b36ddb9210 is the commit where Linus pulled my fix into 6.15.

Some of Matthew Wilcox's folio work also landed in orangefs in 6.15,
causing b36ddb9210 to have a merge conflict with 6.14.

I tested during 6.14-rc7 and Commit 665575cf was pulled into
6.14-rc7 after I tested, causing orangefs to be broken in 6.14.

So... there is not an upstream commit id for my patch that works
with 6.14.

Pulling 665575cf so late into rc7, even though it was known to
have caused deadlock problems with ext4 and (?) seems like
an "unlinuxy" thing to have done. I was just hoping there was
some way to get my un-committed 6.14 flavored patch
backported to 6.14... I figured if it was possible, you'd
know how...

Thanks...

-Mike

On Tue, Jun 3, 2025 at 12:38=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jun 02, 2025 at 12:19:39PM -0400, Mike Marshall wrote:
> > Hi Greg..
> >
> > Commit 665575cf "filemap: move prefaulting out of hot write path", whic=
h was
> > pulled in 6.14-rc7, broke orangefs. I got a fix applied to to 6.15.
> > 6.15 saw more of Matthew Wilcox's folio work folded into orangefs,
> > and my 6.15 patch has conflicts with 6.14. Fedora (and others?) is
> > at 6.14 now.
> >
> > I have a tested 6.14 version of my patch, would it be possible to
> > get that backported to 6.14?
>
> Sure, what is the upstream git commit id of the patch?
>
> >
> > -Mike
>
> > From 572e2027f6111728877f20085e79d07c5b2238de Mon Sep 17 00:00:00 2001
> > From: Mike Marshall <hubcap@omnibond.com>
> > Date: Tue, 13 May 2025 17:00:37 -0400
> > Subject: [PATCH] orangefs: adjust counting code to recover from 665575c=
f
> >
> > A late commit to 6.14-rc7! broke orangefs. 665575cf seems like a
> > good change, but maybe should have been introduced during the merge
> > window. This patch adjusts the counting code associated with
> > writing out pages so that orangefs works in a 665575cf world.
> > ---
> >  fs/orangefs/inode.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
>
> <snip>
>
> This isn't in a format I can take it :(
>
> Also, it's not on a public mailing list for some reason...
>
> thanks,
>
> greg k-h

