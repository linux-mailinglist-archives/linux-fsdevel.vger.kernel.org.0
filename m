Return-Path: <linux-fsdevel+bounces-40008-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0432A1ABAF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 22:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F8AA16811D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 21:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C06A1C1F15;
	Thu, 23 Jan 2025 21:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="b93QnSZ2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EC48BF8
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 21:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737666597; cv=none; b=hgoa4Smxq4tcDfg7/jWdcL2yt5WY+EhoPhx/lHQ4nNelhKMfiOruvnYBaySyuit0Ujvbv5vnStXvvI+pkYG48oAR/jRuBWXo5362nK/YGgnrvp8JJ8+hUP9UlHMTSrjkDKTwIhUe7aUzYjVTI9emgcc/ovB4q1GwIo+AknAp5zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737666597; c=relaxed/simple;
	bh=vhTVOy/w/s9qOhikax5fld6x10F5t9GWo26bab2fhkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P/n+GTYMRypNoENBoaXM8Ba8eyMgd0heT4mRm2Nrl8VCxOqk/vqGh9NxET8lyZgWNOf6KHIoi9yBV0ng8bO92GD7gVcN5G1Hi6XTUMFO6qHB8ArscsKL7tLtMK8CaIC/hCgVT4eBiFjVm/tLf1MM2qlJ0uB+CouBs5Xl/iU1s/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=b93QnSZ2; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5dc10fe4e62so1950380a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 13:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1737666594; x=1738271394; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vxCDyYLjOKBSu/9mlmuGFCp5IbSC8Ommc6IvIiMUgEY=;
        b=b93QnSZ2mQtzDmNdHVmLeTGNC1CNILYMYAFZlmw5m31S0PJ1RZs3/IzMaxxLu6rzFo
         LR6xzT9hp2wsL0qikpWZg6UMgRxOvu3mr/qO4uIio8GPpVUkESQrw37rxhvhYSmaWpVo
         deus3SsfdcrLXbRsiCZXbJ+ZMjyer/Faccg2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737666594; x=1738271394;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vxCDyYLjOKBSu/9mlmuGFCp5IbSC8Ommc6IvIiMUgEY=;
        b=ectlgw2AygLbHzeOJ2m6QGVmMfl7i9DKcBra5K1FZAqiGa9HvyxhIMqnT23wnQs42a
         f+3SM1MQioP8kfOLdpJm6zZCDPxH7qS+qnAJVADXeGj6tC/geDY5DW62X5ksTLT7B0kG
         QupnvgM6pQXuXM+6q9ZumBKKtTjbiajt8nhBGr4aOcyzhVP+VRxELWSL84jBzccvBOqz
         o3aqgwFBC3jgshhhNuuVsvBnQt910qARg4FKeWiWgFas/4SWH6JUeRvlTG+9H4H8cBfy
         AcZ3ilSN0JTyIxuiMSi9eajiNrL6MHVOzhYK20eI+65fJe+jG9RrK96aEBgWFX9X8auv
         szYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqJldCKiXNxIo0P8Wu1UQGrZUQyoZ7wqSo37/hyYtFJbDqkj5LS9zkZG4X6umYi4fs8tkRqkPZZ++4libh@vger.kernel.org
X-Gm-Message-State: AOJu0YyG0NQBanDpW6WwPvehsqnjz36cVkKdjRSl+ivJi4jji0/kKe7g
	M+YVZId8VytaPxs+buDw2lviTx6nlmrrOfhoWS1B6usnCYcgXm15JvHET8uIeVWSO3X15GZFmNu
	o7oUhHw==
X-Gm-Gg: ASbGncva3+uwtBCSE9+x6WLiJMkBIkgMIpAxQysA46g5cuzzDC71Nvd5RpwvmZUiuqt
	YmuS3Z1Gf7sKsu1xLAmPmjyeB9ChHzwrghbRVGxCUOKl9b+q+EnkS83+RXVNnFdFPMvLYClr0++
	UOhGC8s7yfXeAE5wfY1tpvM9PqfbhDxAwepgXBmfcsDBlweYgikBN9pccbKylcr/T4PeDVkPFOT
	rNwphAwkgM5S9F0ZvL13KDQCImeaAryNP83J9ZBpscr0wlW9vB7mkD8NsjA2FD+wOZ4WdRb/bTO
	DpzTwddpqiKKm5HPHRY+TtABwIWBsHuI911AeC9lESUQiVUgLKfvGak=
X-Google-Smtp-Source: AGHT+IEnryfflZn2K4YmK8Jw6IiIY8hIf8yPB5qwGqujelCxKChRCJaMk0uRuBBvIEPDpyyx5Ss1dA==
X-Received: by 2002:a05:6402:1d53:b0:5dc:1273:640c with SMTP id 4fb4d7f45d1cf-5dc127366ddmr2030268a12.23.1737666594121;
        Thu, 23 Jan 2025 13:09:54 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc18618835sm166978a12.1.2025.01.23.13.09.52
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 13:09:53 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa689a37dd4so288605066b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 13:09:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV9wjUM3YZIX2w8V/PGujW1N7hmPoRbc9eD4gG08lYKKjIp1z/+Sp19qfU77kgMkke0RRpsQJMN9G/Dco60@vger.kernel.org
X-Received: by 2002:a17:907:9408:b0:aa6:a87e:f2e1 with SMTP id
 a640c23a62f3a-ab38b4b96d0mr2487031166b.56.1737666592031; Thu, 23 Jan 2025
 13:09:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <i6yf5ledzs4qdt5zhrpg7nz5neyygktthupap6uulpuojcx7un@phdanup4alqb>
 <20250123183848.GF1611770@frogsfrogsfrogs> <CAHk-=whUe3wH4J1YGrdokVEgtb2hjteOdBttF=6ffHSYzakcBQ@mail.gmail.com>
In-Reply-To: <CAHk-=whUe3wH4J1YGrdokVEgtb2hjteOdBttF=6ffHSYzakcBQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 23 Jan 2025 13:09:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh3t1jU=FKgCg_6bKe-JB9GD5PobkdHN1p0bv0Btfsg-Q@mail.gmail.com>
X-Gm-Features: AWEUYZmaxb1XRlJL2xi8oDrvjI0Di3h0amOtEaxEV2ADdSTf3PC-w66vXpRq6AE
Message-ID: <CAHk-=wh3t1jU=FKgCg_6bKe-JB9GD5PobkdHN1p0bv0Btfsg-Q@mail.gmail.com>
Subject: Re: xfs: new code for 6.14 (needs [GIT PULL]?)
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Jan 2025 at 12:46, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I'm getting back to filesystems today, but since I have great
> time-planning abilities (not!) I also am on the road today at an
> Intel/AMD architecture meeting, so my pulls today are going to be a
> bit sporadic.

.. in fact, the xfs pull turned out to be the next in my queue, so
it's in my tree now.

               Linus

