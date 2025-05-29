Return-Path: <linux-fsdevel+bounces-50106-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F529AC8372
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 23:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84AAE1BA3459
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 21:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D402293474;
	Thu, 29 May 2025 21:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZZSuhmK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8304C17C211;
	Thu, 29 May 2025 21:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748552864; cv=none; b=SKP7Rk3jgGmBVsf6BPZfw+cMhOIXvEn+RxSSQIJGN8oto8F0tCqv8zpCE6tz3pH7du/EsC/3dHAAekuJ0EkhSB+FADhVv1Cp4/x4enbGY9nuaLdYrY0IODIwymjgHAoWJkPk5Qdwj/cftCShkMmpO0cFoMDKDYLcHB0HQhGcs0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748552864; c=relaxed/simple;
	bh=9lwVrDAjs/lkkEAfim6H2iCHnFpOqWZjGv1g1H2UR54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KwaNbx1AFzVMLSjdHi5sttJ/5c/JVy3zfLZcBwR7CJvo6P77ft2ZtKT0FMuir5qTelBsYRCUNxrQe0AqFwqnWt8McrJIUaGxsG41ZJnUjCb6Wm+TnFfT/VoQGl/TKW40aEj/VI+DizLO/HeKlY1U8khIzFR/BxkZN6n8e1Wix/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZZSuhmK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA6FAC4AF0C;
	Thu, 29 May 2025 21:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748552863;
	bh=9lwVrDAjs/lkkEAfim6H2iCHnFpOqWZjGv1g1H2UR54=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bZZSuhmKMa+ge/xdHma3i0suzM815Bf2D4x+BYt+i34JtRs/kmCqXpRdGhEvRds4S
	 ZmEwUURQQDjoPF9bLAvlZkEYV4LdWskLOflZ7bjWO0NGIV9gYVfLRxhj0eTiIPzjCU
	 wulMkOReCHVq1Wxmonyd2VzGykKYQ7mrD9L7hz5dlF9ZkqfoS5qn3sP7QV868xTVrw
	 fsDOA90TbRsRqQ+CmTtUL9Cnh82r24Ov/E/2oJOfQRkX1ONPJrvob5vedbAKESI5EK
	 qp+kaZj/CaO/SLJopwuoXT3AtLMmqmJxFqAQvrqFJ3rcRJR6qLx/FQMpU1dBLGcbcD
	 8EhINM1lfyXeQ==
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-48d71b77cc0so15867601cf.1;
        Thu, 29 May 2025 14:07:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUYfjL2+RuYSooKtSUSLlhYZKdk0cJQUi2mMAsu17HzC/fiTKpis9pZ9OtzWcLiMqrE2/XnIPjU8sFJ7ZhV@vger.kernel.org, AJvYcCUkuppWCgwurLjJlP1fJXvUOgZWj9Vr6Z56CrymB2O+a0BUtk41H5lhljROpbkRoycG11Zi6kumAe7n1V8VwHygz7ByGiw5@vger.kernel.org, AJvYcCWbMm6l4PaCcj4ZFB5ZiRbsG8szagoMMwC96xoK3gxmld8336aA6DKjUvmPVisAS4VM3fw=@vger.kernel.org, AJvYcCXH9Y7TPdPtw7kyhvmoFULmu4kqY0QgLiDmGovXS7PouRYCvoQGc3AfoCDGcXHnxVM0sMGcyG9g7QMruLoyNg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxmMmypGUWIsdZGt+01WwMQakJy9cTzpDeGQNKgFe026ZHJqvmx
	AWzJbH71rw29XuVcEKm0HdDAUHo3rMgW8fW2BrkLHyOHpIxcSCS/a9MN9IoJGrVYnbggSRWnaDl
	JBdWm1clpS44ve1MOQJjTBwU5JIW2blc=
X-Google-Smtp-Source: AGHT+IGw4pMchJ96DZc80mIXOTOvp7NLuynoTZX9jfg2YvO62Aip44MiKW0pjVLexS09OxgB8FMIx+eE6NshgaPUNGE=
X-Received: by 2002:a05:622a:40c5:b0:48a:2429:9dc1 with SMTP id
 d75a77b69052e-4a440020affmr17445751cf.9.1748552862928; Thu, 29 May 2025
 14:07:42 -0700 (PDT)
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
 <20250529183536.GL2023217@ZenIV> <CAPhsuW7LFP0ddFg_oqkDyO9s7DZX89GFQBOnX=4n5mV=VCP5oA@mail.gmail.com>
 <20250529201551.GN2023217@ZenIV>
In-Reply-To: <20250529201551.GN2023217@ZenIV>
From: Song Liu <song@kernel.org>
Date: Thu, 29 May 2025 14:07:31 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5DP1x_wyzT1aYjpj3hxUs4uB8vdK9iEp=+i46QLotiOg@mail.gmail.com>
X-Gm-Features: AX0GCFv7sIxT-gOoEHzHaCe2UgQwTNnXO5Ui6eVKQasQUvClMf-PLOS5PhBxXHA
Message-ID: <CAPhsuW5DP1x_wyzT1aYjpj3hxUs4uB8vdK9iEp=+i46QLotiOg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/4] bpf: Introduce path iterator
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>, bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, brauner@kernel.org, 
	kpsingh@kernel.org, mattbobrowski@google.com, amir73il@gmail.com, 
	repnop@google.com, jlayton@kernel.org, josef@toxicpanda.com, mic@digikod.net, 
	gnoack@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 29, 2025 at 1:15=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Thu, May 29, 2025 at 12:46:00PM -0700, Song Liu wrote:
>
> > > Basically, you are creating a spot we will need to watch very careful=
ly
> > > from now on.  And the rationale appears to include "so that we could
> > > expose that to random out-of-tree code that decided to call itself LS=
M",
> > > so pardon me for being rather suspicious about the details.
> >
> > No matter what we call them, these use cases exist, out-of-tree or
> > in-tree, as BPF programs or kernel modules. We are learning from
> > Landlock here, simply because it is probably the best way to achieve
> > this.
>
> If out-of-tree code breaks from something we do kernel-side, it's the
> problem of that out-of-tree code.  You are asking for a considerable
> buy-in, without even bothering to spell out what it is that we are
> supposed to care about supporting.
>
> If you want cooperation, explain what is needed, and do it first, so that
> there's no goalpost shifting afterwards.

We have made it very clear what is needed now: an iterator that iterates
towards the root. This has been discussed in LPC [1] and
LSF/MM/BPF [2].

We don't know what might be needed in the future. That's why nothing
is shared. If the problem is that this code looks extendible, we sure can
remove it for now. But we cannot promise there will never be use cases
that could benefit from a slightly different path iterator. Either way, if =
we
are adding/changing anything to the path iterator, you will always be
CC'ed. You are always welcome to NAK anything if there is real issue
with the code being developed.

Thanks,
Song


[1] https://lpc.events/event/18/contributions/1940/
[2] https://lwn.net/Articles/1018493/

