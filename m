Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 400161F3D7B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jun 2020 16:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbgFIODJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 10:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbgFIODI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 10:03:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3437FC05BD1E;
        Tue,  9 Jun 2020 07:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ny9vncRIzXlNaOwGberHEUJNO0SJ575Sy7XU1PiFiHU=; b=lFMfFcMOdKN7Z6aE1/vocLxn3l
        pWyzovl6er3rVS9F8kCBH5QEMZwyt1aGddKL5B/tjO/jUiVqozuURk+NfWIJC+7sYpog2v73YlVr5
        NbmGpZvTyLeyiJBQp9lclQvGK48tymQFVOD4RiL8FGoW5/f4GtIpB3E1021RCnyOTz3SdXeRSVkXa
        APK4GZvgjF966p1WY9HBSQpyqmh3PtMPeYkA6Rfz7UER1CozUq77lLvA/AAZ8GeKsvUSxJR7b1F85
        pePTU4PtnfaN8z0uYTWoiQWM4ZoR2xNx+w0UEI67hZpwPtSa1w571tE/Gj+ijY14neDHPSzLES1R0
        Qi1/sq/A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jieqG-0006Pm-5B; Tue, 09 Jun 2020 14:03:04 +0000
Date:   Tue, 9 Jun 2020 07:03:04 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     darrick.wong@oracle.com, david@fromorbit.com, hch@infradead.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] iomap: avoid deadlock if memory reclaim is triggered
 in writepage path
Message-ID: <20200609140304.GA11626@infradead.org>
References: <1591254347-15912-1-git-send-email-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591254347-15912-1-git-send-email-laoar.shao@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 04, 2020 at 03:05:47AM -0400, Yafang Shao wrote:
> Recently there is a XFS deadlock on our server with an old kernel.
> This deadlock is caused by allocating memory in xfs_map_blocks() while
> doing writeback on behalf of memroy reclaim. Although this deadlock happens
> on an old kernel, I think it could happen on the upstream as well. This
> issue only happens once and can't be reproduced, so I haven't tried to
> reproduce it on upsteam kernel.

The report looks sensible, but I don't think the iomap code is the
right place for this.  Until/unless the VM people agree that
->writepages(s) generally should not recurse into the fs I think the
low-level file system allocating is the right place, so xfs_map_blocks
would seem like the correct place.
