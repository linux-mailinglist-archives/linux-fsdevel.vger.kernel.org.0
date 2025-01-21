Return-Path: <linux-fsdevel+bounces-39784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C86A1812F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 16:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFF97188BB30
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 15:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB621F4285;
	Tue, 21 Jan 2025 15:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cm3sgPqY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2717581ACA;
	Tue, 21 Jan 2025 15:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737473606; cv=none; b=u0OngKEGQJss7mUyQiR6Dz2iLiwaNCjGmMysx7cDFzIWZpMDKPwLTkZjN/atSVOR8ANAJMwrzuM7WrJEGwhlLpwPL88IDiDcY3DLIPq6e3CTlmqtlcbFHoY2jUrZTRWL9fv0mUeRyec8Bvy5Fs9lZ3UkEu+bnUy9U/875O/tJ3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737473606; c=relaxed/simple;
	bh=thFEJoQmDxkjv//0ZioBEkCI3wQefxUbAGNSApcUaZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c9F+BLgIuQJcbCLTbqFF+Bddova6EKOULIOBRUeBhXfBfloUHgs7UlT/R3AMV9WZN5NMm2sJAg+EBVKPP2cMjHoo6Swc1mJLoQIlpdoc8VrAoUUo7afXGbGcN03+uSGRKJNZbDYdg2LCr7ADkUYEvh55csJyKBZJ4Xc+wYkfV6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cm3sgPqY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C26CC4CEDF;
	Tue, 21 Jan 2025 15:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737473605;
	bh=thFEJoQmDxkjv//0ZioBEkCI3wQefxUbAGNSApcUaZc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Cm3sgPqYQBnUoyajOeiY0tmkWjwSfec2AKeQh2apW4/n7UPVWGfSvRZdUv+otuIlt
	 3hWOdezMt0L0Zc5ns5UAjUkp28ZHTEkho54j6Kg+QYiTksQ4oMAE10UbQvhqPo09Mw
	 y1411krQ/1ok5Z8/W47ognN9LXncxvO3ath3HS59R33FPnSIUh+Yi/a6Kkc33jFiry
	 s8K17Va8hOcLanhNlfQuutKg10cA1K6L1ZzDiORHAsqv+n/T3E9lkhUhbwRq7Cxtou
	 4LdRvLa8miNHSQWiIg+/0I/gnbzRfFtZ9vEpRCSEoOub9xlZef/glvDlt5Dy3TF/QV
	 FekZ2o2DmgSoA==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53df80eeeedso5764978e87.2;
        Tue, 21 Jan 2025 07:33:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUlG7JG0hXIbi7YooJC1hWHXYKQbX2ZAaLLi3FDYSW6O80y9YBWZOZ3vE4BHSDqJucUP5GR25h3Z1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKqMDR1RtWyyrJBmvrxlmvUhNO6/A6ifGYFXgWBGCJk5b2OubM
	/EqvHIgkHa7LHD/58yUjbWojNWY54kmdR2WO1HlAbrOygCMG7qfPs1tWqDvdMVMzTHbx9hnPWjr
	jA4zvKD38fQSr1JiysKkcyxeLnT0=
X-Google-Smtp-Source: AGHT+IFu6KwT0kJc/MwMtxi5szrREDrf3CVi73Zec8pC7AZ/29mwm7iNjNDZf2lLva9PRAM2JLl0Wqczj4IdL5txpPo=
X-Received: by 2002:a19:e054:0:b0:543:baca:6f1b with SMTP id
 2adb3069b0e04-543baca70d7mr182900e87.44.1737473603923; Tue, 21 Jan 2025
 07:33:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250119151214.23562-1-James.Bottomley@HansenPartnership.com>
 <CAMj1kXEaWBaL2YtqFrEGD1i5tED8kjZGmc1G7bhTqwkHqTfHbg@mail.gmail.com>
 <CAMj1kXG1L_pYiXoy+OOFKko4r8NhsPX7qLXcwzMdTTHBS1Yibw@mail.gmail.com>
 <7217bfc596e48cf228bd63aec68e4b18c64524f5.camel@HansenPartnership.com> <a2a45871928362a5af391f0f0dbba00f7aa683c5.camel@HansenPartnership.com>
In-Reply-To: <a2a45871928362a5af391f0f0dbba00f7aa683c5.camel@HansenPartnership.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 21 Jan 2025 16:33:12 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGH4J1hyaauUWo1y8KH0aLTbzXOep1gdCXw1jcgQRLLhw@mail.gmail.com>
X-Gm-Features: AbW1kvZ-Ssk9ATmif9u1zf5hIB8Xw04WzchHBuldvyX3nWoxSxrgvMdn9o0WJcs
Message-ID: <CAMj1kXGH4J1hyaauUWo1y8KH0aLTbzXOep1gdCXw1jcgQRLLhw@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] convert efivarfs to manage object data correctly
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-fsdevel@vger.kernel.org, linux-efi@vger.kernel.org, 
	Jeremy Kerr <jk@ozlabs.org>, Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 Jan 2025 at 14:53, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Mon, 2025-01-20 at 13:57 -0500, James Bottomley wrote:
> > On Mon, 2025-01-20 at 17:31 +0100, Ard Biesheuvel wrote:
> > > On Sun, 19 Jan 2025 at 17:59, Ard Biesheuvel <ardb@kernel.org>
> > > wrote:
> > > >
> > > > On Sun, 19 Jan 2025 at 16:12, James Bottomley
> > > > <James.Bottomley@hansenpartnership.com> wrote:
> > > > >
> > > ...
> > > >
> > > > Thanks James. I've queued up this version now, so we'll get some
> > > > coverage from the robots. I'll redo my own testing tomorrow, but
> > > > I'll omit these changes from my initial PR to Linus. If we're
> > > > confident that things are sound, I'll send another PR during the
> > > > second half of the merge window.
> > >
> > > I'm hitting the failure cases below. The first one appears to hit
> > > the same 'Operation not permitted' condition on the write, the
> > > error message is just hidden by the /dev/null redirect.
> > >
> > > I'm running the make command from a root shell. Using printf from
> > > the command line works happily so I suspect there is some issue
> > > with the concurrency and the subshells?
> >
> > It could be that the file isn't opened until the subshell is spawned.
> > I can probably use the pipe to wait for the subshell to start; I'll
> > try to code that up.
>
> OK, this is what I came up with.  It works for me (but then so did the
> other script ... I think my testing VM is probably a little slow).
>

Thanks - that works on my end too.

I am testing this on a bare metal arm64 machine, but an ancient and
very slow one. So it might be the other way around.

I am going to grab this version and queue it up.

Thanks.

