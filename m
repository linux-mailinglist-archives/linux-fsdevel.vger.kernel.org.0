Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0071ABE13
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 18:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393180AbfIFQzL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 12:55:11 -0400
Received: from verein.lst.de ([213.95.11.211]:58822 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392393AbfIFQzL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 12:55:11 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8772A68B05; Fri,  6 Sep 2019 18:55:07 +0200 (CEST)
Date:   Fri, 6 Sep 2019 18:55:07 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        darrick.wong@oracle.com, hch@lst.de, linux-xfs@vger.kernel.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 15/15] xfs: Use the new iomap infrastructure for CoW
Message-ID: <20190906165507.GA12842@lst.de>
References: <20190905150650.21089-1-rgoldwyn@suse.de> <20190905150650.21089-16-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905150650.21089-16-rgoldwyn@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 05, 2019 at 10:06:50AM -0500, Goldwyn Rodrigues wrote:
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 8321733c16c3..13495d8a1ee2 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1006,7 +1006,10 @@ xfs_file_iomap_begin(
>  		 */
>  		if (directio || imap.br_startblock == HOLESTARTBLOCK)
>  			imap = cmap;
> +		else
> +			xfs_bmbt_to_iomap(ip, srcmap, &cmap, false);
>  
> +		iomap->flags |= IOMAP_F_COW;

I don't think this is correct.  We should only set IOMAP_F_COW
when we actually fill out the srcmap.  Which is a very good agument
for Darrick's suggestion to check for a non-emptry srcmap.

Also this is missing the actually interesting part in
xfs_file_iomap_begin_delay.

I ended up spending the better half of the day trying to implement
that and did run into a few bugs in the core iomap changes, mostly
due to a confusion which iomap to use.  So I ended up reworking those
a bit to:

  a) check srcmap->type to see if there is a valid srcmap
  b) set the srcmap pointer to iomap so that it doesn't need to
     be special cased all over
  c) fixed up a few more places to use the srcmap

This now at least survives xfstests -g quick on a 4k xfs file system
for.  Here is my current tree:

http://git.infradead.org/users/hch/xfs.git/shortlog/refs/heads/xfs-cow-iomap
