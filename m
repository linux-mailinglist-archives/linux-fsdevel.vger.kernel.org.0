Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA6D6D07EA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 09:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfJIHLr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 03:11:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55448 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfJIHLr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 03:11:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6+sFNh9sdecUMLKw+OaXj40ADI+ElyZNUMxdlvfGrTE=; b=KcTxP8V34WjBLbWUB5h2X2Xi6
        Dpqz31GU+u5ifbnFp6jrnxDiFo4wBcvdywV+QbolbN4eWxk9FPseLHMmbdBifRQ8cfCGzNxx9TcsM
        QuzVr/6YaV7YFF3kmwH5lTotDszmsdVBKIKWr71SXbHMcgWigL8gM5d0iwlVHmcOIPHaA7JP4865j
        6+zr21e72dtuw7BuabX6uVibCREjSUAeKVKVgROgiNC2rDqcvzrjxjHgbwyaC0LOouYrWJ3kVwbU4
        1PuiJzz24QYnBXaqpdh1MpuMUMhDi8DneFPjsleCrOBoZYFSzulclGKsfxMlpNZTEIXBQkzKFvbdB
        LRlwz8bVA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iI68P-0002Xs-3v; Wed, 09 Oct 2019 07:11:45 +0000
Date:   Wed, 9 Oct 2019 00:11:45 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, hch@infradead.org,
        david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v4 8/8] ext4: introduce direct I/O write path using iomap
 infrastructure
Message-ID: <20191009071145.GB32281@infradead.org>
References: <cover.1570100361.git.mbobrowski@mbobrowski.org>
 <9ef408b4079d438c0e6071b862c56fc8b65c3451.1570100361.git.mbobrowski@mbobrowski.org>
 <20191008151238.GK5078@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008151238.GK5078@quack2.suse.cz>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 08, 2019 at 05:12:38PM +0200, Jan Kara wrote:
> Seeing how difficult it is when a filesystem wants to complete the iocb
> synchronously (regardless whether it is async or sync) and have all the
> information in one place for further processing, I think it would be the
> easiest to provide iomap_dio_rw_wait() that forces waiting for the iocb to
> complete *and* returns the appropriate return value instead of pretty
> useless EIOCBQUEUED. It is actually pretty trivial (patch attached). With
> this we can then just call iomap_dio_rw_sync() for the inode extension case
> with ->end_io doing just the unwritten extent processing and then call
> ext4_handle_inode_extension() from ext4_direct_write_iter() where we would
> have all the information we need.
> 
> Christoph, Darrick, what do you think about extending iomap like in the
> attached patch (plus sample use in XFS)?

I vaguely remember suggesting something like this but Brian or Dave
convinced me it wasn't a good idea.  This will require a trip to the
xfs or fsdevel archives from when the inode_dio_wait was added in XFS.

But if we decide it actully works this time around please don't add the
__ variant but just add the parameter to iomap_dio_rw directly.
