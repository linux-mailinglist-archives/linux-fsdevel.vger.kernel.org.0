Return-Path: <linux-fsdevel+bounces-65619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 780ACC08B2F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 07:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 554CE3B1E26
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 05:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BF827E056;
	Sat, 25 Oct 2025 05:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJVI+X5i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F0817C9E;
	Sat, 25 Oct 2025 05:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761369220; cv=none; b=NO93bRp7l0ZGYad2OBaQttSbl2+cq6HkyjnEN9LkBPYxJljBRNSGAgp0s0HfrmbU/aCh0GlF1H2CUJEqmyHwl2uAAnN+Z15pcZ8ukWQ8F29AmcTPMY+HI7WH7Hy4o4dDJbyR6LIfxhYLlwk4XA0i9zch527ckysWqWpmW2lThFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761369220; c=relaxed/simple;
	bh=1VhxwTV4sdwWSJRcuCIhvvladHFWeUlpYcqFsLM0igE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s+ZN8h3qpcFTZcLA/cUfup4f6a9I7hO8Gd5Y8itC8ygRlP3I+btKaMZp7ieXO5uyTCs4eZj4xud5ebUejtqG7m8wA/7W2xCpTum9EgYUn4A4Y861oueDVYw3TZPTIBgIKmgTiDw7N+i/XK6WdiQqs+MXtds7TdyahwpYiFdkTFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJVI+X5i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260A9C4CEF5;
	Sat, 25 Oct 2025 05:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761369220;
	bh=1VhxwTV4sdwWSJRcuCIhvvladHFWeUlpYcqFsLM0igE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IJVI+X5iwFou8KDDuBWOj4DT71xelY8qD/kWKC5M3CoBf+EPX0m8QUdmHPqw3/hkc
	 9Ij+aG+7e0DweAJPtOV34CB887xswLV/zPt7R6LDVQiP2DiMYZ/1WcXI3bQh6XPjvR
	 mGUEHnKrRvInYfik/nLX/Vf/4jod5U55GAQ0hiLtSuS5ln1eDv7ue8DkMjJDtO4X4s
	 UgAdiWCB/nmMozeEYlt1EgWB6Bup12CN8XCy5Vsbz1nn/XIivRcTPLpPTgTU+/Rxq8
	 dOwU4rs70rOwmKL12PT34LWIJEc+MrxGFcZ1gELYvlK7vyda5vO9EJy8Q6ea7W55lH
	 tRaDDhk6bygbw==
Date: Fri, 24 Oct 2025 22:13:39 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: libaokun@huaweicloud.com, linux-ext4@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz,
	linux-kernel@vger.kernel.org, kernel@pankajraghav.com,
	mcgrof@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, yi.zhang@huawei.com, yangerkun@huawei.com,
	chengzhihao1@huawei.com, libaokun1@huawei.com
Subject: Re: [PATCH 22/25] fs/buffer: prevent WARN_ON in
 __alloc_pages_slowpath() when BS > PS
Message-ID: <20251025051339.GR6170@frogsfrogsfrogs>
References: <20251025032221.2905818-1-libaokun@huaweicloud.com>
 <20251025032221.2905818-23-libaokun@huaweicloud.com>
 <aPxV6QnXu-OufSDH@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPxV6QnXu-OufSDH@casper.infradead.org>

On Sat, Oct 25, 2025 at 05:45:29AM +0100, Matthew Wilcox wrote:
> On Sat, Oct 25, 2025 at 11:22:18AM +0800, libaokun@huaweicloud.com wrote:
> > +	while (1) {
> > +		folio = __filemap_get_folio(mapping, index, fgp_flags,
> > +					    gfp & ~__GFP_NOFAIL);
> > +		if (!IS_ERR(folio) || !(gfp & __GFP_NOFAIL))
> > +			return folio;
> > +
> > +		if (PTR_ERR(folio) != -ENOMEM && PTR_ERR(folio) != -EAGAIN)
> > +			return folio;
> > +
> > +		memalloc_retry_wait(gfp);
> > +	}
> 
> No, absolutely not.  We're not having open-coded GFP_NOFAIL semantics.
> The right way forward is for ext4 to use iomap, not for buffer heads
> to support large block sizes.

Seconded.

--D

