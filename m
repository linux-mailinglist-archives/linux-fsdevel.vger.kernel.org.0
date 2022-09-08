Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A8C5B2403
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Sep 2022 18:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbiIHQz5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 12:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbiIHQza (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 12:55:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394DB476CC
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Sep 2022 09:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Wbmln1kNR8hccItKJCnaBOvzDTVXLhiF2eeXL7RfOdI=; b=kNBPUJoYroA5CfTIFh1rNg8JFg
        zvLWUK9xW6DknydoZv0ZcuDLCxx6OVKDkzFzsJ3O31nnfOApNaKIKoniPycWmIj7V9R68Lrck5ocI
        z02G3Kbb+maqNEAj/Drn9u6GGvvG8nuoUZlEMnPvOSVGk+Pt2w3u7tOLfNmqQzWRTSn1qkELxrDbB
        HR7hM7o6IgwIClt7nXDgK9wqY8ZcOuD857XMNUxEFbOpDy0KLaTdq520qith2gdKh4KyURGg+PlVj
        63j0OML/QTh4q7ZWc3etjWlvfzVweV3yLhLrwIaSnQQjtZ0J/GjguY2kw8ZCtCGWvB+W4qHfcryOx
        KMyRAYYg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oWKmb-00CVbD-Tc; Thu, 08 Sep 2022 16:53:41 +0000
Date:   Thu, 8 Sep 2022 17:53:41 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu, linux-mm@kvack.org,
        akpm@linux-foundation.org, David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC PATCH] fs/hugetlb: Fix UBSAN warning reported on hugetlb
Message-ID: <YxoeFUW5HFP/3/s1@casper.infradead.org>
References: <20220908072659.259324-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908072659.259324-1-aneesh.kumar@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 08, 2022 at 12:56:59PM +0530, Aneesh Kumar K.V wrote:
> +++ b/fs/dax.c
> @@ -1304,7 +1304,7 @@ EXPORT_SYMBOL_GPL(dax_zero_range);
>  int dax_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
>  		const struct iomap_ops *ops)
>  {
> -	unsigned int blocksize = i_blocksize(inode);
> +	size_t blocksize = i_blocksize(inode);
>  	unsigned int off = pos & (blocksize - 1);

If blocksize is larger than 4GB, then off also needs to be size_t.

> +++ b/fs/iomap/buffered-io.c
> @@ -955,7 +955,7 @@ int
>  iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
>  		const struct iomap_ops *ops)
>  {
> -	unsigned int blocksize = i_blocksize(inode);
> +	size_t blocksize = i_blocksize(inode);
>  	unsigned int off = pos & (blocksize - 1);

Ditto.

(maybe there are others; I didn't check closely)
