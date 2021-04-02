Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 732AA352AFF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Apr 2021 15:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235366AbhDBN1n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Apr 2021 09:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbhDBN1n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Apr 2021 09:27:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE78EC0613E6;
        Fri,  2 Apr 2021 06:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Quv+d5ruToqASsYHkDYyM+RNKRKLkPKY2MzE/OEcBCc=; b=Hn4p16U0Xxhq5upbBRvlz8n2ox
        zWm3vcPITR6WIgIRjEtrgfbpywR54mfRiOw1cS0cS9diYxrum7asLMiUvNEtR/bUQa9suts9rquNt
        6h5DAKJQR8mxrMOT6YRTTRA2o9i73/i4wO3P43uXwZ/0kXaIRnEjeWSgQwXrfi/N/LUHpJalqporl
        HfQAdmqsnJh/m1SlQtGsDDjmv81jNN5D6vhUhWLtxaZyNq1MxY3XN5tDgMXYqNBQBTO9ljSjUqaFY
        pP5P053z76nhNadrx0wLL6GPQXV/dEzbk9NmQ68ylZ8oFQW2QYwjZRVpLURl9rRZnVeP4iXMTBLn+
        cRrcvYcA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lSJpM-007gLj-Br; Fri, 02 Apr 2021 13:27:14 +0000
Date:   Fri, 2 Apr 2021 14:27:08 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: BUG_ON(!mapping_empty(&inode->i_data))
Message-ID: <20210402132708.GM351017@casper.infradead.org>
References: <alpine.LSU.2.11.2103301654520.2648@eggly.anvils>
 <20210331024913.GS351017@casper.infradead.org>
 <alpine.LSU.2.11.2103311413560.1201@eggly.anvils>
 <20210401170615.GH351017@casper.infradead.org>
 <20210402031305.GK351017@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210402031305.GK351017@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 02, 2021 at 04:13:05AM +0100, Matthew Wilcox wrote:
> +	for (;;) {
> +		xas_load(xas);
> +		if (!xas_is_node(xas))
> +			break;
> +		xas_delete_node(xas);
> +		xas->xa_index -= XA_CHUNK_SIZE;
> +		if (xas->xa_index < index)
> +			break;

That's a bug.  index can be 0, so the condition would never be true.
It should be:

		if (xas->xa_index <= (index | XA_CHUNK_MASK))
			break;
		xas->xa_index -= XA_CHUNK_SIZE;

The test doesn't notice this bug because the tree is otherwise empty,
and the !xas_is_node(xas) condition is hit first.  The next test will
notice this.

