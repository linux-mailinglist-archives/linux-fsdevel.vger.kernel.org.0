Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B672B9A51
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Nov 2020 19:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbgKSSDT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Nov 2020 13:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728880AbgKSSDS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Nov 2020 13:03:18 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F13C0613CF;
        Thu, 19 Nov 2020 10:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/T+8AFyLl36EP0BJCpl/7y0TJdJH2AjtO1rZ2kV15Ho=; b=dp022ZLCgTAUhuPA52+TqG9Dq8
        pT8vqGrYW1pWTS8qo2oRay9oXZ3bZQ4RTr3pMkcdUlYXPGyf4w0od2HZRkMFimWQ9hGdFcFdWf0PI
        3BmJkKNKOTLfBYRmKt1HYZa6293WVZUtSLdP0SOKMqyoBHesPqyyV0T23Jo3KISkOuiOHumMU0rLs
        6Nmtusy6xH/OnEdqZ0UfaydbgXXN0w3sJBd8/HOUzJUW7rAvuWskRYw/ZDNeB9kux4iUjCpHcKYjI
        tYK8CydDWwAPscox0LN28xB3z9tAVH4Ngupja5uOw3XUgkegiTTMC8iVOug8Jz1Sf4BTL+TD9tdwp
        QH06PwFA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kfoH5-0006S6-Qy; Thu, 19 Nov 2020 18:03:15 +0000
Date:   Thu, 19 Nov 2020 18:03:15 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] eventfd: convert to ->write_iter()
Message-ID: <20201119180315.GB24054@infradead.org>
References: <ed4484a3dc8297296bfcd16810f7dc1976d6f7d0.1605808477.git.mkubecek@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed4484a3dc8297296bfcd16810f7dc1976d6f7d0.1605808477.git.mkubecek@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 19, 2020 at 07:00:19PM +0100, Michal Kubecek wrote:
> While eventfd ->read() callback was replaced by ->read_iter() recently by
> commit 12aceb89b0bc ("eventfd: convert to f_op->read_iter()"), ->write()
> was not replaced.
> 
> Convert also ->write() to ->write_iter() to make the interface more
> consistent and allow non-blocking writes from e.g. io_uring. Also
> reorganize the code and return value handling in a similar way as it was
> done in eventfd_read().

But this patch does not allow non-blocking writes.  I'm really
suspicious as you're obviously trying to hide something from us.
