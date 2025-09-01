Return-Path: <linux-fsdevel+bounces-59883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BCCB3EAE9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 17:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB7511B25E21
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 15:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AAE35A291;
	Mon,  1 Sep 2025 15:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="cPcrYk0l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C55235A286
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 15:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756739855; cv=none; b=qO3PsDoj3w+kK32G61Az3o1xFrEvwoQyBho9zG9RdRDvRyqFg3HQUXDkL3ENya0/wREChR8kZ9Zlo+odwAULM5Hwl3B60YWGPv7tx4nuLlrgm9SKmA7f5mrEoGM5kusVdhXOLrpeooYPZOeW60++JbMfrmLgmLFpa//kDMsuL2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756739855; c=relaxed/simple;
	bh=2vLlsr7X2ia5/OeQs8olHZPr7msI9HcqjAeK9e+vndo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cygGsYML+AWUlz4ajChjjZlK6p4Ka6u16U3Tbhup1uVsgxV0SBdfP11UuyYAKp5hNT00Fsum3FzQoHvScRJDht+lZqQC59Hw5K0wSfd3+HfzASimb34x3ruEpBBuWqYMMi6H4jLMZLfZA2YCe5eoh14gAFnHqa+j79fscv8BtEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=cPcrYk0l; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b00a9989633so394184766b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Sep 2025 08:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756739852; x=1757344652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVsve/IFMKMWGwAEF879SRkVfMnyldOnTnxfs/L/xuQ=;
        b=cPcrYk0lG5/RAZ05cjfVkLhN1nU+ecgWhsvk7sRT53uzQ0dDFpRoU7ekOVKMTIkWPW
         6KJyY2UdEnBKa3nVLfoaqpb/EBxhsip9d6ROXKlZJ8wqFVVhP1m4iYh6CLeBwIszbsl+
         6TMQyrJKwl+uXZgauZZQ3A7E/zYQWmxOHnw3vgVIfmspqvLcyM5OmBBRG0mdq+7BtODP
         jM5EEiOtv26L+BBOm4zk1P/EmD7gETyl+6/EmhQJ8t46YTZShwNvxdBX7sFOgpdH04Mc
         9Qo4nIXVsmyJX6AMEG7VmpPn8JuLNgE04VTMNj9Uv7LINJ0y4uusJvQCxtG9D905umVS
         BQww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756739852; x=1757344652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PVsve/IFMKMWGwAEF879SRkVfMnyldOnTnxfs/L/xuQ=;
        b=D1/FGr5eQqe5CawcKd/G8hAYcjO19JLuAq2y87deiKP0togtOdDvJ1369L1EbwRWMK
         te6uQsu0GtXBbbnl8d29/96NYSq07iMmnSxjgsrdp0e1o7tJ7Sf3MQJsQz20+Ypa10Mf
         SBnELr6VtjS/V4nVCtv3gRU7ScULRbDKEbS47JdoGzXKAT07t/PnHFplddNxZWN0Xxvm
         8gt0DUj22bBS8qbEFB3FJb6cq6vDX1t08HU90YwNb1rpK+0406mQVEQKM/1buj8Ik4JI
         2HgYfFwBuNqLM9WPNzojvF3NxPdae7xi7o5re3RvzjzofTE7G18yDckogeY95eVewbFK
         i4mw==
X-Forwarded-Encrypted: i=1; AJvYcCVvLtGUoWUgDl8q03VOT/uTp3C2mpXAiNAHTnn3BmN252qCgRYjKkse/cHi8jdOtegyrFy/2NTkZc/hWJVS@vger.kernel.org
X-Gm-Message-State: AOJu0YzmmXRHjHymvxBJXMGrn6b9eXVDWM8gxxQX8miE/BtZt+NPBwnb
	SGcU64K0tyev3xZqPsKdsFzgQcyhTxdcRuqMtaXctsrNJOpyajCeQ/kGvZMIku+WrytO8AEpyRB
	mQy1awegXseW57QSmtX77Ct8JUyUDkig/QVwdpyjNqg==
X-Gm-Gg: ASbGncvZ44S/unSC+DU6W6V8h1oj+K2MRXefnj9+v3HW0V5BuDq427SgK26kpmJJyzT
	YQ+ObtvPS2vWUPEenblcuXKvcfVzOU7uNzBkj3KCRWOfMPTo1D8hpsMaT3KTqlr5SndFPUFTd8X
	CUr71GZjDuwG3xQ81E8vdFxNDbrrZzHpvyOjfF69sS7zgBYVozzHD6M5gltB6/6f7mWXIlT0sPl
	BNHFqy+8wHt2JE51XMUmMhgsj5xOiN0oKg=
X-Google-Smtp-Source: AGHT+IG/xTCJ9bj+alHxnm8uZcbqfurR+IyDtwLk2ZtZW9b4+JSGWCUUEu7vdYbFqHJ+Zaxrj6LPdykdWiyzaO+0sH8=
X-Received: by 2002:a17:907:d8d:b0:afe:5c9d:c7f1 with SMTP id
 a640c23a62f3a-b01d8a8b328mr935024266b.10.1756739851758; Mon, 01 Sep 2025
 08:17:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901123028.3383461-1-max.kellermann@ionos.com>
 <20250901123028.3383461-12-max.kellermann@ionos.com> <081a7335-ec84-4e26-9ea2-251e3fc42277@redhat.com>
In-Reply-To: <081a7335-ec84-4e26-9ea2-251e3fc42277@redhat.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 1 Sep 2025 17:17:20 +0200
X-Gm-Features: Ac12FXzbdsR-8kES_4on1Dew__ksXVksfxEkYJjm0-lwqH8RlE2IsInEJr70z8I
Message-ID: <CAKPOu+8xJJ91pOymWxJ0W3wum_mHPkn_nR7BegzmrjFwEMLrGg@mail.gmail.com>
Subject: Re: [PATCH v5 11/12] mm: constify assert/test functions in mm.h
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, axelrasmussen@google.com, yuanchu@google.com, 
	willy@infradead.org, hughd@google.com, mhocko@suse.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com, 
	vishal.moola@gmail.com, linux@armlinux.org.uk, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, agordeev@linux.ibm.com, 
	gerald.schaefer@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, 
	borntraeger@linux.ibm.com, svens@linux.ibm.com, davem@davemloft.net, 
	andreas@gaisler.com, dave.hansen@linux.intel.com, luto@kernel.org, 
	peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	x86@kernel.org, hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, weixugc@google.com, 
	baolin.wang@linux.alibaba.com, rientjes@google.com, shakeel.butt@linux.dev, 
	thuth@redhat.com, broonie@kernel.org, osalvador@suse.de, jfalempe@redhat.com, 
	mpe@ellerman.id.au, nysal@linux.ibm.com, linux-arm-kernel@lists.infradead.org, 
	linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 4:07=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
> > -static inline void assert_fault_locked(struct vm_fault *vmf)
> > +static inline void assert_fault_locked(const struct vm_fault *vmf)
> >   {
>
> This confused me a bit: in the upper variant it's "*const" and here it's
> "const *".

That was indeed a mistake. Both should be "const*const".

> There are multiple such cases here, which might imply that it is not
> "relatively trivial to const-ify them". :)

I double-checked this patch and couldn't find any other such mistake.
Or do you mean the function vs prototype thing on parameter values?

