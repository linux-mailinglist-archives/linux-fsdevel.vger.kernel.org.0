Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1DD733724A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 13:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbhCKMTy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Mar 2021 07:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232781AbhCKMTs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Mar 2021 07:19:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CF6C061574;
        Thu, 11 Mar 2021 04:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XlQyuboYgzWxooTeci4Rog66BxxnzDAehcID4SPIFSo=; b=v3njQKeaX4Pbb8Na4hXs0oFO/e
        78jdKnI1IOuKOxhZ3g1ccVJB7ixBlwgGXmXHu08AWrRoED9lAyiLyFf/Am4HTCOhNWNmgyI8P0PMI
        qRuBQaL2DFnAlc/Ey6GwwwRPq8MWd6bsF44emvtAr2/L+H62ofkPY5Gkj0COWaNkzfEdEvftUblMX
        Eis0SqnHFXuwVkAmsJkT6KlQlMfuM4BA7iBT+yy4m5ugP1okTqznhY8fsaVOomKwyzNYCQsTmAbVY
        aXu3P56nUabWLhncskyP8b0KtRwN6qhUFWzwKGIMQUFVvhSGIUB8gSMaswGo5sNWSbY9dQHQ3kNPf
        ulLJ+EPA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lKKHj-007IJR-JG; Thu, 11 Mar 2021 12:19:26 +0000
Date:   Thu, 11 Mar 2021 12:19:23 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "chenjun (AM)" <chenjun102@huawei.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>,
        "Xiangrui (Euler)" <rui.xiang@huawei.com>,
        "lizhe (Y)" <lizhe67@huawei.com>, yangerkun <yangerkun@huawei.com>,
        "zhangyi (F)" <yi.zhang@huawei.com>
Subject: Re: [question] Panic in dax_writeback_one
Message-ID: <20210311121923.GU3479805@casper.infradead.org>
References: <CE1E7D7EFA066443B6454A6A5063B50220D0B849@dggeml509-mbs.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CE1E7D7EFA066443B6454A6A5063B50220D0B849@dggeml509-mbs.china.huawei.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 11, 2021 at 07:48:25AM +0000, chenjun (AM) wrote:
> static int dax_writeback_one(struct xa_state *xas, struct dax_device 
> *dax_dev, struct address_space *mapping, void *entry)
> ----dax_flush(dax_dev, page_address(pfn_to_page(pfn)), count * PAGE_SIZE);
> The pfn is returned by the driver. In my case, the pfn does not have
> struct page. so pfn_to_page(pfn) return a wrong address.

I wasn't involved, but I think the right solution here is simply to
replace page_address(pfn_to_page(pfn)) with pfn_to_virt(pfn).  I don't
know why Dan decided to do this in the more complicated way.
