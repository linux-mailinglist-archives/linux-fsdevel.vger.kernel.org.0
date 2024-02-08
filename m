Return-Path: <linux-fsdevel+bounces-10701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB0084D73D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 01:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DE041C23FD0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 00:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A141E21105;
	Thu,  8 Feb 2024 00:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8kFwuEX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895542030A;
	Thu,  8 Feb 2024 00:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707352561; cv=none; b=PgwHO6LE9sKJiOTfiOCxqZoTjIaS047AhkBmH5R0PvIAA182STLpQDqVStxOrpiOlwno3dpti3ZaTbmTuNMwCqpaYEYTxRaByDz40kLabJYYrOVSIiH7T5OSRhSc9kfZpjgZ2Fagb68h8b0ndnCDR26pTJfuDPBWsXqs5XD2IAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707352561; c=relaxed/simple;
	bh=+y7oicrv30c3WDLX2rBtWbOjYhzVnD8McTDPm4HPeQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aBq6aLHAC4u0XLyKqVU+JnNVYlcPsSaAUbRPsNhLyESIAzTLgeDtkTNtG+fvXRLHJVAS7n24uiVPTYu6u25bLfH0vpUW1EQfE+WJtgVigpoo9ZurXFJF/6iz0ScxzWI32w0T//50u/QvCTz4VRvpO9wyUai3r6TdZrfGRgZkrTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8kFwuEX; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-59612e4a21eso655704eaf.3;
        Wed, 07 Feb 2024 16:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707352558; x=1707957358; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yPOhkBaKkb2xYWfNkbRlFQsv4iwsp3aRN92FeLJqKDw=;
        b=J8kFwuEXIczRDVDdkKuV7+n/Br6T3bbNsQqgz9m1sOCLE8E6LYvVju1s88Lz5360iO
         zqhsGcGN4CQQBeoMHs8jrIUxyDbpOotzLTy0BmZY7yI79dgb8+fZnl6u34tJBwiibnnl
         zcJY+N6628jqbs0wsoOPR3DzXdpH9exVdVvISgZtRRWwa5Rcyynq3lfPRGGeeMi9Z3sx
         hy8XiT8aZxaAIx99Qe08GhgcfDpPEEhDMvXGZ2AIjhPBStydGkZJ5PR+CtM970Ic4zh9
         XM2TpFSb3LTZ1axjQMto0QRwRZlo89TW5tWEKt0jf/bp65Y/NQyHUoyrpdmXT2aMeueh
         VxtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707352558; x=1707957358;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yPOhkBaKkb2xYWfNkbRlFQsv4iwsp3aRN92FeLJqKDw=;
        b=w5e/zF1RttOCAcsrvNriGpIyEZ1Hv9VhYr0/T3HBlNLsvaVbQlg+qTo5soTPyw6uvp
         zyADJVSxtx1ZImF42s9zKJXpI/z7w4dZASNpGdXXbSqlcdBSEa/SrxNiNVNrsp9qZ9FU
         k2u7GoaBU1fNeHOb4QxagYeC+c69AJqYrsOwiqbz7H0Z3tsHQD6MmpguJk+D39ydY+JE
         VP09ESQF6l+QnrjRwW5TIZsXf3ZFjbLcTtbFjHuP3UyetfkRgFgNEAenPvpZbbYqW2zs
         6oqhKnWTwJLl8Vaph7DYb5MYTdAcf4wMlQwO2iwRAQLRwDjPn4LfUERyHy1fHBjvvePN
         S9fw==
X-Forwarded-Encrypted: i=1; AJvYcCWxx909BBLyDcqEBOdJrk+ac7Dt/XDIpCjAS19L1kY7NLQ+H/9p0XrUta8L3GUrzOVSToaFDYeiGKGBWRaE45oWRIG35DjB8TKKuoP+MxhEDQvIs4EhdqGS+8j38Y0lQ7oEKKS39THvl6CdI5xAgCFwJiHd+EBlSeFJqBDTYMHQtkiRNs6tKsG81WIB
X-Gm-Message-State: AOJu0YzzJ5ohdy5LahQpKzRwl2AJzwZqizqlGLi38+/6DRd51e95B49s
	MQmJD42WhLDRMxnzpp1FpdRgTQhHbSLJKC8ADY5RnDskjgKRy5LC
