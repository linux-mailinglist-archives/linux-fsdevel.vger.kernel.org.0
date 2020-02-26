Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6495E170584
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 18:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbgBZRH2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 12:07:28 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57782 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgBZRH2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 12:07:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZJi9hC4ehvqCcf6BlT7xvIkRN9seHzpJl6dLbb5ZRoM=; b=EiR9E4pRiVBrxOAfbZhMffZ3+i
        Ol5Ip+ZZrYlhL+mB+pu99N95gdjW/F3y2Z7IeerpE6EtJ/VNYQv1iUIDYr8VvaaTT4WkF8sR/2nun
        0ZPWOfMsbneBeAeCiTcC3tCwOzHeSTU7/DdSdBD9VKqHiUOBtS2uIfDf1EEdnlG9b7LBySCXHHftT
        +j5GVuJjDmc8eW8b59vJiYX/4jB/OVr6jjD2TFu5q9GUn+qXyZ5V1hyexGPIjhtsfiJbZ5SD+mfwO
        mRMegtoRIZ6mD01bXz8gces8xrJ2v4xWcOwg0hb2antvlx/u9r+GdNEECP/xbVSRsWYq6k0zUWzqu
        GwB/MpMA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j709g-0008JU-1v; Wed, 26 Feb 2020 17:07:28 +0000
Date:   Wed, 26 Feb 2020 09:07:28 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v8 25/25] iomap: Convert from readpages to readahead
Message-ID: <20200226170728.GD22837@infradead.org>
References: <20200225214838.30017-1-willy@infradead.org>
 <20200225214838.30017-26-willy@infradead.org>
 <20200226170425.GD8045@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226170425.GD8045@magnolia>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 26, 2020 at 09:04:25AM -0800, Darrick J. Wong wrote:
> > @@ -456,15 +435,8 @@ iomap_readpages(struct address_space *mapping, struct list_head *pages,
> >  			unlock_page(ctx.cur_page);
> >  		put_page(ctx.cur_page);
> >  	}
> > -
> > -	/*
> > -	 * Check that we didn't lose a page due to the arcance calling
> > -	 * conventions..
> > -	 */
> > -	WARN_ON_ONCE(!ret && !list_empty(ctx.pages));
> > -	return ret;
> 
> After all the discussion about "if we still have ctx.cur_page we should
> just stop" in v7, I'm surprised that this patch now doesn't say much of
> anything, not even a WARN_ON()?

The code quoted above puts the cur_page reference.  By dropping the
odd refactoring patch there is no need to check for cur_page being
left as a special condition as that still is the normal loop exit
state and properly handled, just as in the original iomap code.
