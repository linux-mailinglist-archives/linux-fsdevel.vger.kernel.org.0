Return-Path: <linux-fsdevel+bounces-10696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DB484D732
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 01:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C76B01C22832
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 00:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A871E895;
	Thu,  8 Feb 2024 00:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8IxXMwj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688A41D6AA;
	Thu,  8 Feb 2024 00:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707352522; cv=none; b=G0mTwf2s7GRjlnFapZt8rPBJ1FDU0MM3FF1vjyObWMtGEzK1GI35+mqWo+yqrxFQVrfMaoEBa45tvndN/ZaMaVXuCl7DQXO6+d95L17MG/3/Sshst2e/7PKAazonkl1Cm+RPYbI87aWN3kSoE+2yOQPoAZK3pBCzyALEM+fx1KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707352522; c=relaxed/simple;
	bh=MDSJ6iuA6InDsmNvYlCSWAMFVmEWQM5kffEEY5Q1LXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RPhwBVOXy6+hnHTgwJmky6Hd5N7r0ax01MpeD2kGgDDWkwnnO8y0P8N+PsKQX8KCI3Txr1qy5Ft9kxsJ+WgyTsRoTS7Jdx4KxH7tVHZCn8KoxQ67zDXIR9T1VzcN3NQqs6NaZxjtDJClry7jZ+aj8qiAhpQQqOzC9QMexQIoJVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8IxXMwj; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e05f6c7f50so824211b3a.3;
        Wed, 07 Feb 2024 16:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707352521; x=1707957321; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oDJ0invuNtxZWdJkTTrX5eYrDYnTe/UyY807lNEUiLc=;
        b=J8IxXMwj4AC3swx4OXQHJazzdVjuiXiw/HrrE03tDeh0qaWhZIHjo/UBG9REdtrKBH
         Ok1DVFtMmxYm0Ici31kI3ZFyN6NvKQO0B8vYVopMjzrUE9z37v7IUC3bxcnp45cz/z1Y
         tKyjD9Y7k7K0Jf6iYqEBjQuTWmtwpBhuCJnzsV2NAe45ElblO819BSk8RduAUF0AKpCi
         ZO2c0wfFfnMaVZG1R3C8Pv1/bXHmwV4jThb8wMHQy/U8mKnCWCU7bUgo7XOAnOay1UQ8
         U+I/jrNcVsxci5omrEEdwGJHn+s9si85hs4XkmANpvU0S7nhPP2CdDOu5tNZUkY3Dt5I
         zicQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707352521; x=1707957321;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oDJ0invuNtxZWdJkTTrX5eYrDYnTe/UyY807lNEUiLc=;
        b=IgU1Vx8jSxJdTBs1pt+FYlL6gQl0fox2PEBf/tn1NQoca+mczQv0LBDlRy76kk37iC
         f4g5S5ckOoj47kyTQ4cB0bFGJJ8NIAyq3YEEf29gjPEgBXNi6r2gGIsoFKtAZ0axyPgt
         uL/lHWeN9NdCxw7ro293YlbJQYLmFDyKO206qL9Fn6FReIOwocnjLiz3530CuHpYUuXh
         ooIPEizH4S9X752DZTyy4l0nh+pHVfIKb+VQGN+h97fT/AOIEVEJV4/Is+XuHz7RpF3B
         DlGtsiKU3a5ulC9HCkX3kf8FZkgUQ5KTz0RyYq9dahbcU8IcBQGsYq+JdWuHOhH82W7m
         DWCw==
X-Gm-Message-State: AOJu0YyUWtwZklojKA+k7VoUu6V8qFjXItGlHZbx1UuypA49x8czMwWV
	Gv8ZTK+ZQtEcmu3FIa7UaA7o5xisSEhUevGm0A95Q3mfEVo82tNb
