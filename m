Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A096267D812
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 23:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbjAZWAB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 17:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbjAZV7u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 16:59:50 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AD273748;
        Thu, 26 Jan 2023 13:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OjhglGBtSbHObWDXAQNTT3eTz1SwBz2eUzou0wVBXL4=; b=ZAhKcJYH33xoZNrKKxREfVuiKH
        FE2ksTaRnzRNGB7IjpkdxrQCJVPWs339OBUOQlTkneAfPxtnhoD14ttrIN7GVO4aDCyQzKuiUJKtl
        ivkcVgBY7xYxb89/MCqUyU0tbGFdeKsxaMqlt/jWodNWlpaq4GQ7faOfpFmYKCJ1c+lnBHVmApfvb
        DMFPueqgxVxAQhHmDrqLaSUp1TnqHiNvn4sde+xASvB5wvg9YuR9lXOX/xzIXsj0yK/ICoaDmlN+A
        CDL6eN9pCiUuU9x1vYn2sHeQ/G8hKMy51an4yw8P65vo0syurSlKlXW/MXAF6xgl5cAZfDBiyGiz3
        dQJAHSCA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pLAHQ-004K6H-2O;
        Thu, 26 Jan 2023 21:59:36 +0000
Date:   Thu, 26 Jan 2023 21:59:36 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v11 2/8] iov_iter: Add a function to extract a page list
 from an iterator
Message-ID: <Y9L3yA+B1rrnrGK8@ZenIV>
References: <20230126141626.2809643-1-dhowells@redhat.com>
 <20230126141626.2809643-3-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126141626.2809643-3-dhowells@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 26, 2023 at 02:16:20PM +0000, David Howells wrote:

> +/**
> + * iov_iter_extract_will_pin - Indicate how pages from the iterator will be retained
> + * @iter: The iterator
> + *
> + * Examine the iterator and indicate by returning true or false as to how, if
> + * at all, pages extracted from the iterator will be retained by the extraction
> + * function.
> + *
> + * %true indicates that the pages will have a pin placed in them that the
> + * caller must unpin.  This is must be done for DMA/async DIO to force fork()
> + * to forcibly copy a page for the child (the parent must retain the original
> + * page).
> + *
> + * %false indicates that no measures are taken and that it's up to the caller
> + * to retain the pages.
> + */
> +static inline bool iov_iter_extract_will_pin(const struct iov_iter *iter)
> +{
> +	return user_backed_iter(iter);
> +}
> +

Wait a sec; why would we want a pin for pages we won't be modifying?
A reference - sure, but...
