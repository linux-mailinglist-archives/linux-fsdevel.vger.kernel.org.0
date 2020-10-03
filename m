Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA4E2820DD
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Oct 2020 05:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725782AbgJCD7i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Oct 2020 23:59:38 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:38273 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725648AbgJCD7i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Oct 2020 23:59:38 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0933xT2L010362
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Oct 2020 23:59:29 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id E9A6542003C; Fri,  2 Oct 2020 23:59:28 -0400 (EDT)
Date:   Fri, 2 Oct 2020 23:59:28 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, jack@suse.cz,
        Dan Williams <dan.j.williams@intel.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 1/3] ext4: Refactor ext4_overwrite_io() to take
 ext4_map_blocks as argument
Message-ID: <20201003035928.GY23474@mit.edu>
References: <cover.1598094830.git.riteshh@linux.ibm.com>
 <057a08972f818c035621a9fd3ff870bedcdf5e83.1598094830.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <057a08972f818c035621a9fd3ff870bedcdf5e83.1598094830.git.riteshh@linux.ibm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 22, 2020 at 05:04:35PM +0530, Ritesh Harjani wrote:
> Refactor ext4_overwrite_io() to take struct ext4_map_blocks
> as it's function argument with m_lblk and m_len filled
> from caller
> 
> There should be no functionality change in this patch.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
>  fs/ext4/file.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 2a01e31a032c..84f73ed91af2 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -188,26 +188,22 @@ ext4_extending_io(struct inode *inode, loff_t offset, size_t len)
>  }
>  
>  /* Is IO overwriting allocated and initialized blocks? */
> -static bool ext4_overwrite_io(struct inode *inode, loff_t pos, loff_t len)
> +static bool ext4_overwrite_io(struct inode *inode, struct ext4_map_blocks *map)
>  {
> -	struct ext4_map_blocks map;
>  	unsigned int blkbits = inode->i_blkbits;
> -	int err, blklen;ts
> +	loff_t end = (map->m_lblk + map->m_len) << blkbits;

As Dan Carpenter has pointed out, we need to cast map->m_lblk to
loff_t, since m_lblk is 32 bits, and when this get shifted left by
blkbits, we could end up losing bits.

> -	if (pos + len > i_size_read(inode))
> +	if (end > i_size_read(inode))
>  		return false;

This transformation is not functionally identical.

The problem is that pos is not necessarily a multiple of the file
system blocksize.    From below, 

> +	map.m_lblk = offset >> inode->i_blkbits;
> +	map.m_len = EXT4_MAX_BLOCKS(count, offset, inode->i_blkbits);

So what previously was the starting offset of the overwrite, is now
offset shifted right by blkbits, and then shifted left back by blkbits.

So unless I'm missing something, this looks not quite right?

   	      	      		      	    - Ted
