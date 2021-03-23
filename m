Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4633A34656D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 17:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbhCWQhe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 12:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233374AbhCWQhR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 12:37:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9ECC061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Mar 2021 09:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=b4e5o8kaGWEkrICCpRwkfXkHpFa0fxLldHksskNdA0M=; b=AxiwJgwHE38JpI/zixWsQbIi2b
        nb2vdPojjWnX975VXM+ABGx0ZwlNh797YAaQeXdEbWWEwJ/HiIKDD8PZxdZWtWxBIiX6FNFE2Zwvt
        zxA5j543dJFKsMORZDTb6oUv9oiLN5KF08iOxKI7pEEFath/xZB4IqBl1TeEe6AbjzPNYDYgEjXi7
        G3aBZaODPSr+NUJM09ktAdRmgp2wKzcuaBYqPJ/7J9s8yhNK3rnXAMfNoUmvEpOtofsu2akdiBLIm
        Bz6YWySUMpVCzRmoLVSRSMdCNOQ9ZKf070i/anb4prcplrWptrMqTSSZtL+7eFJCHUMI3psa4KG2A
        PqnN/MGg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOk0d-00AHpR-2j; Tue, 23 Mar 2021 16:36:13 +0000
Date:   Tue, 23 Mar 2021 16:35:59 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: set_page_dirty variants
Message-ID: <20210323163559.GA2450855@infradead.org>
References: <20210322011907.GB1719932@casper.infradead.org>
 <20210323154125.GA2438080@infradead.org>
 <20210323163027.GH1719932@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323163027.GH1719932@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 23, 2021 at 04:30:27PM +0000, Matthew Wilcox wrote:
> On Tue, Mar 23, 2021 at 03:41:25PM +0000, Christoph Hellwig wrote:
> > On Mon, Mar 22, 2021 at 01:19:07AM +0000, Matthew Wilcox wrote:
> > > I'd like to get it down to zero.  After all, the !mapping case in
> > > set_page_dirty() is exactly what we want.  So is there a problem
> > > with doing this?
> > > 
> > > +++ b/mm/page-writeback.c
> > > @@ -2562 +2562 @@ int set_page_dirty(struct page *page)
> > > -       if (likely(mapping)) {
> > > +       if (likely(mapping && mapping_can_writeback(mapping))) {
> > > 
> > > But then I noticed that we have both mapping_can_writeback()
> > > and mapping_use_writeback_tags(), and I'm no longer sure
> > > which one to use.  Also, why don't we mirror the results of
> > > inode_to_bdi(mapping->host)->capabilities & BDI_CAP_WRITEBACK into
> > > a mapping->flags & AS_something bit?
> > 
> > Probably because no one has bothered to submit a patch yet.
> 
> I was hoping for a little more guidance.  Are mapping_can_writeback()
> and mapping_use_writeback_tags() really the same thing?  I mean,
> obviously the swap spaces actually _can_ writeback, but it doesn't
> use the tags to do it.

Have you looked at the commit adding mapping_use_writeback_tags?  It
pretty clearly documents that as of that commit the swap cache does not
use writeback tags and why.
