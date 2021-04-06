Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D746F3556F4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 16:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345306AbhDFOsc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 10:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345303AbhDFOs2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 10:48:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C4BC06174A;
        Tue,  6 Apr 2021 07:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LcatN0eXO4hy1rj6fn0i4l5iiWPD2BQjKbVyK62ja+g=; b=cI4R966jLOPd7fq/ZEWnxY7Phh
        qg99KaZnT2dZNnGQr35gIlhGYBPWqbRj3GKbtD6OhcC0+7hBdPgIH3dn1jVz664538BIxs0VrKHno
        6r1wQ8pJBC6fes4ZUZtuAqBM5zGT5TAZCDZbkYAYIaKbG7Aut7Lan9OIjTF2aPmgctb9WT/MgV5PP
        IuydLk+WlIMFYlZvhp2vi3Z8w3csYGHkB8GEuywXGOmcMoZd3k3SMbDn+zDi34R8JwdCBCXucFckr
        oCVlYP4XVsEMmxCzHsiwUH5hB2paLhr6jHj+LPRB/+wG4pi5jJrfdQ5XZND6l4kv523bj1507BxUi
        byMbmo5g==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lTmz2-00Cxf8-V9; Tue, 06 Apr 2021 14:47:20 +0000
Date:   Tue, 6 Apr 2021 15:47:12 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org
Subject: Re: [PATCH v6 01/27] mm: Introduce struct folio
Message-ID: <20210406144712.GA3087660@infradead.org>
References: <20210331184728.1188084-1-willy@infradead.org>
 <20210331184728.1188084-2-willy@infradead.org>
 <20210406122918.h5dsnbjhmwpfasf4@box.shutemov.name>
 <20210406124807.GO2531743@casper.infradead.org>
 <20210406143150.GA3082513@infradead.org>
 <20210406144022.GR2531743@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406144022.GR2531743@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 06, 2021 at 03:40:22PM +0100, Matthew Wilcox wrote:
> On Tue, Apr 06, 2021 at 03:31:50PM +0100, Christoph Hellwig wrote:
> > > > As Christoph, I'm not a fan of this :/
> > > 
> > > What would you prefer?
> > 
> > Looking at your full folio series on git.infradead.org, there are a
> > total of 12 references to non-page members of struct folio, assuming
> > my crude grep that expects a folio to be named folio did not miss any.
> 
> Hmm ... I count more in the filesystems:

I only counted the ones that you actually did convert.

This add about 80 more.  IMHO still not worth doing the union.  I'd
rather sort this out properl if/when the structures get properly split.
