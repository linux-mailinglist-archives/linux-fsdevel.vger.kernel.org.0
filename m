Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5C43BA485
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jul 2021 21:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbhGBUAs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jul 2021 16:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbhGBUAs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jul 2021 16:00:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25027C061762;
        Fri,  2 Jul 2021 12:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rd3fCmRQ3i5zSIy92WhoijXedJ4tTsSkdqIAJCX9pvk=; b=kJvtVtTI1FxNsAU186RY6u8++z
        LFbolpFVSnwqLB0ULZVvhIIDEKbgENZJiAmlG/0Wc1GhSgP0n3u3Bx+ks+7ZEw185MKR7SjDzHBwp
        JjuzesV7AbVOTGvAU/ZAPKQo1Mp3UjIA7H9Dk+YyrtcmU72R64dyCNwF9yY93lBkA0Iwu9QG+WDq3
        pRFBt6+dpKLstUYXA71hu5Gla2NGCYhMTWB2OxrOYfR1v1toP8GWypwTHOM40PxL6sFYRTfKOCLEq
        dNJDxeBqff8ZKIAXRCFvcJsLqKF93xA912FKeCiZDzL7WNijJpkTxk7RILfaeN8+H7mSeIgfN5bqr
        LIjqWlYw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lzPGv-0080GQ-IH; Fri, 02 Jul 2021 19:56:45 +0000
Date:   Fri, 2 Jul 2021 20:56:21 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next 1/1] iomap: Fix a false positive of UBSAN in
 iomap_seek_data()
Message-ID: <YN9vZfo+84gizjtf@casper.infradead.org>
References: <20210702092109.2601-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210702092109.2601-1-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 02, 2021 at 05:21:09PM +0800, Zhen Lei wrote:
> Move the evaluation expression "size - offset" after the "if (offset < 0)"
> judgment statement to eliminate a false positive produced by the UBSAN.
> 
> No functional changes.
> 
> ==========================================================================
> UBSAN: Undefined behaviour in fs/iomap.c:1435:9
> signed integer overflow:
> 0 - -9223372036854775808 cannot be represented in type 'long long int'

I don't understand.  I thought we defined the behaviour of signed
integer overflow in the kernel with whatever-the-gcc-flag-is?

