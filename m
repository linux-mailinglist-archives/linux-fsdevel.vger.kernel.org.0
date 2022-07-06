Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A30569500
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jul 2022 00:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbiGFWHD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jul 2022 18:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbiGFWHC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jul 2022 18:07:02 -0400
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F096A1B0
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Jul 2022 15:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=IzB1b+nmSnfqZDAI35o7K5DhzmsV6TYJdwnb/MeW1oQ=; b=wv+3PtMTxy6iomRDNrOOHBCqsN
        PVYnQOdrK4u+Uj3JI/lCJSGuE4SxPOLmaZYpDDMRZXOolM6GWHIan1J5BuYNQHbj07FVAUljh00Ad
        aD4Pcr124BSi7Eiw2ZX6s31OiwcfK4NOYBACZSTCFHVEVImx3cxsXwIKzvlWDYLtZLGjJXQi1Ngs6
        lxb2legJy0Mzs+BoO/jvhjfcNdZdYy6nTLYOdFzmvCAyRq2PEkQhEnIsp1GZzbo7xQDY0h7NKEKbk
        uUUmaFxlLQLeFNOnPKlWmMZpo+F4KMdYi26O1pcCH4ERWSXOZxzMsUpcrJYW0yxGF0uoA9MhOdgK7
        zpiGQh0bcWob7Z5RTNt4AOLJnL+DZSYjGmxNn+Vl3kHFFeUJv/V2vdyjE9LCALqrcJoXk7G8awO4W
        DhgextQTfJ9NGbwzqIFrA8t2EnnsC+N+CvVIK37HrFd/Xhu1s2Y5I26TUVGZJKxUI8EQrN+I8b62a
        AwGn79Oxx/Fj2nPafhivqT2iYmqITijhotQiY5zJm4mEpAkNxfpKSPk1k0HllMOcF0kWjMKuAiGIN
        2O4pxf/H6tlVArrnCXkpTPDLrtCC3539hfgtBi5fGU+S51huRBjeQJkXtZZ6zcVYoH/QXlI9eUw7Z
        z2m6qtRcqkZgjaw3ZxB1s7UJtNHs26Pk4tV9L3KxI=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 40/44] 9p: convert to advancing variant of
 iov_iter_get_pages_alloc()
Date:   Thu, 07 Jul 2022 00:06:56 +0200
Message-ID: <1910606.yFZSPlTZL1@silver>
In-Reply-To: <7966323.F5XntFNgCk@silver>
References: <YrKWRCOOWXPHRCKg@ZenIV> <20220622041552.737754-40-viro@zeniv.linux.org.uk>
 <7966323.F5XntFNgCk@silver>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Freitag, 1. Juli 2022 15:47:24 CEST Christian Schoenebeck wrote:
> On Mittwoch, 22. Juni 2022 06:15:48 CEST Al Viro wrote:
> > that one is somewhat clumsier than usual and needs serious testing.
> > 
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> 
> Hi Al,
> 
> it took me a bit to find the patch that introduces
> iov_iter_get_pages_alloc2(), but this patch itself looks fine:
> 
> Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>

Tested-by: Christian Schoenebeck <linux_oss@crudebyte.com>



