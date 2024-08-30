Return-Path: <linux-fsdevel+bounces-27997-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A66965C80
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 11:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1630D1C2371C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 09:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865A1170849;
	Fri, 30 Aug 2024 09:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdHjZUX+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3721649C6;
	Fri, 30 Aug 2024 09:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725009308; cv=none; b=Mw3eRViZWNzQQr9eC4sTY1u3h6eQqYqJyjCeS5Eht8oLOlEXGQFwDJvIxBu3UYihnhIQv8NjSCsZYC+L/yIhYQIu/yQuKFBI7nscmrTyzL3TtQA1I2WsojqPbRpJ4C463uHh+1YCw2rYu19aam7UpBzH6JQ0yAsq1pfZdBsUvps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725009308; c=relaxed/simple;
	bh=e7MDYm2G5kiu3Jy622lzL6g9yh8iKw8UGxxsmI61Kyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KjvrnCbQ4yMZ95pHpAR6F12x0GH6OcxrEXvyXJZdGfUUEmKsJULQmLPfj+egIihfDRIXbGxb/EOmPdepSWLoihVsr6Y4ybkAYj1t/gTanVqcIWim5Jekg903G7h80pWNC1O1g6PvvDjkbWEQgv3Xxi1MsgZSTp9BNcYoeZaVFzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OdHjZUX+; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6bf9ac165d3so8955546d6.0;
        Fri, 30 Aug 2024 02:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725009305; x=1725614105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YMYjxf06/xzrVFnQjfFIBLlkRu6WKAwRmwgAflzV1Nk=;
        b=OdHjZUX+iYnZPF8s0LxpiSsAifLfMqldpWtXiXXgL0eFI69D9wr33+p3VRswgg0KbD
         WR1QDLYH7BVPRRr6UyCnjs8LxefFMPxXJpReyOIVav4DgXHPIFu29WaKwpnTTvb7zLkM
         ml08PWDtLIzTQNg+yDkzePJA2IOPZsvsSOh2rqjvMPp6F40Yp9OJ1EHj/9amuCp0E3Ii
         cuIBg8iEHZZ8t4XiMo77VOl4Eoc6G7MxhaGqCCUDZH56XinZDDE5IQ/apU3vBHrKC7cV
         WyMaCzeoxcxCM/u/zMHypxq4ebQjVN8895iahFh+TE9WWHZD8XnWko5otHuIOW15YDYg
         W2Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725009305; x=1725614105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YMYjxf06/xzrVFnQjfFIBLlkRu6WKAwRmwgAflzV1Nk=;
        b=IXnYwBn5sc/gOZFg7HzRjO8Z2Ql37PogoipFWDAa4kuXzsE+GrgFw6HIj+TGrCBi7I
         T+5AtpKyUzzFGiZSvOIHxmRRof4Xeg8KfbzlTZNL+axpj7D8TDMQXbAyy3qZKXmiykC1
         n+uNH+O87UyDJoKdvx+Txc8H+PEFvtQBvx+LpNIYYRlt+NAVX0NyRgqSOQJUlJz7/dRQ
         LvoiQi+vZqu/jRhD5LrEjyX9EwvKc9UgJTZIXoWE3yMUepSPZgHXplNYPVN/6ECU7EQI
         k1EeZpQAu3Mrq836eP1GJYlWKAIzZgyhC5PZWmm8pcikWYtyfR4XHlP9Nj1BI3fOfUMl
         zruw==
X-Forwarded-Encrypted: i=1; AJvYcCWN0MPX+uN7cEi+w6cQTMkGQDD86h/CtLGK+bT01WpdLmR5mqMtVKybpbzjGsxfY2IIUXz37GAPYCj2xuPe@vger.kernel.org, AJvYcCXqk0EhwI5qG22y6E2Ogp/wK2mLYEVvWhc8EjiYDvkLaM3jBvopaCv0nE0ERfjUfB7oagGeoXvEWh9aoB8X@vger.kernel.org
X-Gm-Message-State: AOJu0YzkqpUGPXzKccu/zBzyO6vIdQbzunqnnJ8nYhR5Gxev/6YrSdAs
	R6LIO2se33sdkc4aaLVIAoRGZ03+7ASu9E1C87ajDis4+GYvDLp8xLdrWwullsKZMEsar8i3pSJ
	vSF/0ghsjfAUT0zTG/b6gZ9+h08w=
