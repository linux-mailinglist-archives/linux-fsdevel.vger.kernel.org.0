Return-Path: <linux-fsdevel+bounces-12690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB738628BA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 02:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B95791F21751
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 01:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B489257B;
	Sun, 25 Feb 2024 01:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXeL2bls"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D8F10E4;
	Sun, 25 Feb 2024 01:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708824091; cv=none; b=tOOWMs/FcG1GLvmNw8WocFMIQddg2vg2sG1IxKE9GQ0nobhufezeKYYhQftIpREilFTe9ZOAVb9iOr/SfVUbNXKc5HmDSjljtfHLs5i7qvvC+U0hust8Ji4/vUaxrvaRPbq2S9egHxyYb2Ks67tmU1SNeQMs1jsnbHfrCr9VJLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708824091; c=relaxed/simple;
	bh=mFyhUVC44DtaGMHctMSrjt2YDHiRWqydiWVBS+Xjg58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEN266w72mJiLiEbmguqbhEbqqfWuUjVBNnlIcu//5mOKWj51E0WNe399Cgyshcbxu35nMBYk4ocMEIIQyzhFvHKtNHFXcQyzQRecHhVXmmKWZCnva8hCtqGsO0M6pAuo9hRbsSA+UEoYqigZBuCMT9X9zY1um8JbmNhoFaAtRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YXeL2bls; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83CF6C433C7;
	Sun, 25 Feb 2024 01:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708824090;
	bh=mFyhUVC44DtaGMHctMSrjt2YDHiRWqydiWVBS+Xjg58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YXeL2blskfAFqL6ZyqR1LRwtwpzA0B9B1SEWzVIDeF+qSHJrkFyU9FvpZaVPYOtRh
	 Og0GP99/8ZvUshqDJfzDFRYTyyfdr1juUc8Mf0HKeXKf1vJf3OrOluK5nQ2FUMbUJQ
	 LC18qAniTBv/xaEZeX6qlmKMIpmkjfJYXfaZZALS8iAEr/jMzI9afWhmooYKJvspIt
	 YASDYgPRmQQlPIqYruvgItJRHk3L1mhiBuol/WndgMVcqcS9u/ale0cgsB4EIxHQqo
	 fAi/GmU6ZNvTSdlDWGk+XXencMZSp4ioxC2g59dQAvIB7XFkblbHF10dr3ES8uPSZC
	 9KlgwIhLrqQlg==
Date: Sat, 24 Feb 2024 20:22:42 -0500
From: Al Viro <viro@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
	"Christian Brauner (Microsoft)" <brauner@kernel.org>,
	Matt Heon <mheon@redhat.com>, Ed Santiago <santiago@redhat.com>,
	Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Paul Holzinger <pholzing@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [REGRESSION] 6.8-rc process is unable to exit and consumes a lot
 of cpu
Message-ID: <ZdqWYplgbHL7xSch@duke.home>
References: <6a150ddd-3267-4f89-81bd-6807700c57c1@redhat.com>
 <652928aa-0fb8-425e-87b0-d65176dd2cfa@redhat.com>
 <9b92706b-14c2-4761-95fb-7dbbaede57f4@leemhuis.info>
 <e733c14e-0bdd-41b2-82aa-90c0449aff25@redhat.com>
 <f15ee051-2cfe-461f-991d-d09fd53bad4f@leemhuis.info>
 <c0cbf518-c6d4-4792-ad04-f8b535d41f4e@leemhuis.info>
 <CAHk-=wg9nqLqxr7bPFt4CUzb+w4TqENb+0G1-yJfZbwvRhi29A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg9nqLqxr7bPFt4CUzb+w4TqENb+0G1-yJfZbwvRhi29A@mail.gmail.com>

On Sat, Feb 24, 2024 at 03:43:43PM -0800, Linus Torvalds wrote:
> On Fri, 23 Feb 2024 at 23:00, Thorsten Leemhuis
> <regressions@leemhuis.info> wrote:
> >
> > TWIMC, the quoted mail apparently did not get delivered to Al (I got a
> > "48 hours on the queue" warning from my hoster's MTA ~10 hours ago).
> 
> Al's email has been broken for the last almost two weeks - the machine
> went belly-up in a major way.
> 
> I bounced the email to his kernel.org email that seems to work, but I
> also think Al ends up being busy trying to get through everything else
> he missed, in addition to trying to get the machine working again...

FWIW, I'm pretty sure that it's fixed by #fixes^ (7e4a205fe56b) in
my tree; I'll send a pull request, both for #fixes and #fixes.pathwalk.rcu

