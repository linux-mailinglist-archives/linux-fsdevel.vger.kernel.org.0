Return-Path: <linux-fsdevel+bounces-50308-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE724ACAB8E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 11:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 468217A356A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 09:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71311E378C;
	Mon,  2 Jun 2025 09:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5zlRaru"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346FC2C3240;
	Mon,  2 Jun 2025 09:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748857287; cv=none; b=oyyummmYga4RJNirohUMEH4bMWEJr1eNOVdgfLqBZmvWn8Z8ZOwXN7sd23R3nRcZrDzctZwcA+EPyAi7MSX8I9nW2ToPRahUhlNOV8z7UafkMkNsGfFwlPnQZd7apDQBjw/sgPDPOeCoJD6EutjjsshGHupsqaIQptzdFDVF8fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748857287; c=relaxed/simple;
	bh=nc6j8Ww3pa6hsHO1V9lFp84Qa/02w3fwd44UmE8/4Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bY2JOSbXasHCa1feFZHpOR9U+NtKYsW0/Ak1NYigUlIyVsemsRuEdMalSWzShG8QahR7Sx38/XKzmwLYs6CikyenCmutd8HLZAe4XWzxigqWwxh/ViP4CRPtXSnK3jS0hCII3GaCLGhBymDiGsrhEVNA8GBkYsmaVZSD+SJHR6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5zlRaru; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB054C4CEEB;
	Mon,  2 Jun 2025 09:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748857286;
	bh=nc6j8Ww3pa6hsHO1V9lFp84Qa/02w3fwd44UmE8/4Rk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n5zlRaruelPGzyHReU0/OBvQXB3bXOw3WhShwjZGDlm7089tB9BWiZTrAstN85UVT
	 vzg1Gtx83aO7bMoIQ2tV9NhMl2ld/STm4eeiKWZB44Sk5owmMKGc5wi8Y/4bZNC3AL
	 5fnswEOnW9uvtW5k6tt8pC2T90guJO3a0PGTXlCsjJdawO3ibEbksxnpSAEbqd44FJ
	 EgLiYOxAzzlbpRxHx5IhdQJ4FDscrDa+quTUg4vJb7mzXqXyyYlA2MuhdlB8iD+J06
	 r0/bkShKsBhMNgl24mTLC7Rwo9xXiCLBwBgpBStEcOTfS74Q9ENn9CWfZ0cVf7YWpE
	 RDTh0hp0F0caA==
Date: Mon, 2 Jun 2025 11:41:19 +0200
From: Christian Brauner <brauner@kernel.org>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Song Liu <song@kernel.org>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>, 
	bpf <bpf@vger.kernel.org>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Amir Goldstein <amir73il@gmail.com>, repnop@google.com, 
	Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Subject: Re: [PATCH bpf-next 3/4] bpf: Introduce path iterator
Message-ID: <20250602-zuarbeiten-entledigen-d793f4e0bce3@brauner>
References: <20250528222623.1373000-1-song@kernel.org>
 <20250528222623.1373000-4-song@kernel.org>
 <20250528223724.GE2023217@ZenIV>
 <yti2dilasy7b3tu6iin5pugkn6oevdswrwoy6gorudb7x2cqhh@nqb3gcyxg4by>
 <CAPhsuW4tg+bXU41fhAaS0n74d_a_KCFGvy_vkQOj7v4VLie2wg@mail.gmail.com>
 <CAADnVQ+UGsvfAM8-E8Ft3neFkz4+TjE=rPbP1sw1m5_4H9BPNg@mail.gmail.com>
 <CAPhsuW78L8WUkKz8iJ1whrZ2gLJR+7Kh59eFrSXvrxP0DwMGig@mail.gmail.com>
 <20250530.oh5pahH9Nui9@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250530.oh5pahH9Nui9@digikod.net>

On Fri, May 30, 2025 at 04:20:39PM +0200, Mickaël Salaün wrote:
> On Thu, May 29, 2025 at 10:05:59AM -0700, Song Liu wrote:
> > On Thu, May 29, 2025 at 9:57 AM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > [...]
> > > >
> > > > How about we describe this as:
> > > >
> > > > Introduce a path iterator, which safely (no crash) walks a struct path.
> > > > Without malicious parallel modifications, the walk is guaranteed to
> > > > terminate. The sequence of dentries maybe surprising in presence
> > > > of parallel directory or mount tree modifications and the iteration may
> > > > not ever finish in face of parallel malicious directory tree manipulations.
> > >
> > > Hold on. If it's really the case then is the landlock susceptible
> > > to this type of attack already ?
> > > landlock may infinitely loop in the kernel ?
> > 
> > I think this only happens if the attacker can modify the mount or
> > directory tree as fast as the walk, which is probably impossible
> > in reality.
> 
> Yes, so this is not an infinite loop but an infinite race between the
> kernel and a very fast malicious user space process with an infinite
> number of available nested writable directories, that would also require
> a filesystem (and a kernel) supporting infinite pathname length.

Uhm, I'm not so sure. If you have really deep directory chains and
expose them via bind-mounts in multiple location then it was already
easy to trigger livelocks because e.g., is_subdir() did lockless
sequence counter checks and it refired over and over and over again.
We've fixed that since but such issues aren't all that theoretical. IOW,
the bug was caused simply by having too many concurrent tree
modifications and parts of the code need to make sure that they haven't
affected their result. So I would be very careful with asserting that
it's not possible to hit such issues in real-life...

