Return-Path: <linux-fsdevel+bounces-7484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB445825B85
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 21:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A266284AA8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 20:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1563608B;
	Fri,  5 Jan 2024 20:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nBEhS1X6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C669836093;
	Fri,  5 Jan 2024 20:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GH2fUIxY3jgbl3dQw34A+7ZL3ZN4Y5y8qZthX19vE/I=; b=nBEhS1X6OjPHGFrcdFWKaXU2uc
	C/HyQD9hBggzIqKhTy1YwhypPjHB7wzqgdQnrZ3YXLX1S8gLkE8VwdmjCFsl1DJrdJRZk67hVbJ6O
	h/jvKKuolffwxQxmk/g6O6NnxaHP204q4GxCoX9u33CJzOh2G1JxSb67Op6YDEwjuTsqjLoPYixEl
	2E2uVQC0SrTTvYUpzPQfpL4Ah5+xwfyQOAXKqP6lSuXpEwQGd2mEfNGNTrFF2cVmfsMlZ6SzX7qIB
	VUTA7n96aXJPmJN0T+SJLj1MlWjHh/jKm0BAEX3Hgr6wkHqtOG7n3/tLchQ3hwvZ25JZVbiKkpHAT
	ZmGBHcoQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rLqge-0017Fs-P6; Fri, 05 Jan 2024 20:21:00 +0000
Date: Fri, 5 Jan 2024 20:21:00 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Hou Tao <houtao@huaweicloud.com>, linux-fsdevel@vger.kernel.org,
	Miklos Szeredi <miklos@szeredi.hu>,
	Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, houtao1@huawei.com
Subject: Re: [PATCH v2] virtiofs: use GFP_NOFS when enqueuing request through
 kworker
Message-ID: <ZZhkrOdbau2O/B59@casper.infradead.org>
References: <20240105105305.4052672-1-houtao@huaweicloud.com>
 <ZZhjzwnQUEJhNJiq@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZhjzwnQUEJhNJiq@redhat.com>

On Fri, Jan 05, 2024 at 03:17:19PM -0500, Vivek Goyal wrote:
> On Fri, Jan 05, 2024 at 06:53:05PM +0800, Hou Tao wrote:
> > From: Hou Tao <houtao1@huawei.com>
> > 
> > When invoking virtio_fs_enqueue_req() through kworker, both the
> > allocation of the sg array and the bounce buffer still use GFP_ATOMIC.
> > Considering the size of both the sg array and the bounce buffer may be
> > greater than PAGE_SIZE, use GFP_NOFS instead of GFP_ATOMIC to lower the
> > possibility of memory allocation failure.
> > 
> 
> What's the practical benefit of this patch. Looks like if memory
> allocation fails, we keep retrying at interval of 1ms and don't
> return error to user space.

You don't deplete the atomic reserves unnecessarily?

