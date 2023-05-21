Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147BF70AC32
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 May 2023 05:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjEUDkr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 May 2023 23:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjEUDk2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 May 2023 23:40:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB5A119;
        Sat, 20 May 2023 20:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=skkPldTdNBXlx5+4kVMCe3+Fv9+/+TBY8sALbfR2BeU=; b=dtq7gM1tP5wv7UUZbkdQZkFIAy
        dbTcJi0hkDAshG1iUXyh0jkwFHstnWqB2vy7deWUTfeZtIleG4AFpFIQ9IzgS2yto5hwOjKqm4yQt
        5jR/fvvdd/SZKZm2OunDIBKU/cnEkEfeAKHJiftDa/ldcD1Mh7wUvPMlzKu8Wco8FdFTwFYxEiHIq
        NNoZZiHeOXLJnzuqf1nSwyyFG8ear/BmBv5mGfjKCi9ROb6GIjdBPj34S1u88sVVj8mCW4xniJHDd
        DRvL+qhf0Rxkufom05/KGSFegnJw+9XYpN3R8jOojMvRD+jCSznLyJ+zsqtZ5bQiT8eZObzjZW7rY
        1mF1nUIA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q0Zue-007vJc-G2; Sun, 21 May 2023 03:39:16 +0000
Date:   Sun, 21 May 2023 04:39:16 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH 1/3] filemap: Allow __filemap_get_folio to allocate large
 folios
Message-ID: <ZGmSZP2DeRD/XSun@casper.infradead.org>
References: <20230521090235.4860.409509F4@e16-tech.com>
 <ZGl6UZ0a+fIAPmn5@casper.infradead.org>
 <20230521100434.716E.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230521100434.716E.409509F4@e16-tech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 21, 2023 at 10:04:35AM +0800, Wang Yugui wrote:
> > I don't see it?
> > 
> > size == 1 << 20;
> > 
> > shift = 20;
> > return (20 - 12) << 26;
> > 
> > Looks like about 1 << 29 to me.
> 
> sorry that I wrongly
> 1) wrongly conside PAGE_SHIFT as 13 from arch/alpha/include/asm/page.h
> it should be 12 from arch/x86/include/asm/page_types.h.
> 
> 2) wrongly conside
> 	(20 - 12) << 26
> as
> 	1<< (20 - 12) << 26

Ah, no problem.  Glad I didn't miss something.
