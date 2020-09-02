Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 144B925B044
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 17:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbgIBPyg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 11:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgIBPy3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:54:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6342CC061244;
        Wed,  2 Sep 2020 08:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zMA6zInZMPfkpW5sAnWFlHiBAJv1wx5ytIbHdHXg1sM=; b=bRuJLPF8C4Snr+zFhJCljdfY/w
        LOwNHY/IurlzCI+frzWr/I2YwTtyvqO1i96uiMOKh0es2J/QKpe/VShj7LMjEG5bc6XWid+C/uifD
        knh6Hugg+3TQHjn4bih9rzHjKbAAQrpfrbGY8F6lDFAAMZNepVCXOdkttoA9j1y57zIk5Lt7dn7/z
        NMC0YSGesWGFzxDnigx1NJ7vIhEAZOqKITORYB9PfimxUgTCWj+FVdmUUhimA0dwwSG2ADCJ7ANX2
        U3/heI4KMqDhkltlOaFXldOjLcK7OyFgVdfXJXQzLRYyh+5jWsRw/Sqz+fdvVf4Ytpttr6/8r95b4
        U3/z+XNw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDV5e-0004UT-5Y; Wed, 02 Sep 2020 15:54:26 +0000
Date:   Wed, 2 Sep 2020 16:54:26 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/6] mm: Push readahead_control down into
 force_page_cache_readahead() [ver #2]
Message-ID: <20200902155426.GY14765@casper.infradead.org>
References: <159906145700.663183.3678164182141075453.stgit@warthog.procyon.org.uk>
 <159906147806.663183.767620073654469472.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159906147806.663183.767620073654469472.stgit@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 02, 2020 at 04:44:38PM +0100, David Howells wrote:
> +++ b/mm/fadvise.c
> @@ -104,7 +104,10 @@ int generic_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
>  		if (!nrpages)
>  			nrpages = ~0UL;
>  
> -		force_page_cache_readahead(mapping, file, start_index, nrpages);
> +		{
> +			DEFINE_READAHEAD(rac, file, mapping, start_index);
> +			force_page_cache_readahead(&rac, nrpages);
> +		}
>  		break;

This is kind of awkward.  How about this:

static void force_page_cache_readahead(struct address_space *mapping,
		struct file *file, pgoff_t index, unsigned long nr_to_read)
{
	DEFINE_READAHEAD(rac, file, mapping, index);
	force_page_cache_ra(&rac, nr_to_read);
}

in mm/internal.h for now (and it can migrate if it needs to be somewhere else)
