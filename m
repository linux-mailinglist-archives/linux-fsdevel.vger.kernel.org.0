Return-Path: <linux-fsdevel+bounces-50369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C38ACB916
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 17:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B04B940851
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 15:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD055221FD6;
	Mon,  2 Jun 2025 15:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApJVqihv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BF120E026;
	Mon,  2 Jun 2025 15:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748878822; cv=none; b=iCYy3cEHAXY0v9H/WemWOIOYFRNcB97+4GpqXOsKj1OGHAiZxLkEgQF1ont/s9FC4UYTZeL7zNxG1zggbqLRTAWLfXPwYJP7Wwzj//mEm5LDJDwgi4IJWhXM5kPelvk9W0Wcte4I1eKutiTcPvPD0f3yMpfkLKvlWOhpJwhnZKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748878822; c=relaxed/simple;
	bh=R9Y05yx+OBDd8zhRYutvh4ZOz89p/wmEiP+mhd2CITM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EU7ow+D82+6hZQQ1/j7DrmcDYDsttRIXQfdj8HQjMgPwsL4mqTfmt8/YLccClEKmBDJEbM1onxO+RVnjntoifuL161n1gE7pTXk+vJIJPa1i1S7rBz+IiRleb7PcffNWGx/fQbTzGEffVf9HF3LuygslbvOAThDxgFXOHtAM08U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ApJVqihv; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-450cfb790f7so33589025e9.0;
        Mon, 02 Jun 2025 08:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748878815; x=1749483615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9Y05yx+OBDd8zhRYutvh4ZOz89p/wmEiP+mhd2CITM=;
        b=ApJVqihv/KOFu0lSmE3lUUiFFln46DU6VgXZ3hdBYn5DQ8xOuN9guJ1Q79sAj8YAIr
         7pGEfXFlkVobw9AvjbYadwx3idjFKLYXC+m20mbXQh4/+H1pjqYXu4Od6RsjgfMctnpr
         l+Ex5/s5lS59CQdUcF5pZEacqoKk/nIyl8DCTmy0ijtJk+3ohNS0zZCQ7fART2OcTAdw
         xyr0BvWSGQVRiii8Bpy0kFfMhC5TE7ebaAFpLr2l4QzD7B1pdKxLo6rPGHGTBHyIEysv
         En1JjJmUxKSNI5KPgEN72G3gAdftyZGGm2l9uKAaG/5bz9wT8UJqn1PVqDiJmKWXQdJF
         3NAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748878815; x=1749483615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R9Y05yx+OBDd8zhRYutvh4ZOz89p/wmEiP+mhd2CITM=;
        b=fjqPWDwXY8VsWa+fuF5CG1YPLctPTomJEZ33kDTI5DUvKvVsr3/hQn2p1P7Is74lmJ
         YWnygZceVoa12kA2KV9BBZGIjVRiBKZEILzuEZSPcQlV8AdRxfhrsKP1LZwYcncRDW5Y
         rsLC6rszLGdlkVmdZDOMKizdpspInb9UMsAx/hHV0wWnDKpLakNB6NH4hVHJnNyHv1/v
         +mhjKmVteIQ8GDRHJYIgQPs6tRUKNoxI5amEEsu8ga1WvR5z8oseTXCzjFJUcur1jKlr
         WY9nAFaRy42KryltCyHL4wNM68OpBeoTw4B953t6hMeGCvg9iOBUGbIfEYTXi0Hzdxzz
         RDHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEiApueDQJiH3Gk1I5iJ2r20281f9deK0PMH7e5lqAJVKKgkxy2IVLqV4Z/P3wflSmhpVYotUVgIWXvW3vXg==@vger.kernel.org, AJvYcCUU2q7y08Z8sm2siYidljW5m0f3K12scdXNjUOtYTwsXJTpVXkGe7g0QucjoTcz7eIOvyvEe91a3+Cv95jWuFA0bXSKnKgy@vger.kernel.org, AJvYcCUiBIx5xdrztXGJ1UiGSlosEo3p58rSQwe5RA7I285hhSiHEzY+fltQDIYczZke4gve+Xd6dt3hkWr5nBvY@vger.kernel.org, AJvYcCWlOrC67kasOckFY4fcHPDap9HrMa3jHqdXgWGTWrCOx3+8TgOmdDy6A/Xs+qfKnWxsCk8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7lmQ6LO/FLb3VffDTzy+rKh0Q/Ner0GBJtjiX5dGvvyabTLou
	JSjDhiKGWtDwXd3X3GU688p3sctSTB0HUa/juhQ9Z8hCdl0aQPfM33clQEr+ZyJT3gXZNAMhbXI
	IPD6FZ0QMI4pWQxr4iq7AwKLiVsgCWnY=
