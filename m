Return-Path: <linux-fsdevel+bounces-10697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE52884D735
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 01:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A56E8287137
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 00:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957FA3611D;
	Thu,  8 Feb 2024 00:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqoq3rDy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9322C33CCF;
	Thu,  8 Feb 2024 00:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707352531; cv=none; b=CNucogsCiNDqNEEhkHtUnW/+2kQStDbqXeaTtce+jo095m7djZSyobIj9VudOoeneP5C72qEu96GzJ1sZ5SaOgRcEK74aoAxVqnItLhc3qG6s3UxP1tZFCYwFPdqXnL4fg7mzOTKMXxmtYI+A3b/9ceP4UADE0+i4DP6XJQvruk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707352531; c=relaxed/simple;
	bh=TUUZk3tR5UY5fnRRuIIbhGDqSXw+wRQ2Ef+4Qisbo2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KjezCggEECvUd+fF08FVjn8ysoNjiaQH567K9sDrqF3pfrl6+UJ2SehUs8BQMXzj1nqy8bUkB9GsCK4Rv+V8zYr+k5gqhcRhoSiaqqfrzC/8X6pJWK+m/WUp8t/BrfNV2TrRufo0NSmnqnGvRolcWmT6Tkz8nzo4/WakUekWyvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hqoq3rDy; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d95d67ff45so10463045ad.2;
        Wed, 07 Feb 2024 16:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707352529; x=1707957329; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=elheLIgCjBTJFlqpMnLawmYTo528C44XNCE+wil39mk=;
        b=hqoq3rDy7ND6UsB3Di2MILFogF1gxnTbBQdO9X0xxDMqKF6Sl7/Nj2GsDrZvkXBMYM
         qxOIy5ghnJnvswVd09AI+91ovjQAyOCw/0LWUEyLtJKPSYnfacmVyAtzB8DIeK2HclxG
         sgE45jFV849dsQRI/0Pbn9ZtP11ZESH2tcPFdhtKN9N4IJo0+VPgg+1BAguP++U8sw2U
         XVt9TDYiVAPCL084JIu9mSu5LWCNYaCFGMNU55n31JaD+MRpfpbFjFk/6EwDt6xSBHy7
         67re5R9liOcVKMOnyN2o9EBDnI/9v5pH+7LlkQaZB1zwx/yqxG2bHzMkJ0KjBiH1CNjk
         wwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707352529; x=1707957329;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=elheLIgCjBTJFlqpMnLawmYTo528C44XNCE+wil39mk=;
        b=ELp6L//I4TIgumx8TgtNyyvouyjGySzxVzVruqiBPVgQaU2CTYTX7Qod7OpC2fZ7Qb
         EiW8qZM3m2yVVoZLXmvypMnVd/Q0e58Q2jRfBM/86+I8vnT4+K+2lMkVRpySflYN9qM/
         Dbe3Hf42eSKR1Rc0QsvvXm92Ku+B30qT+IbNP2g/UyCAozSsK9ZUb7WUfycBsJFzPZ2E
         KCSUi7lfGY1aHFO6DrYC9ccR4cZetfp7iUMtV+Hj70VKu1eIvAlQI18RcylHwCb9rlZz
         oSJReVwjHZxevEHZwqTbIvAENqErmnhYKGWiEj0/ZPU0rtdFlygYVlYbo3F7q4dRmUDb
         85AQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsOPyGGf1sXEia+huua3TVsbG298MGyIfibKVgMaf4P5F8Gr0uqASjUo7pR9lZcNdFq073x+ShsiTPmAbdhjrmrN1DnbOiZCdJyhiBFEjEth/Sxx5ZWd64bkrnXVhd04ydDwRFoc5EjnZkNrxmrTTXc8p75DSI0QI+oI4VRa98QGnZ0unBy3VhcVeY
X-Gm-Message-State: AOJu0YwZ/Vh6F/r2oAoh0wUgfMo1drbGTtzSSkWRPWZPYAi8PgbF5QQU
	G48Vgk8vEz5Q1gbAyFMhj948ng5GC2CeAeAzYE6Nshug+3oU8Qj4
X-Google-Smtp-Source: AGHT+IF2pTrjLmmcyBV6ENGFRL8FZfGc9udBA3jz2Q6a5CmaCyGc01uDxFfjMV9SHa+GvfyMvbWOAA==
X-Received: by 2002:a17:903:40c3:b0:1d9:8ddf:5fa0 with SMTP id t3-20020a17090340c300b001d98ddf5fa0mr8439590pld.62.1707352528730;
        Wed, 07 Feb 2024 16:35:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVuJTt+QkA58Dd9Ev57u98IX9BlQdsXvacwu3CBtOmfp+sAqCucwnZoVSDDJV+pSf7plyU9kflwKqgodH7Lpppg/3+q1FTU/jJBptvl/WjtyUCG9KLME1nPhr6pfU/GsjtkpDqhn0Z8ppo3+C6HhdNnhppR3Wog1lY3pR0vqtPQm/m3PUbXJiS1ve29gxHyFCXNHlDURh2uVuUUMXNaziUU1bog4qjbvgRT2DqAxVfcmbBrcoRbImNixEDClUufIqpiUClzj5I2jFaPcg75031bRMZg0ocZz5k7Xmc94wgkvqUljX7swsY50HyR1lRi9503cj+IHjaoHaOuOJGauufdCYjF2x9dc72zfDCWriXb8xIb0pqrv+uxV0dGHRg0nb+jcRvpoJUPPQSvy4Wp0k83HH8tFH6jGVV8/PZDpwJ7VLsfsIcmvuQPRCAy4BvCHXlibIlTLOZVuEAppdQX2YAOGtj4TtuLjoP/QrgGJz+tGfoIpBaOZ+cl4QSmjxoJmJ/3/km5VYxpX2OF9gOgk41h7OFp/VWC8qLAtjfncT/ikEKGDIjoaBMpAP2e3fGswGm9Pqupze1hINXN+s5ldVRwsU7HNVFs0zI+UZgogTlxa4dv1ZUsH2T1nlq6aN6y2NdtIBsSOKHcWG8ssWT3siFF5HvPXOpKGKpCEa3eA9LMBG8ndy5V+gn5xPOcADAyeJsppeLyKItOxn/DIjgviLfFLnx5nwBf6S4ggn4uaCibp9EikuPv9+H79iamx0/m058cYGTzavnyxj3GSnDqL/MpXBkKbQisnLBmm4C3glQowzQ0GkWrXMwKfLg=
Received: from [192.168.54.105] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id i12-20020a17090320cc00b001d8a93fa5b1sm2080420plb.131.2024.02.07.16.35.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 16:35:28 -0800 (PST)
Message-ID: <ddc0d7f5-b63c-4f75-8f4d-07202950a4ae@gmail.com>
Date: Wed, 7 Feb 2024 16:01:00 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/9] rust: security: add abstraction for secctx
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
 <20240202-alice-file-v4-5-fc9c2080663b@google.com>
From: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20240202-alice-file-v4-5-fc9c2080663b@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/2/24 07:55, Alice Ryhl wrote:
> Adds an abstraction for viewing the string representation of a security
> context.
> 
> This is needed by Rust Binder because it has feature where a process can
> view the string representation of the security context for incoming
> transactions. The process can use that to authenticate incoming
> transactions, and since the feature is provided by the kernel, the
> process can trust that the security context is legitimate.
> 
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> [...]

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>

