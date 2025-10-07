Return-Path: <linux-fsdevel+bounces-63568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C216CBC2E1B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 08 Oct 2025 00:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B6104E6E2B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Oct 2025 22:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149B1255222;
	Tue,  7 Oct 2025 22:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HXl7fxmz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4385A3A1D2
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Oct 2025 22:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759876550; cv=none; b=BBOuvkZcnjShhnWqpLjDgNUVwqYzaPBVpTjJKdbYviU2zsxD/gec81dum1/cdEC7qHtqFNfardd4NZx8lKKKHZ9XI58icFaGMTqeIdbSe1CoLeKhSFzMnv5ASJWOKTAbexP1nfMbpy9rFcDHD4bBra78l1Ikbs3SNMQoQoEeR5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759876550; c=relaxed/simple;
	bh=neGVOIR66NHvFQ4eTUWaYAgKfEg//HeNq9xtbiC4+3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qFP+TSZdFJ2NQ75NJpdqnG5pdS3Ywyt7RMnZ6bdWBa6aoHJI/aczOKSWFBZIRmlmt6WaPISiA3+2SKNed+g2/TnEvl9PFX5B/55G5auIhQqH+iLyYyEenvdd5I2+89CY1TZS6640BC6MKEZX0zIIJs1CzMCwUwV1e/tdCwiNWYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HXl7fxmz; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-62fa062a1abso12652589a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Oct 2025 15:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759876546; x=1760481346; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SUJQD6TMxQr8aborn51643M6Hiyk2CEy3VwfT2illBo=;
        b=HXl7fxmzuFwVgip6eU80MLtSW6IhYzQ9vURMuqkm1eVSIGrAGJnCYl315tSJBpTrJR
         aqQ27hBbMVtrXfvBDYAxBuujRSoSCDnSPGZPCaVOpTWbF8B+qEhA4ShTWA7WEsTcL6iD
         OAs03jFyNvn9Wkg8hkUtdDVmxUs1D5pIit3Ec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759876546; x=1760481346;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SUJQD6TMxQr8aborn51643M6Hiyk2CEy3VwfT2illBo=;
        b=suyHvcAhaUQKbFVPSHeOBpO6I8Rve+QQoYf0cHnmfFWsvEsTVr8pklhhfk/oFzrATj
         AuhUdUSnsfdRHV3CmHYaYeOC4yxNmBLU2gqJ8Tee+UJ9jrpqGdsgD+o5Q0AUr+TDLu0K
         CkpxUqylySJhq524kLWRVLdPfgtdFjHXaGk5YYFIeDx66lPDccsYM+vmvfbIOYTb5J1F
         BkrFb5pjs1Q/YTSM++KPDRZ7r7pRgUjBJRkTePJXw7bv2Ddb3qHsOkNUNwy6y5sy+5Tl
         TU3NCym9B+pOeaajDBjJ+TIOuBslrvtomfSoqTU3GHV0NWRB09VZKJ5rNIVB2eGs7jpt
         LOpQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+JZj6Abc1X9SSnpgZX2qWhNQf+LMMgvZ4WTqbYIS3mrvUwiM5v9l5xl6m6xVEwhXUKqqMla7jMR7qdiKG@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1dKQZZnrikLaylZ7s2+dpE5ZRKR10h3SBromaSDNEzkDb4LLu
	/BtJXxWKiE8TgvaGmtHewsB4OTEx2CL+CGy69zTAu8E/xVodij7eIL3rkUdKrLXN2SHEQJBpE++
	YLp4N+u0=
X-Gm-Gg: ASbGncuk0P2fRnQQVluika/JRtTjxNMjC400C1T0w2arZEYKEtHqwJhQErClNlydlhK
	9zZxmofQXKZyV6c3iaGMjRQG4oWDGOIyNh5iAMflDsklVZCqsX8t/1YyUmoEiLDqeR3uUXIJ3xb
	5LocqMdIdyo9pWt7y9DU+54QiAt7sdwMsoEb7sCPMOb5DuSqRGbo6txEuIYMdopYQxAbqYXkB0R
	JSeyav+P4gXccmI7M3MJusoq7TS7TdKc+jXsEMxHTe/+8PWMw96SVMhwi0xl93h8s32MLcvy/KI
	0J0alGb4kAZa+QTX8t7Onm78eIHef52JuhXeKDLwk7s+ixHxpgcx/gcS4rxquCwt14wfm66Bwjm
	qsjoitip58Tm8fJytUghvKDrTwkwAEKKSK3NR6K956RiL4F5qEMU1Wrgt1XAGLf1z8XJmy5Ku/7
	2Ir/EVZOLLsyHpmPqBdxO7AOiIdTJFTE8=