X-Google-Smtp-Source: AGHT+IEpQ0xhM8FwBsmbspVVbp8YAsYk23QuroDUtmPxxQtRhoyyNfOgaP0fXSV84oNzlc4KUqVY7Q==
X-Received: by 2002:a05:6358:93a8:b0:178:8a23:f431 with SMTP id h40-20020a05635893a800b001788a23f431mr4044142rwb.26.1707352558483;
        Wed, 07 Feb 2024 16:35:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUqSawohlr9Roej+TpQHydV2r3gVJRovK3Y503ZMJ0G7vUpbDXFPHIivqSLVxmg+4tssCPi1iu3zMLxtOWbqt49adh76p7UW/ggMr/mO5SAKTiwk3gAl410YODh1JzqFOSZvH3aRvTv5tCt42yzmcPNX+Zh8hRoLjkHX4B7r07Zfi2sVZPByyrC/ZBrpDlg346Y/Zp0mFaaaBPx6hbtb5G/UiEJCwqrNZBVdgwOjRr06EMsP2igVMW/LhlByDzVuwhwSo7S3b9t+NL2do6ETrjVwy5ZjqdwYJbUvdg7B/y2XYpltUr5Hh1r3FTKZ0c+JHNIvjVrSnjzb1N92euLNl2jg5Jv667aL6B1ESPtacMXwfj1sT0gmJdic2feV9cuGWwS9UtLVjuDCH8JpD+yBkfVBB/pha9jfYrvx4X4ZW6jHHQ0zM3bAxI295ARRcXlkUx/Z5np/mH83bJ8mPZebU4IZ67ko90zt2rFwYGrzus40f/cNfRAHq2LUGIJWLo9UP3bUdQu1D/ip1mSgWiFWbJbnS43v68NlxJSxWwbC6jVxRDEB+cK8gLIxu1H9CuLXm5vJxCcNubiCZmRClyvrPLKEVjlX+KGtQuHjBjQjdeyBmY7FTdEfktgwCzbDo2JzBkGnLhCuKepLchBIdQS8GMTwsi1Thi0SkPaYjiBgp8cMGBWCdL+9KKC3//Tu7qzWeW08RudRj7DlRLlmjbimX3hjvzTnI591QM4yaMht834mXS26nM/T3nxhcpwHlGAOTV2rISw9WsRAOIdr1QgNfCYQy6OKy/v8nHsb2QZgKy5P/lpfBRzON685NQ=
Received: from [192.168.54.105] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id i189-20020a62c1c6000000b006e05321ac81sm2356740pfg.28.2024.02.07.16.35.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 16:35:58 -0800 (PST)
Message-ID: <7684f4e8-8dc4-4abb-996a-12b48aa5998f@gmail.com>
Date: Wed, 7 Feb 2024 21:32:58 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 9/9] rust: file: add abstraction for `poll_table`
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
 <20240202-alice-file-v4-9-fc9c2080663b@google.com>
From: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20240202-alice-file-v4-9-fc9c2080663b@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/2/24 07:55, Alice Ryhl wrote:
> The existing `CondVar` abstraction is a wrapper around
> `wait_queue_head`, but it does not support all use-cases of the C
> `wait_queue_head` type. To be specific, a `CondVar` cannot be registered
> with a `struct poll_table`. This limitation has the advantage that you
> do not need to call `synchronize_rcu` when destroying a `CondVar`.
> 
> However, we need the ability to register a `poll_table` with a
> `wait_queue_head` in Rust Binder. To enable this, introduce a type
> called `PollCondVar`, which is like `CondVar` except that you can
> register a `poll_table`. We also introduce `PollTable`, which is a safe
> wrapper around `poll_table` that is intended to be used with
> `PollCondVar`.
> 
> The destructor of `PollCondVar` unconditionally calls `synchronize_rcu`
> to ensure that the removal of epoll waiters has fully completed before
> the `wait_queue_head` is destroyed.
> 
> That said, `synchronize_rcu` is rather expensive and is not needed in
> all cases: If we have never registered a `poll_table` with the
> `wait_queue_head`, then we don't need to call `synchronize_rcu`. (And
> this is a common case in Binder - not all processes use Binder with
> epoll.) The current implementation does not account for this, but if we
> find that it is necessary to improve this, a future patch could store a
> boolean next to the `wait_queue_head` to keep track of whether a
> `poll_table` has ever been registered.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> [...]

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>

