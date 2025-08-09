Return-Path: <linux-fsdevel+bounces-57181-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB78B1F5FB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Aug 2025 21:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42F3018C0BD1
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Aug 2025 19:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48981299937;
	Sat,  9 Aug 2025 19:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="oVH/H+CV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107451F3B87
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 Aug 2025 19:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754767320; cv=none; b=m+1wpLicSkEKK4rBkDyxsJT+HhORMo7jnjQt46CjBc1kiNqV9yIo7vaDlj3FtjFYzmmjbSFt0wikOWEMBRqwPHWlmtEQzgVn6GDKf7/56i9HXnhZsDJVvTjs1U+30FHzigglGGho/aLhjWUN3g50Mfv2LUdwGHMeaqtzdkNNYrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754767320; c=relaxed/simple;
	bh=h3Apy+if9b+XE+PfNGkz/zZ+g5R4G5lXdu3AvwX0+OA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hvVMvjIUCbjr4inW94WW+ht0qb+zHiceVQ/d7JdyA2o0w6gGYsGPsOtclINTS5tR0Sf+W1LeE0oQSngu478zyv6totID4lF4v7CuuI2LYUEB8qDEMs6usrVfuViksESbLFvK9iclVMNkJAMLCOZuS9UCvYWK3Z3a9tdeb0esc8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=oVH/H+CV; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e902849978bso2466494276.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 09 Aug 2025 12:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1754767318; x=1755372118; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tNI3FzGuqhvpLMUoYQfTha9JCC3Gjeyc60VySTiyNyA=;
        b=oVH/H+CVTP2kIoCtmxAjtuWN4HZ7jsoeSpaohP0Nzg1zwyL8nj80w9wiUpEQauN1Xr
         ncwM+ufHVn4SFWVHkRwhfWqaA+LWqohoIcC2kjcb+7UZBCSJ/0d3XbSieafCjvzGsV7C
         k04JdjPqYFu0+mHaeg/hw2V4T0lKQioIpDm5ZMrWfQEM+RRKC0pGGvAnU4BBaSkQ9F0/
         EwpTonZocP6iPzhPHDNBVpQWAB9cexlUZOQCY+AnnRdzejL5thYskk6kHgt9Ld1pHV7Z
         jZERKc9FXo4YBkrqKfhYZsY6phAb+09r2i45Qbmoyu4lc2+VKXSW9kjh1P/XGhRb78xg
         nf8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754767318; x=1755372118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tNI3FzGuqhvpLMUoYQfTha9JCC3Gjeyc60VySTiyNyA=;
        b=WdMgkFYfxLoN0Ojjndv3o6LcNlL3C5Swlq0iefVmnUNHv8VLbOna8gbx3SBc2iCSq6
         DJLQg6ctykDX0gt+A3IjnBoY6zUvYkAtD8iWb55ztr0VtxQW6iQWLIfImtLvsUpYn5JE
         6qZ2YGenK3iDxJMlf7gB724ABWpWwglHZPoxwkyCk0OdCcV/dGS6jhekr23CDc3kOpzn
         XRKp9GOjA9JzZjQRoUH2vapHq9EtG9KZM3dH6kmyRnFja7O3MX95n1HjrtsPKMxrNZtz
         iGS1VSfRwSwzEgOuVl+bST8/eKtfPb+ahnJZt1ocW3vkdCSVWSsKOwJpQLrwIo6pu/ls
         LCQA==
X-Forwarded-Encrypted: i=1; AJvYcCXxuu1Ooi2ne0P9MQRnZxIYuo767uUmmZhoefFAI3ocr97/OJk8qYXxOjjbe5zoShbhVASjN6SIN3lejRyN@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg/kloPAv1zRP6xU2kuwmAN2zTIyzq0F1HKS6V4xG5m7ZVO5V7
	Ao1/YN7Shb9+eZq/ED5wT2APkSd9ZNRf5eW24/fXcULVVBCHNsg4yt+vsfPawuyzjo8=
X-Gm-Gg: ASbGncvRVaKKjSeojVTTffDVyRbMfbyncaov/xOsEB1hL2geSHdj92dF4EcNoeEqPcX
	NG9lV5uYUWNE6GNQ2OjCAOmxk3vKSUr3dvVk27yz9V58k/fMMC2BnpvND8U516KJ73moVSoXzj0
	Ph0N+ARQK1KygG6Dv1SidBojF2OPjEwyth9+wZMSV+IqEWWPSQrCeGkvDJGA/GsvyYSca9njB/C
	gri0CRJExAG9IiD9YvERjQkMY27hJlfOhR5fnagKSVarhfvFQL5V/cxH/HhyGvanZZsaVl9m2xr
	1lLd4CIPmZ6uNyYIdCOX0Zmn81pgKVL2iSs4ndaIgs+3bbiWOim1u8xEJGtlLO2RqX51lhmbzBl
	LQW8beTNt6uEINZh1Csxr98uckqjeC1hj4UgHs9nfGbb9TDS86U0A4xClz0+N87ZmvsX38A==
