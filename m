Return-Path: <linux-fsdevel+bounces-12523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E00A98605AD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 23:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 969731F22C7A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 22:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C157137914;
	Thu, 22 Feb 2024 22:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vEfHm21w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88648137902
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Feb 2024 22:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708640808; cv=none; b=YuChTLOUsS3XptwV/iW48tHJBNKwjfbCMj8Ywdy1TyRNYw0fwtk1Jx3HJfqRjggZaLGiqRQTQcsI11NUdmE4Ow2Z6KM+3exuLeLdhdyDXJAbkYGKa5XAjfky9uEUJnmIFB6nC7QPuKXgSTZpsgX7WII+8IGyQBBLl94Kxjw/60s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708640808; c=relaxed/simple;
	bh=uakp6pNcUQpeLqxV/KFsqT6ljx2PPnsKSGdS4Nn4ldk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qg4cPSVObtzrma/iwmvfTV03+yRc4Oufl2lb3ozPJ+a9/oNBj+trWH6Ror4LpotYEjekulL7QwsDbcPxK4z9cWv+gASXJjAwdx0KgqK+j8XO2vfwGdkqQ4scVR3mByMedRBFaiMDYr96t0X/Ic0AYn03k6tKedt4kHyElDojxYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vEfHm21w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F69C433C7
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Feb 2024 22:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708640808;
	bh=uakp6pNcUQpeLqxV/KFsqT6ljx2PPnsKSGdS4Nn4ldk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=vEfHm21w2Pjw74NoHq2HRFMsBF69w5mTJQ+DAzdfP5//ZJ967ExWVX2xEO/SyIB3s
	 XdxPmDbTDVJ6iP/bs1CQHu62XaWjS/T8MNU5Ez7Wsk4D0bbGytS02BydsNwfG1QRAx
	 CVPtVUJUgY04SREWatdjWatpdPFAzoGEisighju7z5ZRVjgqjYDa+fytXkxUBqeMHu
	 iecEL+kUj+6bX9UAC8mgmK5VIlzsWZz6wvHaeRLJlURcEySXES4DoFl6dHWiDQ9eSS
	 enPtasWN273I4YjYaV6n6Qw3tLRnxxFynBDaVfrrK70jirAUctCFYHXa8ZWFbusnEZ
	 ju2KtHUrRHxUA==
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7c4949a366fso7010039f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Feb 2024 14:26:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU427vYu6LNEc1MmDEVjE6OuexzaYCiRkJoEDZxHUqVjl0N3Zan9oYUl74UkfvSJLgYzeDzsEjcAneeqZSddh2HBphiBWMLBj+/Vsh+bw==
X-Gm-Message-State: AOJu0Yyz/t3M1OVFY+VeJDA5exZfUvpxyaxSNQxAaGN5tYSPJ22vIO2r
	xVOBss8Y4PVdugSq5gcSAr7m2Mvcupvc7zsUzb3UuO3TUCag97CoVjb8vCjKKhnVc5cEpWhE087
	5cgZIOcKgqee6UYyINYZO+aFW+I4VQ7cxZxU6
X-Google-Smtp-Source: AGHT+IEJtvmtefD3Od3t1bbl8B5RouNFbPYfROpVtt9Kyh4HZQ6k22NC85SPF3O3XKdoWz/28JwIFtcPvQXRn/oqWCA=
X-Received: by 2002:a92:d449:0:b0:363:f8c5:9d7b with SMTP id
 r9-20020a92d449000000b00363f8c59d7bmr317959ilm.9.1708640807451; Thu, 22 Feb
 2024 14:26:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2701740.1706864989@warthog.procyon.org.uk> <Zbz8VAKcO56rBh6b@casper.infradead.org>
 <ZdeaQMDjsSmIRXHB@bombadil.infradead.org>
In-Reply-To: <ZdeaQMDjsSmIRXHB@bombadil.infradead.org>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 22 Feb 2024 14:26:35 -0800
X-Gmail-Original-Message-ID: <CAF8kJuMGCf8gPnFEVX=OfvKowWOLGX330EQvGC-qYy6xtLJR4g@mail.gmail.com>
Message-ID: <CAF8kJuMGCf8gPnFEVX=OfvKowWOLGX330EQvGC-qYy6xtLJR4g@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Large folios, swap and fscache
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, Pankaj Raghav <p.raghav@samsung.com>, 
	Hugh Dickins <hughd@google.com>, David Howells <dhowells@redhat.com>, 
	lsf-pc@lists.linux-foundation.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 11:02=E2=80=AFAM Luis Chamberlain <mcgrof@kernel.or=
g> wrote:
>
> On Fri, Feb 02, 2024 at 02:29:40PM +0000, Matthew Wilcox wrote:
> > So my modest proposal is that we completely rearchitect how we handle
> > swap.  Instead of putting swp entries in the page tables (and in shmem'=
s
> > case in the page cache), we turn swap into an (object, offset) lookup
> > (just like a filesystem).  That means that each anon_vma becomes its
> > own swap object and each shmem inode becomes its own swap object.
> > The swap system can then borrow techniques from whichever filesystem
> > it likes to do (object, offset, length) -> n x (device, block) mappings=
.
>
> What happened to Yosry or Chris's last year's pony [0]? In order to try
> to take a stab at this we started with adding large folios to tmpfs,
> which Daniel Gomez has taken on, as its a simple filesystem and with
> large folios can enable us to easily test large folio swap support too.
> Daniel first tried fixing lseek issue with huge pages [1] and on top of
> that he has patches (a new RFC not posted yet) which do add large folios
> support to tmpfs. Hugh has noted the lskeek changes are incorrect and
> suggested instead a fix for the failed tests in fstests. If we get
> agreement on Hugh's approach then we have a step forward with tmpfs and
> later we hope this will make it easier to test swap changes.

Ah, just notice this. I have some pending ideas on how to address
that, I might be the
one that brings up this topic in the discussion David was referring to.

Will reply in his email of this thread.

=3D=3D=3D=3D quote =3D=3D=3D=3D=3D=3D
On Fri, Feb 2, 2024 at 1:10=E2=80=AFAM David Howells <dhowells@redhat.com> =
wrote:
>
> Hi,
>
> The topic came up in a recent discussion about how to deal with large fol=
ios
> when it comes to swap as a swap device is normally considered a simple ar=
ray
> of PAGE_SIZE-sized elements that can be indexed by a single integer.
>
=3D=3D=3D=3D end quote =3D=3D=3D=3D

>
> Its probably then a good time to ask, do we have a list of tests for
> swap to ensure we don't break things if we add large folio support?
> We can at least start with a good baseline of tests for that.

That is a very good idea to start with the test. We need all the help
we can get on the testing side.
I know Huge has his own test setup for stressing the swap systems.
Yes, more tests are always better.

Chris

>
> [0] https://lwn.net/Articles/932077/
> [1] https://lkml.kernel.org/r/20240209142901.126894-1-da.gomez@samsung.co=
m
>
>   Luis
>

