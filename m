Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA01132CE5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 18:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgAGRXB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 12:23:01 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34576 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728292AbgAGRXB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 12:23:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=i2nhsysMNEbmj26CAarD2a+4+ZsWCwB8cVF/8UKJy5Y=; b=AJhldERZhO1ZmK8rntydZBaJV
        W7VzobCfuyv0IDUNPqWPPM8wxIll27RsMw5gDGnQRyMPPADfmTbqn2YvU7BrYgjpefOomRIFl/X4k
        JGDKpdE4sVHLaQtUucOkkarjR4NmPJm9OBQ+cYA9i/RSAjFk9vKlcz3STwOWVmxHrHVhuN2Ogp1kG
        +3q5wFo4T3bKJFzpYCwagfp+2139y41nJmkrnZ9BDa00XGTjq0HjVpUA2K4ovq8QM6BIiB7PnQGZN
        5Rgcy7Ygt8jxgrJ8iSfeLOhTrbCdPSY1CGKH6mMN4D1Y4wsa8nNeU88vdvHbf+w6BUvK6P3lFDUOS
        /5e+JgIsw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iosZI-0004rw-1i; Tue, 07 Jan 2020 17:23:00 +0000
Date:   Tue, 7 Jan 2020 09:23:00 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-btrfs@vger.kernel.org,
        darrick.wong@oracle.com, fdmanana@kernel.org, nborisov@suse.com,
        dsterba@suse.cz, jthumshirn@suse.de, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/8] btrfs: Switch to iomap_dio_rw() for dio
Message-ID: <20200107172300.GB11624@infradead.org>
References: <20191213195750.32184-1-rgoldwyn@suse.de>
 <20191213195750.32184-5-rgoldwyn@suse.de>
 <20191221144226.GA25804@infradead.org>
 <20200102180127.65oh2zmclpmy75ix@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200102180127.65oh2zmclpmy75ix@fiona>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 02, 2020 at 12:01:27PM -0600, Goldwyn Rodrigues wrote:
> On  6:42 21/12, Christoph Hellwig wrote:
> > So Ilooked into the "unlocked" direct I/O case, and I think the current
> > code using dio_sem is really sketchy.  What btrfs really needs to do is
> > take i_rwsem shared by default for direct writes, and only upgrade to
> > the exclusive lock when needed, similar to xfs and the WIP ext4 code.
> 
> Sketchy in what sense? I am not trying to second-guess, but I want to
> know where it could fail. I would want it to be simpler as well, but if
> we can perform direct writes without locking, why should we introduce
> locks.

In that it needs yet another lock which doesn't really provide
exclusion guarantees in its own.  In many ways this lock plus the
historic i_mutex were abused to provide the shared/exclusiv lock
that now exists natively with i_rwsem.
