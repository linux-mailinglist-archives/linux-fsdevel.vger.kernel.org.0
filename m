Return-Path: <linux-fsdevel+bounces-40718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B26A27019
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 12:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADB8B161F8C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 11:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A388420C038;
	Tue,  4 Feb 2025 11:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMqk+WlV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0949D1531C4;
	Tue,  4 Feb 2025 11:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738667880; cv=none; b=f42yMUiP3e/4uWgiiyl/dLyE6JNUliX5pqMeYlefaumElwJ4J06e79lmNKySFxFLekh53+klNwx855sk0jVGaE4IrisJvVwvUJCMU793n4QsW2HLCVVv+mjZm27LyeIagNHc0f59oAbr9tGiIy8XMxs2UFNPFnW9DZuIjXpEXy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738667880; c=relaxed/simple;
	bh=/3y3Dy0oBeayEWHi9QaQJlWsT0nkdVGr4OGqdxej+q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iow4zCZvpjFfVBaJUtNK+0zOkPRFweF3TqXqdkILjH9IL2JlpZIq/0lXGcT/zQeK1vu+YhYX9My7dsao1PywXtgawKtl9eTICWGmhQ/pTJPGtfyt9uAmP2u5OUB7hTOJdK4rW0D5k9vnk2kdlbl0AZGsQhJ5Nw7EG/h0AeBW9zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMqk+WlV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA5FAC4CEDF;
	Tue,  4 Feb 2025 11:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738667879;
	bh=/3y3Dy0oBeayEWHi9QaQJlWsT0nkdVGr4OGqdxej+q0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EMqk+WlVfgOZpwBq78qi34StRN/i9BEMVk/Gx/4/VwDF0fKDzML7j6yI3DHbOs8zh
	 79dqUyWthOETvP0Kq4uatbok+NaM6JjYCCqh2y3NnP+DvZxAACgnHW3UMOVpZ9iU0F
	 3B6TvdpQwjTWwIN2GEIEy52lWOg39X0NlH47UEDei2s6MtdEOLndai8pgIFz97s/E5
	 HG7DiRVNFB5gruo6kvskPu8C3WPnmuz0XCGpIPbC7E+bzeGO5UctiDbZXi6IcuwpJd
	 ms4BNNSlZkTifCWf6gG0OJvBuJAjyVDshGt2Zzog/E1GhmhVYCXgHq7sT0cKuwpAE3
	 RnMm9WLJfzlBg==
Date: Tue, 4 Feb 2025 12:17:54 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Manfred Spraul <manfred@colorfullife.com>, 
	David Howells <dhowells@redhat.com>, WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	Swapnil Sapkal <swapnil.sapkal@amd.com>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still
 full
Message-ID: <20250204-anlaufen-wurfgeschosse-5c57f0d1fc46@brauner>
References: <20250102140715.GA7091@redhat.com>
 <3170d16e-eb67-4db8-a327-eb8188397fdb@amd.com>
 <CAHk-=wioaHG2P0KH=1zP0Zy=CcQb_JxZrksSS2+-FwcptHtntw@mail.gmail.com>
 <20250202170131.GA6507@redhat.com>
 <CAHk-=wgEj=1C08_PrqLLkBT28m5qYprf=k6MQt-m=dwuqYmKmQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgEj=1C08_PrqLLkBT28m5qYprf=k6MQt-m=dwuqYmKmQ@mail.gmail.com>

On Sun, Feb 02, 2025 at 10:39:16AM -0800, Linus Torvalds wrote:
> On Sun, 2 Feb 2025 at 09:02, Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > And if we do care about performance... Could you look at the trivial patch
> > at the end? I don't think {a,c,m}time make any sense in the !fifo case, but
> > as you explained before they are visible to fstat() so we probably shouldn't
> > remove file_accessed/file_update_time unconditionally.
> 
> I dislike that patch because if we actually want to do this, I don't
> think you are going far enough.
> 
> Yeah, you may stop updating the time, but you still do that
> sb_start_write_trylock(), and you still call out to
> file_update_time(), and it's all fairly expensive.
> 
> So the short-circuiting happens too late, and it happens using a flag
> that is non-standard and only with a system call that almost nobody
> actually uses (ie 'pipe2()' rather than the normal 'pipe()').
> 
> Put another way: if we really care about this, we should just be a lot
> more aggressive.
> 
> Yes, the time is visible in fstat(). Yes, we've done this forever. But
> if the time update is such a big thing, let's go all in, and just see
> if anybody really notices?
> 
> For example, for tty's, a few years ago we intentionally started doing
> time updates only every few seconds, because it was leaking keyboard
> timing information (see tty_update_time()). Nobody ever complained.
> 
> So I'd actually favor a "let's just remove time updates entirely for
> unnamed pipes", and see if anybody notices. Simpler and more
> straightforward.
> 
> And yes, maybe somebody *does* notice, and we'll have to revisit.
> 
> IOW, if you care about this, I'd *much* rather try to do the big and
> simple approach _first_. Not do something small and timid that nobody
> will actually ever use and that complicates the code.

Agreed.

