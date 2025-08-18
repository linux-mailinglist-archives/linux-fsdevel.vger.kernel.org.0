Return-Path: <linux-fsdevel+bounces-58214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4157B2B381
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 23:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82EA13A990D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 21:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FEAC21CA0D;
	Mon, 18 Aug 2025 21:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RCLNIcaS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C15202C5C
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Aug 2025 21:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755553018; cv=none; b=uO5dhBtuonWc0PRBgRfLY6Hnh9gEZC5X+tfDMmwwkNRTyP05YLsiowQIA+pj64KxBcHFE3qerc12A+NLwoiVlBX5zOcwcnphBHSIlkPZp2bAK6zotBwgeYyaOkIsuE3+J+73c662vuw4dcdj0Tc9xCNN9frmIqlgF0D583xUdBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755553018; c=relaxed/simple;
	bh=qSXmxjkE7tWxGF9GYswWGcUoeX7dBav9UeXc81vA4C0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sgYZxfJGuiIuaA9zYyOdOGDQWtY2P7ilvQtfj0ggrVdSnPd7YuUPukyGhRNzhJnqlp29Uz4KXwwAcyu/YpgnQLa/B2wFV6UT6lJAYkoDOTlpKLaeIVIydtpKgvllYtMmUuoY3YqKg2tPKs3mHcSYvVbspCqctulduKpBHWso85Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RCLNIcaS; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afcb78f5df4so760887566b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Aug 2025 14:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1755553013; x=1756157813; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aQ6Xr/RwWLTuxcCIJ1FhU8AVBTTArUeQ/AN3U4J5Pw8=;
        b=RCLNIcaSeSb5wrjoblYxSQYxqLQ5ZYf7xqeeYnMh/FGTgHgIJGXo/ZLfOo6vLA1XaY
         5ks7B0DI7bxvKZqGQV9qY6gaDiQIXlPkdgPeTKwVkezzeSsbclo18Jqf7nWDiCC5pmLR
         ouenLhi+I5sJf36D25Z/i79RsU2Vfn+xRaaAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755553013; x=1756157813;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aQ6Xr/RwWLTuxcCIJ1FhU8AVBTTArUeQ/AN3U4J5Pw8=;
        b=N5OGzgcQf6YzZlL0VgpVCrHd7ULTTSiy+fCB6jvvn+i6f6L71K57wQnZI4lTJykKrK
         Gb3ltHaO+huHnd4syKFJRCOXOZus5VirTLD3JvpDKiQ3xFGevRfV9dzI4Rmt3n+BlYtX
         lEZeqAyUticCu2+RcYzuMAOfZOZfNajHI7ubQ9p4xwEzBGJDXBRa3swyN0d4/js1i95n
         EWkOsBvMLfBEOhfa8KlEBht4xBitnzKgX8OCH+0p4BS34lsy34eqt2F2WDGqJ2EB57pp
         XKoeEizBcITF9nxm+DCovtsIEey71AONVDcu/1teHyrtHpJvXBgv2snz4nRGqYrIppR+
         vTjA==
X-Forwarded-Encrypted: i=1; AJvYcCWQwWE0c8GcK+c7LD8kniX04FTHd02+zk1tzNBPnAuHWZnWWYTRQpHNbdXefkCcYPfdxUC2gyuG8z/LdW3d@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6SJlf4KLi7FkgYcUhFZ99J78vkAZf1hRkrj+v0pYv0kS0EsE8
	8cw41KRf90jQSx4fTKE7l3PZSc+Jfb24Cm8plHe/NquqTLcn/u0OmRGPFBeLt7NmDddmTOG/uhv
	n3UEL+aU=
