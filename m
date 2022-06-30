Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7742656262E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 00:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiF3Wjp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 18:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiF3Wjp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 18:39:45 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B18951B0C
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 15:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GD/Hti1sWvpMFSRq5MfDqG+5hPD5td65NxnTY84ovec=; b=FJuITr7h1Mo0KhHrrcPrgFUyb0
        YkanKWf2QyYCcLH+6J1+RSFCcUQDjI40ZokBGXSuCEk6m86315L25mIJQfervd2P3kRYwmYTklDAK
        MwxmYBpoal+BJzRfuD2BMO1Z6vWiX595IYX3rIMirJYpP68FIf4dMYEcQmAcmMnFStsc+1Y6a+Rqz
        vqGpVSO9SKGtRigQEFEZKLvtJ9yvtsUuAG2+jtXWM+WlaijUrRcphyecnGHxmu/4vpay0O77XzzdS
        rfHuANlg7Ud2dV5tGVGteX9s8dEaFPJVo1J2AYnUhHVF35UxdDVV+ysDZkpprzHf87QYo+W7G+lzK
        JpPfJtqw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o72oy-006iOc-Hs;
        Thu, 30 Jun 2022 22:39:36 +0000
Date:   Thu, 30 Jun 2022 23:39:36 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [block.git conflicts] Re: [PATCH 37/44] block: convert to
 advancing variants of iov_iter_get_pages{,_alloc}()
Message-ID: <Yr4mKJvzdrUsssTh@ZenIV>
References: <YrKWRCOOWXPHRCKg@ZenIV>
 <20220622041552.737754-1-viro@zeniv.linux.org.uk>
 <20220622041552.737754-37-viro@zeniv.linux.org.uk>
 <Yr4fj0uGfjX5ZvDI@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yr4fj0uGfjX5ZvDI@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 30, 2022 at 11:11:27PM +0100, Al Viro wrote:

> ... and the first half of that thing conflicts with "block: relax direct
> io memory alignment" in -next...

BTW, looking at that commit - are you sure that bio_put_pages() on failure
exit will do the right thing?  We have grabbed a bunch of page references;
the amount if DIV_ROUND_UP(offset + size, PAGE_SIZE).  And that's before
your
                size = ALIGN_DOWN(size, bdev_logical_block_size(bio->bi_bdev));
in there.  IMO the following would be more obviously correct:
        size = iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
        if (unlikely(size <= 0))
                return size ? size : -EFAULT;

	nr_pages = DIV_ROUND_UP(size + offset, PAGE_SIZE);
	size = ALIGN_DOWN(size, bdev_logical_block_size(bio->bi_bdev));

        for (left = size, i = 0; left > 0; left -= len, i++) {
...
                if (ret) {
			while (i < nr_pages)
				put_page(pages[i++]);
                        return ret;
                }
...

and get rid of bio_put_pages() entirely.  Objections?
