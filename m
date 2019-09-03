Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48DBBA6CD6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 17:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbfICPYK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 11:24:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49810 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728679AbfICPYK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 11:24:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=B/m96XoqXZdtmIUr0ndgNK1S7ZlN6PGhtrgoOXX9AHs=; b=kdOkIQ3ykwPFMvL89bXdzp9yz
        Zlcfo3rwKJ6LYbfJszaCVWLv/nwTs3Xy3oPjOox5oABK4Y41CXWOTO8QKXCJEVS4gr3tUM7GVSXD0
        E4fxalZ85nAZRl3jLzwiZ15LZ79aLrkqMYWWBa7KK1l4pRpeajbajXaBwhkvSWLQzzI1bs3cGGq/c
        tgBpccqszhBKtfej3k/IdiFSVZWViOGf/Q8EhyqtkSxbOdzpVnCODFLn52pw47wzQ0+dNO0pDIzO4
        N+EvQ4U1Hvj1hPRj9FTZ8xBiht4HJQNi365k8rQjylskke2ptWnOF1bSFj0B2TzrG/SLkRZDWKwdq
        sZRqNYeRA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i5Af9-0004IB-HX; Tue, 03 Sep 2019 15:24:07 +0000
Date:   Tue, 3 Sep 2019 08:24:07 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: Re: [PATCH 1/2] iomap: split size and error for iomap_dio_rw ->end_io
Message-ID: <20190903152407.GG29434@bombadil.infradead.org>
References: <20190903130327.6023-1-hch@lst.de>
 <20190903130327.6023-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903130327.6023-2-hch@lst.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 03, 2019 at 03:03:26PM +0200, Christoph Hellwig wrote:
> From: Matthew Bobrowski <mbobrowski@mbobrowski.org>
> 
> Modify the calling convention for the iomap_dio_rw ->end_io() callback.
> Rather than passing either dio->error or dio->size as the 'size' argument,
> instead pass both the dio->error and the dio->size value separately.
> 
> In the instance that an error occurred during a write, we currently cannot
> determine whether any blocks have been allocated beyond the current EOF and
> data has subsequently been written to these blocks within the ->end_io()
> callback. As a result, we cannot judge whether we should take the truncate
> failed write path. Having both dio->error and dio->size will allow us to
> perform such checks within this callback.
> 
> Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
> [hch: minor cleanups]
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
