Return-Path: <linux-fsdevel+bounces-65940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E0526C15CA7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 17:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 15E614EA209
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 16:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD1B283C8E;
	Tue, 28 Oct 2025 16:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="G3GPM/Vp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10F316F288
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Oct 2025 16:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761668479; cv=none; b=pWjaQQZgANKCEBkV364Fs7KioZ5/MvP318Fh/vZiLC8rGredh08DuEx3QPLYqUqALA7aEBoLfnQE6498LLWFxRFHfOUrirWi5OmFlcSm4p37xQKnaiJNsuZAOnr0GJI8duaET+G5RgDhIqhTzqNuItlmNmC+e1Qw1VWntvSjL3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761668479; c=relaxed/simple;
	bh=OTM6b8wUF9rw6fOXlIOEcqaTwYbvDfucC0gkj/2fKZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FcStYrXtwpwqRlGl2MffTSEfKV45nLnUi8H85ZHfb/NAJsykBP2VbG7RHX9jH6GIWPPuVe6ONqNOEC/62o61BPT4wrL9WvzxgoZfgvR46YQsAEHWdF1SUmSG9ptfUM4JxQ/Iw6t6QcEA2R9uGzil1e0a1qgQ/HOJYKYNsQJEFjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=G3GPM/Vp; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b64cdbb949cso1409534066b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Oct 2025 09:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761668476; x=1762273276; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/7vxW2qYHkfek8BcuNGNfNSQ19bugBoHjwa49fBWcYE=;
        b=G3GPM/VpqBoKBnL1r0LYTFSsMNvi86YG89cbi9KNeMgMEXcYKv4BurNWqx8w+FXC8F
         RoMLsOKW0uQ11XT+jR59aOQtXq374BDBFgfIYkca52PoJXwiIbryDs82xBddQojdZOTy
         EV8AxHkDbnakjpw6ecRWW6h9tdAOr1YFev4mg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761668476; x=1762273276;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/7vxW2qYHkfek8BcuNGNfNSQ19bugBoHjwa49fBWcYE=;
        b=Lzbzihj6NoNqu5S8XHi/bAZRXgLF7BlFoPLuLRFiN117Z5PCI89uzQqGGWEGC+7k2h
         Ueaq8IYwLTgGYXLAXbyhK839V7zGm45gSU2HTGTCCyI2JLcj/QpUl+l5rb9XPJwPae8b
         mIALEV5Xe5XTSlWnOoiLc/MIMZ9qVN7GemhNU81aw5pViKJBXAtDwqvVjq5q0xfor9WI
         brl6aeEjLnDg7POSTZa6iW8/z6kTadhEI8V4v3ypd4nr5cNu3S/Eckh+fZ4OvH6jhOut
         qLD0KFdWagWtR1pgFDM4xUT8PbRjCgQs65q+EqhKrY8N7xPGK4hMKmmJ1tmd9k1DR28p
         1S/A==
X-Forwarded-Encrypted: i=1; AJvYcCVIDAYadmG/V/ShiDFiuJOFK5nGXHlIBPQsPmc92/roQ5CUuLhAqudUYVHxW3c62myx3xIee8Vv+hzRW9U8@vger.kernel.org
X-Gm-Message-State: AOJu0YyxI2O7obkZ8Jb6VuhVo8mMd+Q9QIGT1WwVEa9JhiXM1ksMUGJ6
	eZvY1ePRI+ZzgK4+H14k6wPgonFjrE3LKSBQz+P6+7WTcLgWt5T4Cu9tjY5SSwbDAcC6su6RCuI
	u8uLgQBcuHA==
