Return-Path: <linux-fsdevel+bounces-64359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E206DBE2E0A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 12:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC84F1A63720
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 10:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CF931D729;
	Thu, 16 Oct 2025 10:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmiVN99a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1702E0934;
	Thu, 16 Oct 2025 10:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760611378; cv=none; b=p0eRKHMUg1GCQMEh1+pUgSPMwv8/sUEoOXbvU1+91ZpddaiL3CX1Jv+UWJIz8jbuU5kRnj1OpgGe8YmLzvcbhOz9+E5EGkEnkXVd7Ieq4HgKCQ02t4kVhXXfW+ro0lV32d5dDhQ1fWX1Z+68tUNKIBpH6ZQrSS5pypij50O6NR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760611378; c=relaxed/simple;
	bh=fErXExt8RSysN8h2wJXFWIVOcFCJHfLTOJEmQT9C/wc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=peiT/Acn98ADf0DiXyH1Uxid2fI/4lnOckmqUYn0E5UsATi/s1BQs16Z6McUzXm2fUhIInamWJeNSJ59t7kFfF4xyOGxKf65vJ4iMc7jYcqpX83kPB3luf1ehi77m3Wwbdyay9xRF0MXa15DtoqqEPZRgZu1PDeGsWdXJfRsGkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmiVN99a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8BDC4CEF9;
	Thu, 16 Oct 2025 10:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760611378;
	bh=fErXExt8RSysN8h2wJXFWIVOcFCJHfLTOJEmQT9C/wc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=JmiVN99azeY59tVwDTzaK+WC4HQWXUncOqi3pAncLsEm7ZoloUtQxcL0wO03R+6/y
	 PQQBiEKO8U3A1mlrvP3RQKUG6j9ISIEA8lFMKq6OCCskt7dHIy0j/pZS2yN2P4eLMz
	 s06rZAmY58W9yL0Y0zrEm4QJTaxF1y6DQYh2/YScdddCgZwVmREfLd2kNXizNAbYu3
	 irTpEnrr8B/lItxlpxgJkCPDQrtZMwjRZuqn2MKytv65xyyjRGmMQZEzKLoRBhVQ7J
	 CJm5MFX/ATbnHUJ3MR8dMAmQ4RWRJ5o34bBiuNvdsY14Eg+qoDg7pTytqL4EyvS+HT
	 hgj3oGQp5xSsQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Tamir Duberstein <tamird@gmail.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda
 <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich
 <dakr@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, FUJITA Tomonori <fujita.tomonori@gmail.com>, Andrew
 Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell
 King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Breno Leitao
 <leitao@debian.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Luis
 Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Dave
 Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, Leon
 Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Arnd
 Bergmann
 <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>, David Gow
 <davidgow@google.com>, Rae Moar <rmoar@google.com>, Jens Axboe
 <axboe@kernel.dk>, Alexandre Courbot <acourbot@nvidia.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, Tamir
 Duberstein <tamird@gmail.com>
Subject: Re: [PATCH v2 17/19] rust: sync: replace `kernel::c_str!` with
 C-Strings
In-Reply-To: <20250925-core-cstr-cstrings-v2-17-78e0aaace1cd@gmail.com>
References: <20250925-core-cstr-cstrings-v2-0-78e0aaace1cd@gmail.com>
 <20250925-core-cstr-cstrings-v2-17-78e0aaace1cd@gmail.com>
Date: Thu, 16 Oct 2025 12:42:35 +0200
Message-ID: <874irz5dr8.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tamir Duberstein <tamird@gmail.com> writes:

> C-String literals were added in Rust 1.77. Replace instances of
> `kernel::c_str!` with C-String literals where possible.
>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Benno Lossin <lossin@kernel.org>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Acked-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg




