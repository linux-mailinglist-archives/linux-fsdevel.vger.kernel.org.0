Return-Path: <linux-fsdevel+bounces-67724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 815ABC48353
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 18:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 48C074F5BA1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 16:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1408C31DD81;
	Mon, 10 Nov 2025 16:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LUKuim1N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29ADC31D73E
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 16:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792927; cv=none; b=NULfOMly5VAOqJWJNOJNPB4JP8Ix1Tz2zghNJnOiBfjm51kStVSXA/1eHWdP2eQMSq1S7QdMqBwVJ/A2bWcSqEw2M460JkBEiJ/oHCvuge3d9uhvoRyClwWehrtspGWFOUGqJ2+wKR6fGmhWfUN8dlhbYrLjbhsBekLEwRJDxA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792927; c=relaxed/simple;
	bh=GKjNPhJUmE3ffBWuGrURvcOJiiT4jJnfaIvMg2ZBr5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TPaNj7HFZXf/hGqfaDyVHz8Xe4XOpMfXxKLnkP9BnrjyDoYRjJZNhr7HeqaiRbYTQ/QNxbvC3x06vwYegv1LdCk/Z0+0VKhZNuAm7n3FHqD1rSV1vrZAZaY+TFy7I+WXOs+Y+VKEgvRf5NoVTdba9NK2f/sbm5WXylC7+jcbmyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LUKuim1N; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6418b55f86dso1736148a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 08:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1762792923; x=1763397723; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oEQJCmiS2IMzNjbxI9qhqVkNRGDbuejNOKBcwtqGw/c=;
        b=LUKuim1N0j3S16p1DLfN7+deJD/PIxRM9qwe+h2dwcZTnOoIRp4XfI9OAXWyIuP2yE
         qkfv3z07mbQXqV3bvSYeE70A6pDRsCxTvvHpGJIXKw4BjumgVJ8JO0p3IiIae6ult9Qx
         d+cSuFf+aJNcM/T8HZ/7EvgEhNyP11q0ADFx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762792923; x=1763397723;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oEQJCmiS2IMzNjbxI9qhqVkNRGDbuejNOKBcwtqGw/c=;
        b=t/egs1tevjy5Tbhs/y7aBIAeO2FAk6d07wKZmUy67TcEOk6nhSdowr7mv9n9CI6lFh
         F70JVou0fd+ISwqN6gQbPYa57+O0WkFzerX3mN0obRtdrcrFzZvHMV/HxVmPoQ3R/mkY
         QCAEYEiQaOk9iPTIaM9gy4KtN/uii38+nLkC9ds5RXnJ1RwvoOzmT8Q8Cs/znkblMTGS
         L1njR57aTpUVkbsKLY+2/vRjUW+AR57LTCtnbhgDbHyl/Q1IjkZ0UYxjffVxcICgGb/m
         BsM/6noJGp5zdvOXDOXzzUbpLMQk80HY7VdcafsX/qbWEeqZJ1+2zODllKzqKhFPXnmO
         GxtA==
X-Gm-Message-State: AOJu0YwSdKV1e2ar7Zog8IV15sK50K6FU5AikSanPaVr0KMK6DkMUnKN
	4eAsX2ruyogpgmTwEY4UxJIklRfvHRlwh7dHwr3O6+fuPIp8cOTW9Fp3OixRbYTb4mgiqV7cPKE
	6H+NmgEY=
X-Gm-Gg: ASbGncsA263Xip5xnn2N0nevVXhmR9VUdR1bQqIzDxg76FwtAXrDbjbVwMEc4HvVtDE
	h42YENmO4uXba0lX11EWF9DQLuNglyyhYWscYvnnOJl+d+pd1sIJl8jBa1s2gdDeEskzVPHZFex
	8aJy1mzAQ781XKvErMxtKwz/RYwb38KdlMDVDjld5I2v0WFdJxsQKIh5o3cdOEe8KzlHOKnZSPl
	czfS7tQ6gt02EXA1jNH4P3+PQSKYwTtzvFXyrVAlDnlvzeaKwpB7gIWyXrT8CqDTgTy0u2Wqhxf
	vBhQoVsOo6Rfj3k6/CFrv98cCYTXXVZbcGOVJF4KkqixVLFboX8uqKT9PiMxyyPG3hs95dbSeh4
	Ghd6JdeTQq2uTXc2eq86+iYgLpGApLHvpRhsND2g14vkOpdmeUmXpCAa3aFcOuZuo29RPNAaX/R
	yWsF6ThgzA1P3vdCILoHXsIsRBnLeEpXPnZqRtDje++qsRfzlYmqc5eE3/ky7G
