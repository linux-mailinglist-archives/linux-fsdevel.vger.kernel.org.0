Return-Path: <linux-fsdevel+bounces-7799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF8082B1DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 16:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F408B22694
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 15:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5034F1E1;
	Thu, 11 Jan 2024 15:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eDYVkCvm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0C34EB5C;
	Thu, 11 Jan 2024 15:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bWePOa8GLZpZTN02izOhGMD/Rc7CJVvB+zX37Yp82gU=; b=eDYVkCvmb3TPwZ6xVGBlnXj025
	zGxz3Mfnp5uqvF48Js3mxq9WIuc7ujsQLtkU7CsBFblH5mi0nw23nnPMh4X9jnL0QGkY+OMkptcLi
	OTRVklfR+6gVYOUVHyXpo71PFkPw6ck0ibLiA+E/IHWMc4G+iAfjj9l9zojyjHBFH0aDfJdJcm3Q4
	P0jIGhcYwkw5lpcuwHi0A6Bw/UoKbp35xpZp5Ij1j7fYQekMgd/MFiBXxB/8GP82GrnTXX+Ji5g1I
	806nh8P5PeqAKAAUSA+WJWZOw1SoiVBuOHwpbUAsJOZMqSTU5kIxgCYV1KQn/wiafidkgA4daYwLS
	lEgrcmdw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rNx1U-00EB3W-L9; Thu, 11 Jan 2024 15:31:12 +0000
Date: Thu, 11 Jan 2024 15:31:12 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Karina Yankevich <k.yankevich@omp.ru>, lvc-project@linuxtesting.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 5.10 0/2] mm/truncate: fix issue in ext4_set_page_dirty()
Message-ID: <ZaAJwEg4rvleFuC9@casper.infradead.org>
References: <20240111143747.4418-1-r.smirnov@omp.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111143747.4418-1-r.smirnov@omp.ru>

On Thu, Jan 11, 2024 at 02:37:45PM +0000, Roman Smirnov wrote:
> Syzkaller reports warning in ext4_set_page_dirty() in 5.10 stable 
> releases. The problem can be fixed by the following patches 
> which can be cleanly applied to the 5.10 branch.

I do not understand the crash, and I do not understand why this patch
would fix it.  Can you explain either?

> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
> 
> Link: https://syzkaller.appspot.com/bug?extid=02f21431b65c214aa1d6
> 
> Matthew Wilcox (Oracle) (2):
>   mm/truncate: Inline invalidate_complete_page() into its one caller
>   mm/truncate: Replace page_mapped() call in invalidate_inode_page()
> 
>  kernel/futex/core.c |  2 +-
>  mm/truncate.c       | 34 +++++++---------------------------
>  2 files changed, 8 insertions(+), 28 deletions(-)
> 
> -- 
> 2.34.1
> 

