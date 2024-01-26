Return-Path: <linux-fsdevel+bounces-9111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE6F83E404
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 22:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1DBB284DE4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 21:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D55E225A5;
	Fri, 26 Jan 2024 21:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="iKkZLDSW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8524F1DFD9
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 21:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706305001; cv=none; b=mYEwg3w0tscmyzZf77PiTgB0VxBV3dhHsCWQv4UGZOO9NYJnjclE1EV87e8+QRZNmQVpieWzI7t9AURRMmfUlphWS7XevJtNVQSefHHWTQxZnkDTBmYZaKeSwEWUor/3vK4MGFx9mNOdEEWRwhU5RN342eo+j4RTFPFNZ71xy0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706305001; c=relaxed/simple;
	bh=YfaSbj7aWucYRD8fpKinICpQCEEwoP2iLjQO/Z3wcuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lvw9XwT+BbNlzloF6QG5a2wgeqcUS4cWIkjUoti2aKqPBH7CHl8koCsjd4M5YgQeeCWIHVHWEmgHu6n+yhJJu2UP36GQV/G5vqtTMGGmq9AwlasM5DZeW/83hYkYeEVMBCsWw5G7hs91+WCdWwJaxq43G825ODgB4XY/EIX602M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=iKkZLDSW; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40ee418e7edso12697165e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 13:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706304997; x=1706909797; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CvqA4oK/Qg0raxZ+27W7q7BWtiVAxq8zsa6fXWM1cKw=;
        b=iKkZLDSW+6hp07wNnKL6tXBFlxzbgBO3yJRlxOxG5YhwmPItJEtCKFD5Fv+sWSRmYX
         v2pX4ev7Kn+tw5U0g/Au9rHC5LAQeSl+MPtv7n0uaEscNmsr/HVyRJ6dflxqOksvQodG
         Lxg5BQeNkG5YunfSlbOj9OM8087S/GYvo9RBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706304997; x=1706909797;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CvqA4oK/Qg0raxZ+27W7q7BWtiVAxq8zsa6fXWM1cKw=;
        b=Lg4QnpwlvDbgLLGLpPoi6JGB29oYwGraijL3ETumfVeQNTJSExrprmg+hVSin6pev4
         uHs7MznPdxk8I8FGADkf96RrpCBGF55xOXa67ZIw92qJJbQjy/ylDU4W/YYZIc55PlOa
         zRUajDvubpFE2dQ1BYPbl/3s5IstlSlh3vzttIfNh5ngjzYabhoMnEVTZ9AhlaiP5dQr
         LkboPiU231Wz3WYjb9EyZNikxKpzvHbfzH8cPWHvICZFiO5adhIT6HI9u9M+24ccnXD6
         RqUbU6yGRpw958yqnpVEJtfCeNBshnpqKKrEmT5gmm51xNhCV9h4xKj8ZDvqFmnKWk2E
         tQww==
X-Gm-Message-State: AOJu0Yy81Xc4oxWQP49ZM+JyX61TD3juzMocxW7UMCq3jSMiGlYjigvz
	6ccTh953AU0m/4treu2uyzvRD/fjM8RbCWlwgZtwqMc4iI5ITOA6KjRDLDM+tWuRt83+tkm6dtv
	ynEdX+w==
X-Google-Smtp-Source: AGHT+IGEYzJ3vN+C//bkbW8KGajAmOBnkBg6mZjtJvenIyJ/a/NTHseVK3rKp8U0nsymBjZC7YSFSw==
X-Received: by 2002:a05:600c:35d5:b0:40e:af40:b4da with SMTP id r21-20020a05600c35d500b0040eaf40b4damr309846wmq.26.1706304997454;
        Fri, 26 Jan 2024 13:36:37 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id ml19-20020a170906cc1300b00a3145f5820asm1050035ejb.144.2024.01.26.13.36.36
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 13:36:37 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55c2c90c67dso576684a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 13:36:36 -0800 (PST)
X-Received: by 2002:a05:6402:1656:b0:55d:4375:cd14 with SMTP id
 s22-20020a056402165600b0055d4375cd14mr223875edx.26.1706304996651; Fri, 26 Jan
 2024 13:36:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126150209.367ff402@gandalf.local.home> <CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
 <20240126162626.31d90da9@gandalf.local.home>
In-Reply-To: <20240126162626.31d90da9@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 26 Jan 2024 13:36:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj8WygQNgoHerp-aKyCwFxHeyKMguQszVKyJfi-=Yfadw@mail.gmail.com>
Message-ID: <CAHk-=wj8WygQNgoHerp-aKyCwFxHeyKMguQszVKyJfi-=Yfadw@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Devel <linux-trace-devel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Christian Brauner <brauner@kernel.org>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jan 2024 at 13:26, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I'd be happy to change that patch to what I originally did before deciding
> to copy get_next_ino():
>
> unsigned int tracefs_get_next_ino(int files)
> {
>         static atomic_t next_inode;
>         unsigned int res;
>
>         do {
>                 res = atomic_add_return(files + 1, &next_inode);
>
>                 /* Check for overflow */
>         } while (unlikely(res < files + 1));
>
>         return res - files;

Still entirely pointless.

If you have more than 4 billion inodes, something is really really wrong.

So why is it ten lines instead of one?

Dammit, this is a number that NOBODY HAS SHOWN IS EVEN WORTH EXISTING
IN THE FIRST PLACE.

So no. I'm not taking this. End of discussion. My point stands: I want
this filesystem *stabilized*, and in s sane format.

Look to *simplify* things. Send me patches that *remove* complexity,
not add new complexity that you have zero evidence is worth it.

Face it, eventfs isn't some kind of "real filesystem". It shouldn't
even attempt to look like one.

If somebody goes "I want to tar this thiing up", you should laugh in
their face and call them names, not say "sure, let me whip up a
50-line patch to make this fragile thing even more complex".

            Linus

