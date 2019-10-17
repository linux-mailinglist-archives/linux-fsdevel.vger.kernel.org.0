Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99DEDDAC38
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2019 14:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394157AbfJQM3X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Oct 2019 08:29:23 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57849 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728190AbfJQM3X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Oct 2019 08:29:23 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9HCTBPg028552
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Oct 2019 08:29:12 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 94880420458; Thu, 17 Oct 2019 08:29:11 -0400 (EDT)
Date:   Thu, 17 Oct 2019 08:29:11 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: Re: [PATCH v2] iomap: iomap that extends beyond EOF should be marked
 dirty
Message-ID: <20191017122911.GC25548@mit.edu>
References: <20191016051101.12620-1-david@fromorbit.com>
 <20191016060604.GH16973@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016060604.GH16973@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 16, 2019 at 05:06:04PM +1100, Dave Chinner wrote:
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 516faa280ced..e9dc52537e5b 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3523,9 +3523,16 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  			return ret;
>  	}
>  
> +	/*
> +	 * Writes that span EOF might trigger an IO size update on completion,
> +	 * so consider them to be dirty for the purposes of O_DSYNC even if
> +	 * there is no other metadata changes being made or are pending here.
> +	 */
>  	iomap->flags = 0;
> -	if (ext4_inode_datasync_dirty(inode))
> +	if (ext4_inode_datasync_dirty(inode) ||
> +	    offset + length > i_size_read(inode))
>  		iomap->flags |= IOMAP_F_DIRTY;
> +
>  	iomap->bdev = inode->i_sb->s_bdev;
>  	iomap->dax_dev = sbi->s_daxdev;
>  	iomap->offset = (u64)first_block << blkbits;

Ext4 is not currently using iomap for any kind of writing right now,
so perhaps this should land via Matthew's patchset?

					- Ted
