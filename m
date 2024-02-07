Return-Path: <linux-fsdevel+bounces-10693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF1E84D72C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 01:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC730286F9F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 00:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612841DFC9;
	Thu,  8 Feb 2024 00:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PaFWtDKC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573DF1CD19;
	Thu,  8 Feb 2024 00:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707352501; cv=none; b=ifYUpuLy5SJ7xa2OqDeYfBwx/Eh3REzlqOLXBvej+PQ161AKMVIj1/9uu5LnHC9EUXIMWPu/4s2dvVm/Pd3uGTwtCB4UztRgRmKylxkaxptPLkXIRjAw2/+RcNRF+iJd4Xdnw4u3eK96t/sQBWus9fwNTp6Wh+42ccbHpGRrcpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707352501; c=relaxed/simple;
	bh=SvNqjy8xbobMF1LHRj00G2W8Oc3FLp/wPHfTo7pUtfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YOnaMzQW131b5gecUpocWGD1V4Slb5vpkSzFrcpEFpgqzyQJVHPB/OYLgiYljmVxpXRZ8FUOJAGlTVXx7woowLOJP4uga5LlgwOGF7u/aQT3ADe2zh6oVRT1tfymzLxf6mMNQ/b7GvVRenB+S0pvWOM3oW40OqwIXgk0qix0xj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PaFWtDKC; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3bbc649c275so743330b6e.0;
        Wed, 07 Feb 2024 16:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707352499; x=1707957299; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/TA9CO95+kNuaN76uKy04tbHlP8Ka9lRnshWVIdRkKU=;
        b=PaFWtDKC8ldBikfebxYOVTDKKzMUMdU3QvZlRWZzGXtCsJ7I0D7ZvryXNxvZyBpikz
         ZuiOUT2GZIgzGKV03sSoM2f8mz3WmGD47Z36KdoaAjARczTyoOI5CtqmcCBk0YVN2acF
         6qoI3pTLFwUYxXK1EaI8mKw/JGTpvhXeSOhianMT7K1i0KKwXuygMEv6EetawHuITTaJ
         SkzYe8Zl9WgkaisyLRVuNbSCBhrNllHkLvxgE3sZuxok5cb7hdMSZoP64bs3pjN56eDg
         YLVoR9taqc3L5pTvYPCUZg4NYGFzq5KR0w7M5dVR+8a2ia7oQS+4+GWcO+nVsZbeV7Bc
         Lwqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707352499; x=1707957299;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/TA9CO95+kNuaN76uKy04tbHlP8Ka9lRnshWVIdRkKU=;
        b=H29SVXz/WLksKnqCo+GsmAs7JRdAYO486ex+USKu56DzvLcXXsKh7XRV0CEWrFFRoP
         rh+9ZMH5b9a36XWzik0D5rfbLwExMWVmQMQQaPucLxUEUdhfQkfWnYjQfqRZnZdOoZ9l
         qXLdK62xJvAiWZviGbPAlRcc1vGyqJKM40FCKrU69NgmP/U9ee0ySuLPvZYdc7sw3j4m
         TpDcM9iTkHrKYPnlkohSNy5GM+F5+HHRWsi7gw1ZImOuQazhWEnf9pvBxRykWHynNW9x
         Cn1X5TqH0OjPP02MKbKe+JzXTyqhPK7AJc2YAHYpCJI6RRdX/vNZXLuBNuiylr+PiUXi
         g1AA==
X-Forwarded-Encrypted: i=1; AJvYcCVJw2Jxo1WOCwcdXdl1QRevGrGLMeSeuevZYDtQBXAYSnj4u8ezuQXL4c7b63UDz7DZXD7LR6jLGpZAOyyspNglEaQwyD9EO8m6sKNs0R55+0E+6ICBhIMuUbvRAaeFELZKav00nOLDebOpLuoBngmsJyvS5w1wlYEl7YyN2inMvwOG/HHkd5eBtgy+
X-Gm-Message-State: AOJu0YxOzdvjtGE4NBV0cQtCmK0L6HTl2SZ5bAU3DZy4MfQP9NPgSOHi
	fHrW4tCjjcDMIHzifAng6ryhGd1g6B+3JusKYIx/gxcsLd61Ek1m
