Return-Path: <linux-fsdevel+bounces-46305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F236DA86763
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 22:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8E769C0F4D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 20:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3088128CF60;
	Fri, 11 Apr 2025 20:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tq/AgWwJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C7178F45;
	Fri, 11 Apr 2025 20:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744403994; cv=none; b=U0uUGCoJZrxhQDRUnUVR6Ocizi5mi6sJdj9rSBzi7pH2/BOPmdjDZaaKlbTbX/xie006azJhGr6S5aakeivU9sNBzNLdT/ahGehGp4UfjFMZ/nJckM2GqxJPzlCvQoNtTUGNaKe9dxqMUmH+H38P8hFlnJ0KB7VAe8YP23wydrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744403994; c=relaxed/simple;
	bh=O+gVIz8enFbvRjxP1RktrTCu06kj4Lx0FjhATgpFyWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YkitBJms3aLj7ztKKd55d8M+n792Pdu1ndWseVEVcUsEjQFc5dc3xpx2g0FMpbkuAa9X1Ir/v83CE4RMNqXCdzGTp+xXj4VzIKgwVYjr8m2mkF+UN/kLpFXvqjteoLz+WoVjO+ZFYu5JBgshIsi+PqvnmVLInNgnezzGLW7mroE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tq/AgWwJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 046D2C4CEEB;
	Fri, 11 Apr 2025 20:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744403994;
	bh=O+gVIz8enFbvRjxP1RktrTCu06kj4Lx0FjhATgpFyWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tq/AgWwJiKMKLsnJt4hwakmk32CZ6piiP/zfo3Svb6rXe4kwHOHB6UNEcgcOsc4ve
	 tDn5xaesH8uEKRGMtqHN84Mc9ktgpSDGjBtfKr9rd5wXi2AiaeQFtmnu0AvAbK+YoX
	 pDlTi8R8x4Ji2uINsSQvX1KJjb1PeuQGa08IOu+mSNnbMrUJedWUm/dJz/9zZSKUxH
	 yUDMju19IJryspXNwRVlVbLDxwLVedbbmiH2FQfzGVXEIEh7HzPpJ2SQPy6lvc1YM+
	 arem2zAw1QEiYLKSEuqKcttpaB666wiNW8Ra8f2Ln9kHwqSj5etGtJu2G7z1y0bv+U
	 86SvEJHwgSulg==
Date: Fri, 11 Apr 2025 13:39:52 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	linux-block <linux-block@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	xfs <linux-xfs@vger.kernel.org>
Subject: Re: Weird blockdev crash in 6.15-rc1?
Message-ID: <Z_l-GLzyqwXFAq0_@bombadil.infradead.org>
References: <20250408175125.GL6266@frogsfrogsfrogs>
 <20250409173015.GN6266@frogsfrogsfrogs>
 <20250409190907.GO6266@frogsfrogsfrogs>
 <Z_d13yReJn2vqxCL@infradead.org>
 <20250410152554.GP6307@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410152554.GP6307@frogsfrogsfrogs>

On Thu, Apr 10, 2025 at 08:25:54AM -0700, Darrick J. Wong wrote:
> Heh.  Why does xfs still call set_blocksize, anyway? 

Hrm. That's called from xfs_setsize_buftarg() so the buffer target, and it
uses a different min order. We have logdev and rtdev. I just tested and
indeed, a 32k logical sector size drive can be used for data with for
example a 512k logical sector size logdev.

  Luis

