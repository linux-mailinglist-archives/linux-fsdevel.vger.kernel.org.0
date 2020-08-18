Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 147EE248C03
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 18:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbgHRQum (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Aug 2020 12:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbgHRQuj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Aug 2020 12:50:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DC9C061389;
        Tue, 18 Aug 2020 09:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qCqqjOiLMHkOe7OKrabPC0fHPBkc8WYvYKWB05C5lb0=; b=aQxoaYhPMx3PeS+HZ1YaCcl/Mr
        uoDnpgLIyEXgYPI8xJjvMIbt/DTq3PCSe5U6hEPoeNU/Dh4zcNqQZ3DfOFTZgNxKYdu6VEvFGEltU
        STWrIxlX2ZTKhM1NPG0QGV+FUxkpz5JC/mxZVJeKJGPbxupCmb8xSWflhqxMHCqvBt4eFMM8AwFAT
        KK0tkNbk0B2u7xlQqhYH32pSr9GM7QOAYBEa6/v9kN0ZIQd8MOViZxGoBkQeVqED3pEdAYSRBB9o/
        6N25+AyN7o1KMGn9eBkVVEb4mGMs0nPogrAFbPiqzivTAjBs2ahGJ8KtAkVnhhqlAcTW3Y+Tb58/W
        KE6fszGQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k84oV-0001GK-AE; Tue, 18 Aug 2020 16:50:19 +0000
Date:   Tue, 18 Aug 2020 17:50:19 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Yu Kuai <yukuai3@huawei.com>, hch@infradead.org,
        david@fromorbit.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [RFC PATCH V2] iomap: add support to track dirty state of sub
 pages
Message-ID: <20200818165019.GT17456@casper.infradead.org>
References: <20200818134618.2345884-1-yukuai3@huawei.com>
 <20200818155305.GR17456@casper.infradead.org>
 <20200818161229.GK6107@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818161229.GK6107@magnolia>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 18, 2020 at 09:12:29AM -0700, Darrick J. Wong wrote:
> On Tue, Aug 18, 2020 at 04:53:05PM +0100, Matthew Wilcox wrote:
> > It would be better to use the same wording as below:
> > 
> > > +	bitmap_zero(iop->state, PAGE_SIZE * 2 / SECTOR_SIZE);
> 
> ISTR there was some reason why '512' was hardcoded in here instead of
> SECTOR_SIZE.  I /think/ it was so that iomap.h did not then have a hard
> dependency on blkdev.h and everything else that requires...

That ship already sailed.  I over-trimmed this line:

-       bitmap_zero(iop->uptodate, PAGE_SIZE / SECTOR_SIZE);

Looks like Christoph changed his mind sometime between that message
and the first commit: 9dc55f1389f9569acf9659e58dd836a9c70df217

My THP patches convert the bit array to be per-block rather than
per-sector, so this is all going to go away soon ;-)

> https://lore.kernel.org/linux-xfs/20181215105155.GD1575@lst.de/
