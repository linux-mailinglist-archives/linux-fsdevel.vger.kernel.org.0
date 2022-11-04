Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66606619285
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Nov 2022 09:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiKDIOJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Nov 2022 04:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiKDIOH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Nov 2022 04:14:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E9025EA4;
        Fri,  4 Nov 2022 01:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GAW1j5A5JDF6GQGsp28PoKWZc0w/cQdwVJUdKgYTIdA=; b=pbFkEc5+XK81YplUsbz8I6eGvN
        T6CyN+NTL+LGpTZicxFZXINQOdR/tZKdIkSuLJ+hbZBkkjgkYJ756fiW6ws0uzi84yqT6pXeied+Q
        mDNGzdZGqOA1tiFzBqSuTD3UbHe1bp9Izpuoo7gwyEhOxq0+/dHxwIYJ4hOW6KVeKqtsPqAm6XyAm
        rDbSQm5eGwnP2qqkm9Z7WoDWYdnUCTSpsvdXQjPiV9PVfNuwN43ZQVvrnd44+7PYUUIHffU/A+Yt6
        puYY7ta8hAsAmEmgtpfgmddrCv78+dpMnq7VvQqMHCB3uNAeZGcqFFqzHMi1viYg0kSfgO3sKGVhI
        GEtGTXDw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oqrq2-002uza-Dj; Fri, 04 Nov 2022 08:14:06 +0000
Date:   Fri, 4 Nov 2022 01:14:06 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 6/7] xfs: use iomap_valid method to detect stale cached
 iomaps
Message-ID: <Y2TJztmjk9V0NO4m@infradead.org>
References: <20221101003412.3842572-1-david@fromorbit.com>
 <20221101003412.3842572-7-david@fromorbit.com>
 <Y2ItNSakpecwC9Va@infradead.org>
 <20221102213927.GB3600936@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102213927.GB3600936@dread.disaster.area>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 03, 2022 at 08:39:27AM +1100, Dave Chinner wrote:
> My concerns with putting it into the iomap is that different
> filesystems will have different mechanisms for detecting stale
> iomaps. THe way we do it with a generation counter is pretty coarse
> as any change to the extent map will invalidate the iomap regardless
> of whether they overlap or not.

OTOH it is a good way to nudge users to at least implement this simple
but working scheme, and it has no real overhead if people later want
to do something more fancy.

> If, in future, we want something more complex and finer grained
> (e.g. an iext tree cursor) to allow us to determine if the
> change to the extent tree actually modified the extent backing the
> iomap, then we are going to need an opaque cookie of some kind, not
> a u32 or a u32*.

Yes, but for that it actually has to be worth it and be implemented.
