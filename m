Return-Path: <linux-fsdevel+bounces-36759-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A169E90B8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 11:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33206163DA4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 10:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562FC217F34;
	Mon,  9 Dec 2024 10:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vPvN8Enp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26857217676
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Dec 2024 10:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733741061; cv=none; b=LO47my+jUpPlymrTzl4KgdgI7xTMxmmUste0qFOLpXG/osgVRfP3utvVVL0YGRPMyYgk5UwtXOYR6aJ8w2SzwM5nJgKiASeDYj8zUjJQHSMdGZuSKcvk+xtSsLHnkRTz2x98SnxkmGAETfoL8ttzq2Np79IPzKOd0sjAvqoLC+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733741061; c=relaxed/simple;
	bh=6BqBE5aFm4ewSSXypyzZzTAT8ClVBUtCqUHdDBItBdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ewLtkzMIPkvrbl8U0nr2d0IK7E5GJk7hi7T9zytNoj1vCraceXOBsNqgAGrw6EgwCu19hqZFILrZW26vUgWFPAPKmg+AaMgRG2mjaB04dMTL/xwH6ffndmNnTEq/GltQric+qxgwA1uH60j3fEnYEhLQMEw30pf1T4pA4F+rpc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vPvN8Enp; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-434e406a547so13091755e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Dec 2024 02:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733741057; x=1734345857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6BqBE5aFm4ewSSXypyzZzTAT8ClVBUtCqUHdDBItBdU=;
        b=vPvN8EnpVNA5rc8qqkxAJtara8E4ZuJGvWUGneyLKIwD7jB7bidxhK8j8g2D/p/D/J
         uuJeOHoYpEJ6+pndgXVi3QOco4xlP32gd7Ic1vuKYTIO5gazrU27HaG6qCucTdl+IWJ9
         pkC47s2qo3K9wDjxlOX1sCB4fk3LtXY7Tu/sIC1JX3n8hHPmewCkm8b6FYt71iZ5kB8f
         SYF8n4KpLw3P1iZZmEchE40vzj1/ziU91MYpAIJaIO1TtUQnyhNC+BMGYYkN0tzcRqbg
         oB9UPSJNHsZCPZFlRIMORvEeTuKJptggfjvG56Uv3KqidFU9k74PlGpBGAHqLfZiApew
         1zQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733741057; x=1734345857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6BqBE5aFm4ewSSXypyzZzTAT8ClVBUtCqUHdDBItBdU=;
        b=GJC1s2nvCxfnW5rlkXUwE+4f/PhAOReIqWk0a+kXX+LIboLE6AuR8pdULS/8+vqEpK
         x9gQNHV+l8NK5URfgAZbj/RWzO7zNqCwj3NQVqrgZq0CrAs+DfgslkHhNk4JERD1qaV7
         diYD4jZALZQHLTlVxHKtg6RtLna9b/MVZtR68JLNnqbqUi39YrHbgAh71CP0xKMopQQy
         XRD1G77TSILQNp/22PvnmnCoTzy8KFw0OHJ9sb+gd7fGiCTmRy+hiOxFySjNsI0QbPOX
         C7YvYEhfsAxkcG4Ahb2+unrpIRi4Yhs8+qR5N3ya08HmFi6JARX1Nv8rB2uiHfwAiA4Z
         KcCw==
X-Forwarded-Encrypted: i=1; AJvYcCXHTi0hJjFQRxNfdJTpQ3bqeBnXI5ZeWu0oK/Y3mPpvPQ1foXWI40QNInaoW6iZiAVVlJaUz633OqQi2apr@vger.kernel.org
X-Gm-Message-State: AOJu0YwkNDkiO8fv+7VqH40Nbh9wy3qrOuYnDNdLHpcsWdp9uciYEz+P
	U8mFewoqdfP1QTWdrsRel37EB/1wbhIUjIqWuOI2ORbakbFFzhc2zdxjjzt3V/V9MUOUJe6Cr3j
	K+WRH4X9OA2cTBifoXMa9/1guwz/ll0mtCrbc
X-Gm-Gg: ASbGncv/2C3R01XlFUtU9MhdwpmmUjBO/iz57YY01k2PzFrcdOJDANdJzpqAcAbYPkq
	7NbevF86nzI6clfsrJjYAbbn9/MH2uHoXAQriY+NLoY/dAIeUFcKDyXKxypWP
X-Google-Smtp-Source: AGHT+IEtz09n9EgbFd7plwXSP8yb6/Yeh+KMUJh3CuOljqy6eQuyvRHTd05ms9lQNLPlGEDxjngHLcH/n7gSBSV505Y=
X-Received: by 2002:a7b:c8cc:0:b0:434:f0df:a14 with SMTP id
 5b1f17b1804b1-434f0df0c1fmr47702465e9.2.1733741057349; Mon, 09 Dec 2024
 02:44:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209-miscdevice-file-param-v2-0-83ece27e9ff6@google.com> <2024120936-tarnish-chafe-bd25@gregkh>
In-Reply-To: <2024120936-tarnish-chafe-bd25@gregkh>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 9 Dec 2024 11:44:04 +0100
Message-ID: <CAH5fLghxiX8PjJH3s+xcXpJTD_XLuKKEjRM2dOqXkX7n7PoQ6Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Additional miscdevice fops parameters
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Lee Jones <lee@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 9:43=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Dec 09, 2024 at 07:27:45AM +0000, Alice Ryhl wrote:
> > This could not land with the base miscdevice abstractions due to the
> > dependency on File.
>
> So these should go through my char/misc branch now, right?

Yes, that would be great, thanks!

> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>
> No need to sign off on patch 0/X :)

That's just the default when using b4 to send series.

Alice

