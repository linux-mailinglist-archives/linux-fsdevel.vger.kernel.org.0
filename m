Return-Path: <linux-fsdevel+bounces-25854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6171995124E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 04:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E4CC286D0D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 02:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8939C376E0;
	Wed, 14 Aug 2024 02:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLBpcB+h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809C11CF8A
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 02:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723602014; cv=none; b=LA7YGa0KwRdMjEdsULZPpNu+dTrXn+pijpgnpGYjX2ftmzBHCoIuFHo7pTAHqVl+rFUy2okthIIPwQsqpiMXTF/uDu4gnVLp14EfWuTxt8u9yeYFsGcfsL3rar2zubbfDW9ZT9Wd+BAnqWucRaLX/UZe5xcF3ZY+kSsvIXzKIBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723602014; c=relaxed/simple;
	bh=HYrxpf21d7XH2DRDLA2zJF2YgLgbO5mhSkmEaKVmWbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YfVrN7ne1FpKyPvXaidqGPleYTQh6NjB1AViTozYGleAPiPlyLek0Deh+OeF7C0OEiJpTgJJFop7ge79RYZtP2dXu6B1us3t9tqfcsIgJbo0upBBUYlOp2DTVMzJIkhV/UWe5yzJ9H94PuzSoWQ7jlqh0LwuZhXtPDU1bGbjJ3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLBpcB+h; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-70949118d26so4582254a34.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2024 19:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723602012; x=1724206812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f3V+DLbt+gBJxvflbIYvl5HUcut4u3GQMh9nwUHnO0o=;
        b=mLBpcB+hqOj9rW9mE2KkNk0qc5X3kKwyodZumArNL009GR8mlS68AMfXh+EJWrqicJ
         KahRhB2FfFN7ENiObEM0Gp+2I+3Sgfgu92lJMFpiqxTVp/1J9solipCt0aE7+8NSOQPg
         O0hdgU1Q5BBWjBAFajARv5SPx9xcmwHg36j7w5Rkn7vvy49EiEiYZl5e3rlQvUaM4GBQ
         7YGal3DJsZZrhQcvglTkLoQg3WYLWKgiI6wWAxJDdKzd5us5Y1HdfBXNBSSwTo0z9y7n
         yWZL60IpVzSQlUJgEi+QyRYNrfZrCxKhZkZdzF5s2wMhOkadrlPoGV+rw4Suamg2Dgxp
         3AyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723602012; x=1724206812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f3V+DLbt+gBJxvflbIYvl5HUcut4u3GQMh9nwUHnO0o=;
        b=H0Y9c1rnRE/4ivNEdrYVAMLC2AdYYg6VbzVMAka3sX0qXZ0pPdYpUFpBmQe2wQSP6g
         hF+XmE1LC7zWqbPrUYVRNeRJjDrgTr2+0iokK7yDikt+2jWbH/0qPWaYuGRfxJJy6253
         mDfVJrVPFNRp74OcWPhrisk/ID7/S+tZvaz1ayalaNw0+OOKVpUJiOf9ajCqp6EknyX/
         Y8mw7LEhJgNw9LtfGOmvZA05FIz/88wjLYJ78UgOemB+eFuecl08WGuzaYOFpklM1xKh
         OG/3y95+IEQ5ooIGBtdzu252jm2KRrubr1q/tqqnG3UUm6VS7VSxn+nT9EmLY2Hh+TBj
         2UIg==
X-Forwarded-Encrypted: i=1; AJvYcCVrgtmt+WfhB7ZAYrGQ+vSHy7j/Z0qvlFInkU3cgm/9GaJgQhinhukTvxdXZ9Dx7sjvaoLJSDEi/7dpJQFR@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3OkggPlmAJCoB9/HFTtgv6zF6SIYAeBwcX1tqk2nYhCTIYFJb
	TFqY0TapBJURwCmjzS30/KAtjAR+LGNV/r99LRcSkco0jkseuVco+gJcyoHDBT6zhf0cKmMRJ3T
	irBuhUbn9UIjmGgu9XjrKpeUBYLI=
X-Google-Smtp-Source: AGHT+IFi/RRWEoYuIcX8DevLhOsamNomcbuQLC280BbkURJY8WIipWABfMbY2reYR9/jrfvyKYbpzMsESqWN3yrPd54=
X-Received: by 2002:a05:6358:9144:b0:1ad:471:9b7 with SMTP id
 e5c5f4694b2df-1b1aab85b53mr160088755d.18.1723602012558; Tue, 13 Aug 2024
 19:20:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812090525.80299-1-laoar.shao@gmail.com> <20240812090525.80299-2-laoar.shao@gmail.com>
 <Zrv6Fts73FECScyd@dread.disaster.area>
In-Reply-To: <Zrv6Fts73FECScyd@dread.disaster.area>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 14 Aug 2024 10:19:36 +0800
Message-ID: <CALOAHbAfQPdpXt0SHGxQdJEi1R_u+1x2KSwZ5XfrQD-sQmhKiA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: Add memalloc_nowait_{save,restore}
To: Dave Chinner <david@fromorbit.com>
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	Kent Overstreet <kent.overstreet@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 8:28=E2=80=AFAM Dave Chinner <david@fromorbit.com> =
wrote:
>
> On Mon, Aug 12, 2024 at 05:05:24PM +0800, Yafang Shao wrote:
> > The PF_MEMALLOC_NORECLAIM flag was introduced in commit eab0af905bfc
> > ("mm: introduce PF_MEMALLOC_NORECLAIM, PF_MEMALLOC_NOWARN"). To complem=
ent
> > this, let's add two helper functions, memalloc_nowait_{save,restore}, w=
hich
> > will be useful in scenarios where we want to avoid waiting for memory
> > reclamation.
>
> Readahead already uses this context:
>
> static inline gfp_t readahead_gfp_mask(struct address_space *x)
> {
>         return mapping_gfp_mask(x) | __GFP_NORETRY | __GFP_NOWARN;
> }
>
> and __GFP_NORETRY means minimal direct reclaim should be performed.
> Most filesystems already have GFP_NOFS context from
> mapping_gfp_mask(), so how much difference does completely avoiding
> direct reclaim actually make under memory pressure?

Besides the __GFP_NOFS , ~__GFP_DIRECT_RECLAIM also implies
__GPF_NOIO. If we don't set __GPF_NOIO, the readahead can wait for IO,
right?

>
> i.e. doing some direct reclaim without blocking when under memory
> pressure might actually give better performance than skipping direct
> reclaim and aborting readahead altogether....
>
> This really, really needs some numbers (both throughput and IO
> latency histograms) to go with it because we have no evidence either
> way to determine what is the best approach here.
>
> -Dave.
> --
> Dave Chinner
> david@fromorbit.com



--=20
Regards
Yafang

