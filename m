Return-Path: <linux-fsdevel+bounces-39986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F33A1A92E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 18:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 922A17A27C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 17:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1811F17278D;
	Thu, 23 Jan 2025 17:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isk76Loe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FD5165F13
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 17:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737654547; cv=none; b=kWu9mYQPXGy2gPpWSNP/SRwPRIowKnogl3dEU1WLCnC9E2l3/nUS/qTBf0zbMT7JMIXrdElXNGJ2/1x/JwWp2bocKpKAAIFKo2QElkF2SqdBSMzMAt1crzxe+uvNhQtnmEXJArhc4we3is/q81I7K0/c8M+sGCU2xhlPUNYzIUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737654547; c=relaxed/simple;
	bh=XR579GmNd0RPRia6P9BLhpC9LiIljIk1DKY/sg3BKPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rLGisOA9DazydnVvf5e6JN7e5HvBrmg+dx3+GVbjwazOda+LaWy2+TQpP0yWG1KdbJwpHBpTYAPBg/aCiyWBUnST/0GLTKp4Jy5tDi+S1bPHDZ1tTMlYopw4nJdN9HOkA4HKByZdtmDlIK/tp2lDcQqol0oWMXklHZ9nnJJkf1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=isk76Loe; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6dcdf23b4edso10708076d6.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 09:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737654544; x=1738259344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XR579GmNd0RPRia6P9BLhpC9LiIljIk1DKY/sg3BKPI=;
        b=isk76LoegZiCMJzpqc2oGnPF8kpkms2i4ce+T+wGYt3pVUggKZf+lcTcwV5ymBUvo/
         Ac/p+fIFViSgQaxdv/vG3pR8kRXRiBJdNblIKX+HkYD+RolrJaGKIINN7+Rg9dmvco2d
         z491uTt8BWau0SeJgcuScpkzyQWK/sbXQsd3UpU6JKsBIw8hj54qmqmGwgdSEgi1dlsd
         qXSt/ZBETytRt+kTTW8UrBjTxQhSrQ5WZ6ic9TjMyuw7ponr9y9ZugiHMxc/yN1GlfDi
         rh4ixmn4oOZX/2JYMsMNlxzZChNsrxW+p6Z5mpvFqf+dd4wuOvoK39ZbsnNuqEF4xyV0
         i1Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737654544; x=1738259344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XR579GmNd0RPRia6P9BLhpC9LiIljIk1DKY/sg3BKPI=;
        b=I4KwRbdMkLGjgXObf4viIbGpA7v+lmCHs37UiDtYef3RlovmcLvKWalFUvF2Bo3XB8
         k+edjULwCFlV8ipYyH2YpbSA/VqmlJVejqHDwbSc25G3QIu/Jo7+8cAzJa2NUbb5+oN0
         9Wdp/mdM4CYNOOTcyZfSagrxmdTDOLxLiiIhuQZX3+Q76CIqt2nVeIVgJLF9/vhxoxVJ
         ijmV/Dt7IzdC+s49+nW8A53kJzxg2zuRwojVrS5CbQ/fwokEB4F0rk061JUy1oEacgW5
         m7LRX0FdK3k7wG3tRG2mA8Ox+LFxM1+8BgGRJwFv7Fzz6M4KlKZsPeKZaukzGzc9xle0
         4cig==
X-Forwarded-Encrypted: i=1; AJvYcCXG/pZSJ5cqWphQjA29XHqWGBfOLti6/K7w0x7MXAT25vZwRMJzelioSe9mlLrQ52Kt/QbjQnf9jbmGlMkT@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9bwDDirwJjFWmjD7X6ROkjEgK4iY8o7eVjyvCwKNXAyfSIAKt
	/TYtZzFRBSv413YQnKZrH1yEKC4HcKdYczJZ4Z4avJp5gGD5jGk2HvrgmqyZotzQSIeKtah+Vrc
	uj6MVqsDFfiKUunVb+kGzQUcmTN4=
X-Gm-Gg: ASbGnctr7op6d5AGC0nnQaNvLIriK24zIA8ma12nBSDT+Lo3kI3Yk+OT+iRkbb1XVW5
	XHgD860m6ssMyUCdMzkmPBLirhC94YkaNOofK2AA9iTY9EWp5ROaf3UPg572xchB8h6KJWIosU4
	4G4g==
