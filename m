Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A1E1A8380
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 17:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440729AbgDNPlO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 11:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730181AbgDNPk7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 11:40:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D884C061A0C;
        Tue, 14 Apr 2020 08:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uWqF91n+VhADIdhuzisMtYavXGhMw/jiYsc8UWNs3HE=; b=HzraabfbjAbD5+L7alBwAuxQg4
        rZ9TPhmym2Y8LbdBNXVWQtDEQyqbmeqD25/XbZE3tUhzhH/JcUGRIhNkCbpWtxjVXIz/rlIO6KHuX
        aZYI6KMDyzAHtTU8UC2ruyG2iigFrhPaPbyHnOP8pUCpiDIOELu57X5myWxab1z9jknAG44shMPQW
        7is7vPB71BKCuvvh5xQkSMafc65QzJnst7pERFZ/HSXWvbWmkAGDwhYTbQoFW/UzVHYsb5TXAGm9g
        ewvBfmh/GN5FW+TwYsmj2pj1t2jE0yuap2tRGO56LY1erH+/++9Q9aZoERVLOVs/ssgCjrbF5QeVW
        FZIPSzdw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jONg4-00008t-OZ; Tue, 14 Apr 2020 15:40:44 +0000
Date:   Tue, 14 Apr 2020 08:40:44 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org, mhocko@suse.com, yukuai3@huawei.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 3/5] blktrace: refcount the request_queue during ioctl
Message-ID: <20200414154044.GB25765@infradead.org>
References: <20200414041902.16769-1-mcgrof@kernel.org>
 <20200414041902.16769-4-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414041902.16769-4-mcgrof@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 14, 2020 at 04:19:00AM +0000, Luis Chamberlain wrote:
> Ensure that the request_queue is refcounted during its full
> ioctl cycle. This avoids possible races against removal, given
> blk_get_queue() also checks to ensure the queue is not dying.
> 
> This small race is possible if you defer removal of the request_queue
> and userspace fires off an ioctl for the device in the meantime.

Hmm, where exactly does the race come in so that it can only happen
after where you take the reference, but not before it?  I'm probably
missing something, but that just means it needs to be explained a little
better :)
