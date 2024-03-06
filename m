Return-Path: <linux-fsdevel+bounces-13826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC2B874227
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 22:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7686FB21295
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 21:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F356B1B947;
	Wed,  6 Mar 2024 21:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GMWRJpPP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38821B810
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Mar 2024 21:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709761479; cv=none; b=nNNqODEdD27M+k0FxRyjHR2GYllaxgZiB03g/jxp84qmLhUxtyfjXxm+Nbjw+1NpnTDTkgeept5TrgxPQtUwOOU0JRKnNm4tA7/VVVznry/mQ+MD2rk6K9jbU7+uxhbMG4gk/qfLHAhTBHBcbMVY6gaiieiVPbgKXuwmi8HVK3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709761479; c=relaxed/simple;
	bh=yNaF3aOi4krieU8CScidoOzuFos1k7RPbwb2c+R3EAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hyCPNE2jeHNuB9kYmhPK1SmHw57MyBeeypyKXSXEDUgQCY92zjtqdjFydVSUrYlDnkMF+Pn7SVsSHxUX3k69Hm7udS6LkUZgvJYZD6/mUuWRpThKqZPRT5CHt+rmxJWSWTORcBKbwxMYS5OCYRyaL5n4Xg5ylI9I6b15/eu1HOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GMWRJpPP; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dccb1421bdeso159828276.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Mar 2024 13:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1709761477; x=1710366277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TzexKeqTYViWR529/99I1fk8au39z5xjVC/HT3MU//k=;
        b=GMWRJpPPMthfHkO/3mq37QeOIq2uoWFcOxQyZo0N7MzgVddAZm0Xsmxw+HKiozNpn2
         kZY5LQ/xQ2QASR+m3Q6zFokh5pS9eI6EZpUXHjHkEQeP/CQSIm9UF0Ue7Bv29J0MjPd5
         aphzYpGdu/pwM4vaaUnZaE+fpAqbWmO/XENeEfv+fGgZFlcS7J1XVRDOfvHehgOMhC4E
         Kt+rTdUmIGCCMiRtm42JzXDwrZp+LqMY+cq2/nHQTb9bR8+5IBZOpBOlMBnT3go9AvTV
         HzpWy8OMSu9DG/R/FJtZ2Npq7DNNMlZigIv+ESvunOP3wY57XBp25Ychcj/BpUXJtAco
         8ALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709761477; x=1710366277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TzexKeqTYViWR529/99I1fk8au39z5xjVC/HT3MU//k=;
        b=SBh4Zk4e0yDmqeCHjuUe65ggJRKJHTsQxxNsKuVZvex1SuoiO5JxE0WkK9AVePDS7r
         znVIvYWeYuilvWZMXy3Avt9c1L2BHiXjH34Jt0L1aJm3uza++w3oGrP3WCj7/q1/w3uI
         qTp2RvRWygI3xQIHa3H4OzKK3uo3OHO0LuskRNN1kKSEXVxeuuNdBCN8Y0XkSjtTZA+Z
         6inPOpsfIF/s8t575aGRhHcM+2qycKkzmWofvafEzEuZu7a4QGQNl+FHl4333gVyQow+
         lTYcNsBy901UQt/bru2UVjCH7wRTopAhOHlhTIEH8tQYNAMTt1Fm2D7JfrIP0suWpgtZ
         1i1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUHYrZsoPffz2x0N6+2U5KvOJzcYKdvhMuZtTIQ61yEv0lsnmeGOiHbCVnD0fsuNUpcmIctwMrRlx+p5YbZrC1/Iv2pAK9xfD3ifVmuuw==
X-Gm-Message-State: AOJu0YxCKM9rtxml9Ly1RD2n3kMq9KtmrmncP4wD3tYwUz0iNBGPvsWy
	Vy6mHznBpDqEjv+NXqLhK2s2ZwzAKdf5okFmSh6I0479BQeGfoWSs0qeOvJySXD38gKiTwBhBh0
	0fqAmV+qjsD4ctFvrTYWFOYu/c/hyaiYYGEcD
X-Google-Smtp-Source: AGHT+IHiRNoOuP50M05G+2934mcfs5/bOqVRy3BWxHsLB6KirZP8Ll5YoDYeUaTCCUruZFAXGTfcnQL/dVPSyIP0Lgw=
X-Received: by 2002:a25:5102:0:b0:dc6:d738:1fa6 with SMTP id
 f2-20020a255102000000b00dc6d7381fa6mr12722660ybb.6.1709761476718; Wed, 06 Mar
 2024 13:44:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1709675979.git.mattbobrowski@google.com>
 <20240306-flach-tragbar-b2b3c531bf0d@brauner> <20240306-sandgrube-flora-a61409c2f10c@brauner>
In-Reply-To: <20240306-sandgrube-flora-a61409c2f10c@brauner>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 6 Mar 2024 16:44:25 -0500
Message-ID: <CAHC9VhRSydKRpNQOEeyG1SYZi5r36dSa=auXcbh6srA02eaRdw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 0/9] add new acquire/release BPF kfuncs
To: Christian Brauner <brauner@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, kpsingh@google.com, 
	jannh@google.com, jolsa@kernel.org, daniel@iogearbox.net, 
	torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 7:14=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
> On Wed, Mar 06, 2024 at 12:21:28PM +0100, Christian Brauner wrote:
> > On Wed, Mar 06, 2024 at 07:39:14AM +0000, Matt Bobrowski wrote:
> > > G'day All,
> > >
> > > The original cover letter providing background context and motivating
> > > factors around the needs for the BPF kfuncs introduced within this
> > > patch series can be found here [0], so please do reference that if
> > > need be.
> > >
> > > Notably, one of the main contention points within v1 of this patch
> > > series was that we were effectively leaning on some preexisting
> > > in-kernel APIs such as get_task_exe_file() and get_mm_exe_file()
> > > within some of the newly introduced BPF kfuncs. As noted in my
> > > response here [1] though, I struggle to understand the technical
> > > reasoning behind why exposing such in-kernel helpers, specifically
> > > only to BPF LSM program types in the form of BPF kfuncs, is inherentl=
y
> > > a terrible idea. So, until someone provides me with a sound technical
> > > explanation as to why this cannot or should not be done, I'll continu=
e
> > > to lean on them. The alternative is to reimplement the necessary
> > > in-kernel APIs within the BPF kfuncs, but that's just nonsensical IMO=
.
> >
> > You may lean as much as you like. What I've reacted to is that you've
> > (not you specifically, I'm sure) messed up. You've exposed d_path() to
> > users  without understanding that it wasn't safe apparently.
> >
> > And now we get patches that use the self-inflicted brokeness as an
> > argument to expose a bunch of other low-level helpers to fix that.
> >
> > The fact that it's "just bpf LSM" programs doesn't alleviate any
> > concerns whatsoever. Not just because that is just an entry vector but
> > also because we have LSMs induced API abuse that we only ever get to se=
e
> > the fallout from when we refactor apis and then it causes pain for the =
vfs.

Let's not start throwing stones at the in-tree, native LSM folks;
instead let's just all admit that it's often a challenge working
across subsystem lines, but we usually find a way because we all want
the kernel to move forward.  We've all got our grudges and scars,
let's not start poking each other with sticks.

> > I'll take another look at the proposed helpers you need as bpf kfuncs
> > and I'll give my best not to be overly annoyed by all of this. I have n=
o
> > intention of not helping you quite the opposite but I'm annoyed that
> > we're here in the first place.
> >
> > What I want is to stop this madness of exposing stuff to users without
> > fully understanding it's semantics and required guarantees.
>
> So, looking at this series you're now asking us to expose:
>
> (1) mmgrab()
> (2) mmput()
> (3) fput()
> (5) get_mm_exe_file()
> (4) get_task_exe_file()
> (7) get_task_fs_pwd()
> (6) get_task_fs_root()
> (8) path_get()
> (9) path_put()
>
> in one go and the justification in all patches amounts to "This is
> common in some BPF LSM programs".
>
> So, broken stuff got exposed to users or at least a broken BPF LSM
> program was written somewhere out there that is susceptible to UAFs
> becauase you didn't restrict bpf_d_path() to trusted pointer arguments.
> So you're now scrambling to fix this by asking for a bunch of low-level
> exports.
>
> What is the guarantee that you don't end up writing another BPF LSM that
> abuses these exports in a way that causes even more issues and then
> someone else comes back asking for the next round of bpf funcs to be
> exposed to fix it.
>
> The difference between a regular LSM asking about this and a BPF LSM
> program is that we can see in the hook implementation what the LSM
> intends to do with this and we can judge whether that's safe or not.

I wish things were different, but the current reality is that from a
practical perspective BPF LSMs are not much different than
out-of-tree, native LSMs.  There is no requirement, or even
convention, for BPF LSMs to post their designs, docs, or
implementations on the LSM list for review like we do with other LSMs;
maybe it has happened once or twice, but I can't remember the last
time I saw a serious BPF LSM posted to the LSM list.  Even if someone
did do The Right Thing with their BPF LSM and proposed it for review
just like a native LSM, there is no guarantee someone else couldn't
fork that LSM and do something wrong (intentional or not).

Unless something changes, I'm left to treat BPF LSMs the same as any
other out-of-tree kernel code: I'm not going to make life difficult
for a /out-of-tree/BPF/ LSM simply because it is /out-of-tree/BPF/,
but I'm not going to do anything to negatively impact the current, or
future, state of the in-tree LSMs simply to appease the
/out-of-tree/BPF/ LSMs.

--=20
paul-moore.com

