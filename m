Return-Path: <linux-fsdevel+bounces-10695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9910C84D730
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 01:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3939128723B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 00:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49F011737;
	Thu,  8 Feb 2024 00:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNur+k/h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B933A2E620;
	Thu,  8 Feb 2024 00:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707352516; cv=none; b=AtKnL+lTlNswqxBQl1dtXPJbULmVYLD0VY4qP9zuylq3GlEvhtreCMcntkDcm/fJNR1QqAucrLyqNjV9WJz2Xp2grC1vLAAmvatiuDSx6tcC3q+4Jiq5qLhei5y8IeU1MD2hHrydeBIAKZ1SzYWcw5SIwS5qyue39Am6bsZuEVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707352516; c=relaxed/simple;
	bh=QwFwu90qXMZKo80xbUh+cHprXjABFxqPFIT9ZDFwzB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JFiinAchnxzIRPw/8y0ETdrQmKLimv2ragXMB4vB/wYfMxqZLUvdppGZ6rAqka3WxStX5luf+K+QaWfcFH2M2WYWsSN7Ea9ZrAev6GsQcbG0JKwQBGNvLHlpdxFMYKSbMRAKu7ExvIPwdBOjRWGDK3j+em78x4jFGkAdd7g4JjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lNur+k/h; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-21922481a2fso888899fac.0;
        Wed, 07 Feb 2024 16:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707352513; x=1707957313; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UOCijQSPH+wPzVl3RrjASTMUXXfvEmeqInHp65M9mXc=;
        b=lNur+k/hzsB9/VHeYS5Cq3HJAhq2Ad/ZysFhMJxuL0ndaq+452abU6mqw7Q6uQuBxS
         O7Tgm1TIS0+h/wk01WK0sgKYSSHlXmxuIerFic7jrfx2Eh0+3QfMyMISJTcJUYi+WP8B
         PTTnP+OnTi5oV39lS9kOpo497DjSmucoe3NEJ4Oss8ZxCu08T80fv7Yk1CaaNJt5eqtY
         XEtAe++iRgJlqXmXQJRRVGbP5qfznGB5UTk5ZbrNasraTQJESwoelCJkxBNV3InRlZ9A
         pHk5H6q1x5q84aJMv4n/bXFQtIPfCnrJOU8jH33mzu+W3aTeZ9ZRDwLJ5Rc4GBc+6iu+
         VZrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707352513; x=1707957313;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UOCijQSPH+wPzVl3RrjASTMUXXfvEmeqInHp65M9mXc=;
        b=VUqjBPD+tgoZLl9SJBbpZ7bBAc+f/JfKp9w2n8mdOp2cugtbY0dEhwYtrr6wFEo0NE
         blr2n+2s4WKAwzju/eS3aK9IpwEoIuomBBLLngL3pMkGuMlR3XYTpP+LSKdsKzCJoQuS
         3pJnIopUPzGUiM2Uf5q4rwjUIl/nuxaTjIP77xElFz0lMIjCGnhih0L8pJNn8dm+oHVL
         UrXcrJMMOS71vsAuej3HmQSa2p8Jo0d/Rbhygqtjj6s03g+7ZynwZJWbQvjAFuPyJXWl
         12av3NdFrkGXIindDalzGoNbZKlbih3sb0gzQWaM5xKGZUIO+vyXHU4UDKsuNXoK2Buu
         rP0w==
X-Gm-Message-State: AOJu0YxRfXAqgsEX9jZcq+FetyC0QTsl+3Gz51rsC15eJgGsovelfgPy
	53c4qryQMPBr6prmonzvyHjg6s4oFzWH89eAKhrks0muwJPBwdfW
X-Google-Smtp-Source: AGHT+IGp0wz4AuHggt3cb71VpoLTkrbwFAcMhzBsP0RfWn58p5xm+w3AClnC1YzGSdcz4MMzYS+2gA==
X-Received: by 2002:a05:6358:d38e:b0:178:dad2:f32b with SMTP id mp14-20020a056358d38e00b00178dad2f32bmr5089300rwb.4.1707352513510;
        Wed, 07 Feb 2024 16:35:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU9RjD5gW8oQxnLyXDcVFaEyUnXEFQkJhfMjY01H1sNRHFntSRYzT6BU7Dku+w1gKLWWocbVYYJ5oqolJzyLAaeDN1YedvkJoeWEt4JMeK8GslylwXqKOvaGnto+kg6BSJcKflajl4Xoot/Rs2Z2+jwaZLXUltaQLYhR4EoJUYPZBCYdvca0qBdX2sQOwPZcIXiOak1bAXtDx2dCrNDtUj3uh5SKAK+UXREecjI39lq+3xMhzlOKoxSjZAAZipzz+SRfjTjq5q7JDq0QvHMjpZSnvRBuI8hpU89+YovCNkNrA1i3taAQxouaQp/Id55IzqqvSvAruJLVIqKUNBI4D8yw/dg18zFHJFJOhLA1bhOnjlE+/ueoJOas24KqbzTKTAVA+MZsVFXlSdCWfbwhBdzJCquL5rPDLDBOt6JrIi7QpwvhF7RVDGq6Hn/aZpOjrA5iIUaUBP09F0/CqEhczz7Komaw8j5UUMxmb2HEbJljihzgqdkGOOM39JrSEDheIAf+QKCNyGDOd0HptLxOsHQA+ZnYmVZM+crgzTm+yO9vlBGn4Evog1KN0A/rFoB/0mFEGdijAHwA/VuT4rnYxpKMZLyLDTzMzoRD19esoRd5ceVUjFtWDIeO+1N3Qi0/Sl1302UHrHDaYrDJz4UwQhX8ufZrYDniKEIkdlvqL6CBI4H2Pjed+o2BJZnU965Ik+eHwCWkOC7gnAYnEsAcnmnL8Uz2zC6AxIR5uVWxF5FMfIIvRXi46veIa0eujf3HUguHD+Wj1/KLFftkWQc9SzYf5Qz0ZyOcrXDSYPUuM/FZtKXMK6hNVrE87I=
