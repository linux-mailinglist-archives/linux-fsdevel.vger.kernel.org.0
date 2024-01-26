Return-Path: <linux-fsdevel+bounces-9105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 973F983E357
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 21:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53DF0285C51
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 20:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432EE2374C;
	Fri, 26 Jan 2024 20:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QPj29jFc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D635A224E6
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 20:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706300728; cv=none; b=dOe8HH+PpMrVf/nKlw8WSJCbhjpEO0hA85Ob1wt9Sql0BegzCAx3ML0cERPJpTlfphV91Uk2Zfjxqh0ZxT8mhlcfEOMUEJfLC3WgLAb9a4He1H0r3vs4ONWcu80YXKMbe94cy/pqZTlbhnv8flXWpKDtfphMqDIX10+oF+fo4NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706300728; c=relaxed/simple;
	bh=9+OPO3V3SP3LRuHvDOl2Rmxreo2UCuuZVrw9wtlT3Qg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TxtdPmdHJ6mbEuEnxHX75HzmtjURd7hwLtzb0LwkTuPe6+46Puv9jSUleoNPt8DQ/ascVPIrNp4I7Ey3MtNf7KzwUBz3axQtT1kYrIUzxdFYCxVcFkgOCBE8d1j2DOuS/wCh1oL2EdrCU4Q2rCDeY9ZwiWWtg5FoPRI7q9bHT30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QPj29jFc; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2cf1fd1cc5bso9024391fa.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 12:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706300724; x=1706905524; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ANDDmreLZfT1WX/HwjJ1bWT4NTPKcyNOAiea0NIAPr0=;
        b=QPj29jFcpalD29ebe+l7fwI6zsx6iWZyr4exXNH81BalNz4gryHcwEhChrhniGdzGp
         qehZOWrGmpLXa/0STQwdHHZXqD81XWusm2Q49xTBhnuAQRQJH29VLBgGpTIQPeHpE4RJ
         Jou1Q0Q99N9Nz/ByRY+91VA9z51AI9VZ9cChs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706300724; x=1706905524;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ANDDmreLZfT1WX/HwjJ1bWT4NTPKcyNOAiea0NIAPr0=;
        b=OSBa6BqN53nrXgZ698ThIqzd3oMKIxkcActVkz6vjSJTMH4VwbRQvi8JWKvT2nhV5n
         yYB9oaznXgp8oernnn/pSx1Mm6No59MhqRsr3G7pZE5RTb24Hnrwmr7+mrt6TWfwN9Lb
         RpmltpWghrrCDwO+y7mDB0ny/RCV5FWjsFYGW+vRAW7Gktuuov7B2+spJZ7ydYV7EK2m
         4pyMrgC4st4Gk5oFc+t0FMt/jHEuyDzne1J+AOQm+HjupqbZsr2nM2eCABPK7GVIYD6G
         k5Qv+Lp663OeCEokbzGjVO38Ucnb8k6DKBHhPf0XxyWgeUDkIlZRlvJH1BPNsgXvM2o3
         FErA==
X-Gm-Message-State: AOJu0YyWAMbrg6LV1joXW2/Bosbt9a7un61H4k40fZpxXU/EaEbrMGL1
	ar4q1dFd7cZfFCazRJfL6hHpYN8homdJ0e9//px5ab6QeGpc57Psy8JbYTtXO5QyNretrBDmkeu
	onP7eQg==
X-Google-Smtp-Source: AGHT+IGralObzCXiqf0eTyGArnsDPDmM35MHJTJfCGBEil7fVbAVQeCimS1QS0zlVE5GLsO5kiPDCw==
X-Received: by 2002:a2e:b0f6:0:b0:2cf:1f0b:5119 with SMTP id h22-20020a2eb0f6000000b002cf1f0b5119mr419609ljl.17.1706300724612;
        Fri, 26 Jan 2024 12:25:24 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id f14-20020a05651c03ce00b002cd1a3bdecbsm257739ljp.22.2024.01.26.12.25.22
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 12:25:23 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ccec119587so9484051fa.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 12:25:22 -0800 (PST)
X-Received: by 2002:a05:651c:107b:b0:2cf:4170:d181 with SMTP id
 y27-20020a05651c107b00b002cf4170d181mr392047ljm.7.1706300722280; Fri, 26 Jan
 2024 12:25:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126150209.367ff402@gandalf.local.home>
In-Reply-To: <20240126150209.367ff402@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 26 Jan 2024 12:25:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
Message-ID: <CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Devel <linux-trace-devel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Christian Brauner <brauner@kernel.org>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Steven,
 stop making things more complicated than they need to be.

And dammit, STOP COPYING VFS LAYER FUNCTIONS.

It was a bad idea last time, it's a horribly bad idea this time too.

I'm not taking this kind of crap.

The whole "get_next_ino()" should be "atomic64_add_return()". End of story.

You arent' special. If the VFS functions don't work for you, you don't
use them, but dammit, you also don't then steal them without
understanding what they do, and why they were necessary.

The reason get_next_ino() is critical is because it's used by things
like pipes and sockets etc that get created at high rates, the the
inode numbers most definitely do not get cached.

You copied that function without understanding why it does what it
does, and as a result your code IS GARBAGE.

AGAIN.

Honestly, kill this thing with fire. It was a bad idea. I'm putting my
foot down, and you are *NOT* doing unique regular file inode numbers
uintil somebody points to a real problem.

Because this whole "I make up problems, and then I write overly
complicated crap code to solve them" has to stop,.

No more. This stops here.

I don't want to see a single eventfs patch that doesn't have a real
bug report associated with it. And the next time I see you copying VFS
functions (or any other core functions) without udnerstanding what the
f*ck they do, and why they do it, I'm going to put you in my
spam-filter for a week.

I'm done. I'm really *really* tired of having to look at eventfs garbage.

              Linus

