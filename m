Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F1C5358DB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 May 2022 07:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235986AbiE0Fn4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 May 2022 01:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbiE0Fny (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 May 2022 01:43:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A7AB0D1C
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 May 2022 22:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EVMWT2Hdj3E5/5rxLxTdp6J40l9tuFSHJ/tM0mvcJHk=; b=xNY7SWS3e9FPDxkkTIrQ4BXpLL
        qFw/Hy8qA3+BBUI2wByadkCJtVK1x0+eaRMHKF6xp6WMLWk02N1kba1gPVNX9Jd7f/4+DQoa1pkBq
        iJ421raX1dhZCRWCyifKD2HG76LifXAEPzwSoh3P49+/YIgtKYtlqHG+pcDxM2rxqsdhI5s3nxk9W
        U6NAkAaTHHhyGlkV6scBE+SXBv66NPWYXXb7I9bCSGfqd/cZ3IYTrGNC1KRDSQljG0Sx2+eTxweOj
        nfTQOD6oc/9phdDCxUtFs1/g7Mb25nY6r6VbnDFdEw4uGKJWbUoAnNnAl1ZbjvHy+BTlXFui9gPyV
        9rVl1I/g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nuSlL-00GhBW-Cm; Fri, 27 May 2022 05:43:51 +0000
Date:   Thu, 26 May 2022 22:43:51 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     jfs-discussion@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [RFC PATCH 7/9] jfs: Read quota through the page cache
Message-ID: <YpBlF2xbfL2yY98n@infradead.org>
References: <20220526192910.357055-1-willy@infradead.org>
 <20220526192910.357055-8-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526192910.357055-8-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>  static ssize_t jfs_quota_read(struct super_block *sb, int type, char *data,
> +			      size_t len, loff_t pos)
>  {
>  	struct inode *inode = sb_dqopt(sb)->files[type];
> +	struct address_space *mapping = inode->i_mapping;
>  	size_t toread;
> +	pgoff_t index;
>  	loff_t i_size = i_size_read(inode);
>  
> +	if (pos > i_size)
>  		return 0;
> +	if (pos + len > i_size)
> +		len = i_size - pos;
>  	toread = len;
> +	index = pos / PAGE_SIZE;
> +
>  	while (toread > 0) {
> +		struct folio *folio = read_mapping_folio(mapping, index, NULL);
> +		size_t tocopy = PAGE_SIZE - offset_in_page(pos);
> +		void *src;
> +
> +		if (IS_ERR(folio))
> +			return PTR_ERR(folio);
> +
> +		src = kmap_local_folio(folio, offset_in_folio(folio, pos));
> +		memcpy(data, src, tocopy);
> +		kunmap_local(src);

It would be great to have a memcpy_from_folio like the existing
memcpy_from_page for this.

> +		folio_put(folio);
>  
>  		toread -= tocopy;
>  		data += tocopy;
> +		pos += tocopy;
> +		index++;
>  	}
>  	return len;

And this whole helper is generic now.  It might be worth to move it
into fs/quota/dquot.c as generic_quota_read.
