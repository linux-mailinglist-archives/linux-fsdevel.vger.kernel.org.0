Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9497A47E439
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 14:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348462AbhLWNux (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 08:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348693AbhLWNux (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 08:50:53 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D901DC061401
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Dec 2021 05:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SmmP7NkGQYGRhDUQlp6xKwjItLxK6d3jXQpLciOTzWM=; b=uWXI5s8uMycT6ilv2EEPz49eAh
        9UH2JdUuEsGrBW+XiIixYeEAfnWZxw8Ij4dn1apYKgIr1PXiF8Vqe7hlOF6KiPMfmVvmhcdRjly4b
        BOxr6kvsYGE1HFQ5iCIj01pI0UcJXnYIePVzYdFYd3VH/hfx9QM3Qd1BG/9YdfPmo7z/pQICw/kUK
        UxFyftTP7PbVyclq0bwWYDEy/xsNhXDPX8DXKL51RENaLVfhHFwFpFYWSmqjT1z8H+SuOwPCPhgTf
        qN8UXM1MNI4Ep2Qd9hRiIc0rNOWFmxW+/on7qWRqQ2HUqCNgjveMFcVGhByGPDoKFP9mehlfqGkHA
        5cmn2Zxw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0OUd-004JU6-1i; Thu, 23 Dec 2021 13:50:51 +0000
Date:   Thu, 23 Dec 2021 13:50:51 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 02/48] fs/writeback: Convert inode_switch_wbs_work_fn to
 folios
Message-ID: <YcR+u4ibF5lvMyP6@casper.infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-3-willy@infradead.org>
 <YcQcLPS1uEYHIYfY@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcQcLPS1uEYHIYfY@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 22, 2021 at 10:50:20PM -0800, Christoph Hellwig wrote:
> On Wed, Dec 08, 2021 at 04:22:10AM +0000, Matthew Wilcox (Oracle) wrote:
> > This gets the statistics correct by modifying the counters by the
> > number of pages in the folio instead of by 1.
> 
> We can't actually hit this for a multi-page folio yet, can we?
> So this should be more of a prep patch?
> 
> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Right, even by the end of this series, we don't actually create large
folios.  I was hoping to get to that point, but there's still a reliance
on CONFIG_TRANSPARENT_HUGEPAGE that I need to get rid of.
