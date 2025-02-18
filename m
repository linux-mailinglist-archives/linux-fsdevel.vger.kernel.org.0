Return-Path: <linux-fsdevel+bounces-42006-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA2DA3A117
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 16:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16BFB188BA25
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 15:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F1526B96C;
	Tue, 18 Feb 2025 15:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWQce89l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7881F26B09B;
	Tue, 18 Feb 2025 15:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739892280; cv=none; b=k9ttj28rxFERDvyjOBwvPMBu6JoIMfuQYdqKPciNEFo/mtkB1UsYMP1Zok8fa/dtVVnBGIV2kvVo+fzlAdqmSftiP9/lg+59idKKsAwoCc+KwI5vZlBI2oY+lITiYdPBokz9sY9544vHBy3qNmhOHZSl0wOpyFwCajf0b/OmOt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739892280; c=relaxed/simple;
	bh=TB4nv8hn+O/HSxNWQn+GodE7JrdKRLhqMpoEBtPoIuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VgslxscEuNDkOU10TEcV/YiMGCv0f8T1RmbxFJ9msXf1kf7HKKLdEJmfjDPfFFDQH1Khtc0FW7MAa21Yrcxpj0tEKYu/qCPN4FU9iue4b+C7d50VjzrYbmpOSuAmI08iw7L3yxoCMo0z88R+XTSqti5oLEffbdUEKwmQyP/D3VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWQce89l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1000C4CEE2;
	Tue, 18 Feb 2025 15:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739892280;
	bh=TB4nv8hn+O/HSxNWQn+GodE7JrdKRLhqMpoEBtPoIuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eWQce89l5hCWid+82f3s1KD/CfccKWGp+s+7ayW71dT/5p95y7sbwbqNTO/ps3RCa
	 CTvWkPaGaqex5pMqUEKhbLTRRcB8UKp8CD+f25NWjKtVwNU05E5PmHdFaxoPg/csos
	 FE+hUb7XHC8NTPi3FRtbTveLMY3y+m9eMlC2+6l7cnmmRdNN0jWaUWTCcvfwiONv+M
	 /D7jEevk9cyGcTMBBH63KJ77xOqxasnpVA0JUMwLXPZe+4ynym9e3TIe4F5f/LRL+q
	 e9s04oUfKlzwpdVd1lb4fR9AgAztia50tF6Z67GS1QgZIpCKKQKOQ4KKeAtxraLBxQ
	 4CcOUwdomhH3w==
Date: Tue, 18 Feb 2025 16:24:33 +0100
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
Subject: Re: [PATCH v17 1/3] rust: types: add `ForeignOwnable::PointedTo`
Message-ID: <Z7SmMdl5Hl_CRAzs@pollux>
References: <20250218-rust-xarray-bindings-v17-0-f3a99196e538@gmail.com>
 <20250218-rust-xarray-bindings-v17-1-f3a99196e538@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218-rust-xarray-bindings-v17-1-f3a99196e538@gmail.com>

On Tue, Feb 18, 2025 at 09:37:43AM -0500, Tamir Duberstein wrote:
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
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Acked-by: Danilo Krummrich <dakr@kernel.org>