Received: from [192.168.54.105] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id u185-20020a6385c2000000b005d8b89bbf20sm2272021pgd.63.2024.02.07.16.35.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 16:35:13 -0800 (PST)
Message-ID: <09db8a4c-f471-4ff6-aa14-864697772bd0@gmail.com>
Date: Wed, 7 Feb 2024 15:33:25 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/9] rust: file: add Rust abstraction for `struct file`
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
 <20240202-alice-file-v4-3-fc9c2080663b@google.com>
From: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20240202-alice-file-v4-3-fc9c2080663b@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/2/24 07:55, Alice Ryhl wrote:
> From: Wedson Almeida Filho <wedsonaf@gmail.com>
> 
> This abstraction makes it possible to manipulate the open files for a
> process. The new `File` struct wraps the C `struct file`. When accessing
> it using the smart pointer `ARef<File>`, the pointer will own a
> reference count to the file. When accessing it as `&File`, then the
> reference does not own a refcount, but the borrow checker will ensure
> that the reference count does not hit zero while the `&File` is live.
> 
> Since this is intended to manipulate the open files of a process, we
> introduce an `fget` constructor that corresponds to the C `fget`
> method. In future patches, it will become possible to create a new fd in
> a process and bind it to a `File`. Rust Binder will use these to send
> fds from one process to another.
> 
> We also provide a method for accessing the file's flags. Rust Binder
> will use this to access the flags of the Binder fd to check whether the
> non-blocking flag is set, which affects what the Binder ioctl does.
> 
> This introduces a struct for the EBADF error type, rather than just
> using the Error type directly. This has two advantages:
> * `File::from_fd` returns a `Result<ARef<File>, BadFdError>`, which the
>    compiler will represent as a single pointer, with null being an error.
>    This is possible because the compiler understands that `BadFdError`
>    has only one possible value, and it also understands that the
>    `ARef<File>` smart pointer is guaranteed non-null.
> * Additionally, we promise to users of the method that the method can
>    only fail with EBADF, which means that they can rely on this promise
>    without having to inspect its implementation.
> That said, there are also two disadvantages:
> * Defining additional error types involves boilerplate.
> * The question mark operator will only utilize the `From` trait once,
>    which prevents you from using the question mark operator on
>    `BadFdError` in methods that return some third error type that the
>    kernel `Error` is convertible into. (However, it works fine in methods
>    that return `Error`.)
> 
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Co-developed-by: Daniel Xu <dxu@dxuuu.xyz>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> Co-developed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> [...]
> +/// ## Rust references
> +///
> +/// The reference type `&File` is similar to light refcounts:
> +///
> +/// * `&File` references don't own a reference count. They can only exist as long as the reference
> +///   count stays positive, and can only be created when there is some mechanism in place to ensure
> +///   this.
> +///
> +/// * The Rust borrow-checker normally ensures this by enforcing that the `ARef<File>` from which
> +///   a `&File` is created outlives the `&File`.
> +///
> +/// * Using the unsafe [`File::from_ptr`] means that it is up to the caller to ensure that the
> +///   `&File` only exists while the reference count is positive.
> +///
> +/// * You can think of `fdget` as using an fd to look up an `ARef<File>` in the `struct
> +///   files_struct` and create an `&File` from it. The "fd cannot be closed" rule is like the Rust
> +///   rule "the `ARef<File>` must outlive the `&File`".

I find it kinda odd that this unordered list interspaces elements with
blank lines as opposed to the following one, though, I don't see it as
rather a big deal.

> +///
> +/// # Invariants
> +///
> +/// * Instances of this type are refcounted using the `f_count` field.
> +/// * If an fd with active light refcounts is closed, then it must be the case that the file
> +///   refcount is positive until all light refcounts of the fd have been dropped.
> +/// * A light refcount must be dropped before returning to userspace.
> [...]

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>