X-Google-Smtp-Source: AGHT+IExmujknx2TM2tLuZiauHbhXnPmw1RB7ZvhZsQHYkPr1rGepKt+DAqu5eteErMK86fJg6JejQ==
X-Received: by 2002:a05:6902:4a02:b0:e8b:4282:65d7 with SMTP id 3f1490d57ef6-e904b579e55mr7609585276.25.1754767317816;
        Sat, 09 Aug 2025 12:21:57 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8fd3860a91sm8336114276.23.2025.08.09.12.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 12:21:57 -0700 (PDT)
Date: Sat, 9 Aug 2025 15:21:56 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Aquinas Admin <admin@aquinas.su>,
	Malte =?iso-8859-1?Q?Schr=F6der?= <malte.schroeder@tnxip.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Carl E. Thompson" <list-bcachefs@carlthompson.net>,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs changes for 6.17
Message-ID: <20250809192156.GA1411279@fedora>
References: <22ib5scviwwa7bqeln22w2xm3dlywc4yuactrddhmsntixnghr@wjmmbpxjvipv>
 <f4be82e7-d98c-44d1-a65b-8c4302574fff@tnxip.de>
 <1869778184.298.1754433695609@mail.carlthompson.net>
 <5909824.DvuYhMxLoT@woolf>
 <3ik3h6hfm4v2y3rtpjshk5y4wlm5n366overw2lp72qk5izizw@k6vxp22uwnwa>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ik3h6hfm4v2y3rtpjshk5y4wlm5n366overw2lp72qk5izizw@k6vxp22uwnwa>

On Sat, Aug 09, 2025 at 01:36:39PM -0400, Kent Overstreet wrote:
> On Thu, Aug 07, 2025 at 07:42:38PM +0700, Aquinas Admin wrote:
> > Generally, this drama is more like a kindergarten. I honestly don't understand 
> > why there's such a reaction. It's a management issue, solely a management 
> > issue. The fact is that there are plenty of administrative possibilities to 
> > resolve this situation.
> 
> Yes, this is accurate. I've been getting entirely too many emails from
> Linus about how pissed off everyone is, completely absent of details -
> or anything engineering related, for that matter. Lots of "you need to
> work with us better" - i.e. bend to demands - without being willing to
> put forth an argument that stands to scrutiny.
> 
> This isn't high school, and it's not a popularity contest. This is
> engineering, and it's about engineering standards.
> 

Exactly. Which is why the Meta infrastructure is built completely on btrfs and
its features. We have saved billions of dollars in infrastructure costs with the
features and robustness of btrfs.

Btrfs doesn't need me or anybody else wandering around screaming about how
everybody else sucks to gain users. The proof is in the pudding. If you read
anything that I've wrote in my commentary about other file systems you will find
nothing but praise and respect, because this is hard and we all make our
tradeoffs.

That courtesy has been extended to you in the past, and still extends to your
file system. Because I don't need to tear you down or your work down to make
myself feel good. And because I truly beleive you've done some great things with
bcachefs, things I wish we had had the foresight to do with btrfs.

I'm yet again having to respond to this silly childishness because people on the
outside do not have the context or historical knowledge to understand that they
should ignore every word that comes out of your mouth. If there are articles
written about these claims I want to make sure that they are not unchallenged
and thus viewed as if they are true or valid.

Emails like this are why nobody wants to work with you. Emails like this are why
I've been on literally dozens of email threads, side conversations, chat
threads, and in person discussions about what to do when we have exceedingly
toxic developers in our community.

Emails like this are exactly why we have to have a code of conduct.

Emails like this are why a majority of the community filters your emails to
/dev/null.

You alone with your toxic behavior have wasted a fair amount of mine and other
peoples time trying to figure out how do we exist in our place of work with
somebody who is bent on tearing down the community and the people who work in
it.

I have defended you in the past, I was hoping that the support, guidance, and
grace you've been afforded by so many people in this community would have
resulted in your behavior changing. I'm very sorry I was wrong, and I'm very
sorry if my support in anyway enabled the decision to merge your filesystem.

Because your behavior is unacceptable. This email is unacceptable. Everything
about your presence in this community has been a disruption and has ended up
with all of our jobs being harder.

You are not some paraih. You are not some victim. You are not some misunderstood
genius. Your behavior makes this community a worse place to work in. If you are
removed from this community it will soley be because you lack the ability to
learn and to grow as a person and take responsibility for your behavior.

If you are allowed to continue to be in this community that will be a travesty.

Thanks,

Josef

