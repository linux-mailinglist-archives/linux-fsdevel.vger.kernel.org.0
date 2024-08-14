Return-Path: <linux-fsdevel+bounces-25865-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E394D951286
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 04:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FD45283C6C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 02:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD55286A2;
	Wed, 14 Aug 2024 02:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z56zElc8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A72A156CE;
	Wed, 14 Aug 2024 02:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723602900; cv=none; b=Ry1B+S4W4A5B7Kh8DNpAJWD4m2Yhc42KeZOYKh+8qN0h2HJ1NRNQrY87QUnhwBaWIkUu00ds3mf0qO6P4awm6m1+TZm/7oDx2nzlhMcYKiJw+8Zda+NVMrsZBfcydJ2mJIJFDvbMpBVdLILTHkHKVMVVxRGO6ZtBKI0w96S65Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723602900; c=relaxed/simple;
	bh=gulgz5rKPIgrCppnzyz5c+/APUjS7s9WOQeVGOEKdkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pYUWlMcVIrI7dNZx0d2Oymsq3C6Qnci748epvLqWLcoze6OnzG/egOiUtzwutBw0+jywCf71NqyiceZ0t3lA3nnx+pWxFamnBVGNaQQBtr4YaZPSVuXX6Lq2GLuStw3fe+NX+OBC3h1ej1suF5i7zzKo7SxskCJyGoqCTKZCzB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z56zElc8; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6bb96ef0e8eso32734916d6.2;
        Tue, 13 Aug 2024 19:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723602897; x=1724207697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gulgz5rKPIgrCppnzyz5c+/APUjS7s9WOQeVGOEKdkQ=;
        b=Z56zElc8D5kAO0p6JXNP68wMk4rW8ExrF3yfJ9y7pG1TBPuXaJKeNzM5j8lh/fTeDv
         dq3EemzEwhDU8gejfZLOLVC2y1Sc65CoeT3oinmoEy2+tuuvSdNsN1LXoOQrCYkokHYG
         dq9cL/HWKc1NXOmzBS+Rekgr8WMqZTd/I5SBEhYsk5pZmKqIdH2ZbMN0SpRzDjeqgynH
         j981y9CbGZd/eKAWfO423+Q3ihE2ojKMA2zkCX/aFgGMzu6nQb902UBQ1FfOchGSGIFt
         Qc8uytDwT43gMz8dDR/7c47UbSaUNTvK1VNjFrtV2vKd4IWbDWcZCknMuTQe/LE/qmI+
         irRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723602897; x=1724207697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gulgz5rKPIgrCppnzyz5c+/APUjS7s9WOQeVGOEKdkQ=;
        b=AejIe4KHV9iK8lkCT9Q2IEwmDiGvJnneicTfyAEFVow9vxuYM9jAAMzuflR4FbSDVo
         4BIlLYcDBaX8/MLUTSN9s2ljH0Noe96hPsHMLtxpzzQihha9ZwWH1bm6DgsMBm40dLo/
         Rejfjaz1FVzuq+AVcRCo4mLEe07NDLEFZJxrT5kPz0C8/x9/bF+/Zlz7QDSJHSU4XhT5
         rJHHVT7qipCqLMP3FTXBTtMngQcF6ZATB+gHDIQffHLXW5bqd4IlbSGMhrsPss3o6hsw
         dX26QF0PlGqUZpwpYC25NfKeeIO36RdpcKYAy/5hBXndQI4IOnNVJJvXei2fdQJwFcRY
         0gWA==
