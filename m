Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53748D70B3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 10:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbfJOIFm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 04:05:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38114 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728350AbfJOIFm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 04:05:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ojwjcHlS7s088BWF5jHjga+bDbB6CPSLjEsnZu31UEA=; b=F5xdozstYs8n+8OfDs9v1mcAb
        2IYjdtbuBpGeC9CFuNXZ6/eS6+J8mGLVyiC9i5XksqVYXmqvOO3JNX5Y9qST+aKMtDKvj9Bo813ki
        1uJ3btqQwEhGfBN5RrfScdlXicpKVNnt1UJXbLwfTF7vjmAuPDCbSxYF755L/iIItjrVy2FwC3b5n
        9fGgQRwUOnLphcfpel/iBGNGsvEcPvXn2WBbRI+8IKOU2AMyduA7Ealn5TshJa33u/LsDPwHl7Jw9
        /RpVYpzSvUR7ZAEALK50t91J0jCjvADfCz20w9WL/BgYv9S5+wflC4qLGVUuNdIgB97tJR/PHcnJa
        9sSouaOxQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iKHpt-0003yM-RU; Tue, 15 Oct 2019 08:05:41 +0000
Date:   Tue, 15 Oct 2019 01:05:41 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     yangerkun <yangerkun@huawei.com>
Cc:     hch@infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, yi.zhang@huawei.com,
        houtao1@huawei.com
Subject: Re: [PATCH] iomap: fix the logic about poll io in iomap_dio_bio_actor
Message-ID: <20191015080541.GE3055@infradead.org>
References: <20191014144313.26313-1-yangerkun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014144313.26313-1-yangerkun@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 14, 2019 at 10:43:13PM +0800, yangerkun wrote:
> Just set REQ_HIPRI for the last bio in iomap_dio_bio_actor. Because
> multi bio created by this function can goto different cpu since this
> process can be preempted by other process. And in iomap_dio_rw we will
> just poll for the last bio. Fix it by only set polled for the last bio.

I agree that there is a problem with the separate poll queue now.  But
doing partially polled I/O also doesn't seem very useful.  Until we
can find a way to poll for multiple bios from one kiocb I think we need
to limit polling to iocbs with just a single bio.  Can you look into
that?  __blkdev_direct_IO do_blockdev_direct_IO probably have the same
issues.  The former should be just as simple to fix, and for the latter
it might make sense to drop polling support entirely.
