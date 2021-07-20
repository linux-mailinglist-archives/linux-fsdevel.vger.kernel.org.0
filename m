Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA32C3CF4FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 09:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242726AbhGTGVN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 02:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243185AbhGTGUG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 02:20:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437A4C061574;
        Tue, 20 Jul 2021 00:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ewfvvuAfym/iwGWCipSDLSGypAtNWJ0fgldgA5lp580=; b=ThWqMJB9PW1zFusqK+Hfh5cc1y
        kkTgkvixxPOP5NQiA3+OYc+e14Vl6r7vhU+a2GTSMx8to/OEv1als32UFJa+3t+HM0iD8ZfGp5Sb7
        Oy02JmuqKNMxTiJC+N0r8DDolh2Cw9y6Bm87JptEcJqYjoVLy3hf1NacUfoi9qlBAsQAzGFY0ScPZ
        4MRRSncPYeLT2i0R3dkD6XGkw8DYTIQZUmoHUht8PG8SPClbR4CWbNhqV50qGOv4MiGUxQgLsMDsD
        V26ZEI8oYZzWockMjW2ga2uhi9wy4ekzOEC2ZgpkfLne10qDb9b9EUe4lDjHOqTcRtW8zWQ7T9Ojx
        S1qbAsVw==;
Received: from [2001:4bb8:193:7660:5612:5e3c:ba3d:2b3c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5jjG-007qkb-GK; Tue, 20 Jul 2021 06:59:55 +0000
Date:   Tue, 20 Jul 2021 08:59:45 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH v15 09/17] iomap: Use folio offsets instead of page
 offsets
Message-ID: <YPZ0YYF/7F+HG1o+@infradead.org>
References: <20210719184001.1750630-1-willy@infradead.org>
 <20210719184001.1750630-10-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719184001.1750630-10-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +	size_t poff = offset_in_folio(folio, *pos);
> +	size_t plen = min_t(loff_t, folio_size(folio) - poff, length);

These variables are a little misnamed now.  But I'm not sure what a
better name would be.

> +		size_t off = (page - &folio->page) * PAGE_SIZE +
> +				bvec->bv_offset;

Another use case for the helper I suggested earlier.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
