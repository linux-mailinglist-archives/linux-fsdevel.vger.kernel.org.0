Return-Path: <linux-fsdevel+bounces-21666-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3EE907BAC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 20:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3E131F24026
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 18:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9891B14B946;
	Thu, 13 Jun 2024 18:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Msq8uo7L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19789149C6A
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2024 18:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718304207; cv=none; b=L8HrE763ebjOJs1VzaZI2fAV6FHcxZ+jeL2lYl3OMv+r1cjtP27nYokp5+RfOJzYBz8blErXQ+lIUL93D8xaQMY/+xGyPQtz5J8hkPOvRA1LkL6w4NlOGcU7lpCRm+G53TFkKW8PMBWdgBVuWvGUcmH1hruSNedI+ms/hRRWLTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718304207; c=relaxed/simple;
	bh=r5DiRvR5pZWBaw2R0JM4QcTuV5NNPDsViKSFsSYOZVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Icw8h9lUenrwF3clNUzhFscFztdIQnz9oTiLTaY7Kr8XTsKX8HMFimIZQCh2E2wXz8bw0aPqH71fOxNPXN4lOmkUhuLRXLSPnPytduKOIbrSMt2IPXNwRkQ71LPp3PHHCEhWzTZqufHpxYEfQ7H2wd+StgA1Jt9HekzUpeWMOC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Msq8uo7L; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6f253a06caso179020766b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2024 11:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718304203; x=1718909003; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J6MehwvGkTLXwJwX8TygZIo4GI9E/mz52rreRcv1Jb8=;
        b=Msq8uo7LISNoM1/Vov6e0Ydgzrnwvd91aqmtZs2HWaq3ZeI52W1KJCrMdh46IZgK/B
         l1Vh+QhFn9mUk2sg2rex8hvA2E31qYpZ92MeI+uPqiP04AJSGuUYPczQ0c2EmLW202i6
         DhqSlzuMiLsbS78yuh3vnbh2OQQ3ZR/jwZ5tA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718304203; x=1718909003;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J6MehwvGkTLXwJwX8TygZIo4GI9E/mz52rreRcv1Jb8=;
        b=Wn4AX3mz9+VBLG6Xdr4us0YrybT0gDcJAVxjAe8fRAfQ2Qo9WKGy90RcM8SQ9zBsxa
         dCK7rTrPi6hkDMpjC3xOGlWAZsyVJpk4EvW/BdVFd5lSg0R4eZo9+tUmjNGgGt4e7lOX
         RWHdrPpaiQd1Dc2E0wCgOnrZhA3KDuKMFXlwZZg969XS/Xo+bKGzi+pjRzFSe9Ow3TYy
         AmWqyOumBwSxLOopYLK1m2CN6MYyASFcGESJF859HIPEztqFQfDXImIjygcIgiXwJIlZ
         FC39hwrac+8XPuaukuy5mH95rvenu7MVf9qiRPFqWsUyLE4XXHrnIViJJhMRAoPoYYsR
         3ntw==
X-Forwarded-Encrypted: i=1; AJvYcCV8J/y/lGntMfaA40pAjQQxUMjAqB1DkphNImIqBr9AnW0Cks35OiBqb0k78XGswInCoRUKhXoyyKLfdO+//vgaAExEz0RcUci3VWo+zA==
X-Gm-Message-State: AOJu0YzyMgwMvNW/Sb462NX6mbRHIZBf0uVAhk36LC8tKokokK8qvFs8
	43wG9xzlpn9DDE9jYoRrUXf1GxP9GiRMqu2pG23fAefPdWw4Yiqy3fmcELRBGRY8vKgZzVdKImR
	wlWxI/g==
X-Google-Smtp-Source: AGHT+IHZztUXWHIruKGCdNZlH9qIev3fF6jHTbc72Cvx2xIBtPdkXbiKQFJz8j0aagL6cuY07bMFRQ==
X-Received: by 2002:a17:906:27cd:b0:a6f:4c32:3fb6 with SMTP id a640c23a62f3a-a6f60d605eamr43422466b.45.1718304203041;
        Thu, 13 Jun 2024 11:43:23 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56db6201sm97764866b.80.2024.06.13.11.43.22
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 11:43:22 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a6f253a06caso179018066b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2024 11:43:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWiwcVL16BLwxXp6Td3BFtswBkys403tGAjV2dsokTE0AVTxZF8TVBb6+iGL4GuKQiqXj0M761YTMJ6dW2ylhixdHksNCk86BlZYz3PZw==
X-Received: by 2002:a17:906:b182:b0:a6f:4c90:7958 with SMTP id
 a640c23a62f3a-a6f60d13a7amr46483766b.12.1718304202217; Thu, 13 Jun 2024
 11:43:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613001215.648829-1-mjguzik@gmail.com> <20240613001215.648829-2-mjguzik@gmail.com>
 <CAHk-=wgX9UZXWkrhnjcctM8UpDGQqWyt3r=KZunKV3+00cbF9A@mail.gmail.com>
 <CAHk-=wgPgGwPexW_ffc97Z8O23J=G=3kcV-dGFBKbLJR-6TWpQ@mail.gmail.com>
 <5cixyyivolodhsru23y5gf5f6w6ov2zs5rbkxleljeu6qvc4gu@ivawdfkvus3p>
 <20240613-pumpen-durst-fdc20c301a08@brauner> <CAHk-=wj0cmLKJZipHy-OcwKADygUgd19yU1rmBaB6X3Wb5jU3Q@mail.gmail.com>
 <CAGudoHHWL_CftUXyeZNU96qHsi5DT_OTL5ZLOWoCGiB45HvzVA@mail.gmail.com>
In-Reply-To: <CAGudoHHWL_CftUXyeZNU96qHsi5DT_OTL5ZLOWoCGiB45HvzVA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 13 Jun 2024 11:43:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi4xCJKiCRzmDDpva+VhsrBuZfawGFb9vY6QXV2-_bELw@mail.gmail.com>
Message-ID: <CAHk-=wi4xCJKiCRzmDDpva+VhsrBuZfawGFb9vY6QXV2-_bELw@mail.gmail.com>
Subject: Re: [PATCH 1/2] lockref: speculatively spin waiting for the lock to
 be released
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Jun 2024 at 11:13, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> I would assume the rule is pretty much well known and instead an
> indicator where is what (as added in my comments) would be welcome.

Oh, the rule is well-known, but I think what is worth pointing out is
the different classes of fields, and the name[] field in particular.

This ordering was last really updated back in 2011, by commit
44a7d7a878c9 ("fs: cache optimise dentry and inode for rcu-walk"). And
it was actually somewhat intentional at the time. Quoting from that
commit:

    We also fit in 8 bytes of inline name in the first 64 bytes, so for short
    names, only 64 bytes needs to be touched to perform the lookup. We should
    get rid of the hash->prev pointer from the first 64 bytes, and fit 16 bytes
    of name in there, which will take care of 81% rather than 32% of the kernel
    tree.

but what has actually really changed - and that I didn't even realize
until I now did a 'pahole' on it, was that this was all COMPLETELY
broken by

       seqcount_spinlock_t        d_seq;

because seqcount_spinlock_t has been entirely broken and went from
being 4 bytes back when, to now being 64 bytes.

Crazy crazy.

How did that happen?

               Linus

