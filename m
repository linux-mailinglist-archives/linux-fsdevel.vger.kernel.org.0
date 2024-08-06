Return-Path: <linux-fsdevel+bounces-25142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3393594960D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 19:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6389C1C2275D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 17:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8022347A4C;
	Tue,  6 Aug 2024 17:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gJJ2/ksu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF0822331
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Aug 2024 17:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722963683; cv=none; b=pJ4mqwf9aQDBxG8RBLiLLujGKeF22nN0rxF3tCt7QDZ6E7metuL4F6PKXDHf/zQRuKRZRKYmKhY5iU/7Q/e9DlyIv91WNeXkE213uTFDVo/6yV8l9+ti54+9Cxl3Jep/d7fkVJ++wr8tG6B51U7LsjVMo18f0qwJIoZyXZmrKRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722963683; c=relaxed/simple;
	bh=z74moehSgQTr+CrxBCdY3xDjq2CpjqyxeWJ3/rjbUVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vu23Rd5ac6UL9n06idHUUDRDMU4hfW/MGmUcxBSM1wMqnIg778mcQ3nzeDNXYCE/mu1/Eb2LdhRYd9iFaIiB3KAPs9ylnyWsTu1YhdEHZdSrZ+tXkKmux/oZFy6JFpY7dgwLWSiyTbUBFpzLEHeOYBylJDRvEDHq88Qib00UvME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gJJ2/ksu; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5ba43b433beso957668a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Aug 2024 10:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722963680; x=1723568480; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wYjOuLbMCDr/PE8EWIJr5oKj1Wfhs6GBeiD6/n87BEQ=;
        b=gJJ2/ksufayj03OcSJnhXnyAlFoCT6hxC6lyIlsd2xWaX/ym68tXzDUBpkI9O5v0wz
         H0btkboWr7v8G6GQoa9GQp+GCJ+zlnu6hd88PFo/MQjz715WBmsbdXljNApZZuq2BJOh
         g/+N4hp+9uHlYGFW9djN/Fz+KYzO1MGa1G4iw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722963680; x=1723568480;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wYjOuLbMCDr/PE8EWIJr5oKj1Wfhs6GBeiD6/n87BEQ=;
        b=cZ7yDmSc9MpQosqVR4YGxpexPEb818RuL8uEznVLe3CzYHVct55muqvV4Slm/IhE8C
         DHOXO+H8tYtOhJh68FBNGdiBiQYfgzBA6qCPARcsRP1bS3B2CkfuYeCtiKbmstFlMviA
         qn/NPo85u3k/4N2WTpqa+MPheke3Zj8MpkFWDrlt5RBzG3OprvX+JszAkh1Q/kQ4oPNJ
         JyVJOiHDcEFRbMDhpxcdzdcIKhvcQUsWQYYaAbL38io1PmQ3er225MsKWnb1LFkyXto0
         LWpTRF8dodG9Nn3e7l7da5XRSlBoyTcirsPHN5QCherXfr/oOiCoMrole0v1vFx8SUev
         zUIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrOZFLXx4n1NCASLpXVwoSs1V6iUqmcn/Jj6NgC9NQzUR/evYMif+d+rqQfj8DO3rAs+YiNA86l7BqzFKFK/x+j2xuXi28Ts8axSr8jA==
X-Gm-Message-State: AOJu0YwgvEr4/rKR0bHukfUyJX5uJgs45RHdw6Q6DiOEPyZm6Pi34/3y
	T/MwYMk/6NmwSADqaFZ7+8kwuS7w/rQ1Y9/CGKdBjc19EPeqjIyo3DE6U1xDh5qHrTTJlXhYzs3
	G4xLPtA==
X-Google-Smtp-Source: AGHT+IGe8lfXjxt/Esrx+cVID4nnXxEP/Ya5hqnHvfp+e5YMWz7zaVM0zKkdGKMHxjDXL0ZiMHcV3Q==
X-Received: by 2002:a50:eb0b:0:b0:5a1:c793:b440 with SMTP id 4fb4d7f45d1cf-5b7f3cc7601mr12978865a12.10.1722963679595;
        Tue, 06 Aug 2024 10:01:19 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83b92cbccsm6108144a12.68.2024.08.06.10.01.18
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 10:01:18 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7aa4bf4d1eso97148966b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Aug 2024 10:01:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUBsABd+GfDzQP6YqAwm+yVGMvg9P3UTrtrGxexkT1Sw+Yw8BSTMTyoiGU0uhobA1RmWH5Ok+DusO/B0jV22QNs86QekM91cjVHagfR0g==
X-Received: by 2002:a17:907:968b:b0:a7d:c9c6:a692 with SMTP id
 a640c23a62f3a-a7dc9c6a8a1mr1310805966b.51.1722963678478; Tue, 06 Aug 2024
 10:01:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240803225054.GY5334@ZenIV> <CAHk-=wgDgy++ydcF6U2GOLAAxTB526ctk1SS7s1y=1HaexwcvA@mail.gmail.com>
 <20240804003405.GA5334@ZenIV> <20240804034739.GB5334@ZenIV>
 <CAHk-=wgH=M9G02hhgPL36cN3g21MmGbg7zAeS6HtN9LarY_PYg@mail.gmail.com>
 <20240804211322.GD5334@ZenIV> <20240805234456.GK5334@ZenIV>
 <CAHk-=wjb1pGkNuaJOyJf9Uois648to5NJNLXHk5ELFTB_HL0PA@mail.gmail.com>
 <20240806010217.GL5334@ZenIV> <20240806-beugen-unsinn-9433e4a8e276@brauner> <20240806163208.GQ5334@ZenIV>
In-Reply-To: <20240806163208.GQ5334@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 6 Aug 2024 10:01:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg7qeXqNt32ReE_oMz+1FjRG7WhZWvLokFfzu5z6RkQ6g@mail.gmail.com>
Message-ID: <CAHk-=wg7qeXqNt32ReE_oMz+1FjRG7WhZWvLokFfzu5z6RkQ6g@mail.gmail.com>
Subject: Re: [PATCH] fix bitmap corruption on close_range() with CLOSE_RANGE_UNSHARE
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 Aug 2024 at 09:32, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > So I think smp_wmb() and smp_rmb() would be sufficient. I also find it
> > clearer in this case.
>
> It's not the question of sufficiency; it's whether anything cheaper can be
> had.

I'd avoid smp_rmb(), since that can be very expensive, but
"smp_load_acquire()" is about as cheap as it comes. As is
"smp_store_release()" and "smp_wmb()".

So if it's mostly about just ordering with max_fds, I'd suggest just
doing the store of the bigger max_fds value with a smp_store_release()
(which guarantees that any previous stores of the bitmap pointers etc
have been done first and are visible), and then before accessing the
arrays, do the load of the max_fds thing with a "smp_load_acquire()",
and it should all be good.

But the array pointers themselves also need the same
smp_store_release() when updating, just to guarantee that the newly
copied contents are ordered. Which implies having to read those too
with smp_load_acquire(), regardless of the max_fds value read.

But on x86, smp_store_release/smp_load_acquire is completely free. And
on other architectures it's generally one of the cheapest possible
ordering constraints. So I doubt it's a performance issue even outside
of x86, and avoiding a double indirection is probably a win.

            Linus

