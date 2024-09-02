Return-Path: <linux-fsdevel+bounces-28196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A1B967E0B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 05:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D39A9281B8A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 03:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B143A8CB;
	Mon,  2 Sep 2024 03:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IB1TYKzl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BB779C0;
	Mon,  2 Sep 2024 03:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725246208; cv=none; b=fcPWa1t2DMEe0+0eBpJc81cFw3yGmiP1hC6HnY2nGBGDa6cqgRdZjn9bTwlKMXXfvYTpG2bxHLjLeZWrWVLY+E4GtE3RIc1tX8qSL1rtV4Ho2DNsRiRWiWVc2keQjpmEjZwQ6+Pq9/UnH0xLo8x3hxPzPqIdURJShgSaGFrzAMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725246208; c=relaxed/simple;
	bh=FD5QgdU1llmtdefhiBbMEIfOQBm1h7zqqXMxz0ZmR/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZToB/GSOwfZ28SfZ4npbTnWy8jrMMeDjixto3l1gpUFnyeGG0yZg/5aUdXaVSJD/AOSIz52PhjqoCjE+hbeG7L/b3mkgozWi+5r1TbotFXexbR7nfXTLKzCudzJaMO4pFPwOZ2MAB7BNM80xPu7Oj/0HY9rhQpU54IKpRKUEecA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IB1TYKzl; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-456774a0fe7so20936731cf.0;
        Sun, 01 Sep 2024 20:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725246205; x=1725851005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LZxvKASLeQPhlUeFrFQCFSS8riyVWdaWYAqCbhxuJ7E=;
        b=IB1TYKzlH9sImKgOSZYRddp4GTCOiaEXLoPrQ9/zwVBVJ7sE4PQY0N7Xh26qinXuC0
         7IxH94OJh0KdRJ5HlSmp1eE8EfgVwRkPs/noZFZObdIvcBqp2cRTNUpUDJnM9NjW5Pt2
         Y2SvcRXUJODoy1scdLYv79uQJQ+a8cDWAcf42CiaemCROqEGQczy2j/AfyEpb6fZaCg+
         wcMRb5biDMOdG+X/GQJi0rUOcQ58WMrYshrPj/J6WPcHeinGDHUcsZgY+QEesp76Hrql
         gQN4992Cpm/sur82ADvRGicvi7CSwv+h2oanimtO5EbqzumPjBZYggzOP1F6pT3tlfW4
         BqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725246205; x=1725851005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LZxvKASLeQPhlUeFrFQCFSS8riyVWdaWYAqCbhxuJ7E=;
        b=DgmTeCQeIISBFWAPBKmJHM4ptkaST8TsPRgXF0UvgFkoweYu/9LHfxkDDiJ2b52NpW
         ZwQMj+v6BdaxLGrg3AJ8q6/YoQQnotG3I94HCtFijK92Khgw70bGuQ6mAAzZDB3E2LM/
         D1965SaMeajsjAu/ILSMDSrHNlVbHq4nBCCfZg5D9FX2pkwNfmPHY7vUCo1/AW7DfyDF
         +rV6QSALCnZaRuh9nN3EhEeJV911ZRS3ggzcOaSpyNolyfnWPsW7XNX1RB50QIfUKL1R
         soHLGPGpU5mBiQ1IUiKt6mWMh2IOLg6KZZq/LGculnEv2VbvJVbNhVm55p68i6xcN2Y6
         xXVA==
X-Forwarded-Encrypted: i=1; AJvYcCUAmK7wP22U5+dd4DsW7pcWz9MTXuHd1yLIKzZ7wrP+fpLm4G8HcRbNpmF4Pu5oG6DeXgekddyb/Cn0ob36@vger.kernel.org, AJvYcCWxbXtO1R4qMn7b7eyFJg8xbVyEzX7jcSTfk7JdQSU3nT27SlV/p/XA0oe7avOTnhlx3cCkfHR064MP/m+t@vger.kernel.org
X-Gm-Message-State: AOJu0YynH/+hX9Ef0SqppkC43nPBTtifo6t2f9tZUsEqHG7x3PrtCJ3/
	I2ATnE5tOAaV396wPbrlBwp+AwZsyuN99qDGbqAucrQWfbcPdL4/54YHvEc/nyETCg86L/HwiKC
	MDlisSwPyHJy3ovzfs8QFhUImfkc=
X-Google-Smtp-Source: AGHT+IGQT0cG/HgGQSVHmz2EXEuhrSnKMDbqLSUVFa8dO6+VBSLmM6ZI7QgskC6mcN/cUUG56353wFfp/xkzaJSVjf4=
X-Received: by 2002:a05:6214:468e:b0:6c3:5a86:6a2e with SMTP id
 6a1803df08f44-6c35a867552mr66716106d6.50.1725246205287; Sun, 01 Sep 2024
 20:03:25 -0700 (PDT)
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
 <ZtCFP5w6yv/aykui@dread.disaster.area> <CALOAHbCssCSb7zF6VoKugFjAQcMACmOTtSCzd7n8oGfXdsxNsg@mail.gmail.com>
 <ZtPhAdqZgq6s4zmk@dread.disaster.area>
