Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E28A366156
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Apr 2021 23:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234057AbhDTVEt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Apr 2021 17:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233764AbhDTVEs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Apr 2021 17:04:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11B1C06174A
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Apr 2021 14:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=33cl6Q0zBO2WtxzleEbaqu15B/eG+p6M3SX4MVpiqrk=; b=SasqnyUO0VXDzwPWUIt5rvdpEA
        NxeOD1J70CXru5fNWRTpW5zS94z8jeiYR0tQsfUmDy1xzChACTzzVw3g2HxoNXPdXDRjySo/5ge1l
        ltRsw4IN776o2CZ3zxXETt/9D7rFhLkl7pWo8BClPzHSYNBAGgxmhyNw77H9V4Ev0u3dTy1C6Hseu
        BbrkpXL30b8cKuAjIIoM5Aivwl2vrUS+QG/cpSW62WbpCg72LbaEYQ1DWTfEcYIv0a/ev+D7sFmLh
        Jdhrlpt6cqxtnaavTwaEIh0dboLPTj3nwpFamH3+b+dXwrN73tP5hCUCu3cZoMBCFJ+zbZYATUTIB
        RRVnED1w==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lYxWq-00FeRZ-JH; Tue, 20 Apr 2021 21:03:39 +0000
Date:   Tue, 20 Apr 2021 22:03:28 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] mm/readahead: Handle ractl nr_pages being modified
Message-ID: <20210420210328.GD3596236@casper.infradead.org>
References: <20210420200116.3715790-1-willy@infradead.org>
 <3675c1d23577dded6ca97e0be78c153ce3401e10.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3675c1d23577dded6ca97e0be78c153ce3401e10.camel@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 20, 2021 at 04:12:57PM -0400, Jeff Layton wrote:
> > @@ -210,6 +208,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
> >  			 * not worth getting one just for that.
> >  			 */
> >  			read_pages(ractl, &page_pool, true);
> > +			i = ractl->_index + ractl->_nr_pages - index;

			i = ractl->_index + ractl->_nr_pages - index - 1;

> > @@ -223,6 +222,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
> >  					gfp_mask) < 0) {
> >  			put_page(page);
> >  			read_pages(ractl, &page_pool, true);
> > +			i = ractl->_index + ractl->_nr_pages - index;

			i = ractl->_index + ractl->_nr_pages - index - 1;

> Thanks Willy, but I think this may not be quite right. A kernel with
> this patch failed to boot for me:

Silly off-by-one errors.  xfstests running against xfs is up to generic/278
with the off-by-one fixed.