X-Gm-Gg: ASbGncsxpgKzOHZYUEstBMigNjl7weKOjJiNG35EVsL/MoXM9d6v4+rTiATKl+gq3tS
	vLkaABxaJ1ndML4bAdHnF5sP5i5dnzgGHZpCB7Bd7tUHfPaHl5V9fVsPMnlBgwJj2tdXiWRGM9Z
	+TS5qvkFgM202PehHH/gxh5A1AM5qkdNHJ9MHmrJcF75t7+yr6
X-Google-Smtp-Source: AGHT+IFai74334nUkxJO8w5i7tlfzv8GkZQi4oU8k6b4JJORHTZUz87sq7bnLWguHyTzue1p9YeSb9RxpKx7T9X2A3M=
X-Received: by 2002:a05:6000:26ca:b0:3a4:f787:9b58 with SMTP id
 ffacd0b85a97d-3a4f7ab515fmr11139438f8f.58.1748878814719; Mon, 02 Jun 2025
 08:40:14 -0700 (PDT)
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
In-Reply-To: <CAPhsuW7ogestn8Cc2jac2O0fnWcH_w=HuZQiSOx0umM4uT6Whg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 2 Jun 2025 08:40:03 -0700
X-Gm-Features: AX0GCFvmqNkDHrRfZbAR59KGnpN2AAawPk43bzGmffyFYbsau48MyukEK4A30P8
Message-ID: <CAADnVQ+_T2UTVQA9XXew26XR8zqhNpwX33Uy_pVW0_7s-bexLg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/4] bpf: Introduce path iterator
To: Song Liu <song@kernel.org>
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

On Mon, Jun 2, 2025 at 6:27=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> On Mon, Jun 2, 2025 at 2:27=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
> >
> > On Thu, May 29, 2025 at 11:00:51AM -0700, Song Liu wrote:
> > > On Thu, May 29, 2025 at 10:38=E2=80=AFAM Al Viro <viro@zeniv.linux.or=
g.uk> wrote:
> > > >
> > > > On Thu, May 29, 2025 at 09:53:21AM -0700, Song Liu wrote:
> > > >
> > > > > Current version of path iterator only supports walking towards th=
e root,
> > > > > with helper path_parent. But the path iterator API can be extende=
d
> > > > > to cover other use cases.
> > > >
> > > > Clarify the last part, please - call me paranoid, but that sounds l=
ike
> > > > a beginning of something that really should be discussed upfront.
> > >
> > > We don't have any plan with future use cases yet. The only example
> > > I mentioned in the original version of the commit log is "walk the
> > > mount tree". IOW, it is similar to the current iterator, but skips no=
n
> > > mount point iterations.
> > >
> > > Since we call it "path iterator", it might make sense to add ways to
> > > iterate the VFS tree in different patterns. For example, we may
> >
> > No, we're not adding a swiss-army knife for consumption by out-of-tree
> > code. I'm not opposed to adding a sane iterator for targeted use-cases
> > with a clear scope and internal API behavior as I've said multiple time=
s
> > already on-list and in-person.
> >
> > I will not merge anything that will endup exploding into some fancy
> > "walk subtrees in any order you want".
>
> We are not proposing (and AFAICT never proposed) to have a
> swiss-army knife that "walk subtrees in any order you want". Instead,
> we are proposing a sane iterator that serves exactly one use case
> now. I guess the concern is that it looks extensible. However, I made
> the API like this so that it can be extended, with thorough reviews, to
> cover another sane use case. If there is still concern with this. We
> sure can make current code not extensible. In case there is a
> different sane use case, we will introduce another iterator after
> thorough reviews.

It's good that the iterator is extensible, but to achieve that
there is no need to introduce "enum bpf_path_iter_mode"
which implies some unknown walk patterns.
Just add "u64 flags" to bpf_iter_path_new() and
if (!flags) return -EINVAL;
Then we'll have a way to extend that kfunc if really necessary.
Deleting and introducing new kfuncs/iterators is not a big deal,
but reserving 'flags' as an option for extension is almost
always a good backup.

