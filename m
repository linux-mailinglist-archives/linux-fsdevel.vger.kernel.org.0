Return-Path: <linux-fsdevel+bounces-10699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AE084D739
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 01:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A5781F22C75
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 00:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE75A37162;
	Thu,  8 Feb 2024 00:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWl/XBja"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E055836AFE;
	Thu,  8 Feb 2024 00:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707352545; cv=none; b=pHqlkoLAEBnUUvD57TnHHElUbU2IWxGg3ZT+yACZV2LMzuaFD1dhxwDUmAW7yBjtW9GQJi30OQ2n8aCO2y3NMWC7Cp/3mvZfjVa21VJ/rVNi0wi4eSavMR8igh4RDhm5iJ8Ica1HJZDoHzirz0X/wUjRrVIPPzJrTofL0EnUZdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707352545; c=relaxed/simple;
	bh=BNzZJSEaEd3KjDVzE+rJRUMciaZc7/0BY20IR0u7Iv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dwd/2+KRIdIrebkO8WeLmXt6LZcazB5fmLlBoqQ5jBzFewrAuH1t0XSSdv/M3UX2xsX8g7UEcgxogbq6S+JjxoYIsM8pI8hv8Qoo67p5DtFaftnYxLt9H23rkxRDWpuiUhuOETqFiODPQ/bL+Wsi5zFY9EGkRIpZiGfHBIcZqSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lWl/XBja; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d8aadc624dso10208655ad.0;
        Wed, 07 Feb 2024 16:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707352543; x=1707957343; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zyFbV7aGaS4o3jrTpqDZSDrB6jGE56Fol8SftcAYoI4=;
        b=lWl/XBja7x0VE0xRGtaL9Z8KTpFbCXb75sEPyLtKGUuqZ7RjUrbh1ST8tcTjbu7mFi
         ZpYxYTdZiMlKSg6BqDhhO5cizZhW1Vzn3Qa6c69lYt+OL0WV3xrHCRpwtPTNYhrCXQRa
         DIzbIAA3LvswaG10YrmPiQDvbP2r/iLy1Pl089gC62XEb0KDeoQXwAcZVUD3UJPp5+HA
         6fHQCJsySdnW26UlOOp4ioUVE6MtDcItguHCPYmLXx1v0DTGd1VqULB/11PnebQPaUd9
         XEtHd23rnDhRTNAQarqrOnXgK/N/Bmms/uFgmGUoYCL5OBDJXHI/8NtS8DFws70TpVyh
         A/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707352543; x=1707957343;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zyFbV7aGaS4o3jrTpqDZSDrB6jGE56Fol8SftcAYoI4=;
        b=tO/iG7wA7LWCybNDb1runrqAfWDNV8fb5DZNQHmzCWyTNTbTgWN0a/MzNfVjIdfZU/
         XRCK9mK9kgXx5UZYx6d0P+4T91h0oDgXgxgPgFlFeStLFqF31ZqbZYhYCFNSWlTRJ5HM
         n5knYx0oGUA/aNfdQUcewlc6cP7nmNNlmgkBw4dM8I1Rv+r+UnccEuPGA6gB7pSNTE+J
         x+TE7o167YYMZPmdXPznMqrBMZhDNCk6/LUvs6hwj+4x2jk4jn8VUS8kTRbYfbFrv3Q/
         +1q8GHjyVTqo0try6fG5n+QcZAyumII9KPTcs+rT+F+KdiVlTN4QMzWta5aw0ZJdwUuO
         b8tQ==
X-Gm-Message-State: AOJu0YyTRVHE5kk3q2M2t4jED4Fcmkwtp0/E3hDa5GUbSGKjjskQF3rL
	OAisPwvEmq5OULPxOvpvA1w1Zub9SA20kul9ngYLSfcVB/UuuIO5
