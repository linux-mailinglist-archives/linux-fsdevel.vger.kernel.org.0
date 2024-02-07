Return-Path: <linux-fsdevel+bounces-10694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DB184D72E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 01:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB4551C21366
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 00:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6706A208AF;
	Thu,  8 Feb 2024 00:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TK7O0wOc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555C6200BA;
	Thu,  8 Feb 2024 00:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707352508; cv=none; b=LNHN4szPHF7avHN0ndhqc1mVJ/4qBJ9TBirMV8H8X1icZbW+Pz+C+Z2j8+aTWOL5twa3MF4mvrH1KxQNYJ9SSBDPzeLIUICiw/aZMtpkP4PfXHSVeE6B+syT2boFmYjFN0YOkWwAuAF1s8Sgvx6rueRJZA24z3o4bt6UN8lhxaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707352508; c=relaxed/simple;
	bh=b0YDPHlJ74wxKS9gW0VDTe+nRg5YS+3sVyqTQotRkCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QhkPn1R8sXxWaJ8V/zPL9BhHeeYVSFUsPOYQy6oOStWaImXgdp/bSqIvIs9Qkx1Xn6m+YbseqVE4k6n0JX/NIfafI9eKtEkkkNeV9rQoHSdLFeTu8iMsHzj2MUj2f8On01TEBwbGoNUbWy5pqmvGXeKuP+zouiHiwhMmdQcxJaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TK7O0wOc; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3bbb4806f67so881455b6e.3;
        Wed, 07 Feb 2024 16:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707352506; x=1707957306; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hI38Hxhz/DKhzR3J6Y5bJrnbITDykcSfKFPPBrtee9c=;
        b=TK7O0wOcUFAWVkz4vIRalfcmDMSuecoo3ZSJqN1oae4ZnJNBv5eAwX2tXHKvQvCJ6f
         rzPOgh3J0eoQLAJqJ7WuejUpF/H7oFjBA4AojkFYYpaBY4xtkDMWb2YUKkh3jTX7uzmR
         SVTXSNxnKSCyu3Ph+I4FbAuKzIpdQBWR8geGjVswMQ+eixFK/v1ttr9uBkT5YesL6Pk7
         k6jxSpCh+Wp8pbZwbFjHhb7I7Y/gMWDNilzjUPSs5htI8FMPas1YyXP7PlrzG03SQKLp
         +2wB+G3uQGiSfwCAdM3OZuQxzGTZhFCXYqZJbjJGaftJ3Fchqe7AObs4xYEGKjNB/rE1
         cDgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707352506; x=1707957306;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hI38Hxhz/DKhzR3J6Y5bJrnbITDykcSfKFPPBrtee9c=;
        b=m0JoyNh+sNkToxuZDfwgovC0oedH7nV/yDXfFvbq9n4Ug/zN8orj7a6/ex7WY2Eja6
         SuAlY2dcLbSgE12B3ZQxWTOlrSU5L0U5pbx5WiURa7DNuosEJh3AgjiDuH1YZi76MzDS
         sN7zZgPsUJ8FGOhE9KhxM1sLC0lbn8qE/EkYAfPX+F/KeUkJSvIY8YKB2cnKpbD6Sdur
         t0gz86WWLC9wiSzhiY8nZ0L5wwlNQuVW+rwhN9ARHla0da7+CtN0GX8bQSaIwqmNSlSk
         XupUWcPmGbcJwe3G/7bBm8TFoI6+tdJL6ALV5hHg65N+VrhPJE6+nOnku1eFji/W1cfE
         e9nw==
X-Gm-Message-State: AOJu0YwU2tby05EBc9ARhHFkkY0/bFd2TnqWyQ7LvhUkIhXx6VodazAi
	j+RCoR3OQMGPFxno72wU/qjOZ9UdzktDSl+SNbhTbJUiVHt/bh2c
X-Google-Smtp-Source: AGHT+IElJlG/w8v4kCRzsggMgSFGNcWW03/CamY0JT897Cc/CCg+MdLIO1mwJf6vyBFfq47a/Tl+cA==
X-Received: by 2002:a05:6808:13d1:b0:3be:41c1:26d9 with SMTP id d17-20020a05680813d100b003be41c126d9mr7106044oiw.31.1707352506378;
        Wed, 07 Feb 2024 16:35:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWQQwn7u5g+D1ijNWW/BGqr3/c31gYseCiJsVWshCHAD2LSX4WHcgr6Flfh4qb5TnqkU6IKlBE/saFv4wxznmlQScXVXZDxy9Zf9ZUIH/4PH8y1pKVaDU+a3aDqaxeXklTjKHm9yVBQrTELgwYFy4AOXOiexu0M7OJewfm8NpPxLzeiFgAnPhfJyTP1Cttch8FvU8AbmV0dZOSZ2uR0zDUt5dSGaP9tJYP7Xs+3QGbX7zYUJ+hod0qVvHiCqAHa7L+p4bPkOXTGOzuppmPmXhunqQ99gxaOLVUxYKeEFY2Fo78bxiReFZO3TKvhprCyALYHx4jOYVVI12Xk61suxwzMPf37E2vVUd3yolNRQqENI52vXrkJb85ssCNqnJMC2Wgg/rW9UC55plsE1wEPnlKW1pqZ/48IROv/HaYYIDOG9E1KVXsZKTUrN6zIQHdPtfUY8pqYzXp8PSh7m705gNsUbWsbupZfBSsmx6MAC7aWje/hq8Kv4IvDDJ2Jo0PfuGslqj1C/qyqGq6bWKAjA/F0HTc/wFfi50559Qa2N0GJz3/Ff8cE7lxWr8K9NPLGjOi0XYMQwDXyxHGBAHu5gRYdpA/koMEBKqqQipawuYSGFXxuEb1SDKuFKohpj0fMcFJ46ROHCRJpt/WohWYmJD/qOLlJtMRHu9g3ptBVfDCYeS766q1uv5DZhwYLGjLkf3lxuRwBTsBqVXOnai+i67np67c7Xx4GUv3Sq41GXM0JUP87kRClzj+wpmejhzen+Pqk4AZzyO+s1M8n5gwz0phLeBb8fnsrAbGnCdQplmNEX5C24iCxle/QB2Y=
Received: from [192.168.54.105] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id u185-20020a6385c2000000b005d8b89bbf20sm2272021pgd.63.2024.02.07.16.35.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 16:35:06 -0800 (PST)
Message-ID: <b7db12e9-bba1-44cb-82b9-78c7b161db32@gmail.com>
Date: Wed, 7 Feb 2024 10:24:59 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/9] rust: task: add `Task::current_raw`
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
 <20240202-alice-file-v4-2-fc9c2080663b@google.com>
From: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20240202-alice-file-v4-2-fc9c2080663b@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/2/24 07:55, Alice Ryhl wrote:
> Introduces a safe function for getting a raw pointer to the current
> task.
> 
> When writing bindings that need to access the current task, it is often
> more convenient to call a method that directly returns a raw pointer
> than to use the existing `Task::current` method. However, the only way
> to do that is `bindings::get_current()` which is unsafe since it calls
> into C. By introducing `Task::current_raw()`, it becomes possible to
> obtain a pointer to the current task without using unsafe.
> 
> Link: https://lore.kernel.org/all/CAH5fLgjT48X-zYtidv31mox3C4_Ogoo_2cBOCmX0Ang3tAgGHA@mail.gmail.com/
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> [...]

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>

