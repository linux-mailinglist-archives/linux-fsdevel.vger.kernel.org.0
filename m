Return-Path: <linux-fsdevel+bounces-49743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64274AC1D7F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 09:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 524B93BEDFF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 07:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90961202976;
	Fri, 23 May 2025 07:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EIza2Uyo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8346C1EF397
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 May 2025 07:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747984706; cv=none; b=ASVeVJ0uVhopzlQFe0hmPVnXbD35/BjTj2zdZnyGsPyVJJiKdtB5nQPEkVi1U7RKtvi+ijP6BbH5m9jSk+Vcxya6CAxnf82jrrS4NguaU/paCS+eqm1kGyRgUH1a+kNn/yrXBfBlt4eTmGGAhu6jh5dZmbARX7lrFfadxBqXTFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747984706; c=relaxed/simple;
	bh=lVYMphes35U9lkXFrf4iNVcCwNEwl0JdKp5SGA1MAAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=moXF1xcYrq2OPypheAbbd3oWG5ys6EuFaDkHj4uUIP7AVJS+RC6VJBgs3HUDNMkLl1XTRXB6ksB5GfLhk8sgDOvq5iLX1ubVTDXsthHpZMKPUYHDS0cSfQPwlOe/Wx6GR+yk4aBSYuHJm48aQ3Ok/pIlmrA2MYob6fjtVmMNqm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EIza2Uyo; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-74267c68c11so7620142b3a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 May 2025 00:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1747984705; x=1748589505; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nT5x4R3EOROpWwoxoCqfM0RYSyQwM4rLGow549o6NuI=;
        b=EIza2UyovrzcbuNvZzsMi3zMlV77+D2cVrkfHWEo4T9xYcXcvbcM1adPC1E3aDb5pB
         D5Duh+6McvvRWt+er4VpVERiq6UsathroscFUg5CaQ4aTkcg9ziqoLaDoXneRz1eUmFJ
         3tcxS/ipOqsHi5dG9prLDJDqL2PMyf8P9HTRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747984705; x=1748589505;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nT5x4R3EOROpWwoxoCqfM0RYSyQwM4rLGow549o6NuI=;
        b=FOcfT/QqTG39YoEW2AxB06ts0IwM1u6YCwhrD2wueGG2DJk4Lcg5nUhYcnpkUtATBH
         a0Z/S9Kh7pm1dXw0W0m3k4O92uzMUBKiUBd5ipYNGTL0QBSAsdw3u4/QIiAk0x9sORkE
         DR7/eVdYC09bwryk4AYjqnPRtwQchdgUierEJAvGAKk/ICs28ACRP/wcZhTjlYhPllWW
         UUsqvxHi2XRi6xdaXhBM/nViAEVuO5qr4OlHf6i8v7Ib9n3pTPe+BCgVFUvu+h5VS87Q
         0Ix3sdc0YWsNp5X35clJ3GSBuNmCKqb7H/30wQKyEPASffzu1mjlCH/TvhG/GEHhWhCx
         V5Lg==
X-Forwarded-Encrypted: i=1; AJvYcCXGTDH/5sQZWnSRx2TliA+mJUNORnmy3RLagRQTs/5BrYQYvp5QYO0BupK+ySq0rn9nV+2hXLNJUwAHNyGm@vger.kernel.org
X-Gm-Message-State: AOJu0YzaEbv3PlKh6813OeGJDRO+WH72n1b523kVLDUTq+fG37g3CNxc
	Lx6fbfzjp1USnjeEVfziOJ7R00lwVqdX3Y1GqJ2Cr6TwWhCINmlFFXLWbEiP4caORw==
X-Gm-Gg: ASbGncvVw6tur56SPCJuzuyqDCplIeeQ7lWcO0Moldbwdj3uM83K5LoviysLKDM6T6b
	5GO7LL0PXwf+ynEdKik935cPTwB6NFEYNR07Rf4RR3NtlR7GDImHlwixhnGV5ksgR4O6zi9RaKc
	o3mDXHaPiqhq6CYXn0ACfChcaTYXgEf2UMrRsP2pMV5sIX8qv3SqCfJnGQPLdupM4uZeRwOUdYv
	edvPAmhAhPBo9/Gp7ko5Z937GwifYTtEVLwukrYIMHkBH45nM2a4kk4767NVA+UeXXPb9wyV9rB
	8pcy59QRQBbljSfIoWjCb22CXRi7A13s/w7GQ7+V6yoOHQJ93paqgZcg5xf3YI9Z0Q==
X-Google-Smtp-Source: AGHT+IFey4kxcjPV6xyVJcvfXT9T7AbAZLEUoMeC5l047BI9jzfUsoDQSq1r8kyTPBiYpRr594WLgg==
X-Received: by 2002:a05:6a00:3492:b0:740:596e:1489 with SMTP id d2e1a72fcca58-742acd736e4mr36713925b3a.23.1747984704781;
        Fri, 23 May 2025 00:18:24 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:17f7:e82e:5533:af02])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a970d7c5sm12716099b3a.67.2025.05.23.00.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 00:18:24 -0700 (PDT)
Date: Fri, 23 May 2025 16:18:19 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Jan Kara <jack@suse.cz>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Amir Goldstein <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] fanotify: wake-up all waiters on release
Message-ID: <ccdghhd5ldpqc3nps5dur5ceqa2dgbteux2y6qddvlfuq3ar4g@m42fp4q5ne7n>
References: <3p5hvygkgdhrpbhphtjm55vnvprrgguk46gic547jlwdhjonw3@nz54h4fjnjkm>
 <20250520123544.4087208-1-senozhatsky@chromium.org>
 <bsji6w5ytunjt5vlgj6t53rrksqc7lp5fukwi2sbettzuzvnmg@fna73sxftrak>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bsji6w5ytunjt5vlgj6t53rrksqc7lp5fukwi2sbettzuzvnmg@fna73sxftrak>

On (25/05/21 12:18), Jan Kara wrote:
> On Tue 20-05-25 21:35:12, Sergey Senozhatsky wrote:
> > Once reply response is set for all outstanding requests
> > wake_up_all() of the ->access_waitq waiters so that they
> > can finish user-wait.  Otherwise fsnotify_destroy_group()
> > can wait forever for ->user_waits to reach 0 (which it
> > never will.)
> > 
> > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> 
> We don't use exclusive waits with access_waitq so wake_up() and
> wake_up_all() should do the same thing?

Oh, non-exclusive waiters, I see.  I totally missed that, thanks.

So... the problem is somewhere else then.  I'm currently looking
at some crashes (across all LTS kernels) where group owner just
gets stuck and then hung-task watchdog kicks in and panics the
system.  Basically just a single backtrace in the kernel logs:

 schedule+0x534/0x2540
 fsnotify_destroy_group+0xa7/0x150
 fanotify_release+0x147/0x160
 ____fput+0xe4/0x2a0
 task_work_run+0x71/0xb0
 do_exit+0x1ea/0x800
 do_group_exit+0x81/0x90
 get_signal+0x32d/0x4e0

My assumption was that it's this wait:
	wait_event(group->notification_waitq, !atomic_read(&group->user_waits));

But I guess I was wrong.

