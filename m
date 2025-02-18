Return-Path: <linux-fsdevel+bounces-42004-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9AFA3A0FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 16:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAC3716561B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 15:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE1A26B97A;
	Tue, 18 Feb 2025 15:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxh+gLyo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A68326B941;
	Tue, 18 Feb 2025 15:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739892097; cv=none; b=gnyJOuyN4cjrm3OXa+csV/GQZgIMVx/sRd/rIWHrsZfuasUE+pbHevaanJii43BZ2XW2Vdz7q3Wat0F5nmtsp7OrDS2qwZpYliUzviMWLG0MjU+N03PPjM+FmlYh/Xab6tptP/uOIwAru7LjipDt+pQ0PSKn4RkOV3oRML9Emq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739892097; c=relaxed/simple;
	bh=mWpV972E5ut4sDMGsVOXViJCPA83Mo2K6cuKVK5+Fnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LjXDYyLBTtlIfK7300Ih5HjQi8ZY/7x9UrDd2MHmFbMHMXZhaXt4VG1FEvu0iEXA2sOMXtc2lAyhHVcStIC0JzRb5iqIE8JDmIF2zISSlh53+naiqOfTnvY1hJ5VHyTtwqjNVO4D780jrk2g+xEdEU4yNDhlC2sVwWHCmTlH2GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxh+gLyo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91CB9C4CEE2;
	Tue, 18 Feb 2025 15:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739892097;
	bh=mWpV972E5ut4sDMGsVOXViJCPA83Mo2K6cuKVK5+Fnw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hxh+gLyoFPfHfSBBy+QYQexE+ze8nE5J8ewaFjq8ABA7xntuy8TAvHNnpMyPyV24b
	 gS8pavJbUSs3FE7whbN8LpAmxEBP9iE0nhWUYwwbcRyFVn1D2Yx2g/XGvaCHEIW3el
	 k2xmX4irZxai0UgDTSJnuUQI85BNSfp9aKg7uCvH68oq6hG+EKitRCMJyoZHkMgI1J
	 HPnL+3c+JjZJB7vgLmsVsI3AhKjT9yOCkNpTDYYKV1r9aWqQ4jrN2zMIra3NEG+Nxn
	 S9Snf6RLsqBsQqCUrF5vBGeo+FANra/h6KzbRnf+TdvyGMZUqVT+7bNzKsnO/G4BEx
	 3brYVBooKx17A==
Date: Tue, 18 Feb 2025 16:21:29 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Matthew Wilcox <willy@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v17 0/3] rust: xarray: Add a minimal abstraction for
 XArray
Message-ID: <Z7SlefHJtpZFzV6t@pollux>
References: <20250218-rust-xarray-bindings-v17-0-f3a99196e538@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218-rust-xarray-bindings-v17-0-f3a99196e538@gmail.com>

On Tue, Feb 18, 2025 at 09:37:42AM -0500, Tamir Duberstein wrote:
> Changes in v17:

> - Drop patch "rust: remove redundant `as _` casts". (Danilo Krummrich)

Just to clarify, I did not suggest to drop the patch, but rather move it after
patch 1 ("rust: types: add `ForeignOwnable::PointedTo`").

Instead you proposed to make this a good first issue, which is fine too.

> - Drop trailers for shared commit from configfs series[0]. (Danilo
>   Krummrich)

Clarifying further, I pointed out that it's worth to consider dropping them when
making subsequent changes that haven't been discussed on the list and are not
listed in the change log (e.g. because they seem minor).

This was an expression of opinion, not a request.

> - Avoid shadowing expressions with .cast() calls. (Danilo Krummrich)

I appreciate that, thanks!

