Return-Path: <linux-fsdevel+bounces-10698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 995A584D737
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 01:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A28721C23A08
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 00:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D3A364CD;
	Thu,  8 Feb 2024 00:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0KUvTR8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD93C364A3;
	Thu,  8 Feb 2024 00:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707352538; cv=none; b=rFmBevZczdhkSR7L9ZsqsBR7YWPeQ/SDxvrzNPrVlSleBvZ5z4L4tozvpO84IJG7rdD1li+pD/OjXKT0GpOq880kjACOzXALRzXsPdt0net48W5Bc0k5/Bt/FnlIL9+VoFacTUzYtcQoGF0D1OwwlUgG69P0tybvGFLcKO0J6uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707352538; c=relaxed/simple;
	bh=cQVAjKcd4pRL8YhW7Xh41cD3of5aTTwqhXUTJW8cbFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m/3NJ5k8/kz96e3JvUKDvgp+6QEhqBxjUU9njs3qGp3bIK0Jiix3nC68VB7MQQf74dU1TLxEge74FpZOSrMm3KCcuA4PhSz2V0UbiWwH0zlKeax3dJziZ31fZWE9UP6+Cg28XLfrHaqgnAcTqKyJmRlXPckE9MpM3eA0rfRnyFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0KUvTR8; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5dc11fdddd6so1091388a12.1;
        Wed, 07 Feb 2024 16:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707352536; x=1707957336; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lrbbTAjaY46wh40ntuLIgBTYNQ3DLFuC4PjlSBPhSJg=;
        b=A0KUvTR8aFtobS+LMlm/qPv8e2EusYoKFzQmPlb7HHmhuzrvTxLKzAxCNSrM58AASR
         AMZRRCdlOG+Y4AoXgCvYtVLWKvyq0dhmytQyisKlFHSGF5cn07KXa1JNcjEISqWfyuDX
         FghzAnz/OoAizUm+Ziq1t/iUW+Z0FSpRT+W9NQZ3DxKIYJbkd4TNQKJCGJ080qtsOFA4
         5ohsNffap8z3dwstr1HzKXNr38O8qKfWA2Eqw2hUrSJSpNekV5BXXlb07Jv0sKcokmwf
         dOwH8ai7X5kOhcTlHL9MBUtL26M4vvSnrbpA/jsJqeaFUr+OUEzQb7gppXVCZga7f86Y
         oeRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707352536; x=1707957336;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lrbbTAjaY46wh40ntuLIgBTYNQ3DLFuC4PjlSBPhSJg=;
        b=MYB3jmwpCLg5v4QWFJIWxG658PQO8kN/vrr7EL021duBOqNynwtHpvhQuj6IHUZjYo
         k29zTHNZYVgqRTY9FFInYx/xtlf3yRWyb2CV05zoieocsdr2zg/m6uTvEdRrpL2noof4
         k1B6U66812FABql5/Kbv0YN3NoP5boQ9ZOzhjwdhXUtYbLQ7645Z3jDb5uKh8JkQVzGm
         CDbIBapYRZ9ZniX2ACp+VVXR7BMdNvJsxmOR4Qb8usA51DWk0YFSVJBFfJgXMOlcKIO/
         3cMlUbwmKQ+ZrZ3qKQ8A64lRa5vLmqEU2qeLkN8yNEqEnYdr01KCcAzLrnCuA7JfQ8P1
         ngfw==
X-Forwarded-Encrypted: i=1; AJvYcCWdfkLtHBBlIREUO63NCE5Lnz2ahS6WnVj+NAuSCKRccFBeGVPa8SgwmBcTu1XhJFDtkpyUxZ0IS7em+KxkxB4zFUsUQ1l0iqMYjJeS8EBkq//uJsB/vK8A5GxJ0CraPIcfD/+4T3BBAYAbzrHHMhQ+BhcrE9foQfzWfRghPjaVXAaIp906rt7BdpK1
X-Gm-Message-State: AOJu0YzObJTd+KMwBYuVXFpE784nCgssUb6rZ1LjdMb0fFQFRjeXuwvD
	xVjIZ11RHWvEgOVif7w5c0IXA5yDXOz/eHTrYR5sS4qOOxpfmN4v