X-Google-Smtp-Source: AGHT+IHB344R09ZulhAI4V5kCa4uUhmSg9etrz+06FR9MT1Edvw1FEv58JjT0abKTHobp10fxU9MFiCDyZrp77G+PR4=
X-Received: by 2002:a05:6214:260b:b0:6d8:92c9:12a0 with SMTP id
 6a1803df08f44-6e1b224cc1cmr394810736d6.44.1737654544243; Thu, 23 Jan 2025
 09:49:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122215528.1270478-1-joannelkoong@gmail.com>
 <20250122215528.1270478-3-joannelkoong@gmail.com> <87ikq5x4ws.fsf@igalia.com>
 <CAJfpegtNrTrGUNrEKrcxEc-ecybetAqQ9fF60bCf7-==9n_1dg@mail.gmail.com>
 <9248bca5-9b16-4b5c-b1b2-b88325429bbe@ddn.com> <CAJnrk1bbvfxhYmtxYr58eSQpxR-fsQ0O8BBohskKwCiZSN4XWg@mail.gmail.com>
 <4f642283-d529-4e5f-b0ba-190aa9bf888c@fastmail.fm>
In-Reply-To: <4f642283-d529-4e5f-b0ba-190aa9bf888c@fastmail.fm>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 23 Jan 2025 09:48:53 -0800
X-Gm-Features: AbW1kvbmKpSWCRtCY7qSZOFqZUDGynV3QC6Za3xU8t7IM9HJSOC-SeqFS-5qc6M
Message-ID: <CAJnrk1YDFcF5GPR23GPuWnxt2WeGzf8_bc4cJG8Z-DHvbRNkFA@mail.gmail.com>
Subject: Re: [PATCH v12 2/2] fuse: add default_request_timeout and
 max_request_timeout sysctls
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Bernd Schubert <bschubert@ddn.com>, Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	jefflexu@linux.alibaba.com, laoar.shao@gmail.com, jlayton@kernel.org, 
	senozhatsky@chromium.org, tfiga@chromium.org, bgeffon@google.com, 
	etmartin4313@gmail.com, kernel-team@meta.com, 
	Josef Bacik <josef@toxicpanda.com>, Luis Henriques <luis@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 9:19=E2=80=AFAM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
> Hi Joanne,
>
> >>> Thanks, applied and pushed with some cleanups including Luis's clamp =
idea.
> >>
> >> Hi Miklos,
> >>
> >> I don't think the timeouts do work with io-uring yet, I'm not sure
> >> yet if I have time to work on that today or tomorrow (on something
> >> else right now, I can try, but no promises).
> >
> > Hi Bernd,
> >
> > What are your thoughts on what is missing on the io-uring side for
> > timeouts? If a request times out, it will abort the connection and
> > AFAICT, the abort logic should already be fine for io-uring, as users
> > can currently abort the connection through the sysfs interface and
> > there's no internal difference in aborting through sysfs vs timeouts.
> >
>
> in fuse_check_timeout() it iterates over each fud and then fpq.
> In dev_uring.c fpq is is per queue but unrelated to fud. In current
> fuse-io-uring fud is not cloned anymore - using fud won't work.
> And Requests are also not queued at all on the other list
> fuse_check_timeout() is currently checking.

In the io-uring case, there still can be fuds and their associated
fpqs given that /dev/fuse can be used still, no? So wouldn't the
io-uring case still need this logic in fuse_check_timeout() for
checking requests going through /dev/fuse?

>
> Also, with a ring per core, maybe better to use
> a per queue check that is core bound? I.e. zero locking overhead?

How do you envision a queue check that bypasses grabbing the
queue->lock? The timeout handler could be triggered on any core, so
I'm not seeing how it could be core bound.

> And I think we can also avoid iterating over hash lists (queue->fpq),
> but can use the 'ent_in_userspace' list.
>
> We need to iterate over these other entry queues anyway:
>
> ent_w_req_queue
> fuse_req_bg_queue
> ent_commit_queue
>

Why do we need to iterate through the ent lists (ent_w_req_queue and
ent_commit_queue)? AFAICT, in io-uring a request is either on the
fuse_req_queue/fuse_req_bg_queue or on the fpq->processing list. Even
when an entry has been queued to ent_w_req_queue or ent_commit_queue,
the request itself is still queued on
fuse_req_queue/fuse_req_bg_queue/fpq->processing. I'm not sure I
understand why we still need to look at the ent lists?

>
> And we also need to iterate over
>
> fuse_req_queue
> fuse_req_bg_queue

Why do we need to iterate through fuse_req_queue and
fuse_req_bg_queue? fuse_uring_request_expired() checks the head of
fuse_req_queue and fuse_req_bg_queue and given that requests are added
to fuse_req_queue/fuse_req_bg_queue sequentially (eg added to the tail
of these lists), why isn't this enough?


If it's helpful, I can resubmit this patch series so that the io-uring
changes are isolated to its own patch (eg have patch 1 and 2 from the
original series and then have patch 3 be the io-uring changes).

Thanks,
Joanne
>
>
>
> Thanks,
> Bernd
>
>

