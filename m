Return-Path: <linux-fsdevel+bounces-37485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 472B09F303A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 13:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FF0C7A35A3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 12:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57AE20551B;
	Mon, 16 Dec 2024 12:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7GxRNSI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0889F2046B2;
	Mon, 16 Dec 2024 12:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734351095; cv=none; b=aGpIsj1Zw6AHiQcPzR5dfbmHnCXO1LIzHKunqlklV5gmoaIzO9YJDDPPVYJ8dZPhWLiw/xSrzRvDd5ZyNkxhiaYSuqoQsm+X1s/mlenBYurcSV49PzQIMobaLm3GnbYmfB4CDpO93p+6v6ny9XMAK3ZpJ8NtcRyX54a37UIbCLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734351095; c=relaxed/simple;
	bh=ciQCs46G5sP2n0VuQw3RaBYOH04XxMT9t62CwWEmgVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kc280EaLSmD7KuiIrf31GGK3cJ0g9RoHQDH5OLpkiMhjkO3cGGUYjr65lQ5y+Ed7Pko7ONJDnPkejmhBkIiimT/KQrf9YrHxvPJWTm1zRKyLvyapgZDisUf16wyxvhwZjV7BHJqmLrvYKqP0HM5hK1zgrj6vzL8BSDbh6tuP1nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7GxRNSI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD6FFC4CED0;
	Mon, 16 Dec 2024 12:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734351094;
	bh=ciQCs46G5sP2n0VuQw3RaBYOH04XxMT9t62CwWEmgVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l7GxRNSIk1Afq65WH5PkH8PCsoT7vQJVWefnlgKwbUMgtJdB6SSE8JQ2d1aQwzV4n
	 uklRpKkXP2LaD/x/Lo2ZPnG0TQ9N9CXSobFkNbWTGesbtrFXFRt0uaJ11s9PoI2MRX
	 4XCiLWNZt//8meflzxxfVrOQlz+RIlJn2/O4ctdoae+8EFlfSyMl/eDjiU7KbYyEv7
	 TckEuaj07TWEjfkqqu9iHhbeOPDWGnSUeu+gbMLug+LOKhvOg/e4Luw5af5o2S++qI
	 QFDZEf3Nt3+rzxgN52eXusaK/VDPivBUfcyyvYm0OyhYO8qgG4VrCGngYOGZYENH13
	 yQNjuXmxk4tgw==
Date: Mon, 16 Dec 2024 13:11:28 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>, Lee Jones <lee@kernel.org>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Additional miscdevice fops parameters
Message-ID: <Z2AY8D3pni7wxWD1@cassiopeiae>
References: <20241210-miscdevice-file-param-v3-0-b2a79b666dc5@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210-miscdevice-file-param-v3-0-b2a79b666dc5@google.com>

On Tue, Dec 10, 2024 at 09:38:59AM +0000, Alice Ryhl wrote:
> This could not land with the base miscdevice abstractions due to the
> dependency on File.
> 
> The last two patches enable you to use the `dev_*` macros to print
> messages in miscdevice drivers.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

For the series,

Reviewed-by: Danilo Krummrich <dakr@kernel.org>

> ---
> Changes in v3:
> - Fix build error in fops->open() patch.
> - Improve wording of some comments in fops->open() patch.
> - Update commit message with more info on why `struct miscdevice` is
>   only made available in fops->open() and not other hooks.
> - Include Lee's device accessor patch, since it's a needed component to
>   use the `dev_*` printing macros with miscdevice.
> - Link to v2: https://lore.kernel.org/r/20241209-miscdevice-file-param-v2-0-83ece27e9ff6@google.com
> 
> Changes in v2:
> - Access the `struct miscdevice` from fops->open().
> - Link to v1: https://lore.kernel.org/r/20241203-miscdevice-file-param-v1-1-1d6622978480@google.com
> 
> ---
> Alice Ryhl (2):
>       rust: miscdevice: access file in fops
>       rust: miscdevice: access the `struct miscdevice` from fops->open()
> 
> Lee Jones (1):
>       rust: miscdevice: Provide accessor to pull out miscdevice::this_device
> 
>  rust/kernel/miscdevice.rs | 66 +++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 55 insertions(+), 11 deletions(-)
> ---
> base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
> change-id: 20241203-miscdevice-file-param-5df7f75861da
> 
> Best regards,
> -- 
> Alice Ryhl <aliceryhl@google.com>
> 
> 

