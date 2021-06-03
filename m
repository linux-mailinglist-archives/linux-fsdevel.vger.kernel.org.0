Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDBF39A9AC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jun 2021 20:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhFCSDz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Jun 2021 14:03:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:45820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230075AbhFCSDy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Jun 2021 14:03:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D50661168;
        Thu,  3 Jun 2021 18:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622743329;
        bh=AYv0ziU2fZoIFGrB9jAtGF3UoZuuMZuDZMmboZOyAQE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=bdeF0Heb5uv6B0G8M9xsMdQ8COYs/gvL4EnTIdZhW5MZIqpqTLMPOUjnsYROkk8Af
         JBiFlGRCA3KUk6iC1EQUwd4dtQoBz8KVb1hJQZVYXCrz2uKVk18nYLoQ6cXacHgZo4
         u34qYoKftut2kQ91LOn+UhcPZJjQg6a9vxRSDABDJQUxQKdp889KT0CficU7THf0c9
         LHPG9mx1j66U7CwnHzz2UfdnsYBdRsiaKLrQ9/axZJO2eaChKZr//t2LcQq7nBNNSl
         KCpBggaE3M7nKSaibM3uzLGICPjjdfS6evOzysFYc/evDswDO7MPp7rf2kRZVqbaWH
         9bnfOymir5BHQ==
Message-ID: <589c225884ced126b0ff52f419686fa6d185c5c8.camel@kernel.org>
Subject: Re: question about mapping_set_error when writeback fails?
From:   Jeff Layton <jlayton@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Thu, 03 Jun 2021 14:02:08 -0400
In-Reply-To: <YLgFpqi63K/NMO2D@casper.infradead.org>
References: <20210602202756.GA26333@locust>
         <YLgFpqi63K/NMO2D@casper.infradead.org>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.1 (3.40.1-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2021-06-02 at 23:26 +0100, Matthew Wilcox wrote:
> On Wed, Jun 02, 2021 at 01:27:56PM -0700, Darrick J. Wong wrote:
> > In iomap_finish_page_writeback,
> > 
> > static void
> > iomap_finish_page_writeback(struct inode *inode, struct page *page,
> > 		int error, unsigned int len)
> > {
> > 	struct iomap_page *iop = to_iomap_page(page);
> > 
> > 	if (error) {
> > 		SetPageError(page);
> > 		mapping_set_error(inode->i_mapping, -EIO);
> > 
> > Why don't we pass error to mapping_set_error here?  If the writeback
> > completion failed due to insufficient space (e.g. extent mapping btree
> > expansion hit ENOSPC while trying to perform an unwritten extent
> > conversion) then we set AS_EIO which causes fsync to return EIO instead
> > of ENOSPC like you'd expect.
> 
> Hah, I noticed the same thing a few weeks ago and didn't get round to
> asking about it yet.  I'm pretty sure we should pass the real error to
> mapping_set_error().
> 
> I also wonder if we shouldn't support more of the errors from
> blk_errors, like -ETIMEDOUT or -EILSEQ, but that's a different
> conversation.

Note that whatever error you pass there is likely to bubble up to
userland via fsync/msync or whatever. Most file_check_and_advance_wb_err
callers don't vet that return code in any way. That's not a problem,
per-se, but you should be aware of the potential effects.
-- 
Jeff Layton <jlayton@kernel.org>

