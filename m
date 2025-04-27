Return-Path: <linux-fsdevel+bounces-47455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77202A9E3DA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Apr 2025 17:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B89A317B858
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Apr 2025 15:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A321DE2CE;
	Sun, 27 Apr 2025 15:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DT8MhAFT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894B12C181;
	Sun, 27 Apr 2025 15:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745769495; cv=none; b=hhhYIEyyDm1aqdE0rFP9TxgfrH9k9Jk0alQ6apkgUzWeUV3jN8Z4npNHyQE69l/S2bVaP+ToSwsUTS8gCc3VEZ0Vs7wOgMRQELqLUFMhn9Ch2o2QJ310803IbR3UTtsm36pzZUUsDP+sMBAEbPTmK3LYA7yZ8LObesgJzxGmyng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745769495; c=relaxed/simple;
	bh=PRcF1wx9W5kCOh9rkrBrJyrDP1Inw4iSiEPZHDryyUw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pM8iJhtr/Lu4MLYZI3M5N14PW6Tm3W+YZSHdr4HFVNYe6HkGLaXpDvBlB2IVphKTz54HlslwtCShmv3fpseAFLqxvMsmj39OibRMxasXuR1/sLED4FnVKYMb570KS4skC72LtHwEEzVo3GngJK8dDBMfSuD5TTi4MNljorB6ob4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DT8MhAFT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2663DC4CEE3;
	Sun, 27 Apr 2025 15:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745769494;
	bh=PRcF1wx9W5kCOh9rkrBrJyrDP1Inw4iSiEPZHDryyUw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=DT8MhAFTNrm48nKrXN8HHesLD1DU12mg2OE/tHkb3ZIpGqRsjOpmnjgJqZFBE469c
	 VZ63rjSTHy1gmvXgKibXEtBbblXi3he39+zozM6LGGh/4VVyy/2QeNj6fEj2JKIH1j
	 Sx63ze/pSAwkz/qT8tEcCmMx5Qp3vsnG6te+OvBS4psCuyfoYX97jEAWGA8k0TESXo
	 QKsj4qY0nB7GLknOzxAnHpHFX6JxfegqnJHRw50tMtlm7mohWOFm1bW7BHzZF9L9ns
	 6gX5QK9v+7k0t5CZIHHdPWEEHUFAIlJx2G+RjtYfqcsYDvn9XVErfMKTCOEzSXzD2q
	 3ZMPB+BGHoUsg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno
 Lossin" <benno.lossin@proton.me>,  "Alice Ryhl" <aliceryhl@google.com>,
  "Trevor Gross" <tmgross@umich.edu>,  "Matthew Wilcox"
 <willy@infradead.org>,  "Bjorn Helgaas" <bhelgaas@google.com>,  "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>,  "Rafael J. Wysocki"
 <rafael@kernel.org>,  "FUJITA Tomonori" <fujita.tomonori@gmail.com>,  "Rob
 Herring (Arm)" <robh@kernel.org>,  "Tamir Duberstein" <tamird@gmail.com>,
  =?utf-8?Q?Ma=C3=ADra?= Canal <mcanal@igalia.com>,  "Asahi Lina"
 <lina@asahilina.net>,
  <rust-for-linux@vger.kernel.org>,  <linux-fsdevel@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v19 0/3] rust: xarray: Add a minimal abstraction for XArray
In-Reply-To: <aA5Bp3Psj7yWg9wu@pollux> (Danilo Krummrich's message of "Sun, 27
	Apr 2025 16:39:35 +0200")
References: <20250423-rust-xarray-bindings-v19-0-83cdcf11c114@gmail.com>
	<174569693396.840230.8180149993897629324.b4-ty@kernel.org>
	<-4ES_myfpiIqBRA27qXi1g19UfFVV7HMTi9wB6PA5Zs-yv3UgTg3Rnq5nnUiNWz9b1cnux0LNB7K_0t-49B7Pg==@protonmail.internalid>
	<aA5Bp3Psj7yWg9wu@pollux>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Sun, 27 Apr 2025 17:57:58 +0200
Message-ID: <87ldrl4mwp.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Danilo Krummrich" <dakr@kernel.org> writes:

> On Sat, Apr 26, 2025 at 09:48:53PM +0200, Andreas Hindborg wrote:
>>
>> On Wed, 23 Apr 2025 09:54:36 -0400, Tamir Duberstein wrote:
>> > This is a reimagining relative to earlier versions[0] by Asahi Lina and
>> > Ma=C3=ADra Canal.
>> >
>> > It is needed to support rust-binder, though this version only provides
>> > enough machinery to support rnull.
>> >
>> >
>> > [...]
>>
>> Applied, thanks!
>>
>> [1/3] rust: types: add `ForeignOwnable::PointedTo`
>>       commit: a68f46e837473de56e2c101bc0df19078a0cfeaf
>> [2/3] rust: xarray: Add an abstraction for XArray
>>       commit: dea08321b98ed6b4e06680886f60160d30254a6d
>> [3/3] MAINTAINERS: add entry for Rust XArray API
>>       commit: 1061e78014e80982814083ec8375c455848abdb4
>
> I assume this went into xarray-next? If so, you probably want to adjust t=
he
> MAINTAINERS entry accordingly.

Yes, thanks for catching that. I'm very much in the learning phase
still.


Best regards,
Andreas Hindborg



