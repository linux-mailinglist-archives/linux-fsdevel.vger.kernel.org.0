Return-Path: <linux-fsdevel+bounces-31132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC73992042
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 20:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D57C1C20E4C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 18:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52447189F33;
	Sun,  6 Oct 2024 18:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aJIaM4Jx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932D9189917
	for <linux-fsdevel@vger.kernel.org>; Sun,  6 Oct 2024 18:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728238192; cv=none; b=p39ydGTUP3PYVn3jaHkRYyrNLmEVhDCl8Zob4t0YFu/3trQTl12vRbOzp+JFIMFKjbsMws8NbFoZtM0bAaPhnMgWshuoX9+g97Fmryu4L/bCM/hUJgxqcfe4cLjam6ZgmybsE+i5jEjbPlgI6HjRw2OMf6SWFpiEwifN6XmW+70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728238192; c=relaxed/simple;
	bh=GhYwFHPF3z0gEg+L3cwhKmqowjN7RsxJiYEt/aXrtVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mUCPH3UiLrG7nzK5RXJuAf1GbI1eWErJylKiT5QiWhOsjclfK+ygrceEq6QQqiFim4ffN64R+gKgXp/FHeqPLwA8Pq+QUUethjRhKdFTLf+7032wM76rostOFB0FHZTwF/Gm77eIFIMTLJNr6udg6nyly1gKTZSUjijQOqkVcuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aJIaM4Jx; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c87853df28so5104270a12.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Oct 2024 11:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1728238189; x=1728842989; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2i5rM7rJ9PoDyKGOfI+tNj3jSlRCBrI5CqGeex8O4rI=;
        b=aJIaM4Jxg4Y6Lk2iEBmGpYYUgCChRZCiMLq9zO83H9rTbToILc7Z52nScZLN7kr5aw
         7DiHDJUDJNwPmSH1Ro0Lp/vGNIHCw/H4OAyPNqS3CWYnR/7QHHJAztBdM4lf1GUDyOqc
         C5AvRJverWZ6EJZkhPYuzRokg2bDT7wPFPzTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728238189; x=1728842989;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2i5rM7rJ9PoDyKGOfI+tNj3jSlRCBrI5CqGeex8O4rI=;
        b=ToAmeX9NO2JrQCQRzbw0IIFSSciJ6W/BZ9VrveGx6yWImdsc8Rb8Tb8TtMdeDFlcb0
         nUlYyFhmfQWj3MhubNmadqXbhZuNosQwzynnpciL+igTMHK4q9bewB/RS525dCPPWToI
         4+iYr0EEf0ZtE+1l5GRA+PP1OwK+45HSitwzQVviaMRsFslU2o5XgfNiAKVsdzjGCUnA
         5QYPmPKCQ78fgKZ08jlkDmp1Q+biHvwwNplAz8h8INnOy4dHyhzBiKHnI93t03Trlpnd
         qMSNbDMn6Iifxl56kS+yx6xrWXaFGznFO7H1xj/RirfH/IThbd6gzlm+RE+tChLFbyuw
         eOgQ==
X-Gm-Message-State: AOJu0Yw7+caQsH7T2AUaYWbBkAfpVVzMzxE6RKftriqXmz2fEc7xgNWA
	1FOhXqhVhCnSFOgPS0ekE2rt9twZ7dYnCvZvj+VM2KvShXSikGUApaji663Yg/E02bW6spVIcXe
	D4y8=
X-Google-Smtp-Source: AGHT+IFkgwOAuZsOSodg8+Kcdz44+Zf9DiD8j1Jy0K9EoDYZGezD65kNye2CUBuvjHojBIlVzdhDyw==
X-Received: by 2002:a17:907:3da0:b0:a99:499f:4cb7 with SMTP id a640c23a62f3a-a99499f58eamr423888666b.23.1728238188710;
        Sun, 06 Oct 2024 11:09:48 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9937813111sm248247066b.127.2024.10.06.11.09.48
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Oct 2024 11:09:48 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a994cd82a3bso98950266b.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Oct 2024 11:09:48 -0700 (PDT)
X-Received: by 2002:a17:907:3e8e:b0:a86:9644:2a60 with SMTP id
 a640c23a62f3a-a991bce5b80mr1006445866b.6.1728238187763; Sun, 06 Oct 2024
 11:09:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241005-brauner-file-rcuref-v1-0-725d5e713c86@kernel.org>
 <CAHk-=wj7=Ynmk9+Fm860NqHu5q119AiN4YNXNJPt=6Q=Y=w3HA@mail.gmail.com>
 <CAHk-=wgwPwrao9Bq2SKDExPHXJAYO2QD1F-0C6JMtSaE1_T_ag@mail.gmail.com> <20241006-textzeilen-liehen-2e3083bd60bb@brauner>
In-Reply-To: <20241006-textzeilen-liehen-2e3083bd60bb@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 6 Oct 2024 11:09:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg2VQzbenNK2puyjMQnpCLeXih92B8032Q-9ur0z33iXw@mail.gmail.com>
Message-ID: <CAHk-=wg2VQzbenNK2puyjMQnpCLeXih92B8032Q-9ur0z33iXw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/4] fs: port files to rcuref_long_t
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 6 Oct 2024 at 03:21, Christian Brauner <brauner@kernel.org> wrote:
>
> Iiuc, then we should retain the deadzone handling but should replace
> atomic_long_add_negative() with atomic_long_add_negative_relaxed().

I assume you meant the other way around.

However, then it's not the same as the regular rcuref any more. It
looks similar, it sounds similar, but it's something completely
different.

I definitely do *not* want to have "rcuref_long_get()" fundamentally
different from just plain "rcuref_get()" .

Now, maybe we should just make the plain version also do a full memory
barrier. Honestly, we have exactly *one* user of rcyref_get(): the
networking code dst cache. Using the relaxed op clearly makes no
difference at all on x86, and it _probably_ makes little to no
difference on other relevant architectures either.

But if the networking people want their relaxed version, I really
really don't want rcuref_long_get() using non-relaxed one. And with
just one single user of the existing rcuref code, and now another
single user of the "long" variant, I really don't think it makes much
sense as a "library".

IOW, my gut feeling is that you'd actually be better off just taking
the rcuref code, changing it to using atomic_long_t and the
non-relaxed version, and renaming it to "file_ref", and keep it all
purely in fs/file.c (actually right now it's oddly split between
fs/file.c and fs/file_table.c, but whatever - you get the idea).

Trying to make it a library when it has one user and that one user
wants a very very different model than the other user that looked
similar smells like a BAD idea to me.

The whole "let's make it generic" is a disease, if the result only has
a single use.

              Linus

