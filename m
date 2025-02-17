Return-Path: <linux-fsdevel+bounces-41864-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA1CA3888E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 17:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 074C67A3637
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 15:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9231B225A49;
	Mon, 17 Feb 2025 15:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqTC94z/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550BE225385;
	Mon, 17 Feb 2025 15:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739807450; cv=none; b=ZuN60XtTMpLxtrmVj8MyXEWQBBklAPvfFuo5K0WALof8DKaykeU9zOIuzW2ygboCYtEjakwe+49AHWguITnMOOr6l76HsYuLuOmsz+VwFRu/tFpcUxcKXWLHMiQEGP1BnQdeNBhJXtZD87riEbBATenJsagBhobGWiG9j/pTpXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739807450; c=relaxed/simple;
	bh=eNseTvayRYPpE5U3sQCGXSLB+tmkH6DD9wRv8Ufkz6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KWE8Q2NkrPtRjQYxaJHu/0Sfe9nodPKcrZl1IfsVU67j9MzJhYxNs5qjhV3m3vtu//eHLsdmQoZYnukrZvEtcEARdm8K25NfQCg6YXt4urqGAElBm4SvRxeE5aE/hYd+V97ELbKNzhC15b1tWo2x8E7UBZZ+YN8OaDD7yI97wkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LqTC94z/; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3098088c630so16920891fa.1;
        Mon, 17 Feb 2025 07:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739807446; x=1740412246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eNseTvayRYPpE5U3sQCGXSLB+tmkH6DD9wRv8Ufkz6I=;
        b=LqTC94z/4cLIWFGJVzsyzG3am7hxwj/vqEG3aD0lFrSUqjnvnbaboMa2mnGf4G9ymG
         Rv96ztitm75K04n5Ephps+XlztK6NB131h2sZj16UbnuBJSxGaiPcnERKN+fwIJmq7Bm
         56eZUjtIgNoKX6rJbDCgBLvhhjxUWtkdOt+Y4IWWxRfoQzSkVvZG+yzsv7uAbG9gHfzW
         cP5aIpdq1DlMcJqBaxpTT1YBxQnWEBcSwdZCZHddtvmPsbyp8rWVNQONoGwJT8WjyoZI
         HeaJCdRyQ1FiI8IlJymSN6ar47OSeM7nDVaVOOLUOvkMa6NaHkmFLrKsEJK//3geSOOf
         K/Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739807446; x=1740412246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eNseTvayRYPpE5U3sQCGXSLB+tmkH6DD9wRv8Ufkz6I=;
        b=VKlU6WeDDQLeOOYifQWO1TNgPwso9ZVRUJKwLQo1xKKaqGnPVydSaNPP6EfIS9+1Tn
         uIZ85HbJY9T1poFmkb1FtpbH6dMJM9nqAPkfCsLSdH9d/OohKLsEFdvLUpu+oDYx3K6F
         EqHWZRww+/Wvbl1peqygCcNnkBd3CPLyQWayC9xIxRcQlgGtBlvHDOHCDnSjEjdPRF4A
         HBhKUq0Phegyrs3RVB4kqu1qO5Tbza1IEj2W7S9IM/z3HZ2xEZd+YSPv2B4pmIUQ9nnw
         e4L4lbiorPww0WeEfK5VbITQMNHK9xpCSeyO+AlnlIARmqLvB+mov0cD97G1FTyCOCen
         8Ovg==
