Return-Path: <linux-fsdevel+bounces-52788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9FFAE6B46
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 17:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 546B11886801
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 15:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBE925634;
	Tue, 24 Jun 2025 15:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="D4O5FtOA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7392957BA
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 15:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750778139; cv=none; b=WFEBQiWIHVySF2Ly4Kso9a2w25uS7SJLUHdkEfRL2zc+wiI6GTpcot+H3Eck86ydeVGFCWkf2jXcsGYKkusWICm25s6OhuyATpM3XLXH3KvqcyEOIYOUxXBjEfkm1w3iGNGyeApCfhGc8HKULEgYxNEWWbLF3m5iOiRfvvvRBg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750778139; c=relaxed/simple;
	bh=ZrdxuWG7+LFoBk2IWmpfoUdLdIZz43RgZ3fNnrL1bTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ckTiBCHFug+CHOM62s0EkmbfCIdFpim9ognOMjJku2roUgzNjdIyWJ8Fxno+77+hOK26xssEsGzc7WbWgoUYGjaZ8ROsU1H1X0l4VX9fxTIBwpWwKcWhLgp74eaLyFeB38GoXakcW18eSovdwzlmBwiFqDWYXe/9t6+8GQR3+EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=D4O5FtOA; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ad56cbc7b07so850625966b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 08:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1750778135; x=1751382935; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eLkoFblRVcI4qlzicS3evY0eDoBrk4ZSgrPnvsJhZ+Q=;
        b=D4O5FtOA9Yt2WDFWzF48V0lhRyzjRMI77+3uvTWdycEfvkhBTQCW/8m6kmska5RZ42
         RTDPKfRjckSNgMzaXL1YIA1WY5+wqFsb/GlwARfZx+/K90ZnjB9hAIjDqlJ5RroKPv0B
         jL6sADr7ILu0b8cQK+jCNQ57unCHF2lLFa5Lg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750778135; x=1751382935;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eLkoFblRVcI4qlzicS3evY0eDoBrk4ZSgrPnvsJhZ+Q=;
        b=JDmTAzVdUyzV/4nRnRlAeXPB2bSauK9M9uIpya3VN4ifaNW435QCYpLXh9k9+swlZn
         SztfHoIEl5fhRZBlMe9jbq+2iT6V6toPmgAK3z4GcgkQudSpC8784vgca0ZoHVuqdgk/
         ahtkj71SmNPoLNEYI6E/IkA2ce1IcAGShQyvaxnb4r0YDVHKGuC1/Hbiea/38vQSlzw9
         2Rh+5oFBaJn8OJqtFNQJd0X7+zNPL30U4Dx/nJxYc/r0tsLOoxlRV9UfDLOe2Mq1+zMS
         CIAyoaODIPmTCcyCyt8jcjDR7TL5UBOq+wOW7bfBwf0SgggIdj/3uL+DAI49uHZ40eLs
         n4OQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+WIAngoj3Mdn2ZWzM/jR333d3FIVMuigr1Ou+I1aRqFm7162GMQ54aIkvqCLJlT2FdeLdKrs9sVoQsOXB@vger.kernel.org
X-Gm-Message-State: AOJu0YxNknUEzSCkMgapPhJ/kObP4T6tdWG39QRbqS5L0aiFmVZIcERy
	avbyB+AmZywpQzvQJJW3wCkVqx4WfHwmtH51aVOKR3wRYMlrU3v4ad/aP5VrIJjRBht+FxhSFqW
	TgxuZUMQ=
X-Gm-Gg: ASbGncvqU/vMi4yK7pqkr+h4aOAkTtsio+mTdm8skE8aag96siR6uHzsYbMI9fq7pX+
	ukfdfArMUT237h7LsLHDvxO/dikAbOlwf9R+bcQMwsAfoOy+lJyrEajLDGN4ExEICQeOLzltROY
	yNDdJK6w377WpU4Ye9e4+CvLjHkdAfWJGrqf+hEv6eJNmOtwJROP0DUNZPgVgYQDdnr1StKROku
	JN2vGiOfIPoEEMR64lEZ8FjOzZ8XigY1k16rEZvHeS565A894iZjsh/Mtu07+c1HN/Xy5n32hT0
	jTrUA6e2Q3tY7WswafmLDdrHBBqsLRXF+Cm9ncl2OeL/MtpVzF0tEP+rZjZHlojpjGVdrUJx+B/
	r16oU4dOsrv4Gkl6cZdT/CejfxgFN9X4/nON/
