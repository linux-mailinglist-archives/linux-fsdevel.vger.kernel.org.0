Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 373C51D5DC0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 May 2020 03:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgEPBtT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 21:49:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:33770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbgEPBtT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 21:49:19 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 605F1207BB;
        Sat, 16 May 2020 01:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589593758;
        bh=rNgC9Av8/awoQKHVkrrrbimQ/X1+g+/VCLMQh1wNG1g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hJNgi+ZomU2YTxsBjCbe2QJTpuDs9IiQb8zA0Gl04r5yBvxKjcsW9KPd4lj/e2JNh
         b/jXMS3Wq0KxGiZmhPHKSkY3E/wlmhwfBypn6MFSdMPjo8XtmPJxI5xiHkuRJRg/CL
         or18Dd5tcT5/fCn/9tqnYE+5LgBud0+YCF90g9qQ=
Date:   Fri, 15 May 2020 18:49:16 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     ira.weiny@intel.com
Cc:     linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/9] fs/ext4: Disallow verity if inode is DAX
Message-ID: <20200516014916.GF1009@sol.localdomain>
References: <20200513054324.2138483-1-ira.weiny@intel.com>
 <20200513054324.2138483-3-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513054324.2138483-3-ira.weiny@intel.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 12, 2020 at 10:43:17PM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Verity and DAX are incompatible.  Changing the DAX mode due to a verity
> flag change is wrong without a corresponding address_space_operations
> update.
> 
> Make the 2 options mutually exclusive by returning an error if DAX was
> set first.
> 
> (Setting DAX is already disabled if Verity is set first.)
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes:
> 	remove WARN_ON_ONCE
> 	Add documentation for DAX/Verity exclusivity
> ---
>  Documentation/filesystems/ext4/verity.rst | 7 +++++++
>  fs/ext4/verity.c                          | 3 +++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/Documentation/filesystems/ext4/verity.rst b/Documentation/filesystems/ext4/verity.rst
> index 3e4c0ee0e068..51ab1aa17e59 100644
> --- a/Documentation/filesystems/ext4/verity.rst
> +++ b/Documentation/filesystems/ext4/verity.rst
> @@ -39,3 +39,10 @@ is encrypted as well as the data itself.
>  
>  Verity files cannot have blocks allocated past the end of the verity
>  metadata.
> +
> +Verity and DAX
> +--------------
> +
> +Verity and DAX are not compatible and attempts to set both of these flags on a
> +file will fail.
> +

If you build the documentation, this shows up as its own subsection
"2.13. Verity and DAX" alongside "2.12. Verity files", which looks odd.
I think you should delete this new subsection header so that this paragraph goes
in the existing "Verity files" subsection.

Also, Documentation/filesystems/fsverity.rst already mentions DAX (similar to
fscrypt.rst).  Is it intentional that you added this to the ext4-specific
documentation instead?

- Eric
