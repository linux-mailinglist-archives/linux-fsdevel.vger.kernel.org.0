Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 569A815D0F4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2020 05:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbgBNEVi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 23:21:38 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39632 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728195AbgBNEVi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 23:21:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pJ62j82nIU2Zy2GDXfwdfrwos2PK4U7hpjBMCZD+BHU=; b=ek5FlmUJYVH7TpMGN0UDhdbdlP
        ZpmOzXocMxVA9d+jNFuPudLwDNy8swGrQKmqAV1aNIqgz+vUnuTGmNlYmgpVvtLBxVCCQf/xRgUQe
        aYNfvPrXmq2c9txws9vk9GMvkDWjdJajzfqJTNG4wpo2D6zNpxIMcEYsw/Uzmu6+fgNlhK+Z6xcqv
        U2oZdCKEAQQi7TpP6smp3l+MpsP/IBWp0Zr5Q7SQ0ag+jo6r6bu7CUU385j6YfQ+3UbG2m+R8CiIP
        hMY9ekNVlTY1SfacIa6TX8hjMg1KzbNePDpc9q0x1IrQoqCtQgquJiQia27l1b496aVFYOc5RO091
        699nobpA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j2STx-0008Ig-7x; Fri, 14 Feb 2020 04:21:37 +0000
Date:   Thu, 13 Feb 2020 20:21:37 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v5 01/13] mm: Fix the return type of
 __do_page_cache_readahead
Message-ID: <20200214042137.GX7778@bombadil.infradead.org>
References: <20200211010348.6872-1-willy@infradead.org>
 <20200211010348.6872-2-willy@infradead.org>
 <e0f459af-bb5d-58b9-78be-5adf687477c0@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0f459af-bb5d-58b9-78be-5adf687477c0@nvidia.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 13, 2020 at 07:19:53PM -0800, John Hubbard wrote:
> On 2/10/20 5:03 PM, Matthew Wilcox wrote:
> > @@ -161,7 +161,7 @@ unsigned int __do_page_cache_readahead(struct address_space *mapping,
> >  	unsigned long end_index;	/* The last page we want to read */
> >  	LIST_HEAD(page_pool);
> >  	int page_idx;
> 
> 
> What about page_idx, too? It should also have the same data type as nr_pages, as long as
> we're trying to be consistent on this point.
> 
> Just want to ensure we're ready to handle those 2^33+ page readaheads... :)

Nah, this is just a type used internally to the function.  Getting the
API right for the callers is the important part.
