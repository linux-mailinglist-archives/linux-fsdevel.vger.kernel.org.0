Return-Path: <linux-fsdevel+bounces-56054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B86AB1249E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 21:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0A231CC1CCF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 19:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B7F254877;
	Fri, 25 Jul 2025 19:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DnS9beiT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A01257AC8
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Jul 2025 19:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753470665; cv=none; b=uS2+PaxFDLwaxm8twduMPhkkupBSG9xOjQ66FIkufmpTgO0ICccVUC1nZAMZ34ePeUQYYJlLD7Y8EMMq8WnmwtWd+oQfxVoRIR9DuUj1cotn9lewUn8e2q+bEFBGX7mIRU64Qj5v2gZtXjN4vOuPlhJQ01MMjk2QmRcsQgjHCBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753470665; c=relaxed/simple;
	bh=ohbQ5KF8b/EeqfVu3tRLb4Pn8KVgHa3I47YPvi58yJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZiCaw022dj7G9tIhDA5it9EvxSP8nj3DiMzi/Hlf2ZRthMsiqS5ZsBp55LWJd3eqki5ku1Mwmx44fQRy3TwqMtVl3F1pOuNaaoQ/+zoCCcg3lTAd07PSVy8GHV/NaxhEgyRvu3Cg0Eq7v/uNT2TJV7B1wrG3dCK/yk6ZEy9iEvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DnS9beiT; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-611d32903d5so2114a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Jul 2025 12:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753470662; x=1754075462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ohbQ5KF8b/EeqfVu3tRLb4Pn8KVgHa3I47YPvi58yJM=;
        b=DnS9beiT7uXsPw3bRisI+ErVdWds8WtJYyqV1d5E2WN2ZE0H2wuraqH+6Dl88gV9Nx
         IqqgSxSFfnH1JEtdCymc9KolcD+WMl9AOtqvqx+sLOAS5P7FxKyHPltmWPOtq+VIvnpC
         D8HlKLGnF3KG9cEcP3MbZrtG6WtdQTdF4FwHrV7rGNvGJvRZwUJcVQYuBrKswmlivJSI
         p4U7orPNmLOGN88jwxyzKOss11JcJBKZgTvRnYmDX3mpvRtHJCaYHfxfwG3Sws5gNekF
         dswdqL0KSeD08UVsbSFKzLgtR60KvO5BYuvUoCDiLHJwTc6tTZJb4bQIfpKNrTBEfugc
         IFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753470662; x=1754075462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ohbQ5KF8b/EeqfVu3tRLb4Pn8KVgHa3I47YPvi58yJM=;
        b=shrbdvGkJiwJ0dnHulU4baUzhBoyBX8A1DP2qQEmE604dy93vUhwWiyOoJobDxrN1s
         3yIZ4cAIyUHP45SVmaRojZYiwGyXO1lHoTbM0fq1MXi5GaqUX1SnwIkHOfvC8VzNF/c+
         gB/MExjkMddoIqbiKGstxylD3POLY7eDTOxzccIYK1Yw+yn6kTEUKDJiKVyO18fgQIK9
         OlKQeb1tZrW8u5Zkls9w+lepFC3TAMXfyDbgwp4/8Ns/6cRR3YQbaOx51WnzE63wYRBH
         hPhZKswKoEHS6aSw2YjPDj4l6+/okJJ5ZMklI9KGql340uICDErKZCbywM9QLDyc5L4o
         nQrg==
X-Forwarded-Encrypted: i=1; AJvYcCUvUCLQY7fOrmcU4MAfcDiKhw8SHs5vg04BwAj3qm4feWOW9uz3YbHTYjkeZyZp4+FENenlXIOvInXVAcg7@vger.kernel.org
X-Gm-Message-State: AOJu0YzDwCgBeQk+u0eOpKuOqmHpgvwlo+Bv14VqMtphGNkCCnfzlLT6
	1jSVHk677izCVn9WpH4riRjLWZX3dZsJiXkWxDIQIvsKe/RdB6LQf8Btrk92Fs1HibwRiZoHTB/
	b4Csgo4utxBpXaCRFXuArrIXyvu7RcJBtGYQ73uj6
X-Gm-Gg: ASbGncujjkc4risnuEeCiHdWcOEpRDKvk4VByKE+kT63sREsGyGSCs9JpmWQZITLKSx
	xTrO6XO+VGdBReSr49Wqp+HViJolZY/gFj9drNgSP2E/l1LP2tSuooQoNaNYqIMOwzlQaosaExN
	UjF6mgMos6jYcXOAFHsN9Y9ITDi+aF9bsH9Yip6+lLT/ifCa1lVgrzybF0yMK6wf9WeLYOXWrRF
	NNLhARL5napoBh4FKc9I46lxY1D+rZHa90=
X-Google-Smtp-Source: AGHT+IFnM9lb8v0yhy+r9g7LlejQ85g1+jN80aPjt0EXGFDmgpf5XaZMiO20Q6d8dkFVzoj7t44+LzAH3gV+dXXjqTY=
X-Received: by 2002:a05:6402:2088:b0:607:bd2:4757 with SMTP id
 4fb4d7f45d1cf-61505ca9e53mr18025a12.1.1753470661523; Fri, 25 Jul 2025
 12:11:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1752232673.git.lorenzo.stoakes@oracle.com>
 <8f41e72b0543953d277e96d5e67a52f287cdbac3.1752232673.git.lorenzo.stoakes@oracle.com>
 <CAG48ez0KjHHAWsJo76GuuYYaFCH=3n7axN2ryxy7-Vabp5JA-Q@mail.gmail.com> <892e3e49-dbcd-4c1f-9966-c004d63f52df@lucifer.local>
In-Reply-To: <892e3e49-dbcd-4c1f-9966-c004d63f52df@lucifer.local>
From: Jann Horn <jannh@google.com>
Date: Fri, 25 Jul 2025 21:10:25 +0200
X-Gm-Features: Ac12FXzH0kaDd1FSHQ6rjBvK5l93OfpQZvkg8iFQz3nK0xtBEz9RE_fXG7JCCE8
Message-ID: <CAG48ez3qB7W3JqjrkkQ3SRdQNza3Q9noqkgmBg=3F_8vhwQ4gQ@mail.gmail.com>
Subject: Re: [PATCH v3 09/10] mm/mremap: permit mremap() move of multiple VMAs
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 7:28=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> On Fri, Jul 25, 2025 at 07:11:49PM +0200, Jann Horn wrote:
> > On Fri, Jul 11, 2025 at 1:38=E2=80=AFPM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > > Note that any failures encountered will result in a partial move. Sin=
ce an
> > > mremap() can fail at any time, this might result in only some of the =
VMAs
> > > being moved.
> > >
> > > Note that failures are very rare and typically require an out of a me=
mory
> > > condition or a mapping limit condition to be hit, assuming the VMAs b=
eing
> > > moved are valid.
> >
> > Hrm. So if userspace tries to move a series of VMAs with mremap(), and
> > the operation fails, and userspace assumes the old syscall semantics,
> > userspace could assume that its memory is still at the old address,
> > when that's actually not true; and if userspace tries to access it
> > there, userspace UAF happens?
>
> At 6pm on the last day of the cycle? :) dude :) this long week gets ever
> longer...

To be clear, I very much do not expect you to instantly reply to
random patch review mail I send you late on a Friday evening. :P

> Otherwise for mapping limit we likely hit it right away. I moved all the
> checks up front for standard VMA/param errors.

Ah, I missed that part.

