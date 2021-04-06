Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 105753556B0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 16:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345173AbhDFOdC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 10:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345168AbhDFOdB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 10:33:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A0FC06174A;
        Tue,  6 Apr 2021 07:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=76Y+RpJl3c/zLDkucbQIVrpSXOundieidtG+VMNQ3II=; b=ABwBhwABT0zb+XUznUbXzl3gna
        QrIvghe0Py38QdNyUo3z0fAezD/he5R3W91heecXoXp9dqnCsw/HpTjWxZa3SdD8Qsr2u6fNpEmds
        qBKXlpKJ8MX7k8u8nq5qGQz4hK+U5aEIJWmhbW94Xhgw6G35jTuwQDFXsEzx/H9h1JfAdfbmQN5DT
        wrrbPVJa1ePk1Y2RPw+Rc85lUvYC9IN4VCymFSak0LIT2EdicuJoN9V3wygWfBdMRIbWsyB8rzAgp
        6lklwAQi10w6QH5iyzyafUUUB8w+EEWYdnS185eIXwYq0Lsp3yq+jC7zUnhR0oB6gn1I2rTvwepy7
        F1ZNZNJw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lTmkA-00CwNG-RE; Tue, 06 Apr 2021 14:32:10 +0000
Date:   Tue, 6 Apr 2021 15:31:50 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org
Subject: Re: [PATCH v6 01/27] mm: Introduce struct folio
Message-ID: <20210406143150.GA3082513@infradead.org>
References: <20210331184728.1188084-1-willy@infradead.org>
 <20210331184728.1188084-2-willy@infradead.org>
 <20210406122918.h5dsnbjhmwpfasf4@box.shutemov.name>
 <20210406124807.GO2531743@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406124807.GO2531743@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 06, 2021 at 01:48:07PM +0100, Matthew Wilcox wrote:
> Now, maybe we should put this optimisation into the definition of nth_page?

That would be nice.

> > As Christoph, I'm not a fan of this :/
> 
> What would you prefer?

Looking at your full folio series on git.infradead.org, there are a
total of 12 references to non-page members of struct folio, assuming
my crude grep that expects a folio to be named folio did not miss any.

Except for one that prints folio->flags in cachefiles code, and which
should go away they are all in core MM code in mm/ or include/.  With
enough file system conversions I do see potential uses for ->mapping
and ->index outside of core code, but IMHO we can ignore those for now
and just switch them over if/when we actually change the struct folio
internals to split them from tail pages.

So my opinion is:  leave these fields out for now, and when the problem
that we'd have a lot of reference out of core code arises deal with it
once we know about the scope.  Maybe we add wrappers for the few
members that are reasonable "public", maybe we then do the union
trick you have here because it is the least evil, or maybe we just do
not do anything at all until these fields move over to the folio
entirely.
