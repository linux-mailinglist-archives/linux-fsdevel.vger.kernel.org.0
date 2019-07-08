Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8356262593
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2019 18:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388689AbfGHQDw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jul 2019 12:03:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35798 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388273AbfGHQDw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jul 2019 12:03:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AK046X7d27ccBkwVz6G/EMIjS9u9oBaRg4znnSmwSQ0=; b=T4SZUnfKFWcMF4MfKVSWSWbN5
        Yuhvx8FUyJVLZFEI1Bc91rmSpx1FW0fyFRs+8Jj1746iXn0LV4sHeBPol0aJHn4GmyW/tq10vr4JS
        HdVNqHGSplhAtujYRoSwRp5TdprCuQ26ZPoY8sf8lchT/mX0v9PQ6iLpz/2qudwGgNm71xFIgzxVb
        1tm8MKh6z8PRTMdX2DAu80meXuaymTiosos/OKSIf9EbiDJYvmRR8xKvib1ShpdOzLf/L1SD/OfAA
        FXHb9AubihU+BpYQrzVAfFLB0fkpaBOE1sV0ry/a1B6em58WW4YrwZERt6sMFvoFWhzZO5gz+SYVf
        4Eg0f+QJQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hkW7G-0004rW-Ra; Mon, 08 Jul 2019 16:03:46 +0000
Date:   Mon, 8 Jul 2019 09:03:46 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     hch@infradead.org, darrick.wong@oracle.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        andreas.gruenbacher@gmail.com, gaoxiang25@huawei.com,
        chao@kernel.org
Subject: Re: [RFC PATCH] iomap: generalize IOMAP_INLINE to cover tail-packing
 case
Message-ID: <20190708160346.GA17715@infradead.org>
References: <20190703075502.79782-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703075502.79782-1-yuchao0@huawei.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 03, 2019 at 03:55:02PM +0800, Chao Yu wrote:
> Some filesystems like erofs/reiserfs have the ability to pack tail
> data into metadata, e.g.:
> IOMAP_MAPPED [0, 8192]
> IOMAP_INLINE [8192, 8200]
> 
> However current IOMAP_INLINE type has assumption that:
> - inline data should be locating at page #0.
> - inline size should equal to .i_size
> Those restriction fail to convert to use iomap IOMAP_INLINE in erofs,
> so this patch tries to relieve above limits to make IOMAP_INLINE more
> generic to cover tail-packing case.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>

This looks good to me, but I'd also like to see a review and gfs2
testing from Andreas.
