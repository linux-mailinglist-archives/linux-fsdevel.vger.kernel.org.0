Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6381C4CACA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2019 11:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730494AbfFTJZy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jun 2019 05:25:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:46702 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725875AbfFTJZx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jun 2019 05:25:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 771EBAD76;
        Thu, 20 Jun 2019 09:25:52 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 13B0E1E434D; Thu, 20 Jun 2019 11:25:52 +0200 (CEST)
Date:   Thu, 20 Jun 2019 11:25:52 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ross Zwisler <zwisler@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Ross Zwisler <zwisler@google.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Fletcher Woodruff <fletcherw@google.com>,
        Justin TerAvest <teravest@google.com>
Subject: Re: [PATCH 1/3] mm: add filemap_fdatawait_range_keep_errors()
Message-ID: <20190620092552.GK13630@quack2.suse.cz>
References: <20190619172156.105508-1-zwisler@google.com>
 <20190619172156.105508-2-zwisler@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619172156.105508-2-zwisler@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 19-06-19 11:21:54, Ross Zwisler wrote:
> In the spirit of filemap_fdatawait_range() and
> filemap_fdatawait_keep_errors(), introduce
> filemap_fdatawait_range_keep_errors() which both takes a range upon
> which to wait and does not clear errors from the address space.
> 
> Signed-off-by: Ross Zwisler <zwisler@google.com>

The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/fs.h |  2 ++
>  mm/filemap.c       | 22 ++++++++++++++++++++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index f7fdfe93e25d3..79fec8a8413f4 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2712,6 +2712,8 @@ extern int filemap_flush(struct address_space *);
>  extern int filemap_fdatawait_keep_errors(struct address_space *mapping);
>  extern int filemap_fdatawait_range(struct address_space *, loff_t lstart,
>  				   loff_t lend);
> +extern int filemap_fdatawait_range_keep_errors(struct address_space *mapping,
> +		loff_t start_byte, loff_t end_byte);
>  
>  static inline int filemap_fdatawait(struct address_space *mapping)
>  {
> diff --git a/mm/filemap.c b/mm/filemap.c
> index df2006ba0cfa5..e87252ca0835a 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -553,6 +553,28 @@ int filemap_fdatawait_range(struct address_space *mapping, loff_t start_byte,
>  }
>  EXPORT_SYMBOL(filemap_fdatawait_range);
>  
> +/**
> + * filemap_fdatawait_range_keep_errors - wait for writeback to complete
> + * @mapping:		address space structure to wait for
> + * @start_byte:		offset in bytes where the range starts
> + * @end_byte:		offset in bytes where the range ends (inclusive)
> + *
> + * Walk the list of under-writeback pages of the given address space in the
> + * given range and wait for all of them.  Unlike filemap_fdatawait_range(),
> + * this function does not clear error status of the address space.
> + *
> + * Use this function if callers don't handle errors themselves.  Expected
> + * call sites are system-wide / filesystem-wide data flushers: e.g. sync(2),
> + * fsfreeze(8)
> + */
> +int filemap_fdatawait_range_keep_errors(struct address_space *mapping,
> +		loff_t start_byte, loff_t end_byte)
> +{
> +	__filemap_fdatawait_range(mapping, start_byte, end_byte);
> +	return filemap_check_and_keep_errors(mapping);
> +}
> +EXPORT_SYMBOL(filemap_fdatawait_range_keep_errors);
> +
>  /**
>   * file_fdatawait_range - wait for writeback to complete
>   * @file:		file pointing to address space structure to wait for
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
