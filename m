Return-Path: <linux-fsdevel+bounces-25888-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 237C89515A1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 09:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEB7D1F223D6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 07:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AC613B585;
	Wed, 14 Aug 2024 07:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIfceOAJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FC13BBF4
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 07:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723620873; cv=none; b=h8eKPBZko/2so895NNfl6Sk2pvY3ue3u1975B5uVp1YUMxLlE3u5HLewgc9v+y//CLqLw+96PI0DmtD0ijhtSqe1QGRBU6V/MlZscxnbp2dJ0hVhjXgCmyKlUlrKud4vDD/6V2mnRhbYZ3wUuxqjP8ZTqpGjngX4PWJXuVLaS7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723620873; c=relaxed/simple;
	bh=Xl1gbxafPeZPZBRnvQtjYlsfTaBwSUg/5qQDqY44cps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B4MzQxj0Up4ZRbiyQ+tLtkiUKPH40n4NDrMZQ4wtj8dEOh+TKtEo5fP7ZkrU31DXxKaHZBohxvAiNX8lI6fwSuDIgj/2nDgmvnx+Be/2M10qiRfmE2FJV032UWDgYGLx/9su17DgoNbEla1Ky3Td4WVEjlVKNWSLYsntXgixPrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIfceOAJ; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-704466b19c4so3709807a34.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 00:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723620871; x=1724225671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2bjOX4mGEHFmIEz1jEs1hiEAiKrVOpPuuW0ccR1x8HQ=;
        b=XIfceOAJtfOar4ijG7BGCrTlIvXXJPB9S+IVih6ub9QzDdHF7RH+9WDbRLn74QvGDQ
         pJeLeXRc/k4GSS708Hcur+ZdgAPIGHqbk6hYjcxinOwIkk3rElnuS1V41HI27DpGjrha
         5ETcXss/nAIDAIo62BDPHWzj/huDsht3st7GYU8Jb9v+L7G++Z73Z6iHDqXNuiFVkb3w
         5wqKWgCjzp8H9ni6X6gdvkGK4XyYS6Voqxpoo7expY2HzWFMKVshtTlrO0yVe7RnMidV
         cHhIST3F9V/YvpzaEQ40lSP0CbkHMp84NvMWJoDOPSPmyL/YkrSew16Ozh0Smi9lqFmK
         1+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723620871; x=1724225671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2bjOX4mGEHFmIEz1jEs1hiEAiKrVOpPuuW0ccR1x8HQ=;
        b=jn84kU+68cEQ4MMdiZuDb+ipFZzw+e9jqIGqn8UN1NQFV0+sXmcigvdMipkNk/JU/M
         TOIwfnLvTwjDjx0D2wbcz+TP1YAskVIPfEM7tPgqBc4BGNMvlxF2NjHnW90VfLXRsWoD
         r2272oQN/9posmCpoODt2GK5ZCcVlcs9jbK7GnINyuka7/639N1o/JuYASceOpAhdRBl
         /mPsKKdk1ky36Elx2a6KmKlANnUL4+v/clyyYKklWfsooYl/JXoEBab9/pmtoQnj7Dl4
         RwqII3DtjsHOXzceUE7yRnF6y9lkdAJiWU3RNUNddcSu+p0rcpVvjLlrY60b195YKquC
         jPDg==
X-Forwarded-Encrypted: i=1; AJvYcCXPHwnwJfxRMx50Cj4LYseoSKADYCcqxCq08KbpZ1pTdXGbq+dcpoqXIWi4EoZ551jzSGP9wGKlCvdrlLMQMX4Vxlwwz5hEfSuorbWfvA==
X-Gm-Message-State: AOJu0YwdPz7A3oSYnX/bPvotjGPlbR8TUJqrF8zm446cACMaVZVN1iL7
	V3vESQ3Q8sWCHfF3aT6u7urF4SNgJYSxEJTsajHCvX4gBKXX8WtLtcYXGeJtKdXqO/Yr0iXOSaQ
	bjoo7nFZKu+JEXcrT5ldqUnwgn+c=
X-Google-Smtp-Source: AGHT+IF6GAJD4WvBYEJSuyjTxL68+NQ9PLVJbHkuFvat0NeTGs2j4IjiCDp0nhPmFPHfkH39iGdjveseroBk+/S0xFk=
X-Received: by 2002:a05:6358:d0e:b0:1ac:f7ac:d777 with SMTP id
 e5c5f4694b2df-1b1aab0baa8mr235217955d.2.1723620870886; Wed, 14 Aug 2024
 00:34:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812090525.80299-1-laoar.shao@gmail.com> <20240812090525.80299-2-laoar.shao@gmail.com>
 <Zrn0FlBY-kYMftK4@infradead.org> <CALOAHbBd2oCVKsMwcH_YGUWT5LGLWmNSUAZzRPp8j7bBaqc1PQ@mail.gmail.com>
 <ZroMalgcQFUowTLX@infradead.org> <CALOAHbC=fB0h-YgS9Fr6aTavhPFWKLJzzfM4huYjVaa9+97Y4g@mail.gmail.com>
 <ZrxASkumlaXWftJ8@infradead.org>
In-Reply-To: <ZrxASkumlaXWftJ8@infradead.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 14 Aug 2024 15:33:54 +0800
Message-ID: <CALOAHbCu05WWUo9FpU92Ls2Us3x2+7U8PBxOGza4g+hkaXViuQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: Add memalloc_nowait_{save,restore}
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, david@fromorbit.com, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, Kent Overstreet <kent.overstreet@linux.dev>, 
	Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 1:27=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> > There are already memalloc_noreclaim_{save,restore} which imply __GFP_M=
EMALLOC:
> >
> >   memalloc_noreclaim_save - Marks implicit __GFP_MEMALLOC scope.
>
> .. and those are horrible misnamed :(

What about renaming it to memalloc_memalloc_save ?

>
> If we can't even keep our APIs consistently name, who is supposed
> to understand all this?
>

--=20
Regards
Yafang

