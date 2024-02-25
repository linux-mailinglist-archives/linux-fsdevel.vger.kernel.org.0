Return-Path: <linux-fsdevel+bounces-12725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4566862C31
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 18:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37C2B28197C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 17:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A3917C7F;
	Sun, 25 Feb 2024 17:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AdALb5Kd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0833C16415
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 Feb 2024 17:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708880635; cv=none; b=PRNtDFGl9HICKNLmsQnjvh2J7NPnxB+58xgHQa/xSnnW3bTDQ/SuUvDRRONBIYp8aQ+tB9iIIG4uBiARp9yIfWa1g/OAaaIbbuRJWqCHd90T0NO4yhPl2GM6tNdS2fTDVmWmNXI0IOOZ0cqIA37so2T9twyXZrVzkH67N1bCFKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708880635; c=relaxed/simple;
	bh=hC1suwtfs13TGM2QRbOP89aHwLY8sDHmvzVfueFvIV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fcfVLgnJvTfLsgUF4PgoWHakUk1AHRTHj1DwFbe9bbXh7RPBgFZPbMvUPYrcoHIbKjsznmdruwwhAfoVpAj4D+QBxBDSFpjQaBLSOb+T1p+0kIhh1gUcexTHluCXg6iAr/m3zDveUOMQvgeHwKLyittnCFPscq3l7GsxD+bXNWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AdALb5Kd; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d2305589a2so34257931fa.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Feb 2024 09:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1708880631; x=1709485431; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SYy3wOmbUatqMC0tUK+yhnIuh+GGp0MIfopsKx9GQbw=;
        b=AdALb5KdOWvo4Zc2eBo04YlawwXiut64JgpGud16MLdPJ8zIdEiun+m9hb0c2x2QvT
         Wvcu/b/R4OW8l4Bnp0Y+sPct3zvI+bqjTNEuJ22Ux/H3vfdD3gQAlG/SB/C8jYdarqlj
         NCc3yt+Yd4uV/9FDCDYk7vdPzLzIuZu9y33YY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708880631; x=1709485431;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SYy3wOmbUatqMC0tUK+yhnIuh+GGp0MIfopsKx9GQbw=;
        b=l3HqJMRAvZys5+0Gmu/xrsma8ZN4rDOTEjXRAyvhteNdcPRYGHfv1NhFLUj1jnXGwz
         tGKMGJUYIE9BEOTG4Z11+4DPgGPSy3h0lcFiFcdrXUf96gl0QRIjjz3mNDwaHB5lPt/9
         1o28JFlfFxiDJz4oJmW5mrf/MNshXT4FoRl+XlO/O/ryQVmEEgqs8q0nxo958qODFseZ
         P5sT0PmybVoqTfpnuufjO+BLYnVShhnk71R0QGZtpsg/99luAPN6jR0uDFLow+uNozFc
         ENJiexF7j+Zq8AIylx9g6PgdxORI8xyd6lqlNcWp2huoMeuKenN+FZ8dnHpxmyHO0WnI
         CKtA==
X-Forwarded-Encrypted: i=1; AJvYcCWivQQk30JZzuCigqMX2wBeO9RNwf7dM64sqHA3nZl3wFA3ywFh2epnPR5HOLqgjxyGO+9sgrjnh3HID6pYJRjolnqKG6j0sAZ8VrAI/Q==
X-Gm-Message-State: AOJu0Yy4hvTJeeqF1N/j1Rxd972R6Nqx3X7876dsQ/le8GP6Js86w9/C
	ci/o62vvY2FhukPwqCNnovcohZdfW3m+KeS5Zj5KUCTaVxIWePX7/g5PyC+acLVyP0Mk+Vpgl2t
	NqO4=