X-Google-Smtp-Source: AGHT+IHPz7RwNRoySa4cVAgVqyXEx7uUIhjwxzkc5uRcUJ/q8SAC8Z4h+mjIUB24TBnUS1LnBmmacRsc+acMxQH2sD0=
X-Received: by 2002:a05:6214:4408:b0:6b5:936d:e5e9 with SMTP id
 6a1803df08f44-6c33e6254eemr63713016d6.26.1725009305147; Fri, 30 Aug 2024
 02:15:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828140638.3204253-1-kent.overstreet@linux.dev>
 <Zs9xC3OJPbkMy25C@casper.infradead.org> <gutyvxwembnzaoo43dzvmnpnbmj6pzmypx5kcyor3oeomgzkva@6colowp7crgk>
 <Zs959Pa5H5WeY5_i@tiehlicka> <xxs3s22qmlzby3ligct7x5a3fbzzjfdqqt7unmpih64dk3kdyx@vml4m27gpujw>
 <ZtBWxWunhXTh0bhS@tiehlicka> <wjfubyrzk4ovtuae5uht7uhhigkrym2anmo5w5vp7xgq3zss76@s2uy3qindie4>
 <ZtCFP5w6yv/aykui@dread.disaster.area>
In-Reply-To: <ZtCFP5w6yv/aykui@dread.disaster.area>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 30 Aug 2024 17:14:28 +0800
Message-ID: <CALOAHbCssCSb7zF6VoKugFjAQcMACmOTtSCzd7n8oGfXdsxNsg@mail.gmail.com>
Subject: Re: [PATCH] bcachefs: Switch to memalloc_flags_do() for vmalloc allocations
To: Dave Chinner <david@fromorbit.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Michal Hocko <mhocko@suse.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 10:29=E2=80=AFPM Dave Chinner <david@fromorbit.com>=
 wrote:
>
> On Thu, Aug 29, 2024 at 07:55:08AM -0400, Kent Overstreet wrote:
> > Ergo, if you're not absolutely sure that a GFP_NOFAIL use is safe
> > according to call path and allocation size, you still need to be
> > checking for failure - in the same way that you shouldn't be using
> > BUG_ON() if you cannot prove that the condition won't occur in real wol=
d
> > usage.
>
> We've been using __GFP_NOFAIL semantics in XFS heavily for 30 years
> now. This was the default Irix kernel allocator behaviour (it had a
> forwards progress guarantee and would never fail allocation unless
> told it could do so). We've been using the same "guaranteed not to
> fail" semantics on Linux since the original port started 25 years
> ago via open-coded loops.
>
> IOWs, __GFP_NOFAIL semantics have been production tested for a
> couple of decades on Linux via XFS, and nobody here can argue that
> XFS is unreliable or crashes in low memory scenarios. __GFP_NOFAIL
> as it is used by XFS is reliable and lives up to the "will not fail"
> guarantee that it is supposed to have.
>
> Fundamentally, __GFP_NOFAIL came about to replace the callers doing
>
>         do {
>                 p =3D kmalloc(size);
>         while (!p);
>
> so that they blocked until memory allocation succeeded. The call
> sites do not check for failure, because -failure never occurs-.
>
> The MM devs want to have visibility of these allocations - they may
> not like them, but having __GFP_NOFAIL means it's trivial to audit
> all the allocations that use these semantics.  IOWs, __GFP_NOFAIL
> was created with an explicit guarantee that it -will not fail- for
> normal allocation contexts so it could replace all the open-coded
> will-not-fail allocation loops..
>
> Given this guarantee, we recently removed these historic allocation
> wrapper loops from XFS, and replaced them with __GFP_NOFAIL at the
> allocation call sites. There's nearly a hundred memory allocation
> locations in XFS that are tagged with __GFP_NOFAIL.
>
> If we're now going to have the "will not fail" guarantee taken away
> from __GFP_NOFAIL, then we cannot use __GFP_NOFAIL in XFS. Nor can
> it be used anywhere else that a "will not fail" guarantee it
> required.
>
> Put simply: __GFP_NOFAIL will be rendered completely useless if it
> can fail due to external scoped memory allocation contexts.  This
> will force us to revert all __GFP_NOFAIL allocations back to
> open-coded will-not-fail loops.
>
> This is not a step forwards for anyone.

Hello Dave,

I've noticed that XFS has increasingly replaced kmem_alloc() with
__GFP_NOFAIL. For example, in kernel 4.19.y, there are 0 instances of
__GFP_NOFAIL under fs/xfs, but in kernel 6.1.y, there are 41
occurrences. In kmem_alloc(), there's an explicit
memalloc_retry_wait() to throttle the allocator under heavy memory
pressure, which aligns with your filesystem design. However, using
__GFP_NOFAIL removes this throttling mechanism, potentially causing
issues when the system is under heavy memory load. I'm concerned that
this shift might not be a beneficial trend.

We have been using XFS for our big data servers for years, and it has
consistently performed well with older kernels like 4.19.y. However,
after upgrading all our servers from 4.19.y to 6.1.y over the past two
years, we have frequently encountered livelock issues caused by memory
exhaustion. To mitigate this, we've had to limit the RSS of
applications, which isn't an ideal solution and represents a worrying
trend.

--=20
Regards
Yafang

