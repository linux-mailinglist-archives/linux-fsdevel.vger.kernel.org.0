Return-Path: <linux-fsdevel+bounces-70924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6416CA9DE2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 06 Dec 2025 02:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 628B0311B08F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Dec 2025 01:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F0021FF46;
	Sat,  6 Dec 2025 01:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="awGHQUPo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9620F191F94
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Dec 2025 01:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764985992; cv=none; b=eqxACNCoZYFNxBn/JxTb4Fdh7s74IoHnvwp1PnwvS7B5flRlcgiZCqHJKzjGGwtipBUruMBAgT615UPP549wgM3eQjSyL7wxKVI8Y7EuXrK85TpyB4PyJ/A0bJDcFl/GZkKS+dBfvc4lBT9mWzHPhN2BkLA1gWvoGYImIpHC4rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764985992; c=relaxed/simple;
	bh=oJeVkb6C1PgTTRyHcn2AabpAYCIJcY237CZqmxo+zBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eQdsWEUSEtKGWeMCayVvchv9llAmQO2L/Q7xWRCHbxAe3aTDjcf+Vs3MRgd4s6HMs9PmNFzJS5A2cczZRQY8PJRptu2qfDIrn/vuQR9ArgADpkBFIUe3wRuqhXNLdLaHTA96vzhetD9k0VccX+ls2A8eZP/F7DoGbwA0PsMw6Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=awGHQUPo; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b7697e8b01aso248708666b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Dec 2025 17:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1764985989; x=1765590789; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Di3S/t+/5uZhPFA0oMvgeFpPIVhymQoPTu3NzhjmUi0=;
        b=awGHQUPo202vs3jxbjwI4CdHodWOarDw16ABrtQLyKXz2WWy+lJ2bpg8OUbdPAfvlJ
         HtI3tAh4r5X+JGT+WsEeeZHLE+y8ccgAuEHop4hURKOwZJ4alni2Jny1gyNuR+6UkeCg
         Is7UCCr9bR9TasJucWcG6FqhQLQ6vnNMITsMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764985989; x=1765590789;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Di3S/t+/5uZhPFA0oMvgeFpPIVhymQoPTu3NzhjmUi0=;
        b=LXei6GfwBU8J+PByXkAXP0qjvULbNAlf9kxCTIgmnM1hOKBmwhIwS6AFPE5piw9zZ+
         wobW5hC2bVzLjDA/aE7rdlhH5ftY0DDjEQJsk9fMFB8u73yoGFuYrt7CeoSDf7yd2TJn
         IAbOov3gc+1sC1LFN3D2fKIWjBEbobGZoMlLtLx/RgKKdkf1dpcxojRnOOL7AcSjmaXm
         VUiRb7pq3CV2xyRlS/DyBqtfx8eLgb6m6GNibXh7wos/qOo495FxnunkgztolroQrdRN
         XamMdb3XHCEnKGWOF3E/EgdXFHtc6zYH4N69tw2tEfpYdFccnPMU6hV8mIgU8gdgtzAr
         yqHA==
X-Forwarded-Encrypted: i=1; AJvYcCVvMVYYt7ePptPN600/LOgaqK3UOSZpanZDVqoWjX7IrSTnsvrzqwE0K7UKinU11n/yXWRhsv02GNpFeswj@vger.kernel.org
X-Gm-Message-State: AOJu0YyC0MMJ0PNZu4q7scC0bYhaOtXfyWOm8Y6sPZu4opbF3B73SiSh
	ekSwNfRY5gIuyhTKeNSz/0AEPEO6Deuu2u9l2CZ6yJuNXNDSIES4HK5yZ6I6XCeewcTF6/gXcgo
	NXBtba+ZiMA==
X-Gm-Gg: ASbGnctH1J6/haPN3ZY7YBOnkhtiwt6ENo/QKS/ykQ82mFKmy4RXYm2kgvJCX0rZvVo
	UcGd9IKmmFU+QnP+hE5ByPLaOrKjoMeoKy5eodTBklKuww+KTuCt7xKkv4NiG+xBOfTOI/LAeo9
	R/LRnwHUAzijkKt5Kh+9Po82hvGoRx/SuZYBRF6V38RUuuH3WkXng+lO0S8dSAVBKGxox5uOPlq
	0724Xh9XXJTsrzP7rQCNLaKd372bI83S8pYPHvvdXYeKrmM4Uqp72U7CwScDZzqq0X2HCWYk0Qb
	6z17BRumbjPCBmC/0xdTjAuIuK2ffTxcfdBkZ/1Hrr6fMJT8pzYcXPo0x0jwa7BTQeoVNza4hS/
	90eDblCNnFGOUaNdpe77vvxG5n4n22uxRx7rK7YnQzzYZt/9BLqOjeoHOf0XH50zR87hS9IGhpF
	8Z0+CT9x83Oie9czXyA5k9p0I7LcpsEQU3BCQdEgonCmqNAxusa7K/9hi9FNzX
X-Google-Smtp-Source: AGHT+IFqO9YIlL7fhs6H+ullQ1SJsShAMkP/NSOC1cEPCfLmX56FT7CrEqgFeJ64acWf1NS5yuQVdw==
X-Received: by 2002:a17:907:7e83:b0:b79:f984:1557 with SMTP id a640c23a62f3a-b7a247b500bmr109395666b.46.1764985988611;
        Fri, 05 Dec 2025 17:53:08 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-647b2edf72asm5105324a12.11.2025.12.05.17.53.07
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Dec 2025 17:53:07 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-647a44f6dcaso3676623a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Dec 2025 17:53:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVVG2K6GTxJHvaI4OS2kHcTj4Cprt6Y5e0scddn2vapNS5Qzq7zzruMsIVqblAWMbFiV+3N9SviSZIZU3GL@vger.kernel.org
X-Received: by 2002:a05:6402:4403:b0:641:8a92:9334 with SMTP id
 4fb4d7f45d1cf-64919c053d4mr758424a12.6.1764985987057; Fri, 05 Dec 2025
 17:53:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegunwB28WKqxNWCQyd5zrMfSif_YmBFp+_m-ZsDap9+G7Q@mail.gmail.com>
 <CAHk-=wht097GMgEuH870PU4dMfBCinZ5_qvxpqK2Q9PP=QRdTA@mail.gmail.com> <20251206014242.GO1712166@ZenIV>
In-Reply-To: <20251206014242.GO1712166@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 5 Dec 2025 17:52:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg8KJbcPuoRBFmD9c42awaeb4anXsC4evEOj0_QVKg0QQ@mail.gmail.com>
X-Gm-Features: AQt7F2oF6FTs2sUwqWqe8d22qb4OqS6omXJ8PzKzz4l0t5fdpcBoE3KTUpf-_t4
Message-ID: <CAHk-=wg8KJbcPuoRBFmD9c42awaeb4anXsC4evEOj0_QVKg0QQ@mail.gmail.com>
Subject: Re: [GIT PULL] fuse update for 6.19
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Dec 2025 at 17:42, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Far more interesting question, IMO, is what's to prevent memory
> pressure from evicting the damn argument right under us.

That was my first reaction, but look at the 'fuse_dentry_prune()' logic.

So if the dentry is removed by the VFS layer, it should be removed here too.

But maybe I missed something,

            Linus

