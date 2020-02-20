Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC32D16625C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 17:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbgBTQYF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 11:24:05 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35548 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727709AbgBTQYF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 11:24:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/X+cuahXNVjwX8kIjzPU/QZUMEm+qIm+lNxfvhlX3EA=; b=lxTIdidZw2P2UO9t/Oji3FNceT
        +CjnxJZogq66GLHl3rhRoufVhXPoH7CxN5rw1pgrMvr7szk03lJeq2TvDL3R2ys6m86hnGj7sXBXg
        AQaHFo4WLWH90RnuR6backVMmU/lhsJTXMH7V42hfdxcXElLYWAoi8WkszieVn0N2xZmXUiT1EECe
        GJX8uJUjnaFLb7zI2vKxvhhrKwSedVafnnaMtZd9zrJbg6npgPtnxSYDtx+h9J81ITalXizKXonPp
        SQVVA+pyipbUonuljCpyE7+n90vEPRYltjJb/REqxUNVBonREpCV+ttQEEWV7EF1CEorahGhIHM1b
        9p1J3F8g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4ocO-0001zg-A1; Thu, 20 Feb 2020 16:24:04 +0000
Date:   Thu, 20 Feb 2020 08:24:04 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v7 21/24] iomap: Restructure iomap_readpages_actor
Message-ID: <20200220162404.GY24185@bombadil.infradead.org>
References: <20200219210103.32400-1-willy@infradead.org>
 <20200219210103.32400-22-willy@infradead.org>
 <20200220154741.GB19577@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220154741.GB19577@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 20, 2020 at 07:47:41AM -0800, Christoph Hellwig wrote:
> On Wed, Feb 19, 2020 at 01:01:00PM -0800, Matthew Wilcox wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > 
> > By putting the 'have we reached the end of the page' condition at the end
> > of the loop instead of the beginning, we can remove the 'submit the last
> > page' code from iomap_readpages().  Also check that iomap_readpage_actor()
> > didn't return 0, which would lead to an endless loop.
> 
> I'm obviously biassed a I wrote the original code, but I find the new
> very much harder to understand (not that the previous one was easy, this
> is tricky code..).

Agreed, I found the original code hard to understand.  I think this is
easier because now cur_page doesn't leak outside this loop, so it has
an obvious lifecycle.

I'm kind of optimistic for Dave Howells' iov_iter addition of an
ITER_MAPPING.  That might simplify all of this code.
