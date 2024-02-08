Return-Path: <linux-fsdevel+bounces-10700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB0E84D73B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 01:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16A762890A1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 00:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44EEDF44;
	Thu,  8 Feb 2024 00:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFjsKtul"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA77374F7;
	Thu,  8 Feb 2024 00:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707352552; cv=none; b=Dx0zYSNMzXlq8iUgbkIl2O/zmFQqGHM8RjahhIDlw2yNzShGabwQzHGvVK+prn9tdAJdfg/pZHVYoTNFYVmIPDETj7lj5PZxeK0GY/A51uSFKLe3keQ56E76EccHcnCDPqPB7Qog7F8UmXp92FcMFXFVH8IoTXQNYNss4eyTjdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707352552; c=relaxed/simple;
	bh=VLJK/j/b7PDEMQo/a7C/uKMRAmAN2B9zbm2BC5mSflk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UyYDiOD4Z36Q+v6YG1Mgw5jB6PYzcdHPgmCSHSGFBerxeZ062w6CLL0h6pMsL6xv29/u79oSiqh3E6JgWa9X55+Hp33sv+RWtrNp0Ppu5UcuRkP1YT973O8TjZdeJ9xdx/TY0j+Or4VAunotuFAvP74Z+/1ETTeWjHOxFTvfLQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFjsKtul; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e05d41828aso866772b3a.0;
        Wed, 07 Feb 2024 16:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707352550; x=1707957350; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IvWBFnMPj0SmcOq/M6KphuwJmg9YhoVXQdx6E2pEKTE=;
        b=gFjsKtulXRyFAdzAicaOJoZS/y5Hnys7L7Is7cvSzmQx8dMx71/k2JwHyN8MlPFMnw
         vYzYEbywoVChz80rPt+AWw+cL4NIkL0Afsz0+OVDXtUNsEx7r8ie5YNTH0Kuup7UKSjl
         EzVCzdAgOZsDUzNrypTp1MGrFeUB8sBfO5XL0kxa9Z0pcG+n3gtjP4VnfgRwb/vxGjYk
         Rvz5UF5o3ITGCxoCaQwlW02yOnELAhzeyPfZGhhmcw/kXUNoW2DV5Bc3ckAS1v5p3B01
         Fyn3xb7D/U8xVRRwBRclW/vO3ZEyusLPVj3OCApaVPDdkoY1bE+rK2P1bJxIqbwT1zk8
         Ep4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707352550; x=1707957350;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IvWBFnMPj0SmcOq/M6KphuwJmg9YhoVXQdx6E2pEKTE=;
        b=fwOvs/of1nG3mA7lUJLrc9OV9kBX0q/ab2omrM8iQ7XDxfqAZmwH1v3fPbquD0iD7G
         Xy+fnHHX5z2mTccQe3Z9wNgkDuyUolhabd5nXt2c27EoECPuvTTNfoM5nJp11BRbtt1d
         ynp8u+aINgv/6Rrv/mprJAOzFAiLK7oTeFzSVPEXS3nyGz5epujVPNGke4vZDU/7Lvv8
         cuKeMFYJ8F5dpYpfG2pW10Ep1ZVGzpSTNr8LGJAp971yugEklpHMw5EFgnu/sYbC4JkF
         5E3NCwnIzTAe9jK5nBd2orloQ3tVKJH3KESdsuDHWt3gLbP4E1i05gBsaubogm/MiDdO
         9Nuw==
X-Forwarded-Encrypted: i=1; AJvYcCXEL5utfQi2tWNYQqfcX0te8evh2p9pPrRQEz80NUWvbGdegqmjje6QLF35lUU2TWt9JZgpH/aXKbcgP3mdD6P2zQBUIEXwoKLAN+AqJ28IVnvSonSNF1F8MfEFDjfghxEwGi+7M6dUwWgKSIaydQbK1+cmZSAvgeeS8RRZm2tFF1o+fzuhxh/wtP0m
X-Gm-Message-State: AOJu0Ywtfq6+vsIepv8K77BmiuxFT2RCUs44bFgeuXynd1Tua0qzw13j
	7naH3/ojJeMXzvh6jZ5wrkC2YhkhHRqlwmo0YoObCntfUWgBXK8/
