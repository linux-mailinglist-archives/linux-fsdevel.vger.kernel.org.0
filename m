Return-Path: <linux-fsdevel+bounces-40192-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C5CA202F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 02:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8315A165EA5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 01:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEB7824A3;
	Tue, 28 Jan 2025 01:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="D+yJ4W+a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDE3F9F8
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2025 01:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738027651; cv=none; b=Y3IJ+6c29iw1Fc9A7swnCRpGQF+9u9ak4y4R4As4KOca6EIsEGDTman0/RvDp/VOp+WqAHGxdKL7KPknkmmxLS2gIG/H8FB2ysaAJAoVLCKrnRiHEvyzVgOHLZm5lGvCA/e4YmQFeQY4uU+r5RHGbxrmlfgMHRxJ0JxChXqTwV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738027651; c=relaxed/simple;
	bh=tJ0cF8Saiuv5f5osrHINo7PACAOgC78dsgBh7SJ4JMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KgOSRfnKkCxSD8itNBWxbHaeaxXmXAW7Dw0i8JelV0U2bp31XOE9BVf+aLfBSAUEMYSttXEuMHVXXkYz/0M9AYU+5xcxqMlyYnKpYxVqInzKhSmMEIwi1J0SaNnGWhDGKByAkOyO9CGyt7gkdCxLEO1WAjNIiWxEeWZSxO1Hccs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=D+yJ4W+a; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5dc0522475eso9998534a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jan 2025 17:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1738027648; x=1738632448; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NLY92uDAl4h46dZE347IFb1LDmGaT8L4B9xBfkFYivU=;
        b=D+yJ4W+auXa1nSu3xPcpW9oiQgGGN4jV5Fa/fXUqSmolx1g9iTDd0p2wI0dTp5yNCD
         IkbJLA+FSW1pu7LbzCj1A/s0dzODqU+i0iideplxb0asoY2eK8V7hoQDFHXv1KCM874m
         OYqVR1zgEsb0m1bpXFUvlhtn3MX66EPREOEGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738027648; x=1738632448;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NLY92uDAl4h46dZE347IFb1LDmGaT8L4B9xBfkFYivU=;
        b=vV58ELiwNwTYVXKad8ZiyTtVfEb0cO1Dr0Mfx1K36JT8H+paCWUFyU8xIKuA76gRf1
         JAATn5G5V/sVAsH5cvTO4hLRZ7zT5hv9p9RfY5Os50E6LTFOWJmzzldjBmy5sEBq72hc
         ig8VwCWJS9ckm6WXg6jrus/dsiaVM7E23aEHyNsaqBmI5U5nImwKPHiFU1eUb3JqBg0d
         mFXdZQhE4BXU9bjnhH+LKY3XFxEktBvkG/PUbIOthnBbonb+DtjK2qc5fR4ks/hOlT0e
         m6LkpfkMKoFM/U7/vaHLnUpOVfH8WJoEHK1Tn/R5WzotfzqEQxL5V8Rqy1VSPV+2x4Q3
         DpQA==
X-Forwarded-Encrypted: i=1; AJvYcCUYREVhMKE49TV0lHk1W6ewI4+VQsin0WO/qsA/nqcV4L+70Q3OPQ/oqGAvqK5HLFm/yGosP+GjDtAUfpvG@vger.kernel.org
X-Gm-Message-State: AOJu0YwGevtUrUo6nvou6ryedQvX6r3Guf61p9IDFZF189KD5liq6ZCn
	60GhgFoXKvGkNjknl1HiijEX1NTj5wAIawxiuZX6iAunVKuIw/80aHHhr13GATmzNLgjLvwwNO0
	s5FU=
X-Gm-Gg: ASbGncuZ6sw/WZHoIhXikM9SqTVMbcNw38lsUv0o+JFmvnp9X37BKOI/vO+6UBoVxtX
	Y+lHAH5U0TooKQv6NdJ7FXHjxHg3CNoq7PbgDe60UyzJVuJ3Iu+hzFFnjLJfXtYIDSBH+N2mNJN
	QtqZ/Lku10b+Gff7/YBZErqt7y9QXG+YfdMw6ARHcneQ9NKrTXlwESue/gsx6FEze7J4RSWyzHd
	mM/yVP+UDsEfUSkumcbA8g99zoSXheHFCD/a/zuxFQtgNGYVXZtxCszgyz2i76Ie/RWa9VWBSbz
	aRKQqTqwJv8gjRvQBHjIDcvh5dyEkZ79XPu2AhtZuRbNwobUqp+iJzg=
X-Google-Smtp-Source: AGHT+IGpUr2WZJQaKOsdRQlMXL7bOnk6Mn/AZLOvXYyU2H42cfrm1C1cId2jELe2hC16QlBzd1DcMw==
X-Received: by 2002:a05:6402:40c7:b0:5dc:100c:1569 with SMTP id 4fb4d7f45d1cf-5dc100c17f2mr19529324a12.13.1738027647831;
        Mon, 27 Jan 2025 17:27:27 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc1861939asm6191881a12.12.2025.01.27.17.27.25
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2025 17:27:26 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aaf3c3c104fso318984866b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jan 2025 17:27:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWvTgkl0PdoGATCFAD0/+itjvvvWP/JYzXGB++RNlEnkzSebY5N95sS+JI73J7TWycXRjOlowOH29fRP7mr@vger.kernel.org
X-Received: by 2002:a17:907:d1b:b0:aa6:6e02:e885 with SMTP id
 a640c23a62f3a-ab38b3cdcd3mr4003758266b.47.1738027645212; Mon, 27 Jan 2025
 17:27:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127044721.GD1977892@ZenIV> <Z5fAOpnFoXMgpCWb@lappy>
 <20250127173634.GF1977892@ZenIV> <Z5fyAPnvtNPPF5L3@lappy> <20250127213456.GH1977892@ZenIV>
 <20250127224059.GI1977892@ZenIV> <Z5gWQnUDMyE5sniC@lappy> <20250128002659.GJ1977892@ZenIV>
 <CAHk-=wiyuiqR9wJ5pn_d-vmPL9uOFtTVuJsjVxkWvvwzhWEP4A@mail.gmail.com> <20250128012120.GL1977892@ZenIV>
In-Reply-To: <20250128012120.GL1977892@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Jan 2025 17:27:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=whtfm7wKucbsT7=qSvtt7YZcQNmgn_cj3+h__1w7d_0WQ@mail.gmail.com>
X-Gm-Features: AWEUYZneZ4sFVqXGLnXui8P5IYGpZoLvCLcZo8joVqBWXirb5sF4mRZa2aCsstk
Message-ID: <CAHk-=whtfm7wKucbsT7=qSvtt7YZcQNmgn_cj3+h__1w7d_0WQ@mail.gmail.com>
Subject: Re: [git pull] d_revalidate pile
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Jan 2025 at 17:21, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Umm...  On some architectures it does, but mostly that's the ones
> where unaligned word loads are costly.  Which target do you have
> in mind?

I was more thinking that we could just make the fallback case be a 'memcmp()'.

It's not like this particular place matters - as you say, that
byte-at-a-time code is only used on architectures that don't enable
the dcache word-at-a-time code (that requires the special "do loads
that can fault" zeropad helper), but we've had some other places where
we'd worry about the string length.

Look at d_path() for another example. That copy_from_kernel_nofault()
in prepend_copy()...

             Linus

