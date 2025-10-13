Return-Path: <linux-fsdevel+bounces-63992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 839D4BD4E73
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 18:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E0C1D350B27
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 16:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BB12F60D5;
	Mon, 13 Oct 2025 16:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Qv9Wwd+o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755AB3093CD
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 16:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760371636; cv=none; b=n+6rVRDqV3qyzzZ/eRkUDJuaFXVb2BvzAiZJb7t1FJFCLo3ojWCPYHS6ZIa0IOnY1mOE9261Dm2g0c/8MiIYXGlQH1zGGUu+7iB5IC7gtiZe1FJzaaU+nkktH3z2jXHFe20L7CwQ8a7hiBnw+RePiUd0A4U/+xqemG1Ip8Ngqfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760371636; c=relaxed/simple;
	bh=hFj0LtbJR63+2H95rnHIfFzjxqJbB/yGK9XaKbmrs78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kGqm7gqI+bcFnKUr/t6jwd99Bxa4QgG7m8akVhRDv/CLaYRIrINNQIJmGaYPI6uzMD1t1lZLYBAMRgysc3v6oacivSGamR5eFbsO0YmqMVT0jtpEYJhs9kT0PosOsOm0BpyDZ41lGALAK9rHAq4fAN3vOFFaJsQ3edphrtquqiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Qv9Wwd+o; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-63a10267219so1585655a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 09:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1760371632; x=1760976432; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hOeuZsdXIkLl0kniBUHtR87t7zPBM315DZT5nopWqFw=;
        b=Qv9Wwd+ovv7rck3oztXst1eNmFcIlwJOMKwNfd0gH91rrNSf5Oooz27Y0Is0eTkwIv
         I4pmU1vl7LEIN7k2c/qPlU6Z+/ebClykiWykyZxUfXhp4+SZeuzzxVLfhWc3niRJWPIH
         XbgR6xApdqVBSpTmxITjwXNba6tVpMcIZ/tFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760371632; x=1760976432;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hOeuZsdXIkLl0kniBUHtR87t7zPBM315DZT5nopWqFw=;
        b=hLkLAQNj/S4gj6mAKPHMScCsezrGbcrBVOJ/8lTuy923MtHwlvSe0QUMSBcztrOXJq
         h0D3kpYc9oa9srnzFQFCLTWx+tQl/QHZaeB8ZST9tsX+jn8XLcr77B8mdxmKeIMg798q
         3b2OWf7SNmjF+CnJuQRcfFrCXJ47LknR9IL8MjCUdPwsYpSP75bPUnQzh5XtNT3Qpuxk
         aysYATtlUsV4M8KpEZYeCvr+0tWw+a01aThjp7q3GYcn5KOT2/cuKm92FfeTJRRkaxz8
         McvDW2QWK/sTzEWQyvu/GhCfTsyFAScgYqyelIcY1ayRFsUTauFQrqrlZsuq87yvLWW8
         dHrg==
X-Forwarded-Encrypted: i=1; AJvYcCWYh9J4PGBGtbJwvHbOer1ehqrtZhyJqOUtF8IYvcEn1Gajm7GIPCwKCUBw7Eomt6UDfwGMUZSOaqzGVygu@vger.kernel.org
X-Gm-Message-State: AOJu0YzidY7fJxt5SYYGZVHbXa+DVS+66UqHacLHBpHeeWXpQeBnB9hu
	85CdV8b//9XQzYpxvkh09hztUoIQCkp4sYcJqM15YMIhku4ilAI+IHVylCCjM5W4O0/VkhrhNGF
	2vOn3D20=
X-Gm-Gg: ASbGnctO+o2SySWI3ZnQT0699NfBP2xM4WlYFjdVtJscUJLjS0InIF/zN8ORLnkFS35
	FnYJCycEJ272OyEtKmd0LaH7UEFzApR2EaL9qMlRsK5huH7YLwvMW3oOAFjh+ay4iJLjDfnbm3L
	uVW0EJLcZrQdUivSqb7p/QCHLt81XPxgZ8kBROMRrnhWDAnNLqBdb8JkxHlBj18nbGRLJgG9UkD
	3uZ8LtsfBKrDJ+RkS5uKPsSnX+YIylae1MiopD2SJNtAYYbxX4KMmN49TJ7QiuW383q0F4BEFD6
	W4tbZ/erWhLYVigskd+MS0EmssYY2J4dnSmfpB2anvw5LMS7B+O6hHb/8aCJ6EUvcVXhkrgFDRm
	OSoolB31uR2Yy8HtK+zeFjozeZOIikJger+Xut4qhDxoeH9i3Fln+Z/lvjB0sjcUCggs1i61Fs/
	1+N74dQVB7DdOG908=
