Return-Path: <linux-fsdevel+bounces-50455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC8BACC700
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 14:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B72383A339A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 12:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF31722DA08;
	Tue,  3 Jun 2025 12:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="GhiFs+Oa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C271572618
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Jun 2025 12:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748954955; cv=none; b=Ci2O3O76uZrfWVCflvV+8JkH+lBZDuiIEx/iDg90Dqt9ZmyloRAxex3bLfvUhzUIOTfsiEitfNK+GSccDt9JDVaul991yXowKewrSp1eMdtnHQCv14eIYVBBrqSFqEUnhvLhWQ7RcTMpvH+GfU9Gh0olqbrFXbyTE6Cl7sSEThU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748954955; c=relaxed/simple;
	bh=YpSUlje0QFo8fAg0UbMHlFaUYLWtmOn9kosehVUWl2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iuzNScUuCFzjQrgoaKRC9Fdmde3gu4P5ZyS3eEoCira1CTNL7snsEAlKe3PY0wTpekkW69V5kYZVrTZsorBJiEq4F16tvmyRez2Q08qPWrzgvdsp7l10G9BzD38wgDYEoh6BK3j7FBt4oi8Q7Ot1vzOUMGCal5ZGTE8ORTE6Ydg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=GhiFs+Oa; arc=none smtp.client-ip=185.125.25.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bBVs24Wlqz19Nm;
	Tue,  3 Jun 2025 14:49:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1748954950;
	bh=f3sEmdCXf265fZdW3agrYCmOKfWp1F1brT5D1vfWqXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GhiFs+OagmKnjzrO37+j/bRCJRvL9X3nchSdSAL8QZU93u7utA+y7M8Amp3tayn7Y
	 IO9csEQOJKBi0mYDUlEtitpv2pCrsfPbqVoQ3xYe9TAcL3iY//3waB8c/VPB78CrOt
	 4joM5dCTU2faTdJvacgFSKLJK8cYRtNhLvtQiqA4=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4bBVs15hNzzDkc;
	Tue,  3 Jun 2025 14:49:09 +0200 (CEST)
Date: Tue, 3 Jun 2025 14:49:09 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Jan Kara <jack@suse.cz>
Cc: Song Liu <song@kernel.org>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Christian Brauner <brauner@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Amir Goldstein <amir73il@gmail.com>, repnop@google.com, 
	Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH bpf-next 3/4] bpf: Introduce path iterator
Message-ID: <20250603.be1ahteePh8z@digikod.net>
References: <20250528222623.1373000-1-song@kernel.org>
 <20250528222623.1373000-4-song@kernel.org>
 <20250528223724.GE2023217@ZenIV>
 <yti2dilasy7b3tu6iin5pugkn6oevdswrwoy6gorudb7x2cqhh@nqb3gcyxg4by>
 <CAPhsuW4tg+bXU41fhAaS0n74d_a_KCFGvy_vkQOj7v4VLie2wg@mail.gmail.com>
 <CAADnVQ+UGsvfAM8-E8Ft3neFkz4+TjE=rPbP1sw1m5_4H9BPNg@mail.gmail.com>
 <CAPhsuW78L8WUkKz8iJ1whrZ2gLJR+7Kh59eFrSXvrxP0DwMGig@mail.gmail.com>
 <20250530.oh5pahH9Nui9@digikod.net>
 <vumjuw5ha6jtxtadsr5vwjtuneeqfg3vpydciczsn75qdg2ekv@464a4dxtxx27>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <vumjuw5ha6jtxtadsr5vwjtuneeqfg3vpydciczsn75qdg2ekv@464a4dxtxx27>
X-Infomaniak-Routing: alpha

On Tue, Jun 03, 2025 at 11:46:22AM +0200, Jan Kara wrote:
> On Fri 30-05-25 16:20:39, Mickaël Salaün wrote:
> > On Thu, May 29, 2025 at 10:05:59AM -0700, Song Liu wrote:
> > > On Thu, May 29, 2025 at 9:57 AM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > [...]
> > > > >
> > > > > How about we describe this as:
> > > > >
> > > > > Introduce a path iterator, which safely (no crash) walks a struct path.
> > > > > Without malicious parallel modifications, the walk is guaranteed to
> > > > > terminate. The sequence of dentries maybe surprising in presence
> > > > > of parallel directory or mount tree modifications and the iteration may
> > > > > not ever finish in face of parallel malicious directory tree manipulations.
> > > >
> > > > Hold on. If it's really the case then is the landlock susceptible
> > > > to this type of attack already ?
> > > > landlock may infinitely loop in the kernel ?
> > > 
> > > I think this only happens if the attacker can modify the mount or
> > > directory tree as fast as the walk, which is probably impossible
> > > in reality.
> > 
> > Yes, so this is not an infinite loop but an infinite race between the
> > kernel and a very fast malicious user space process with an infinite
> > number of available nested writable directories, that would also require
> > a filesystem (and a kernel) supporting infinite pathname length.
> 
> Well, you definitely don't need infinite pathname length. Example:
> 
> Have a dir hierarchy like:
> 
>   A
>  / \
> B   C
> |
> D
> 
> Start iterating from A/B/D, you climb up to A/B. In parallel atacker does:
> 
> mv A/B/ A/C/; mkdir A/B
> 
> Now by following parent you get to A/C. In parallel attaker does:
> 
> mv A/C/ A/B/; mkdir A/C
> 
> And now you are essentially where you've started so this can repeat
> forever.

Yes, this is the scenario I had in mind talking about "infinite race"
(instead of infinite loop).  For this to work it will require the
filesystem to support an infinite number of nested directories, but I'm
not sure which FS could be eligible.

Anyway, what would would be the threat model for this infinite race?

> 
> As others wrote this particular timing might be hard enough to hit for it
> to not be a practical attack but I would not bet much on somebody not being
> able to invent some variant that works, in particular with BPF iterator.

There might exist corner cases that could be an issue but would the
impact be different than with other kinds of path walk?

What could we do to avoid or limit such issue?

> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