X-Google-Smtp-Source: AGHT+IFxspvuir9eoSR/UH8i7Y1kVi7rSUNyelzS9DeI8H7/sHqM7rCwzRKsk91lJmn8vnuG4E6FKA==
X-Received: by 2002:a05:6402:3586:b0:640:e943:fbbf with SMTP id 4fb4d7f45d1cf-6415dc15ff4mr7159352a12.11.1762792923133;
        Mon, 10 Nov 2025 08:42:03 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f862bd0sm11856744a12.26.2025.11.10.08.42.02
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 08:42:02 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b3c2c748bc8so408014166b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 08:42:02 -0800 (PST)
X-Received: by 2002:a17:907:7ea4:b0:b72:d9ee:db89 with SMTP id
 a640c23a62f3a-b72e056d064mr770836966b.47.1762792922013; Mon, 10 Nov 2025
 08:42:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109063745.2089578-1-viro@zeniv.linux.org.uk>
 <20251109063745.2089578-11-viro@zeniv.linux.org.uk> <CAHk-=wgXvEK66gjkKfUxZ+G8n50Ms65MM6Sa9Vj9cTFg7_WAkA@mail.gmail.com>
 <CAHk-=wjA=iXRyu1-ABST43vdT60Md9zpQDJ4Kg14V3f_2Bf+BA@mail.gmail.com> <20251110051748.GJ2441659@ZenIV>
In-Reply-To: <20251110051748.GJ2441659@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 10 Nov 2025 08:41:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgBewVovNTK4=O=HNbCZSQZgQMsFjBTq6bNFW2FZJcxnQ@mail.gmail.com>
X-Gm-Features: AWmQ_bmrAqXZ2m4pzkboWqVgXqNR03LoZBcEW296TEL_nMeJgv27T0QqUNlPZ1A
Message-ID: <CAHk-=wgBewVovNTK4=O=HNbCZSQZgQMsFjBTq6bNFW2FZJcxnQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 10/13] get rid of audit_reusename()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz, 
	mjguzik@gmail.com, paul@paul-moore.com, axboe@kernel.dk, 
	audit@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 9 Nov 2025 at 21:17, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> That's more about weird callers of getname(), but...
>
> #ifdef CONFIG_SYSFS_SYSCALL
> static int fs_index(const char __user * __name)
> {
>         struct file_system_type * tmp;
>         struct filename *name;
>         int err, index;
>
>         name = getname(__name);

Yeah, ok, this is certainly a somewhat unusual pattern in that "name"
here is not a pathname, but at the same time I can't fault this code
for using a convenient function for "allocate and copy a string from
user space".

> Yes, really - echo $((`sed -ne "/.\<$1$/=" </proc/filesystems` - 1))
> apparently does deserve a syscall.  Multiplexor, as well (other
> subfunctions are about as hard to implement in userland)...

I think those are all "crazy legacy from back in the dark ages when we
thought iBCS2 was a goal".

I doubt anybody uses that 'sysfs()' system call, and it's behind the
SYSFS_SYSCALL config variable that was finally made "default n" this
year, but has actually had a help-message that called it obsolete
since at least 2014.

The code predates not just git, but the bitkeeper history too - and
we've long since removed all the actual iBCS2 code (see for example
commit 612a95b4e053: "x86: remove iBCS support", which removed some
binfmt left-overs - back in 2008).

> IMO things like "xfs" or "ceph" don't look like pathnames - if
> anything, we ought to use copy_mount_string() for consistency with
> mount(2)...

Oh, absolutely not.

But that code certainly could just do strndup_user(). That's the
normal thing for "get a string from user space" these days, but it
didn't historically exist..

That said, I think that code will  just get removed, so it's not even
worth worrying about. I don't think anybody even *noticed* that we
made it "default n" after all these years.

             Linus