X-Gm-Gg: ASbGnctQ3OeprQKuj5qNJ1l2hKxmOSVtt5W+VGtXDTjXEhtWl4fQfXMDMyeOc8l89Tg
	CCOvsfJMceUqUKHV6aa9N9aRpdpAJMes0EhDLSmC3GxExlUZ/cbbcDlh53GHhKz/Y3er/l0LlM0
	ZI9RTT2LJkMcSwHVwgc04Iag2EW5e39iFFbE+HUX3Idi38nBNfTJIK4CI+VOyc+kU2p+G3rYOve
	cMtWyN07HQpF5y3CrAp3OtWBLbuSarWOmUOq4HBWDcB22mrtkY/SO05lMoHAuTULsc/IwYhLoOH
	VI9xmhl/qz1afwy3JhoHGIA9+rf7CP5umPfA1Y1j5QB8J42YvdAxsSWky29eLbeCFGVH05WzPZQ
	/MUIKAZU+IV5ySLzX90WpEhba1pIUbArAmSMRou6VQwPLtcUV3t/ddv2wHfwYmNYYx2X5nVOZkY
	kHJfcl2+ORHsxcLJWWt/3ZBc4NHUqhg4mHBwPfQeneMC4N/slQJQ==
X-Google-Smtp-Source: AGHT+IGLtE3HpI2GmIx68n5VzdkeTx0qEeKKAuHpmmDQsqx/28erCX701ystsbOJd/N0nBPdVI/IUg==
X-Received: by 2002:a17:907:3c91:b0:b6d:2b14:4aa4 with SMTP id a640c23a62f3a-b6dba619c69mr398206366b.63.1761668475844;
        Tue, 28 Oct 2025 09:21:15 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6db9b86c80sm383486766b.43.2025.10.28.09.21.15
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 09:21:15 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b6d3effe106so1383563166b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Oct 2025 09:21:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXuknAYE1TKbk6VkDhq7tQNwb0Fwy0mmMYVRyDhlfj7KJF1ye6mGYJdO8SubflxvVouK13xSxJxsjlIC1w8@vger.kernel.org
X-Received: by 2002:a05:6402:358a:b0:63c:4d42:993f with SMTP id
 4fb4d7f45d1cf-63ed826ace7mr3748960a12.3.1761668033009; Tue, 28 Oct 2025
 09:13:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027083700.573016505@linutronix.de> <20251027083745.736737934@linutronix.de>
 <0c979fe0-ee55-48be-bd0f-9bff71b88a1d@efficios.com> <87frb3uijw.ffs@tglx>
In-Reply-To: <87frb3uijw.ffs@tglx>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 28 Oct 2025 09:13:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjZ39CSZwN3W6n5kSAqL-OhJghygh3-dRsrJKpOa9nTwg@mail.gmail.com>
X-Gm-Features: AWmQ_bkZ4DVtg-fqS9oPLAcmx2bmXbpg5s6Qki9Q4422mgDG3jAT_1tXHLLXals
Message-ID: <CAHk-=wjZ39CSZwN3W6n5kSAqL-OhJghygh3-dRsrJKpOa9nTwg@mail.gmail.com>
Subject: Re: [patch V5 10/12] futex: Convert to get/put_user_inline()
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, LKML <linux-kernel@vger.kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	kernel test robot <lkp@intel.com>, Russell King <linux@armlinux.org.uk>, 
	linux-arm-kernel@lists.infradead.org, x86@kernel.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, 
	Andrew Cooper <andrew.cooper3@citrix.com>, David Laight <david.laight.linux@gmail.com>, 
	Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 Oct 2025 at 08:56, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> There was not justification for the open coded inline either and
> converting it to get/put must be a completely seperate change.

Actually, there's some justification in the original: see commit
43a43faf5376 ("futex: improve user space accesses") which talks about
the original impetus for it all: avoiding the very expensive barrier
in __get_user(), and how __get_user() itself couldn't be fixed.

So then it was converted to the modern user access helpers - including
address masking - and the inlining was mostly incidental to that, but
the commit message does point out that it actually makes the address
generation a bit cleaner in addition to avoiding the function call.

But I doubt that the extra instructions are all that noticeable.

That said - this code *is* in a very hot path on some loads, so it is
entirely possible that the inlining here is noticeable. I$ patterns in
particular can be a real thing.

(There was an additional issue of just making those user accesses -
get, put and cmpxchg - look a bit more similar)

           Linus

