Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFEC0173B88
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2020 16:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgB1Pgw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Feb 2020 10:36:52 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48414 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbgB1Pgw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Feb 2020 10:36:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0JSMZzOTsRNiRlOclvpQv2KkO6ENBMomHaAkZFbWKPg=; b=AZa0zXdNIVEbsaMQ1Mz093E9Dt
        dO3gLe+InhjPj1oSx6rQyE9cWgwGY2DLziXiELY7V97fnLCB1jj/Y7QqIM4cIgLcTy7TQqITJIIbz
        MxhRJ3iEs39R3DYAaluDhwJE73UaBjDbpAVpnlwsEumW94jBnNcOeUQObHxuGrSN0wpMSkjZVG3pZ
        DJYyaXrWTdCxt2877cr0IMAXv/jwImPfaQ/auWAGpyZStWEnSgrjxx9rCoudH4zEndcC20L6vK+S/
        4gOEWzSlA5uwhpvuSFzKaXFkKfO/yGQkiAYvPWuc0GUMumA0586dqfk0wgd0KA9aZme/NHck3NBZf
        bWnaPXow==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j7hh4-0003GR-W1; Fri, 28 Feb 2020 15:36:50 +0000
Date:   Fri, 28 Feb 2020 07:36:50 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, jack@suse.cz, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, hch@infradead.org, cmaiolino@redhat.com,
        david@fromorbit.com
Subject: Re: [PATCHv5 6/6] Documentation: Correct the description of
 FIEMAP_EXTENT_LAST
Message-ID: <20200228153650.GG29971@bombadil.infradead.org>
References: <cover.1582880246.git.riteshh@linux.ibm.com>
 <5a00e8d4283d6849e0b8f408c8365b31fbc1d153.1582880246.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a00e8d4283d6849e0b8f408c8365b31fbc1d153.1582880246.git.riteshh@linux.ibm.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 28, 2020 at 02:56:59PM +0530, Ritesh Harjani wrote:
> Currently FIEMAP_EXTENT_LAST is not working consistently across
> different filesystem's fiemap implementations. So add more information
> about how else this flag could set in other implementation.
> 
> Also in general, user should not completely rely on this flag as
> such since it could return false value for e.g.
> when there is a delalloc extent which might get converted during
> writeback, immediately after the fiemap calls return.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
>  Documentation/filesystems/fiemap.txt | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/filesystems/fiemap.txt b/Documentation/filesystems/fiemap.txt
> index f6d9c99103a4..fedfa9b9dde5 100644
> --- a/Documentation/filesystems/fiemap.txt
> +++ b/Documentation/filesystems/fiemap.txt
> @@ -71,8 +71,7 @@ allocated is less than would be required to map the requested range,
>  the maximum number of extents that can be mapped in the fm_extent[]
>  array will be returned and fm_mapped_extents will be equal to
>  fm_extent_count. In that case, the last extent in the array will not
> -complete the requested range and will not have the FIEMAP_EXTENT_LAST
> -flag set (see the next section on extent flags).
> +complete the requested range.

This sentence still seems like it should be true.  If the filesystem knows
there are more extents to come, it will definitely not set the LAST flag.

> @@ -96,7 +95,7 @@ block size of the file system.  With the exception of extents flagged as
>  FIEMAP_EXTENT_MERGED, adjacent extents will not be merged.
>  
>  The fe_flags field contains flags which describe the extent returned.
> -A special flag, FIEMAP_EXTENT_LAST is always set on the last extent in
> +A special flag, FIEMAP_EXTENT_LAST *may be* set on the last extent in
>  the file so that the process making fiemap calls can determine when no
>  more extents are available, without having to call the ioctl again.

I'm not sure I'd highlight 'may be' here.

> @@ -115,8 +114,9 @@ data. Note that the opposite is not true - it would be valid for
>  FIEMAP_EXTENT_NOT_ALIGNED to appear alone.
>  
>  * FIEMAP_EXTENT_LAST
> -This is the last extent in the file. A mapping attempt past this
> -extent will return nothing.
> +This is generally the last extent in the file. A mapping attempt past this
> +extent may return nothing. In some implementations this flag is also set on
> +the last dataset queried by the user (via fiemap->fm_length).

The word 'dataset' is used nowhere else in this document.  How about

"Some filesystems set this flag to indicate this extent is the last one in
the range queried by the user"
