Return-Path: <linux-fsdevel+bounces-29688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E3F97C489
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 08:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 310AD2847DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 06:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CC118FC86;
	Thu, 19 Sep 2024 06:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SpEr+eq3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A7C18E36C
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Sep 2024 06:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726729071; cv=none; b=qjRoY9DEVSeGlLg/NI1clkMb1eI5qwdJNZ16GYbHyFKos8wr9A80CeEZ5cUDV12sM4oSSTZ06ns4oXhhrJOqe1r1xw83VkrpqJXVLef8UOh82qK/CLMYaNkkJzgxfqt+OeBG7nOvLc0ZCCn5TFkPiTUfg9PxzQGddD6/GpJSe3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726729071; c=relaxed/simple;
	bh=T42I0lRZBaFB9187EeGtKoTYqZo584h9kb6/EqVjmtE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EEoVQLhjjHw044XtVc/i3fdShz11t7JATaxBmnYJ6tS8Cd2ZxWWWPSjYI55AYFeneGcYK/10L6zcwdRbUpkQmaL1CG+hU8ewbtsAX60k2axEweMRgPB7QAqimIbvQ8dTLedM3TLrp6av+o8uL62/rj3QFbdUMcgsPgabuMUqOEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SpEr+eq3; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8d0d82e76aso58829366b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2024 23:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1726729067; x=1727333867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5TUPhH68J4aIRtGndcy4NXpmyIlQij++uMUQdRa57QE=;
        b=SpEr+eq3/HQ76fT8RajuijqMzOA6bqekax+/as/obHB1a77UjrN5y1LJrrFqfcCIK7
         AcxmtSLzvY3ZQSDCZOfg0DR819lly9TCQbo2PuO8eentFY4zmIAZ2PVpe0y2mTlSv0gM
         nFQVT0QYN3rgJtORcJUYDcrQHBUc2xJOcYc2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726729067; x=1727333867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5TUPhH68J4aIRtGndcy4NXpmyIlQij++uMUQdRa57QE=;
        b=TgsyLtsq5RaWOR3FTwGkY02yo3RWNdR2VsM0nF5QAJvU7Mr6tm+Ifyf6yPUbHbREv8
         VyjvDiPp9SzZ66pCxR75uA4uvxgCAjYTyE9vv30UvnCBY14hFTH717rre69kLpE0+PUI
         detJjAS+dYaJUnHpwVL6oJg6pU79tYuZM9Xo4Tv9D7ITE5Cw+LRCY4ZGhoEl5yJXmFia
         WYFR7CJwtjbfpjmCq7ebph496FUywU/nzY4Y1WumMJJdnf+UkByYY6tzo/liDfs6ZA4T
         FJoGfeozEb0++LH8KTRmF0+zjBAsO1y4DUoGHcmR+RI2uWGj+hGfAppoOfe4A625BPBN
         Rdcw==
X-Forwarded-Encrypted: i=1; AJvYcCWhQSvkVGd48PIBMvGsZSiRfKXDf3dig482uu3uEelV+nPD08iRp/PTVOYvXm4gMwXb8v7PDvL2mcxMzRPS@vger.kernel.org
X-Gm-Message-State: AOJu0YyYccXUCPB3h+BfDSmWqrYabQHic/WJAoOdi0qkHLN808kekCN5
	h3So385dpGGbYbmvuAvOt/WwJoLiwQPCBVgiq+Ijg0Ait8uW+XKHJO9qJG+WCMEh1OU+5RIpPq0
	npfBf/g==
