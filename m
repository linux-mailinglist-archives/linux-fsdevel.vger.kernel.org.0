Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC832C242D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 12:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732865AbgKXLaC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 06:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732723AbgKXLaC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 06:30:02 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320A9C0613D6;
        Tue, 24 Nov 2020 03:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZZ2l4IESKUU682BRulh2Bd5uLxUPUcTi214dKXSiVxA=; b=ndo6Ljx/trPHysvjVeLBFgsGLR
        +iCJhVTS60wRMqIzm5JXdrdKHX1JCpTJwGLcjmpVB6UY6CqXg7v8MwyZR1HdmdiO0vVXPEqs95sCL
        d/ap4KZJvOiodxa3+XsJRJ0JnIdnL2fg5m/kz4L3D+7ipz0XYCgnvY8NAzYdJldM8zW4ErZ+pq4iM
        G4uzgxHsrRF6WcM2ammZh51pCvKwokvQjaK3ylMCmuoTJq1xrDW/hzoiRivWCHBRS3jZPjsOggLd1
        suI0Nli39LjgmjdcnUg2Wuh17xNPYipwrMORYzIJETntSnRv8r8fkv3twBp4Ysp5ib5V7mCMTGaUP
        35MHHi1g==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khWW9-0007Pq-8M; Tue, 24 Nov 2020 11:29:53 +0000
Date:   Tue, 24 Nov 2020 11:29:53 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com, hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v10 02/41] iomap: support REQ_OP_ZONE_APPEND
Message-ID: <20201124112953.GA27727@infradead.org>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
 <72734501cc1d9e08117c215ed60f7b38e3665f14.1605007036.git.naohiro.aota@wdc.com>
 <20201110185506.GD9685@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110185506.GD9685@magnolia>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 10, 2020 at 10:55:06AM -0800, Darrick J. Wong wrote:
> When we're wanting to use a ZONE_APPEND command, the @iomap structure
> has to have IOMAP_F_ZONE_APPEND set in iomap->flags, iomap->type is set
> to IOMAP_MAPPED, but what should iomap->addr be set to?
> 
> I gather from what I see in zonefs and the relevant NVME proposal that
> iomap->addr should be set to the (byte) address of the zone we want to
> append to?  And if we do that, then bio->bi_iter.bi_sector will be set
> to sector address of iomap->addr, right?

Yes.

> Then when the IO completes, the block layer sets bio->bi_iter.bi_sector
> to wherever the drive told it that it actually wrote the bio, right?

Yes.

> If that's true, then that implies that need_zeroout must always be false
> for an append operation, right?  Does that also mean that the directio
> request has to be aligned to an fs block and not just the sector size?

I think so, yes.

> Can userspace send a directio append that crosses a zone boundary?  If
> so, what happens if a direct append to a lower address fails but a
> direct append to a higher address succeeds?

Userspace doesn't know about zone boundaries.  It can send I/O larger
than a zone, but the file system has to split it into multiple I/Os
just like when it has to cross and AG boundary in XFS.

> I'm also vaguely wondering how to communicate the write location back to
> the filesystem when the bio completes?  btrfs handles the bio completion
> completely so it doesn't have a problem, but for other filesystems
> (cough future xfs cough) either we'd have to add a new callback for
> append operations; or I guess everyone could hook the bio endio.
> 
> Admittedly that's not really your problem, and for all I know hch is
> already working on this.

I think any non-trivial file system needs to override the bio completion
handler for writes anyway, so this seems reasonable.  It might be worth
documenting, though.
