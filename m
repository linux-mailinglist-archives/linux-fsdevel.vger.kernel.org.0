Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55D972B0787
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Nov 2020 15:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgKLOZN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Nov 2020 09:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727899AbgKLOZN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Nov 2020 09:25:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293ECC0613D1;
        Thu, 12 Nov 2020 06:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VcMks6Wi61G32KKQBazDbueQCM5KDLnMj38ZyrJ3Vq0=; b=mPUVPqKezBH0sm5pocs2w/1taz
        1ANQLNTV1zNlQkSEv938A+v7xjQOunJjD1pGMFnh7w/+ScT+Ix3LEDiM5MUJceoJzqES+ffGT8wj6
        dQu+3ofTRhraKJVXmaD8e/oBh1DDesC7q32VTl6/E2p6LmDo9oSB4dxdLWMf4gMDmEnv3ogJDZCut
        v8DqIKqfq7cOI2wJSPZF/jdJnJ88eJLlGy8t5DTv3rgBoniWVtkeMZtFa6V1vT47elTgjMPEIe5+A
        UsBQYiXLh4DjNcAt+0LrbQVV5DWOcK98obakGagJHOy2rXkvfSAiH2s0x51cTpLS6mxEpIWzgAapF
        ZfH4f6UA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdDXB-0006a5-28; Thu, 12 Nov 2020 14:25:09 +0000
Date:   Thu, 12 Nov 2020 14:25:08 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v3 03/12] mm/filemap: Add helper for finding pages
Message-ID: <20201112142508.GA17076@casper.infradead.org>
References: <20201026041408.25230-1-willy@infradead.org>
 <20201026041408.25230-4-willy@infradead.org>
 <20201027185642.GA15201@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027185642.GA15201@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 27, 2020 at 06:56:42PM +0000, Christoph Hellwig wrote:
> > +static inline struct page *xas_find_get_entry(struct xa_state *xas,
> > +		pgoff_t max, xa_mark_t mark)
> 
> I'd expect the xas_ prefix for function from xarray.h.  Maybe this
> wants a better name?

The obvious name for this is find_get_entry().  But that already exists.
Although it turns out it has only two users and one of them doesn't
actually want to use it, so I'm going to rename find_get_entry() to
mapping_get_entry() and then this can become find_get_entry().
