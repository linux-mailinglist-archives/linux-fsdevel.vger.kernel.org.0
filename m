Return-Path: <linux-fsdevel+bounces-33321-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55ACF9B74AC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 07:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1281E28106A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 06:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A26146A93;
	Thu, 31 Oct 2024 06:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PGCDlG4y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE721465B4
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2024 06:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730356977; cv=none; b=RmTeclVBbOyLnt57zUlCipJLn9jYChciun1UNHBf3OG5rNtLetl3CW/3b37VpFZCQk0ilEwvvhkDlJrhE/5SPCtNgMVfz0G7n1NYjbM70MCqOUf0Kl5JhVRsGcMUFr2ZN0zsOn7v2CXks8aD1d5Bopwm0r4gJd6XYGiicmN39AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730356977; c=relaxed/simple;
	bh=Lg+VoelW75CBiygAVLiCdfRwdHThoH5MeopbZpeTp4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HdAPzr0YXK5P6fA3Q8lUFDVF5vEDacIeuvp78gWTVf7gTNIzs69q+o9Yej5rilrR4QxN6PPJc0FYjfe3i8zsqnPvjnkkC5VgeTCTgzL6OUQh3PMN+rxZ2RxXXRo1BSFSE0QagTLaistyMf0/SRrFHQhEYmIT1XgfvmfmxYMzWnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PGCDlG4y; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5cbb0900c86so857852a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Oct 2024 23:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1730356973; x=1730961773; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LRnYwlKpV+N1pzxKi94IZ/JQIiXBDG+pWCAUpo56vZM=;
        b=PGCDlG4y5EnJGebbjcu/F++nAsW7XA0Dxh6C6RGtszqh4ccjgOP/to5r5ZE6rqtmic
         hUB7INOhj8mc7DNC65WNFg6VZ582unbMNxv3UHYOVEB/v5XRcgZAMnj8Uuh8nkoKf9pO
         PRe3WHrm/SxOje9EVzghcCJ2AmS+yDE/+lv/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730356973; x=1730961773;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LRnYwlKpV+N1pzxKi94IZ/JQIiXBDG+pWCAUpo56vZM=;
        b=GwLi1UxaHSO9bztV8AbLG8JaeRluqEq1V+WOye2iQlg+hB8A/dwaxiAJBPTypQhFlv
         dGei9kTiJGrUvrn91NH1lMTrs4/yjsN5kXC9GZ38dkQIGlIJCpO9BEjxx15Sg/U5kAE2
         1kuAlUNqA+aK8LGSws7I+dpCvpsC31zgYdMhQ0vkVvC2Gg5/+MmQjQUrXShmZR40u/oW
         Dq+wPfsS9MPuLLQL0K0vYN9J2sN8wmRnxxPhS7Gzb09KbkmegaNL/L2A+PGtkuuWH9RS
         mZN5t0XvPii9y/81hihsCqopiGjo+qeSJqwKqb3Fv5UtzebuwDh03KPfI2YFQVN5Lbhu
         EO7w==
X-Forwarded-Encrypted: i=1; AJvYcCUW5uxid+Zbhnaz+jG54dla9hvxJ2OUlGWEWKThxogqCyGk/qXq7L63LVKLxPdoVXZzdUtPHFC+mdlwsg1x@vger.kernel.org
X-Gm-Message-State: AOJu0YxgjADbgq8qk4WXecvuNF0Fmnd4oIglnfiBHRj2PhOM/jWY7ele
	6UfSCnwEGbdVnoXS/yaI5pbE0zwMQkrvyKAtVlkH5kMet79TrtyDi8xbvizBxLDS7TYXOBj0dKe
	EeDg=
X-Google-Smtp-Source: AGHT+IGP7t5OQgT+yGA9Ps2ihtIimdilz1I4W703DAHzlBgXGfKgdorLLf/+X1ajDbVhFG0gaKC8YQ==
X-Received: by 2002:a17:907:e8d:b0:a9a:55dd:bc23 with SMTP id a640c23a62f3a-a9de5d6f205mr1769082566b.8.1730356972984;
        Wed, 30 Oct 2024 23:42:52 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e564c4f2dsm33054566b.52.2024.10.30.23.42.51
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 23:42:51 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5ceb03aaddeso116071a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Oct 2024 23:42:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVQvo2C5eKE4V5/J49lVcVvIQAvIDFVRw0KfOMKZ9cLomXmBI2cMw7un8+HxPA9+9nS7hTkU2ic4QVI1VAS@vger.kernel.org
X-Received: by 2002:a05:6402:1ed5:b0:5cb:6ca4:f4cd with SMTP id
 4fb4d7f45d1cf-5cbbf8796ddmr14660814a12.7.1730356970853; Wed, 30 Oct 2024
 23:42:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whJgRDtxTudTQ9HV8BFw5-bBsu+c8Ouwd_PrPqPB6_KEQ@mail.gmail.com>
 <20241031060507.GJ1350452@ZenIV>
In-Reply-To: <20241031060507.GJ1350452@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 30 Oct 2024 20:42:33 -1000
X-Gmail-Original-Message-ID: <CAHk-=wh-Bom_pGKK+-=6FAnJXNZapNnd334bVcEsK2FSFKthhg@mail.gmail.com>
Message-ID: <CAHk-=wh-Bom_pGKK+-=6FAnJXNZapNnd334bVcEsK2FSFKthhg@mail.gmail.com>
Subject: Re: generic_permission() optimization
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Oct 2024 at 20:05, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, Oct 30, 2024 at 06:16:22PM -1000, Linus Torvalds wrote:
>
> > +static inline bool no_acl_inode(struct inode *inode)
> > +{
> > +#ifdef CONFIG_FS_POSIX_ACL
> > +     return likely(!READ_ONCE(inode->i_acl));
> > +#else
> > +     return true;
> > +#endif
> > +}
>
> Hmm... Shouldn't there be || !IS_POSIXACL(inode) in there?

I was going for "intentionally minimalistic". IOW, this was meant to
be an optimization for a presumed common case, but fall back to the
generic code quickly and simply.

Put another way: is the !IS_POSIXACL() actually a common situation
worth optimizing for?

Do real people actually use "noacl"? My gut feel is that it was one of
those mistakes that some random odd case is using, but not something
worth really optimizing for.

But maybe some common situation ends up using it even without "noacl"
- like /proc, perhaps?

I was kind of hoping that such cases would use 'cache_no_acl()' which
makes that inode->i_acl be NULL. Wouldn't that be the right model
anyway for !IS_POSIXACL()?

Anyway, this is all obviously a "matter of tuning the optimization".
And I don't actually know if it's even worth doing in the first place.

From just the profiles I looked at, that make_vfsuid() conversion
looked like a surprisingly big deal, but obviously this optimistic
fast case wouldn't remove all such cases anyway.

               Linus

