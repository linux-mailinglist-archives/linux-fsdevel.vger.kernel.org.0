Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877AD741E9F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 05:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjF2DQN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 23:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjF2DQJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 23:16:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D716271B;
        Wed, 28 Jun 2023 20:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Y/a+t3d/wEGpupZ38F99LZOEtohzSmepAE5z3o2T7a8=; b=CTZhf+teSgQpgsLhWsOMru+raT
        rGOlq5+9XWj+3Qybu/cItMXXcGn+dmBh3BYY/u+etzJuhSwhd+AwWOH+qRL4DPv8W/3xM8jy66/fP
        CU2vEJSD/TKotnmx44dMrC/KKnaQ4IULmg/PLdoa5Bpn0lz/+5k+zb054tvw4HgIFHKBzJPcaJj8E
        vpahTFNTvelbDXud2gdmXYPPg0CBFz6N3opF4dZ++04IyAxXRanoP+fZvOc4TL6/VIbw9sOkzlCUc
        BdDTSfRnMtu0JlIh8odHKhw46jDxaAWUXO2p1d1V9464PAwU0zx1LgWGO2coHKwjiR4ns7GpP3Osu
        mhzkRDCQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qEi8a-004YGx-Ui; Thu, 29 Jun 2023 03:16:05 +0000
Date:   Thu, 29 Jun 2023 04:16:04 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Sumitra Sharma <sumitraartsy@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>, Deepak R Varma <drv@mailo.com>
Subject: Re: [PATCH] fs/vboxsf: Replace kmap() with kmap_local_{page, folio}()
Message-ID: <ZJz3dO10o9+xV65F@casper.infradead.org>
References: <20230627135115.GA452832@sumitra.com>
 <ZJxqmEVKoxxftfXM@casper.infradead.org>
 <6924669.18pcnM708K@suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6924669.18pcnM708K@suse>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 29, 2023 at 12:23:54AM +0200, Fabio M. De Francesco wrote:
> > -	buf = kmap(page);
> > +	do {
> 
> Please let me understand why you are calling vboxsf_read() in a loop, a 
> PAGE_SIZE at a time.

Because kmap_local_folio() can only (guarantee to) map one page at a
time.  Also vboxsf_read() is only tested with a single page at a time.

> If I understand the current code it reads a single page at offset zero of a 
> folio and then memset() with zeros from &buf[nread] up to the end of the page. 
> Then it seems that this function currently assume that the folio doesn't need 
> to be read until "offset < folio_size(folio)" becomes false.
> 
> Does it imply that the folio is always one page sized? Doesn't it? I'm surely 
> missing some basics...  

vboxsf does not yet claim to support large folios, so every folio that
it sees will be only a single page in size.  Hopefully at some point
that will change.  Again, somebody would need to test that.  In the
meantime, if someone is going to the trouble of switching over to using
the folio API, let's actually include support for large folios.

> > -	kunmap(page);
> > -	unlock_page(page);
> > +	if (!err) {
> > +		flush_dcache_folio(folio);
> > +		folio_mark_uptodate(folio);
> > +	}
> > +	folio_unlock(folio);
> 
> Shouldn't we call folio_lock() to lock the folio to be able to unlock with 
> folio_unlock()?
>  
> If so, I can't find any neither a folio_lock() or a page_lock() in this 
> filesystem. 
> 
> Again sorry for not understanding, can you please explain it?

Ira gave the minimal explanation, but a slightly fuller explanation is
that the folio is locked while it is being fetched from backing store.
That prevents both a second thread from reading from it while another
thread is bringing it uptodate, and two threads trying to bring it
uptodate at the same time.

Most filesystems have an asynchronous read_folio, so you don't see the
folio_unlock() in the read_folio() function; instead it's in the I/O
completion path.  vboxsf is synchronous.
