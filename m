Return-Path: <linux-fsdevel+bounces-8465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF01836F6B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 19:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D9671C26C00
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 18:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69C341758;
	Mon, 22 Jan 2024 17:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hlZOqYuK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F6667A0B
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jan 2024 17:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705945159; cv=none; b=RmGyBPsAmjuh5dRYcrgtFvRht17Um94x42AbNYpniKD+E8U+ndLL8Bs+vgZ3NNDrcl5ZkLow2/nJWNnzq+rI/RsW3Us+fw47x9/qwMhMmpcAeVRys0iKFeXNFTeyiC4drbfqXsF4b8BaFAVCw8K+L5UNxLbeSj8jakTX9RB1NPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705945159; c=relaxed/simple;
	bh=pVhRcHSJ3aXTlxyGVJozi5V8ZRcCGz5qGw25a4dRsOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HDHjLrgmhRj+69mL9iXH0b2CgtEk7qoL6pEAaydaafFv2ZEOU8hUtsQUSFixiTnVrmCDC2EU02JxFZTpltQiBezpGuDNXHMWYABD0lgunHGdFPvDYdOgKskeefEKLujz2Og9MxM/nLkNTZFf8PPtYvdpi0LNKnkivjstOONmtaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hlZOqYuK; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-361a829e012so301345ab.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jan 2024 09:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705945157; x=1706549957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFL/pJ8lBcoZD5EX7oUKXSpQaXjWBIZbPdd+OtvuQEs=;
        b=hlZOqYuKwHrobJcOUWuYFau/C+5vtbFC5GfohP13sXFPD6oxhJP6OgKULxWFFvW5vh
         K5fUtqiz1bbOZVXc1NGzRy/M33jENnGghzGCoFlog/sVTUek8FrxiOSwY5ZReF5m6c52
         GVo5tD4ltshVHaUmUxIrrDyHg0ONTAq/o+t56oItirpiw7vlCjkrbQwTUPAjpmVBPeL3
         DyrDLLbAq0LPg0+aB5Tq53TdMhxpi/ulVKlri0+L1WRBmgP+FYU/17iRML1TgljZOw2r
         OGDz0BsQGcO3T/FLeMIe7UJ9ckTmL1Z60t43b8HrDzn6HhvA1rH2u9wtAIhOoaApBXDP
         rXbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705945157; x=1706549957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VFL/pJ8lBcoZD5EX7oUKXSpQaXjWBIZbPdd+OtvuQEs=;
        b=sptaEJPVN189DCon17r3/Q6Io9PPNdxAjPxBmHec8Sjjy48aA3m1PdQesJYbTqz8Qc
         8iey/LRK4xs/v3rP63kXoM4ugAwS5ZDTGYv2VRL0ubHAt7CSm36hP3Jqwaln7LLRlq3I
         ftBNwGXxUa8wrJGH0jSGSfegj65iTImWDki5u9tOGz8qFZhhC7fbZIoSOf44PsPTnnVR
         TLtOfchzS5dw+hykW4GIqkPybvgCHzz+ulTXc/Z73TC2rG5pVQpFCsDlDjAi5ZaPy7Vd
         2E9RDyvADcishyEgN5J5vLWU9dmYj66d65itPwwLviSDVeAIm9fi7/tVBZITFtN6W8tn
         MBSA==
X-Gm-Message-State: AOJu0YzgfwS812sZfhOnXtW1I6nlKhl4kCXvh1Ace5h0WfMP/wzqOdiF
	wu5cRyL4n4WOKNN3QDWXtAtqPlTb4E0lvtgMnQyV52sOo7id
X-Google-Smtp-Source: AGHT+IEEEj8QEKx7WALQ/y8chwZxkEBYc5Si3Sg0sBoZD48NB4UP8F+1j2y3WziM2jUCW63ZmvVnFrQq9Y40lYL4jZM=
X-Received: by 2002:a05:6e02:1905:b0:35f:b09b:ccd2 with SMTP id
 w5-20020a056e02190500b0035fb09bccd2mr481453ilu.7.1705945156747; Mon, 22 Jan
 2024 09:39:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119092024.193066-1-zhangpeng362@huawei.com>
 <Zap7t9GOLTM1yqjT@casper.infradead.org> <5106a58e-04da-372a-b836-9d3d0bd2507b@huawei.com>
 <Za6SD48Zf0CXriLm@casper.infradead.org> <CANn89iL4qUXsVDRNGgBOweZbJ6ErWMsH+EpOj-55Lky8JEEhqQ@mail.gmail.com>
 <Za6h-tB7plgKje5r@casper.infradead.org>
In-Reply-To: <Za6h-tB7plgKje5r@casper.infradead.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 22 Jan 2024 18:39:04 +0100
Message-ID: <CANn89iJDNdOpb6L6PkrAcbGcsx6_v4VD0v2XFY77g7tEnJEXXQ@mail.gmail.com>
Subject: Re: SECURITY PROBLEM: Any user can crash the kernel with TCP ZEROCOPY
To: Matthew Wilcox <willy@infradead.org>
Cc: "zhangpeng (AS)" <zhangpeng362@huawei.com>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org, 
	akpm@linux-foundation.org, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, arjunroy@google.com, 
	wangkefeng.wang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 6:12=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Mon, Jan 22, 2024 at 05:30:18PM +0100, Eric Dumazet wrote:
> > On Mon, Jan 22, 2024 at 5:04=E2=80=AFPM Matthew Wilcox <willy@infradead=
.org> wrote:
> > > I'm disappointed to have no reaction from netdev so far.  Let's see i=
f a
> > > more exciting subject line evinces some interest.
> >
> > Hmm, perhaps some of us were enjoying their weekend ?
>
> I am all in favour of people taking time off!  However the report came
> in on Friday at 9am UTC so it had been more than a work day for anyone
> anywhere in the world without response.
>
> > I don't really know what changed recently, all I know is that TCP zero
> > copy is for real network traffic.
> >
> > Real trafic uses order-0 pages, 4K at a time.
> >
> > If can_map_frag() needs to add another safety check, let's add it.
>
> So it's your opinion that people don't actually use sendfile() from
> a local file, and we can make this fail to zerocopy?

Certainly we do not do that at Google.
I am not sure if anybody else would have used this.



 That's good
> because I had a slew of questions about what expectations we had around
> cache coherency between pages mapped this way and write()/mmap() of
> the original file.  If we can just disallow this, we don't need to
> have a discussion about it.
>
> > syzbot is usually quite good at bisections, was a bug origin found ?
>
> I have the impression that Huawei run syzkaller themselves without
> syzbot.  I suspect this bug has been there for a good long time.
> Wonder why nobody's found it before; it doesn't seem complicated for a
> fuzzer to stumble into.

I is strange syzbot (The Google fuzzer) have not found this yet, I
suspect it might be caused
by a recent change somewhere ?

A repro would definitely help, I could start a bisection.

