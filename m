Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 050F6F8582
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 01:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfKLAnW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 19:43:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:53244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726877AbfKLAnW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 19:43:22 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D337121872;
        Tue, 12 Nov 2019 00:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573519401;
        bh=2ydOdcJmPK7SfwcXHI6Om5OCHngakPJ/DYZhOTWW10o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SOzp8l2jF+hnRTMM8q4NciR40xpr2wA8IEZXzXLtzty1uJCCAHC48frwRoMrmhIgj
         /7KlrVHe8GSSQzkgLciyKV6Wjc2QrBzyUz7KSoNvmSZmxLcVP9FF5gG3lBZZ8iYeIs
         16TeSWpaFSFmQYkdL5nMvM/M08VwG7jCggvpqX5s=
Date:   Mon, 11 Nov 2019 16:43:20 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     ira.weiny@intel.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, Dave Chinner <david@fromorbit.com>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 2/2] fs: Move swap_[de]activate to file_operations
Message-Id: <20191111164320.80f814161469055b14f27045@linux-foundation.org>
In-Reply-To: <20191112003452.4756-3-ira.weiny@intel.com>
References: <20191112003452.4756-1-ira.weiny@intel.com>
        <20191112003452.4756-3-ira.weiny@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 11 Nov 2019 16:34:52 -0800 ira.weiny@intel.com wrote:

> From: Ira Weiny <ira.weiny@intel.com>
> 
> swap_activate() and swap_deactivate() have nothing to do with
> address spaces.  We want to eventually make the address space operations
> dynamic to switch inode flags on the fly.

What does this mean?

>  So to simplify this code as
> well as properly track these operations we move these functions to the
> file_operations vector.
> 
> This has been tested with XFS but not NFS, f2fs, or btrfs.
> 
> Also note f2fs and xfs have simple moves of their functions to
> facilitate compilation.  No functional changes are contained within
> those functions.
>
> ...
>
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -11002,6 +11002,8 @@ static const struct file_operations btrfs_dir_file_operations = {
>  #endif
>  	.release        = btrfs_release_file,
>  	.fsync		= btrfs_sync_file,
> +	.swap_activate	= btrfs_swap_activate,
> +	.swap_deactivate = btrfs_swap_deactivate,
>  };

Shouldn't this be btrfs_file_operations?


