Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EECFD2227
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2019 09:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733087AbfJJHyX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Oct 2019 03:54:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38466 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733077AbfJJHyX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Oct 2019 03:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wy0nIgFz6pgFWv4Hpr9obe+X20H/TisRVpRpFZiZaeY=; b=cQeZp76lFNnbJ8kjBVwIbzKS1
        ojZdYJ3gRwhWgeG3NVmdIcc8+N8DGfiMq6pe7bXvbcahS5DbmCsuPWQp7cqpiezfYwLUHd4gNDZi5
        2NL8diD+xGScbzPzq60hcyS445pimw1gbllD1IkSUAvp3TZo45rOiYt1jAoNUpSsD0oaN3KWtNH3H
        FDllchYbWlS0WQd3bDI7OzE7zdXdW7bWaU+S/utvlKp1YMPGv5L9WXxL7HZLFfHIsEnjsO3Mzcb9/
        RL9XS5JNZiy2sMNe0CnHt188Xw+lzOc9PmtNqgp0zkJ1bbGBmhvVd9jAW1AGKP/HF5xW7JCXz350s
        NnPq3CRrg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iITHA-0002k9-Iu; Thu, 10 Oct 2019 07:54:20 +0000
Date:   Thu, 10 Oct 2019 00:54:20 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, darrick.wong@oracle.com,
        linux-xfs@vger.kernel.org,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: Re: [PATCH 0/2] iomap: Waiting for IO in iomap_dio_rw()
Message-ID: <20191010075420.GA28344@infradead.org>
References: <20191009202736.19227-1-jack@suse.cz>
 <20191009230227.GH16973@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009230227.GH16973@dread.disaster.area>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 10, 2019 at 10:02:27AM +1100, Dave Chinner wrote:
> That would mean the callers need to do something like this by
> default:
> 
> 	ret = iomap_dio_rw(iocb, iter, ops, dops, is_sync_kiocb(iocb));
> 
> And filesystems like XFS will need to do:
> 
> 	ret = iomap_dio_rw(iocb, iter, ops, dops,
> 			is_sync_kiocb(iocb) || unaligned);
> 
> and ext4 will calculate the parameter in whatever way it needs to.

I defintively like that.

> 
> In fact, it may be that a wrapper function is better for existing
> callers:
> 
> static inline ssize_t iomap_dio_rw()
> {
> 	return iomap_dio_rw_wait(iocb, iter, ops, dops, is_sync_kiocb(iocb));
> }
> 
> And XFS/ext4 writes call iomap_dio_rw_wait() directly. That way we
> don't need to change the read code at all...

I have to say I really hated the way we were growing all these wrappers
in the old direct I/O code, so I've been asked Jan to not add the
wrapper in his old version.  But compared to the force_sync version it
at least makes a little more sense here.  I'm just not sure if
iomap_dio_rw_wait is the right name, but the __-prefix convention for
non-trivial differences also sucks.  I can't think of a better name,
though.
