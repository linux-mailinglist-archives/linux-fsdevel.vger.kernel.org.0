Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5FD3A876C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 19:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbhFORWI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 13:22:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229494AbhFORWH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:22:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C3D30610A3;
        Tue, 15 Jun 2021 17:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623777602;
        bh=xfpYdTiFtO6fupidTDpKVikPPyV2ma0JS7KlyV5pg6o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CIeWhp6tD03WqalHtlwknpiyM2Z5gPTxDisxzhoCPCztpaexvsR+KnJhA/2OzpLp6
         XFtHaQbtxPFVxrwIkBpFUDS8YH6QLJ9kt6Q6/9RjyvZsya9B91S605Vijojg1l21Zl
         XhySo+nF+3l6PUh5f3IbllxwDQeCXUhSixPOa/7E=
Date:   Tue, 15 Jun 2021 19:19:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] iomap: Use __set_page_dirty_nobuffers
Message-ID: <YMjhP+Bk5PY5yqm7@kroah.com>
References: <20210615162342.1669332-1-willy@infradead.org>
 <20210615162342.1669332-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615162342.1669332-4-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 15, 2021 at 05:23:39PM +0100, Matthew Wilcox (Oracle) wrote:
> The only difference between iomap_set_page_dirty() and
> __set_page_dirty_nobuffers() is that the latter includes a debugging
> check that a !Uptodate page has private data.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/gfs2/aops.c         |  2 +-
>  fs/iomap/buffered-io.c | 27 +--------------------------
>  fs/xfs/xfs_aops.c      |  2 +-
>  fs/zonefs/super.c      |  2 +-
>  include/linux/iomap.h  |  1 -
>  5 files changed, 4 insertions(+), 30 deletions(-)
> 
> diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
> index 50dd1771d00c..746b78c3a91d 100644
> --- a/fs/gfs2/aops.c
> +++ b/fs/gfs2/aops.c
> @@ -784,7 +784,7 @@ static const struct address_space_operations gfs2_aops = {
>  	.writepages = gfs2_writepages,
>  	.readpage = gfs2_readpage,
>  	.readahead = gfs2_readahead,
> -	.set_page_dirty = iomap_set_page_dirty,
> +	.set_page_dirty = __set_page_dirty_nobuffers,

Using __ functions in structures in different modules feels odd to me.
Why not just have iomap_set_page_dirty be a #define to this function now
if you want to do this?

Or take the __ off of the function name?

Anyway, logic here is fine, but feels odd.

greg k-h
