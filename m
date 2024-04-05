Return-Path: <linux-fsdevel+bounces-16150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 263F989939D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 05:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB9CF1F22605
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 03:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E8C18E1D;
	Fri,  5 Apr 2024 03:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyNOT7qy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBB1134A9;
	Fri,  5 Apr 2024 03:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712286554; cv=none; b=IM1ryCuJy/oWvfe3W1YzAgUWVv3CcBuJKPxiENroQCPZ3PFI6Ng3E1jqEBU2tihi3d/p91XXQcX7iP23Rs6/Ll4Fy6H1E4cXqJKov3enOReIPdFYlciE/beuSo71SjjAUAUjunHjF5Jpg2Arxe0CvXZ21GT+N1axM4bHz/pdiSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712286554; c=relaxed/simple;
	bh=SO+Zd8wRflBZFgTbN19FRmYwYbK/BlfHAER+ctHttZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bH2sGtFb0OxxZHc/nJpbeikFwoBJJo0wl0s7YEajp871aqc3HDjRm/1kLal88Zo/BA65K6EfDXg0IBtgvu+npELrNolLoeg2Ni+KLpCtgJIxfVU4aX8NBmjE1YLuMuzBszOBPtMhTmNvlxHEsDQN0Mc5YYSWoIg3flN7722vaY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyNOT7qy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD43BC433C7;
	Fri,  5 Apr 2024 03:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712286554;
	bh=SO+Zd8wRflBZFgTbN19FRmYwYbK/BlfHAER+ctHttZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hyNOT7qy5UUMQxBJ4CBbv8GJltpJLuJvJhFzcIZi3O6RwKeCF8j4gKLyFjwy00Xyl
	 pi5CZEvFG1WG4q1Tu8otRDYyFLZX5kebxHdAR1TC61BAq3tiyqfso7udrpOkuKdxJW
	 YmwDVO3dUZLnvfzT8r5SVcvC0lLiLQ2XSZ6rS4LbiYpVuEmYWaUr86ikkSHX5jPqUY
	 CEgLXmQdOGmPEUAbnG8RQzQ+SC3RXcef4F8MBTHGXtmv2ChImFdMvK+z7ExQ1l8Fnw
	 MT7kpOkwTPbeyqZZpQfP0HDcnWEXTEsw5Kckrca38x4J3fZh+ZAS5YGC7estJO5C9I
	 ov5IdKC2wJqdw==
Date: Thu, 4 Apr 2024 23:09:11 -0400
From: Eric Biggers <ebiggers@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: aalbersh@redhat.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH 11/13] fsverity: report validation errors back to the
 filesystem
Message-ID: <20240405030911.GI1958@quark.localdomain>
References: <171175867829.1987804.15934006844321506283.stgit@frogsfrogsfrogs>
 <171175868048.1987804.2771715174385554090.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171175868048.1987804.2771715174385554090.stgit@frogsfrogsfrogs>

On Fri, Mar 29, 2024 at 05:35:32PM -0700, Darrick J. Wong wrote:
> +	/**
> +	 * Notify the filesystem that file data validation failed
> +	 *
> +	 * @inode: the inode being validated
> +	 * @pos: the file position of the invalid data
> +	 * @len: the length of the invalid data
> +	 *
> +	 * This is called when fs-verity cannot validate the file contents.
> +	 */
> +	void (*fail_validation)(struct inode *inode, loff_t pos, size_t len);

There is a difference between the file actually being corrupt (mismatching
hashes) and other problems like disk errors reading from the Merkle tree.
"Validation failed" is a bit ambiguous, and "cannot validate the file contents"
even more so.  Do you want only file corruption errors?  If so it may be a good
idea to call this 'file_corrupt', which would be consistent with the
"FILE CORRUPTED" error message in fs/verity/verify.c.  Or do you actually want
all errors?  Either way, it needs to be clarified what is actually meant.

- Eric

