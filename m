Return-Path: <linux-fsdevel+bounces-67626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FF1C44963
	for <lists+linux-fsdevel@lfdr.de>; Sun, 09 Nov 2025 23:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A4C91889F20
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Nov 2025 22:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D5026CE34;
	Sun,  9 Nov 2025 22:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ONbHLkze"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDD921B9C5
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Nov 2025 22:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762728288; cv=none; b=azrVvg/YpPepiyGCW7K8tbl3n2J/Dj9ko6zL4GuntiqhQR7u/2Lj7Dm6mfFC+qe8HzYisVuQ1O8l7aCApGnWdcEqqE+Z4p8L7BOnLy8YJn+4dNtLmQ6k5X83YzT8QxGg3ig9eKcNmpLMI5ycS4pP6Njo/8znR3f7WkynBFQ2Heo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762728288; c=relaxed/simple;
	bh=JyYqEeLnWZ0z1NADpRPZfSdR8cGolArsUHrUE2T2Vrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ruC5iurIOUM8OW8+L8owEBOQjZ6pssHvYdYx+BsJwqEUFjlTYFADgnMXyNK7ug+9iTkj9s62aMIZ+B1E/b30eL8wnisYuOv8//Mx6Rc1a2lmNaAoo6NShVd9aflqupON8CoIytRwLMcETvAcWZbH9R8qrjQkTZUAE+FX4X5AqM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ONbHLkze; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b729f239b39so517191766b.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Nov 2025 14:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1762728285; x=1763333085; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pMxRTSFq+KiC/PO/c3X5DJYPCM+6QHM19lCO2aQiEdI=;
        b=ONbHLkzePLW3NYXoC65X0c4flpPEIP9HB4AWQ6w7d1p8UmpF7VXEUSH0e6eQ+aolId
         t3NGtbcmMRpSgNk7lkHMt/E3beKQ9mHIhiJRkqSVG6qEGCnD3GZW795ESzqWF8OQGzM+
         fxsKxBWZr6J2XplP9J+rDe+JlWbG3QfXeQTuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762728285; x=1763333085;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pMxRTSFq+KiC/PO/c3X5DJYPCM+6QHM19lCO2aQiEdI=;
        b=ggPqchn2vexHoVnuwfZYKXfBxs7sr7UbcNnAXZh2awv+N6j6tinaATevoqggTfN+TP
         rVDO/c9eXU6eB4KDq4wqItBalIEK01H2AOQaNfkvDc7rdvZgUuNR7Qg/kJX5XumcC5fC
         94YjCeUjw8sjvYQsU/xR00enJy1SZwQOwmDYJUNkb9aMA295H4fd7rTBpCLxyvKzY2qZ
         8b3pKzoXxIpINSWpKiaSAnHpKU+VMOP9xd3Fw9if+WpydD8Wn4KhpPqwatmzJa30ylpG
         +69cEW1DPrFS5lfpgdcJBtKM6eOCJXd9r1e91+LKpN86327HKpGodZHHauLVCW7AntYT
         NpUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXksMu9+5uzfsK12Fg94M1fvgIpkkPlBfaXx9aNxZs7NUZL+wIjLbNPkNtEJ3XeQR5vNCLpJpS/B0c7usDK@vger.kernel.org
X-Gm-Message-State: AOJu0YzkMHnyfrEeusCpoyHotfgqfN9jCR3Crfxya9yvEly/mRN+kAp0
	f1sE6B46DjDDqG+cXnnITpEJhSqltCb892cL2n7lYkfgyknM2XlNQQWKHOfOGVI+SpmbQFAC/U8
	o7JKbYzY=
