Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E968153CEF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 03:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbgBFCVq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Feb 2020 21:21:46 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35732 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbgBFCVq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Feb 2020 21:21:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8YTlkpxV+cRqAszdfaLxD3OYxH/DD97FpI+XDrKWML0=; b=Dv4ZgcSfFUoAA0KV8uKAHgP8+9
        YV/5oHyVsKKd084qLwbISjJ0u1C7uC/0+vV29bIsjzop/C5be+vVs0cK/AjRvOAO5fQ8wUuQMA1MX
        NPy77zu+qIctxFO35q5jYgBcn6Rj0Xo5T2vTiXcaZ7HfUV3ifc4j9UIfm8eBDxiYkwWs35zVlenbP
        wQaTMV4DkGFIuQNisuQIxVYC4gIAHA6MsQiQ2bT9qe1oZliazkwNInFI0xolYlfPnKVJCRmJEoJWr
        Tsp2osXnB5tEKnAgitCm/tT1bSxEiv3rBzTuCT9rOD6oFHLzK1QSTPV7MmA4S7RYuyrca98SeYB85
        Tj/I2ILg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1izWnY-000234-83; Thu, 06 Feb 2020 02:21:44 +0000
Date:   Wed, 5 Feb 2020 18:21:44 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 8/8] xarray: Don't clear marks in xas_store()
Message-ID: <20200206022144.GU8731@bombadil.infradead.org>
References: <20200204142514.15826-1-jack@suse.cz>
 <20200204142514.15826-9-jack@suse.cz>
 <8ea2682b-7240-dca3-b123-2df7d0c994ba@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ea2682b-7240-dca3-b123-2df7d0c994ba@nvidia.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 05, 2020 at 02:19:34PM -0800, John Hubbard wrote:
> So if we do this, I think we'd also want something like this (probably with
> better wording, this is just a first draft):
> 
> diff --git a/Documentation/core-api/xarray.rst b/Documentation/core-api/xarray.rst
> index 640934b6f7b4..8adeaa8c012e 100644
> --- a/Documentation/core-api/xarray.rst
> +++ b/Documentation/core-api/xarray.rst
> @@ -66,10 +66,11 @@ pointer at every index.
>  You can then set entries using xa_store() and get entries
>  using xa_load().  xa_store will overwrite any entry with the
>  new entry and return the previous entry stored at that index.  You can
> -use xa_erase() instead of calling xa_store() with a
> +use xa_erase() plus xas_init_marks(), instead of calling xa_store() with a

Woah, woah, woah.  xa_erase() re-initialises the marks.  Nobody's going
to change that.  Don't confuse the porcelain and plumbing APIs.