X-Google-Smtp-Source: AGHT+IFUAgvqQ7E87ra7u9hZQ1mEEo26LctKz2cvgTvEkvHl5Wg7KifAeaaBMCN84yr0y8cMLyMS7w==
X-Received: by 2002:a05:6808:148f:b0:3bf:da5c:37e4 with SMTP id e15-20020a056808148f00b003bfda5c37e4mr8745339oiw.8.1707352499181;
        Wed, 07 Feb 2024 16:34:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWoBN043EZ+dasbkx+0gHydIdb1avapkSJHOL+/2wfbYdIfvolvuULbUJ5DQFkYdLnS6Mp6IcHG3sA08gEKZwAK2VN5dYgoOFA7USXopXDvHVTjsQ3GBYxoLoOi67+WCK4WxnO3jE2tdGuF1N0+wRZL/EKKgpalC58Bm2laKUue5Zp9ZxGRcJQ+xGdlxmL7e2zVuPlKBrWPUwfTB791l5x+wYIUJ7vmlzIa9MQ469faVc7/SPSLvmJXmGmFwW+IiSTnPvbEdDUbiWMZDxY/hXhYbLZU66ucM3PNYKaG8eNo1/0k0H4KucaNc4p1i6JXpEHvmGI5ArJg1kCeH6kNjw7HctS9uvgFMvLg04iJYXhWKjf7MEc2QEZh5YxlE+vUJuTieU8klX5BoOKb2EcXGS9SIgdpini9tcaYKkyjmn1UnQDtoCDaf2TNXkClxZlfGSuFna2NoeqEIPAaki6SbTz97+6LmqTajztabJ5uLAMk2EjLyB2Z2yj29Gdfb+0tUvprVwZhJwCx/AU4IAqDCu5GJsS+GfsPCzLn0+C0OpM6sRS9AqNIV3xY/3T1+I9euFCRoKKFZoW4j3orcl+D/oH0AMfeoPzKRudCJAAXvT+Wjf4GSDounmgFRczbbREgsDGMyyamCBnjyXDgD19vcgMW2xTtUce6qOspOpGV8W5h8twyzGjlahWeO+1hsgHLrG1GOHgxyO0IpUw3KjmRfC2d5qaj0Fx4EPhsOoR+olGWr5dX1u6xJ5kXVl2ytRwwCcrhHlcPeU/4XlQQDIFBAG/iCMQhfExn+52grbuQR6GXDZ7lW3ZgcnJadqA=
Received: from [192.168.54.105] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id u185-20020a6385c2000000b005d8b89bbf20sm2272021pgd.63.2024.02.07.16.34.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 16:34:58 -0800 (PST)
Message-ID: <c6bcde7e-af39-4de2-b77a-781ccf80c854@gmail.com>
Date: Wed, 7 Feb 2024 10:22:33 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/9] rust: types: add `NotThreadSafe`
Content-Language: en-US
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
 Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas
 <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>,
 Dan Williams <dan.j.williams@intel.com>, Kees Cook <keescook@chromium.org>,
 Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20240202-alice-file-v4-0-fc9c2080663b@google.com>
 <20240202-alice-file-v4-1-fc9c2080663b@google.com>
From: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20240202-alice-file-v4-1-fc9c2080663b@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/2/24 07:55, Alice Ryhl wrote:
> This introduces a new marker type for types that shouldn't be thread
> safe. By adding a field of this type to a struct, it becomes non-Send
> and non-Sync, which means that it cannot be accessed in any way from
> threads other than the one it was created on.
> 
> This is useful for APIs that require globals such as `current` to remain
> constant while the value exists.
> 
> We update two existing users in the Kernel to use this helper:
> 
>   * `Task::current()` - moving the return type of this value to a
>     different thread would not be safe as you can no longer be guaranteed
>     that the `current` pointer remains valid.
>   * Lock guards. Mutexes and spinlocks should be unlocked on the same
>     thread as where they were locked, so we enforce this using the Send
>     trait.
> 
> There are also additional users in later patches of this patchset. See
> [1] and [2] for the discussion that led to the introducion of this
> patch.
> 
> Link: https://lore.kernel.org/all/nFDPJFnzE9Q5cqY7FwSMByRH2OAn_BpI4H53NQfWIlN6I2qfmAqnkp2wRqn0XjMO65OyZY4h6P4K2nAGKJpAOSzksYXaiAK_FoH_8QbgBI4=@proton.me/ [1]
> Link: https://lore.kernel.org/all/nFDPJFnzE9Q5cqY7FwSMByRH2OAn_BpI4H53NQfWIlN6I2qfmAqnkp2wRqn0XjMO65OyZY4h6P4K2nAGKJpAOSzksYXaiAK_FoH_8QbgBI4=@proton.me/ [2]
> Suggested-by: Benno Lossin <benno.lossin@proton.me>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> [...]

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>

