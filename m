Return-Path: <linux-fsdevel+bounces-41301-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D91A2D955
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2025 23:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C63831888847
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2025 22:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B186D1F2BA9;
	Sat,  8 Feb 2025 22:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IFmrHhwg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE1F1F2B86
	for <linux-fsdevel@vger.kernel.org>; Sat,  8 Feb 2025 22:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739054118; cv=none; b=KrXHio++vOSH9PG2tYwoPMo++MhDTX7D4A9zk1VY9nUIUcHMDWl9igXodarSKEquneV7tV7faPIRxuggZ+r0Yh53RGkFfqK1DvOEqcWUzlgK8NJPbzOlP2PjxUSdyJ1+NI9TFTsgn32Bm1qoyEE45vdnak2Ssd4/dt4vrTgfTIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739054118; c=relaxed/simple;
	bh=/wmy6yC82GOnuYOyCwKkx324d1uQc1M7iBLRt0YPcSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NPDjVfaeVob5MuayiKoP0BJqf1o3aVx74hMqmPctUw3nm0sXyFsH5sAWKUqBBh7xdpwsb6qztqcTLAijCT+ZK3d7HDsOSJpLppaMhLqUfXUt5/7dTUUdxUrRj64jo6GtzEnv5kWz5SZMZzi8WIWYGuGkQG40n0Aosj8WSb4BAoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IFmrHhwg; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ab7157cf352so835882366b.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 08 Feb 2025 14:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1739054114; x=1739658914; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Aw5rB8a9ogv1Af1lax+6BTqRpmDPZAFLk8yjZ727oUc=;
        b=IFmrHhwgs7cCGRVikbEAb67WxNmKWOzSX0WStZLfOCVNSNHLv722hnmADzISHbUhQq
         UU37oWUZeSsNf74jvhz6OKVx80OtgT07UL1vWGFn6CXhB0AcBKtNkqx2qSR8u08OhWY+
         II9cgAmletJ6ME0xF6ifoWH+4UyotgJ2M7OEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739054114; x=1739658914;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Aw5rB8a9ogv1Af1lax+6BTqRpmDPZAFLk8yjZ727oUc=;
        b=f6mwV9ef/KihEs8ebA+CI5+Y4HmCtmolBdeVTcfywapTs5/W2idqZnKkoBgl3lrd8M
         mncTWcQrmHPzPz/lsLbNnDljrJyVnMgiopxbe04681dOR57mwiU4S8kK+iQjP8siO7XB
         A+6p7FXonNA11fnroiYr20LlOaalCpCA1MxcKcimAyMHmOlvEp5QwBqwJOZtMMB8v5GZ
         hDIVg8x+DLjvCkdkxp5qPSg+GWq5gZNj2SsoMFjsvDLsLG7K8n9EfozZoCCHvIg7kKvj
         fa4/BW64fY+kIGDSqBy9ZjpGtVQp9yJJlGqUX/PvLZaoH3wxWoaeJBu95UbHmiP5Zdwn
         cqBg==
X-Forwarded-Encrypted: i=1; AJvYcCWGF5jDzOr1+F6dsHdsZvB3xqc+UdupzURD1sdDVJYt9MElb8IVVnhe1ZhcNAqdkoJ5XztfRTDWKMYFr6cV@vger.kernel.org
X-Gm-Message-State: AOJu0YxIPYoQFX//iogYch1tH29kEX5Spzlyq9DQ7XpFzZL6pHnnjTCx
	lJzzfAw8kpn1htPwls4j03xLdiFNIOcbhyX8lVL0gtST+qNEFJkZQKudbZxUkBe+g6nT0CRFXGI
	dnZ1ivQ==
X-Gm-Gg: ASbGncs6t5azZUD2oqKFTD8s+yn0gM8DxtQ8pbLdgu8KQcqV9yLKCmOTEf655lMdRXq
	8zqglkpQSzcaiWeosUBZ9FWMUHAu2+lNGx2hV7YYW+Ef5QBMtVKGg+NgOyRBCTNVK9L65jkqVXq
	5wVEQF9IyyKuxRWAesv/uC+ngEUrBKfFKzzSm8/AbFIwbQ/4nFEPr0kZPkrX0XwZRW3etWvzL7h
	L30xVAjpJIHnwsylTGIzuoAST4ziksZpk9Gl0mcSfls+EGyTz16i+JybAQ3QmIF5/2NcN0iQS4r
	z9cAoPZeq0XCLOXed5JsxYRvYtFSFSzNpM9cpEkD284onxTnYuPwLV758skpWS1nnQ==
X-Google-Smtp-Source: AGHT+IE/M5TL0IvhZw6AInTbDeBB0IYYDgAVbXQnXejbcrdr7RshQ9CiaadpzhUcmk9gObmYV+LDyw==
X-Received: by 2002:a17:907:7fa6:b0:ab6:de32:da61 with SMTP id a640c23a62f3a-ab789a9a58emr809610866b.5.1739054114351;
        Sat, 08 Feb 2025 14:35:14 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7b2adcd58sm45801566b.112.2025.02.08.14.35.13
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Feb 2025 14:35:13 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5de6069ceb5so1100834a12.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 08 Feb 2025 14:35:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXfBVc2sxf8OXywzibKOLNVL1MimJO+JsT8RaJgigLSwI/MzSkHY+Bqg3kIf1vwl4IMTxmWhCRrXaQVIiG0@vger.kernel.org
X-Received: by 2002:a05:6402:40d2:b0:5de:59fe:f585 with SMTP id
 4fb4d7f45d1cf-5de59fef79cmr3972861a12.6.1739054113055; Sat, 08 Feb 2025
 14:35:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206054504.2950516-1-neilb@suse.de> <20250206054504.2950516-15-neilb@suse.de>
 <20250207210658.GK1977892@ZenIV> <20250208220653.GQ1977892@ZenIV> <CAHk-=whEbj9p33Cn_P4PawBqkav8zQq5+WjtzqYCK0o621p1kw@mail.gmail.com>
In-Reply-To: <CAHk-=whEbj9p33Cn_P4PawBqkav8zQq5+WjtzqYCK0o621p1kw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 8 Feb 2025 14:34:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=whyBwei9inP2j1CYxH=RVoFya47rd2Z5oYfKNDKAz2Hxg@mail.gmail.com>
X-Gm-Features: AWEUYZlCBj39i2MdyBuSfTYd8OzjnY0fhKAQ--9Qm9JnvM0_fMK2hsmooPtcTg4
Message-ID: <CAHk-=whyBwei9inP2j1CYxH=RVoFya47rd2Z5oYfKNDKAz2Hxg@mail.gmail.com>
Subject: Re: [PATCH 14/19] VFS: Ensure no async updates happening in directory
 being removed.
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: NeilBrown <neilb@suse.de>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jeff Layton <jlayton@kernel.org>, Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 8 Feb 2025 at 14:30, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I've never used clang-format, but I do know it supports those kinds of
> extensions, since I see them in the kernel config file.

Bah. Over-eager editing removed the context of that sentence.

The context was supposed to be that in the kernel, we tend to have
lots of patterns that make traditional indentation checking totally
useless: things like the "list_for_each()" macro that obviously
includes a loop in it and thus has indentation expectations.

           Linus

