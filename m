Return-Path: <linux-fsdevel+bounces-57863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DF6B2607C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 11:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07497167D55
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 09:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2ACF2F659F;
	Thu, 14 Aug 2025 09:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xf8P/+q7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0AC2EAD0D;
	Thu, 14 Aug 2025 09:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755162458; cv=none; b=tas6mO3ZA3tLpnYP10BhaedqODzEiQejs49esWTvt7yrRcfYcYkeshENuljoHUfBqJ+KIg3ymyyE92+kHXH3/M5tn/18Axu3Rx6zJVQqL9nHPYmrNC/SrQe6ud143fKSLAtzMv0LImSFpJvwVjkPSbzawVGk9mFtPfTtA8qweeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755162458; c=relaxed/simple;
	bh=w8hCbPXfmihu7zR72JNGg3vbfSeuvBM7obhn0s4J7IU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KsgTihtT+eq8SXnymtHhw9hHT8Zg25T9G7R97Isd5tUEygr5UF7zHki3daTGozDYLPyVZrhAwrkyU1jWPOO9hxC0SkLfzprSqpfhT+T8BOMPsYQ9JifkTOxS+79ez3JzQXqEL+BmKbm+9nakEtxGv/DCChmiOkUlxNxLazKw3hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xf8P/+q7; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b4717006ea9so75049a12.0;
        Thu, 14 Aug 2025 02:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755162455; x=1755767255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L58BGBn53CdEaQI/pHX66dG5GkpXtAAIQcYXknidNg4=;
        b=Xf8P/+q7FP7Sj6wUfRijJLt6MHzwIgFGKK3Hy+/iaRBWNmJuKnEgp6Q4heqzKmy/ns
         CbI6us6t0QerSP9xU4HCyBAnFO47uXNHXmDTEWFDE4aFl3F5tw1EMXrHhwaSP+Q94Yle
         hUbYVGt33Rl4FUjof+vKYA3XEAGntJgIiKneoa6py0QbM1xesztFcO0PJlfLO/KPayfk
         KbzFIZVWKytOYTo70RHDQFLmhTYeuaKaxxOkBZxC70kMplRE79PdCvYuqPa8Hq/oyrDP
         ieTWI3j8jVmZRD9aRu9AZuZL+UhL997ePMlnNvAUIbatTYk+36efO+YO7O0aq6Vs8DaZ
         7qxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755162455; x=1755767255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L58BGBn53CdEaQI/pHX66dG5GkpXtAAIQcYXknidNg4=;
        b=S1DHe7qi75DsfyW67moRz6bTP62osfv4ZupVGK66+/6oRl/PSBBrpxouOA3s0CK+/J
         eVeuQ1mNW+ATUkgbrOub/RJu5cMNsZuFZI2O2s01GlVIudT15VlPvi31NoSysrV0I/os
         aVYTDNLR8S3lb7pSeDeQD1Y4n5d82Sb6ASiJ8HH9C+AgCUMz/yZuOQyTSR2XsVIWAvkT
         1tfHA2IIUyf7STmWmv5VCsH0unkXUZrLNgzaVI/RBKtSQ2XqptqYMHuv1EtcxLTj0nXV
         Nr3ERjmLyxOCGWQ2sOEZaekqoFppCx2c1336nLoWSXz6WSP4N+InZTmzBoBl5l4qO17R
         La1w==
