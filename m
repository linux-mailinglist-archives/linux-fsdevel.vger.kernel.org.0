Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25539690C39
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Feb 2023 15:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjBIOyT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Feb 2023 09:54:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjBIOyS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Feb 2023 09:54:18 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20DC65BE;
        Thu,  9 Feb 2023 06:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ES4udDTOA1uOWwrwxbciiHy4JfTk88Aqo60ttQ9GIH4=; b=YQ9o0KaulzV77sBueXsLADh811
        Iixr4ow0bYwfaVtI2mlyNlsW7L+zLjlL67ZUQw+xOqX7eAkQLXgToj8/3A5Jpcq2BoW1JQSTxPouI
        sXCaxvYau281l78kFL8KJILrB67lwaDAsHu7Xcgq+SQGuJ+qESXYcHyIygkMnKC0cyj1mY5H/SRaS
        nfto/ChofAGFkVRr5hAUnKl+0EWjSSa4Rarqocwq0yZ44LuePkkRoE1gluY4D9mf6tKrPiijxCosS
        +whvGmrXTx2dN2QMJNT5I6LP+JBIn9JERpn0uZSQVvZRJc3Gn1bjEoeqLVZR8Ev9IvLwxejkF9Lsh
        OaCWj5rw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pQ8J7-002HHU-Nk; Thu, 09 Feb 2023 14:53:53 +0000
Date:   Thu, 9 Feb 2023 14:53:53 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
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
Subject: Re: [PATCH v13 01/12] splice: Fix O_DIRECT file read splice to avoid
 reversion of ITER_PIPE
Message-ID: <Y+UJAdnllBw+uxK+@casper.infradead.org>
References: <20230209102954.528942-1-dhowells@redhat.com>
 <20230209102954.528942-2-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209102954.528942-2-dhowells@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 09, 2023 at 10:29:43AM +0000, David Howells wrote:
> +	npages = alloc_pages_bulk_list(GFP_USER, npages, &pages);

Please don't use alloc_pages_bulk_list().  If nobody uses it, it can go
away again soon.  Does alloc_pages_bulk_array() work for you?  It's
faster.

> +	/* Free any pages that didn't get touched at all. */
> +	for (; reclaim >= PAGE_SIZE; reclaim -= PAGE_SIZE)
> +		__free_page(bv[--npages].bv_page);

If you have that array, you can then use release_pages() to free
them, which will be faster.