X-Google-Smtp-Source: AGHT+IEVD8vtBq0+QCaaee2bKiA9ZjpaYMt2wsOo2VdbzCW2lmVqT1OzppArD9d0YJ0rLAqasoCzsQ==
X-Received: by 2002:a17:907:efd6:b0:a86:820e:2ac6 with SMTP id a640c23a62f3a-a9029435299mr2435778766b.22.1726729067287;
        Wed, 18 Sep 2024 23:57:47 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612dfa6bsm681091566b.154.2024.09.18.23.57.46
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2024 23:57:46 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8d4093722bso66260966b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2024 23:57:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVCT11s2IJm6DXsI/kqimIRszW8F/3bAn0BT8KuL+xBeeFXyJQCd+fGqYHVmGvqH6vRpzTE8jU3YwV77hiD@vger.kernel.org
X-Received: by 2002:a17:906:f5a7:b0:a86:a56a:3596 with SMTP id
 a640c23a62f3a-a9029678cbemr2701906566b.60.1726729065735; Wed, 18 Sep 2024
 23:57:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wh5LRp6Tb2oLKv1LrJWuXKOvxcucMfRMmYcT-npbo0=_A@mail.gmail.com>
 <Zud1EhTnoWIRFPa/@dread.disaster.area> <CAHk-=wgY-PVaVRBHem2qGnzpAQJheDOWKpqsteQxbRop6ey+fQ@mail.gmail.com>
 <74cceb67-2e71-455f-a4d4-6c5185ef775b@meta.com> <ZulMlPFKiiRe3iFd@casper.infradead.org>
 <52d45d22-e108-400e-a63f-f50ef1a0ae1a@meta.com> <ZumDPU7RDg5wV0Re@casper.infradead.org>
 <5bee194c-9cd3-47e7-919b-9f352441f855@kernel.dk> <459beb1c-defd-4836-952c-589203b7005c@meta.com>
 <ZurXAco1BKqf8I2E@casper.infradead.org> <ZuuBs762OrOk58zQ@dread.disaster.area>
 <CAHk-=wjsrwuU9uALfif4WhSg=kpwXqP2h1ZB+zmH_ORDsrLCnQ@mail.gmail.com>
 <CAHk-=wgQ_OeAaNMA7A=icuf66r7Atz1-NNs9Qk8O=2gEjd=qTw@mail.gmail.com> <E6728F3E-374A-4A86-A5F2-C67CCECD6F7D@flyingcircus.io>
In-Reply-To: <E6728F3E-374A-4A86-A5F2-C67CCECD6F7D@flyingcircus.io>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 19 Sep 2024 08:57:29 +0200
X-Gmail-Original-Message-ID: <CAHk-=wgtHDOxi+1uXo8gJcDKO7yjswQr5eMs0cgAB6=mp+yWxw@mail.gmail.com>
Message-ID: <CAHk-=wgtHDOxi+1uXo8gJcDKO7yjswQr5eMs0cgAB6=mp+yWxw@mail.gmail.com>
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
To: Christian Theune <ct@flyingcircus.io>
Cc: Dave Chinner <david@fromorbit.com>, Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@meta.com>, 
	Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org, 
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Daniel Dao <dqminh@cloudflare.com>, 
	regressions@lists.linux.dev, regressions@leemhuis.info
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 19 Sept 2024 at 08:35, Christian Theune <ct@flyingcircus.io> wrote:
>
> Happy to! I see there=E2=80=99s still some back and forth on the specific
> patches. Let me know which kernel version and which patches I should
> start trying out. I=E2=80=99m loosing track while following the discussio=
n.

Yeah, right now Jens is still going to run some more testing, but I
think the plan is to just backport

  a4864671ca0b ("lib/xarray: introduce a new helper xas_get_order")
  6758c1128ceb ("mm/filemap: optimize filemap folio adding")

and I think we're at the point where you might as well start testing
that if you have the cycles for it. Jens is mostly trying to confirm
the root cause, but even without that, I think you running your load
with those two changes back-ported is worth it.

(Or even just try running it on plain 6.10 or 6.11, both of which
already has those commits)

> In preparation: I=E2=80=99m wondering whether the known reproducer gives
> insight how I might force my load to trigger it more easily? Would
> running the reproducer above and combining that with a running
> PostgreSQL benchmark make sense?
>
> Otherwise we=E2=80=99d likely only be getting insight after weeks of not
> seeing crashes =E2=80=A6

So considering how well the reproducer works for Jens and Chris, my
main worry is whether your load might have some _additional_ issue.

Unlikely, but still .. The two commits fix the repproducer, so I think
the important thing to make sure is that it really fixes the original
issue too.

And yeah, I'd be surprised if it doesn't, but at the same time I would
_not_ suggest you try to make your load look more like the case we
already know gets fixed.

So yes, it will be "weeks of not seeing crashes" until we'd be
_really_ confident it's all the same thing, but I'd rather still have
you test that, than test something else than what caused issues
originally, if you see what I mean.

         Linus

