Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B47F3B5D61
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jun 2021 13:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbhF1LxJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Jun 2021 07:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbhF1LxH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Jun 2021 07:53:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679B3C061574;
        Mon, 28 Jun 2021 04:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GDSq0NtU1BVOXfQ/dS8BZrVt+kCI2fOBmY8YWTpCw/Q=; b=hArg8QhORkUpq8rvl4GS8UcGMq
        w2nry9nqQ4dTFrkSER3m/Bvhe8rpJt2vNG3JC7/Ot3rDAHFiCrd+85ubk3hLZexRDUEB5Pw33wo+a
        TU0WHxxqQTlDy0Mrs9SQAgIAzQ4Q80aQeOeBUDqG2UpbANzBr9e11Ogszrhr/w69i4y1dGN2QdmR9
        I2zbeb90l7jmRkwoPbRr7A2fThQv5UMl96a0ifilFKVP+cpRHKVTPTL3JyyVYsGNml5SFlQBLkTfb
        NAKxjO6pSaZpbH7MZq6cOkoLYxNEo2d4JpYkY5ZhD1RCLLNFAL0t0eDRXPTEWDWWSUqiMcFSuSp5k
        kezd82UQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxpll-002vLV-Tr; Mon, 28 Jun 2021 11:49:53 +0000
Date:   Mon, 28 Jun 2021 12:49:41 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, dm-devel@redhat.com,
        darrick.wong@oracle.com, dan.j.williams@intel.com,
        david@fromorbit.com, hch@lst.de, agk@redhat.com,
        snitzer@redhat.com, rgoldwyn@suse.de
Subject: Re: [PATCH v5 5/9] mm: Introduce mf_dax_kill_procs() for fsdax case
Message-ID: <YNm3VeeWuI0m4Vcx@casper.infradead.org>
References: <20210628000218.387833-1-ruansy.fnst@fujitsu.com>
 <20210628000218.387833-6-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628000218.387833-6-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 28, 2021 at 08:02:14AM +0800, Shiyang Ruan wrote:
> +/*
> + * dax_load_pfn - Load pfn of the DAX entry corresponding to a page
> + * @mapping:	The file whose entry we want to load
> + * @index:	offset where the DAX entry located in
> + *
> + * Return:	pfn number of the DAX entry
> + */

This is an externally visible function; why not add the second '*' and
make this kernel-doc?

> +unsigned long dax_load_pfn(struct address_space *mapping, unsigned long index)
> +{
> +	XA_STATE(xas, &mapping->i_pages, index);
> +	void *entry;
> +	unsigned long pfn;
> +
> +	xas_lock_irq(&xas);
> +	entry = xas_load(&xas);
> +	pfn = dax_to_pfn(entry);
> +	xas_unlock_irq(&xas);

Why do you need the i_pages lock to do this?  is the rcu_read_lock()
insufficient?  For that matter, why use the xas functions?  Why not
simply:

	void *entry = xa_load(&mapping->i_pages, index);
	return dax_to_pfn(entry);

Looking at it more though, how do you know this is a PFN entry?
It could be locked, for example.  Or the zero page, or empty.

But I think this is unnecessary; why not just pass the PFN into
mf_dax_kill_procs?

