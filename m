Return-Path: <linux-fsdevel+bounces-65015-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E0CBF9B72
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 04:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82B5219A5CFA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 02:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A1D221F26;
	Wed, 22 Oct 2025 02:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mg+cjNtW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EC221B195
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 02:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761100023; cv=none; b=qNmhOpUQdR8pieFw4SdIVzUGdz39xTzrBnM0vCs+PtZSlMFjXLdmiq+jABYE0w4VFh2VFWIhFyzIm5hwK+f9eh2+UmrFu8sqOV12fvDteDsz8ZRONlSYI9PErQYeLbS4JQ6t2pZfLzrDoPHmkPfdop1CcIh4gl0NVMtBrTb/0sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761100023; c=relaxed/simple;
	bh=GHDQMCS5dEWxKn+0Txm/veOfLoI8l83ajhIWcN5rWOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJYy+H4/oAtxKjiS3jiuWqGAhX6FG012RPstmMS/UhS0cNVbFgdsHQ3fsMZJ768Z/ERiOJJgXWbAFj6Hz3kSnCMzVuQY054Ro9RO2jSlXFDOZ/zxmqNUNHj1QAGJGSrXs/Q+JyAQPttN7tvN8pJRj6sB7TPt7G7a5UcS+x7LVxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mg+cjNtW; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-793021f348fso5642685b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 19:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761100021; x=1761704821; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WqQzNiLchpkg3pgwyuDiy5UGt+eUDtmLfbzoo0ne91s=;
        b=mg+cjNtWy85MJ5yikxe1d5u3CQrZAjAaOamlRzfbcdkFc85wGXMOx7OimDEizRlL13
         txfW2OZvUMSY5eFEerqT7QTicfB804oqCBqCynrAlYUTxnsBqONIs7uIKiRQx1ktaOGA
         loKeDRjhNZyPV5Rmfbrl4X3ij+Zz7r2XmLJX/ilOvwgPp6gCuFVfiehV2L5iKcnHSVjP
         5PCELIx8MNhXM6fFehUhXBSUX35G/sCuqZ9nS7oBOqa/UsJPWmIfs5B6s5xwP1pBkLYb
         sjSYn6ux8ztx2kOSkpyBJ8c4L5WvphtjFNHRtAArdgUZ25ChBq3laCFW0RNTBtCty38g
         hTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761100021; x=1761704821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WqQzNiLchpkg3pgwyuDiy5UGt+eUDtmLfbzoo0ne91s=;
        b=I/T1tyhfqBSu6/V2FImr9LcyR8YZKM7UTbHEPAlf+2LHe+lfEGB3rth4s7evj8X5k8
         NfPQgJt5dpE2ImCn/uM/tuEmqtwChc3modMBcW4XjzlUWpk3u+3Q5xOrzhMSMj9Kz5O2
         evk+orRml8ypheKoYRS9QH6wKF+Dygw+WTHzwaSPe2m5zDgwGLeMuogkuRsC6Gkv4tm9
         SY0eIgga8DiuDyIqVHHvF9W28dc3ItA7Sc8XDVCmlbkZkXhGooM4q2YCacCzkf6QEicS
         kYD4HKn6qYh2CwNuZyW/MCPWKOs9Y2bYpqxuyIPSOat8+RWhwUYmbNHipDqOFx5WN0NF
         RXDw==
X-Forwarded-Encrypted: i=1; AJvYcCXZhz8sn9lQkjL5aD3AIuty4vyoTEe5xSdHh/RHzWmPUbOcPszCgzkvRdXJIYAps7S1mHj/5YJ1e5Pl5KvY@vger.kernel.org
X-Gm-Message-State: AOJu0YzLhuFouJI/SQKzcbJtaWZkUlz4ZdpNeQ0EnjtGBndY64REmo0s
	Y0re9T+s/zTcSXT26EA0AKKP/ugDXvMChbWvh+kIQOLXgxSayURnLXZxajod9olCsYA=
X-Gm-Gg: ASbGncsVEXbeARqdl0kEewJteTC7o8xTLGhhdUBfdxRBnpAoKJc+yRmAcuT+qvdEbHh
	91Yjda35RL9v4Kz8hYTGKh5IT2k2o54senfTeZZGNkYxiPa+G+gQRwy2zBfY5e1JjKX/br0YVh7
	2I/aivwQwd6Yvhtnrj8zjNFdWwCBwG73koQWD9yudIdH9+C4OwmRfI0b+jBcLSMhQszuhtagm39
	0QywusvbCrY4Ux39SxUcyvtMU4pcCSOEwe3qH3eRHvKZilkk7vLiXfnU35x6Kuw36cubldXZYR7
	mc4q2kWIeuMFvjHSZ2GiuvviWEmrDp6Td8RNqQnxEc1y12j8lP1+agzl6m7xhgwIvorPi0Zo1p8
	iFrcubgOK/1MVdrk12vOb92eX8oM5uneSHo8Yqa7CWBFbM+BcC5/oUQPxhl2XqmZolwy1WJV+kq
	yVSg==
X-Google-Smtp-Source: AGHT+IEiODVZTmpBKH4GJGfRgQpdF+p0v4t2QcX4SapXa+98D5HxqE/HG1opMUzT/b2Bq6W9RKZPmQ==
X-Received: by 2002:a05:6a00:2e1f:b0:781:171f:df6f with SMTP id d2e1a72fcca58-7a220b14d80mr26349244b3a.18.1761100020948;
        Tue, 21 Oct 2025 19:27:00 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a23011088fsm12778187b3a.65.2025.10.21.19.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 19:27:00 -0700 (PDT)
Date: Wed, 22 Oct 2025 07:56:57 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v18 10/16] rust: opp: use `CStr::as_char_ptr`
Message-ID: <75keuxnrpd2p2lumgmoxpwt42ovsx4xyltq3dimarvlspjq3gn@cmadekc427tk>
References: <20251018-cstr-core-v18-0-ef3d02760804@gmail.com>
 <20251018-cstr-core-v18-10-ef3d02760804@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018-cstr-core-v18-10-ef3d02760804@gmail.com>

On 18-10-25, 13:45, Tamir Duberstein wrote:
> Replace the use of `as_ptr` which works through `<CStr as
> Deref<Target=&[u8]>::deref()` in preparation for replacing
> `kernel::str::CStr` with `core::ffi::CStr` as the latter does not
> implement `Deref<Target=&[u8]>`.
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  rust/kernel/opp.rs | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

