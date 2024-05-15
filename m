Return-Path: <linux-fsdevel+bounces-19488-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 244DF8C5F1D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 04:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAA1D1F2239B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 02:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E2736AF5;
	Wed, 15 May 2024 02:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AsAsoTRy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056D917C96;
	Wed, 15 May 2024 02:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715740454; cv=none; b=DFnxE1BT70dOCz3PsCE+K8M44i6kRdWHz02O3tiiltjqfp+jRXD65L/SCReEPPl0rXSUk3OLl5BRxYiWsbK75Tp92dWfQbYH/FU+YkW5nQdNiYhUdduLU0qxiKbfbOrMjBuLzwHsGr3Dqvm+z/h9mrxNTvYhUNBTx5FrCwQKLec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715740454; c=relaxed/simple;
	bh=0Py+mhpyh17Xg65Pwy3AgGKMlMnS9vSsEebG9ZJaFD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6ZfZZfWsrC8f9SI1MJvN4CPfQJw5zVpPTuqX1oUYDs6TlKeT+rlosDIKm2lm3CEqgtT0JedA2fTneZZahAhLuQfZKLOtcXK0KLErrsKo/HMZ+m5QQWVm2KXFCuA7LGb6+Yx4jyGU3vm0sRkezAet6rVc4pinmqDqxmKPlGcUgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AsAsoTRy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE1DC2BD10;
	Wed, 15 May 2024 02:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715740453;
	bh=0Py+mhpyh17Xg65Pwy3AgGKMlMnS9vSsEebG9ZJaFD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AsAsoTRypuTTu9iaHHn2KZjbJ/9neXFQJTFwUXCDU+s7ruNnsRvASy0edAeFZE4Z8
	 j9kUsw8UGriNRqZNG5wR/zf8gLLLIsPvHecCzRobMZ/X07hQgg9yqznIOm5HXI9VBY
	 XnPoQStJZIryWkPphJEAC/giqR0vgcj1ia/zRfjJ+1JOem5el76/mI+vFVbHPqMOsa
	 4L5FG8RXZ5XQodrhSBQqbUM1dgK2dqd5ggnjttYR7BpouOp7LyGxneTLhxHCdV91sj
	 Q7T/kJtwg1Y+sik6O/xokLJcQlDVhKJbVPoL/m7ybDfpqiu8BRG0U0gcI3f1ffIjOT
	 RbMBAtJuCxcog==
Date: Tue, 14 May 2024 20:34:09 -0600
From: Keith Busch <kbusch@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, hch@lst.de,
	mcgrof@kernel.org, akpm@linux-foundation.org, brauner@kernel.org,
	chandan.babu@oracle.com, david@fromorbit.com, djwong@kernel.org,
	gost.dev@samsung.com, hare@suse.de, john.g.garry@oracle.com,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-xfs@vger.kernel.org, p.raghav@samsung.com,
	ritesh.list@gmail.com, ziy@nvidia.com
Subject: Re: [RFC] iomap: use huge zero folio in iomap_dio_zero
Message-ID: <ZkQfId5IdKFRigy2@kbusch-mbp>
References: <20240503095353.3798063-8-mcgrof@kernel.org>
 <20240507145811.52987-1-kernel@pankajraghav.com>
 <ZkQG7bdFStBLFv3g@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkQG7bdFStBLFv3g@casper.infradead.org>

On Wed, May 15, 2024 at 01:50:53AM +0100, Matthew Wilcox wrote:
> On Tue, May 07, 2024 at 04:58:12PM +0200, Pankaj Raghav (Samsung) wrote:
> > Instead of looping with ZERO_PAGE, use a huge zero folio to zero pad the
> > block. Fallback to ZERO_PAGE if mm_get_huge_zero_folio() fails.
> 
> So the block people say we're doing this all wrong.  We should be
> issuing a REQ_OP_WRITE_ZEROES bio, and the block layer will take care of
> using the ZERO_PAGE if the hardware doesn't natively support
> WRITE_ZEROES or a DISCARD that zeroes or ...

Wait a second, I think you've gone too far if you're setting the bio op
to REQ_OP_WRITE_ZEROES. The block layer handles the difference only
through the blkdev_issue_zeroout() helper. If you actually submit a bio
with that op to a block device that doesn't support it, you'll just get
a BLK_STS_NOTSUPP error from submit_bio_noacct().

