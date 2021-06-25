Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 885173B3B32
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jun 2021 05:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbhFYDcZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Jun 2021 23:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbhFYDcY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Jun 2021 23:32:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E81EC061574;
        Thu, 24 Jun 2021 20:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8Vwxl6D+Lu5QRVNKMZe3vjsqCEkLlWvK03dV0gQsJgc=; b=m12G3Jb5Y4Qzg5nzgbooeJEl4s
        MIMbrukKcUeNXFS1nEC68bFJkME+fS3l8VEZHJ+Vc9S/JeKcG8zmZe8+HEL6ueR8EOgYvSRXA3UVK
        j9+WiAJUOPGjDmg02FLwGrriME7+WN0IM9rwHc2W/Wm32aDBbZjTPOtG3bLaxPo+COyomyd2kZTCi
        EZNKP0H/PMSf/9kkGlcnbl9YdujprhtBTRV6C+X0zfMG6rmraM40lZfqqSCaEf6R/w0Ym5SEk290B
        Mm/kWBbyBojr7NkpnzhMmaKABJ2jrRf/qSEmRVQAJYSB6r4z3/3YVK2kccDva4cHt3i/lM+n8+DU6
        H3vKQcrw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwcXL-00HGUW-4U; Fri, 25 Jun 2021 03:29:50 +0000
Date:   Fri, 25 Jun 2021 04:29:47 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 44/46] mm/filemap: Convert mapping_get_entry to return
 a folio
Message-ID: <YNVNq+PgyYzOkNJs@casper.infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-45-willy@infradead.org>
 <YNMb1+0PrD73yCXE@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNMb1+0PrD73yCXE@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 23, 2021 at 01:32:39PM +0200, Christoph Hellwig wrote:
> On Tue, Jun 22, 2021 at 01:15:49PM +0100, Matthew Wilcox (Oracle) wrote:
> > - * Return: The head page or shadow entry, %NULL if nothing is found.
> > + * Return: The folio, swap or shadow entry, %NULL if nothing is found.
> 
> This (old and new) reads a little weird, given that it returns a
> struct folio, even if that happens to be a magic entry.

Yeah.  How about this?

- * Return: The head page or shadow entry, %NULL if nothing is found.
+ * Return: The folio, swap or shadow entry, %NULL if nothing is found.
  */
-static struct page *mapping_get_entry(struct address_space *mapping,
-               pgoff_t index)
+static void *mapping_get_entry(struct address_space *mapping, pgoff_t index)
 {

I still use a struct folio in mapping_get_entry(), but this means that
pagecache_get_page() doesn't change in this patch.