X-Forwarded-Encrypted: i=1; AJvYcCU2AkLqzX62Vycq+X6usAtf/cvgf3AuXGjPMkTI5weB5qRSez+BRbQPp0VwlXAi8l6t6j5XcN6i@vger.kernel.org, AJvYcCUwuph8ybeUT2N+0zvQDwO/H6dav7+g/3s7KdJDGD4tHT73X+tE+FVegC8zuKNl182WSqoaLbPtQjI=@vger.kernel.org, AJvYcCV10rheNuYpNIv9Osg6EBPwerim/bHVHpgLsdwESRLoMhXEXTYw3Io03QZozPaa+nRh+WYL+3hoX80D@vger.kernel.org, AJvYcCVwLNHl+ID6/Mk6+JKZ3yCFOn5nOsH7AfmBmJybSY1PXDzdUTPH/dVuvZ036iQnRjUFqnHiwu3BFaPpDFL6@vger.kernel.org, AJvYcCWU64E2Bp0aS+//LKch0vW1UXHMSEz6PgT8bo77hg7nGHusEgUdCYOp4WqjVpmDmrVSGSl9wQN6LXE8PTZzXhG+@vger.kernel.org, AJvYcCWdbDoZ13ifKjijbNra1QB+3WrB9S7KIM3u7yTRScbvEWDRq5R5A/ySrT9+wgKeLQMo1WtBVxdQAJJwyw==@vger.kernel.org, AJvYcCX445xNq7eU4zuJA/nSWvEm96C59lCZYfvEIUslFz8g4O8hivF2aQ0VWYkKENKl2/90MdduNfdC33C5@vger.kernel.org, AJvYcCXDrwJ8uyybzhIeAp2qlzh0mixgbHHjA9WAqkaFZmBkGgDrf0QyPf6JONV3+Y/HKmq4mupee4IslTmAYfGCXto=@vger.kernel.org, AJvYcCXfV82ubBzNsUdCdy60J2WTzXOtVfNtxdObhOckteiU0awOI7UNKhP/w/7Ds2KXNuiCEi5+9Jtya9bnx1W67A==@vger.kernel.org
X-Gm-Message-State: AOJu0YypINaXScbYWu7AGqasYGV8fdyR3+x9hPlk+3U2Vr5IEgIvclm8
	TFzwmHPLFMzEx3AggrVZ99bzcKxt2fjFBRfTRbQewEezlSqj6NnVPkWqnjD/lUMDNgUmSe3GZSF
	lykirKCdz7P7+z8jZZE+LKaVYuYSSCMf78Th3BwE=
X-Gm-Gg: ASbGncvc/qynT4YZKqaP9Sy1oQaLptA0kKszFqn87yqjhQVN1bnzA5BpLAQtpKgyJxv
	DNf6bsK2GhoDrE2MqVcHfNhoyX9mM9xiDFQLIJN6MYP4WIWtzgsaihTxUhWYtMpqW++OdzckXGL
	arntGWRa5tL8xRO6g7m32YglmVjV7rPn7awFAh53Z28pQXssmWj0nmaGr8wApLqHwNurFUA/gkV
	f6a
X-Google-Smtp-Source: AGHT+IGz6bvQQDm0FDjw3b6Z4zK6LWUctdhJrkeBml6MEiQLxKVKVm/2E3KeNDssnbiZd1rTjK+/reiEgrFQf4jGtow=
X-Received: by 2002:a17:902:ec8d:b0:240:5c13:979a with SMTP id
 d9443c01a7336-2430d22a83dmr44771485ad.9.1755162454741; Thu, 14 Aug 2025
 02:07:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813-core-cstr-cstrings-v2-0-00be80fc541b@gmail.com>
 <34d384af-6123-4602-bde0-85ca3d14fe09@sirena.org.uk> <aJ2dST9C8QLUcftA@google.com>
In-Reply-To: <aJ2dST9C8QLUcftA@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 14 Aug 2025 11:07:23 +0200
X-Gm-Features: Ac12FXw9McZU8Dlo3fmof7Lor15J3uB_TM7gEYyMiiYtjURPvTaxggH_LYJAg0o
Message-ID: <CANiq72nnXG8mzGD5ydu1pMpaBAHTWvfQWSo0w38xefu=1JSURA@mail.gmail.com>
Subject: Re: [PATCH v2 00/19] rust: replace `kernel::c_str!` with C-Strings
To: Alice Ryhl <aliceryhl@google.com>
Cc: Mark Brown <broonie@debian.org>, Tamir Duberstein <tamird@gmail.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Alexandre Courbot <acourbot@nvidia.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Liam Girdwood <lgirdwood@gmail.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 10:24=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> Tamir mentioned to me that he ran into a daily limit on the number of
> emails he could send.

He is posting the updates around the migration in Zulip:

    https://rust-for-linux.zulipchat.com/#narrow/channel/288089-General/top=
ic/CStr.20migration/near/527957336

Cheers,
Miguel

