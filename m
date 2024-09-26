Return-Path: <linux-fsdevel+bounces-30167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EA09874CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 15:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34D03B27D9C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 13:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8A77A13A;
	Thu, 26 Sep 2024 13:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rcPflZ7P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C6054F95
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Sep 2024 13:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727358794; cv=none; b=LxRsr1X4VO6uekl4G+XQjGfkQMwe8z61mRK0cB0y53VuHdoEhoHhQuT5NcPP8ISTmlB1Qw9CfEVV0rxsDR8Cc1MiNqzdisJOsjGeTDskSc+XMu8Xv9NoEv/E7lcm5zC1BW7grZ2svRABFCEKJBZl6GX2aD3ldNxdTmiAT+Ce04o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727358794; c=relaxed/simple;
	bh=1UJrOvJldB0tb7mLeLmuMQ5f/rN84sIL4+2CKikHASk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kupau/cLa0h20GhnxG+jPXwbJXhB958nrPQaAJnklcAu8upWJD+Q3/KO4IfWrZEjPcRL84ykaCYmeYztVA0ykNacgoG1h+iFbGgpcqzvUCcpyRINzxX3RUOovjPnb/grJ8K8amsWzNHvawL4japEvodvInnR6KOTPHVRPG+e0Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rcPflZ7P; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yRx6qLYwqz04Vp58gRtJGngnhFxcQA4gy1QsyF9WlLk=; b=rcPflZ7P4TxnglRWIss7fEwE1f
	nQv5JLt2+1MX1LQ5ZRBr+jC5NJmSI8yUSgDTy75t5hpXYeRwsLQ8ARfDpSr1YQ1HtgZbpuoJ/Nesr
	QmmUhpwYaqhPCmQHYEnlmDEN1Lpkpa46ZUDqFE9Pgy6aW3pD1yWBRusSuuUC0Q+09x4AXg6t0tfkn
	rKb1uhp5URDHSX0MDE5VVO49OXyfO4MxnUWnyjyp3V2AD+gilVSqOBCLYBJreIU45CGXxP/TRVdSY
	jiYgF/Ru8lsIVUNUoICRUkGXQhQaSeIhmiBVDvpkH722erBR+eOPsDbUw+fOBF4snl+6eIrwd9KLA
	Qn/sLLmA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1stovU-00000006mVK-0LrT;
	Thu, 26 Sep 2024 13:53:00 +0000
Date: Thu, 26 Sep 2024 14:52:59 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Anna Schumaker <Anna.Schumaker@netapp.com>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: Re: Re: [PATCH v2] tmpfs: fault in smaller chunks if large folio
 allocation not allowed
Message-ID: <ZvVnO777wfXcfjYX@casper.infradead.org>
References: <20240914140613.2334139-1-wangkefeng.wang@huawei.com>
 <20240920143654.1008756-1-wangkefeng.wang@huawei.com>
 <Zu9mbBHzI-MyRoHa@casper.infradead.org>
 <1d4f98aa-f57d-4801-8510-5c44e027c4e4@huawei.com>
 <nhnpbkyxbbvjl2wg77x2f7gx3b3wj7jujfkucc33tih3d4jnpx@5dg757r4go64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nhnpbkyxbbvjl2wg77x2f7gx3b3wj7jujfkucc33tih3d4jnpx@5dg757r4go64>

On Thu, Sep 26, 2024 at 10:38:34AM +0200, Pankaj Raghav (Samsung) wrote:
> > So this is why I don't use mapping_set_folio_order_range() here, but
> > correct me if I am wrong.
> 
> Yeah, the inode is active here as the max folio size is decided based on
> the write size, so probably mapping_set_folio_order_range() will not be
> a safe option.

You really are all making too much of this.  Here's the patch I think we
need:

+++ b/mm/shmem.c
@@ -2831,7 +2831,8 @@ static struct inode *__shmem_get_inode(struct mnt_idmap *idmap,
        cache_no_acl(inode);
        if (sbinfo->noswap)
                mapping_set_unevictable(inode->i_mapping);
-       mapping_set_large_folios(inode->i_mapping);
+       if (sbinfo->huge)
+               mapping_set_large_folios(inode->i_mapping);

        switch (mode & S_IFMT) {
        default:

