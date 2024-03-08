Return-Path: <linux-fsdevel+bounces-13968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4609875CB0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 04:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57B951F21DCA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 03:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF0C2C1A5;
	Fri,  8 Mar 2024 03:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBfqqBdb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACB45C99;
	Fri,  8 Mar 2024 03:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709868320; cv=none; b=uBtxMIJd8ueH9aiUxHPnxmAffnZjtSHJdI0/vbQ8lGNuBmrhoqbT6X03A0jbK+QwZiIIM2Y6NIgxvk8XgdxjVkSZbTpGOOkv0WMiUr3toDJxXzDgJxBepYGYCs7emJrBd1Mjr7nazO/zQycUOs5bIYn4q7qg8LFsHNGsRcLykMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709868320; c=relaxed/simple;
	bh=ljjWsD0mkDW6S5Z8l+KmzlJNgsYlODKfPIHn5+hvqcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BcTMxG2QEEMcs/U/O3zSbytPF8xY1bk48Ydok51QIDqvstQ0hc25H7LTJ4pTJyEY1aEph6iTo95K0RLKFxGNdvVJ1DRk3JfNRG7UXZdYrEEu0fDzaHAs9J4RpNM9hrMGJTO4SBC+pTdUJCwlQhaCgKAwDDUqywPngR3Y4Txqdx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBfqqBdb; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d2ab9c5e83so14878571fa.2;
        Thu, 07 Mar 2024 19:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709868317; x=1710473117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPSiClXTZkXxOQQM7cnS4xIuIQY9WF4sDtVpHq+rPH4=;
        b=nBfqqBdb+53k1lzUHcw+HWgK9LU1RS7wVFOOi5GnVRCNG0u5RU2xLOA4OqgCw4baHx
         jDjOFxhZkjtwL5iDDX8yyEJCIYCEu4h+Ov4E7YzkpFr9/jQD1X9dwhsrPp9wxinzkxRc
         46CFQ+SwXYRvrzQRsAmY628IWmqnNKkHmpQ+Xw51OzG3xvS/7YFBel07xH1kZMCj7fme
         nEbL+tWv5lJwGa9TGqTZX8PMBqBPM5osOGoQBhRMmy23DKUib3Uk004LhIgmcLHrn2m/
         FrEJRBuo5aY1mmkZrXsm3F4r+/U7086VbgleO8gQ1VX10iblcMmMXIHjbVxPNEzBF95m
         pN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709868317; x=1710473117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LPSiClXTZkXxOQQM7cnS4xIuIQY9WF4sDtVpHq+rPH4=;
        b=KKMSq6FHO9zRAx2Q6n84ctpVQRajkvhB0F+bW7MR2nj4itP+Bm9wCl5quDmC8oaK5+
         O66B31ezRjCW9VW9yFj901+OfNEIZhvVGfdyjYlRS09b0mfgP9UYe8Y9Q91ul2sXRfPo
         l5LI/EtqVJShv9KRHAOwN8uH0RKcy+hq/ycO1z4/8wkuqncuEO9496idezrGSq51DeAk
         xoQk9Kn6E2iCgdzkkEAUVyUpu1y3Nkjcu4pXzzMQN+LxrBW7VdPD057baPVt9D6tVOYK
         qOQMUu3XnHftwcYbhu2NreeHMMCYcYHN09HtRuaUOdSWzcsv67pW6i8OjKKOQIp3+WQ4
         cbBw==
X-Forwarded-Encrypted: i=1; AJvYcCUTrAF3J8kkrg6Wmq+zIMgdh3ZeB71bM/+dHBTzGIaK5pCwBvQdF2kJl0IEY8Ghmn/54XAxI3vm7+JvOJ/4AflZjpHspvRkbWAnN3pNbLZdTS9nap4XtD6CITeCOIyEEEXboAeD15VGXmSEAzMNOjeAODPXmC8WnAjmaoF3SXL+9s9bafKZG2pd3Q==
X-Gm-Message-State: AOJu0YznYp6zAsUa0Bv+PDAcIGgnEu+UlhEMVZTSQXq03SAOvmSB7OlQ
	aM+q3r/piMJW8QN9sMeKQ72XAChj8OhxytKiE98guQHiswny0sq65YwHKWt8P8Em/pI44t+N+FQ
	5kPOlpq+Irj7K0d+xnlbNcPr+ghU=
X-Google-Smtp-Source: AGHT+IFSVbbuqmWwNNTZOd4k0Y+Frt5MCyeYjJjNoXLplH7e4td4X/jthidRHH/iK8DjOzl55b03fcskIUPEJP5DWjE=
X-Received: by 2002:a05:6512:1250:b0:513:95b6:2e79 with SMTP id
 fb16-20020a056512125000b0051395b62e79mr222993lfb.69.1709868316510; Thu, 07
 Mar 2024 19:25:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1709675979.git.mattbobrowski@google.com>
 <20240306-flach-tragbar-b2b3c531bf0d@brauner> <20240306-sandgrube-flora-a61409c2f10c@brauner>
 <CAADnVQ+RBV_rJx5LCtCiW-TWZ5DCOPz1V3ga_fc__RmL_6xgOg@mail.gmail.com>
 <20240307-phosphor-entnahmen-8ef28b782abf@brauner> <CAHC9VhTbjzS88uU=7Pau7tzsYD+UW5=3TGw2qkqrA5a-GVunrQ@mail.gmail.com>
In-Reply-To: <CAHC9VhTbjzS88uU=7Pau7tzsYD+UW5=3TGw2qkqrA5a-GVunrQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 7 Mar 2024 19:25:05 -0800
Message-ID: <CAADnVQLQ8uVaSKx-zth1HTT44T3ZC8C1cyNxxuhPMqywGVV9Pw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 0/9] add new acquire/release BPF kfuncs
To: Paul Moore <paul@paul-moore.com>
Cc: Christian Brauner <brauner@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, KP Singh <kpsingh@google.com>, Jann Horn <jannh@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mm <linux-mm@kvack.org>, LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 12:51=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, Mar 7, 2024 at 4:55=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
> >
> > There's one fundamental question here that we'll need an official answe=
r to:
> >
> > Is it ok for an out-of-tree BPF LSM program, that nobody has ever seen
> > to request access to various helpers in the kernel?
>
> Phrased in a slightly different way, and a bit more generalized: do we
> treat out-of-tree BPF programs the same as we do with out-of-tree
> kernel modules?  I believe that's the real question, and if we answer
> that, we should also have our answer for the internal helper function
> question.

From 10k ft view bpf programs may look like kernel modules,
but looking closely they are very different.

Modules can read/write any data structure and can call any exported functio=
n.
All modules fall into two categories GPL or not.
While bpf progs are divided by program type.
Tracing progs can read any kernel memory safely via probe_read_kernel.
Networking prog can read/write packets, but cannot read kernel memory.
bpf_lsm programs can be called from lsm hooks and
call only kfuncs that were explicitly allowlisted to bpf_lsm prog type.
Furthermore kfuncs have acquire/release semantics enforced by
the verifier.
For example, bpf progs can do bpf_rcu_read_lock() which is
a wrapper around rcu_read_lock() and the verifier will make sure
that bpf_rcu_read_unlock() is called.
Under bpf_rcu_read_lock() bpf programs can dereference __rcu tagged
fields and the verifier will track them as rcu protected objects
until bpf_rcu_read_unlock().
In other words the verifier is doing sparse-on-steroids analysis
and enforcing it.
Kernel modules are not subject to such enforcement.

One more distinction: 99.9% of bpf features require a GPL-ed bpf program.
All kfuncs are GPL only.

