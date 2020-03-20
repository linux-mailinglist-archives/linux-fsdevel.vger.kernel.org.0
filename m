Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57A5318D7D1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Mar 2020 19:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbgCTSvh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Mar 2020 14:51:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:45870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727555AbgCTSvg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Mar 2020 14:51:36 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73FEA20775;
        Fri, 20 Mar 2020 18:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584730295;
        bh=wmxvXevR06nb1QmpGEsop/WZiA63VuWIIHhbvnGv3KA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ATEVLUwSRAGOLrwqGIPQHX0PWH4lr45iE5A/NazJJCfEOZHnreOA2VBhpGjQhk/ki
         4+ZKkX5+P81ra2F1GVplnKnGZnFW5hCuQZ+bwoyYxCCre1aOpfzyewy++fV9Qt8rae
         IkgJ+cgr/UTSzDQK5vzJ04cieWphnrdFa7f7cJlw=
Date:   Fri, 20 Mar 2020 11:51:34 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-xfs@vger.kernel.org,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-mm@kvack.org, ocfs2-devel@oss.oracle.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v9 22/25] f2fs: Convert from readpages to readahead
Message-ID: <20200320185134.GI851@sol.localdomain>
References: <20200320142231.2402-1-willy@infradead.org>
 <20200320142231.2402-23-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320142231.2402-23-willy@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 20, 2020 at 07:22:28AM -0700, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Use the new readahead operation in f2fs
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> ---
>  fs/f2fs/data.c              | 47 +++++++++++++++----------------------
>  include/trace/events/f2fs.h |  6 ++---
>  2 files changed, 22 insertions(+), 31 deletions(-)
> 

Reviewed-by: Eric Biggers <ebiggers@google.com>

> @@ -2210,7 +2204,7 @@ static int f2fs_mpage_readpages(struct address_space *mapping,
>  				ret = f2fs_read_multi_pages(&cc, &bio,
>  							max_nr_pages,
>  							&last_block_in_bio,
> -							is_readahead);
> +							rac);

IMO it would be clearer to write 'rac != NULL' here (and below) since the
argument is actually a bool, but this works too.

- Eric