X-Gm-Gg: ASbGnctYLKHGJ0nY+p7/O3//MSVJnNjU96aXIiYDCtvvOrTHNnSs+494BXL/fZMEYiI
	QNjbmUgvm4ruScPoPDIS19hfi5qyzPJ9amRD81R+mUk7HnQuDLAiWjNy0Os3qV0I2uqyA4rVxFH
	A05T68oqz1GMTxRKJsvyg33+e/ydhw/kWniEBN+jnzrL94YaHBQlaWbxShyJj3gdalo0NwiD7W6
	mPNmC2nbJqrSEUL5gNzlqAlF2x/kfLRoMgIfIIeOaVCsGoZUu4GUpBiqWkvj33EdJNjn7RNaB5e
	p+iFAkeaYD3h1Te3DVM3voKl2r7W8xeZQjcrnXdMLUK1wgBwrxEbqrE5y4h0h2HiwQa/RijTiM7
	lucWJZx8Z8Bboxzpg8pxpsbGPwptsvWsYMOZQAg74a1P19w7yTocQZUD5FKtfHuSmD0uV9XDZj3
	ujE6HTfEBfHE760Wfno1EC+EheyqijnWKRoc2v4i+xGsA1lFdsOQ==
X-Google-Smtp-Source: AGHT+IEiR4jo+dEF+Tlyls6k++CTjRjDP+5PB0xI7hvuUrJ5TlXyV7Ro0ntHNe4hDy7LmE/PCagQwA==
X-Received: by 2002:a17:907:7f89:b0:b61:e088:b560 with SMTP id a640c23a62f3a-b72d08cd942mr1010318566b.4.1762728284632;
        Sun, 09 Nov 2025 14:44:44 -0800 (PST)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bfa25454sm901469066b.75.2025.11.09.14.44.44
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 14:44:44 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b727f452fffso410663366b.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Nov 2025 14:44:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVs5fe+aUPyb3Hk8XuyGuh4f6DQTVKaolmtRv/RuQYhRXqREwqYDKtf/dY/V0HFx8iYCpwDhNjA8z8QrivV@vger.kernel.org
X-Received: by 2002:a17:907:7b9a:b0:b3a:8070:e269 with SMTP id
 a640c23a62f3a-b72df9d994bmr743402766b.14.1762728283808; Sun, 09 Nov 2025
 14:44:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109063745.2089578-1-viro@zeniv.linux.org.uk>
 <20251109063745.2089578-11-viro@zeniv.linux.org.uk> <CAHk-=wgXvEK66gjkKfUxZ+G8n50Ms65MM6Sa9Vj9cTFg7_WAkA@mail.gmail.com>
 <CAGudoHHoSVRct8_BGwax37sadci-vwx_C=nuyCGoPn4SCAEagA@mail.gmail.com>
 <CAHk-=wiaGQUU5wPmmbsccUJ4zRdtfi_7YXdnZ-ig3WyPRE_wnw@mail.gmail.com>
 <CAGudoHGCkDXsFnc30k10w-thxNZ5c0B9j26kOWsCXkOV8ueeEA@mail.gmail.com>
 <CAHk-=whxKKnh=rtO9sq0uUL76YGLB3YTb98DVBub_84_nO6txA@mail.gmail.com>
 <CAGudoHHA_dDXMZFh1=U=AjPsqK9PRUGq3fQ_GjOdebUBK-sn3g@mail.gmail.com> <CAHk-=wj5GSLaqf+rVE6u-4-rzdUK+OM_oUnPLQoqVY4J_F0uRw@mail.gmail.com>
In-Reply-To: <CAHk-=wj5GSLaqf+rVE6u-4-rzdUK+OM_oUnPLQoqVY4J_F0uRw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 9 Nov 2025 14:44:27 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgbn+6pGaPw1k6LsMyaPQqz4PxOqF_kN+drQvNudF_1XA@mail.gmail.com>
X-Gm-Features: AWmQ_blFRyp2aK66FJENgGjkorwps5yaIcGGW5kQ_CdDWidiXHxD-MbAtM3Q3ZI
Message-ID: <CAHk-=wgbn+6pGaPw1k6LsMyaPQqz4PxOqF_kN+drQvNudF_1XA@mail.gmail.com>
Subject: Re: [RFC][PATCH 10/13] get rid of audit_reusename()
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	brauner@kernel.org, jack@suse.cz, paul@paul-moore.com, axboe@kernel.dk, 
	audit@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 9 Nov 2025 at 14:41, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> We optimize for the common case.

Side note: I'm now running that second version of the patch I posted.
It boots. It seems to work.

And again: that patch will slow things down, because it doesn't
actually take advantage of any stack allocation model. So I'm not
claiming that it's an optimization in *that* form. It might _allow_
optimizing things, but as-is is only adds more allocations (but not
particularly many more)

               Linus

