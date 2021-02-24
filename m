Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A76F32428F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Feb 2021 17:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234663AbhBXQx0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Feb 2021 11:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235773AbhBXQwK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Feb 2021 11:52:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBF9C061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Feb 2021 08:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aoyPJLOINcOzWX3hzDOiZBRt38O6h9dI3clPQSbSKR4=; b=cE7NwaD5byiIKUjfWuWYFkMHE0
        W5cSoETaMV4YMaypv48GFoQl9V8BA1KED/CixT3d+mnLjBkJYgODkBbAAjh1/MzKiwUnHKpC04ozN
        eQIC2JfSuiOP3lo293V/Ra9C/1i6ijViIdpOqX15N/83gRVJ9R44/yCdgxMlR83R3PNuVqyV+XaqG
        ONah66BwgxifxBaOlW5OYKNaONVnoFU89l6J77oIQvnoYhUZQ6I+ozB2elhKwbIoLEz4pficEJ70E
        x4HQTGVbSGQuXz/PzIcovJ7jiiBgCFbx8Rv3bZntokWn+XZXowDdAt0TGbVIYYBxYIIx8SiGLrkZn
        iPcnhcZw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lExNG-009dqU-Ng; Wed, 24 Feb 2021 16:51:12 +0000
Date:   Wed, 24 Feb 2021 16:50:54 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH 1/3] mm: provide filemap_range_needs_writeback() helper
Message-ID: <20210224165054.GR2858050@casper.infradead.org>
References: <20210224164455.1096727-1-axboe@kernel.dk>
 <20210224164455.1096727-2-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210224164455.1096727-2-axboe@kernel.dk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 24, 2021 at 09:44:53AM -0700, Jens Axboe wrote:
> +++ b/include/linux/fs.h
> @@ -2633,6 +2633,8 @@ static inline int filemap_fdatawait(struct address_space *mapping)
>  
>  extern bool filemap_range_has_page(struct address_space *, loff_t lstart,
>  				  loff_t lend);
> +extern bool filemap_range_needs_writeback(struct address_space *,
> +					  loff_t lstart, loff_t lend);
>  extern int filemap_write_and_wait_range(struct address_space *mapping,
>  				        loff_t lstart, loff_t lend);
>  extern int __filemap_fdatawrite_range(struct address_space *mapping,

These prototypes should all be in pagemap.h, not fs.h.  I can do
a followup patch if you don't want to do it as part of this set.
Also we're deprecating the use of 'extern' for prototypes.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