X-Google-Smtp-Source: AGHT+IFHPkAOLJwDnPEtka8N/gQxXRPv64cvqrCdfS0mtbW+LVjyyXSjhnm+dQj5qi153nqzTg5s3Q==
X-Received: by 2002:a17:907:6088:b0:ad2:4d69:6da5 with SMTP id a640c23a62f3a-ae057cdea94mr1757024466b.57.1750778134652;
        Tue, 24 Jun 2025 08:15:34 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0541b7258sm887311666b.119.2025.06.24.08.15.33
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 08:15:33 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-601dfef6a8dso8698460a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 08:15:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXQnHljdQVRskYrs8GOCU/u9TAAgJ07LVMaA6+5n5adZNHI0/PlJHEuSqcT/mSXi3dkKCS8HiR2j4ClMs5A@vger.kernel.org
X-Received: by 2002:a05:6402:4308:b0:608:330a:9f67 with SMTP id
 4fb4d7f45d1cf-60a1d1a2ecamr15042057a12.32.1750778131214; Tue, 24 Jun 2025
 08:15:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1750585239.git.christophe.leroy@csgroup.eu>
 <f4b2a32853b5daba7aeac9e9b96ec1ab88981589.1750585239.git.christophe.leroy@csgroup.eu>
 <CAHk-=wj4P6p1kBVW7aJbWAOGJZkB7fXFmwaXLieBRhjmvnWgvQ@mail.gmail.com> <2f569008-dd66-4bb6-bf5e-f2317bb95e10@csgroup.eu>
In-Reply-To: <2f569008-dd66-4bb6-bf5e-f2317bb95e10@csgroup.eu>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 24 Jun 2025 08:15:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh+zcmrHM5ryM=_71vEwjaRjwRHVgFu8WRG5xsgu3ku+A@mail.gmail.com>
X-Gm-Features: Ac12FXyiIOMeVWX36Mt87GnZfIOR3ssqbql1oPQlXRyO409zF_tN4rQRqufbqcw
Message-ID: <CAHk-=wh+zcmrHM5ryM=_71vEwjaRjwRHVgFu8WRG5xsgu3ku+A@mail.gmail.com>
Subject: Re: [PATCH 2/5] uaccess: Add speculation barrier to copy_from_user_iter()
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, Andre Almeida <andrealmeid@igalia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Laight <david.laight.linux@gmail.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Jun 2025 at 22:49, Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> >
> > (Although I also suspect that when we added ITER_UBUF we might have
> > created cases where those user addresses aren't checked at iter
> > creation time any more).
> >
>
> Let's take the follow path as an exemple:
>
> snd_pcm_ioctl(SNDRV_PCM_IOCTL_WRITEI_FRAMES)
>    snd_pcm_common_ioctl()
>      snd_pcm_xferi_frames_ioctl()
>        snd_pcm_lib_write()
>          __snd_pcm_lib_xfer()
>            default_write_copy()
>              copy_from_iter()
>                _copy_from_iter()
>                  __copy_from_iter()
>                    iterate_and_advance()
>                      iterate_and_advance2()
>                        iterate_iovec()
>                          copy_from_user_iter()
>
> As far as I can see, none of those functions check the accessibility of
> the iovec. Am I missing something ?

So we still to do this checking at creation time (see import_iovec ->
__import_iovec, and import_ubuf).

In the path you give as an example, the check happens at that
"do_transfer()" stage when it does

        err = import_ubuf(type, (__force void __user *)data, bytes, &iter);

but yeah, it's very non-obvious (see __snd_pcm_lib_xfer(), which calls
writer() which is either interleaved_copy() or noninterleaved_copy(),
and then they do that do_transfer() thing which does that
import_ubuf() thing.

So *because* you were supposed to have checked your iov_iters
beforehand, the actual iter code itself at some point just used
__copy_to_user() directly with no checking at all.

And that all was really *much* too subtle, and Al fixed this a few
years ago (see commit 09fc68dc66f7: "iov_iter: saner checks on
copyin/copyout")

                  Linus

