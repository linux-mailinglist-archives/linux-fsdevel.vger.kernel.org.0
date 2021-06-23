Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D05C3B153D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 10:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbhFWICQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 04:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbhFWICP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 04:02:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA29C061574;
        Wed, 23 Jun 2021 00:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KMXVCqZ54Yxoe8fux+wICaoLLPpO0k0UUumj828rXPg=; b=SB9LAhJPa+YmbC+MVoju6lAnq4
        EHw/aaGCDFZqwNd0m/MS2oBu6bYz2ycQ/pMYHn/IL2zXe4pJBL2SETILoAjb0iVu9Zue4MCp+ryhp
        t2rhWZkMjbObtMnwcnCmY/NBO1Y1iImPWzZutHOHet8mTNUmvWcFuR29M4Dx97yLQdzNAolYxuk7S
        T1ckVoPyivYwJEMwx/cPUFba/EePTSVXNIl1Q7h2oxSoWR3CHc/UObhrrnQHCALHxbGW5xSTKukAs
        APMFZm9prZER7OcDGKTWOlszETSy7Di/YFN/ihuIf9/lhdA62xm15VmS8jhfDa5LmK6ciFOpg/2/m
        h71SMpag==;
Received: from [2001:4bb8:188:3e21:6594:49:139:2b3f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvxmk-00FBQW-OW; Wed, 23 Jun 2021 07:59:09 +0000
Date:   Wed, 23 Jun 2021 09:58:52 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/46] mm: Add kmap_local_folio()
Message-ID: <YNLpvO4baPikgvc5@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622121551.3398730-4-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 22, 2021 at 01:15:08PM +0100, Matthew Wilcox (Oracle) wrote:
> This allows us to map a portion of a folio.  Callers can only expect
> to access up to the next page boundary.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

This looks sensible to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>

While we're at it:  flushing incoherent mappings for use with kmap
has been a complete mess.  I've been trying to fix this with
kunmap_local_dirty, but that could use another review, as well as a
folio version probably give that one prime use case of folios is to have
them mapped into userspace.
