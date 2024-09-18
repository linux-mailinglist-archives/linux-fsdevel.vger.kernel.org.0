Return-Path: <linux-fsdevel+bounces-29667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B40797BFB7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 19:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CAEA28371C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 17:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4431C9DCB;
	Wed, 18 Sep 2024 17:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XvvvBJcW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD601494B1;
	Wed, 18 Sep 2024 17:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726680800; cv=none; b=b6W5XScSYghYEO7Cl99ACW1ZhCiZYXdLd29mH1gFxh77n39hZyK3OcDOxv3sbBzd6edUx2RitnxizrKWCG6PIvMYr0M9lIZc3Z3BqpnphpVarQ0O7BY5226CFqYuHnovZADy4sTYRh5REpFE7G2c/zkVlt0tcgP9WeDoho5fvsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726680800; c=relaxed/simple;
	bh=tIFJ/CuP9h6xL+Bwi/PuiYNFKtcMe9v3Ai36kNvOrSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NvWSHnKkg+UCPs1vM1FTYVZTATG9C2HF9nxueQCeYBpeaDPrFcO9RBIg2HtlBkKRaS/0rNR5DDKKAws74SnVH/bmrwggFcqbHl6pnFXm7Gl48Y/6SZGPslMDRzY00/GHo209yDowPwKlOf7AjMx3Hh4DANr58uxbf8wMoWjdgbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XvvvBJcW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E08B7C4CEC2;
	Wed, 18 Sep 2024 17:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726680800;
	bh=tIFJ/CuP9h6xL+Bwi/PuiYNFKtcMe9v3Ai36kNvOrSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XvvvBJcW23WDUtpy5y30x89DQ6zc6ZpSCf01kBObo1dq02eCHGLbrxzEdrNM3p/fn
	 G/m0EiFSA9lQg2/pMPoBdZJ+uQI7KDm+wp1jEbsowfRrWFs6abwLbVOLMCy3L2RQFQ
	 nS5cDUewRV2F1igYTjI4dAjBh88J96nFKlOr3nd0=
Date: Wed, 18 Sep 2024 19:33:18 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: shankerwangmiao@gmail.com
Cc: stable@vger.kernel.org, Xi Ruoyao <xry111@xry111.site>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] Backport statx(..., NULL, AT_EMPTY_PATH, ...)
Message-ID: <2024091801-segment-lurk-e67b@gregkh>
References: <20240918-statx-stable-linux-6-10-y-v1-0-8364a071074f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240918-statx-stable-linux-6-10-y-v1-0-8364a071074f@gmail.com>

On Wed, Sep 18, 2024 at 10:01:18PM +0800, Miao Wang via B4 Relay wrote:
> Commit 0ef625bba6fb ("vfs: support statx(..., NULL, AT_EMPTY_PATH,
> ...)") added support for passing in NULL when AT_EMPTY_PATH is given,
> improving performance when statx is used for fetching stat informantion
> from a given fd, which is especially important for 32-bit platforms.
> This commit also improved the performance when an empty string is given
> by short-circuiting the handling of such paths.
> 
> This series is based on the commits in the Linus’ tree. Sligth
> modifications are applied to the context of the patches for cleanly
> applying.
> 
> Tested-by: Xi Ruoyao <xry111@xry111.site>
> Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>

This really looks like a brand new feature wanting to be backported, so
why does it qualify under the stable kernel rules as fixing something?

I am willing to take some kinds of "fixes performance issues" new
features when the subsystem maintainers agree and ask for it, but that
doesn't seem to be the case here, and so without their approval and
agreement that this is relevant, we can't accept them.

thanks,

greg k-h

