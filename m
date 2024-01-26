Return-Path: <linux-fsdevel+bounces-9093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2071183E194
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 19:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 535A61C214BC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 18:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2C91EF1E;
	Fri, 26 Jan 2024 18:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Wx2A9qie"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE5221A0C
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 18:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706293888; cv=none; b=uSkTOISi4zQK6M9irQcSyEDAShnxuihBWxrnsSbh/L7JQxoUv3NRCK7HxXNcvwW3jF0sTA+fI/qJJKuhWHFGbSgOszl27lo/fi9lgpobdVEsW1Cw2xXJMlfrkkGdp3NX5TFmMQ468us5E2myTt89bH6/OndIe6VJhajYzTUNr7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706293888; c=relaxed/simple;
	bh=W7B76i3+B9hYS0jCDzE1qW/RvQJCSXTVBuxx+AfGDdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F7OjNW48lUZeXjEym4Evqzo+VK8gS0fQyluaw05U5x97WwPvG3oBP+mjgmOJrBKYtIUTOJZUMj0rY7DWr643yiYPmWsA1u5qAZSG50v6MklDe5Le+Zq/6an5QhqQlIcdsmEVw/Y5X92YT/U3jrnQ2Dk5i1PiEObFNTqSWpA7z+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Wx2A9qie; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50eabbc3dccso806522e87.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 10:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706293885; x=1706898685; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mdy4NXmtqUV6APWQzUWxFYpWUDUY5MY8BJqI1nPSu7g=;
        b=Wx2A9qieYIbSrzzcEStmTkov8NiyT7165kKVH7ip7ciWsRocp0fzGNISspD3qf1NKH
         hQRA6hLnrrf8rdBpzJWu19hewRfRfOidN6aBT1RQxpj4xTLVZ/X0nTmUrqYwlPMU0XKj
         lY7eTZ+yH2qp5ZnSQCEAMCZ9Z8kzTW3SEFKlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706293885; x=1706898685;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mdy4NXmtqUV6APWQzUWxFYpWUDUY5MY8BJqI1nPSu7g=;
        b=agzoa9SQPYYnNMERiNYcvHIyM8bh/J92WUcVEIVBaGQIHOlldGCHHZrWR3RtQ+ABRH
         +KoveY5E61ZzMNkljYj4danSrlLtLvhxhbptMbZ0k8n3a8BYU6cqpJc/jywxyn9ofq8m
         I7EZ0QW7EAzHEC1ag47vqSpWHuFxMfIuA2qni8TqH0ECnaDd0OVlXh9bdxjq7+tG3sKu
         4bFqGF1sWFvrLZ59PkIVFJgUQXK88mEvawi2UpICUEYBZ9eeBwvPVMG/TU2zfls7XXpY
         sZ2AmS1TccSOYH0FxewVa0I78R9/IRrJOJvkFQC7trk0WUu3Yu7xC31vTci0nxqLUq7K
         oj5g==
X-Gm-Message-State: AOJu0YzStLwl+Cm4DK+tRQEFb6DzZM6AWUh1h+a7qlHPoQa/kwmbw3RQ
	TtvIGpYPQqI8wW0shfBQSvPKNVEGU0Aupa9LvCeAtZOzDRd/jXaunf/gYueOP4PWVTBsEThvxSn
	uvpo=
X-Google-Smtp-Source: AGHT+IEBwPhVGVeabDd66SqhL8Z3mIuxaPQNo20K3ReuODf2zH70zApHFNwJUkr3qVmy7ng22Mrlwg==
X-Received: by 2002:ac2:51ad:0:b0:50e:e2e2:d4c5 with SMTP id f13-20020ac251ad000000b0050ee2e2d4c5mr38321lfk.5.1706293885002;
        Fri, 26 Jan 2024 10:31:25 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id m17-20020a056512015100b0050f0a04f0a9sm249472lfo.40.2024.01.26.10.31.24
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 10:31:24 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2cf4a22e10dso7556321fa.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 10:31:24 -0800 (PST)
X-Received: by 2002:a2e:be8a:0:b0:2cf:12a2:c1fa with SMTP id
 a10-20020a2ebe8a000000b002cf12a2c1famr96305ljr.215.1706293883810; Fri, 26 Jan
 2024 10:31:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126131837.36dbecc8@gandalf.local.home>
In-Reply-To: <20240126131837.36dbecc8@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 26 Jan 2024 10:31:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=whA8562VjU3MVBPMLsJ4u=ixecRpn=0UnJPPAxsBr680Q@mail.gmail.com>
Message-ID: <CAHk-=whA8562VjU3MVBPMLsJ4u=ixecRpn=0UnJPPAxsBr680Q@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Give files a default of PAGE_SIZE size
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Christian Brauner <brauner@kernel.org>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jan 2024 at 10:18, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> By following what sysfs does, and give files a default size of PAGE_SIZE,
> it allows the tar to work. No event file is greater than PAGE_SIZE.

No, please. Just don't.

Nobody has asked for this, and nobody sane should use 'tar' on tracefs anyway.

It hasn't worked before, so saying "now you can use tar" is just a
*bad* idea. There is no upside, only downsides, with tar either (a)
not working at all on older kernels or (b) complaining about how the
size isn't reliable on newer ones.

So please. You should *NOT* look at "this makes tar work, albeit badly".

You should look at whether it improves REAL LOADS. And it doesn't. All
it does is add a hack for a bad idea. Leave it alone.

                   Linus

