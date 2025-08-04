Return-Path: <linux-fsdevel+bounces-56696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB95B1AB1D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 00:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF737173CDA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 22:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433A6291C11;
	Mon,  4 Aug 2025 22:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fp2Z4bN0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E580291882;
	Mon,  4 Aug 2025 22:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754348232; cv=none; b=CBJmDJUx8YyKwSziJoeaZQCbUW7qw4Ah9z4/plxOePQpmlwyx+dzOjCN0tewRnHpDxY9WN4GLxM4wMDQlV9igQ9vBodgwecG6SmhHR+uLA7I1GrRQpk/hc0L0P+5NMcLtWPBEKtMaLUDz/trNuf8rzcjqXMkJps/iDKRy6q8fds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754348232; c=relaxed/simple;
	bh=8sop6D/1PDWvsWvtUXyDsayywtKtHpvkilZcpXuGZWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0nbIKFumE7Y73dYlrlrdlhYP5h/yvwSVw/VrQf8ndrbO4/qdQeAd1bMHuShJbH920SggmFdonkIFqmYSz/ZO8ei/zXxSPWXHX/e8RGHH8BTqbwN5slL9PRBlV0r9P+k0YLW3EcEU+eexgZn0O9MBEHVQhqEIzph66YEbvBwxvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fp2Z4bN0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 565E5C4CEF0;
	Mon,  4 Aug 2025 22:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754348232;
	bh=8sop6D/1PDWvsWvtUXyDsayywtKtHpvkilZcpXuGZWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fp2Z4bN0byH7UQQ+I3AsZDyknRWX0cREYD5PTt3SvwCPWqGqjYWrUZf3WTssb9MEo
	 L21qO5dKKMCw/zah0KaengYwISwFSDlYK4AEG7ykZ0VvMzM6mrDdocX+ZEDnRzEOOF
	 HzqzfUxpnpX+iEPmL0dPImUVdZN1ooxcgQaNjY5RJTBtp0SBgD2CUHKG80Az0n6UuY
	 o3BHOl/ppD5Lv6sQtDt614TL6yBpkK3WWvwKpGlTqwP7ylHjgp2Ho5k2FB8iNvejmI
	 rAB9UogKx1jZKvNd3JLFXsw5Xx5hNgyJHFHWqS+6pCMy2vKz3Fh4iQpHDQvYEDC0+v
	 +vzXiKbmzpvGA==
Date: Mon, 4 Aug 2025 16:57:08 -0600
From: Keith Busch <kbusch@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	axboe@kernel.dk, dw@davidwei.uk, brauner@kernel.org,
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 7/7] iov_iter: remove iov_iter_is_aligned
Message-ID: <aJE6xAsSjHxVExKX@kbusch-mbp>
References: <20250801234736.1913170-1-kbusch@meta.com>
 <20250801234736.1913170-8-kbusch@meta.com>
 <aI1xySNUdQ2B0dbJ@kernel.org>
 <aJDAx1Ns9Fg7F6iK@kbusch-mbp>
 <aJDQ1GPV5F5MB1kP@kernel.org>
 <aJEzrzWgso2TwRaX@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJEzrzWgso2TwRaX@kernel.org>

On Mon, Aug 04, 2025 at 06:26:55PM -0400, Mike Snitzer wrote:
> FYI, I was able to avoid using iov_iter_is_aligned() in favor of
> checks in earlier code (in both NFSD and NFS).

Excellent! I promise removing the extra iteration is totally worth it. ;)

I just know of one error case bug mentioned in patch 2, so unless I hear
anything else, I'll spin out the new version with a fix for just that
tomorrow.

