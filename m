Return-Path: <linux-fsdevel+bounces-41340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35942A2E07A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 21:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 952F63A5F27
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 20:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D8C1E32BF;
	Sun,  9 Feb 2025 20:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BE69vYIK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A520137775
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Feb 2025 20:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739133653; cv=none; b=YZx3jbeIVStDa0Mu0F23EL1m0OQiA3Gfr8LeJ2G9th94YqrQkAsoHqgSZc84VVvl6X7QVvzNEiP+vcjAEXe+WaEMRlPl9ez9ccx8R3La6yoYEw8sVkVNeGfYZ00B24nTHr+CI5TjOaK59cysH5TkxwdERryB1sPVYB6JokZwrlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739133653; c=relaxed/simple;
	bh=2gU2/QcKUSQ/wiYWG3ZtCdYIXBDzhN+gWWqdMsOanrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sp7PloPQeHPtm3maKJ/uPetI9OrEgPfu/fjfXaYXSA3+EyTEStaRv34In/ZtYcfT8Ik3UM6VLAgl26GxVR9iUaxIgjH8qAXD7Z6Y0viMZ4Z3m3uoapp3sicDgOjV5YptLKwZaQ3V2pDLMMjbBBdHTdoO0G8A5v8HrvcAwLgEhao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BE69vYIK; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ab7b7250256so97753966b.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Feb 2025 12:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1739133650; x=1739738450; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Vq74F1wFcESZ51amFrl8eHD6/YdZmXUP7VjXbw0WJkc=;
        b=BE69vYIKgwGzL27c0YTGtHEK9QlFR/2WfeCpmTBR4ioAu5v2vbataE2ywvnnDNHsQh
         jPtU/na/UYtvlFDHsrMHON4IMUBdv4yXl+pStD/8uriNtNARd8CFCDwrBoNtpmpXOqY0
         I9m3KWH16kYwKIvh0MJB/aVl67I960T/cFgPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739133650; x=1739738450;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vq74F1wFcESZ51amFrl8eHD6/YdZmXUP7VjXbw0WJkc=;
        b=nrUfmVYbxRw8znBsL24Qi4u3jMz/2evlsEn4U266O09Eye4MsusgnO6ZzInuNocAlu
         TuRDtCd+QQ/iA6RKx84oav8Dwhi48I/zfu2rX0No02TDqEwAJQWBMR3jW9H4+TZwHNiA
         Oquyxy3jo3WNoTUtc1D/JZaA2NBQOO8XVIUIu63yOncmla/CFlM82iDjcllN6u3EM2L/
         FPvzlZfycFd1L8McdvmoU/T+J/8YpDcDmUE7Pk7Vc3RAjdPFzIBU0mEas0rL68DeSMJ+
         QqbGd+YJ/efOFvG2rK3AwKsqss+hLlsQLW3nvmxzz3I9eds5D3AxBP2r+OtQDVpukTE7
         J9yQ==
X-Gm-Message-State: AOJu0YzFP76qRQulbKkko+vSl+PSpVQGWGF5dj8HvFbHaPx+OudmxAqc
	LTLdzYoVA1m59bM/39BqLCCRKJgtgoiDmsztLopt2qqgZP4YT/NriVOi/FKMQ6WijO1pR6w4s3C
	rOwM=
X-Gm-Gg: ASbGncuVo3WZihuE6zM3gjHT1tKwLXKpnZaXImyHpetHTuFfD9abyzz92iNuyhhgw5I
	xKqIphRflqAMiAE3DFLSKxLek19M5MVwOxo6a0nAUh0XuXZu1PE5XfQWq3Tvhbd+BxojZAwsCr5
	z6RPMNNGvT3HBi7iZgGIBd2DtHm+6Jof/jWm+g3VTiaUZI9ad+pWocfqZQW2Xm6EFksdKqHR76/
	iB61w8FuDGT0rvAORguIFbwWW0DeMpioL+ObqeEoddB8I33HrWpuw4Np6+JF+VTg8OVWSNXsU9v
	WP3ti4tSoVj3kIJmgND2ts5XeU/CT21aQ77PtEyionDH0L0u3ASfP5fPhyOfVxBnOQ==
X-Google-Smtp-Source: AGHT+IFe7o3FgAqN0qEna1f5oWcLT96HUYgAKg5uRuyrdEfeuu16/B7Fb7Fc/YoHyczlm4hbZldiew==
X-Received: by 2002:a17:906:6a29:b0:aa6:b63a:4521 with SMTP id a640c23a62f3a-ab789add8b0mr938120466b.15.1739133650091;
        Sun, 09 Feb 2025 12:40:50 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7b88aa451sm162658266b.133.2025.02.09.12.40.48
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Feb 2025 12:40:49 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5de5a853090so3005147a12.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Feb 2025 12:40:48 -0800 (PST)
X-Received: by 2002:a05:6402:3589:b0:5de:5d4a:9f56 with SMTP id
 4fb4d7f45d1cf-5de5d4aa093mr7276032a12.31.1739133648266; Sun, 09 Feb 2025
 12:40:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250209105600.3388-1-david.laight.linux@gmail.com>
 <20250209105600.3388-2-david.laight.linux@gmail.com> <CAHk-=wgu0B+9ZSmXaL6EyYQyDsWRGZv48jRGKJMphpO4bNiu_A@mail.gmail.com>
 <20250209194756.4cd45e12@pumpkin>
In-Reply-To: <20250209194756.4cd45e12@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 9 Feb 2025 12:40:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=wisZo7+-xmC_o8GQJ-G0qFp4u29t_FkjgPvgq7FXaTyDg@mail.gmail.com>
X-Gm-Features: AWEUYZnm-byqLtVgoG1xZKmNlSCIlTB0Vzbhmfc7swHQWKbOulXf3f_pjqQ0pEk
Message-ID: <CAHk-=wisZo7+-xmC_o8GQJ-G0qFp4u29t_FkjgPvgq7FXaTyDg@mail.gmail.com>
Subject: Re: [PATCH 1/2] uaccess: Simplify code pattern for masked user copies
To: David Laight <david.laight.linux@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Arnd Bergmann <arnd@arndb.de>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 9 Feb 2025 at 11:48, David Laight <david.laight.linux@gmail.com> wrote:
>
> You almost need it to be 'void masked_user_access_begin(&uaddr)'.

Maybe we just need to make it a two-stage thing, with

        if (!user_access_ok(uaddr, size))
                return -EFAULT;
        user_read_access_begin(&uaddr);
        unsafe_get_user(val1, &uaddr->one, Efault);
        unsafe_get_user(val2, &uaddr->two, Efault);
        user_read_access_end();
        ... all done ..

Efault:
        user_read_access_end();
        return -EFAULT;

and that would actually simplify some things: right now we have
separate versions of the user address checking (for
read/write/either): user_read_access_begin() and friends.

We still need those three versions, but now we'd only need them for
the simpler non-conditional case that doesn't have to bother about the
size.

And then if you have user address masking, user_access_ok() just
unconditionally returns true and is a no-op, while
user_read_access_begin() does the masking and actually enables user
accesses.

And if you *don't* have user address masking, user_read_access_begin()
still enables user accesses and has the required speculation
synchronization, but doesn't do any address checking, because
user_access_ok() did that (and nothing else).

That seems like it might be a reasonable compromise and fairly hard to
get wrong (*)?

            Linus

(*) Obviously anybody can get anything wrong, but if you forget the
user_access_ok() entirely you're being wilful about it, and if you
forget the user_read_access_begin() the code won't work, so it seems
about as safe as it can be.

