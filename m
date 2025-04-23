Return-Path: <linux-fsdevel+bounces-47090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10004A98AE9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 15:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B2B41B66634
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 13:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F3217A31D;
	Wed, 23 Apr 2025 13:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rfhm+UsN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AAE1624DE;
	Wed, 23 Apr 2025 13:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745414662; cv=none; b=NH/55FRWHEYLoYlXhsMWcFSlTwjEfvbTE4q5TH8S020Kv9oCQtB13L6riYiCgSG+IF3YHv6Yvr4iyW2XsAp5KJRgsb6sOD4+aSm4HnY+DwuWs1zUjw376Ua3sUKwY2yliDY5WEGVgHae3shNJmZ6Xrx2sWM3aLSYv/cNurmaNU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745414662; c=relaxed/simple;
	bh=hfZgyjx3DsKZ3Dg050Yv997kK6y+fVdnQqZRcRk7DNI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LvtEfgRrvA5+RQO3PkzbBSP3Z3/HkKuMxck+J1+7ehOSQ8fCiV9uL6xk6pz+HYlnYZtDIuOuGM/mvxnFAsBXXaoUq6jYQZAQrjXiU0VAd7VQQ4xre/lssd+4hR97bLaTClqLXWCG3k5+59LBKN5acvm7tqzgAC/lM3JMhMzXiE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rfhm+UsN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE23C4CEE2;
	Wed, 23 Apr 2025 13:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745414661;
	bh=hfZgyjx3DsKZ3Dg050Yv997kK6y+fVdnQqZRcRk7DNI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=rfhm+UsNLwGa5dgzq6N5a/AN1uY6D+kWd2cJfPcKyHEycC1OzcYC22ErHO+kkoYHM
	 U6TvuXLOLdFhRSJRPhsdfqxcwNO0X9f7Q1vnV8Sk0vrXnBxJkWp5G4OjT9qL3QrloU
	 uapJbwcZ8NRmGjixU4hW0ehRqTElS8gZzZeaPLRopunpJV5wXDZ8cP2idRjuObpJkk
	 5JREjkXVR2NhKWv6rC4ZMK9PdPI81YwhjgbyKMdeVy3bTtq7wqvCKfkqTYMHuZUb7u
	 URRd6R1gpKkPpivZ77zftx7tdt95xvu+5S+e0ixhBjPp7XKa+u6ZDpmORzSGlYYwF1
	 3T/w3zk6eCyLA==
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
  "Rafael J. Wysocki" <rafael@kernel.org>,  "FUJITA Tomonori"
 <fujita.tomonori@gmail.com>,  "Rob Herring (Arm)" <robh@kernel.org>,
  =?utf-8?Q?Ma=C3=ADra?= Canal <mcanal@igalia.com>,  "Asahi Lina"
 <lina@asahilina.net>,
  <rust-for-linux@vger.kernel.org>,  <linux-fsdevel@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v18 0/3] rust: xarray: Add a minimal abstraction for XArray
In-Reply-To: <20250221-rust-xarray-bindings-v18-0-cbabe5ddfc32@gmail.com>
	(Tamir Duberstein's message of "Fri, 21 Feb 2025 15:27:39 -0500")
References: <30REU2ajXLw46ECdobmT6O2N2vu7_MqsQik95FbqPQgT1Pf13PKYBVQOR4vTVvODo1kTBB0U06LjX3C3HGF5kQ==@protonmail.internalid>
	<20250221-rust-xarray-bindings-v18-0-cbabe5ddfc32@gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Wed, 23 Apr 2025 15:24:08 +0200
Message-ID: <877c3bko3r.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Tamir,

"Tamir Duberstein" <tamird@gmail.com> writes:

> This is a reimagining relative to earlier versions[0] by Asahi Lina and
> Ma=C3=ADra Canal.
>
> It is needed to support rust-binder, though this version only provides
> enough machinery to support rnull.
>
> Link: https://lore.kernel.org/rust-for-linux/20240309235927.168915-2-mcan=
al@igalia.com/ [0]

Can you respin these so they apply on v6.15-rc2? I hope to stage them
for v6.16 merge window.


Best regards,
Andreas Hindborg



