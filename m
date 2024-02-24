Return-Path: <linux-fsdevel+bounces-12677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 093CF8626E4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 20:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22DC9B21519
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 19:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C03C487A9;
	Sat, 24 Feb 2024 19:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bO3Gq6Dm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03959482C6
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Feb 2024 19:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708801910; cv=none; b=rOCRNbps5d+ffiI50h1yBo+NbsprMIDCFVMAmAot4vtJjzbz6SQVSmF/35yeKKXMvrhBYw7n6wRv4/k+kwNUexyCOFcj2X3rr63E/P4UT0vJNW5oJaU4pBHbSbApyVzRmc1Bw8/UswVGCiYyRAo43s5Xx+64xAueg4+77nOEqUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708801910; c=relaxed/simple;
	bh=fweICtA4eArWnGkUUK/T6EMubJx7TjcY3269SFLrzMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XU/SBfoF59kgam0fnCLmel+maphuRjdE3M1iTskbv3ZPYW24vR5i9FzoT5qxv+35HHeC2+vUm1gaKV7kEeY7CiSK8VNWzvIdJLzkGNt+Z92it8V8sd88hpJsZRfR/vg6iQmvnHsdw3RBZn7HeuJYT0Z/ZnAaQLj5coaeWiJYW88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bO3Gq6Dm; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-563c403719cso2173152a12.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Feb 2024 11:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1708801907; x=1709406707; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v3rIRZE6qd8PRkBRyLQqB1Dk89aejWHzm1lt6LZxklY=;
        b=bO3Gq6DmSIQjjp84s8OU0ern7k9RWh+Nbnq5njm8TPuiDYk3uWEQq9smW1UICswdv2
         kpEdyYEeFUKJG+LzmaNjbz5RWV9sJPi9kwSKMznzMkfCOddZsbL4n6WKcrfnL4tM4ecl
         CPWUf+g6StG577kiBogvpsXSwZT/M2BjqluIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708801907; x=1709406707;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v3rIRZE6qd8PRkBRyLQqB1Dk89aejWHzm1lt6LZxklY=;
        b=uT/C8+waeWdZBjXasKryqE8PJUl50T0x2ObelDXrZ+cvW7Pb4qmbxaHk+eeGGsfPyf
         siJr7vixD2r7Lh9w1eyBDSo+VzGH/UsVKZjZe8LpvvtjIWhYCdj6pU1J85eX7mCwJ1Tg
         y20GamdMatJ9kLrqh94RL5wvapMZnz3CTiPrBAF3n2zwbBQLBhMPlkBlCukAwAnD5kIq
         YTogZPzdrAW0nTxPG58GTM7v4VOxJLrcGedrLWeTZClLdjyOo5pB+i1zo4WgvJW3Y6Zr
         dcrBi5u1KELjUaWJyXKzBpvvy6Bz47CAzTeHUpgT+MGnOD5eQ5NqFJrntG1JUAsS82x3
         EWOw==
X-Forwarded-Encrypted: i=1; AJvYcCWCjID8esa+/by3laU2xfbiPuiNGWmW/A3BnkDaNauy1E+7gSRCLyRb6trBYaUArL3f3utzI6gUs13V2x0EcpOj0nOvdv5n5u8LrPOfKw==
X-Gm-Message-State: AOJu0Yz8nLQKW/pDuReGVATFq1IBr0DOiMl2rk/mhbjXANjC6hstDAnB
	4DnKnGJO/lRj1CRULkMQc99FW4O9XERMOXxCAKzugw1yrNhGfUUs/2Fo75/RpefczHynhT2NCqm
	FDXY=
X-Google-Smtp-Source: AGHT+IEI3wGDxy6kb565XYOomB9yza8G+5MLuAxhptsHP9A7+pQHYd5xRUYxYrBfKe0dOVIfc/TwlA==
X-Received: by 2002:aa7:d750:0:b0:565:9ac6:a9e5 with SMTP id a16-20020aa7d750000000b005659ac6a9e5mr1493071eds.21.1708801907167;
        Sat, 24 Feb 2024 11:11:47 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id da16-20020a056402177000b00565b0852e12sm598633edb.39.2024.02.24.11.11.45
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Feb 2024 11:11:45 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a26fa294e56so320537066b.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Feb 2024 11:11:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUY9pLdhitqRbBRbeByYPKUI5lNmlUOG9PdjM/4tqv+IG4Td/e45Bp87xrezRiBD5uHh2ihv1Q4zE2g1D7MlIE2KiG74HIqixPY3XwchA==
X-Received: by 2002:a17:906:260d:b0:a3e:d2ea:ff5e with SMTP id
 h13-20020a170906260d00b00a3ed2eaff5emr2238168ejc.58.1708801905524; Sat, 24
 Feb 2024 11:11:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zdkxfspq3urnrM6I@bombadil.infradead.org> <Zdlsr88A6AAlJpcc@casper.infradead.org>
 <CAHk-=wjUkYLv23KtF=EyCrQcmf9NGwE8Yo1cuxdaLF8gqx5zWw@mail.gmail.com> <CAHk-=wj0_eGczsoTJska24Lf9Sk6VXUGrfHymcDZF_Q5ExQdxQ@mail.gmail.com>
In-Reply-To: <CAHk-=wj0_eGczsoTJska24Lf9Sk6VXUGrfHymcDZF_Q5ExQdxQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 24 Feb 2024 11:11:28 -0800
X-Gmail-Original-Message-ID: <CAHk-=wintzU7i5NCVAUY_es6_eo8Zpt=mD0PAyhFd0aCu65WfA@mail.gmail.com>
Message-ID: <CAHk-=wintzU7i5NCVAUY_es6_eo8Zpt=mD0PAyhFd0aCu65WfA@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
To: Matthew Wilcox <willy@infradead.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, lsf-pc@lists.linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>, 
	Daniel Gomez <da.gomez@samsung.com>, Pankaj Raghav <p.raghav@samsung.com>, 
	Jens Axboe <axboe@kernel.dk>, Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>, 
	Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 24 Feb 2024 at 10:20, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> If somebody really cares about this kind of load, and cannot use
> O_DIRECT for some reason ("I actually do want caches 99% of the
> time"), I suspect the solution is to have some slightly gentler way to
> say "instead of the throttling logic, I want you to start my writeouts
> much more synchronously".
>
> IOW, we could have a writer flag that still uses the page cache, but
> that instead of that
>
>                 balance_dirty_pages_ratelimited(mapping);

I was *sure* we had had some work in this area, and yup, there's a
series from 2019 by Konstantin Khlebnikov to implement write-behind.

Some digging in the lore archives found this

    https://lore.kernel.org/lkml/156896493723.4334.13340481207144634918.stgit@buzz/

but I don't remember what then happened to it.  It clearly never went
anywhere, although I think something _like_ that is quite possibly the
right thing to do (and I was fairly positive about the patch at the
time).

I have this feeling that there's been other attempts of write-behind
in this area, but that thread was the only one I found from my quick
search.

I'm not saying Konstanti's patch is the thing to do, and I suspect we
might want to actually have some way for people to say at open-time
that "I want write-behind", but it looks like at least a starting
point.

But it is possible that this work never went anywhere exactly because
this is such a rare case. That kind of "write so much that you want to
do something special" is often such a special thing that using
O_DIRECT is generally the trivial solution.

                   Linus

