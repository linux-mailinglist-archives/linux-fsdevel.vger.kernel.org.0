Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB73612893B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Dec 2019 14:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfLUNmY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Dec 2019 08:42:24 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53682 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbfLUNmX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Dec 2019 08:42:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ITvzNp4E23+buFOgn8ttDs82cud3gvCRdk1X3kPR978=; b=IoQ9qVjyYFF8s+zvqVooAolbC
        6TKqMJ+cW4VUCElvLepRF4P7opTxWdMuu2ohBDcYO89609xTjVZYFSRdq/HlNClI3ynQrFGRXNL/w
        Jh+WP+hxYGCxcZh+xoJoB5CsX9s+h9XxNq4fpPA+SrJzddAXEOMQSykUFEFWg5aqelm9gm+UDOu1o
        LOkpxuneLFlox2sKfEPp1338q5TGpkdvJ3g6P3BOuTy/Hl1Iove5BYZ8LSedXVbfgvKey1+MURFJO
        Komyjd4yajn8mSr8YI8U03pZmp/0fBWnb0VYapo6uPv6bZ1+8imFsSV5jL6Fdg9zeL1et1pDsSKuA
        GCNKLIQwA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iif1T-00067B-Aw; Sat, 21 Dec 2019 13:42:23 +0000
Date:   Sat, 21 Dec 2019 05:42:23 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, hch@infradead.org,
        darrick.wong@oracle.com, fdmanana@kernel.org, nborisov@suse.com,
        dsterba@suse.cz, jthumshirn@suse.de, linux-fsdevel@vger.kernel.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 3/8] iomap: Move lockdep_assert_held() to iomap_dio_rw()
 calls
Message-ID: <20191221134223.GA23294@infradead.org>
References: <20191213195750.32184-1-rgoldwyn@suse.de>
 <20191213195750.32184-4-rgoldwyn@suse.de>
 <20191221134118.GA17355@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191221134118.GA17355@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 21, 2019 at 05:41:18AM -0800, Christoph Hellwig wrote:
> On Fri, Dec 13, 2019 at 01:57:45PM -0600, Goldwyn Rodrigues wrote:
> > From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > 
> > Filesystems such as btrfs can perform direct I/O without holding the
> > inode->i_rwsem in some of the cases like writing within i_size.
> > So, remove the check for lockdep_assert_held() in iomap_dio_rw()
> 
> As said last time: in the callers the assert is completely pointless,
> as it is always very close to taking the lock.  This was just intended
> to deal with callers not adhering to the iomap_dio_rw calling
> conventins, and moving the assert to the calllers doesn't help with
> that at all.

And the actual patch even does that, it just is the commit log that
doesn't match it..
