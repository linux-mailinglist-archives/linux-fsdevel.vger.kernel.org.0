Return-Path: <linux-fsdevel+bounces-12437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 374D085F525
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 11:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AF391C244F6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 10:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2232339AEE;
	Thu, 22 Feb 2024 10:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fl7s6ciS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B873D381B8
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Feb 2024 10:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708596013; cv=none; b=UWdqvo6mvxvLIN0hVyO4+28h+vkRHZBow5MgzW6WOH7QUAnhvLuGcrUboxcsjuu3AdjE/EHa2N9LeIzHcvpc/F73/qt/o9yKK+uj+RZsCAa2Ox0LQQmANfTy5p9b7Z3xX7zwX7LtVl1Ybm3+j5h4PAvZSLqqOzxs4SWrZ6Gukqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708596013; c=relaxed/simple;
	bh=xY3a5A8TczyzS4EQy7YnxSv2e9KYZLcka7tIrv2ih1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nqbd31aa19VdmqdeXdPW4sZR2UV0KjkPXWZCrhPc1knETFjSLaZ5RjKyLIq6bsp4BluM6bcUk63C3XnyeRp64osc4tf2boapCbjObOMJebQ38AxVjmunKHo+8e/eiJPn3W07ojlZucZlW6y+dBPG2XdzRNFV8jmqCmbCG24qvPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fl7s6ciS; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4704c69a3d9so1093321137.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Feb 2024 02:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708596009; x=1709200809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xY3a5A8TczyzS4EQy7YnxSv2e9KYZLcka7tIrv2ih1k=;
        b=Fl7s6ciS+4en1deeuOU1AB9WFgIiGeW1f4XEAekJTZ75iq/9K0zrmPX8NhW9X9AUuT
         rIQ1bhTNP1/ArqGkQo6HiNaG0lvbiRuCiwjxV8zRR931e/kxKipH+1tXcxSwhCciQD9F
         swg16CJUpxbze9NfoejW0g7KuioJZM3daXgKi0E2vxseSMc6+r2+y6uYd8LipL/9aPf2
         yuz7aJTTtJDtHnmyioZxhaQphffvs3V0hrDSGHVrhPHJRUziBd/e2Rkt1xZwqbP9HYzY
         u1ipZpJD+g7DjFIyZZEWx98Hu+sWJfypdUg9c0mxSGGmqpL7L2EcLXkzklunvFDnY198
         jCXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708596009; x=1709200809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xY3a5A8TczyzS4EQy7YnxSv2e9KYZLcka7tIrv2ih1k=;
        b=G2oftNmpNtR6ye1+afuVFNNerK/b9BSKwNt9kewAenCXcDOwTWpjCiNZypkEYOOVyt
         N6seEArtZNv4FEbLe55+0CNQe0cCPNS+uU9OSlxCkyr6XnMOFNazn47MevnRus4mTQv3
         qTwIGTINKgWmmrNBroaDBQaoYHE3aHH9R/8F1EhyGBf9dhDPbVZhLJ8nZ8/VxcIUxXhi
         lEBh0xOLB5FVBZ1rCSYsLileHEPUDTE29PTJfQ7oru84hxGVaA6f9hKnszySXI+TTQ2O
         8Y8TEltpY7YC/9LVcnYpdYlLew4aVYtUDst8mecKVjrHZdCSanpiTKf0Xi7BzEdugaiz
         F+BA==
X-Forwarded-Encrypted: i=1; AJvYcCXhbSOaCG/iQN4pPw9mvppe1GZTWVT//nkpoKVrIDnP1EIjo+3VPo7vKWjy0YU90FKFsln2zLCDd2vDY/5y7WzLeybwW7w3CiATBZKR4g==
X-Gm-Message-State: AOJu0YyXG0ON9v3dl+VsL3iYHIMMtrQPdo61IdqeegNZRCd8cKiKBxLj
	0bLdJwkwBl3gELpFjRRVG/LX4Rt+aKUh7g+ilO/98W7WuDfncd2+QCS6BfDSl7/lKb8+dJJli5n
	2N3NEp/IQj0dWZDWF0ncPM8b8HYF2zk80lF9H
X-Google-Smtp-Source: AGHT+IHtNH9SG5kviHG0Zp4ObgcElY0QaPwq/WKIrJZZn0CRZo740etRowxrv/bo9NQSJHSXY5Ib9q+PDO3ajLn3tTQ=
X-Received: by 2002:a05:6102:1626:b0:470:4a6e:4a4e with SMTP id
 cu38-20020a056102162600b004704a6e4a4emr14352031vsb.29.1708596009136; Thu, 22
 Feb 2024 02:00:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <20240221194052.927623-25-surenb@google.com>
In-Reply-To: <20240221194052.927623-25-surenb@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 22 Feb 2024 10:59:57 +0100
Message-ID: <CAH5fLgiyouEuDGkbm3fB6WTOxAnTiDx=z6ADx7HN3BTMAO851g@mail.gmail.com>
Subject: Re: [PATCH v4 24/36] rust: Add a rust helper for krealloc()
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 8:41=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> From: Kent Overstreet <kent.overstreet@linux.dev>
>
> Memory allocation profiling is turning krealloc() into a nontrivial
> macro - so for now, we need a helper for it.
>
> Until we have proper support on the rust side for memory allocation
> profiling this does mean that all Rust allocations will be accounted to
> the helper.
>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: Alex Gaynor <alex.gaynor@gmail.com>
> Cc: Wedson Almeida Filho <wedsonaf@gmail.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Gary Guo <gary@garyguo.net>
> Cc: "Bj=C3=B6rn Roy Baron" <bjorn3_gh@protonmail.com>
> Cc: Benno Lossin <benno.lossin@proton.me>
> Cc: Andreas Hindborg <a.hindborg@samsung.com>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: rust-for-linux@vger.kernel.org
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Currently, the Rust build doesn't work throughout the entire series
since there are some commits where krealloc is missing before you
introduce the helper. If you introduce the helper first before
krealloc stops being an exported function, then the Rust build should
work throughout the entire series. (Having both the helper and the
exported function at the same time is not a problem.)

With the patch reordered:

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Alice

