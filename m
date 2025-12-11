Return-Path: <linux-fsdevel+bounces-71167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C70CB7667
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 00:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE520301D5AC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 23:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E57828B3E7;
	Thu, 11 Dec 2025 23:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VsTXuHoV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CAB188A3A;
	Thu, 11 Dec 2025 23:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765496514; cv=none; b=oFm8x+MAjhbR3L0swh+M5eipBcsFbc7IgbH4xZ7kMU6mDZ3pNv/JzjGG1615BAz7ibrojJ/9a4SloSSqoeAuRZTSlLaRiB6Trib2HIKdMZnRMmpQMET3x40XhnFHZF6rU0cJI46BSTj0HEET2I+NhabtbQhLZSnjUMppfM6B0dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765496514; c=relaxed/simple;
	bh=CR3ZEiMwY3TTyqg2vdjOCFXXqKz1Yye1dWRZpqXf0jA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PXQ0o/voNiK5wkk7XyxuFcKiIYUK7N9ixn6yX4HQeRO56RigCeZLATU0KxtXnkTqia2g0eiq5Q9A8HC+sWy77YJQaM80mgBNcRQ8u5kkHCWd759HKRE83WNZ7Jf0z1jylkyG76Q6HBMp5a2A1P8YKFVpecSJaOIayKiasxZKJ5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VsTXuHoV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE89FC4CEF7;
	Thu, 11 Dec 2025 23:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765496514;
	bh=CR3ZEiMwY3TTyqg2vdjOCFXXqKz1Yye1dWRZpqXf0jA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VsTXuHoVQt6RAgHp6d+QrAV/+IPiryqpoxXMomjd33RQuWxQxOILmCQPchvcVeFAL
	 WLQMf9HU6p7cKik/ruTPhvItp5UuGKk0XCaKljNV6RKaDdPJiLrbi+CZ/lmUlvkMyE
	 lWvD+dCCAldQjxysgKjxdYLekybXNkzCtHXkmCDM7eNS66V1YW61ZOjprnDKLQ5Ao6
	 wbth60KfTwjOC4Nu69XhoILwD2tLsEnl3KxCSLHn9WdTZTcepc9uaY/0C9zCt2o5fH
	 R0CZ22WJhJmS75GfT09GzSD2rfAkGTc6j1FQKN/iYQ2JuWYh5+fmNEe+MJy4F01IUB
	 4qjOb2LDVTCZg==
Date: Thu, 11 Dec 2025 23:41:52 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	hirofumi@mail.parknet.co.jp,
	almaz.alexandrovich@paragon-software.com, tytso@mit.edu,
	adilger.kernel@dilger.ca, Volker.Lendecke@sernet.de,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v2 1/6] fs: Add case sensitivity info to file_kattr
Message-ID: <20251211234152.GA460739@google.com>
References: <20251211152116.480799-1-cel@kernel.org>
 <20251211152116.480799-2-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211152116.480799-2-cel@kernel.org>

On Thu, Dec 11, 2025 at 10:21:11AM -0500, Chuck Lever wrote:
> +/* Values stored in the low-order byte */
> +enum fileattr_case_folding {
> +	/* Code points are compared directly with no case folding. */
> +	FILEATTR_CASEFOLD_NONE = 0,
> +
> +	/* ASCII case-insensitive: A-Z are treated as a-z. */
> +	FILEATTR_CASEFOLD_ASCII,
> +
> +	/* Unicode case-insensitive matching. */
> +	FILEATTR_CASEFOLD_UNICODE,
> +};

What does "Unicode case-insensitive matching" mean?  There are many
different things it could mean: there are multiple types of Unicode
normalization, Unicode case-folding, NTFS's upper case table, etc.
There are also multiple versions of each.

I see you're proposing that ext4, fat, and ntfs3 all set
FILEATTR_CASEFOLD_UNICODE, at least in some cases.

That seems odd, since they don't do the matching the same way.

- Eric

