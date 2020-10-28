Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F91D29D47C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Oct 2020 22:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbgJ1VwZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 17:52:25 -0400
Received: from casper.infradead.org ([90.155.50.34]:44300 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728311AbgJ1VwY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:52:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=C0tW2f8j7jb4MFbdm+6sFYCzENYguiyxnLGk7T5Zcss=; b=wF3nI97v/Uz1kPYDyGYYLFO4Lk
        p/9xBY2r3teh5weq0/szrtdJX+7FWu36/I7vl3ml9pz5fqMBMVXxbdpQ4hyaWxic7UfXBbiyEV+9O
        CBUt5F8GDxzp9HMFYQhkGOcBXdZX2SkrNisaMlmNIqZLF+BgtDMknzQzwH/Y4oIpL0CTHfWQo0kUE
        18hBf+BPhYRhO8/llRBAjZGE+ozeYAjoHccvlHNV7H3R7s3/JpZwsa4bp0f2izE8piGj+o9o6lYFs
        O9AcUlzWszqZWCEap50ckrIU5ur034C++3JsIvhIrReyLW0PzUQHksLRnt69nYqCKm9wY2GZneQeJ
        XXbDgfew==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXozP-0005WC-Ql; Wed, 28 Oct 2020 17:11:59 +0000
Date:   Wed, 28 Oct 2020 17:11:59 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org, kernel test robot <lkp@intel.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/11] afs: Fix dirty-region encoding on ppc32 with 64K
 pages
Message-ID: <20201028171159.GB20115@casper.infradead.org>
References: <20201028143442.GA20115@casper.infradead.org>
 <160389418807.300137.8222864749005731859.stgit@warthog.procyon.org.uk>
 <160389426655.300137.17487677797144804730.stgit@warthog.procyon.org.uk>
 <548209.1603904708@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <548209.1603904708@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 28, 2020 at 05:05:08PM +0000, David Howells wrote:
> Matthew Wilcox <willy@infradead.org> wrote:
> 
> > > +{
> > > +	if (PAGE_SIZE - 1 <= __AFS_PAGE_PRIV_MASK)
> > > +		return 1;
> > > +	else
> > > +		return PAGE_SIZE / (__AFS_PAGE_PRIV_MASK + 1);
> > 
> > Could this be DIV_ROUND_UP(PAGE_SIZE, __AFS_PAGE_PRIV_MASK + 1); avoiding
> > a conditional?  I appreciate it's calculated at compile time today, but
> > it'll be dynamic with THP.
> 
> Hmmm - actually, I want a shift size, not a number of bytes as I divide by it
> twice in afs_page_dirty().

__AFS_PAGE_PRIV_MASK is a constant though.  If your compiler can't
optimise a divide-by-a-constant-power-of-two into a shift-by-a-constant (*),
it's time to get yourself a new compiler.

(*) assuming that's faster on the CPU it's targetting.
