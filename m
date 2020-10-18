Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 034E72917F9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Oct 2020 17:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgJRPEh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Oct 2020 11:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgJRPEh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Oct 2020 11:04:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76281C061755;
        Sun, 18 Oct 2020 08:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ozbku8hiYzbGmZSU0ChozvnpkppdAlQ/lMjncce8v0c=; b=VuBzcCMZNbPmDpy/vkqNJnwwRX
        TV0xKZsCRQ9xR4EXJZ/TymNsOL2/Hf11lIagLCFCbzNcP3n38I7f78miT0FlbmlVNmm02QUej6Aa0
        FT77od1x5uvMXLzwP0zLajft9yAYgTF2F5kIxNNeuwMbxZa32XWKd98ZFF6gBF/h9FEFt4aq9QMai
        8z3a3RswKzwEmZK8wINWbFsm+HkKKjUomG2/ZckPr/OoV1JicMGnazRadI78Ipjcv0pIH9cxWyd/C
        InwiiHPhlL6feNPUGPNg1VK+3hTBsx6SGXtyoIOTVMEbeb41zyjcwGnxVlxRwb3B2erwc8TqRk5Q6
        DYNZTP8w==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kUAEd-0005g6-72; Sun, 18 Oct 2020 15:04:35 +0000
Date:   Sun, 18 Oct 2020 16:04:35 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 12/18] ext4: Return error from ext4_readpage
Message-ID: <20201018150435.GL20115@casper.infradead.org>
References: <20201016160443.18685-1-willy@infradead.org>
 <20201016160443.18685-13-willy@infradead.org>
 <20201018142557.GH181507@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201018142557.GH181507@mit.edu>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Oct 18, 2020 at 10:25:57AM -0400, Theodore Y. Ts'o wrote:
> On Fri, Oct 16, 2020 at 05:04:37PM +0100, Matthew Wilcox (Oracle) wrote:
> > The error returned from ext4_map_blocks() was being discarded, leading
> > to the generic -EIO being returned to userspace.  Now ext4 can return
> > more precise errors.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> This change is independent of the synchronous readpage changes,
> correct?  Or am I missing something?

It's a step along the way.  If you want to queue it up independently of
the other changes, I see no problem with that.  The requirement to make
a synchronous ->readpage killable is making the conversion quite thorny
and I'm not sure I'm going to get it done this merge window.
