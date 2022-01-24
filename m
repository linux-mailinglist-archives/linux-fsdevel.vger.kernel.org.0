Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E580C4980E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jan 2022 14:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243095AbiAXNSZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jan 2022 08:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiAXNSY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jan 2022 08:18:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86571C06173B;
        Mon, 24 Jan 2022 05:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eVF/Mv3zSzI2Qv9R17ZtBQ7iXQHeN6j3EvpwEFzhP+A=; b=MtKNoAUtESHAtwBDb3vz7cd1iq
        UZOXon3J+Q3yBBjJ54bWFLp+IXJLgFgUjRKdXSW2AHl4dSQAmoQtijlx2xZVIDVN5Reg2pxKhGsNh
        Tj1kjCJ6AXAEIAs7n74mOFweE1jgA85vQlvIytqfUW90QyrMRqYiFXP3XbgPp+6ztCpD2lsw71NQ+
        6RMnE9W9bjnvj9Vy3JS9NG3G1keJAcVEgmVRst3yMJHwLMIoXMg8LDIosetR3WhVECuDdL/Popbyt
        lmi/+J/eqPGXQK4AgT5cgKhQrG0DONsxkeo8B7KWrQp7CUaT65FpFZXvWMqhjWDRksulTY1LcCU/H
        Xvhx4khw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nBzEh-000fvO-7w; Mon, 24 Jan 2022 13:18:19 +0000
Date:   Mon, 24 Jan 2022 13:18:19 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block@vger.kernel.org
Subject: Re: RFA (Request for Advice): block/bio: get_user_pages() -->
 pin_user_pages()
Message-ID: <Ye6nG6xvVG2xTQkZ@casper.infradead.org>
References: <e83cd4fe-8606-f4de-41ad-33a40f251648@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e83cd4fe-8606-f4de-41ad-33a40f251648@nvidia.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 23, 2022 at 11:52:07PM -0800, John Hubbard wrote:
> To ground this in reality, one of the partial call stacks is:
> 
> do_direct_IO()
>     dio_zero_block()
>         page = ZERO_PAGE(0); <-- This is a problem
> 
> I'm not sure what to use, instead of that zero page! The zero page
> doesn't need to be allocated nor tracked, and so any replacement
> approaches would need either other storage, or some horrid scheme that I
> won't go so far as to write on the screen. :)

I'm not really sure what the problem is.

include/linux/mm.h:             is_zero_pfn(page_to_pfn(page));

and release_pages() already contains:
                if (is_huge_zero_page(page))
                        continue;

Why can't the BIO release function contain an is_zero_pfn() check?
