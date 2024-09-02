Return-Path: <linux-fsdevel+bounces-28218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C0D9682A0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 11:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15E2628525F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 09:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890EB187357;
	Mon,  2 Sep 2024 09:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8O4zswC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810501547D2;
	Mon,  2 Sep 2024 09:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725267714; cv=none; b=O9jkr7X+zdoMSaIs5PdNl+mLnVC7vcFPLi8U4iz4FNGigoLcIUQc8x1ZMcjT9V3XvUgIpzo9kOaPomJpzyyLizDnm+WxhPdk2gkYMyDzu/IgOX4j2q31uzTuys3ZnMwNHlVEsWB4xE6/dVLvSAe9FYkSVFoLRY0hBZKtTPOB0mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725267714; c=relaxed/simple;
	bh=8w+z23lksUm6jWm8m7lWHXd7Naju1kJtluu4cziMBP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q8M9vSwsK+u/TRgFnVQSTbD7tDIOqAWLufMrIiNKqsyzkBzM0u+il0u5OPVCb2CpaXzv/sDFFhEc8SwMvert1qmGM/JdRr3MLtAE/8OqWSHOvWBI4rUDz0+qZp9Fol0alLKdnwnyf4rR2GWdfXdeIxu8o7jgJy1WBNX2gw4xja0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8O4zswC; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6c3551ce5c9so16723416d6.0;
        Mon, 02 Sep 2024 02:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725267711; x=1725872511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynRjrJnf/caknOdrqHKVGwTxMwIA5RzjX7iPoNekIHI=;
        b=X8O4zswC+WC//eDf6yiRinXEvKRODrtsZ328zVQyJc2QqC4Rdp53TuPvEH8MXXzu2y
         YYniUQhSj1k5oJxX9h55WXFPGOkvUYOLNkli7UpcRKYTRvLqvfxi/nSIsEvBQGQ2/3YZ
         ZM62CCd8IqAyqeoY9ESNNk/G6IyJhy9UsiFoeDaOZT5ZUlHCw3N1180qGTMlVRGEOEAb
         ZVJkAuX6dbN1W+ILYIP2BHw4r95zQOU8KU45EE/zLSzDLRc3C9qQ1NwcLbl53vrBYoWM
         q2blGPso6y8g4aj11VAVj84F7vdfe/pDry6dBajrLnfs84kCC5XqhAJuhze/0deQhHYX
         FW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725267711; x=1725872511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ynRjrJnf/caknOdrqHKVGwTxMwIA5RzjX7iPoNekIHI=;
        b=oIY1oTdQzxd+sITeKTW+oy4FPdfSG1Du8wcBYMGHW/+xmIZ9ygA2u7EJBx5LDrvrj2
         R6/7TS1dQ8sPqtR6ntgWvO3t99M5qq1ed19z7jux1Q+Kf7p5d7BiP2AzKQxLvHN38tzZ
         G4/0CTG8RcCbWY3V2A0dXWk/oUP68zHD5+ig9Gm9VHKhpGVzbShO/xcxf3y+if2H/zMi
         6K4jkINN8lCVWmFF40t/R6h1fUqJ785bKMKta3PRLhwVBcaPDm9RWxG5qa/KSnyAzExD
         tGiKMgG9dmHVG1L8RQS6qXROZBL/HxyqXcxk8cGolEHiXS7+kTJjyAHm6L2MSU012i7G
         YkbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZTOjqxV1F8hotD6IyOUAUQnEzuutbSGsz/0YspdThhXb9vaWLzPi09+MwwAOIh8eQ+ZNbPInUQROuuDSf@vger.kernel.org, AJvYcCX47IUF2ajFnl7KtQo1a7BZL9NPMpixkc6FXyH2wAPKTmM1+7XEmDcndNBfewVbeFpgcnk6+X7/TEoLoaXy@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7mie+/8WIy8tnmqN/CMuDsCqGRPH2dob8K8h3gHd+1FQzfi61
	PPkytz4Q9F9pWvuGtJR/eHZqELzNnmCABGrKjCPCcjJ9X52DYu3zV/xEpa1b3dxe5SVCLMzV6GZ
	18ELU5cLvpESZ14V3tFAmW5cV9YM=