X-Google-Smtp-Source: AGHT+IFBL2imxLLumg6bWJ29T/qhnpn5LOE9hU8E6bn+gzbfTcUW2+/Yv/eNuJNMeyFoUoF091G4ZA==
X-Received: by 2002:a05:6a00:4581:b0:6db:d2f5:9e28 with SMTP id it1-20020a056a00458100b006dbd2f59e28mr3794645pfb.10.1707352520718;
        Wed, 07 Feb 2024 16:35:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXFd9ksAcixjaCWWfK02HeO2h/azCkkQjttxMtNxtGyg7ZLX/hz9Uo6D0lkFZf5Er5xH8g8sJkDKuxUrSCXDzywADA3+pPmwwGiDBi6QniFrqM7ScHl7nxFwTD1XvZRlFU/pxVxzgf7HzwSGRGbdExQ0dPw3YxecYaiX0zVFOuIHusrM9cDR7CZ1khUzVojpmuoCxobFMf5acE7NxOrBhHEfPUgB7Hivyx+Iys57ByB2Yc7YIeEBepwe0Jj/uhQc4AYOCwrii8aScPvy+jdmThvpTjQOaVPT742yuiyk8j11PKP3mzC+F8Y6KfrnEPPAZaeCFxTHGFtu46C0CeCAw18RSSx1ysIN3EqvzI6Se4jXty1vesvHuhin0jFcFSIVI/AXd3y/PP5bkEaQDLj3CEHkh2a4sD6id0FchEtDFPPxcof3PgC/APljXsWTPmYRENxXIJUIDvU6HrKU7FRjN73uFH1m9DmdY3EJJkD2bbRmbKi4Gi0rGEcHAbaIsW0Q/Ke+iiEmFRSqxjhrdFCpDpmgR9Jx0AUsarPVhu4pxgqsK632RvI683tFTL9huoblWvjfxu6dX5riUkCTz5uD1RlA3/kCKdLCwBhD66StBRxltE6y+j+bpDQbE+e0buytX56+VQNbF3Bp6dHRSTAdvasaNeFHCECXiZDC9bFD1chVW0I7yP2JCJVPrQeftK/WHCRmaHLo+w6oXanKEGcjIM+tuf/KmviL/8PfHUbUE9PE1n7v10GHQm9/ilc4LRWzuDxGDValit4Cdy/48UviBEf7OVWFuT/RSo35lVyeO/rsiZSVK1c/s7ytOY=
Received: from [192.168.54.105] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id u185-20020a6385c2000000b005d8b89bbf20sm2272021pgd.63.2024.02.07.16.35.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 16:35:20 -0800 (PST)
Message-ID: <aa0f46bc-6bed-4a4e-9dcd-e34cc2563a37@gmail.com>
Date: Wed, 7 Feb 2024 15:58:41 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/9] rust: cred: add Rust abstraction for `struct cred`
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
 <20240202-alice-file-v4-4-fc9c2080663b@google.com>
From: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20240202-alice-file-v4-4-fc9c2080663b@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/2/24 07:55, Alice Ryhl wrote:
> From: Wedson Almeida Filho <wedsonaf@gmail.com>
> 
> Add a wrapper around `struct cred` called `Credential`, and provide
> functionality to get the `Credential` associated with a `File`.
> 
> Rust Binder must check the credentials of processes when they attempt to
> perform various operations, and these checks usually take a
> `&Credential` as parameter. The security_binder_set_context_mgr function
> would be one example. This patch is necessary to access these security_*
> methods from Rust.
> 
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Co-developed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> [...]
> +    /// Returns the credentials of the task that originally opened the file.
> +    pub fn cred(&self) -> &Credential {
> +        // SAFETY: It's okay to read the `f_cred` field without synchronization because `f_cred` is
> +        // never changed after initialization of the file.
> +        let ptr = unsafe { (*self.as_ptr()).f_cred };

 From what I can see `file.f_cred` is valid from the moment `file` was
initialized, worth to notice too IMO.

> +
> +        // SAFETY: The signature of this function ensures that the caller will only access the
> +        // returned credential while the file is still valid, and the C side ensures that the
> +        // credential stays valid at least as long as the file.
> +        unsafe { Credential::from_ptr(ptr) }
> +    }
> [...]

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>