X-Forwarded-Encrypted: i=1; AJvYcCVRicJ4I5cM8khtNW6eIby8MOxbY/kMNzfCkYWS3LLguNYDs2D8V+YmTrqXXE1+N5kpeYP/n7Y9mtuXWgL9Y3w=@vger.kernel.org, AJvYcCVcoW7+GF9Z8OOLs/FtnSyPlhE5StrF67v2YVfQ8oDYTuWoeSKzsNv92Xg8FtoHHwapr4jh0ZYXptFObBnX@vger.kernel.org, AJvYcCW+UJhwX88Nhlunshc62tTHDYXXtpz1lzOde3rugBBczHYEPAOg91X9txISmvGZrxJFDWEQGxqrj1ofWsJJ@vger.kernel.org, AJvYcCWSO7b3LwK3J7y79YnAFpg5byluHS/UT4YJfLbVwDh6V2dlSJFdgJCcgQorTgQgLGULsUPhlrEduPre@vger.kernel.org
X-Gm-Message-State: AOJu0YyDN9xJqMeVA8/L725jAXbPASYAc4umUEKswVAvLDu2ImWyjTIu
	8qTPUAlLB3TpZ7KeXjYZmqBDMXvKhDTxZtnDCB+2hypNc6fjaqOlguGRkPW06op9joG3qLXPmPK
	bWcnvU/zKP3P4+om9wyLNLpMkOUY=
X-Gm-Gg: ASbGncsm4yJYZUsO9fsNh1Sl/2k2LeSwAVyelE8o8Gu0Tw2IL+kZ/60a3upGUKtmj76
	UoBxFGQtFYVmDtOQjOEdJmcYRlGniASfirGtGtCqWE/9eWbToCi+S3JP31SZG+q5jdtqz3suPsX
	4X9dyLEHZiPFxa2scCY9YU2uAujLkHAcE=
X-Google-Smtp-Source: AGHT+IEWLfgkl+FCjuMBS3fn68xkWa9P5Ave195MYSwc/MJOtRAv0opVrES6jV9kKRAbbt4TWs7/lOLJt5HP6IpU86I=
X-Received: by 2002:a2e:8615:0:b0:304:588a:99ce with SMTP id
 38308e7fff4ca-3092797efe8mr25693211fa.0.1739807446155; Mon, 17 Feb 2025
 07:50:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207-rust-xarray-bindings-v16-0-256b0cf936bd@gmail.com>
 <20250207-rust-xarray-bindings-v16-2-256b0cf936bd@gmail.com>
 <Z7MnxKSSNY7IyExt@cassiopeiae> <CAJ-ks9=OG2zPPPPfZd5KhGKgNsv3Qm9iHr2eWXFeL7Zv16QVdw@mail.gmail.com>
 <Z7NEZfuXSr3Ofh1G@cassiopeiae> <CAJ-ks9=TrFHiLFkRfyawNquDY2x6t3dwGi6FxnfgFLvQLYwc+A@mail.gmail.com>
 <Z7NJugCD3FThZpbI@cassiopeiae> <CAJ-ks9mcRffgyMWxYf=anoP7XWCA1yzc74-NazLZCXdjNqZSfg@mail.gmail.com>
 <Z7NNDucW1-kEdFem@cassiopeiae>
In-Reply-To: <Z7NNDucW1-kEdFem@cassiopeiae>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 17 Feb 2025 10:50:10 -0500
X-Gm-Features: AWEUYZkTMjeFzOHSQCr11RKK9P9i9z6qVWK7CwCD_YdiJtL8GAwsKrnf2C3CTM0
Message-ID: <CAJ-ks9kZJt=eB0NU-PcXiygjORhhbEhGYEr9g3Mgjcf2-os06w@mail.gmail.com>
Subject: Re: [PATCH v16 2/4] rust: types: add `ForeignOwnable::PointedTo`
To: Danilo Krummrich <dakr@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Matthew Wilcox <willy@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, "Rob Herring (Arm)" <robh@kernel.org>, 
	=?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, Fiona Behrens <me@kloenk.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 9:52=E2=80=AFAM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Mon, Feb 17, 2025 at 09:47:14AM -0500, Tamir Duberstein wrote:
> > On Mon, Feb 17, 2025 at 9:37=E2=80=AFAM Danilo Krummrich <dakr@kernel.o=
rg> wrote:
> > > You're free to do the change (I encourage that), but that's of course=
 up to you.
> >
> > I'll create a "good first issue" for it in the RfL repository.
>
> That's a good idea -- thanks.

What do you think about enabling clippy::ptr_as_ptr?
https://rust-lang.github.io/rust-clippy/master/index.html#ptr_as_ptr

Do we currently enable any non-default clippy lints?

