Return-Path: <linux-fsdevel+bounces-34275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1809C442C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 18:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A6A528842A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 17:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F76A1AB6E2;
	Mon, 11 Nov 2024 17:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ald7LYst"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B081AB52B;
	Mon, 11 Nov 2024 17:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731347384; cv=none; b=r0qntyUcq0o1lEJe37ZfSB1Lpr9A4WBXFUgs8HylRHqh0q0f/hDbS2RXS/qNCachjleUnHKDI4q/5oDSrii16KTPAQXSOqMrECPke7WDfs+OzYlz//t0ciyFokPYGGz7akWzofgvn0IROmpzmP7Nj/XX/qaLvQewrR53+YSUxYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731347384; c=relaxed/simple;
	bh=3ihcOxH0KPGLgY5ePe70oCYDX5V0T/3mD31vPks9usk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FJsAUO1efrVQhapWsTfZUCbB5E/QKYi8tvWRk6kqdB4JyuYC3Y/hFiLprTsYNKRFM2CdO/g0ynDMd+mMQqgRoS/IEAV1bIOEJcTbg6E2sZNR7qo3sYvaJgRvKt7yCS0o5qWxFR5XdodaQ6zjxdsQNBUB2n+jPClFiu3ktK4io1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ald7LYst; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-720b2d8bcd3so3781863b3a.2;
        Mon, 11 Nov 2024 09:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731347383; x=1731952183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zll8ldXQZW9waQ7dwCuyoXvWN+LSXFNQJtpkHY+2pVo=;
        b=Ald7LYstXlbw+3X/qvqulZrAO32cP8NhudWGHWX3JbdsUVkBy4mdcFcX0HaF1OcJ8K
         kMemn2m0MwyCjrZc/1exEmgfnHnTVIuCXQfrIH2QfgHOcNcVciXxux8ThWKL122yku0l
         IEUtTHQ4VD3R03xGBaI1thQ5/fJhTm0GW92Gng4wkzFC1bbTfqCG48PiQSIbge/zPHLS
         gyq3Dec8KT3WYE6cnrcOHjtSeXbdSwEz9zGRnGBGMBVaCaNtVVTvvCJB7um3tdkoV5hN
         rz+qQdO5NGEBfKBNaKjvfSGL4TjbdsTgvTaZ2yEADdKiP5QEWFF1fXyLxqlApDYS5oJN
         0bYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731347383; x=1731952183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zll8ldXQZW9waQ7dwCuyoXvWN+LSXFNQJtpkHY+2pVo=;
        b=pb2FoXr95Oz+ClPyXiJ9YWLYoNPVD1vqiDa0c8FV7TmOrOqF9pzw9EM1hRDoWkwmLa
         bFyapSUL5gteEHZ11m7/zgoIVQn1AJ751oCZ+mlDtjdxPCaOolPryC+TQ4th54G+SZRV
         mEffPdhTE8bTtFRyU/LsEmZSoRUDt2Crnq1SPbMqbe/ytWPRy7wRlULJVgv8a3OcuG2v
         0zXT07JMoJDlvHWd3GDHqmAGp4FXSgMsaBmUWzUQWyXQV2TUZcRDC5jG9OEY/9o01KSc
         OtRXFaSg5Y8dNXuW517CmCTBGsuxBC25e/1OSRChUfgWXnwLM1qvsjPRSZm/UILyklFv
         ZhAA==
X-Forwarded-Encrypted: i=1; AJvYcCUQH8nsGuTrQyrHU+foctJTWKDewpZGjm1U5uPjSxrd5dR7mtq9X+PHvVi2RgKpsr1Cc+I=@vger.kernel.org, AJvYcCW9ssOcc53mSuMK5l2vXstrtvl1kBgaOJT6EtyXlOiXlD0PPpaY3N00AGxxeWiEiH0f/5Qhf55vngda/06Nyg==@vger.kernel.org
X-Gm-Message-State: AOJu0YywO1JztXEmNJqBKNqU0nQcbDNkFcLJy4Rbb5ehYXCp3rCvji1U
	h6aRldbxC/1JuzHBSYqIo4kgXFZAVDnUI5d3+sOqRrwn6V2kTF9tARXVJ7HlIpGF3U8CWpFO1NQ
	3ukNKC/YY3N5+xTbbeV9c5MBf4Pw=
X-Google-Smtp-Source: AGHT+IFjhI+Su5HVqTQd1FHPmPjFyvtaz/5qqN+MvZdcq6vQBsNi62OM4QBT4nvmT7Qylj7UBUb/FAFCyEqpgXTwF4A=
X-Received: by 2002:a17:903:244c:b0:20d:345a:9641 with SMTP id
 d9443c01a7336-21183d63de0mr186227605ad.27.1731347382653; Mon, 11 Nov 2024
 09:49:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829174232.3133883-1-andrii@kernel.org> <20240829174232.3133883-10-andrii@kernel.org>
 <20241111055146.GA1458936@google.com>
In-Reply-To: <20241111055146.GA1458936@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 11 Nov 2024 09:49:30 -0800
Message-ID: <CAEf4BzZz_L5yc8OE21x93zb2RU+bujNsyQJTmvOvpm3Y--Uwpw@mail.gmail.com>
Subject: Re: [PATCH v7 bpf-next 09/10] bpf: wire up sleepable bpf_get_stack()
 and bpf_get_task_stack() helpers
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-mm@kvack.org, 
	akpm@linux-foundation.org, adobriyan@gmail.com, shakeel.butt@linux.dev, 
	hannes@cmpxchg.org, ak@linux.intel.com, osandov@osandov.com, song@kernel.org, 
	jannh@google.com, linux-fsdevel@vger.kernel.org, willy@infradead.org, 
	Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 10, 2024 at 9:51=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> Hi,
>
> On (24/08/29 10:42), Andrii Nakryiko wrote:
> > Now that build ID related internals in kernel/bpf/stackmap.c can be use=
d
> > both in sleepable and non-sleepable contexts, we need to add additional
> > rcu_read_lock()/rcu_read_unlock() protection around fetching
> > perf_callchain_entry, but with the refactoring in previous commit it's
> > now pretty straightforward. We make sure to do rcu_read_unlock (in
> > sleepable mode only) right before stack_map_get_build_id_offset() call
> > which can sleep. By that time we don't have any more use of
> > perf_callchain_entry.
>
> Shouldn't this be backported to stable kernels?  It seems that those stil=
l
> do suspicious-RCU deference:
>
> __bpf_get_stack()
>   get_perf_callchain()
>     perf_callchain_user()
>       perf_get_guest_cbs()

Do you see this issue in practice or have some repro?
__bpf_get_stack() shouldn't be callable from sleepable BPF programs
until my patch set, so I don't think there is anything to be
backported. But maybe I'm missing something, which is why I'm asking
whether this is a conclusion drawn from source code analysis, or there
was actually a report somewhere.