X-Google-Smtp-Source: AGHT+IHaigv0FIi8RMTVKh9R/vG9fKQbhTn+2PGrQ0ZqzL0luJBP3yPcSSyH8TBtbhYbd96P76+4Ew==
X-Received: by 2002:a05:6a20:d90e:b0:19e:9bcb:9344 with SMTP id jd14-20020a056a20d90e00b0019e9bcb9344mr7684373pzb.53.1707352535964;
        Wed, 07 Feb 2024 16:35:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXQUBfvFI9w4wcHHu1h7rIY/5hl6x4chfCamcLJq7s8RRD7bti/k/CsNroh3QGTQ/ejbJnaR2NR6CTjXPL2PMrRpYynvdYdvZkC4hu3lo97rMaVN18lRhGTO9JW4aTCYdQDE3cWHPOEH1zF3g+lA28vyhKkhCkSYS6/yFObOB966ajG1hgmA5I0hvRJkSTHaRt+gKJ88IeWbY1U/QaEyejiWWkvmlO3qQqzRgMcrV/trO+M1GHlqOlC1geWZJ0u4SGjAvsecuRanws9BPsUJBUfjxkaFNW928QNic34dKYg4wtD1MSuNVS1VCo8mr6nQDrAIN84z3xJKdZCf6LjZTqM8YmrWctyJum/y6buEgF6pb9MNgv7zrfzMmznIvxiysHa7p9CLos/RqKf9yU0ZzKdGpGvCklqQZF/Djno8uF8DA90Gg7kzCx5fXnNsjDX4E/lbDc109Iy8KYSHD5mR/hRS6xlj30V/bp02UuDVmsqfjMCIynj1W4r2nUsT2m0eK8WZaSmV7X8KqvlJZcnWbDpMORZC1WnoMv80eHrPHN0RqaWE1EiaSxMEZi5y0/QE4l0941/JP8qaoFUajBOcelRzsy2a+NfcpnPBUV3ADEuNNrfYANff1HByOl1uXUJ0moKfkcJCITiIQ+8frnaIdQkcRXXdRc/rmY7hWaW7OJucgAb92dI9FDq95MDCkGqh5F80GoJj9LQF9XyaUy5QyNr17HLgBKvO34rOM5/hBWT+qvBDP20woDN414cUHzQ74u1i8NhGW393IAtA5s0SVOSYPOe0/dxx7x0+5KaGtxAT14EiLGAH1unu8k=
Received: from [192.168.54.105] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id i12-20020a17090320cc00b001d8a93fa5b1sm2080420plb.131.2024.02.07.16.35.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 16:35:35 -0800 (PST)
Message-ID: <75f4edfc-9cd3-4a05-94ca-ccdab7874f41@gmail.com>
Date: Wed, 7 Feb 2024 16:03:16 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/9] rust: file: add `FileDescriptorReservation`
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
 <20240202-alice-file-v4-6-fc9c2080663b@google.com>
From: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20240202-alice-file-v4-6-fc9c2080663b@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/2/24 07:55, Alice Ryhl wrote:
> From: Wedson Almeida Filho <wedsonaf@gmail.com>
> 
> Allow for the creation of a file descriptor in two steps: first, we
> reserve a slot for it, then we commit or drop the reservation. The first
> step may fail (e.g., the current process ran out of available slots),
> but commit and drop never fail (and are mutually exclusive).
> 
> This is needed by Rust Binder when fds are sent from one process to
> another. It has to be a two-step process to properly handle the case
> where multiple fds are sent: The operation must fail or succeed
> atomically, which we achieve by first reserving the fds we need, and
> only installing the files once we have reserved enough fds to send the
> files.
> 
> Fd reservations assume that the value of `current` does not change
> between the call to get_unused_fd_flags and the call to fd_install (or
> put_unused_fd). By not implementing the Send trait, this abstraction
> ensures that the `FileDescriptorReservation` cannot be moved into a
> different process.
> 
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Co-developed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> [...]

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>

