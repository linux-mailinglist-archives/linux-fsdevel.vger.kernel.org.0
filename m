Return-Path: <linux-fsdevel+bounces-8220-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0638B831172
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 03:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 875521F25D8A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 02:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B178F7D;
	Thu, 18 Jan 2024 02:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="I5WI9hpW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2318C09
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jan 2024 02:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705545243; cv=none; b=DxjXuN+g5CAP0XgKPDgP0zUmZJDqebGunwqJ2JbTHO0tMoDeDeqQ856bdMWMsQ0FlBBoNBeZ14bEAgoqjf9XL0PIdZTYyEKCGzbpWq7zw0Q8GBGZoiVcXTu/Zats24J0FDFsdxdILlSD+1tRieBOkchNDioa7rx/ESUaY0WsheU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705545243; c=relaxed/simple;
	bh=Fx0FZp/yriWUS/60rJIiJaDOE/GkdueDBQIxbv2+PDA=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:Message-ID:Subject:To:Cc:Content-Type;
	b=Y4dijYrziphaYh+I5rr5oWuImfce6uFLC3wpqKo6BDEvzwoJ8k1FgZS32MUA58sguKx7c46TBPwrOtFIMCu9Hla0xsTnjJDN2JnfZCksWhhxZXRYmxoY3hybN5y2bC2XJKe+36tHfoj4JO6lg4YuwqxRiSKLjLuTvUQNOcXrXYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=I5WI9hpW; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-559dbeba085so1625536a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jan 2024 18:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705545239; x=1706150039; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jZCb42IR8aKR+GNSKmqQtELI6hBL5y5IxUEk4iaV7Fw=;
        b=I5WI9hpWk1TasqkgNmmCyGXmR86rx/o18FmIpDVKLUhYG50KfR2cwbZL2HPuE4qYs/
         elVfHNpmq7QcCfFx2uT5nZdsjp9A8Uwgq2sIKrWFoNTV2F/qkmaqSmcOgqJw6HUsvGYA
         OtltzS0rxg4SnTr2g1xB3CVfs01s8Ktc6Rngw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705545239; x=1706150039;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jZCb42IR8aKR+GNSKmqQtELI6hBL5y5IxUEk4iaV7Fw=;
        b=LQVeLqgOcWxp4QTZC0u/hh/6/0htJcMnS4rqCacwkRetT7YR4l5p+bmrgkgFP9jVa7
         4xzEBVu0U78BjLYVPUNp3eEX6hqDUs3H6iRPzbpQKgz3WHCTgs3E7KCfcjUvqgUb26P5
         MzSez4tkozHpEmyueOGZDo6HjJAST3lMhPeJq07V9dqzjEqufr5NoQtM+kR/8ZzakcZx
         8FkjYT2v53SgtvxsqBA42q/UlPX9ux8pGqa+JdaJKcwcArE3DtDavswWoEtEoxsQjx5n
         nf3xLm+/ffOJCvee79Um+S9f3Jkx8PHK1p+gwOuGdPUc5tvSNQUvWmCps73x/Gy0rgGl
         40aQ==
X-Gm-Message-State: AOJu0Yxgdfs+7mKcAAWSB6gdWI5PAXFtEwQNDjddy4GmP+RJmtzBxvta
	l5hAfcfGsjtfVHaBYqgdOpzrZ4UiEomFjgm/v+L31vo5oa6NWMyx1opCFhpVokI0Vv8HWRziOhR
	u/z10GA==
X-Google-Smtp-Source: AGHT+IEoGWv9nNAh+Quf+6CF03aeUKqt9NKUQPHZUKxiLpO0eWU4ipPoCmZQVySIFk15TocdjrtFhQ==
X-Received: by 2002:a50:8ad7:0:b0:557:2069:db8c with SMTP id k23-20020a508ad7000000b005572069db8cmr128246edk.46.1705545238980;
        Wed, 17 Jan 2024 18:33:58 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id cn25-20020a0564020cb900b00559c8520f6bsm2062365edb.75.2024.01.17.18.33.58
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 18:33:58 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-559f80c9ab6so604984a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jan 2024 18:33:58 -0800 (PST)
X-Received: by 2002:aa7:da0e:0:b0:559:cc32:e087 with SMTP id
 r14-20020aa7da0e000000b00559cc32e087mr112756eds.20.1705545238057; Wed, 17 Jan
 2024 18:33:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117222836.11086-1-krisman@suse.de> <20240117223857.GN1674809@ZenIV>
 <87edeffr0k.fsf@mailhost.krisman.be> <CAHk-=wjd_uD4aHWEVZ735EKRcEU6FjUo8_aMXSxRA7AD8DapZA@mail.gmail.com>
 <20240118020554.GA1353741@mit.edu>
In-Reply-To: <20240118020554.GA1353741@mit.edu>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 17 Jan 2024 18:33:40 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjkFcF4HKDhSf_fpsLNmDGMkD-ozaNdEhpEQ4JH=MsnNg@mail.gmail.com>
Message-ID: <CAHk-=wjkFcF4HKDhSf_fpsLNmDGMkD-ozaNdEhpEQ4JH=MsnNg@mail.gmail.com>
Subject: Re: [PATCH] libfs: Attempt exact-match comparison first during
 casefold lookup
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Gabriel Krisman Bertazi <krisman@suse.de>, Al Viro <viro@zeniv.linux.org.uk>, ebiggers@kernel.org, 
	linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Jan 2024 at 18:06, Theodore Ts'o <tytso@mit.edu> wrote:
>
> A file system which supports casefolding can support "strict" mode

.. and we can support "shit" mode that craps all over your filesystem
too. The fact that you can support something doesn't make it good.

> This is what MacOS does, by the way.

The MacOS filesystem is the CVS of filesystems: if you see that it
does something, the right thing is almost certainly to do the exact
opposite.

Case-folding is a horrible thing to do in the first place, but MacOS
compounds on its bad ways by then using NFD normalization, AND
EXPOSING THAT TO THE USER.

IOW, MacOS actively changes and corrupts the data the user gave it for
filenames.

There are tons of Apple apologists out there that will make any number
of excuses for it, but it's actively shit. It's broken garbage.

So the fact that MacOS then has "strict" mode, really is an argument
*against* it. The MacOS filesystem designers were fed the wrong kind
of drugs, and I suspect they may not have been the brightest bunch to
begin with.

> So we don't need to worry about the user not being able to fix it,
> because they won't have been able to create the file in the first
> place.

Yeah, that's a fine argument, until you have a bug or subtle bit flip
data corruption, and now instead of having something you can recover,
the system actively says "Nope".

> I admit that when I discovered that MacOS errored out on illegal utf-8
> characters it was mildly annoying,

We may have to be able to interoperate with shit, but let's call it what it is.

Nobody pretends FAT is a great filesystem that made great design
decisions. That doesn't mean that we can't interoperate with it just
fine.

But we don't need to take those idiotic and bad design decisions to
heart, and we don't need to hide the fact that they are horrendous
design mistakes.

So "strict" mode should mean that you can't *create* a misformed UTF-8 filename.

It's that same "be conservative in what you do".

But *dammit*, if "strict" mode means that you can't even read other
peoples mistakes because your "->lookup()" function refuses to even
look at it, then "strict" mode is GARBAGE.

That's the "be liberal in what you accept" part. Do it, or be damned.

Really. No excuses for shit modes.

               Linus

