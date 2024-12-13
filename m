Return-Path: <linux-fsdevel+bounces-37347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C64F29F12E5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 17:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5A9416AB69
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 16:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE26917DFFD;
	Fri, 13 Dec 2024 16:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MyzzD1gz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B19B632;
	Fri, 13 Dec 2024 16:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734108545; cv=none; b=GoFH16XmQjNl2cVfJWsZYQ6C2T4/R/N4t/CoY/VyQvode2KbQylvhYhmpFdz7oZz1UiGvoA7qgMzCgSNQOvkrodw47Ae4NjnPQ/z7Be0uAkXn2uI0ElTJkgHd4vwdnJD5v1P435VcqEQhmxyDxHWT4JSLZ1TpsLtYWE8GAZyzjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734108545; c=relaxed/simple;
	bh=869hHfsCU1IKtJ+typeBokJqrcxvJ7KWf31UweXKEOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gYxaFOkmLhqSnvhfsBFzPNSwi7ZSAcTC2BbtWe8PJjNwsk2Ipk+kq3AyTR13wpMAR+pswbqk9ZR/7Tq5TrMyUzm9faBMs6RZIqDxPFucKnY39E2U3XCFqBkHWKy0fmzQlTXbXd3x66EbXc0cnXP1OXoeoPxvKiYe7acfx7/Sn4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MyzzD1gz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38692C4CED0;
	Fri, 13 Dec 2024 16:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734108544;
	bh=869hHfsCU1IKtJ+typeBokJqrcxvJ7KWf31UweXKEOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MyzzD1gz9j2zEaJa9CpCKnlNuDFs9TwpDAHVqZOScmRsPx7c778mKtj9VvE3Qz2gt
	 Xwewdpz5HOToxzuZkLl3cG7+uTjV7jRJIjCuVost27+jjU/15mBfnuOwdek176+Y1B
	 K0uDkPqORScd+6o1x9Thf6a9TwiU/rt7kjLQ5Jc5vtS0MkJiS5TmBxdcn4dgItcFIq
	 0H3+K1c+Ge2uFU7SYlkQJOZ2wXl71cVTtrTdbYRDVzCulyMmkykDQ4wqise3mLvji1
	 sjVCJw9H4bYaLWxKyfPAF7YM7cI3guwGH0HsEbNBKg+s05SpYTtyxH4FEEQnZIVTvR
	 sDhF3WBikg8ZQ==
Date: Fri, 13 Dec 2024 16:48:58 +0000
From: Lee Jones <lee@kernel.org>
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
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] rust: miscdevice: Provide accessor to pull out
 miscdevice::this_device
Message-ID: <20241213164858.GE2418536@google.com>
References: <20241210-miscdevice-file-param-v3-0-b2a79b666dc5@google.com>
 <20241210-miscdevice-file-param-v3-3-b2a79b666dc5@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241210-miscdevice-file-param-v3-3-b2a79b666dc5@google.com>

On Tue, 10 Dec 2024, Alice Ryhl wrote:

> From: Lee Jones <lee@kernel.org>
> 
> There are situations where a pointer to a `struct device` will become
> necessary (e.g. for calling into dev_*() functions).  This accessor
> allows callers to pull this out from the `struct miscdevice`.
> 
> Signed-off-by: Lee Jones <lee@kernel.org>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/miscdevice.rs | 11 +++++++++++
>  1 file changed, 11 insertions(+)

This might be superfluous, but:

Tested-by: Lee Jones <lee@kernel.org>

-- 
Lee Jones [李琼斯]

