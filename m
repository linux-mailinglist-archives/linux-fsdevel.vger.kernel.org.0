Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 559783B58F9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jun 2021 08:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbhF1GMH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Jun 2021 02:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbhF1GMG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Jun 2021 02:12:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DC1C061574;
        Sun, 27 Jun 2021 23:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BJQH8ExqyG+PaKnx7zyfiS+jgoJEuon+FRVA2gAuWXM=; b=qHL5isZbk+RSlqlOVauQ1UEPt/
        Qsg78G4uDqlluI+9DaMWUoyWCsxLI0HfvdOtzdlMRwW/EU7G1g4fuguZnC+icIvNYeD7cZz+vsu35
        5oXECD34kNiWhGrPc1DwxS2bVvk006UxAhT1GWq/6JWXh2il4yB+z9Mcx0CAJdrTPnYyVQysK1OYu
        SaLNrbV2FP9q2fRx/ZKlhygIqE9mU/BkuPNbdAEMknkuNFjPqTjCGVwGFqNeSTA29JIwC+tQSimJq
        Kwdiv4vRWnHJY7EKequNdSQ5HI2/+vpU5JUiKVVxWGiYBbQnHz+DlMitqjiGDyDWZYxQ3ekTZQtMR
        RXV0Rifg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxkQV-002dr2-Uq; Mon, 28 Jun 2021 06:07:34 +0000
Date:   Mon, 28 Jun 2021 07:07:23 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 44/46] mm/filemap: Convert mapping_get_entry to return
 a folio
Message-ID: <YNlnGyqZi2o09bVz@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-45-willy@infradead.org>
 <YNMb1+0PrD73yCXE@infradead.org>
 <YNVNq+PgyYzOkNJs@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNVNq+PgyYzOkNJs@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 25, 2021 at 04:29:47AM +0100, Matthew Wilcox wrote:
> > > - * Return: The head page or shadow entry, %NULL if nothing is found.
> > > + * Return: The folio, swap or shadow entry, %NULL if nothing is found.
> > 
> > This (old and new) reads a little weird, given that it returns a
> > struct folio, even if that happens to be a magic entry.
> 
> Yeah.  How about this?
> 
> - * Return: The head page or shadow entry, %NULL if nothing is found.
> + * Return: The folio, swap or shadow entry, %NULL if nothing is found.
>   */
> -static struct page *mapping_get_entry(struct address_space *mapping,
> -               pgoff_t index)
> +static void *mapping_get_entry(struct address_space *mapping, pgoff_t index)
>  {
> 
> I still use a struct folio in mapping_get_entry(), but this means that
> pagecache_get_page() doesn't change in this patch.

Much better, thanks.
