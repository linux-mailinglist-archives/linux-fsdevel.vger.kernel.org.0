Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 484A21B7EB4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Apr 2020 21:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbgDXTRl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Apr 2020 15:17:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:59544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727022AbgDXTRl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Apr 2020 15:17:41 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBA7A20857;
        Fri, 24 Apr 2020 19:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587755861;
        bh=VlyxgCrOLgi7dFsPEF6HpMuYuVTTibVbUYAsTqnMBZQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q16C0/hczHcQoc0YoGcJ6bs6EebZRpbQ8HK4F7h4D4AZNQLn/OWJyPdhQJs6i2/fc
         Eb06SirpvCybURyZWFZ79HsVhUmBdECxZZ6xr2A/tB500s2LPx2Vswg0mzfDN1CNe3
         Mhb8LVTWkPmhkEN+hWJVEnqWB5leCOJ4jGD0S9Ls=
Date:   Fri, 24 Apr 2020 12:17:39 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jan Kara <jack@suse.com>, tytso@mit.edu,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/2] fibmap: Warn and return an error in case of block >
 INT_MAX
Message-ID: <20200424191739.GA217280@gmail.com>
References: <cover.1587670914.git.riteshh@linux.ibm.com>
 <e34d1ac05d29aeeb982713a807345a0aaafc7fe0.1587670914.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e34d1ac05d29aeeb982713a807345a0aaafc7fe0.1587670914.git.riteshh@linux.ibm.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 24, 2020 at 12:52:17PM +0530, Ritesh Harjani wrote:
> We better warn the fibmap user and not return a truncated and therefore
> an incorrect block map address if the bmap() returned block address
> is greater than INT_MAX (since user supplied integer pointer).
> 
> It's better to WARN all user of ioctl_fibmap() and return a proper error
> code rather than silently letting a FS corruption happen if the user tries
> to fiddle around with the returned block map address.
> 
> We fix this by returning an error code of -ERANGE and returning 0 as the
> block mapping address in case if it is > INT_MAX.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
>  fs/ioctl.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index f1d93263186c..3489f3a12c1d 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -71,6 +71,11 @@ static int ioctl_fibmap(struct file *filp, int __user *p)
>  	block = ur_block;
>  	error = bmap(inode, &block);
>  
> +	if (block > INT_MAX) {
> +		error = -ERANGE;
> +		WARN(1, "would truncate fibmap result\n");
> +	}
> +

WARN() is only for kernel bugs.  This case would be a userspace bug, not a
kernel bug, right?  If so, it should use pr_warn(), not WARN().

- Eric
