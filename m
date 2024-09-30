Return-Path: <linux-fsdevel+bounces-30429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE5A98B138
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 01:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 563361F24E31
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 23:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9B3189525;
	Mon, 30 Sep 2024 23:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RBHvZAtC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3752C1B4
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Sep 2024 23:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727740408; cv=none; b=mzj6hnUg51zJimtrUiI2BDkpidi36hApVoPVh7pfgyUxjRjIyLfTPYi7xrxmhg7n5VpZ/Z9fdCK6d3kmsFiwkjXYfgKQnDcMZYrwJaiaKBUCoAl7oCcuVfXxd6BQR6kp8CEKQaDDhKZOPzWsMp1UGsbszZfuLCWb3hDmUyYmI4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727740408; c=relaxed/simple;
	bh=jqmfhlo6Nq51O9MWU++JmBpPZJAwV8doQ3e17gImTUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BJrYNataqiN3mwhwe4JdFEAA5vwSRbV9SEZ1W0TMqAqCbfFXCkVVsa4RolfvVuMkbOnbJvb5tglprCWD677zbUhXLGXYfvQWfaICLUCMShRl3v6Hy5/eeX/crv4gnfdGBM0EbBmQjE0eKjTAvSc/L8FWEeut0ZYlL/xpjwHlAw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RBHvZAtC; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a8d2b24b7a8so1101170066b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Sep 2024 16:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727740404; x=1728345204; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N6S4zxOawKjAaveDpwT3Z661D+kmHQpHbS1yW1IiFsM=;
        b=RBHvZAtC0XjQpmoqJR68dCZw+hsgv8tvLlPKhiHnhrzNR25lSuyqu7IbKpmov4l7Yu
         7mfl4yllnK68MDoREddpYigV5KUXfv+f/3RXYMFACnGeSI9agkrzflgvfua78Wao8PNs
         fQRBgLb0OSCzFbgT4FsWEVW1bmG/3zrPc5gMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727740404; x=1728345204;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N6S4zxOawKjAaveDpwT3Z661D+kmHQpHbS1yW1IiFsM=;
        b=OxpoEh/UneqOu744eFDz9xbn/2tCzc4PBGMcWNxUuayLF4RR1EoxCm+9rKBKZrz5WN
         4Aa1iP4ilPa4Cru7OSQheU30m9n2XK3jBcwZ8OOXD0sXm9DD1NizzT6RWMJRmsYOdm4f
         6MfdMBslzGSPeqvE6lcl/X7tyxc/qCmdtE2+P/tBz/Q9ZpqijqJ7U5PCx4Taq+Ti9NG4
         429G3tzVx+6xcTagTRSRVxXg675UADHZz6cyh3eeZuDm7MuhsWFuFR6DN73jaErV0BDE
         hC2I7ZuJAex6xNQfdNd8Dw/ylRWdsmi1EX/q1tQ3mwUEmUaVv8PxJHaU4ShD34rhCrn1
         ya5A==
X-Forwarded-Encrypted: i=1; AJvYcCWey4PDvy2sSSRhZgd8qBN9M36zYcVALHJ4IvPLujVE9scapE8m4SL4qLkuxS+2nZp6UU/VPqunQBokXRIo@vger.kernel.org
X-Gm-Message-State: AOJu0YzSva1tshtS5pkIMyY/HwOZvQHrtvfVTzEyECod7HP5m2428VqK
	lL3QozzSfKIp/HQSLLz2Vs/nO4SIYb4u2+jnUOLKn/ZlzfjiiZTMnmCyZbB+GCOX4WR9rHy+hoz
	kOakHyg==
