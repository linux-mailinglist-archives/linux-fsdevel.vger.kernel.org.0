Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 708CED3D28
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2019 12:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbfJKKS0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Oct 2019 06:18:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58374 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfJKKS0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Oct 2019 06:18:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=osXmQntjSq5WIJZaSwd1Ch1sx8vgZPb5+KGs0NIvYmA=; b=ttI45Cl03wSnj0wnkNde49eV5
        F2l5JgCrcYi1MthZHQEgEsX6IrV5bYKawfsbXzyQh2bE4q2Ai2LhitCjS4MKSy58RV3h+obj3MQFJ
        MgpTMLrz0nQRy7JwBDbbeByex/FW/WQ+y5QUKSoOICFKYndRtZ+yC0HOxCLx6mvdOlzt3FK1TU6Ho
        hJovia9H36EvE3avlwJy/EZlxGhqEuqcc17VnMuQZ2cFHHEcE2x0i1zu2fJcNJPqX47xoY1Bd0Dmn
        VVEp8YVfy9Tp6AxBUA/Icf9akYshYvzRGTMJM9siEM9OPidMguGtPG4CcwQ/X0sQ2NNK+qYmC1P+b
        ksu1zHlJw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iIs0A-0003G1-0J; Fri, 11 Oct 2019 10:18:26 +0000
Date:   Fri, 11 Oct 2019 03:18:25 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 16/26] xfs: synchronous AIL pushing
Message-ID: <20191011101825.GA29171@infradead.org>
References: <20191009032124.10541-1-david@fromorbit.com>
 <20191009032124.10541-17-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009032124.10541-17-david@fromorbit.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 09, 2019 at 02:21:14PM +1100, Dave Chinner wrote:
> Factor the common AIL deletion code that does all the wakeups into a
> helper so we only have one copy of this somewhat tricky code to
> interface with all the wakeups necessary when the LSN of the log
> tail changes.
> 
> xfs_ail_push_sync() is temporary infrastructure to facilitate
> non-blocking, IO-less inode reclaim throttling that allows further
> structural changes to be made. Once those structural changes are
> made, the need for this function goes away and it is removed,
> leaving us with only the xfs_ail_update_finish() factoring when this
> is all done.

The xfs_ail_update_finish work here is in an earlier patch, so the
changelog will need some updates.

> +	spin_lock(&ailp->ail_lock);
> +	while ((lip = xfs_ail_min(ailp)) != NULL) {
> +		prepare_to_wait(&ailp->ail_push, &wait, TASK_UNINTERRUPTIBLE);
> +		if (XFS_FORCED_SHUTDOWN(ailp->ail_mount) ||
> +		    XFS_LSN_CMP(threshold_lsn, lip->li_lsn) <= 0)
> +			break;
> +		/* XXX: cmpxchg? */
> +		while (XFS_LSN_CMP(threshold_lsn, ailp->ail_target) > 0)
> +			xfs_trans_ail_copy_lsn(ailp, &ailp->ail_target, &threshold_lsn);

This code looks broken on 32-bit given that xfs_trans_ail_copy_lsn takes
the ail_lock there.  Just replacing the xfs_trans_ail_copy_lsn call with
a direct assignment would fix that, no need for cmpxchg either as far
as I can tell (and it would fix that too long line as well).

But a:

		while (XFS_LSN_CMP(threshold_lsn, ailp->ail_target) > 0)
			ailp->ail_target = threshold_lsn;

still looks odd, I think this should simply be an if. 

> +		wake_up_process(ailp->ail_task);
> +		spin_unlock(&ailp->ail_lock);

xfsaild will take ail_lock pretty quickly.  I think we should drop
the lock before waking it.