In-Reply-To: <ZtPhAdqZgq6s4zmk@dread.disaster.area>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 2 Sep 2024 11:02:50 +0800
Message-ID: <CALOAHbBEF=i7e+Zet-L3vEyQRcwmOn7b6vmut0-ae8_DQipOAw@mail.gmail.com>
Subject: Re: [PATCH] bcachefs: Switch to memalloc_flags_do() for vmalloc allocations
To: Dave Chinner <david@fromorbit.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Michal Hocko <mhocko@suse.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 1, 2024 at 11:35=E2=80=AFAM Dave Chinner <david@fromorbit.com> =
wrote:
>
> On Fri, Aug 30, 2024 at 05:14:28PM +0800, Yafang Shao wrote:
> > On Thu, Aug 29, 2024 at 10:29=E2=80=AFPM Dave Chinner <david@fromorbit.=
com> wrote:
> > >
> > > On Thu, Aug 29, 2024 at 07:55:08AM -0400, Kent Overstreet wrote:
> > > > Ergo, if you're not absolutely sure that a GFP_NOFAIL use is safe
> > > > according to call path and allocation size, you still need to be
> > > > checking for failure - in the same way that you shouldn't be using
> > > > BUG_ON() if you cannot prove that the condition won't occur in real=
 wold
> > > > usage.
> > >
> > > We've been using __GFP_NOFAIL semantics in XFS heavily for 30 years
> > > now. This was the default Irix kernel allocator behaviour (it had a
> > > forwards progress guarantee and would never fail allocation unless
> > > told it could do so). We've been using the same "guaranteed not to
> > > fail" semantics on Linux since the original port started 25 years
> > > ago via open-coded loops.
> > >
> > > IOWs, __GFP_NOFAIL semantics have been production tested for a
> > > couple of decades on Linux via XFS, and nobody here can argue that
> > > XFS is unreliable or crashes in low memory scenarios. __GFP_NOFAIL
> > > as it is used by XFS is reliable and lives up to the "will not fail"
> > > guarantee that it is supposed to have.
> > >
> > > Fundamentally, __GFP_NOFAIL came about to replace the callers doing
> > >
> > >         do {
> > >                 p =3D kmalloc(size);
> > >         while (!p);
> > >
> > > so that they blocked until memory allocation succeeded. The call
> > > sites do not check for failure, because -failure never occurs-.
> > >
> > > The MM devs want to have visibility of these allocations - they may
> > > not like them, but having __GFP_NOFAIL means it's trivial to audit
> > > all the allocations that use these semantics.  IOWs, __GFP_NOFAIL
> > > was created with an explicit guarantee that it -will not fail- for
> > > normal allocation contexts so it could replace all the open-coded
> > > will-not-fail allocation loops..
> > >
> > > Given this guarantee, we recently removed these historic allocation
> > > wrapper loops from XFS, and replaced them with __GFP_NOFAIL at the
> > > allocation call sites. There's nearly a hundred memory allocation
> > > locations in XFS that are tagged with __GFP_NOFAIL.
> > >
> > > If we're now going to have the "will not fail" guarantee taken away
> > > from __GFP_NOFAIL, then we cannot use __GFP_NOFAIL in XFS. Nor can
> > > it be used anywhere else that a "will not fail" guarantee it
> > > required.
> > >
> > > Put simply: __GFP_NOFAIL will be rendered completely useless if it
> > > can fail due to external scoped memory allocation contexts.  This
> > > will force us to revert all __GFP_NOFAIL allocations back to
> > > open-coded will-not-fail loops.
> > >
> > > This is not a step forwards for anyone.
> >
> > Hello Dave,
> >
> > I've noticed that XFS has increasingly replaced kmem_alloc() with
> > __GFP_NOFAIL. For example, in kernel 4.19.y, there are 0 instances of
> > __GFP_NOFAIL under fs/xfs, but in kernel 6.1.y, there are 41
> > occurrences. In kmem_alloc(), there's an explicit
> > memalloc_retry_wait() to throttle the allocator under heavy memory
> > pressure, which aligns with your filesystem design. However, using
> > __GFP_NOFAIL removes this throttling mechanism, potentially causing
> > issues when the system is under heavy memory load. I'm concerned that
> > this shift might not be a beneficial trend.
>
> AIUI, the memory allocation looping has back-offs already built in
> to it when memory reserves are exhausted and/or reclaim is
> congested.
>
> e.g:
>
> get_page_from_freelist()
>   (zone below watermark)
>   node_reclaim()
>     __node_reclaim()
>       shrink_node()
>         reclaim_throttle()

It applies to all kinds of allocations.

>
> And the call to recalim_throttle() will do the equivalent of
> memalloc_retry_wait() (a 2ms sleep).

I'm wondering if we should take special action for __GFP_NOFAIL, as
currently, it only results in an endless loop with no intervention.

>
> > We have been using XFS for our big data servers for years, and it has
> > consistently performed well with older kernels like 4.19.y. However,
> > after upgrading all our servers from 4.19.y to 6.1.y over the past two
> > years, we have frequently encountered livelock issues caused by memory
> > exhaustion. To mitigate this, we've had to limit the RSS of
> > applications, which isn't an ideal solution and represents a worrying
> > trend.
>
> If userspace uses all of memory all the time, then the best the
> kernel can do is slowly limp along. Preventing userspace from
> overcommitting memory to the point of OOM is the only way to avoid
> these "userspace space wants more memory than the machine physically
> has" sorts of issues. i.e. this is not a problem that the kernel
> code can solve short of randomly killing userspace applications...

We expect an OOM event, but it never occurs, which is a problem.

--
Regards

Yafang

