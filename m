Return-Path: <linux-fsdevel+bounces-66908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BE9C3042C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 10:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86B18466E01
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 09:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5085E328B5D;
	Tue,  4 Nov 2025 09:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="aDC1exI6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBDB3126D2
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 09:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762247594; cv=none; b=Wc6LEnGf1mb8/eYr2Qv+1IuFP08ilMF+kK6GAe2VysqSPdxsncPRNkB4BTwCCh3IHreZRVO+oBIgdNAoO/RrDoOPbw1GdyuBh5BjfL85dHWGyOYZAVwwG9ellB+jYtjuuYsukzjVrjEBVnuJeT8+s1x+1ryAVrj/EEGonUnzo5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762247594; c=relaxed/simple;
	bh=NDU1hiQwu7FdHTpMhd0I9FoiS/nc8IPLEwr44cI7vmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CvkArn1XBMJTytvZ6KrTLVAoq9VeQaQScLR1naJ5Q4hfVbiQ8rxHs8jsdtGpvC0bR2MP9p2PBsBRFb2DGqTu1evISzjXY2gv48SU9EoRu85EOH4GFXBi0XwStWWewOxGn56HelYTLQsp3qCcWjpWdnNpB0B6NRCw6xqqlPzyvxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=aDC1exI6; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-59431f57bf6so1444373e87.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Nov 2025 01:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1762247591; x=1762852391; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3JJwXSbqr+v12TtiF4SUvzSMGeBbQ6+WpMyUrdAjzl0=;
        b=aDC1exI690qjpWiKayywuA8Eq/3IwToORd/8kn7JT8cuAuuurmD9EQYzl11U/f8+am
         spMuHdsiLBFI+mwakT26jYJd4Zq5z3cbrWlmuvotGqQgP2KXFjPX0GOG+BnjHKiJH4Bg
         Zl8dTjOVx8D6jEinZWj51pCaMNFcPZdvO/7U8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762247591; x=1762852391;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3JJwXSbqr+v12TtiF4SUvzSMGeBbQ6+WpMyUrdAjzl0=;
        b=YLd5gbeyBb+0VQQpTjdG9SCtwpPzrvWC5XiWsDtqI5OIhTxHrg3PfaIirWKWg+6I2T
         3GdFJbxhNRnHm5eb4m60L4MUKeW3AfJah189aeeL0uPQxAd4iURe9FNjOmjHdckZOvn6
         QogW4jq0JsUyGAmDcfrL1HgLXdU6eeVnYjjppeG05m2Aq7NFGw4v3Ay8QNsPtVYS+Dj0
         BNTyUhVWNxWEvp1C9JGsLlU46lx2bM6TUYK8JTT8XgbbhQI2Tq8gARdt+UiS0y0G5UXA
         f2ehJ8sjR/Xt/XY7oMW//At5qe7AGRe6tVpa2tj69vZpUF1W9ilR5C7cnWbyaM9iS0In
         PpUA==
X-Gm-Message-State: AOJu0YyJ/XAlmtH71VE3gOd6j7eetr0QdG8oo4qR4T8SlBx76PrWlH4g
	59NATw3zS6laInAesjIQANcAbvEHlao5T/g1lXf+k4vQvcGpyFdwYZEzBi3aYUDXxa3k2z4vj6o
	ub21zjghMqF+bXkGHdwVML3t4oxB5y1hoku97NlM49A==
X-Gm-Gg: ASbGncu4KcV7ad36FsmIxk4h4wvzT18U7CKJ1eNUp6FJeWnUrWwv3lKx9kFvUw1B0km
	3pDgqx18egEDJzNXN12Gh9hmqkEqJ4c6jog/ApFN7d86mShRT/sskoAn1XEFTWY5lH/8vN2o1+y
	b6vOoiMT8YE9W2UmAWgb37USGHCqybaphkrltKJ83i82DWW0bJdRKQDARTy3EPDVh3WbpMLll23
	KXu6jfRoGWPnqOEYIPdBhefGcqYT/xgxj+Jr5r1I72YdQElA+5CoN6SK6X+5nnLho0JWtg=
X-Google-Smtp-Source: AGHT+IGIrgqZur4fdDqVzzBvNjnqurbHh6qFq/W76MRjvcgGMQTlFuhtN29tyTK2nV0YI6a9E/yOj99hDn+LYF28LEI=
X-Received: by 2002:a05:6512:b8d:b0:594:2997:629b with SMTP id
 2adb3069b0e04-59429976537mr2228773e87.0.1762247591236; Tue, 04 Nov 2025
 01:13:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org> <20251028-work-coredump-signal-v1-16-ca449b7b7aa0@kernel.org>
In-Reply-To: <20251028-work-coredump-signal-v1-16-ca449b7b7aa0@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Tue, 4 Nov 2025 10:12:59 +0100
X-Gm-Features: AWmQ_bmXdEopZCYfcyuYWp30tuUpRICJUFmghYYmVfsBZAPlWH78ckTbofZQDFc
Message-ID: <CAJqdLrr25D+-M0kPhFkh-7pp1J3Z3B21DhfQaXOvTEN-3D3LQA@mail.gmail.com>
Subject: Re: [PATCH 16/22] selftests/coredump: handle edge-triggered epoll correctly
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, 
	Amir Goldstein <amir73il@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Yu Watanabe <watanabe.yu+github@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Jeff Layton <jlayton@kernel.org>, Jann Horn <jannh@google.com>, 
	Luca Boccassi <luca.boccassi@gmail.com>, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Mike Yuan <me@yhndnzj.com>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
Content-Type: text/plain; charset="UTF-8"

Am Di., 28. Okt. 2025 um 09:47 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> by putting the file descriptor into non-blocking mode.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  tools/testing/selftests/coredump/coredump_test_helpers.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/tools/testing/selftests/coredump/coredump_test_helpers.c b/tools/testing/selftests/coredump/coredump_test_helpers.c
> index 7512a8ef73d3..116c797090a1 100644
> --- a/tools/testing/selftests/coredump/coredump_test_helpers.c
> +++ b/tools/testing/selftests/coredump/coredump_test_helpers.c
> @@ -291,6 +291,14 @@ void process_coredump_worker(int fd_coredump, int fd_peer_pidfd, int fd_core_fil
>         int epfd = -1;
>         int exit_code = EXIT_FAILURE;
>         struct epoll_event ev;
> +       int flags;
> +
> +       /* Set socket to non-blocking mode for edge-triggered epoll */
> +       flags = fcntl(fd_coredump, F_GETFL, 0);
> +       if (flags < 0)
> +               goto out;
> +       if (fcntl(fd_coredump, F_SETFL, flags | O_NONBLOCK) < 0)
> +               goto out;
>
>         epfd = epoll_create1(0);
>         if (epfd < 0)
>
> --
> 2.47.3
>

