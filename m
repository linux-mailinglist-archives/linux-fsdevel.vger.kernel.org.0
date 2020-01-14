Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25D4013B4C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 22:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbgANVvD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 16:51:03 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52545 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727102AbgANVvD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 16:51:03 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-108.corp.google.com [104.133.0.108] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 00ELoN8O028997
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jan 2020 16:50:24 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 5833A4207DF; Tue, 14 Jan 2020 16:50:23 -0500 (EST)
Date:   Tue, 14 Jan 2020 16:50:23 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 08/12] ext4: hold i_rwsem until AIO completes
Message-ID: <20200114215023.GH140865@mit.edu>
References: <20200114161225.309792-1-hch@lst.de>
 <20200114161225.309792-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114161225.309792-9-hch@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 14, 2020 at 05:12:21PM +0100, Christoph Hellwig wrote:
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 0e8708b77da6..b6aa2d249b30 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4777,9 +4777,6 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>  	if (mode & FALLOC_FL_KEEP_SIZE)
>  		flags |= EXT4_GET_BLOCKS_KEEP_SIZE;
>  
> -	/* Wait all existing dio workers, newcomers will block on i_mutex */
> -	inode_dio_wait(inode);
> -
>  	/* Preallocate the range including the unaligned edges */
>  	if (partial_begin || partial_end) {
>  		ret = ext4_alloc_file_blocks(file,

I note that you've dropped the inode_dio_wait() in ext4's ZERO_RANGE,
COLLAPSE_RANGE, INSERT_RANGE, etc.  We had added these to avoid
problems when various fallocate operations which modify the inode's
logical->physical block mapping racing with direct I/O (both reads or
writes).

I don't see a replacement protection in this patch series.  How does
are file systems supported to protect against such races?

    	 	 	      	      	      - Ted
