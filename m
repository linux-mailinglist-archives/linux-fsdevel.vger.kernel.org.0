Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A208E3B3172
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jun 2021 16:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbhFXOfk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Jun 2021 10:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbhFXOfj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Jun 2021 10:35:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDA2C061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Jun 2021 07:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Vac4KMPv7toMg6xvfIcq1d8YzQttnltHnR0zqVrbeVc=; b=Iq061BFc+Wd+AjRniWdlf4WsYj
        Xj5lhE2MVW9w/4QBgoGamZ/VrWwF7+ey1Y1R8FoUgAzw3mrG2AERkU4gfbIBNx2ZKQL8PBvqYuGTM
        etm9Butzj0LXdsrtl2RBXOLMMjlEj62ez1Y2HmXVusciJKAjIp4egy9yfa54JEX0iy1CEpOIhctXx
        PPKrMR3nRspqJQ36Y5RB/UH3399bpkgTwsdou7p3yHMFJCnU7Z+uLzdmq7LOasgsdUX/A4SXjXYCM
        y7T5eD1GhdPuP044lsz8xjl+TfcFyoYAtxZlH9LNErDHwcUpWVsCUjgazqs8Rn+TOzSuQUPS+JCjw
        bSCuKz9w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwQPS-00GfMT-KM
        for linux-fsdevel@vger.kernel.org; Thu, 24 Jun 2021 14:32:59 +0000
Date:   Thu, 24 Jun 2021 15:32:50 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Subject: Re: page split failures in truncate_inode_pages_range
Message-ID: <YNSXkuGDE4h1vicx@casper.infradead.org>
References: <YNOCpu3ooDo39Z4F@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNOCpu3ooDo39Z4F@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 23, 2021 at 07:51:18PM +0100, Matthew Wilcox wrote:
> But truncate_inode_pages_range() is also called by, for example,
> truncate().  In that case, nobody calls filemap_write_and_wait_range(),
> so we can't discard the page because it might still be dirty.
> Is that an acceptable way to choose behaviour -- if the split fails,
> discard the page if it's clean and keep it if it's dirty?  I'll
> put a great big comment on it, because it's not entirely obvious.

It seems to be working ...

        if (!folio_multi(folio))
                return true;
//      if (split_huge_page(&folio->page) == 0)
//              return true;
        if (folio_dirty(folio))
                return false;
        truncate_inode_folio(mapping, folio);
        return true;

No additional xfstests failures from commenting out those two lines.
