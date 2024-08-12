Return-Path: <linux-fsdevel+bounces-25711-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D27F394F640
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 20:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 106651C22207
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 18:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFECD1898E3;
	Mon, 12 Aug 2024 18:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JaOED2O1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2689CC156;
	Mon, 12 Aug 2024 18:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723485944; cv=none; b=en5KoH4i4OzgAv1iFs4c7UyoKOb1Pmx5GdlZNKEmhGMOQXnVcwDk1nsrRPzquIE/YTSjNO+9xCQO7FTlOlgSxqf55fmyq+f5NKzES+cbQ140gO1CeZsMeAC1sNyzCLaHMJv6m4EuFnE4BmPhoUKiiKfPfbphQc248vg9KgyGEpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723485944; c=relaxed/simple;
	bh=1nx+vzrAb9GxccYNVGvNUJ66rUWE4yHfuV1J6T8RZ+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nt/WN5f2K0BuKo6t6rVP1eyeQBwAC19TbQ6GqU00N3lz62NFavT6qAt5HjmpgjWav/5b/5jB5cflFVuDknImnzmzqX3/bwn/JCRppgyM4aR2ut6TVM+lkKHD4Z6tO5S5fGYvcX9XaDUOHR47OhUjJz2oHF2uqpuIwp61kxUmYIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JaOED2O1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7CB8C32782;
	Mon, 12 Aug 2024 18:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723485944;
	bh=1nx+vzrAb9GxccYNVGvNUJ66rUWE4yHfuV1J6T8RZ+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JaOED2O1WS6LJCZjUcks+c/ZkRCWrthzTpi1+1AdUq1mL/PM5zR157KPC05SOnRmC
	 9c7C9BrjL+kTnu0eDWprTauRWOdhjvacJcTEfFqMatkdBfJxBfYT1kBcKYk06IASDf
	 RR15sH25pazSBGUqkZrH7hlj+34BzTxIHlIBMeKm31QpnfQX3SiWbifWgAqav2SuSa
	 8n0Si+GSeqvQh72d6loNBuyq7w6tJXW1ppgKNJT1B9j5XpYRRmLnZC4OKQXVFOAdnA
	 xdlZWGOre/otTgAkWn0UKvC4lLQpHk2VDhxK0PSuVk3mpX/ZAuVyZ07+4k3iFsyhnl
	 DPSt3lxaGTm/w==
Date: Mon, 12 Aug 2024 11:05:43 -0700
From: Kees Cook <kees@kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Brian Mak <makb@juniper.net>, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v3] binfmt_elf: Dump smaller VMAs first in ELF cores
Message-ID: <202408121105.E056E92@keescook>
References: <036CD6AE-C560-4FC7-9B02-ADD08E380DC9@juniper.net>
 <87ttfs1s03.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ttfs1s03.fsf@email.froward.int.ebiederm.org>

On Sat, Aug 10, 2024 at 07:28:44AM -0500, Eric W. Biederman wrote:
> Brian Mak <makb@juniper.net> writes:
> 
> > Large cores may be truncated in some scenarios, such as with daemons
> > with stop timeouts that are not large enough or lack of disk space. This
> > impacts debuggability with large core dumps since critical information
> > necessary to form a usable backtrace, such as stacks and shared library
> > information, are omitted.
> >
> > We attempted to figure out which VMAs are needed to create a useful
> > backtrace, and it turned out to be a non-trivial problem. Instead, we
> > try simply sorting the VMAs by size, which has the intended effect.
> >
> > By sorting VMAs by dump size and dumping in that order, we have a
> > simple, yet effective heuristic.
> 
> To make finding the history easier I would include:
> v1: https://lkml.kernel.org/r/CB8195AE-518D-44C9-9841-B2694A5C4002@juniper.net
> v2: https://lkml.kernel.org/r/C21B229F-D1E6-4E44-B506-A5ED4019A9DE@juniper.net
> 
> Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> 
> As Kees has already picked this up this is quite possibly silly.
> But *shrug* that was when I was out.

I've updated the trailers. Thanks for the review!

-Kees

-- 
Kees Cook

