Return-Path: <linux-fsdevel+bounces-29676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D1097C310
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 05:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B9A3B21BBB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 03:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D5E1758F;
	Thu, 19 Sep 2024 03:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JmC7BmOr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EDD125B9
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Sep 2024 03:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726715027; cv=none; b=P7+72FZucdWD5WtDfIYVAnHqVZZOy8o2mfjAMJuFisQePpDGHEUPwuGumy92BuG6mQ0vCiyxbNRjWVKwoD6JzeqWM+CwmeSrmtsB2A2kVxii7gRob2zqqZwtk5LqScvr8kZGoC1nDpsfnxfqyyxiTx7lh3YsKA4tmuYiZuWUPm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726715027; c=relaxed/simple;
	bh=0MvubnRoO2thymcr3IM6P8f7dqwINBUBTCZ/gsgv40A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W1ne8jh1EtSvPv7TvZoNBWQYcZdgtiirtXnxUCxeZjJDBbjAYc+e41yqnEagZwg5bENC/ZPfrutNzCn2D9EhobZJSxScejy6hyoEJu3msTZ/hdaeouStl6nq1OqDhmxPaOZN5EJ4xdkqRf8q7+9Svw0DdoYWBinkMVJXDKZySms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JmC7BmOr; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f75129b3a3so3112861fa.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2024 20:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1726715023; x=1727319823; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tyPRcAS13dyaq/sXSJCfCLBh5tay+9ZOU9JDC/uil9A=;
        b=JmC7BmOryQHUT9rI25BlAgJADQCP5kxHzSOn6PqeHEhTOdTvqzbdSxnNogXY+e5DQ/
         aOdirZjCoLkRWQ7icmjkr+bet5l8HhPffHwF/jxSfs+1quSsK+rp30koqUKvexStGk9p
         DilWbCkGIF1hj7NNqax0SIxWhDNVxPQqaWQlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726715023; x=1727319823;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tyPRcAS13dyaq/sXSJCfCLBh5tay+9ZOU9JDC/uil9A=;
        b=rjtHatmCfDph4RLpaFkHrqHvZr2qREZbXX/OACTwrP+eMY+bs6bTb+00tzVJHRQXXr
         CggG53pe/KQha74/1cwNW7qOh26rfIYoOCLYpwFvaHpcL/g+jccRVZ/M/V50W+BJk1PY
         5cOffYrOQ72BNVW2lcYXOhA4Txuy6pcR0gcFZrZ5Fn3mLi/3xV+ClvP4nMmgYNpzieGP
         t2dkHZXxeSVSnKY3mGoegELkD7EUN1CZ1rhQXl0d6hRYs2Am91WvY5MjZpgeDJREwh/8
         yC183nUynZ6G1YUKIbu+5E/Pc1xa0zfni+VZyZTi1Emzf/maJrEnmgHoSw19/U7H3Pie
         vD9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVPZpBnQoYwHQO6JNjedr7/l1Fek7Da2/eKAQpgp0KMwBpVfZxvQccED+3qV6oXZnyjZmg1ApykvvJdaeHD@vger.kernel.org
X-Gm-Message-State: AOJu0YzVA6CzKMw1uOLcenMs7vFnZLl1yJcOq0hBLIj3uOkJh/LHNnqo
	YLQj7MdBKvpp7IILv0b5fJlSymRpxnR5kArTs+1hJAdVuXxzWBMesnXY847JshJ/Ap5rvhwHcCQ
	zmsNlyQ==
X-Google-Smtp-Source: AGHT+IG1gsB1RZ7vGPaze5l6XUneOK5QurnEQ+Gx6pRcxiK9uO/wNTLDUIVDBD4You7v48hvBSeiFA==
X-Received: by 2002:a2e:e0a:0:b0:2f7:5c58:cc7c with SMTP id 38308e7fff4ca-2f787f6a8f5mr103983681fa.44.1726715023167;
        Wed, 18 Sep 2024 20:03:43 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f79d2e1eb5sm14719341fa.27.2024.09.18.20.03.40
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2024 20:03:41 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5365c060f47so390494e87.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2024 20:03:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU52sWp9O3+DqTo02lay7KcuwLWHF6zpZJkl8M+01GGaLUQW0PcUnvhkF5ZtZ6EmFSnOZRkZEfSAeNGzCYb@vger.kernel.org
X-Received: by 2002:a05:6512:220d:b0:535:6a75:8ac8 with SMTP id
 2adb3069b0e04-53678fc24e6mr13825268e87.23.1726715020071; Wed, 18 Sep 2024
 20:03:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wh5LRp6Tb2oLKv1LrJWuXKOvxcucMfRMmYcT-npbo0=_A@mail.gmail.com>
 <Zud1EhTnoWIRFPa/@dread.disaster.area> <CAHk-=wgY-PVaVRBHem2qGnzpAQJheDOWKpqsteQxbRop6ey+fQ@mail.gmail.com>
 <74cceb67-2e71-455f-a4d4-6c5185ef775b@meta.com> <ZulMlPFKiiRe3iFd@casper.infradead.org>
 <52d45d22-e108-400e-a63f-f50ef1a0ae1a@meta.com> <ZumDPU7RDg5wV0Re@casper.infradead.org>
 <5bee194c-9cd3-47e7-919b-9f352441f855@kernel.dk> <459beb1c-defd-4836-952c-589203b7005c@meta.com>
 <ZurXAco1BKqf8I2E@casper.infradead.org> <ZuuBs762OrOk58zQ@dread.disaster.area>
In-Reply-To: <ZuuBs762OrOk58zQ@dread.disaster.area>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 19 Sep 2024 05:03:23 +0200
X-Gmail-Original-Message-ID: <CAHk-=wjsrwuU9uALfif4WhSg=kpwXqP2h1ZB+zmH_ORDsrLCnQ@mail.gmail.com>
Message-ID: <CAHk-=wjsrwuU9uALfif4WhSg=kpwXqP2h1ZB+zmH_ORDsrLCnQ@mail.gmail.com>
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
To: Dave Chinner <david@fromorbit.com>
Cc: Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@meta.com>, Jens Axboe <axboe@kernel.dk>, 
	Christian Theune <ct@flyingcircus.io>, linux-mm@kvack.org, 
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Daniel Dao <dqminh@cloudflare.com>, 
	regressions@lists.linux.dev, regressions@leemhuis.info
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Sept 2024 at 03:43, Dave Chinner <david@fromorbit.com> wrote:
>
> Should we be asking for 6758c1128ceb to be backported to all
> stable kernels then?

I think we should just do the simple one-liner of adding a
"xas_reset()" to after doing xas_split_alloc() (or do it inside the
xas_split_alloc()).

That said, I do also think it would be really good if the 'xa_lock*()'
family of functions also had something like a

        WARN_ON_ONCE(xas->xa_node && !xa_err(xas->xa_node));

which I think would have caught this. Because right now nothing at all
checks "we dropped the xa lock, and held xas state over it".

               Linus

