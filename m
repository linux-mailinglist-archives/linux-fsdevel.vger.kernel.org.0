Return-Path: <linux-fsdevel+bounces-50389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C68CACBCC7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 23:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 409703A535C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 21:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A63522CBD9;
	Mon,  2 Jun 2025 21:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLKRAjGi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB61722A4E1;
	Mon,  2 Jun 2025 21:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748900398; cv=none; b=ci3uEDl/VyOby/CV8vIOi6Vo03fCi9KoBbHysSgoDcSIbrTpTujOYUjZyhiC4L9p9XPhyA3OPqF66/8f+LfyuLMKV6s1K6izxQUL2W9M4ipdz/9flUwibdiFJfflCJLLaCJdyMiV5gYDxBqoBMoH0b2PaO6zpwJ8k35fJW4QfXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748900398; c=relaxed/simple;
	bh=D5rMwgMuw7vFEBLzBjHtdZTfsg5qAmhgT0qIubto9J4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RQv02A9q7Fh9She5cofbobYrg2P9mC163sdWSkvZ1Y1xa71Xmu2eSBWl1+bIashl2ppSMRbLoTStetbgKbZbYR4HnQi0EvD9GElVjFQe6dZmS9/9hOnj5mGF+5Koo6me8XEr16shIRYSpgCKKgVWZBK6IlJvhTkvzaVKXYSrXPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLKRAjGi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3251BC4CEF9;
	Mon,  2 Jun 2025 21:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748900398;
	bh=D5rMwgMuw7vFEBLzBjHtdZTfsg5qAmhgT0qIubto9J4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HLKRAjGigSWDLuFnxM8vofEHocn+JaqHR5pGIkrgYeAW9be3PE/2mdjXlbixptb1b
	 +cczS7ulkWOezL95LKGr+vc7fxZvxUSTB8TjnAW6Dns7BujG4ebPMBc2orA0uVW/8V
	 rPoHCnWMnbRUE7wqBffUXbNgFxj3ELkLnjOjAojnaqmmcqN9/ASdBGrFxCZV7vBLwR
	 qv3aQ6dXZSfZ6qEgo1ishXxI1LPnExdY3nQ3wW4kX8EkRAfCsubEzqg0YNJbYwVkWu
	 dZ0TXpJLBMduAS2nqLZqwITfT6HsO6xv9E+3PmeM137n683ixBcQZyjRhUvZ0w9har
	 enoLdX9N4N7ig==
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4a56cc0def0so37242801cf.3;
        Mon, 02 Jun 2025 14:39:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUNVHiAu7LWdfaxaglj5qLv88bNA+MgkqknGfbmVnRANrvssnfDcSny5yGAHxXgLNdWNY/8vsu3wDquXPlUxk6ZqZbzEVz6@vger.kernel.org, AJvYcCVu7CQalzFvMl7wdmaULg/Oc2UDMGGe7HHAudyO3mUfInmPb29E99sd/lEe7MFNfaL8CF8=@vger.kernel.org, AJvYcCWC9tlzIqAOPkaze1xpuN6vR/UwA/9D+6AdUjOLPI1JgmRSUOUy5sd9A3fCg4FVr0t0n6ej3vcLLvzyYfNc@vger.kernel.org, AJvYcCXf8q8HZdk7kA/5BAPuWmpEq57S1ds9U1xXfhDr30QzJor0VLYnd4nm4App55o6+bc2y8e3lWEUx5i3cKGrdw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJq6YHQR17zggIjERDTpOJc7dNTTrESVBpR/ye4CilillTM1zA
	P4+9rIx+2cEfnHAJQMIyhC3GhgjsclHt66QwyCsmpTC4CcAVvwhUhRKjmFuCW7L9yCdm+1Xn59U
	+HJ96hiiA3Q5lphcQ0OKJNzdOwCWSOVM=
