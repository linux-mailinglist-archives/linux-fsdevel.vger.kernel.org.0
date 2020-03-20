Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD9A618D0FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Mar 2020 15:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbgCTOfC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Mar 2020 10:35:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36824 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbgCTOfB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Mar 2020 10:35:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LASMtyJcflOe2DO3cMPw3KuweMH8ZRP8HrjCuN3ZWuw=; b=VhUVee2gbMU0XK1vhhZ6TcLOmc
        sraKGYo+YoBXNwcurStnG0TgfV6N3p0YhFOZRrWy1SZDDqYsRkj/SJgCwF/460LuladY5ZiH4saWL
        iQ4O7KqQ41MoNhnTKuDc6Lw7FATmy+teB6laEaMzOvxzncKUBUmPZkv/Qc3wDDGbpvNSUzwkhsb9d
        t87WoEcIsU5ZqMyUvEp2YFL1kyrZ2Kvk3ec30ZUzOFzhXkUmtL9iPnFK4SzqmsH5F/tXWFSjW135w
        X/Qr2l+kf/HbbjpDjWKYRIeWRtCMDz7oJPZzsw+hhuhW7gPUCnlO/dX9CZPRf5Mo3Rm7NLuawm7/k
        ArIxTO8w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jFIjk-0006Jc-O9; Fri, 20 Mar 2020 14:35:00 +0000
Date:   Fri, 20 Mar 2020 07:35:00 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-fsdevel@vger.kernel.org, riteshh@linux.ibm.com,
        linux-ext4@vger.kernel.org, darrick.wong@oracle.com,
        willy@infradead.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] iomap: return partial I/O count on error in
 iomap_dio_bio_actor
Message-ID: <20200320143500.GA16143@infradead.org>
References: <20200319150805.uaggnfue5xgaougx@fiona>
 <20200320140538.GA27895@infradead.org>
 <02209ec3-62b4-595f-b84e-2cd8838ac41b@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02209ec3-62b4-595f-b84e-2cd8838ac41b@toxicpanda.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 20, 2020 at 10:23:43AM -0400, Josef Bacik wrote:
> I'm not sure what you're looking at specifically wrt error handling, but I
> can explain __endio_write_update_ordered.
> 
> Btrfs has ordered extents to keep track of an extent that currently has IO
> being done on it.  Generally that IO takes multiple bio's, so we keep track
> of the outstanding size of the IO being done, and each bio completes and
> thus removes its size from the pending size.  If any one of those bios has
> an error we need to make sure we discard the whole ordered extent, as part
> of it won't be valid. Just a cursory look at the current code I assume
> that's what's confusing you, we call this when we have an error in the
> O_DIRECT code.  This is just so we get the proper cleanup for the ordered
> extent.  People will wait on the ordered extent to be completed, so if we've
> started an ordered extent and aren't able to complete the range we need to
> do __endio_write_update_ordered() so that the ordered extent is finished and
> we wakeup any waiters.
> 
> Does this help?  If I need to I can context switch into whatever you're
> looking at, but I'm going to avoid looking and hope I can just shout useful
> information in your direction ;).  Thanks,

Yes, this helps a lot.  This is about the patches from Goldwyn to
convert btrfs to use the iomap direct I/O code.  And in that series
he currently calls __endio_write_update_ordered from the ->iomap_end
method, which for direct I/O is called after all bios are submitted
to complete ordered extents for a range after an I/O error, that
is one that no I/O has been submitted to, and the accounting for that
is a little complicated..