X-Google-Smtp-Source: AGHT+IEOtzdQP87jtuIu+7gAutIqqQCqJuo0TkI2QRrNxHDn5Vu50xzQ+ulbq11QbYrneQ6BdF22nw==
X-Received: by 2002:a17:907:6e9e:b0:a6f:996f:23ea with SMTP id a640c23a62f3a-a967bf67b2amr138851666b.15.1727740404540;
        Mon, 30 Sep 2024 16:53:24 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93e49542afsm381230266b.205.2024.09.30.16.53.22
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 16:53:23 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c88c9e45c2so3802133a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Sep 2024 16:53:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXYpixVSK19BfxwUBgCHLCAMg7iu3o0BbzPmeHdJw+bIPkE+UGKlWyLWeq4d6VETFlJ+BCl5otVY172A/r5@vger.kernel.org
X-Received: by 2002:a17:907:7294:b0:a8d:5f69:c839 with SMTP id
 a640c23a62f3a-a967bf527c8mr104147566b.15.1727740402409; Mon, 30 Sep 2024
 16:53:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZuuBs762OrOk58zQ@dread.disaster.area> <CAHk-=wjsrwuU9uALfif4WhSg=kpwXqP2h1ZB+zmH_ORDsrLCnQ@mail.gmail.com>
 <CAHk-=wgQ_OeAaNMA7A=icuf66r7Atz1-NNs9Qk8O=2gEjd=qTw@mail.gmail.com>
 <E6728F3E-374A-4A86-A5F2-C67CCECD6F7D@flyingcircus.io> <CAHk-=wgtHDOxi+1uXo8gJcDKO7yjswQr5eMs0cgAB6=mp+yWxw@mail.gmail.com>
 <D49C9D27-7523-41C9-8B8D-82B2A7CBE97B@flyingcircus.io> <02121707-E630-4E7E-837B-8F53B4C28721@flyingcircus.io>
 <CAHk-=wj6YRm2fpYHjZxNfKCC_N+X=T=ay+69g7tJ2cnziYT8=g@mail.gmail.com>
 <295BE120-8BF4-41AE-A506-3D6B10965F2B@flyingcircus.io> <CAHk-=wgF3LV2wuOYvd+gqri7=ZHfHjKpwLbdYjUnZpo49Hh4tA@mail.gmail.com>
 <ZvsQmJM2q7zMf69e@casper.infradead.org>
In-Reply-To: <ZvsQmJM2q7zMf69e@casper.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 30 Sep 2024 16:53:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wire4EQTQAwggte-MJPC1Wy-RB8egx8wjxi7dApGaiGFw@mail.gmail.com>
Message-ID: <CAHk-=wire4EQTQAwggte-MJPC1Wy-RB8egx8wjxi7dApGaiGFw@mail.gmail.com>
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
To: Matthew Wilcox <willy@infradead.org>
Cc: Christian Theune <ct@flyingcircus.io>, Dave Chinner <david@fromorbit.com>, Chris Mason <clm@meta.com>, 
	Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org, 
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Daniel Dao <dqminh@cloudflare.com>, 
	regressions@lists.linux.dev, regressions@leemhuis.info
Content-Type: text/plain; charset="UTF-8"

On Mon, 30 Sept 2024 at 13:57, Matthew Wilcox <willy@infradead.org> wrote:
>
> Could we break out if folio->mapping has changed?  Clearly if it has,
> we're no longer waiting for the folio we thought we were waiting for,
> but for a folio which now belongs to a different file.

Sounds like a sane check to me, but it's also not clear that this
would make any difference.

The most likely reason for starvation I can see is a slow thread
(possibly due to cgroup throttling like Christian alluded to) would
simply be continually unlucky, because every time it gets woken up,
some other thread has already dirtied the data and caused writeback
again.

I would think that kind of behavior (perhaps some DB transaction
header kind of folio) would be more likely than the mapping changing
(and then remaining under writeback for some other mapping).

But I really don't know.

I would much prefer to limit the folio_wait_bit() loop based on something else.

For example, the basic reason for that loop (unless there is some
other hidden one) is that the folio writeback bit is not atomic wrt
the wakeup. Maybe we could *make* it atomic, by simply taking the
folio waitqueue lock before clearing the bit?

(Only if it has the "waiters" bit set, of course!)

Handwavy.

Anyway, this writeback handling is nasty. folio_end_writeback() has a
big comment about the subtle folio reference issue too, and ignoring
that we also have this:

        if (__folio_end_writeback(folio))
                folio_wake_bit(folio, PG_writeback);

(which is the cause of the non-atomicity: __folio_end_writeback() will
clear the bit, and return the "did we have waiters", and then
folio_wake_bit() will get the waitqueue lock and wake people up).

And notice how __folio_end_writeback() clears the bit with

                ret = folio_xor_flags_has_waiters(folio, 1 << PG_writeback);

which does that "clear bit and look it it had waiters" atomically. But
that function then has a comment that says

 * This must only be used for flags which are changed with the folio
 * lock held.  For example, it is unsafe to use for PG_dirty as that
 * can be set without the folio lock held.  [...]

but the code that uses it here does *NOT* hold the folio lock.

I think the comment is wrong, and the code is fine (the important
point is that the folio lock _serialized_ the writers, and while
clearing doesn't hold the folio lock, you can't clear it without
setting it, and setting the writeback flag *does* hold the folio
lock).

So my point is not that this code is wrong, but that this code is all
kinds of subtle and complex. I think it would be good to change the
rules so that we serialize with waiters, but being complex and subtle
means it sounds all kinds of nasty.

            Linus

