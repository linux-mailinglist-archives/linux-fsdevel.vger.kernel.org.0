Return-Path: <linux-fsdevel+bounces-20668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 394578D6924
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 20:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AB631C23CE0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 18:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F42B7E591;
	Fri, 31 May 2024 18:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Mlml4Tt3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8EE44C6C
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 May 2024 18:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717181084; cv=none; b=A6ymbhsrCZMYe6s9PEupGupmUB+oyZDga/Y0zvM7Z2gRq19E1fjntyL0KZVquMlNxFQchIaxoIGhU8SIQn2IJQ3XliLBuEELJaN6m4aC7n7K+4sd7IEVe0/OtYsF7nZSJqM/G2awvIFlWDATK2yk4xTgVK0LJhGMQs1PmWzXEP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717181084; c=relaxed/simple;
	bh=lClgfGGMd4oHf0pDEaMTvMEqOfx/HScpLazot9q0RTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BGvvU7TmBeS9dJ8XRyKQJEPbULeYs/1NS6oK37yVXfOQ8sU6altbvBkATWrhmGT+B/Ub98w4nyJhCTcBIVoP0VnXlg0/CXRVelFNF+0X5ZhtEP1Y6stkPzo1w2i3PC8WK9ZMRlq0S/tyql/mg+h6APkSLmHjVSQNgTCiMfoYE7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Mlml4Tt3; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52b86cfcbcaso2473844e87.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 May 2024 11:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1717181080; x=1717785880; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Bx6t4jazLUqv5H0bltVAWI7s0Qwv16yRPXPTraDkilo=;
        b=Mlml4Tt3DxzfY2cpiAPf5clqKuPyGYAUFKMniyXoq/F8jG1TpP/HYwIEeg2hv9X6vW
         W4VLT4iq9m/Z8FG+kSZc+9/ZjiYU64BR8X5tpWVLMYTkQuxOR1TqXRF0RBIzWsv0bmJ9
         wxycBNO9BhyKSeLgBkctyVOUA4RJ9QdrPHqsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717181080; x=1717785880;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bx6t4jazLUqv5H0bltVAWI7s0Qwv16yRPXPTraDkilo=;
        b=r7zsJSXPaIkN8MADA69W63nNia5YBWDKg61AKxB4UtYuRjPxvpkXU0xW8CDgSqxuCg
         BzgceVmuQYSRIF8muL1H85RXJZNPcwI59GmgCH16y5kEFiX9m6546yq3pCnDurw4dmEz
         6ya0Cb2XHOt3xsCd/s9dbToTltODh7cw72kLtVsaDGwpnX3Zz4A6u5Wc0DPgZdRY5T29
         lsp+3CBhjU/0EKgv7ARou4Ol66bsJ/sqDhu+mFEVPRAq7SUJ1/gglbbyXNVF2Vk/TvWt
         1aRD2xaQSRIbAE1aoj9rA57PgF79jMd3U87J43JYQ7ohwGUDNhmDELPh09kbWbwrZf1C
         2gIQ==
X-Gm-Message-State: AOJu0Yz2JngU2DbJXU1wgTZEh4xji0CzQqjQBEOY6CkHOWoB/h5X93Fr
	NN8J4BTdH5Z50ToMVVAVvleTZSAmty8Mx8hU6vOnPUWpEcFJUnIBmZ/d82EpVJMf4S3+uQDF6/W
	uYeBR8A==
X-Google-Smtp-Source: AGHT+IHWaZE4yAR2wkhE4Q8zregvWimmefgGrCScnWE/umLtWcXJ5o4fjVyZ5HPpQ67nSMghjFUQIg==
X-Received: by 2002:a19:641c:0:b0:52b:8255:71d6 with SMTP id 2adb3069b0e04-52b896afe32mr2032418e87.59.1717181080161;
        Fri, 31 May 2024 11:44:40 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b8bb3659dsm210799e87.227.2024.05.31.11.44.39
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 11:44:39 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52b0d25b54eso3591394e87.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 May 2024 11:44:39 -0700 (PDT)
X-Received: by 2002:a05:6512:20c6:b0:521:92f6:3d34 with SMTP id
 2adb3069b0e04-52b8954e8f1mr2091841e87.22.1717181079180; Fri, 31 May 2024
 11:44:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531031802.GA1629371@ZenIV> <20240531163045.GA1916035@ZenIV>
In-Reply-To: <20240531163045.GA1916035@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 31 May 2024 11:44:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjm3XN1rOWpOKp0=Jgce-bCUmeWvaHLmUiqsDgunUDzxw@mail.gmail.com>
Message-ID: <CAHk-=wjm3XN1rOWpOKp0=Jgce-bCUmeWvaHLmUiqsDgunUDzxw@mail.gmail.com>
Subject: Re: [RFC] struct fd situation
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 31 May 2024 at 09:30, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> That would be something along the lines of

Looks all sane to me.

Putting error values in there worries me just a tiny bit, because they
won't have the low bits clear, so error values will match the FDPUT_X
bits, but your approach of using another type for it looks like a sane
and clean model.

In fact, with the different types, I think you could make things
cleaner by using _Generic(), and do things like

   #define fd_empty(f) _Generic(f, \
        struct fd: unlikely(!(f).word), \
        struct fd_err: unlikely(IS_ERR((f).word))

or something like that. Untested, written in the MUA, but I think it's
a good way to avoid having to remember which kind you're working with.

The above obviously assumes that an 'fd_err' never contains NULL.
Either it's the pointer to the fd (with whatever FDPUT_xyz bits) or
it's an error value. I don't know if that was your plan.

You can use similar tricks to then get the error value, ie

   #define fd_error(f) _Generic(f, \
        struct fd: -EBADF, \
        struct fd_err: PTR_ERR((f).word))

and now you can write code like

        if (fd_empty(x))
                return fd_error(x);

and it will automagically just DTRT, regardless of whether 'x' is a
'struct fd' or a 'struct fd_err'.

The same model goes for 'fdput()' - don't make people have to use two
names and pointlessly state the type.

The bad old days where people were convinced that "Hungarian notation"
was a good thing were bad. Let's leave them behind completely.

Worth it? Who knows.. But I like your type-based approach, and I think
that _Generic() thing would fit very very with it.

             Linus

