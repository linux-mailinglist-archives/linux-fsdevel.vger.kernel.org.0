Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B403483C26
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jan 2022 08:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbiADHOX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jan 2022 02:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiADHOW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jan 2022 02:14:22 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1BBC061761;
        Mon,  3 Jan 2022 23:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5GDK6wsjzyCdNrIZIwJzo1FnWILu4v1tiSfyW0Py52E=; b=dPnO0bvO1384YiT1R8mQJHiurs
        +kFTlizPKpvg0r14qaGGRAL06NcsRtdoWB03mrIJNZrVepTyjc4elCTgi1gBxdH9IoVYz7uiPagSE
        7bUUdXvscYPpXC2M4UHt1HWskROxF04MrjcVOZ+gmsuVIvUOzBD3Jw+ULDprsqE7CJdTFcazjjEXg
        xPMODM+iPYU+kwqO/c11qcHtxxuGo9wCnZ3txsd3mf88xJv6Hr4zQKy6A9hc0hQaSBlKljINQTjc6
        fzlERaAmzjGlLcMSxcIP6Cc9yGAQBkUR7sxuPkip1yIMfY3J/9pBD4Wbp/lLsvhzZV0/5lvNNZcq8
        H2AgvrYw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n4e1S-00AUwt-Kr; Tue, 04 Jan 2022 07:14:18 +0000
Date:   Mon, 3 Jan 2022 23:14:18 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] block: add filemap_invalidate_lock_killable()
Message-ID: <YdPzygDErbQffQMM@infradead.org>
References: <0000000000007305e805d4a9e7f9@google.com>
 <3392d41c-5477-118a-677f-5780f9cedf95@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3392d41c-5477-118a-677f-5780f9cedf95@I-love.SAKURA.ne.jp>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 03, 2022 at 07:49:11PM +0900, Tetsuo Handa wrote:
> syzbot is reporting hung task at blkdev_fallocate() [1], for it can take
> minutes with mapping->invalidate_lock held. Since fallocate() has to accept
> size > MAX_RW_COUNT bytes, we can't predict how long it will take. Thus,
> mitigate this problem by using killable wait where possible.

Well, but that also means we want all other users of the invalidate_lock
to be killable, as fallocate vs fallocate synchronization is probably
not the interesting case.

Or we should limit the locked batch size of block device fallocates that
actually do write zeroes, which never really was the intent of the
fallocate interface to start with..
