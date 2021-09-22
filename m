Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21CC9414F9B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Sep 2021 20:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236967AbhIVSLi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 14:11:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:40576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236837AbhIVSLi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 14:11:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E98C8603E7;
        Wed, 22 Sep 2021 18:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632334208;
        bh=2FwWHPE6KXulGfBoEIvctyLfkkEDVIGf/eIXcW1lVbY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gB7Tt4mZIBo+KxCjLQLKIY/0LpEz0ftYgaAB6ugV5xrWhnlYDp5TdPKA0dkX8SISP
         TH52gOWQAlhvF28mI49nBrSBjfzndDrZ8lRZ6E2iNGKMkQUykfiBcsPI++yTwS0ebr
         1h5i7dZNuD8YqwW627Fcx9bsPS1KH7rkLmTvd/xtS/kItypztgjbUrvpSRzlBYE6c5
         LWd+otWM69N7kgYKOwcCC5gipgvA8OAWZkr6GHw2yxv8gfPRTZEnd9rh3Nmdd+6TPr
         jDgJByXJNFxvv75bXt6v+s64Bq2IJpQ1UmpNqeIxgxHeEL3CPz1m0x37AxM8yMBesR
         J4fgmT15K+/2A==
Date:   Wed, 22 Sep 2021 11:10:07 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     jane.chu@oracle.com, linux-xfs@vger.kernel.org,
        dan.j.williams@intel.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/5] dax: prepare pmem for use by zero-initializing
 contents and clearing poisons
Message-ID: <20210922181007.GI570615@magnolia>
References: <163192864476.417973.143014658064006895.stgit@magnolia>
 <163192865031.417973.8372869475521627214.stgit@magnolia>
 <YUmZL9qs0ZJ3ESBW@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUmZL9qs0ZJ3ESBW@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 21, 2021 at 09:34:55AM +0100, Christoph Hellwig wrote:
> On Fri, Sep 17, 2021 at 06:30:50PM -0700, Darrick J. Wong wrote:
> > +	case IOMAP_MAPPED:
> > +		while (nr_pages > 0) {
> > +			/* XXX function only supports one page at a time?! */
> > +			ret = dax_zero_page_range(iomap->dax_dev, start_page,
> > +					1);
> 
> Yes.  Given that it will have to kmap every page that kinda makes sense.
> Unlike a nr_pages argument which needs to be 1, which is just silly.
> That being said it would make sense to move the trivial loop over the
> pages into the methods to reduce the indirect function call overhead

Done.  AFAICT all the implementations *except* nvdimm can handle more
than one page.

--D