X-Google-Smtp-Source: AGHT+IEl19xYKphp6ScpotIBp7vISmshyLgOHscf74bsxVvcAveqQtSi4J8d9EExxhp1QPyLAmlOFMD+xXrQ1asLmnM=
X-Received: by 2002:a05:622a:8ca:b0:4a4:31e2:2e77 with SMTP id
 d75a77b69052e-4a4aed6d87fmr194893451cf.50.1748900397157; Mon, 02 Jun 2025
 14:39:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528222623.1373000-1-song@kernel.org> <20250528222623.1373000-4-song@kernel.org>
 <20250528223724.GE2023217@ZenIV> <yti2dilasy7b3tu6iin5pugkn6oevdswrwoy6gorudb7x2cqhh@nqb3gcyxg4by>
 <CAPhsuW4tg+bXU41fhAaS0n74d_a_KCFGvy_vkQOj7v4VLie2wg@mail.gmail.com>
 <20250529173810.GJ2023217@ZenIV> <CAPhsuW5pAvH3E1dVa85Kx2QsUSheSLobEMg-b0mOdtyfm7s4ug@mail.gmail.com>
 <20250602-lustig-erkennbar-7ef28fa97e20@brauner> <CAPhsuW7ogestn8Cc2jac2O0fnWcH_w=HuZQiSOx0umM4uT6Whg@mail.gmail.com>
 <CAADnVQ+_T2UTVQA9XXew26XR8zqhNpwX33Uy_pVW0_7s-bexLg@mail.gmail.com>
In-Reply-To: <CAADnVQ+_T2UTVQA9XXew26XR8zqhNpwX33Uy_pVW0_7s-bexLg@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Mon, 2 Jun 2025 14:39:43 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4JRgWDJNp5yysH1xNvaXCLg3c_QEHAMiuCwzbZ7e-hhQ@mail.gmail.com>
X-Gm-Features: AX0GCFskcyFCGev_LYvQ3JP4unXF6FRY_i6cg5E06f6c2dBU7o8khi7-pZnJUk0
Message-ID: <CAPhsuW4JRgWDJNp5yysH1xNvaXCLg3c_QEHAMiuCwzbZ7e-hhQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/4] bpf: Introduce path iterator
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	bpf <bpf@vger.kernel.org>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Amir Goldstein <amir73il@gmail.com>, repnop@google.com, 
	Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 2, 2025 at 8:40=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Jun 2, 2025 at 6:27=E2=80=AFAM Song Liu <song@kernel.org> wrote:
> >
> > On Mon, Jun 2, 2025 at 2:27=E2=80=AFAM Christian Brauner <brauner@kerne=
l.org> wrote:
> > >
> > > On Thu, May 29, 2025 at 11:00:51AM -0700, Song Liu wrote:
> > > > On Thu, May 29, 2025 at 10:38=E2=80=AFAM Al Viro <viro@zeniv.linux.=
org.uk> wrote:
> > > > >
> > > > > On Thu, May 29, 2025 at 09:53:21AM -0700, Song Liu wrote:
> > > > >
> > > > > > Current version of path iterator only supports walking towards =
the root,
> > > > > > with helper path_parent. But the path iterator API can be exten=
ded
> > > > > > to cover other use cases.
> > > > >
> > > > > Clarify the last part, please - call me paranoid, but that sounds=
 like
> > > > > a beginning of something that really should be discussed upfront.
> > > >
> > > > We don't have any plan with future use cases yet. The only example
> > > > I mentioned in the original version of the commit log is "walk the
> > > > mount tree". IOW, it is similar to the current iterator, but skips =
non
> > > > mount point iterations.
> > > >
> > > > Since we call it "path iterator", it might make sense to add ways t=
o
> > > > iterate the VFS tree in different patterns. For example, we may
> > >
> > > No, we're not adding a swiss-army knife for consumption by out-of-tre=
e
> > > code. I'm not opposed to adding a sane iterator for targeted use-case=
s
> > > with a clear scope and internal API behavior as I've said multiple ti=
mes
> > > already on-list and in-person.
> > >
> > > I will not merge anything that will endup exploding into some fancy
> > > "walk subtrees in any order you want".
> >
> > We are not proposing (and AFAICT never proposed) to have a
> > swiss-army knife that "walk subtrees in any order you want". Instead,
> > we are proposing a sane iterator that serves exactly one use case
> > now. I guess the concern is that it looks extensible. However, I made
> > the API like this so that it can be extended, with thorough reviews, to
> > cover another sane use case. If there is still concern with this. We
> > sure can make current code not extensible. In case there is a
> > different sane use case, we will introduce another iterator after
> > thorough reviews.
>
> It's good that the iterator is extensible, but to achieve that
> there is no need to introduce "enum bpf_path_iter_mode"
> which implies some unknown walk patterns.
> Just add "u64 flags" to bpf_iter_path_new() and
> if (!flags) return -EINVAL;
> Then we'll have a way to extend that kfunc if really necessary.
> Deleting and introducing new kfuncs/iterators is not a big deal,
> but reserving 'flags' as an option for extension is almost
> always a good backup.

Sounds good! I will prepare v2 with a flags field.

Thanks,
Song

