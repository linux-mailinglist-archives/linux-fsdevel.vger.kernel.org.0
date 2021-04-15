Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A16360C1B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Apr 2021 16:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbhDOOqf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Apr 2021 10:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbhDOOqf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Apr 2021 10:46:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E024C061574;
        Thu, 15 Apr 2021 07:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DCBSWmrCJfa4/K3AiPkI+ofdOr4wt6uSHRs4glxHxFA=; b=Y+SU13o4f/rB7+MpjS20NagpYq
        LX6fOqzSkFgPWF7e9gqGYrFUBjeYp7D0hxGzlAa9B+T23MaDxGDzfDZEkXqs9yL7tyeiSdf9y/cHw
        oAfonrP8Y1GLpCf3Cz3JmsXSp27BhVNx8RAlnneIBw0ySQKiGCFPDl6o4R6Xjl1t0YVseBr2WzE2X
        WWane+zKD97RdoYp2FXMJX4hEGUnrcSfcYhpyNIScNx9kCVRmssg+w91fR/1Oy9YlgnGNVlCqVUZ2
        LI1knadXLG0YjrNUrsgHwXgEHGiYyjaUDYb0S/q1SyrhYfiq/NmltofBq1//+4CxH/kc7bg15XXCy
        5Z3pJioQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lX3Fo-008glT-7F; Thu, 15 Apr 2021 14:46:03 +0000
Date:   Thu, 15 Apr 2021 15:46:00 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yukuai3@huawei.com
Subject: Re: [RFC PATCH v2 4/7] jbd2: do not free buffers in
 jbd2_journal_try_to_free_buffers()
Message-ID: <20210415144600.GB2069063@infradead.org>
References: <20210414134737.2366971-1-yi.zhang@huawei.com>
 <20210414134737.2366971-5-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414134737.2366971-5-yi.zhang@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 14, 2021 at 09:47:34PM +0800, Zhang Yi wrote:
>  static int blkdev_releasepage(struct page *page, gfp_t wait)
>  {
>  	struct super_block *super = BDEV_I(page->mapping->host)->bdev.bd_super;
> +	int ret = 0;
>  
>  	if (super && super->s_op->bdev_try_to_free_page)
> +		ret = super->s_op->bdev_try_to_free_page(super, page, wait);
> +	if (!ret)
> +		return try_to_free_buffers(page);
> +	return 0;

This would rea much better as:

	if (super && super->s_op->bdev_try_to_free_page &&
	    super->s_op->bdev_try_to_free_page(super, page, wait)
		return 0;
	return try_to_free_buffers(page);

and I think changing ->bdev_try_to_free_page to return a bool where true
means "yes, free the buffers" and false means "don't free buffers" would
be a better calling convention.

Also please split the changes to the method signature from the ext4
internal cleanups.