X-Google-Smtp-Source: AGHT+IEAYBf+TcejbTb68AoAFFLzWE+/vDoQL00e542CH//KOT/7b64YJVApv2U0W42T/lOF1O38eg==
X-Received: by 2002:a17:906:f586:b0:b3d:530:9f07 with SMTP id a640c23a62f3a-b50aa792c58mr155928866b.11.1759876546066;
        Tue, 07 Oct 2025 15:35:46 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6378811f14bsm13300443a12.45.2025.10.07.15.35.44
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 15:35:45 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-62ecd3c21d3so12477735a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Oct 2025 15:35:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXr7h75vZsnJMmlqp9xcCTvYwhic2SsCEYsI7mqeDfvhIBQ5KgOIom9KfCNVdY76R0V7UzS8Qk+Qsl5sBEb@vger.kernel.org
X-Received: by 2002:a05:6402:26c7:b0:639:dab5:d610 with SMTP id
 4fb4d7f45d1cf-639dab5dab3mr251304a12.15.1759876544657; Tue, 07 Oct 2025
 15:35:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wj00-nGmXEkxY=-=Z_qP6kiGUziSFvxHJ9N-cLWry5zpA@mail.gmail.com>
 <flg637pjmcnxqpgmsgo5yvikwznak2rl4il2srddcui2564br5@zmpwmxibahw2>
 <CAHk-=wgy=oOSu+A3cMfVhBK66zdFsstDV3cgVO-=RF4cJ2bZ+A@mail.gmail.com>
 <CAHk-=whThZaXqDdum21SEWXjKQXmBcFN8E5zStX8W-EMEhAFdQ@mail.gmail.com>
 <a3nryktlvr6raisphhw56mdkvff6zr5athu2bsyiotrtkjchf3@z6rdwygtybft>
 <CAHk-=wg-eq7s8UMogFCS8OJQt9hwajwKP6kzW88avbx+4JXhcA@mail.gmail.com>
 <4bjh23pk56gtnhutt4i46magq74zx3nlkuo4ym2tkn54rv4gjl@rhxb6t6ncewp>
 <CAHk-=wi4Cma0HL2DVLWRrvte5NDpcb2A6VZNwUc0riBr2=7TXw@mail.gmail.com>
 <5zq4qlllkr7zlif3dohwuraa7rukykkuu6khifumnwoltcijfc@po27djfyqbka> <CAHk-=wjDvkQ9H9kEv-wWKTzdBsnCWpwgnvkaknv4rjSdLErG0g@mail.gmail.com>
In-Reply-To: <CAHk-=wjDvkQ9H9kEv-wWKTzdBsnCWpwgnvkaknv4rjSdLErG0g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 7 Oct 2025 15:35:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiTqdaadro3ACg6vJWtazNn6sKyLuHHMn=1va2+DVPafw@mail.gmail.com>
X-Gm-Features: AS18NWD-EYOWOuMnn_EcBjH4dRmdOnLeMLRD6pujUfuQrjY9wz8yiIq4-85QYEU
Message-ID: <CAHk-=wiTqdaadro3ACg6vJWtazNn6sKyLuHHMn=1va2+DVPafw@mail.gmail.com>
Subject: Re: Optimizing small reads
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Matthew Wilcox <willy@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Linux-MM <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Oct 2025 at 14:47, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Note: this also ends up doing it all with pagefaults disabled, becasue
> that way we can do the looping without dropping and re-taking the RCU
> lock. I'm not sure that is sensible, but whatever. Considering that I
> didn't test this AT ALL, please just consider this a "wild handwaving"
> patch.

It might be worth noting that the real reason for disabling page
faults is that I think the whole loop should be moved into
filemap_fast_read(), and then the sequence count read - with the
memory barrier - would be done only once.

Plus at that point the code can do the page lookup only once too.

So that patch is not only untested, it's also just a "step one".

But I think I'll try to boot it next. Wish me luck.

               Linus