X-Google-Smtp-Source: AGHT+IFmGYxOpZSlnZjOQPQBSfy9fvVvEGwFpqbXUzm/O3joRK4rDgWxrTThemyFuJ7PyQnVRYSUWw==
X-Received: by 2002:a05:6402:1d50:b0:639:f6a9:1385 with SMTP id 4fb4d7f45d1cf-639f6a92178mr17080781a12.5.1760371632461;
        Mon, 13 Oct 2025 09:07:12 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a5235dccfsm9078773a12.9.2025.10.13.09.07.11
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 09:07:11 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-63a10267219so1585584a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 09:07:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVgCYgFiutei5VFAa6WL3aedZA0qhVdrumzfgPHhpQs6+s5mhZW4jvDuDN/uvKORG9NkyW36mj8vOn2uj2r@vger.kernel.org
X-Received: by 2002:aa7:d45a:0:b0:62f:8bad:76e5 with SMTP id
 4fb4d7f45d1cf-639baf07534mr17910768a12.5.1760371631299; Mon, 13 Oct 2025
 09:07:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wiTqdaadro3ACg6vJWtazNn6sKyLuHHMn=1va2+DVPafw@mail.gmail.com>
 <CAHk-=wgzXWxG=PCmi_NQ6Z50_EXAL9vGHQSGMNAVkK4ooqOLiA@mail.gmail.com>
 <CAHk-=wgbQ-aS3U7gCg=qc9mzoZXaS_o+pKVOLs75_aEn9H_scw@mail.gmail.com>
 <ik7rut5k6vqpaxatj5q2kowmwd6gchl3iik6xjdokkj5ppy2em@ymsji226hrwp>
 <CAHk-=wghPWAJkt+4ZfDzGB03hT1DNz5_oHnGL3K1D-KaAC3gpw@mail.gmail.com>
 <CAHk-=wi42ad9s1fUg7cC3XkVwjWFakPp53z9P0_xj87pr+AbqA@mail.gmail.com>
 <nhrb37zzltn5hi3h5phwprtmkj2z2wb4gchvp725bwcnsgvjyf@eohezc2gouwr>
 <CAHk-=wi1rrcijcD0i7V7JD6bLL-yKHUX-hcxtLx=BUd34phdug@mail.gmail.com>
 <qasdw5uxymstppbxvqrfs5nquf2rqczmzu5yhbvn6brqm5w6sw@ax6o4q2xkh3t>
 <CAHk-=wg0r_xsB0RQ+35WPHwPb9b9drJEfGL-hByBZRmPbSy0rQ@mail.gmail.com> <jzpbwmoygmjsltnqfdgnq4p75tg74bdamq3hne7t32mof4m5xo@lcw3afbr4daf>
In-Reply-To: <jzpbwmoygmjsltnqfdgnq4p75tg74bdamq3hne7t32mof4m5xo@lcw3afbr4daf>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 13 Oct 2025 09:06:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgBkLXAFwj6z_6LtSzP8EVJi53HDa9wvZqcp1kr7UWzKw@mail.gmail.com>
X-Gm-Features: AS18NWBfLjf3F5D1SH907b2VJtHoEseavJA7J2wgEzyIuzyFb1rK7aIuY2U6g6g
Message-ID: <CAHk-=wgBkLXAFwj6z_6LtSzP8EVJi53HDa9wvZqcp1kr7UWzKw@mail.gmail.com>
Subject: Re: Optimizing small reads
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Matthew Wilcox <willy@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Linux-MM <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 Oct 2025 at 08:35, Kiryl Shutsemau <kirill@shutemov.name> wrote:
>
> The patch is below. Can I use your Signed-off-by for it?

Sure. But you can also just take ownership.

> Here's some numbers. I cannot explain some of this. Like, there should
> be zero changes for block size above 256, but...

I'd assume it's the usual "random cache/code placement" thing. The
numbers seem reasonably consistent, and guessing from your table you
did basically a "random file / random offset" thing.

And even if you go "but with random files and random offsets, cache
placement should be random too", that's not true for the I$ side.

So you could have some unlucky placement of the helper routines (like
the iov stuff) that hits one case but not the other.

> 16 threads, reads from 4k file(s), MiB/s
>
>  ---------------------------------------------------------
> | Block | Baseline  | Baseline   | Patched   |  Patched   |
> | size  | same file | diff files | same file | diff files |
>  ---------------------------------------------------------
> |     1 |      11.6 |       27.6 |      33.5 |       33.4 |
> |    32 |     375   |      880   |    1027   |     1028   |
> |   256 |    2940   |     6932   |    7872   |     7884   |
> |  1024 |   11500   |    26900   |   11400   |    28300   |
> |  4096 |   46500   |   103000   |   45700   |   108000   |

The high-level pattern is fairly clear, with the big improvement being
in the "small reads hitting same file", so at least the numbers don't
look crazy.

                    Linus

