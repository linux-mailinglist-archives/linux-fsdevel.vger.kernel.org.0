Return-Path: <linux-fsdevel+bounces-2432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD657E5E82
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 20:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7EF7B20D75
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 19:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60EF36B1F;
	Wed,  8 Nov 2023 19:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A8QtkpFW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D2836B06
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 19:25:36 +0000 (UTC)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0A52110
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 11:25:36 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1cc3542e328so20725ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Nov 2023 11:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699471535; x=1700076335; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uWUjp1kT4QadWCPtlP2kQwh/Ipvn+sm+hKLdkqyjovw=;
        b=A8QtkpFWV0yoYeO7nkf1L1uajgS2jaLH1xnHmhbrt/jpiXmkFis51gQzCH5BsIO48k
         bKv2nN6ky9U9lGFIZmso0whW8z+pTngEUETkgaLPWosJBgEgaW0bMFslXVYj1boW/Nqd
         XxKge1wj32mHp4A6GLq+U6/Ml1Pe/5Dsn3eU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699471535; x=1700076335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uWUjp1kT4QadWCPtlP2kQwh/Ipvn+sm+hKLdkqyjovw=;
        b=oYMfI5kxmYTYxiN9E8Dk0bzeoaDN0N5GFzRg1rdZ0f2dkhtQf11YDGbnc+1IdAv628
         23SEPjDzMf4wOHGaruEfVq2WLEywYeapTM9KaKYg0Ucx/ejg5Y1JrmV91HzdzrYMfdrk
         0ttBtPqfWMXq/bJ64QFYuckSZLeyn+WsBsqPdQsVQ0K/gGRzCu1aIRanLjWZaXndb2e2
         TGAJ8QUEfGft62gXVHuwEgzOQgZ0oge7Bb5DWyemtJMYiP65a+uRKmUr9zjAsNO0UT1x
         PqH1brmmrj5Vq/jeCt0QrzeT6PsFpMWySkDTyIslyd56WF07wChH8+f2LJ7t/EXxV63O
         +EMg==
X-Gm-Message-State: AOJu0Yy+SCm603WSAZz5pREOeMdlbCGAw1MnCubScwZPiEM7P5D59uWV
	BqMkFUtwG8pN3udctHqzNQfCHQ==
X-Google-Smtp-Source: AGHT+IFWQvD64GPyRJT6Hb58vipaf+YJS2on70JhtNQdeZqsPwpz2F6tsQ6yRwN8BcF7cB5aQ/N19w==
X-Received: by 2002:a17:902:ecc6:b0:1cc:4072:22c6 with SMTP id a6-20020a170902ecc600b001cc407222c6mr3552930plh.24.1699471535672;
        Wed, 08 Nov 2023 11:25:35 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ix22-20020a170902f81600b001b8a00d4f7asm2097005plb.9.2023.11.08.11.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 11:25:34 -0800 (PST)
Date: Wed, 8 Nov 2023 11:25:34 -0800
From: Kees Cook <keescook@chromium.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Josh Triplett <josh@joshtriplett.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/exec.c: Add fast path for ENOENT on PATH search
 before allocating mm
Message-ID: <202311081123.391A316@keescook>
References: <5c7333ea4bec2fad1b47a8fa2db7c31e4ffc4f14.1663334978.git.josh@joshtriplett.org>
 <202311071228.27D22C00@keescook>
 <20231107205151.qkwlw7aarjvkyrqs@f>
 <CAGudoHFsqMPmVvaV7BebGkpkw=pSQY8PLdB-1S3W5NpYh6trmA@mail.gmail.com>
 <202311071445.53E5D72C@keescook>
 <CAGudoHF5mYFWtzrv539W8Uc1aO_u6+UJOoDqWY0pePc+cofziw@mail.gmail.com>
 <A7FFA44F-F7DD-477F-83A6-44AF71D6775E@kernel.org>
 <CAGudoHESNDTAAOGB3riYjU3tgHTXVLRdB7tknfVBem38yqkJEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHESNDTAAOGB3riYjU3tgHTXVLRdB7tknfVBem38yqkJEA@mail.gmail.com>

On Wed, Nov 08, 2023 at 01:03:33AM +0100, Mateusz Guzik wrote:
> [...]
> >>@[
> >>    __pv_queued_spin_lock_slowpath+1
> >>    _raw_spin_lock_irq+43
> >>    wait_for_completion+141
> >>    stop_one_cpu+127
> >>    sched_exec+165
> >
> > There's the suspicious sched_exec() I was talking about! :)
> >
> > I think it needs to be moved, and perhaps _later_ instead of earlier?
> > Hmm...
> >
> 
> I'm getting around 3.4k execs/s. However, if I "taskset -c 3
> ./static-doexec 1" the number goes up to about 9.5k and lock
> contention disappears from the profile. So off hand looks like the
> task is walking around the box when it perhaps could be avoided -- it
> is idle apart from running the test. Again this is going to require a
> serious look instead of ad hoc pokes.

Hm, that is pretty interesting. I'll see if I can go find the original
rationale for adding sched_exec() in there...

> Side note I actually read your patch this time around instead of
> skimming through it and assuming it did what I thought.
> 
> do_filp_open is of course very expensive and kmalloc + kfree are slow.
> On top of it deallocating a file object even after a failed open was
> very expensive due to delegation to task_work (recently fixed).
> 
> What I claim should be clear-cut faster is that lookup as in the
> original patch and only messing with file allocation et al if it
> succeeds.

I'm less familiar with the VFS guts here -- I'm open to alternatives! :)

-- 
Kees Cook