X-Gm-Gg: ASbGnctnxZob6zY0Yh11zHjRigBp6IbDvBjOhEoKu1hUZG7ajyZd3Kdqql0e2NqXRb3
	s14Bm9IJojAqKiSm5d+otISbwPMGzL6lODPFqco7gdWfW0blubcRUt/B7hEfDFG3ktlwkK2kEih
	KUJgLTdkvsQ4H7MwA7cW3BNOHkFOAtYgkcGMiPImiRkQTk0pxksrVptKIlAO1TObnvVec8XvfYB
	PIozBz4FK8lJ8ZNCmuAKpH0U9idhXBDuHFMSa/tLoofNIQevRD1FRMys89RgHTxhopnHHvZUJMn
	uxK+lkK/0b9+6Eggh5RGWWZAZQstggf8W5JXS1bn+jkuPEhsu5frXHizAygLoKAWyaxGpUFjtpF
	UfTBP67n8A8uoACYJDX8X/JTVi8yisCRIc8YrQlKm3v45qhAjQOQDWIXiiJ5K7D/kl+6oUT9z
X-Google-Smtp-Source: AGHT+IFbewUORizN7d6gBe6D5rm8aP0a+Qkem6jmn37rQdHH748CsspzWh8yuJdgVC98FIwgpkxHgg==
X-Received: by 2002:a17:907:6d0e:b0:ae6:abe9:4daa with SMTP id a640c23a62f3a-afddccddda2mr27331366b.27.1755553013084;
        Mon, 18 Aug 2025 14:36:53 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdce53c3bsm865962566b.23.2025.08.18.14.36.49
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 14:36:49 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6188b793d21so7056454a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Aug 2025 14:36:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX11aMruPWYDlzeEsvshfg9/PMZqMfl68qjRHGQLqAwGIUKyeDIpu5HYFV/+F/RflJGX8/i/AOxPQjxP0Bu@vger.kernel.org
X-Received: by 2002:a05:6402:274f:b0:615:cb9c:d5a2 with SMTP id
 4fb4d7f45d1cf-61a7e737ccemr64589a12.18.1755553008944; Mon, 18 Aug 2025
 14:36:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813150610.521355442@linutronix.de> <20250817144943.76b9ee62@pumpkin>
 <20250818222106.714629ee@pumpkin>
In-Reply-To: <20250818222106.714629ee@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 18 Aug 2025 14:36:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wibAE=yDhWdY7jQ7xvCtbmW5Tjtt_zMJcEzey3xfL=ViA@mail.gmail.com>
X-Gm-Features: Ac12FXxf0x77QebHuGiALx_MGnJLRb3R5d6KhLXyrQWXnGFnx9g-2vQrxqt1ti0
Message-ID: <CAHk-=wibAE=yDhWdY7jQ7xvCtbmW5Tjtt_zMJcEzey3xfL=ViA@mail.gmail.com>
Subject: Re: [patch 0/4] uaccess: Provide and use helpers for user masked access
To: David Laight <david.laight.linux@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	=?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, x86@kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Aug 2025 at 14:21, David Laight <david.laight.linux@gmail.com> wrote:
>
> Would something like this work (to avoid the hidden update)?

It would certainly work, but I despise code inside macro arguments
even more than I dislike the hidden update.

If we want something like this, we should just make that last argument
be a label, the same way unsafe_{get,put}_user() already works.

That would not only match existing user access exception handling, it
might allow for architecture-specific asm code that uses synchronous
trap instructions (ie the label might turn into an exception entry)

It's basically "manual exception handling", whether it then uses
actual exceptions (like user accesses do) or ends up being some
software implementation with just a "goto label" for the error case.

I realize some people have grown up being told that "goto is bad". Or
have been told that exception handling should be baked into the
language and be asynchronous. Both of those ideas are complete and
utter garbage, and the result of minds that cannot comprehend reality.

Asynchronous exceptions are horrific and tend to cause huge
performance problems (think setjmp()). The Linux kernel exception
model with explicit exception points is not only "that's how you have
to do it in C", it's also technically superior.

And "goto" is fine, as long as you have legible syntax and don't use
it to generate spaghetti code. Being able to write bad code with goto
doesn't make 'goto' bad - you can write bad code with *anything*.

            Linus

