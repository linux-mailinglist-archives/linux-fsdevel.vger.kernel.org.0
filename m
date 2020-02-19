Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3745E163B45
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 04:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgBSD3g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 22:29:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:41670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726446AbgBSD3g (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 22:29:36 -0500
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB6A824658;
        Wed, 19 Feb 2020 03:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582082976;
        bh=Be/ShAdVvoVw7PIhz4RQ5k4za6c4aizt0SASf/qexgY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=plo0B7tNDe57VbC/yC0rOzcAei0YUXdc1f4dr2CWVcw7e0qg9AgP+rj6qu8UrLaSF
         gewq1595Ti6GJCQLWG0bqUD0ydY7Gq+C+nxwRKtF05o+5dxf/CzPCrGZ495V+t6U4e
         Fy0nGJuZP4V+WRQbsVvNFY4o4dZo13ulK1XTogiE=
Date:   Tue, 18 Feb 2020 19:29:34 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-mm@kvack.org, ocfs2-devel@oss.oracle.com,
        linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v6 14/19] ext4: Convert from readpages to readahead
Message-ID: <20200219032934.GC1075@sol.localdomain>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-25-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217184613.19668-25-willy@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 17, 2020 at 10:46:05AM -0800, Matthew Wilcox wrote:
> diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
> index c1769afbf799..e14841ade612 100644
> --- a/fs/ext4/readpage.c
> +++ b/fs/ext4/readpage.c
> @@ -7,8 +7,8 @@
>   *
>   * This was originally taken from fs/mpage.c
>   *
> - * The intent is the ext4_mpage_readpages() function here is intended
> - * to replace mpage_readpages() in the general case, not just for
> + * The ext4_mpage_readahead() function here is intended to
> + * replace mpage_readahead() in the general case, not just for
>   * encrypted files.  It has some limitations (see below), where it
>   * will fall back to read_block_full_page(), but these limitations
>   * should only be hit when page_size != block_size.
> @@ -222,8 +222,7 @@ static inline loff_t ext4_readpage_limit(struct inode *inode)
>  }

This says ext4_mpage_readahead(), but it's actually still called
ext4_mpage_readpages().

- Eric
