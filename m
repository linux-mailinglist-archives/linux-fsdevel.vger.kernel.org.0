Return-Path: <linux-fsdevel+bounces-70918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDD5CA9A88
	for <lists+linux-fsdevel@lfdr.de>; Sat, 06 Dec 2025 00:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1AAB73034CF3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 23:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431011C84BB;
	Fri,  5 Dec 2025 23:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TKDViLJP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB13625
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Dec 2025 23:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764978491; cv=none; b=T/0JE/4+62b0AlpwuqpM8MytFeWwODpJO29HAEjXQ3Y7k5cW+k/opz/m28Grpm8Brd2M1TmGyoYpcMlW4rdGD/Z8HFNnmODxHm/i6EequnW5oaEIjnwdPXQ/Gq8Slmg3l+tzQIsA+IcsFCv7CLpaidqO7T6MvHQHmNqWYj1CClo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764978491; c=relaxed/simple;
	bh=hrPJLg76bB4ouRqf3LRLY1sC3T8ACDvEaITt2kDvyUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RHzoync8On8fONYL49guwa2TYDQq01ism4WELcqj9T7nM17sNHOAJ8HRNRVOSoConEp841hxhTsFLnGI4roI60gmw2MRqezodrCgnrIMhZKXNlZQ6u8BEIVuh3pUUUpLTyyfOvrHCLDoHA9afNKD99fbGlo9FI+zrQ/Y7GKFipI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TKDViLJP; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b79d6a70fc8so432302466b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Dec 2025 15:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1764978487; x=1765583287; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XLNk7q29SYCfgF2/5hVny548Lm2318M2rsMLcMyZyqI=;
        b=TKDViLJPZG+ghM5ZbpmVkdxyMw0sZo3wrsD3MKpDcbV5/uKjkm2F8zBSrs3fpxvgHG
         +Jrb7dwD6QDebjcoA/byMVqDoKXieSJtFHDVRmjxtu9nq1ZZPZTheb3omiJXP0z+Ta5a
         Pm0IADiSF3jM0o8nluLxAZGKzD/0mihDBHQ94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764978487; x=1765583287;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XLNk7q29SYCfgF2/5hVny548Lm2318M2rsMLcMyZyqI=;
        b=JpTTczrAoOQ9AG1GtdVeGEI3F4632WgQvmSr1Giz1F90OYxqCBDuvR/ZDGTE7Icrxm
         Jq9aszBYU2PMvaSwh+uKj9z3X/kIj9+s3oOXLNXEqrW3avh4X7EKm09IYaLXQ9wHWhwl
         MpbNvA9KuJGzWy3b4cGVtTmpz0l7gGjuqBWQTBX/7qT4WBmjIs2XmcPAAAPzLtZ7KRof
         biNt92acZ01sPr3GPJxWieK3BuaU264qWaVdOu+f81taGjY0oBEsXFZMLLK64ztHRYLc
         RAFxPRggYvICQ/Q/QYEs4EPyob+niNqkqOj8bn39KCMHHaCHMv+GTFO70GsRpJQWekIK
         Gwbw==
X-Gm-Message-State: AOJu0YyPkBmmmPJPu0nMdnDLzwkVoY/FOWX1HsoLEnZeUX8yyH8qZsXr
	vmRZparuRq4BBbskIo0SOpjQEQOBZom/HsKNOyU+KE+WxbXwyx0FJ0gryFC+h7+97o/orz4KjCo
	GNNjpIazcyw==
X-Gm-Gg: ASbGncvpIm19dpoe2Ho/s5lNUh9LlCkJAROWSZ9SgohxnyNBtu2EPMSHRPN8OOGvAkZ
	wqfffxJsY4pVJouXeyDOLobJdJxJhukIC5+3JhkBpDGCpSUsBO3LdNdMate3dFAFV9UGxBvw3aB
	38kqQ+ViVHxyidjFtx541zei4pEGPyvcttSYAPfWCCAtKa4zsD+jQBH4EPdop7wDz79uiRedLiI
	1Gp6sepd91QSDrP79+zuO8UOhwdxT7c0xVJv/ClUs27iJHbh9n7oXzCJVn3k7NTPOKK3WOPxY5U
	q4zMmwNsdYtw5wfT2rS8UHoYRGITPCA15/XFvgfEYW8oV3GD0JJkNaLruD7a+YabtfWxpSIw9+y
	ArrZo5kkBL5Gz3BMd1cSolpSC66Z3OygRJJtfAVtOR5PhkTduwGRAsSa6WQ1Ta9rm6TURuVm/bz
	Hqo7IQURYcxHpfxQIbqq2kWsHVAgyCuhTFTESgTL6V5DcBK8qcR74FilQSgO5J6MTur1StOlI=
X-Google-Smtp-Source: AGHT+IE9GpWgi8VbS080GC1DAwqBvku7JlBC1T0ylz3vtacEa974nfWqdHGMG2UurlPav6zS6xrOCA==
X-Received: by 2002:a17:907:c22:b0:b71:cec2:d54 with SMTP id a640c23a62f3a-b7a2481e6d5mr92316166b.57.1764978487298;
        Fri, 05 Dec 2025 15:48:07 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b79f4975c56sm470802366b.33.2025.12.05.15.48.06
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Dec 2025 15:48:06 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-641677916b5so4106573a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Dec 2025 15:48:06 -0800 (PST)
X-Received: by 2002:a05:6402:2747:b0:640:6653:65c1 with SMTP id
 4fb4d7f45d1cf-6491a1dc146mr539978a12.5.1764978486068; Fri, 05 Dec 2025
 15:48:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegunwB28WKqxNWCQyd5zrMfSif_YmBFp+_m-ZsDap9+G7Q@mail.gmail.com>
In-Reply-To: <CAJfpegunwB28WKqxNWCQyd5zrMfSif_YmBFp+_m-ZsDap9+G7Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 5 Dec 2025 15:47:50 -0800
X-Gmail-Original-Message-ID: <CAHk-=wht097GMgEuH870PU4dMfBCinZ5_qvxpqK2Q9PP=QRdTA@mail.gmail.com>
X-Gm-Features: AQt7F2rNSr-kbkrT0_CRzNcHhQvwG4PA0LhNMpz-VKdVZF4eCEfZEG9zYVGYqLU
Message-ID: <CAHk-=wht097GMgEuH870PU4dMfBCinZ5_qvxpqK2Q9PP=QRdTA@mail.gmail.com>
Subject: Re: [GIT PULL] fuse update for 6.19
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Dec 2025 at 00:25, Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> The stale dentry cleanup has a patch touching dcache.c: this extracts
> a helper from d_prune_aliases() that puts the unused dentry on a
> dispose list.  Export this and shrink_dentry_list() to modules.

Is that

        spin_lock(&dentry->d_lock);
        if (!dentry->d_lockref.count)
                to_shrink_list(dentry, dispose);
        spin_unlock(&dentry->d_lock);

thing possibly hot, and count might be commonly non-zero?

Because it's possible that we could just make it a lockref operation
where we atomically don't take the lock if the count is non-zero so
that we don't unnecessarily move cachelines around...

IOW, some kind of "lockref_lock_if_zero()" pattern?

I have no idea what the fuse dentry lifetime patterns might be, maybe
this is a complete non-issue...

         Linus