X-Forwarded-Encrypted: i=1; AJvYcCXok3ZOPd0gADdUPsyiRDw6GZQ54AbO7gEjjZpB2kEmrdd7SKQyrhyipC/9p2tY90IBn1sMdc2tUGZQtCy+kZ8ach75MTsdsvoCShw9c1ajTWqj8lm++CLIhyG7YJD5Ti622IEhWgo6jjor426L+UQzjquk01fTuaXoTnh2SwGfSZ3alb6bYeywauk6zT3YO3JRwij/Cgx/k0xgcE2BTuMcohV+Y+rlqqUHNDukGwDXCXDhIWN+yAxrCIElU/MO2Pk/TksnwT1U4BOyj/0B/r6G7M14xhVNqL2oKPVmEVa6eQV0Iam8SfeMTdRUI/ouOwMfWG3u7Q==
X-Gm-Message-State: AOJu0YyYfWiuQyeN9qUzn3cigW/BWklo5wUzCOstBN88ppI+qqsD6aHQ
	MLmLABk7aFSSvH/39PdUUxZg8iW5hjP8bgA3hAL7VcE9w3u894o6MwS4bisc6ADQhLTlHrvPRrk
	iwFHs6E4Mg661GG4Sd66h4i0G4ZUKztA3IbFkfWgQ
X-Google-Smtp-Source: AGHT+IFMSVMbk2rFvvLCxVG+t2Kro+kM02PzB20ab6DAgtzjWvP0nxAeN6FMupoLej6GxB7D7awodMjAvR0yE5dJ7Jc=
X-Received: by 2002:a05:6214:4413:b0:6b7:ab54:3b90 with SMTP id
 6a1803df08f44-6bf5d22db83mr14601296d6.35.1723602897166; Tue, 13 Aug 2024
 19:34:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812022933.69850-1-laoar.shao@gmail.com> <20240812022933.69850-8-laoar.shao@gmail.com>
 <hbjxkyhugi27mbrj5zo2thfdg2gotz6syz6qoeows6l6qwbzkt@c3yb26z4pn62> <CAFhGd8oBmBVooQha7EB+_wenO8TfOjqJsZAzgHLuDUSYmwxy=w@mail.gmail.com>
In-Reply-To: <CAFhGd8oBmBVooQha7EB+_wenO8TfOjqJsZAzgHLuDUSYmwxy=w@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 14 Aug 2024 10:34:21 +0800
Message-ID: <CALOAHbC=DpQROvwxxzqU31L5pOd5tC3+26Q_KuC8PZ7FeU=AAg@mail.gmail.com>
Subject: Re: [PATCH v6 7/9] tracing: Replace strncpy() with strscpy()
To: Justin Stitt <justinstitt@google.com>, ruanjinjie@huawei.com
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org, 
	ebiederm@xmission.com, alexei.starovoitov@gmail.com, rostedt@goodmis.org, 
	catalin.marinas@arm.com, penguin-kernel@i-love.sakura.ne.jp, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 6:31=E2=80=AFAM Justin Stitt <justinstitt@google.co=
m> wrote:
>
> On Tue, Aug 13, 2024 at 3:19=E2=80=AFPM Justin Stitt <justinstitt@google.=
com> wrote:
> >
> > Hi,
> >
> > On Mon, Aug 12, 2024 at 10:29:31AM GMT, Yafang Shao wrote:
> > > Using strscpy() to read the task comm ensures that the name is
> > > always NUL-terminated, regardless of the source string. This approach=
 also
> > > facilitates future extensions to the task comm.
> >
> > Thanks for sending patches replacing str{n}cpy's!
> >
> > I believe there's at least two more instances of strncpy in trace.c as
> > well as in trace_events_hist.c (for a grand total of 6 instances in the
> > files you've touched in this specific patch).
> >
> > It'd be great if you could replace those instances in this patch as wel=
l :>)
> >
> > This would help greatly with [1].
> >
>
> I just saw that Jinjie Ruan sent replacements for these strncpy's too
> and tracked down and replaced an instance of strscpy() that was
> present in trace.c but was moved to trace_sched_switch.c during a
> refactor.
>
> They even used the new 2-argument strscpy which is pretty neat.
>
> See their patch here:
> https://lore.kernel.org/all/20240731075058.617588-1-ruanjinjie@huawei.com=
/

+ Jinjie

That sounds good. Since this change can be handled as a separate
patch, I will drop it from the next version and leave it to Jinjie.
Please note that Steven might have a better solution for handling
task->comm in trace events, so it=E2=80=99s probably best to leave any chan=
ges
related to trace events to him [0].

[0] https://lore.kernel.org/all/20240603184016.3374559f@gandalf.local.home/=
#t

--
Regards
Yafang

