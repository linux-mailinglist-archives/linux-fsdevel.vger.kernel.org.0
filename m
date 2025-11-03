Return-Path: <linux-fsdevel+bounces-66863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 50ADFC2E5EB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 00:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D80934E3B32
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 23:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EA02FE593;
	Mon,  3 Nov 2025 23:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bGw+++mj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF972FD1BA
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Nov 2025 23:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762211091; cv=none; b=ppoRALp91ElmI6cKs8IEEGrp+hILyTnk7QUUIuPv9HDpO2BzIYuxuirOw7ZUJYNJ+77ubjLIYrqB/qkUpCceYE06mJ/jzd5mNeQYa78bXv/OYOJhYIBanfFe/EoIvDNLfillW2JTEsAZ/PvRShJjNhtvJEtUyevCarY/43LvXM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762211091; c=relaxed/simple;
	bh=qFJb3QTz/3jg/L6x2lbG2psgJfjIQh5q1KW1+nPPaBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i32lndFHU+hy1I2m+SncPheEUucPKp0OsNanPUmxSA060++Wh/8p6CvTR3IKp6qkk8Jxu4opzGcmzry4blToynJ+obgybT6Ew5jJbvlo926sPfqT1vmY62J7v94rcOXn1OkhrKCVX1sRrBpprTZ26oNDA1NBvN9bnfRf60/U1gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bGw+++mj; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-640c3940649so2369708a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Nov 2025 15:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1762211087; x=1762815887; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZH0fDpUKrbZ7Y4RH7y1khfYrGo0F4yDKdY+imctMyp4=;
        b=bGw+++mjPYnWZOYiS6EcFjJzEyuTPJUQqXmW4FOvtqPBOG+AEaph4a7eceAvZWI8sN
         R74TLprWSn9DqgtcHyPzPf4wf8FG9rBlSIZbYpVeKH91J9lQiGihNuLD2YemdmX+AfI0
         vxH9nHyZHQoa5N9Z3rudNTHD7bXvZuu2Kaums=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762211087; x=1762815887;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZH0fDpUKrbZ7Y4RH7y1khfYrGo0F4yDKdY+imctMyp4=;
        b=QYMUBoiyWM7eb6u7/TuG6/G33HYGLcYJFP9U6sm2JSlUcf7sAkIyi685kdDPmErVhU
         scQU4nohSIckzd3OYkNilUpTiE1KQ2C8lmeP+aB0jHMwPOy3uwBRIX54xL5Oz1ZT7drv
         PFFxmpUAHUW0ku9x/aF07EropTqX7K1k5AjU11YZSKNyukVPE/AYtezwNSk2FqmMQF78
         VmwcehLiX9tZJyRZIlUMKrsR2PRjc0BNz5sx7Kdt/lxF+pcTXtTe3CY2KKXnsnaqAH+m
         F7u3W85pvTDObgLV3avRmuyPIA4DdPgxrsD9V8soP+eQOOqqLxX3CH3D2ZumXR4EQBzB
         g6hg==
X-Gm-Message-State: AOJu0Yw6pHBDAWv4COAlNnbVGRayHR1sfp8fsxHNKU9jvQqpcZ6Akply
	XXA4UUzQmmGTyHV0WOpfmGIg9EMfUvFnE44Vz2ZcdNE0a1hA5QXeFMFIb+rh5BUcpJqjg98RLdU
	hDKeFdCVjZg==
X-Gm-Gg: ASbGncuatfy94joviztXbMkj13o/RTIa03nxxqFDtp2nGaVcVgPLNDSudfdsN5W4Ryi
	Cc49zM548C5PXCEgQWRrjh1afs7M489k3Hj+MJ48v3QIlSlcuR2QiM0iKLCaUPTUjUTSzPREyaL
	ynprAiuqM7rglBS3gR/FoZ+p+geDcvZwPqbTPoyChKm7eRM2s0Ft885VjhgP3+xnCqobuZunAsS
	O5bSBlPSxWjUtKntkLQVTn3mRbCUbaLr0JV5lZl8DeHZkwrJkmG6gBnJ57HYjh4v4OCr+AXKdQl
	QfM0IzS6HMu6rak/9yYmZ7lHmOzoSWasVZEUjFNiLwuzSgXobAjOXHggN14feQ+kwKCJn9rpTgl
	HJQFcrkD2MbhPxvdB5ApPFIDMpAW3BsSOuuhb5q4/vWKvDO8ztaVdfJcZvt9XfDVKLtvNFvAhn6
	ewn6ZGnk2buNCa+zwf/WtGDqW5r8BFEfsh9vMfQiDTq58Vw4iZ3g==
X-Google-Smtp-Source: AGHT+IGQzwPxzyVnzGiseKvKiaupK0b1a32fWXvlmQfympctnSpp1JcjbvfCwX5uuV3vwKn1ZBl3MA==
X-Received: by 2002:a05:6402:848:b0:640:c062:8bca with SMTP id 4fb4d7f45d1cf-640c0628f7cmr3971154a12.18.1762211087488;
        Mon, 03 Nov 2025 15:04:47 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-640e67eb96esm546139a12.1.2025.11.03.15.04.44
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 15:04:46 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b4aed12cea3so892266266b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Nov 2025 15:04:44 -0800 (PST)
X-Received: by 2002:a17:907:1c28:b0:b71:854:4e49 with SMTP id
 a640c23a62f3a-b710854688emr499540366b.56.1762211084280; Mon, 03 Nov 2025
 15:04:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103-work-creds-guards-simple-v1-0-a3e156839e7f@kernel.org> <20251103-work-creds-guards-simple-v1-14-a3e156839e7f@kernel.org>
In-Reply-To: <20251103-work-creds-guards-simple-v1-14-a3e156839e7f@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 4 Nov 2025 08:04:28 +0900
X-Gmail-Original-Message-ID: <CAHk-=wiSmez2LFEpM05VUX=_GKJC8Ag68TJDByVPO=x4QwjyuA@mail.gmail.com>
X-Gm-Features: AWmQ_bmQaBgs1Hs2Yx75LVx_L0plRwfdpBhmjm5wyWf-G7aoJOGX7gmwXWEf8f8
Message-ID: <CAHk-=wiSmez2LFEpM05VUX=_GKJC8Ag68TJDByVPO=x4QwjyuA@mail.gmail.com>
Subject: Re: [PATCH 14/16] act: use credential guards in acct_write_process()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-aio@kvack.org, linux-unionfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
	cgroups@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Nov 2025 at 20:27, Christian Brauner <brauner@kernel.org> wrote:
>
>         /* Perform file operations on behalf of whoever enabled accounting */
> -       cred = override_creds(file->f_cred);
> -
> +       with_creds(file->f_cred);

I'd almost prefer if we *only* did "scoped_with_creds()" and didn't
have this version at all.

Most of the cases want that anyway, and the couple of plain
"with_creds()" cases look like they would only be cleaned up by making
the cred scoping more explicit.

What do you think?

Anyway, I approve of the whole series, obviously, I just suspect we
could narrow down the new interface a bit more.

                Linus

