Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60A04107319
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2019 14:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfKVN1D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Nov 2019 08:27:03 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59728 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfKVN1D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Nov 2019 08:27:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ds+XjOb+d/mlAyvjvQ/6JKUM2h/iZ/Y2E8kDx+1Ak0A=; b=dpGmP2Fw/Pwuq7tmRQVVsNqTA
        ZFcyqGffiS9OJmQdcrlOxpwWrvuReZsJQhKFVWAmVRNxTk9Le7+neSrICRYOiI0ETuzLFoPyLVVkO
        t+f3y52R5W9JCqHBWpjlCi2hI8otr3/MhkHA1WUR6GpXRd+kqTcUGgi4H6HTk6fiXbb/gLMQwD+aE
        LjGthLLha0exBVvqrigV13Br8b3iGtbyNgCPMU68asV8fiLaw73vDrVvrwF/8TcvSj3kjLcJrXJSC
        4tpVNfv2JBtvjXL8QOLbax3+o/5D+whPIvq+UkZ1JcyXbETkE/24Wk9emG6qty3OGLBDhtC5M0Hy/
        vSPzw1V1w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iY8xe-0007mh-LV; Fri, 22 Nov 2019 13:26:58 +0000
Date:   Fri, 22 Nov 2019 05:26:58 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH 2/2] iomap: Do not create fake iter in
 iomap_dio_bio_actor()
Message-ID: <20191122132658.GB12183@infradead.org>
References: <20191121161144.30802-1-jack@suse.cz>
 <20191121161538.18445-2-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121161538.18445-2-jack@suse.cz>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> -	/*
> -	 * Operate on a partial iter trimmed to the extent we were called for.
> -	 * We'll update the iter in the dio once we're done with this extent.
> -	 */
> -	iter = *dio->submit.iter;
> -	iov_iter_truncate(&iter, length);
> +	/* Operate on a partial iter trimmed to the extent we were called for */
> +	iov_iter_truncate(dio->submit.iter, length);

I think the comment could be kept a little more verbose given that the
scheme isn't exactly obvious.  Also I'd move the initialization of
orig_count here to keep it all together.  E.g.

	/*
	 * Save the original count and trim the iter to just the extent we
	 * are operating on right now.  The iter will be re-expanded once
	 * we are done.
	 */
	orig_count = iov_iter_count(dio->submit.iter);
	iov_iter_truncate(dio->submit.iter, length);

>  
> -	nr_pages = iov_iter_npages(&iter, BIO_MAX_PAGES);
> -	if (nr_pages <= 0)
> +	nr_pages = iov_iter_npages(dio->submit.iter, BIO_MAX_PAGES);
> +	if (nr_pages <= 0) {
> +		iov_iter_reexpand(dio->submit.iter, orig_count);
>  		return nr_pages;
> +	}

Can we stick to a single iov_iter_reexpand call?  E.g. turn this into

	if (nr_pages <= 0) {
		ret = nr_pages;
		goto out;
	}

and then have the out label at the very end call iov_iter_reexpand.

>  			iomap_dio_zero(dio, iomap, pos, fs_block_size - pad);
>  	}
> +	/* Undo iter limitation to current extent */
> +	iov_iter_reexpand(dio->submit.iter, orig_count - copied);
>  	return copied ? copied : ret;

In iomap-for-next this is:

	if (copied)
		return copied;
	return ret;

so please rebase to iomap-for-next for the next spin.
