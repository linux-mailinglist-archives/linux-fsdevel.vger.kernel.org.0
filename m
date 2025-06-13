Return-Path: <linux-fsdevel+bounces-51640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F410AD9836
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jun 2025 00:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FBF71BC5027
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 22:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A0928DF07;
	Fri, 13 Jun 2025 22:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCkjVS5F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28D6239E85;
	Fri, 13 Jun 2025 22:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749853666; cv=none; b=FULDPT4vxwk0lD0BmuPylY3m6NDWvBs6eylhKvHIyTqGwnMexIZc24EWvaFh5HCvKNbfeANNWRd7tGZh1R3Iely5UOeDeyWiaiaGIgndi7uhOsfk+8L8FlovDBmzVm3LlBHNiIJf2Mc4W6Csswa1m4qAdlsAHCwko5srNyUvnGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749853666; c=relaxed/simple;
	bh=oz5GGeZK5HuwW8R1dyYQv0i5Y3h3LLimhUbd5OgIOdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IEHmnPbVgTR2ADXhd1IXWHX0voc+u4JRkUCUs1FGHqLP2/ge9eiRIoAzjTaFoATUeGyU8AUO7AUWl7uDrsIKpWGomP1k7/7qnRxbBck19MjvaPZNESIrYukKbWvh4MrfIIKrCtOUmhWraGiOof1bu1MmXETGudOaDmHo4zFlPQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aCkjVS5F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22397C4CEFB;
	Fri, 13 Jun 2025 22:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749853666;
	bh=oz5GGeZK5HuwW8R1dyYQv0i5Y3h3LLimhUbd5OgIOdY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aCkjVS5FxDgUtqX8oVnyg6xn4mxlqiQ+M/pLPDwe7I1MJALISNIrn8GKHULqV7I4r
	 kHChX13gq3l+CUgS3Ahb8tWITO9+Abym2+X1naKmv8Xk9Nv+M9jqWDQUjRm0AStq5Y
	 /z+Nnk5/MQ1Y7+FzBlcCPnhGnrkJj0ntECW8wehUAb6YANOKl8OIzPNANCXoeCnmXD
	 +IWgTHzuUuJ3TLN3TJTOnP5h0F+BHynHLfJMUlGMpGlFLPKU8oHpFt21kTAQAnCCIi
	 K8eLxeBqRFU7NGRIiDDI3DJm5a86FcM5ihi8Dsy3/NleQ6KDM9mXRB2G7zs++c5XAd
	 fYWWaNz+AMVFg==
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4a44b0ed780so37103631cf.3;
        Fri, 13 Jun 2025 15:27:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU35ZTP4YvEhF85h6pFJS83pZ4ZUMhLOPKk8I6DN8WO7kongiQ1AN2irMlkVwIAk55Gm28ae8C0ls3NAJN8@vger.kernel.org, AJvYcCUMthNvS9kkROTE9Oip4uc5uTFdNU0z8Fxg3+/FSWVj1kQCNTM/v08HKi+yssbkpmYqV4MMkOmGodctboBHNEcnq7X9NrN4@vger.kernel.org, AJvYcCWSbouNWmziph6Bni3TFS8ymb9TfeuLNyu6eF88l68Uy3l8iihr+iQ1Fll+uFuhRG/EtkcjHQXXX/Q18ILt@vger.kernel.org
X-Gm-Message-State: AOJu0YzBlLQ3mptT7IMaf39zPj7ShTbDqnYXmyRKq/dgXtyiPJzzA8iF
	VSgOq1+DUtfEYqQ+fFrH9Lt4K/1bCwCi42tZr27CgORx1wQ9ugiPHlQ6rcVWQ8URQL3jMuVk7on
	3f+rxkh6Sy4dSf3zFueR+h0xwlDe5L7c=
X-Google-Smtp-Source: AGHT+IGWkjVtdv83eE0pBs/jdfMfaxcVMpueUKvLdi3qvZP9yMR8Onxx6KI7dzY5aOnj72v0w6SET/QZNJny9oMPl7I=
X-Received: by 2002:ac8:5a43:0:b0:4a3:fcc7:c73c with SMTP id
 d75a77b69052e-4a73c4fd271mr14044651cf.8.1749853665106; Fri, 13 Jun 2025
 15:27:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611220220.3681382-1-song@kernel.org> <20250611220220.3681382-2-song@kernel.org>
 <174977345565.608730.2655286329643493783@noble.neil.brown.name>
In-Reply-To: <174977345565.608730.2655286329643493783@noble.neil.brown.name>
From: Song Liu <song@kernel.org>
Date: Fri, 13 Jun 2025 15:27:33 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7V9MWXBqiEFbFipUVASwysbB1pX3Lz0NCncFJ9Gjpo5w@mail.gmail.com>
X-Gm-Features: AX0GCFsvU1L3eassdPC77vEMHxMtYL1v9e9xJtapswAl6ledQxqg87gGstBk2wM
Message-ID: <CAPhsuW7V9MWXBqiEFbFipUVASwysbB1pX3Lz0NCncFJ9Gjpo5w@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 1/5] namei: Introduce new helper function path_walk_parent()
To: NeilBrown <neil@brown.name>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, kpsingh@kernel.org, 
	mattbobrowski@google.com, amir73il@gmail.com, repnop@google.com, 
	jlayton@kernel.org, josef@toxicpanda.com, mic@digikod.net, gnoack@google.com, 
	m@maowtm.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 5:11=E2=80=AFPM NeilBrown <neil@brown.name> wrote:
[...]
> > +
> > +false_out:
> > +     path_put(path);
> > +     memset(path, 0, sizeof(*path));
> > +     return false;
> > +}
>
> I think the public function should return 0 on success and -error on
> failure.  That is a well established pattern.

Yeah, I think we can use this pattern.

> I also think you
> shouldn't assume that all callers will want the same flags.

__path_walk_parent() only handles two LOOKUP_ flags, so
it is a bit weird to allow all the flags. But if folks think this is a
good idea, I don't have strong objections to taking various flags.

>
> And it isn't clear to me why you want to path_put() on failure.

In earlier versions, we would keep "path" unchanged when the
walk stopped. However, this is not the case in this version
(choose_mountpoint() =3D> in_root =3D> return -EXDEV). So I
decided to just release it, so that we will not leak a path that
the walk should not get to.

>
> I wonder if there might be other potential users in the kernel.
> If so we should consider how well the interface meets their needs.
>
> autofs, devpts, nfsd, landlock all call follow_up...
> maybe they should be using the new interface...
> nfsd is the most likely to benefit - particularly nfsd_lookup_parent().

AFAICT, autofs and devpts can just use follow_up().
For nfsd, nfsd_lookup_parent() and nfsd4_encode_pathname4() can
use path_walk_parent. And 2/5 covers landlock.

I think we can update nfsd in a follow up patch, just to keep this set
simpler.

Thanks,
Song

> Just a thought..

[...]