X-Google-Smtp-Source: AGHT+IGojBAFnUw96tmstVKh9Nndf8pOlB1o3sv1FfjQIHdX1f+3Hr43CeGp8D92oZNz9guz9pIZSg==
X-Received: by 2002:a17:902:da88:b0:1d9:9f86:3c84 with SMTP id j8-20020a170902da8800b001d99f863c84mr7966434plx.23.1707352543140;
        Wed, 07 Feb 2024 16:35:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVBV3YbKbFkuYLtDzYnMwgGf3oDs7K3zY825kKWCL2V0exGJxISDr1sL8bj9Q7wRSNc5tVzGsTXfg2bfnEL4v3Q4A9v3Fww33j9LAIc16pBFbXd+ElxdMF9uGR7eVRtw8S++X67mrcYaxLKT9I/2tcAbf9qM4Az2ECCbzxF9KGv0J1m9WhNH/nXNy8boczbVd6us2hM1h7V+qvz3qUS48QG9/K8ZEs7KAXl/sA3omKQ2V46aZBoxik5IrQYf1wWbwd3fhKyXuE9qbP5JoXFz7VSb2JSawiO+VXPJOTMP6Bd0DIxp0OmawDKozJkT/Xnugjnlmv7vgVLyxMKkvkPa23zd0inK6RS2Omr3zba5bv+cJdJu5hOV1bmKCDtrf5bOA6NcSKApUn9YQUSXS4NzVLaWLBw1yB93hHk2Y+ybJEnF1TCiVUC/57kDwKe2ywMAQz+bEFy0icDGWNejl2J5NIFu7kU/7pYpY0iozomDnLR/aYEppwVgF2FWOX72VtQG7QPtD1rL/00pG11QcDXtfwKpaXyPjg2U+L8hvIgump+SdeE4njhyS/fl8E0PbSEDxf//HrKJtO4vfU6v8rKzxyjIWGhY5a8h/K9h6rKnNwq3+5HUf5jc4Hhzyo08iWlrtmQ3wVM3wf1pjXivhCgmgNGw/Skuo/WSF7GOEV9DIplUoTTcCexWTYCChJyMMr4stufjcOBZ944JH8JFYsAtxRnAeDmRJxgD5JwCH0PtkmJ+c3jRPiL30CjCElxY+JS+rs7trd+Njb/gFj86S/oamI48Rk/b9QNnlzpnxcP7ghI63NpYgtXOwgo9jc=
Received: from [192.168.54.105] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id i12-20020a17090320cc00b001d8a93fa5b1sm2080420plb.131.2024.02.07.16.35.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 16:35:42 -0800 (PST)
Message-ID: <12b5bbc8-3661-4d67-a402-cecae692e75a@gmail.com>
Date: Wed, 7 Feb 2024 16:05:19 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/9] rust: file: add `Kuid` wrapper
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
 <20240202-alice-file-v4-7-fc9c2080663b@google.com>
From: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20240202-alice-file-v4-7-fc9c2080663b@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/2/24 07:55, Alice Ryhl wrote:
> Adds a wrapper around `kuid_t` called `Kuid`. This allows us to define
> various operations on kuids such as equality and current_euid. It also
> lets us provide conversions from kuid into userspace values.
> 
> Rust Binder needs these operations because it needs to compare kuids for
> equality, and it needs to tell userspace about the pid and uid of
> incoming transactions.
> 
> To read kuids from a `struct task_struct`, you must currently use
> various #defines that perform the appropriate field access under an RCU
> read lock. Currently, we do not have a Rust wrapper for rcu_read_lock,
> which means that for this patch, there are two ways forward:
> 
>   1. Inline the methods into Rust code, and use __rcu_read_lock directly
>      rather than the rcu_read_lock wrapper. This gives up lockdep for
>      these usages of RCU.
> 
>   2. Wrap the various #defines in helpers and call the helpers from Rust.
> 
> This patch uses the second option. One possible disadvantage of the
> second option is the possible introduction of speculation gadgets, but
> as discussed in [1], the risk appears to be acceptable.
> 
> Of course, once a wrapper for rcu_read_lock is available, it is
> preferable to use that over either of the two above approaches.
> 
> Link: https://lore.kernel.org/all/202312080947.674CD2DC7@keescook/ [1]
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> [...]

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>

