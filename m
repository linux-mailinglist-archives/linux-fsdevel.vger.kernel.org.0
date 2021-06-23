Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6A33B1AF7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 15:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhFWNWn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 09:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbhFWNWm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 09:22:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516E1C061574;
        Wed, 23 Jun 2021 06:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PCiuVMRKNuvDVek4f2Qirj3VC8XGRRERUW2AchHc/MQ=; b=hcfWOuBJRoHFvIireuLopMJJIN
        0mFj9pzL9E0v2HJFchjshkcfMrBODvjZXCYMcsfEIV79eOPVhChBwMqrB2gxf7Z6WyJmbW5BfKz7c
        NoeM6xCILm0Ju0EhokXO44NR4XYh58h76EzyxwJRuBEP+Rmgf8YwsWWXuBbNOw3yNyXC4rLjq41Us
        XoVdEBhsvMLjjrEfjI6iNwn8VzOM9NzwBwtQXxeH02gN8Uyv0GDKvUxmxRSrcRJjxCs7trNLRwZOW
        EcTPHIODyXkwpeN4uh2IH6+MVCUjCIlH3bIbdBLRwoa0nrgyjsIDuu8Dn/pGnCNuE/msZEb2paEcf
        zGJM0C3g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lw2n8-00FSzT-B9; Wed, 23 Jun 2021 13:19:48 +0000
Date:   Wed, 23 Jun 2021 14:19:42 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 35/46] mm/filemap: Add folio_mkwrite_check_truncate()
Message-ID: <YNM07q4bIw8Vii58@casper.infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-36-willy@infradead.org>
 <YNMDTgeHh9/Sfd1/@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNMDTgeHh9/Sfd1/@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 23, 2021 at 11:47:58AM +0200, Christoph Hellwig wrote:
> On Tue, Jun 22, 2021 at 01:15:40PM +0100, Matthew Wilcox (Oracle) wrote:
> > This is the folio equivalent of page_mkwrite_check_truncate().
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> Any reason that page_mkwrite_check_truncate isn't turned into a wrapper?

It'd introduce an extra call to page_folio() for no actual benefit
