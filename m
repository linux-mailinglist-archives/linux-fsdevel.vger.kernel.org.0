Return-Path: <linux-fsdevel+bounces-67094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A8AC35449
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 11:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB23A18C0241
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 11:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287DD30CDAB;
	Wed,  5 Nov 2025 10:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXWGrw7o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B52C2FB612;
	Wed,  5 Nov 2025 10:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762340388; cv=none; b=Y0PGwK8rY4KLjeTfq5DfpD1C+mcLKrnu5ypY8iTIUQhhNGAqh2Ghs4q/8e9Z7UPR6f6GOOoER/cLcM/hcuaPtVL1YzxbZT7ECx0Eyj/4LB2WaXd4QkEQfBC0zKr2HjYnfDnnOGu96fiwP5JeX6K/smXXS+2q60E3dD5N9pv61yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762340388; c=relaxed/simple;
	bh=Djgzz+8Wq0X5WeVDrT4jXPplb0BTE8Hmc73FCm/+xkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGqxnEsO0IV2YUCpNxnCGJ/kC9lyFLvaxwnS5/yTkp5z1Z9jbWZdd3/oMFC5W6bnEvF8qMx4xd42dCujjT4hxBBKTgU8joiQefIZVOTTlec6nksVDf36DbAAXLvlUT9DZ9gBUQNhTp4DwJnyd+QFm0JChHzrPvJKaCdX+jHmHOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXWGrw7o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F707C4CEFB;
	Wed,  5 Nov 2025 10:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762340388;
	bh=Djgzz+8Wq0X5WeVDrT4jXPplb0BTE8Hmc73FCm/+xkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cXWGrw7owhRC02vRSezQYB2vUZoCA8Cv8qp/6jh6ZXAxMRJfv9rzE3p+8DS7b9s5T
	 5hPURoqjf7lf8Hh4jWMQJoHlir+m11frEjwanyZvV9XG7hwU89owhKfhGfTYaVBtwk
	 gYxovIMS/N9QV2HybNq+8wlLJn5DTpu3I/FxQt9dRRP5ChbsGo/EcNgJD0jwflXapu
	 IHjyrqNqrMUnIluuOtGXxHyIsw8GEKaebJuU0haozLAjVVYdSMLKHRDUFAWwEZOXXd
	 nGkB2msvk5HEU0qzg/uHzqkiAQNOO4XhNvy/CdsaJ7W3PDDqArqGyBlsHxXVV9Yetv
	 iTml+nAPDu8Jw==
Date: Wed, 5 Nov 2025 11:59:41 +0100
From: Christian Brauner <brauner@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, 
	viro@zeniv.linux.org.uk, jack@suse.cz, arnd@arndb.de, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexandre Courbot <acourbot@nvidia.com>
Subject: Re: [PATCH 1/3] rust: fs: add a new type for file::Offset
Message-ID: <20251105-begibt-gipfel-cf2718233888@brauner>
References: <20251105002346.53119-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251105002346.53119-1-dakr@kernel.org>

On Wed, Nov 05, 2025 at 01:22:48AM +0100, Danilo Krummrich wrote:
> Replace the existing file::Offset type alias with a new type.
> 
> Compared to a type alias, a new type allows for more fine grained
> control over the operations that (semantically) make sense for a
> specific type.
> 
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1198
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---

What's the base for this?
If it's stuff that belongs to fs/ I'd prefer if it always uses a stable
-rc* version as base where possible.

