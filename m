Return-Path: <linux-fsdevel+bounces-39699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB93A170E4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 17:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9405A1885C77
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 16:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527171EC01D;
	Mon, 20 Jan 2025 16:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3Qx9r5+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7D21EBFEB
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 16:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737392200; cv=none; b=Acnl/WM1B/JyFttPWJ9S/Gae5Did6TY1rHuepglXORQpuY0d5D+mQiGnM3Ea2a2Y9jrcj6y6BfsiluedvMprUUbRMceP2ak7kRq9oqyNBp9YsIL52akI+wEGy3SheK5rOOoqR/btkpPmzY2XxM3ZDdcjerY/sp58d/BW5cS9Vcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737392200; c=relaxed/simple;
	bh=4CvVSY5hWxosVkVreTkBr9Yrr92TsfK5tAEGgE4motY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j2P8TPXGpIKjvybybcctrbmu8BA4kydxFvL9viRmZCU/uy1MVZS9ni7i7KIFhRNsr6Q8E8pVSixPfxE8ZKLzBvUx1F7afCOfTFvPwI9RqGalkfBq2UmODFEe7wbRS7dFdErcOhrKq5G4IkIZgMZnYbAfAiX5vQZl0Gu/Rx7QIPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P3Qx9r5+; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d414b8af7bso9767238a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 08:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737392197; x=1737996997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4CvVSY5hWxosVkVreTkBr9Yrr92TsfK5tAEGgE4motY=;
        b=P3Qx9r5++GnmMlPVeBmsuTNaSP1uuwveCA00EfDFtTxp2OXHeC15tonxzv6u4zPPmi
         0U6Cpwp2mdwnRsuiP0jWjkaOmxK23Sz5LBxTP6JO3mQv0xEJWbNNo3NAv5IhEqRpQ6Eg
         TN1KR+tijYuqKqKUkgpvX6TZyUtQEGno/A1B05WK4pR1gw4LbNFy+JyjVxvwUc8k+kAL
         gt149CM+/bGoYtgbgt+xNPj5bSAQ0G9mJp352LzFZlB2gzr3N+vb0D2erVXdJn3SJc2f
         lGGH23TirKcWDa3SCfdLei3j8iOWSZskQ3B08bH+8fjZ/oFesHfHKhKryns7FfUlxUQ4
         Z6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737392197; x=1737996997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4CvVSY5hWxosVkVreTkBr9Yrr92TsfK5tAEGgE4motY=;
        b=MKcZ8BiWvDAwX0woV/Jd+7kf6TG3hmZwZ+4arLC4JoAfN6Ux5uEpyCjffsmTP7q1LH
         9L7P5CjUyEtTnDXs27wJG5IEJJmbBWoqPuwY8yCLcDU4NNx3H0OmNtsHoOVcxWHPt6CH
         85kxDoPFoGG5RuVrFmskXXKteJ18reGiS6gZrT34I+NkBhYlEFPB1AgQ9Ee4Kswetr41
         xzfRRvkqekyhFKSCNKf9DHqJowo97zLMthcN+WC6DydCBzCAVu4ciYsBWDtsY8jAZTiL
         z8mnIFweLaGr7YddDMrH2O9qgQarltEUXB+YpGqCqOym0uw1CUsCVzE7je9izfh+adLu
         w8AQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjq8Km3YFBYjByvGnoRT8ltqOthgFoYHgM/G4yFS5JAuTmivyqjoECDSZ7oF1DENi1hBNkeB9gvjmNIH2j@vger.kernel.org
X-Gm-Message-State: AOJu0YwNgRuGZO/6xIPiZLYrfZVwun8KySrrJk/8u6S3e5JNCUn65wza
	dwhvehWDlZ/sWPE2mERf5MVPm1n95gxJ0pnZ+APrZpupmdABxCweIbnMS6k52ANB88YBKKhJLxE
	1zuQVhmMwih0WIH9RHMl5nEsHtuU=
X-Gm-Gg: ASbGncvx4zmOTlYCsjMuzdd4vPmk902sMniqt5K9caVzyJym7n2s8BRyfNabwl5jxN5
	dD6FbvyF9Ia2f5Fm55R0moKv948y9wMIcIqsg80RrOiJB2tTc8QU=
X-Google-Smtp-Source: AGHT+IF14A19T+Gx11YlcY8v4DNdzLQUA+vTHCkjLeQUh/0qf2OWi8InoQ9ihBBc7ztM+Gi8v/put8sMIX0NOyq3PLw=
X-Received: by 2002:a05:6402:3509:b0:5d0:cfdd:2ac1 with SMTP id
 4fb4d7f45d1cf-5db7d2d9958mr13973390a12.6.1737392197031; Mon, 20 Jan 2025
 08:56:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202501201311.6d25a0b9-lkp@intel.com> <leot53sdd6es2xsnljub4rr4n3xgusft6huntr437wmaoo5rob@hhbtzrwgxel2>
 <20250120121928.GA7432@redhat.com> <20250120124209.GB7432@redhat.com>
In-Reply-To: <20250120124209.GB7432@redhat.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 20 Jan 2025 17:56:24 +0100
X-Gm-Features: AbW1kvbaXg9VK4NnspF3WjlWEwZ0pL-tI_NNyxvLDripmfqOiy7OOAZAjI8A9k8
Message-ID: <CAGudoHFOsRWT0nKRKqFwgHdAhs0NOEO4y-q7Gg4cjm9KBxQc9A@mail.gmail.com>
Subject: Re: [linux-next:master] [pipe_read] aaec5a95d5: stress-ng.poll.ops_per_sec
 11.1% regression
To: Oleg Nesterov <oleg@redhat.com>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	Christian Brauner <brauner@kernel.org>, WangYuli <wangyuli@uniontech.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2025 at 1:42=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> Forgot to mention...
>
> On 01/20, Oleg Nesterov wrote:
> >
> > On 01/20, Mateusz Guzik wrote:
> > >
> > > Whatever the long term fate of the patch I think it would be prudent =
to
> > > skip it in this merge window.
> >
> > Perhaps... I'll try to take another look tomorrow.
> >
> > Just one note right now.
> >
> > > First two notes:
> > > 1. the change only considers performing a wake up if the current
> > > source buf got depleted -- if there is a blocked writer and there is =
at
> > > least one byte in the current buf nothing happens, which is where the
> > > difference in results is coming from
> >
> > Sorry I don't understand. Unless this patch is buggy, pipe_read() must
> > always wakeup a blocked writer if the writer can write at least one byt=
e.
> >
> > The writer can't write to "current" buf =3D pipe->bufs[tail & mask] if
> > pipe_full() is still true.
>
> But I'll recheck this logic once again tomorrow, perhaps I misread
> pipe_write() when I made this patch.
>

While I'm too tired to dig into the code at the momen, I did manage to
grab an extra data point for hackerbench. Note on my setup (24-way) it
takes way longer to execute with your patch.

I checked how often the sucker goess off cpu, like so: bpftrace -e
'kprobe:schedule { @[kstack()] =3D count(); }'

With your patch I reliably get about 38 mln calls from pipe_read.
Without your patch this drops to about 17 mln, as in less than half.

--
Mateusz Guzik <mjguzik gmail.com>

