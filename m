Return-Path: <linux-fsdevel+bounces-7272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6E1823792
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 23:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8307D1C20F2D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 22:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6951DA44;
	Wed,  3 Jan 2024 22:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TXpigq1f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB19C1EB27
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jan 2024 22:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a28ac851523so93615266b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jan 2024 14:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704320067; x=1704924867; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9MZB2GKQQoVizz0Mae9gZ/uAOfWAVjDPrCIYZs+35rM=;
        b=TXpigq1fP06iV+K9Vz/jiCG8snCJB+ToJQy6mkZNLYt8SH+to9rdIa6UHpeQyYA0xL
         Of/1GWWsq9TcwpbvGyUJC/DDootYQzVqFaPqp7/QEQegurNXtkyc+uBgycRJTixATrrG
         VTEoWOu4KetX4yBFlgS5LJC9Rj7pkpnH4EMjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704320067; x=1704924867;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9MZB2GKQQoVizz0Mae9gZ/uAOfWAVjDPrCIYZs+35rM=;
        b=Rzt01vcbxzUhR9hJUDDYMevrpglIC1maJ5fQEOG3tz7KJL58rAulzNfNGShRadzUoy
         ijoTyrGlD9Z5FJQoR0W02yZjKGFg0bS24ZxXys7iHnxfJn2VPOcbHfwbLi9EPHxObJCl
         6/bxRzIkihP3Posh2oW2b21WoQekGap3wcMpViwijhmPq6LXri8p5LbidtAyvy5Ziyx8
         EqoBT8sLijMty9LyUUK8K4ExuAIC0LTy0hoFlxrEmBume1q0vhs63gVFpXaMJGDy4COp
         ot2/zwMr3rlKdvVxrTLPXnKp7JnzupTbtW/TP2JmYxxIkWC1lRmLE649snWKB1P1bOaC
         DTRw==
X-Gm-Message-State: AOJu0Yyi3tJSmL/yYmeMR/RSgf0ckp5SuKZuS7KiXfa8lU8yiRpgdNMr
	E8KdSkAZ6A/Jv08KMf4hkekq/zr+LFndo76semo5hOLW0nd8xqv2
X-Google-Smtp-Source: AGHT+IEDAWcYvO4Ge+hI4ybUTZ+6/CkaCcpmk71ZNz2cN6xhmwyXD9pDhsn1r204MsQwNGohfFuItw==
X-Received: by 2002:a17:906:f588:b0:a27:e264:e114 with SMTP id cm8-20020a170906f58800b00a27e264e114mr3522957ejd.120.1704320067127;
        Wed, 03 Jan 2024 14:14:27 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709060e0900b00a27d7657a05sm4015472eji.157.2024.01.03.14.14.26
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 14:14:26 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5555f9061b9so7524149a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jan 2024 14:14:26 -0800 (PST)
X-Received: by 2002:a17:906:6854:b0:a27:9029:4657 with SMTP id
 a20-20020a170906685400b00a2790294657mr3946525ejs.125.1704320065698; Wed, 03
 Jan 2024 14:14:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103102553.17a19cea@gandalf.local.home> <CAHk-=whrRobm82kcjwj625bZrdK+vvEo0B5PBzP+hVaBcHUkJA@mail.gmail.com>
 <CAHk-=wjVdGkjDXBbvLn2wbZnqP4UsH46E3gqJ9m7UG6DpX2+WA@mail.gmail.com>
 <20240103145306.51f8a4cd@gandalf.local.home> <CAHk-=wg=tnnsTjnzTs8xRQOBLvw4ceKe7=yxfzNtx4Z9gb-xJw@mail.gmail.com>
 <CAHk-=wh5kkk2+JAv_D1fm8t1SOpTQyb4n7zuMuVSBG094HH7gA@mail.gmail.com> <20240103170556.28df7163@gandalf.local.home>
In-Reply-To: <20240103170556.28df7163@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Jan 2024 14:14:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiWbqy-hd-Xo6dwx=6dH+gMyvf_wFtih7eEpBkHyigzJA@mail.gmail.com>
Message-ID: <CAHk-=wiWbqy-hd-Xo6dwx=6dH+gMyvf_wFtih7eEpBkHyigzJA@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Stop using dcache_readdir() for getdents()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jan 2024 at 14:04, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I actually have something almost working too. Here's the WIP. It only works
> for tracefs, and now eventfs needs to be updated as the "events" directory
> no longer has the right ownership. So I need a way to link the eventfs
> entries to use the tracefs default conditionally.

Ack. So the ->getattr() and ->permission() thing is a bit more
targeted to "look at modes", and is probably better just for that
reason.

Doing it in d_revalidate() is a bit hacky, and impacts path lookup a
bit even when not necessary. But it's still a lot less evil than
walking the dentry tree manually.

So that d_revalidate() patch was more of a "I think you can make it
smaller by just hooking in at this layer"). So d_revalidate ends up
with a smaller patch, I think, but it has the problem that now you
*have* to be able to deal with things in RCU context.

In contrast, doing it in ->getattr() and ->permission() ends up
meaning you can use sleeping locks etc if you need to serialize, for
example. So it's a bit more specific to the whole issue of "deal with
modes and owndership", but it is *also* a bit more flexible in how you
can then do it.

Anyway, your patch looks fine from a quick scan.

                  Linus

