Return-Path: <linux-fsdevel+bounces-12533-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD0186097F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 04:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24AAC1F2091B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 03:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B99FBF4;
	Fri, 23 Feb 2024 03:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ss5+OnXO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018B4C2E9
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Feb 2024 03:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708659999; cv=none; b=jcNN9H4VRY9sI5rYIIR4OMZ+TmzojJeCYwweUIIRKvqNqWhOr6oAOJfNy/+KFubkxdcmuG9BA/oYzzUQSDC6SJgywHLOuJ3gO6TNUsKCf4U8oMK+IFLt169XzdObZxziBjj0W+MGQU0p//54bxHSFu5eam0m4xi+j0EUOMt73/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708659999; c=relaxed/simple;
	bh=iGul607Cp7rDkfZ94qKL6w4xt1f9nX9iQReaI0swLc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uMS9oADX4oB2GVaGS9lSH7W/QgbuCTkvGddVd0gujcyHqeCngZSbYDfMXAWCZuQ1Fr+Jh5EimAjaHeafarFGG0oroK47VfCSBH3QTPYyXZVXNilvVeSZAxJZNH8KQxwA7ng6chfAnXw0toixhK1Ir/nnOr1yRhatO/sCj1XNb00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ss5+OnXO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A342EC43394
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Feb 2024 03:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708659998;
	bh=iGul607Cp7rDkfZ94qKL6w4xt1f9nX9iQReaI0swLc0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ss5+OnXOHt9v6JYmfkpOwLkMePy0RI5IUBZyKFkwQDo1YwbYgU1EPqpM0ZD/HXCNS
	 IoTBgqy113G4J1q7SDG/rNCRJf0RXKJHcQeVPrqHd8pTPBcnv/xipLjuKR7uMK9F+j
	 9EJpZYqP7ymdhvha5Eod9pabF6n4NOYSa2MFIzx67GGmVGr9iQduTUlakqgLGsyxhi
	 0XilYrgtCNI2bGZecbsmu/dGLvdnsp3LQXlzYSmWH+JmlyZQypJsrLuETJ2NnObS5v
	 MA9Lck+1zAvGT8xXa43WUAaA16ccrxt2VWS73h6mabAb1uao6881k8/mYW5CgDyens
	 /I3G+VmVXaMGQ==
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-36517375cc6so1199745ab.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Feb 2024 19:46:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWVD/aIUBrIFkPw0aykg2mlRk6srkdjmAbOTgBL2S6mxjLjSJI5wDGbTJ8fwQtBdyUulgfxo/ugBm1eDYm4N/ufbWhyL5lRVJ9no+9PhA==
X-Gm-Message-State: AOJu0YxwQNN0HGHZ/1qeySDhq6AlVWadaZNxFx4Ha/KSC/9ioXAdjqHj
	mcWtulaiScY1eXrq6n7oIWZbGsMSa2MDERqllKczX/QrAFBfepLpFIjPvUDrusl/XKmlcnyuZuv
	MZkLBxuv4788r/+dirmxhChFuylgLnY6tW3i7
X-Google-Smtp-Source: AGHT+IFsxTZLAPCkD0TH5XAL1lgftVp9VE5z8c865bPRirAR/yXtuKuQ6IawvGKBD9vlftWjblFJjx5+nNwDQPOuMaY=
X-Received: by 2002:a05:6e02:12c7:b0:364:fffe:44c5 with SMTP id
 i7-20020a056e0212c700b00364fffe44c5mr1130416ilm.1.1708659997924; Thu, 22 Feb
 2024 19:46:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2701740.1706864989@warthog.procyon.org.uk> <CAF8kJuNt2Vqk0yGkuz7qHAui7tb9B1W6U+SLyTmc6N2ngCU53A@mail.gmail.com>
 <1B53E6AF-0EFA-4290-A4CF-CFA7F3BF0E51@dilger.ca>
In-Reply-To: <1B53E6AF-0EFA-4290-A4CF-CFA7F3BF0E51@dilger.ca>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 22 Feb 2024 19:46:24 -0800
X-Gmail-Original-Message-ID: <CAF8kJuOFKTuepSheBa1Uhdm-a+pOVKUORjOPSDhTfxFydRTN_A@mail.gmail.com>
Message-ID: <CAF8kJuOFKTuepSheBa1Uhdm-a+pOVKUORjOPSDhTfxFydRTN_A@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Large folios, swap and fscache
To: Andreas Dilger <adilger@dilger.ca>
Cc: David Howells <dhowells@redhat.com>, lsf-pc@lists.linux-foundation.org, 
	Matthew Wilcox <willy@infradead.org>, netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

On Thu, Feb 22, 2024 at 7:03=E2=80=AFPM Andreas Dilger <adilger@dilger.ca> =
wrote:
>
> On Feb 22, 2024, at 3:45 PM, Chris Li <chrisl@kernel.org> wrote:
> >
> > Hi David,
> >
> > On Fri, Feb 2, 2024 at 1:10=E2=80=AFAM David Howells <dhowells@redhat.c=
om> wrote:
> >>
> >> Hi,
> >>
> >> The topic came up in a recent discussion about how to deal with large =
folios
> >> when it comes to swap as a swap device is normally considered a simple=
 array
> >> of PAGE_SIZE-sized elements that can be indexed by a single integer.
> >
> > Sorry for being late for the party. I think I was the one that brought
> > this topic up in the online discussion with Will and You. Let me know
> > if you are referring to a different discussion.
> >
> >>
> >> With the advent of large folios, however, we might need to change this=
 in
> >> order to be better able to swap out a compound page efficiently.  Swap
> >> fragmentation raises its head, as does the need to potentially save mu=
ltiple
> >> indices per folio.  Does swap need to grow more filesystem features?
> >
> > Yes, with a large folio, it is harder to allocate continuous swap
> > entries where 4K swap entries are allocated and free all the time. The
> > fragmentation will likely make the swap file have very little
> > continuous swap entries.
>
> One option would be to reuse the multi-block allocator (mballoc) from
> ext4, which has quite efficient power-of-two buddy allocation.  That
> would naturally aggregate contiguous pages as they are freed.  Since
> the swap partition is not containing anything useful across a remount
> there is no need to save allocation bitmaps persistently.

That is a very interesting idea. I saw two ways to solve this problem,
buddy allocation system is one of them. The buddy allocation system
can keep the assumption that swap entries will be contiguous within
the same folio. The buddy system also has its own limits due to
external fragmentations. For one there is no easy way to relocate the
swap entry to other locations. We don't have the rmap for swap
entries. That makes the swap entries hard to compact. I do expect the
buddy allocator can help reduce the fragmentation greatly.

The other way is just to have an indirection for mapping a folio's
swap entry to discontiguous swap entries. It will break more
assumptions of the current code about contiguous swap entries.

If we can reuse the ext4 mballoc for swap entries, that would be
great. I will take a look at that and report back.

Thanks for the great suggestion.

Chris