X-Google-Smtp-Source: AGHT+IGmMonEdQFP+7TRWcf6niFaTiNpbZ8TKLvfAiRU+Bvm1x767wr/+3jp4lSo2bqmoTFslmiRtQ==
X-Received: by 2002:a2e:6a0f:0:b0:2d2:7bda:ce29 with SMTP id f15-20020a2e6a0f000000b002d27bdace29mr2567925ljc.19.1708880631046;
        Sun, 25 Feb 2024 09:03:51 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id l16-20020a2e99d0000000b002d0c8fa072asm599089ljj.20.2024.02.25.09.03.49
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Feb 2024 09:03:49 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-512fd840142so259872e87.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Feb 2024 09:03:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVB9gMAQgV2YGlFPSEGpLuBOsK96cGDk/V6FaGl+0id31r82utbHYPlYIYLxRPagpBDOb2jW9oXkl/heUeQ+2Zs+dS4TkPIknIOAjV4nA==
X-Received: by 2002:a19:7419:0:b0:512:b344:774e with SMTP id
 v25-20020a197419000000b00512b344774emr2771001lfe.22.1708880629372; Sun, 25
 Feb 2024 09:03:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zdkxfspq3urnrM6I@bombadil.infradead.org> <Zdlsr88A6AAlJpcc@casper.infradead.org>
 <CAHk-=wjUkYLv23KtF=EyCrQcmf9NGwE8Yo1cuxdaLF8gqx5zWw@mail.gmail.com>
 <o4a6577t2z5xytjwmixqkl33h23vfnjypwbx7jaaldtldpvjf5@dzbzkhrzyobb> <Zds8T9O4AYAmdS9d@casper.infradead.org>
In-Reply-To: <Zds8T9O4AYAmdS9d@casper.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 25 Feb 2024 09:03:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgVPHPPjZPoV8E_q59L7i8zFjHo_5hHo_+qECYuy7FF6g@mail.gmail.com>
Message-ID: <CAHk-=wgVPHPPjZPoV8E_q59L7i8zFjHo_5hHo_+qECYuy7FF6g@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
To: Matthew Wilcox <willy@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Luis Chamberlain <mcgrof@kernel.org>, 
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-mm <linux-mm@kvack.org>, Daniel Gomez <da.gomez@samsung.com>, 
	Pankaj Raghav <p.raghav@samsung.com>, Jens Axboe <axboe@kernel.dk>, 
	Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>, 
	Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 25 Feb 2024 at 05:10, Matthew Wilcox <willy@infradead.org> wrote:
>
> There's also the small random 64 byte read case that we haven't optimised
> for yet.  That also bottlenecks on the page refcount atomic op.
>
> The proposed solution to that was double-copy; look up the page without
> bumping its refcount, copy to a buffer, look up the page again to be
> sure it's still there, copy from the buffer to userspace.

Please stop the cray-cray.

Yes, cache dirtying is expensive. But you don't actually have
cacheline ping-pong, because you don't have lots of different CPU's
hammering the same page cache page in any normal circumstances. So the
really expensive stuff just doesn't exist.

I think you've been staring at profiles too much. In instruction-level
profiles, the atomic ops stand out a lot. But that's at least partly
artificial - they are a serialization point on x86, so things get
accounted to them. So they tend to be the collection point for
everything around them in an OoO CPU.

Yes, atomics are bad. But double buffering is worse, and only looks
good if you have some artificial benchmark that does some single-byte
hot-cache read in a loop.

In fact, I get the strong feeling that the complaints come from people
who have looked at bad microbenchmarks a bit too much. People who have
artificially removed the *real* costs by putting their data on a
ramdisk, and then run a microbenchmark on this artificial setup.

So you have a make-believe benchmark on a make-believe platform, and
you may have started out with the best of intentions ("what are the
limits"), but at some point you took a wrong turn, and turned that
"what are the limits of performance" and turned that into an
instruction-level profile and tried to mis-optimize the limits,
instead of realizing that that is NOT THE POINT of a "what are the
limits" question.

The point of doing limit analysis is not to optimize the limit. It's
to see how close you are to that limit in real loads.

And I pretty much guarantee that you aren't close to those limits on
any real loads.

Before filesystem people start doing crazy things like double
buffering to do RCU reading of the page cache, you need to look
yourself in the mirror.

Fior example, the fact that Kent complains about the page cache and
talks about large folios is completely ludicrous. I've seen the
benchmarks of real loads. Kent - you're not close to any limits, you
are often a factor of two to five off other filesystems. We're not
talking "a few percent", and we're not talking "the atomics are
hurting".

So people: wake up and smell the coffee.  Don't optimize based off
profiles of micro-benchmarks on made up platforms. That's for seeing
where the limits are. And YOU ARE NOT EVEN CLOSE.

                  Linus

