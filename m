Return-Path: <linux-fsdevel+bounces-41111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D63B8A2B15A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 19:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 134291889EA1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 18:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF3C1A08A4;
	Thu,  6 Feb 2025 18:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElSm9AEN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CC419B5B1;
	Thu,  6 Feb 2025 18:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738867018; cv=none; b=NJuUK2yKtRkPYtylUS6mUDTO28VxssHADJTUm+qYKAyzNflkOwbqKn/V+C07ju2xOejrzwv+jlnDPGvBE/CtgfBRNNMPBqkSQisVdgsuIHGNOXC4NHeYREtlyNg6dhg+17YJErOwhbFhKbJ4/ZmgJ8ZsyRhORqIuHMgT8boSXpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738867018; c=relaxed/simple;
	bh=Pl/pRzWWs1PmY47A0wzBJas/w/7eDQBcATlY90AXwc0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bebhCj4q0K+vUODQphGJC8MXuhLHKjqjcq3TkygPaEs2oe/lWcyOLrLydqhhf7HQbY7uh4sJwkH8AesytLbiO8caj0kF7cGvr2PLPDRHmms3sWgevOWoaw0YlCjX1Aw4TV8AibX+RwjdAQf82A4g0gC+flTpskUF0AmraF07cb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElSm9AEN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E48D5C4CEDD;
	Thu,  6 Feb 2025 18:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738867018;
	bh=Pl/pRzWWs1PmY47A0wzBJas/w/7eDQBcATlY90AXwc0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ElSm9AENoZWQzArPWi9pVI1OGqm9SosyC+2lHceSJH1ferZ0iOs8izfBX4JTxEGz0
	 pSXBG4RlV7P1tGOeG1x7QMALVLRmKM9+2OK8oKih+9oui+etW3Po5ZNorWbcaaktcG
	 1u32SmM3RXTOy2J8HEJha/Luja5bpEI3fF01slzPyBEMXNu3DvyJRGQ+NgImXLCjAa
	 FBbBFz+IhWKAgK+6iTdMfr7yDSM3P7zzb22QRNbWwVFK9TTnIolCixG9xC03p3NO4j
	 dtIcM5y63jNei4llajYfjdFuiONOru2Kq6Tmaf3XKiGTkSGT/MKjBeuJOjut8YXDOz
	 kraUPUo0f76AA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Tamir Duberstein" <tamird@gmail.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>,  "Miguel Ojeda"
 <ojeda@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno Lossin" <benno.lossin@proton.me>,
  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  "Matthew Wilcox" <willy@infradead.org>,  "Bjorn Helgaas"
 <bhelgaas@google.com>,  "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
  "Rafael J. Wysocki" <rafael@kernel.org>,  =?utf-8?Q?Ma=C3=ADra?= Canal
 <mcanal@igalia.com>,  "Asahi Lina" <lina@asahilina.net>,
  <rust-for-linux@vger.kernel.org>,  <linux-fsdevel@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v15 1/3] rust: types: add `ForeignOwnable::PointedTo`
In-Reply-To: <20250206-rust-xarray-bindings-v15-1-a22b5dcacab3@gmail.com>
	(Tamir Duberstein's message of "Thu, 06 Feb 2025 11:24:43 -0500")
References: <20250206-rust-xarray-bindings-v15-0-a22b5dcacab3@gmail.com>
	<M_aGJpRAcPu7ika8Fb63g92-thcZeDwbTud0mNvk66mhbgXEW-iJ61eKYYxqRex_pYIhvTOloysZfMcEweamNQ==@protonmail.internalid>
	<20250206-rust-xarray-bindings-v15-1-a22b5dcacab3@gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 06 Feb 2025 19:36:35 +0100
Message-ID: <874j16kjik.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Tamir Duberstein" <tamird@gmail.com> writes:

> Allow implementors to specify the foreign pointer type; this exposes
> information about the pointed-to type such as its alignment.
>
> This requires the trait to be `unsafe` since it is now possible for
> implementors to break soundness by returning a misaligned pointer.
>
> Encoding the pointer type in the trait (and avoiding pointer casts)
> allows the compiler to check that implementors return the correct
> pointer type. This is preferable to directly encoding the alignment in
> the trait using a constant as the compiler would be unable to check it.
>
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---

Pleas pick up tags from Alice and Fiona from the configfs series where I
included your patch:

https://lore.kernel.org/rust-for-linux/20250131-configfs-v1-1-87947611401c@kernel.org/


Best regards,
Andreas Hindborg



