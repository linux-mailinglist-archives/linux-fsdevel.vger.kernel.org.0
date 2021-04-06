Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF507355713
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 16:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240240AbhDFO4U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 10:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239544AbhDFO4T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 10:56:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA01BC06174A;
        Tue,  6 Apr 2021 07:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=utRNYwnpm4FcBjJdhPy0mCfMjTjs+CQ5M9mPuIzGgp8=; b=B4sNd7sg32rPyOsIgv2PbVlcbN
        7B2vtCRS2jWMF8YCT+TtOfptbT6vEn1bW7PoE1bej4VpqIMjJ3pIdZJPEgmxSADGJnPM5EHmY8XDu
        WxXL3Zmryrp3/J1FbmZ9V0oI0sW16vJz/vTO0q4E4pe58/O2+ppfW0NZUCUBX8fVrtkeArPRr6rbh
        Qkc0VfYUGABjpsksTr3+MSSlix59ar1rB3i+DDCf6+vlJiBycap5g1k2yuLgybWa1J7YOhWkOCVH/
        9mL/XljMzMfdFySfO9lRTeLKvl3JoabCNYs9TCoQyiNzOT224PlpqWDMljOLGbzyyiG4JaqBTt86M
        wbMHdHqQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lTn6l-00CyKp-9l; Tue, 06 Apr 2021 14:55:30 +0000
Date:   Tue, 6 Apr 2021 15:55:11 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org
Subject: Re: [PATCH v6 01/27] mm: Introduce struct folio
Message-ID: <20210406145511.GS2531743@casper.infradead.org>
References: <20210331184728.1188084-1-willy@infradead.org>
 <20210331184728.1188084-2-willy@infradead.org>
 <20210406122918.h5dsnbjhmwpfasf4@box.shutemov.name>
 <20210406124807.GO2531743@casper.infradead.org>
 <20210406143150.GA3082513@infradead.org>
 <20210406144022.GR2531743@casper.infradead.org>
 <20210406144712.GA3087660@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406144712.GA3087660@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 06, 2021 at 03:47:12PM +0100, Christoph Hellwig wrote:
> On Tue, Apr 06, 2021 at 03:40:22PM +0100, Matthew Wilcox wrote:
> > On Tue, Apr 06, 2021 at 03:31:50PM +0100, Christoph Hellwig wrote:
> > > > > As Christoph, I'm not a fan of this :/
> > > > 
> > > > What would you prefer?
> > > 
> > > Looking at your full folio series on git.infradead.org, there are a
> > > total of 12 references to non-page members of struct folio, assuming
> > > my crude grep that expects a folio to be named folio did not miss any.
> > 
> > Hmm ... I count more in the filesystems:
> 
> I only counted the ones that you actually did convert.
> 
> This add about 80 more.  IMHO still not worth doing the union.  I'd
> rather sort this out properl if/when the structures get properly split.

Assuming we're getting rid of them all though, we have to include:

$ git grep 'page->mapping' fs |wc -l
358
$ git grep 'page->index' fs |wc -l
355

