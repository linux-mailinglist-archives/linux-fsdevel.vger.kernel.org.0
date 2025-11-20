Return-Path: <linux-fsdevel+bounces-69296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BCBC7683D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 23:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4AB62350353
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 22:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD9234321A;
	Thu, 20 Nov 2025 22:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pW9dY9CE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2951305963;
	Thu, 20 Nov 2025 22:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763677970; cv=none; b=U7nLzBW/RwVx2bs5xb2bevWcAHpH6JX1NCS9ThfOFwmPFaNiyGS/ZEFYYA0wer1YxauWfAlmWkSkYnKZf1TTewrH/RvDE//R52tfiYlkLj6CLGMLoOCZFnuz7gMGcnDy8bRCHymdi74MEXBFd5gLWG3ULQ9jlkmvx34Zrp4ocn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763677970; c=relaxed/simple;
	bh=/XFD8n5SyOrLkA6fCYNpJSe3Aq4hZzQsouSjrLNF0fQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jlfvTEc7SPgW9Z2eXDq+y/kFU1zjpgnSH2nKMKnUpZ5tzQxVordwlUj1VvkAEi+mDBd3rLZhh/8/rLyvobPcDQEUOuuonT13EhCD9ysxXZhkjIrjzgVbN+KY/W5Tt30cBvPTGnIPAjG4k1TtxuRhAomg3GXTCW9nITImMooCImw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pW9dY9CE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7295EC116B1;
	Thu, 20 Nov 2025 22:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763677970;
	bh=/XFD8n5SyOrLkA6fCYNpJSe3Aq4hZzQsouSjrLNF0fQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pW9dY9CEreZ+MoHtlQi5g/zOHjZTNGQqO3mbyuA3/qmGux0xITBV/FZcShYVhLG4h
	 gemth7ymkBX/iNQbQWq0aNio+Nw1mbtEsOgmW766rPmXvBt9aK4FoAYb3gkPxqU2yy
	 2aowhm5LaNM6sJ7l5VV63wRD/rsiImFYZp10E5oFDxti4tHpbqoUjNKhn4q8zL/F/J
	 T1/nBuTE49iRsHM28via7Je3wq2AKfOKqaxJ/4rasPUxZDUHyw+mdczBiBEnrakxET
	 9swCsJlGRxfxnKahTsYbM2Uw02kBZ94DHHhDGf8UWd1HqghsM7TjD49rgOTQQJk/5Q
	 e6YRNY7KYT5ow==
Date: Thu, 20 Nov 2025 22:32:48 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-crypto@vger.kernel.org, linux-btrfs <linux-btrfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	Daniel Vacek <neelx@suse.com>, Josef Bacik <josef@toxicpanda.com>
Subject: Re: Questions about encryption and (possibly weak) checksum
Message-ID: <20251120223248.GA3532564@google.com>
References: <48a91ada-c413-492f-86a4-483355392d98@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48a91ada-c413-492f-86a4-483355392d98@suse.com>

On Fri, Nov 21, 2025 at 08:28:38AM +1030, Qu Wenruo wrote:
> Hi,
> 
> Recently Daniel is reviving the fscrypt support for btrfs, and one thing
> caught my attention, related the sequence of encryption and checksum.
> 
> What is the preferred order between encryption and (possibly weak) checksum?
> 
> The original patchset implies checksum-then-encrypt, which follows what ext4
> is doing when both verity and fscrypt are involved.
> 
> 
> But on the other hand, btrfs' default checksum (CRC32C) is definitely not a
> cryptography level HMAC, it's mostly for btrfs to detect incorrect content
> from the storage and switch to another mirror.
> 
> Furthermore, for compression, btrfs follows the idea of
> compress-then-checksum, thus to me the idea of encrypt-then-checksum looks
> more straightforward, and easier to implement.
> 
> Finally, the btrfs checksum itself is not encrypted (at least for now),
> meaning the checksum is exposed for any one to modify as long as they
> understand how to re-calculate the checksum of the metadata.
> 
> 
> So my question here is:
> 
> - Is there any preferred sequence between encryption and checksum?
> 
> - Will a weak checksum (CRC32C) introduce any extra attack vector?

If you won't be encrypting the checksums, then it needs to be
encrypt+checksum so that the checksums don't leak information about the
plaintext.  It doesn't matter how "strong" the checksum is.

- Eric

