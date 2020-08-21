Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87D6F24D546
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 14:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgHUMoc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 08:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgHUMoa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 08:44:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DCCC061385;
        Fri, 21 Aug 2020 05:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XCvj4UvtI8iBMYfCEtiYykY+vZaMey49dX7k5fdz2Jg=; b=KC6s2PS1ionfOA78d78PGDMnaB
        FDAIx5puFcJZXfcSERkREBH32q+nIbrgXoHUzQQEgU1mBAbPrkfGAJlvSAlsHMLfsGLxHKbXbFmEP
        gQXHWs+AmSm4PDeKFmIKpshtm6F/h43HCmxteQyPaOBa5/+HCYjwoyOrQM+mIuNN//3M0F/OUqakg
        D5ehuGs8JM6e9288weor4jAwKwv6dpmTsN8ydizOAXMOTD99eJ4lrt8PUN7Nfzhbcx0Nsietjmgrm
        YC8qNAgchLRkivAdnJFy3zUaMJg3/HTdoRrTkJEj6SdTlU0D5n8ZNl9qAW6mEDPoh5077C8BmCfk1
        48nuulxg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k96PA-0002Yc-2R; Fri, 21 Aug 2020 12:44:24 +0000
Date:   Fri, 21 Aug 2020 13:44:24 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     hch@infradead.org, darrick.wong@oracle.com, david@fromorbit.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [RFC PATCH V4] iomap: add support to track dirty state of sub
 pages
Message-ID: <20200821124424.GQ17456@casper.infradead.org>
References: <20200821123306.1658495-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821123306.1658495-1-yukuai3@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 21, 2020 at 08:33:06PM +0800, Yu Kuai wrote:
> changes from v3:
>  - add IOMAP_STATE_ARRAY_SIZE
>  - replace set_bit / clear_bit with bitmap_set / bitmap_clear
>  - move iomap_set_page_dirty() out of 'iop->state_lock'
>  - merge iomap_set/clear_range_dirty() and iomap_iop_clear/clear_range_dirty()

I'm still working on the iomap parts of the THP series (fixing up
invalidatepage right now), but here are some of the relevant bits (patch
series to follow)