X-Google-Smtp-Source: AGHT+IEtE8fR3NCIXcXfU+CpHQ5AgaOpyNqDtDXDxlUTHG+k3a+yvymwRqsgTFDNSRjzsJZDve0TKg==
X-Received: by 2002:a05:6a20:9012:b0:19c:881d:78e6 with SMTP id d18-20020a056a20901200b0019c881d78e6mr5161880pzc.42.1707352549990;
        Wed, 07 Feb 2024 16:35:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVUxS3L4wjEJ0C0nLCSUxFsGiTg+HHq+TPwhvRvVhJw7bSIdg9Pra0rQ9oCA5HCaRf1s8LahQZZZ1C+R4UhPhUT1mUQpvMQszeRf0wSm2Z2QFBCBwNztz9oRNFRz2B677wPhGSIGWlyTCT7wScqjMwg8P5aJEvx6ZZP18DO9GxQ9ITgEEW1SeCJ8Cay5fVt/TKanCFO11J3keU3ER6wUjTilEN8x+iCgs863gA+VpqRUtB90xf4RZ5K4UKcfkFvSTdT0zez7pkS+iy+BY6AlYBGTLXpZ1o1NAaqHKJdqRSbc5+49ClZ64wfrZJQjhqRqUd3E61LbG1SmQiZnrgEjC3y/oUUYOhx3rMvz9x4vS+spWfYSTE4ZPd+HDMidmkR/J/Gtjo4KUCetJpSSwtF7TFUd7+0cbNiUqg4sit92vNsDaTd4krNYA1OGwFVl0gGYiNKWVPZRz5af/OI2LI4Df5Y75Nn4ogtG6iasMWiCKN0jiwcNFO0tyzKN9SoBeCzT/p5YhrGhTCKxsU9JBd/eYUX/PwKwMCKuviE0wAzWpFQwS/ksblSayD1SvXuNXmBcwv9Y5QXjZDAcyGeDwCqKwHxVaVRMYxTgh7sIjvNtGIgmqrZKG0cftmwE8bGrWeDvAThsTOinWozzfqdggomWrq4u8JumfgO3ITmAQAThpZgXdOFUypBVPtz0djtjY7VkH4LJLhXJlpFbIXxOjhd4QsBetQK+oW8M0QnUE9EbNvpLv+1Cd8Cylx4Q1Npx6LCP9ofSyjtF8M3Ljz6BXwHv49ZutyYvfAMiFlKUizdg5/w54yzAfNq+yCkt3o=
Received: from [192.168.54.105] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id i12-20020a17090320cc00b001d8a93fa5b1sm2080420plb.131.2024.02.07.16.35.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 16:35:49 -0800 (PST)
Message-ID: <6ce4ff41-6e77-47a2-87c4-575c70b98f69@gmail.com>
Date: Wed, 7 Feb 2024 21:26:01 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/9] rust: file: add `DeferredFdCloser`
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
 <20240202-alice-file-v4-8-fc9c2080663b@google.com>
From: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20240202-alice-file-v4-8-fc9c2080663b@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/2/24 07:55, Alice Ryhl wrote:
> To close an fd from kernel space, we could call `ksys_close`. However,
> if we do this to an fd that is held using `fdget`, then we may trigger a
> use-after-free. Introduce a helper that can be used to close an fd even
> if the fd is currently held with `fdget`. This is done by grabbing an
> extra refcount to the file and dropping it in a task work once we return
> to userspace.
> 
> This is necessary for Rust Binder because otherwise the user might try
> to have Binder close its fd for /dev/binder, which would cause problems
> as this happens inside an ioctl on /dev/binder, and ioctls hold the fd
> using `fdget`.
> 
> Additional motivation can be found in commit 80cd795630d6 ("binder: fix
> use-after-free due to ksys_close() during fdget()") and in the comments
> on `binder_do_fd_close`.
> 
> If there is some way to detect whether an fd is currently held with
> `fdget`, then this could be optimized to skip the allocation and task
> work when this is not the case. Another possible optimization would be
> to combine several fds into a single task work, since this is used with
> fd arrays that might hold several fds.
> 
> That said, it might not be necessary to optimize it, because Rust Binder
> has two ways to send fds: BINDER_TYPE_FD and BINDER_TYPE_FDA. With
> BINDER_TYPE_FD, it is userspace's responsibility to close the fd, so
> this mechanism is used only by BINDER_TYPE_FDA, but fd arrays are used
> rarely these days.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> [...]

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>

