Return-Path: <linux-fsdevel+bounces-31252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F139937CC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 21:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFA091F241B5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 19:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DC61DE4D7;
	Mon,  7 Oct 2024 19:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CPJ/NhI7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0A31DE3C9;
	Mon,  7 Oct 2024 19:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728331169; cv=none; b=HkQiNx36ormUXwZG2TDJrGc4YttZeJdwJ8x/9NKMYR4wO0L3mNhiZxAaV0MK1ovM15pAYq6MGJRbC1i7mfHaZfYsdeR8e+0X/OKjy/DEDntBAixWzXDoYXByo77IEfB8mcOmNgOtLTJWiYiI5AQzpl6nqKuTmZmw6ceQ75DO/qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728331169; c=relaxed/simple;
	bh=zyS2MoYrjjDRv7zTLdZVaJsOLMtAdkXuonDPik1JNlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oTtAUHK5iNrY3gftaKOF0oLSh2aePJ2ee5zt3maQCUdnh3HRmPOHqXpcFB6g8YY4hBRJ2mqnoHC+K9JM7JGK0vEMAld0F25eEzOgvB7fsTWOJE8bnqhZnX73L01yd3KixqnMwVmXeaR3lnGX1Lzyg72UcCpXqkeIV43mwYYCPwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CPJ/NhI7; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 7 Oct 2024 15:59:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728331164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fTaQ+JHHJBLPhVTk8LqtlupUHTo1DQk5ZQd2/or6P1k=;
	b=CPJ/NhI7G1WI4w70Bx3ha9RF0NvYnCQY0D0ZiOoFqY1/LocP2azX5UvCHqwK8rsEW6Yng/
	ftTXZC79VnvaYRaq2J6MzrXXzsF9RggST1zgj3u6O8SPEtbPltAgE4iC5CJqfJNDIQgrJO
	cache0/8aHuNCdZHPwMDpntoPLWzocY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Theodore Ts'o <tytso@mit.edu>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.12-rc2
Message-ID: <6hjoiumgl3sljhjtmgvsifgu2kdmydlykib3ejlm5pui6zjla4@u7g2bjk4kcau>
References: <x7w7lr3yniqrgcuy7vzor5busql2cglirhput67pjk6gtxtbfc@ghb46xdnjvgw>
 <CAHk-=wi-nKcOEnvX3RX+ovpsC4GvsHz1f6iZ5ZeD-34wiWvPgA@mail.gmail.com>
 <e3qmolajxidrxkuizuheumydigvzi7qwplggpd2mm2cxwxxzvr@5nkt3ylphmtl>
 <CAHk-=wjns3i5bm++338SrfJhrDUt6wyzvUPMLrEvMZan5ezmxQ@mail.gmail.com>
 <2nyd5xfm765iklvzjxvn2nx3onhtdntqrnmvlg2panhtdbff7i@evgk5ecmkuoo>
 <20241006043002.GE158527@mit.edu>
 <jhvwp3wgm6avhzspf7l7nldkiy5lcdzne5lekpvxugbb5orcci@mkvn5n7z2qlr>
 <CAHk-=wh_oAnEY3if4fRC6sJsZxZm=OhULV_9hUDVFm5n7UZ3eA@mail.gmail.com>
 <dcfwznpfogbtbsiwbtj56fa3dxnba4aptkcq5a5buwnkma76nc@rjon67szaahh>
 <ZwP341bZ9eQ0Qyej@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwP341bZ9eQ0Qyej@zx2c4.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Oct 07, 2024 at 05:01:55PM GMT, Jason A. Donenfeld wrote:
> On Sun, Oct 06, 2024 at 03:29:51PM -0400, Kent Overstreet wrote:
> > But - a big gap right now is endian /portability/, and that one is a
> > pain to cover with automated tests because you either need access to
> > both big and little endian hardware (at a minumm for creating test
> > images), or you need to run qemu in full-emulation mode, which is pretty
> > unbearably slow.
> 
> It's really not that bad, at least for my use cases:
> 
>     https://www.wireguard.com/build-status/
> 
> This thing sends pings to my cellphone too. You can poke around in
> tools/testing/selftests/wireguard/qemu/ if you're curious. It's kinda
> gnarly but has proven very very flexible to hack up for whatever
> additional testing I need. For example, I've been using it for some of
> my recent non-wireguard work here: https://git.zx2c4.com/linux-rng/commit/?h=jd/vdso-test-harness
> 
> Taking this straight-up probably won't fit for your filesystem work, but
> maybe it can act as a bit of motivation that automated qemu'ing can
> generally work. It has definitely caught a lot of silly bugs during
> development time.

I have all the qemu automation:
https://evilpiepirate.org/git/ktest.git/

That's what I use for normal interactive development, i.e. I run
something like

build-test-kernel -I ~/ktest/tests/fs/bcachefs/replication.ktest rereplicate

which builds a kernel, launches a VM and starts running a test; test
output on stdout, I can ssh in, ctrl-c kills it like any other test.

And those same tests are run automatically by my CI, which watches
various git branches and produces results here:
https://evilpiepirate.org/~testdashboard/ci?user=kmo&branch=bcachefs-testing

(Why yes, thas is a lot of failing tests still.)

I'm giving out accounts on this to anyone in the community doing kernel
development, we've got fstests wrappers for every local filesystem, plus
nfs, plus assorted other tests. Can always use more hardware if anyone
wants to provide more machines.

