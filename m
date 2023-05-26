Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBB8712216
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 10:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242646AbjEZIUi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 04:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242672AbjEZIUe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 04:20:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED131BF;
        Fri, 26 May 2023 01:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/kSO5Pkxt0E1wD1vZlEErFGpQ+uRM9cO+R3QIlyHQFY=; b=crkjvMq2tLgxbnjWR9kR7dwfpE
        GtXCYDoFhrWEDM+sHwPIbkB2KTnY2DDbHu0ZpcqcJ0kUqsGYKZh77RZNRVgZg2LpB8YesgJ4mwpZN
        tNMNGy4/OD6aJkZMnzH0hDuaJyl2np80bw2T6pW7o8ZNt72BxXxZfozkmUYWvOp0pRQ9ezxAKuBm+
        8EzfBCiqXA02MMDeTrRhrW0matlCtUjSs4BRv3DBvFifVMFpgI/2GSrH99OgnykuF2kSdKPMKrvk1
        +GMR7XGaugmsaLQJgwcRAunM1XZ1kQs3YNCQpBbCL6Ut03QRJcCA8qMpeQ6PKAqAtPK1XFLI3yCdg
        oITZ/JQA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q2SgM-001aIt-1k;
        Fri, 26 May 2023 08:20:18 +0000
Date:   Fri, 26 May 2023 01:20:18 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH v2 2/3] mm: Provide a function to get an additional
 pin on a page
Message-ID: <ZHBrwrRiY4/WTuYe@infradead.org>
References: <20230525223953.225496-1-dhowells@redhat.com>
 <20230525223953.225496-3-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525223953.225496-3-dhowells@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 25, 2023 at 11:39:52PM +0100, David Howells wrote:
> +/**
> + * page_get_additional_pin - Try to get an additional pin on a pinned page
> + * @page: The page to be pinned
> + *
> + * Get an additional pin on a page we already have a pin on.  Makes no change
> + * if the page is the zero_page.
> + */
> +void page_get_additional_pin(struct page *page)

page_get_additional_pin seems like an odd name, mixing the get and
pin terminologies.  What about repin_page?  Or move to a folio interface
from the start can call it folio_repin?

