Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBEFE2A1D92
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Nov 2020 12:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgKALUd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Nov 2020 06:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgKALUd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Nov 2020 06:20:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1D8C0617A6
        for <linux-fsdevel@vger.kernel.org>; Sun,  1 Nov 2020 03:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XP0ktuKFVEjKCr/aKj+0RFycxoJenodAvemu+mBbN+s=; b=XpMCbKkNBAQZfANnvHYW4hKUPw
        X/J3MGVTBbdZqcROukoYfpxTmrR7kuiX5P59xTHonPZvF74HDYypX9hSYOFU4TlSEiqbUc3oOid24
        i98Sh0rpgt8FWSSfDExqzbiH0f2erGcyczwY8qHO3tywOPESRYiaCvOFdcJH7m0cCZuMNjtM9votn
        D3PqVDJCYVARL6WIHFwql1Up4qMLPJEXX4k8eKIWXtW54axHB0roYgd5cxBMnIPekIr1CJiZknhJL
        dju1Uf1XMNQEcjLX5NRVCm4IKNyqQjYWiRRUAwGnwsOed6/6arUBRsr0vkOCW4cA7Lj6K2dIq16t4
        aYPXyzkQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kZBPR-0003vU-Jq; Sun, 01 Nov 2020 11:20:29 +0000
Date:   Sun, 1 Nov 2020 11:20:29 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 10/13] mm: open code readahead in filemap_new_page
Message-ID: <20201101112029.GX27442@casper.infradead.org>
References: <20201031090004.452516-1-hch@lst.de>
 <20201031090004.452516-11-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201031090004.452516-11-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 31, 2020 at 10:00:01AM +0100, Christoph Hellwig wrote:
> Calling filemap_make_page_uptodate right after filemap_readpage in
> filemap_new_page is rather counterintuitive.  The call is in fact
> only needed to issue async readahead, and is guaranteed to return
> just after that because the page is uptodate.  Just open code the
> readahead related parts of filemap_make_page_uptodate instead.

Oh, you got rid of it again ;-)

It's still not possible for this page to have Readahead set on it --
it was only just created, and can't possibly have been created by
an earlier readahead call.

