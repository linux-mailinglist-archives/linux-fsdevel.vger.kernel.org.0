Return-Path: <linux-fsdevel+bounces-20544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7958B8D5006
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 18:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 164F81F23E7F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 16:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970B928DBC;
	Thu, 30 May 2024 16:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXemE1/m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F70823777
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 16:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717087491; cv=none; b=gzpieD8ujv0I4d2JSQVDD9DOKXTQ4qhz1+uT3XsSuaekKLNMvLx+z63D4ML1e28TN54Gk7AivOi4/8ThgBNCN7ovlVF04OldSTB+4H1QUS2tRbi0PvWF7cEtsI3L/c6O+VN3HuQblXYEAMhTOPT5+iT2jyEM6AC2NsTXda1EiMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717087491; c=relaxed/simple;
	bh=t4dArSdUJYLFqF9fB++hFwh+xqExRj4hAZz/VWdv6Jc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iJ1/BXMvquyBvrN45zf8myN6nL2QCr30xBhzJK7oqYi4c952AUtp4AiukH5jXD/ALsHOxDIb3uVPcy4KvTSJ7GeUhvP7GzOh9KJcZdzkavbpTpsoWid4QdatHr/PhNVD4y5gqR58NmKutxkNeGB1DVR3UplbG2Q4dSWeRXxnOf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXemE1/m; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-df771959b5bso957771276.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 09:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717087488; x=1717692288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0KdGIlB/j1mDA4JE1Kq2B0SSrOwXPOvfq9nCNwY25g4=;
        b=NXemE1/mqiXlqCZdtwYC9E3+iR5qEmcwjuh0ZfkWLXfZHF281DkKNd3xdFgp7xIBOa
         YaaKbg6mNuj5tfz6DtWr1abk4kcQKTe1KbrGdEDgjv9nGdtOk9gtd2/D2ahnMOBtAmSm
         WBu8y+sbCeYYkgcwlIOB4bpPOOzrpEM5Qmh7m4JC3FSSJX3wGgi3Y3vXQV+4S2+V1VNq
         BOS5faX9y9aVRX2cAQFCfUbdR7wIVpCJRlQ23ZBK9m+szCOoeqH8qYBiI9UjkVQpa3TM
         DU8InARyjfqvf/BvwE/wU/YfFxXmZzAo1bchoUZwUjHHmcYaBHl1kFFeW+7NikmDZbcG
         U7Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717087488; x=1717692288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0KdGIlB/j1mDA4JE1Kq2B0SSrOwXPOvfq9nCNwY25g4=;
        b=lilUJSLnQCphUHZfSpGtH3DP5NZNHO77Xl+r+E3nV+DCk6ZynAmfLGUhzxAcNxxG2J
         TRnsyc5hNe5JYWFvPllUi8CoAylgGqadmZfDABXbEKP7SFcwcb+8adWry4S5Y/2duvHY
         Ys3Bll3P1xOjnlyDG5T2WM+hDVS22fe/NPYH0vv4v9vcZYUdD15T1a+dWaSaWNUjak/b
         PPFaE2M2kMb8018IiefaRC7RdC/4iMwjN8UiPFKk+eL1a7h+Q0Oet4aGqPfnvazDFlVF
         DkPT1Dw4ZVk0IJ4e6JHupkPkUYvApSxp8JijuhJhh1h6g8FpDmwZ7HxtFgm1m2pWkmw2
         95Xw==
X-Forwarded-Encrypted: i=1; AJvYcCXejQ1NQPk5LJdvH/gLpcdUzDYQW/TU+7kFonO6ZHLzyBjeitAcGIJhu4HmHlE92aDVnU5Ma6Ngbw96uKEhgF3ga629clDeJaLTcJxVtw==
X-Gm-Message-State: AOJu0Yx9RGlmrRv41cx5bsSlqyJyFPQsCse3eOAgXaA8r4YEupEAXYpT
	tfs85xZ/tz+SREVr/TrmUwWUwP0cIxOemuZT5bkP9qniRw26fJh+xzPrOq7mo/g+SB+vPLUjcSI
	sYUKjmw7XaLNSO2xNk2vUu0o7CX4f6rB7
X-Google-Smtp-Source: AGHT+IFfdt6se1EnZoz7vGj36lOfcni99Nr7k2YJ3FKwb94zNb7NbkLJKRWW4Uz/1trBRMsTPWnjUolXw8FQDXZmoho=
X-Received: by 2002:a25:a2cc:0:b0:de5:5084:715d with SMTP id
 3f1490d57ef6-dfa5a800c52mr3083111276.53.1717087488541; Thu, 30 May 2024
 09:44:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com> <20240529-fuse-uring-for-6-9-rfc2-out-v1-16-d149476b1d65@ddn.com>
In-Reply-To: <20240529-fuse-uring-for-6-9-rfc2-out-v1-16-d149476b1d65@ddn.com>
From: Shachar Sharon <synarete@gmail.com>
Date: Thu, 30 May 2024 19:44:37 +0300
Message-ID: <CAL_uBtfpdFAjZuALySuMoyegGpoyPFg32tw5K+vKzDsrzs=ZAg@mail.gmail.com>
Subject: Re: [PATCH RFC v2 16/19] fuse: {uring} Wake requests on the the
 current cpu
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
	bernd.schubert@fastmail.fm
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 10:36=E2=80=AFPM Bernd Schubert <bschubert@ddn.com>=
 wrote:
>
> Most of the performance improvements
> with fuse-over-io-uring for synchronous requests is the possibility
> to run processing on the submitting cpu core and to also wake
> the submitting process on the same core - switching between
> cpu cores.
>
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
>  fs/fuse/dev.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index c7fd3849a105..851c5fa99946 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -333,7 +333,10 @@ void fuse_request_end(struct fuse_req *req)
>                 spin_unlock(&fc->bg_lock);
>         } else {
>                 /* Wake up waiter sleeping in request_wait_answer() */
> -               wake_up(&req->waitq);
> +               if (fuse_per_core_queue(fc))
> +                       __wake_up_on_current_cpu(&req->waitq, TASK_NORMAL=
, NULL);
> +               else
> +                       wake_up(&req->waitq);

Would it be possible to apply this idea for regular FUSE connection?
What would happen if some (buggy or malicious) userspace FUSE server uses
sched_setaffinity(2) to run only on a subset of active CPUs?


>         }
>
>         if (test_bit(FR_ASYNC, &req->flags))
>
> --
> 2.40.1
>
>

