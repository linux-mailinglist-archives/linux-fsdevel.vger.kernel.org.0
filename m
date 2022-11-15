Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96ED9629117
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Nov 2022 05:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbiKOEJ0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 23:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiKOEJY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 23:09:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5E31A82F;
        Mon, 14 Nov 2022 20:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=j/xUVrD8mPcSbyQHk615wZHvvK1z2hXuDfFCa4PiwtI=; b=cqcPHDV+eY3ifO9g3vqqcV+Bnh
        zsVmJpaFiflf5AYEOG3Gk8yCOvxY2VdVW1IHUEvxNgWPziM1+s7iQWCyjRwtqWOztJWjco+wIE8+/
        JAszRx1WSMGrgfhPxUKltG0mJzXigO2CzTqvQCN0Q3HVnio9l5kV7sxhHrOccZCnn8Cy7fh3vQHHk
        qM7aIAWE419vYSVxB5x5f2zCN2lWsovAQiBqh9msxwhjWhlT12x0nsBLDANysPmO7exwN52iTGj2e
        ijqiE0P7vjJQpO6DIyXSI0xgg+e0DxJ/Z5xGIsfiwcPbNKl3PxKsNMEMxE+mpSFr4xxXC7ElQ+PUq
        RJbOqsQw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ounFy-00G84y-Gg; Tue, 15 Nov 2022 04:09:06 +0000
Date:   Tue, 15 Nov 2022 04:09:06 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     dwysocha@redhat.com, Rohith Surabattula <rohiths.msft@gmail.com>,
        Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Ilya Dryomov <idryomov@gmail.com>, linux-cachefs@redhat.com,
        linux-cifs@vger.kernel.org, linux-afs@lists.infradead.org,
        v9fs-developer@lists.sourceforge.net, ceph-devel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] mm, netfs, fscache: Stop read optimisation when
 folio removed from pagecache
Message-ID: <Y3MQ4l1AJOgniprT@casper.infradead.org>
References: <166844174069.1124521.10890506360974169994.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166844174069.1124521.10890506360974169994.stgit@warthog.procyon.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 14, 2022 at 04:02:20PM +0000, David Howells wrote:
> +++ b/mm/filemap.c
> @@ -3941,6 +3941,10 @@ bool filemap_release_folio(struct folio *folio, gfp_t gfp)
>  	struct address_space * const mapping = folio->mapping;
>  
>  	BUG_ON(!folio_test_locked(folio));
> +	if ((!mapping || !mapping_release_always(mapping))
> +	    && !folio_test_private(folio) &&
> +	    !folio_test_private_2(folio))
> +		return true;

Why do you need to test 'mapping' here?  Also this is the most
inconsistent style ...

	if ((!mapping || !mapping_release_always(mapping)) &&
	    !folio_test_private(folio) && !folio_test_private_2(folio))

works fine, but if you insist on splitting over three lines, then:

	if ((!mapping || !mapping_release_always(mapping)) &&
	    !folio_test_private(folio) && 
	    !folio_test_private_2(folio))

> @@ -276,7 +275,7 @@ static long mapping_evict_folio(struct address_space *mapping,
>  	if (folio_ref_count(folio) >
>  			folio_nr_pages(folio) + folio_has_private(folio) + 1)

I think this line is incorrect, right?  You don't increment the folio
refcount just because the folio has private2 set, do you?

>  		return 0;
> -	if (folio_has_private(folio) && !filemap_release_folio(folio, 0))
> +	if (!filemap_release_folio(folio, 0))
>  		return 0;
>  
>  	return remove_mapping(mapping, folio);

Can we get rid of folio_has_private() / page_has_private() now?
