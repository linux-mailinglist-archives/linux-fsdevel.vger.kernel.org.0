Return-Path: <linux-fsdevel+bounces-43212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F520A4F6D0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 07:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A62A16D39A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 06:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F141D7985;
	Wed,  5 Mar 2025 06:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Wdqb53XN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F323F2E338F;
	Wed,  5 Mar 2025 06:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741154672; cv=none; b=S7mnhwAQ9PkIxBUpOp20sArTICibCwdvV1qupVu06xdQzEvVKJQY+hLtkqT8memb/IR6RtD4cdauZkFkqrlh78kB6gwuqeUcNmyK7mghGm0wE2Zt3Ne1sTVQgzBRmzPE833OnFH8wbDmG6ok/8f9uxIyaOB1bDqFM+NUBMt6gGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741154672; c=relaxed/simple;
	bh=OXph4ujJlPsqqPzhhrB3GYYsGtqeypRxXEPTIotWMLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPlbKnfIm7/GyWd0Xwng2j5YE9me3ITQMwns//vgD9In0vLJBMPbq3FcGTF4oPg7reIwLyWA72G1F0EG2nosii/GE1yZy42XtGX1Iq4qdLdvvvZ30D1irNb/dQlEidSy5QE/CQ/66T8EQIxFdZQTh9T7AcEk5fmxbeNUBbI5hww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Wdqb53XN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5rAW3kna2L/oLcwpIx54HiaaUQE+mm7gEUx3fbSEXoY=; b=Wdqb53XN7+C0d0dv1rFuLy+uC0
	tY+ao74Dj+jOWwKMyPUem123vE8hj+9ktII7rPuVfwUFQTMkrJiYHKtdhD7AJZNL53tmSgJ23PevV
	lj/YjCajWJBd/cO1Y+7c4d2q7/YtlvuiRZS9qDKRGtP3y/RznFlLm3mEP8xXJS5wdotG5VAJ/EVW6
	HQCRez5uIocC76trRGzPsAEhwUOIo7YNL5Ig6N2zb6g3cMjlSli58n7Xi9Mec4LP+yYuYCn6/zMUh
	v5J8XzZ+tLQ7/MtMcMp6ggGn2632Oh1SvkZ3vlw5LwJKj48t7HEFnICozgc4IE921YSk8FAvXLt0A
	al85CaIQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tphri-00000004pIP-06xF;
	Wed, 05 Mar 2025 06:04:22 +0000
Date: Wed, 5 Mar 2025 06:04:21 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: brauner@kernel.org, hare@suse.de, david@fromorbit.com,
	djwong@kernel.org, kbusch@kernel.org, john.g.garry@oracle.com,
	hch@lst.de, ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com, da.gomez@samsung.com, kernel@pankajraghav.com,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: [PATCH] bdev: add back PAGE_SIZE block size validation for
 sb_set_blocksize()
Message-ID: <Z8fpZWHNs8eI5g38@casper.infradead.org>
References: <20250305015301.1610092-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305015301.1610092-1-mcgrof@kernel.org>

On Tue, Mar 04, 2025 at 05:53:01PM -0800, Luis Chamberlain wrote:
> The commit titled "block/bdev: lift block size restrictions to 64k"
> lifted the block layer's max supported block size to 64k inside the
> helper blk_validate_block_size() now that we support large folios.
> However in lifting the block size we also removed the silly use
> cases many filesystems have to use sb_set_blocksize() to *verify*
> that the block size < PAGE_SIZE. The call to sb_set_blocksize() can
> happen in-kernel given mkfs utilities *can* create for example an
> ext4 32k block size filesystem on x86_64, the issue we want to prevent
> is mounting it on x86_64 unless the filesystem supports LBS.
> 
> While, we could argue that such checks should be filesystem specific,
> there are much more users of sb_set_blocksize() than LBS enabled
> filesystem on linux-next, so just do the easier thing and bring back
> the PAGE_SIZE check for sb_set_blocksize() users.
> 
> This will ensure that tests such as generic/466 when run in a loop
> against say, ext4, won't try to try to actually mount a filesystem with
> a block size larger than your filesystem supports given your PAGE_SIZE
> and in the worst case crash.

So this is expedient because XFS happens to not call sb_set_blocksize()?
What is the path forward for filesystems which call sb_set_blocksize()
today and want to support LBS in future?

