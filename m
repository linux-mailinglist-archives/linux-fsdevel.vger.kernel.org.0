Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7DB3563B8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 08:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244591AbhDGGJe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 02:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhDGGJd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 02:09:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03399C06174A;
        Tue,  6 Apr 2021 23:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NRtbf3X0CiIsO8I6hjkjztgDDSQh3gQr0xj404D/krM=; b=LqsJeHvCYvCB8AVRRneLDLYHjJ
        d5E2O0+2IvqUtoSFQRV3iB7L201oW1WRT2it1nHkuoe+IlcWHoo1CItCkOifbOawtT+TB5il9vbS4
        LmBoLlfMPO0v7G45TokEAWH8vP0I1cFYAS9KgxCxSVRNVeUSCwmRVAuntIV/vBOpNabsEKr/oATMR
        XNBiOUZL8EwYiZG11Xey025y0Zt61X8Dz4EjvXFBpy/Jh2aUB3Z5LX3TIXA8L0KCULY06V6HN4i3g
        mVV/Quzh42XfuClet/dvLbUUGXmtTgAAiAt4Qn5CMQYc+8ozERkyDoG9KAhU0K5KS20a9/1YOR/2l
        Yy9CGqaw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lU1N6-00DzNF-Be; Wed, 07 Apr 2021 06:09:08 +0000
Date:   Wed, 7 Apr 2021 07:09:00 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org
Subject: Re: [PATCH v6 01/27] mm: Introduce struct folio
Message-ID: <20210407060900.GA3333828@infradead.org>
References: <20210331184728.1188084-1-willy@infradead.org>
 <20210331184728.1188084-2-willy@infradead.org>
 <20210406122918.h5dsnbjhmwpfasf4@box.shutemov.name>
 <20210406124807.GO2531743@casper.infradead.org>
 <20210406143150.GA3082513@infradead.org>
 <20210406144022.GR2531743@casper.infradead.org>
 <20210406144712.GA3087660@infradead.org>
 <20210406145511.GS2531743@casper.infradead.org>
 <20210406150550.GA3094215@infradead.org>
 <20210406162530.GT2531743@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406162530.GT2531743@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 06, 2021 at 05:25:30PM +0100, Matthew Wilcox wrote:
> About a third of ->index can be folio_offset(), based on a crude:
> 
> $ git grep 'page->index.*PAGE_' |wc -l
> 101
> 
> and I absolutely don't mind cleaning that up as part of the folio work,
> but that still leaves 200-250 instances that would need to be changed
> later.
> 
> I don't want to change the page->mapping to calls to folio_mapping().
> That's a lot of extra work for a page which the filesystem knows belongs
> to it.  folio_mapping() only needs to be used for pages which might not
> belong to a filesystem.
> 
> page_file_mapping() absolutely needs to go away.  The way to do that
> is to change swap-over-nfs to use direct IO, and then NFS can use
> folio->mapping like all other filesystems.  f2fs is just terminally
> confused and shouldn't be using page_file_mapping at all.  I'll fix
> that as part of the folio work.

Thanks.  So my opinion for now remains preferably just don't add
the union and derefence through the page.  But I'm not going to block
the series for it, as I think it is a huge and badly needed cleanup
required to make further use of larger pages / large chunks of memory
in the pagecache and the file systems.
