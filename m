Return-Path: <linux-fsdevel+bounces-65028-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECC9BF9E38
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 05:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 115FE19C5042
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 03:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097422D594A;
	Wed, 22 Oct 2025 03:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oe4dbb4W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1455350A21
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 03:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761105442; cv=none; b=YI3vkzm9x4HEYim+VrsdSIz2Vskza6ZuoaBE+LO16smMBIDViIrAlrLQggp0LiT6S5hw7+QKNNbFzXQjEiXVQUGyv7MKajc8bRl8sCq5h6jW6umo02nfo4r+GVOrgnzi6VRgAiHAd/d6oHZxbcpdqOxtYPiZPkeDN44GgDYkRuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761105442; c=relaxed/simple;
	bh=qWU3gcv2n5vPIYTEv6u9o74rRMnYuUnMY2EGJgd5Hwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cyVF1+WeVCyfCCJ5jrOrQhgjQoVSSufO86ivw7TKZdcSBr0SAtVXMEfgymV6bqpSDm2Z7cWgIZH9NP1mTvRcAGPEzVQoSYY4kMUK86hCougQzjyPFcnZXSIuj6numiiUAX7zw7FcBDF2XlLWq+lQJCK5sH15dtAkSSZmS2XIzHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Oe4dbb4W; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3327f8ed081so7693785a91.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 20:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761105440; x=1761710240; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eJJGHuWNBUYeZe+bCjnWrKJ6vdZrDU3vtt+RVJeuIe8=;
        b=Oe4dbb4WLq5HWWLw7/eEzqjc0fc8cLtpgEfIWgy0ems0U0m6UP8+pVy9YPBi5Vto/f
         vLfMANNef3Hr47z6WdGUDtkL68RaMYKmho4B+iJ+bLopRzEdBgcVCfI+DYnQ5irOq5+N
         rZ91QmTLY+8W1XmkC+XoGbmAZrpCcuWEOi7x6+EG9mqX/J264+THP2L23cgW+t7wHMCm
         8VirNBtMOhVZfqE2CdIF8PKbqwext/T1H8sxDroBUaEwZG6PMUwLlegDyyu03+zFz139
         GARdjDJBa/wtVjJb4IT5DXwPeMc3W/fqQ9DiZOBiwViTsBeLvTCyT88V0NIuy8pwk4QD
         eaZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761105440; x=1761710240;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eJJGHuWNBUYeZe+bCjnWrKJ6vdZrDU3vtt+RVJeuIe8=;
        b=s8tWBW9BtksD/1dGVfM5gCRRVHsxv76QdhSiwP9uGRFsVpNxkXH1vME6UG0WcHu4re
         Ua6eCfy6F9/hARkXFmJT4tQKbxP6RTVzgr4lYbil5aw8kpcrlEfYv38AmDe0dGOptAck
         NnCrO0gCG5DcwqnIMZYZnDBkRtNjhPjjNj1bFDtZkF6+tdz+9Ad57IWq76/jHM9rqOvJ
         4mDJsBJ5AwbhJuL57atywIdn08ujqm/H57g7Rzh0svWNv7ulGQ2NuMbKJYnxCnTlqVbS
         RaoX71COJTMfdAMdkU9I0swcBV5kQ7NMo8Eb476C+YcsuR8BxZSseRNjIVG2l7V5VXti
         PmeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiLjKPCtyQ0udnLYMu/mVZZQgfQeFjeSroUbKgcGovb0q6CgTigfxtLoZiquyzNbbNKKeeG1SctyK9Qxmo@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3aXiRGBg4Ioq8hck7G71+zl+Na8wqek32JHfwhOgK2/PEIdUF
	D+mxFZ5u8F1zvJPRVWrjBZygqqSN8MBQtj78LCwN176O9dlS47RxyvDxS9tWOF2+LA4=
X-Gm-Gg: ASbGncuoMBWI6x1CpISk6x68M0zS5vk4XHn1tAiOvmO3HdsDOWZN9Mrnw/hHALe/ZOK
	7qrBYQWF3PoRHbSmbKEYeC1q0n10A3E75kpzODt0SlVH5eUsYusVa5Xx04n4pSTGqDmi680OGCV
	XKzu2igFqS2iNsi88Iyf0gc416Qn6cDi5xoYESwJNRXB2r1W3uthgyMuuIAVEkhbwopJmnNcYp3
	o016Z99NgaeOYaDZAHV52jrmmtSsX6lF73VrdRBs71v2H83S37MRcHwAnkdbXa0Rar2dYNuoxfe
	pHIJwHmPhpmpDOWtwvEdKbMzeTkaz281rvq2V08/s1hTJ3lyjyXRKHHVNOyxMl/uymMeaUcZvbP
	ILSNBmNwEjvq9CSq+sHiue1RY1vztxalXH+b4/00allhyoajH0IClQOMaTqysPeLqW4HfhrKPOt
	pKAQ==
X-Google-Smtp-Source: AGHT+IElJYs5hS03PBXdQxnYWI3VpdFMd3uudSGQGvl+AqJvx2HQM7kb+KxG1SNdziFnaV4FdnABlg==
X-Received: by 2002:a17:90a:ec8b:b0:32e:9a24:2df9 with SMTP id 98e67ed59e1d1-33bcf86c09emr22277403a91.14.1761105439473;
        Tue, 21 Oct 2025 20:57:19 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223c7fb5sm1164284a91.2.2025.10.21.20.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 20:57:18 -0700 (PDT)
Date: Wed, 22 Oct 2025 09:27:16 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Tamir Duberstein <tamird@kernel.org>, 
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Jens Axboe <axboe@kernel.dk>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Uladzislau Rezki <urezki@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Breno Leitao <leitao@debian.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Luis Chamberlain <mcgrof@kernel.org>, 
	Russ Weight <russ.weight@linux.dev>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, llvm@lists.linux.dev, 
	Tamir Duberstein <tamird@gmail.com>
Subject: Re: [RESEND PATCH v18 11/16] rust: opp: fix broken rustdoc link
Message-ID: <4cweppdfmaei5isgmfg575eikx2qycjl457iggips2reuk247n@o242mrr5ghiy>
References: <20251018-cstr-core-v18-0-9378a54385f8@gmail.com>
 <20251018-cstr-core-v18-11-9378a54385f8@gmail.com>
 <CANiq72==SKsYkogrQhKTzCXwxeYfbL3V5jOiQKiunwzLta5=Pw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72==SKsYkogrQhKTzCXwxeYfbL3V5jOiQKiunwzLta5=Pw@mail.gmail.com>

On 19-10-25, 23:25, Miguel Ojeda wrote:
> On Sat, Oct 18, 2025 at 9:17 PM Tamir Duberstein <tamird@kernel.org> wrote:
> >
> > From: Tamir Duberstein <tamird@gmail.com>
> >
> > Correct the spelling of "CString" to make the link work.
> >
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> 
> It is private, but it is good to have this done so that eventually we
> can potentially enable a runtime toggle for private docs.
> 
> However, this is independent of the series, so I would suggest that
> Viresh et al. apply it independently.
> 
> Fixes: ce32e2d47ce6 ("rust: opp: Add abstractions for the
> configuration options")

Applied. Thanks.

-- 
viresh

