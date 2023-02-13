Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFAE2693F81
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Feb 2023 09:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjBMIWw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Feb 2023 03:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjBMIWu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Feb 2023 03:22:50 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E32D51F;
        Mon, 13 Feb 2023 00:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=mQA/TMoqGXtzaC3xl5xqOmLbaTvrl04Kg+nkMyx7H6o=; b=myKwfl24JBnnudqvTZWtxcOoM7
        vSYq9vFkJ6kLpTtn34g7Zd6tKdd+GZxaccqbhIP3MKORXGysgWarLaZqld2FaU2px9GtU7DwAVWRb
        RSSz9Dc/bFMeFNpohNDcmrffxwAA9f0HQp5WRChtNR3cLbjR8Gx2sOn+uzo42IBATYhwi2JGWni+4
        TevkWhFX3zbzw1GvT/L2V2ei8t/Fmd+aUtJtHjpk1Dt4bjReVoKee2JUtMuQzZX5KozrtEngJx76l
        iI6pjlfh6OYrle1Ml0EonQvRBLd2gG9fQc6hpn0b9jk+Cf/bsQtpRQxy7UfLKKBNxyzBivUhch/2F
        S0CT16qQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pRU6N-00DZfL-En; Mon, 13 Feb 2023 08:22:19 +0000
Date:   Mon, 13 Feb 2023 00:22:19 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        syzbot+a440341a59e3b7142895@syzkaller.appspotmail.com,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v14 01/12] splice: Fix O_DIRECT file read splice to avoid
 reversion of ITER_PIPE
Message-ID: <Y+nzO2H8AizX4lAQ@infradead.org>
References: <Y+UJAdnllBw+uxK+@casper.infradead.org>
 <20230209102954.528942-1-dhowells@redhat.com>
 <20230209102954.528942-2-dhowells@redhat.com>
 <909202.1675959337@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <909202.1675959337@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +	if (!bv)
> +		return -ENOMEM;
> +
> +	pages = (void *)(bv + npages);

I think this cast should be to struct page **… not void *.

> +	npages = alloc_pages_bulk_array(GFP_USER, npages, pages);
> +	if (!npages) {
> +		kfree(bv);
> +		return -ENOMEM;
> +	}

> +	reclaim = npages * PAGE_SIZE;
> +	remain = 0;
> +	if (ret > 0) {
> +		reclaim -= ret;
> +		remain = ret;

...

> +	/* Free any pages that didn't get touched at all. */
> +	reclaim /= PAGE_SIZE;

Any reason not to keep reclaim in PAGE_SIZE units to start with?