X-Google-Smtp-Source: AGHT+IELCIzq8aGAuBTY7sWBevW03eMyKRara0e3UrDynu2DH3Tlc7UV5ru2SiwfFawaiuHtoGIA7wlXcThU81HRLSI=
X-Received: by 2002:a05:6214:f69:b0:6b5:2062:dd5c with SMTP id
 6a1803df08f44-6c33f33be5fmr290491226d6.8.1725267711323; Mon, 02 Sep 2024
 02:01:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zs9xC3OJPbkMy25C@casper.infradead.org> <gutyvxwembnzaoo43dzvmnpnbmj6pzmypx5kcyor3oeomgzkva@6colowp7crgk>
 <Zs959Pa5H5WeY5_i@tiehlicka> <xxs3s22qmlzby3ligct7x5a3fbzzjfdqqt7unmpih64dk3kdyx@vml4m27gpujw>
 <ZtBWxWunhXTh0bhS@tiehlicka> <wjfubyrzk4ovtuae5uht7uhhigkrym2anmo5w5vp7xgq3zss76@s2uy3qindie4>
 <ZtCFP5w6yv/aykui@dread.disaster.area> <CALOAHbCssCSb7zF6VoKugFjAQcMACmOTtSCzd7n8oGfXdsxNsg@mail.gmail.com>
 <ZtPhAdqZgq6s4zmk@dread.disaster.area> <CALOAHbBEF=i7e+Zet-L3vEyQRcwmOn7b6vmut0-ae8_DQipOAw@mail.gmail.com>
 <ZtVzP2wfQoJrBXjF@tiehlicka>
In-Reply-To: <ZtVzP2wfQoJrBXjF@tiehlicka>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 2 Sep 2024 17:01:12 +0800
Message-ID: <CALOAHbAbzJL31jeGfXnbXmbXMpPv-Ak3o3t0tusjs-N-NHisiQ@mail.gmail.com>
Subject: Re: [PATCH] bcachefs: Switch to memalloc_flags_do() for vmalloc allocations
To: Michal Hocko <mhocko@suse.com>
Cc: Dave Chinner <david@fromorbit.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 4:11=E2=80=AFPM Michal Hocko <mhocko@suse.com> wrote=
:
>
> On Mon 02-09-24 11:02:50, Yafang Shao wrote:
> > On Sun, Sep 1, 2024 at 11:35=E2=80=AFAM Dave Chinner <david@fromorbit.c=
om> wrote:
> [...]
> > > AIUI, the memory allocation looping has back-offs already built in
> > > to it when memory reserves are exhausted and/or reclaim is
> > > congested.
> > >
> > > e.g:
> > >
> > > get_page_from_freelist()
> > >   (zone below watermark)
> > >   node_reclaim()
> > >     __node_reclaim()
> > >       shrink_node()
> > >         reclaim_throttle()
> >
> > It applies to all kinds of allocations.
> >
> > >
> > > And the call to recalim_throttle() will do the equivalent of
> > > memalloc_retry_wait() (a 2ms sleep).
> >
> > I'm wondering if we should take special action for __GFP_NOFAIL, as
> > currently, it only results in an endless loop with no intervention.
>
> If the memory allocator/reclaim is trashing on couple of remaining pages
> that are easy to drop and reallocated again then the same endless loop
> is de-facto the behavior for _all_ non-costly allocations. All of them
> will loop. This is not really great but so far we haven't really
> developed a reliable thrashing detection that would suit all potential
> workloads. There are some that simply benefit from work not being lost
> even if the cost is a severe performance penalty. A general conclusion
> has been that workloads which would rather see OOM killer triggering
> early should implement that policy in the userspace. We have PSI,
> refault counters and other tools that could be used to detect
> pathological patterns and trigger workload specific action.

Indeed, we're currently working on developing that policy.

>
> I really do not see why GFP_NOFAIL should be any special in this
> specific case.

I believe there's no way to stop it from looping, even if you
implement a sophisticated user space OOM killer. ;)

--
Regards
Yafang

