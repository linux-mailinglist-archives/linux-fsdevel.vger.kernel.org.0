Return-Path: <linux-fsdevel+bounces-47513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54341A9F1EA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 15:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99D12176103
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 13:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DA4269883;
	Mon, 28 Apr 2025 13:15:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1617378F30;
	Mon, 28 Apr 2025 13:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745846136; cv=none; b=ntBVjvHTrWITW2km+GwEtlxkxpy+8D0YUXJoUCgFknPca1szdU4VVjNzqUKmVfTKey6ISqv8cBftHPjQ6xY/0dzG6lVbnOGSUq/R6RMqZUeWNrG2Enfb65oNmLwIOIFtyjQ2oRa5s6LDU6LWkwlL9TIQiUeirrBK26Eo+kbtzNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745846136; c=relaxed/simple;
	bh=ZVCtisApqhKOJN5ecR8RFOOqHxIcHWABToG63CUxN/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WuH8BlHiaTaB7ITK4XgRRHVCX8GNOxd8SXYle0yn4lBpVGoYppd4caykqULAPc9ycfk4TW24TUmeI7Sef6INALsIKwqYrWCIme4civgAsYzzxDrOOnUOKagQ8KAIe6OYENFHJb8z7wpI/XXUsVyj+YNMV6kQRxKsOJvsM3H3/l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 681D268C4E; Mon, 28 Apr 2025 15:15:30 +0200 (CEST)
Date: Mon, 28 Apr 2025 15:15:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kees Cook <kees@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>, gregkh@linuxfoundation.org,
	rafael@kernel.org, dakr@kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Xiao Ni <xni@redhat.com>
Subject: Re: [PATCH] devtmpfs: don't use vfs_getattr_nosec to query i_mode
Message-ID: <20250428131530.GA30382@lst.de>
References: <20250423045941.1667425-1-hch@lst.de> <20250425100304.7180Ea5-hca@linux.ibm.com> <20250425-stehlen-koexistieren-c0f650dcccec@brauner> <20250425133259.GA6626@lst.de> <D865215C-0373-464C-BB7D-235ECAF16E49@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D865215C-0373-464C-BB7D-235ECAF16E49@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Apr 25, 2025 at 08:40:23AM -0700, Kees Cook wrote:
> This isn't the case: the feature was explicitly designed in both GCC
> and Clang to not disrupt -Wuninitialized. But -Wuninitialized has been
> so flakey for so long that it is almost useless (there was even
> -Wmaybe-uninitialized added to try to cover some of the missed
> diagnostics).

I do remember a fair amount of bogus uninitialized variable warnings,
but they could be easily shut up without negative impact on the
code.  Not getting any warnings at all on the other hand is catastrophic.


> And it's one of the many reasons stack variable zeroing
> is so important, since so much goes undiagnosed. :(

That only helps if the expected but forgotten initialization value
actually is zero. 


