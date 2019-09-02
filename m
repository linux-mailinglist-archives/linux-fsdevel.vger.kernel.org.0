Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED27A55FA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 14:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731600AbfIBM0c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 08:26:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45066 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731597AbfIBM0b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 08:26:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=svUkB0dxi2TuM3Fl0ZlJgO11nAP1/canIdeXNo7nLhk=; b=qLGt2hfPD/A3ccp43tsVxEP+x
        jUUBvQ2XSyyvgDYe6TrtxZgmxG16PIqrFXwYQD0yu1nwGhSCRVMgr+BdkXiKj/jUe/2dQ5P7VV3pB
        mpwJArbHQTIKn0n527nkd8xUQJNtgNtVG8et41zGsCgOkMzEOlCzz45lNssyF4O0wqmBgl6Ukn6n/
        8ofbDkQMFNYqoFQnvcgy+ixWOpyh3PXymSyceVE8mrA4rAByp/dH+mwABAy8SkQ5g83bFmoNvqLB1
        XOC0h+5IQadmsREIEoQJIxKs+Dac3mR4wbOu6xrUwlc8scnfiePGNF1jWbmmkDViTqxZwhaFQrhQG
        w8IvWePTA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i4lPf-00042m-Hk; Mon, 02 Sep 2019 12:26:27 +0000
Date:   Mon, 2 Sep 2019 05:26:27 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Gao Xiang <hsiangkao@aol.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: Re: [PATCH 16/21] erofs: kill magic underscores
Message-ID: <20190902122627.GN15931@infradead.org>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190901055130.30572-1-hsiangkao@aol.com>
 <20190901055130.30572-17-hsiangkao@aol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190901055130.30572-17-hsiangkao@aol.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>  
> -	vi->datamode = __inode_data_mapping(advise);
> +	vi->datamode = erofs_inode_data_mapping(advise);
>  
>  	if (vi->datamode >= EROFS_INODE_LAYOUT_MAX) {

While you are at it can we aim for some naming consistency here?  The
inode member is called is called datamode, the helper is called
inode_data_mapping, and the enum uses layout?  To me data_layout seems
most descriptive, datamode is probably ok, but mapping seems very
misleading given that we've already overloaded that terms for multiple
other uses.

And while we are at naming choices - maybe i_format might be
a better name for the i_advise field in the on-disk inode?

> +	if (erofs_inode_version(advise) == EROFS_INODE_LAYOUT_V2) {

I still need to wade through the old thread - but didn't you say this
wasn't really a new vs old version but a compat vs full inode?  Maybe
the names aren't that suitable either?

>  		struct erofs_inode_v2 *v2 = data;
>  
>  		vi->inode_isize = sizeof(struct erofs_inode_v2);
> @@ -58,7 +58,7 @@ static int read_inode(struct inode *inode, void *data)
>  		/* total blocks for compressed files */
>  		if (erofs_inode_is_data_compressed(vi->datamode))
>  			nblks = le32_to_cpu(v2->i_u.compressed_blocks);
> -	} else if (__inode_version(advise) == EROFS_INODE_LAYOUT_V1) {
> +	} else if (erofs_inode_version(advise) == EROFS_INODE_LAYOUT_V1) {

Also a lot of code would use a switch statements to switch for different
matches on the same value instead of chained if/else if/else if
statements.

> +#define erofs_bitrange(x, bit, bits) (((x) >> (bit)) & ((1 << (bits)) - 1))

> +#define erofs_inode_version(advise)	\
> +	erofs_bitrange(advise, EROFS_I_VERSION_BIT, EROFS_I_VERSION_BITS)
>  
> +#define erofs_inode_data_mapping(advise)	\
> +	erofs_bitrange(advise, EROFS_I_DATA_MAPPING_BIT, \
> +		       EROFS_I_DATA_MAPPING_BITS)

All these should probably be inline functions.
