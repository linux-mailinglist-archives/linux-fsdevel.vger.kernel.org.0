Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61FA72CC321
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 18:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387515AbgLBRLd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 12:11:33 -0500
Received: from sandeen.net ([63.231.237.45]:56874 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728380AbgLBRLc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 12:11:32 -0500
Received: from liberator.sandeen.net (liberator.sandeen.net [10.0.0.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id 1EAB1146296;
        Wed,  2 Dec 2020 11:10:34 -0600 (CST)
To:     ira.weiny@intel.com, fstests@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Eric Sandeen <sandeen@redhat.com>,
        David Howells <dhowells@redhat.com>
References: <20201202160701.1458658-1-ira.weiny@intel.com>
From:   Eric Sandeen <sandeen@sandeen.net>
Subject: Re: [RFC PATCH] common/rc: Fix _check_s_dax() for kernel 5.10
Message-ID: <b131a2a6-f02f-9a91-4de1-01a77b76577a@sandeen.net>
Date:   Wed, 2 Dec 2020 11:10:50 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201202160701.1458658-1-ira.weiny@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/2/20 10:07 AM, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> There is a conflict with the user visible statx bits 'mount root' and
> 'dax'.  The kernel is shifting the dax bit.[1]
> 
> Adjust _check_s_dax() to use the new bit.
> 
> [1] https://lore.kernel.org/lkml/3e28d2c7-fbe5-298a-13ba-dcd8fd504666@redhat.com/
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> 
> I'm not seeing an easy way to check for kernel version.  It seems like that is
> the right thing to do.  So do I need to do that by hand or is that something
> xfstests does not worry about?

xfstests gets used on distro kernels too, so relying on kernel version isn't
really something we can use to make determinations like this, unfortunately.

Probably the best we can do is hope that the change makes it to stable and
distro kernels quickly, and the old flag fades into obscurity.

Maybe worth a comment in the test mentioning the SNAFU, though, for anyone
investigating it when it fails on older kernels?

> Ira
> 
> ---
>  common/rc | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index b5a504e0dcb4..3d45e233954f 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3222,9 +3222,9 @@ _check_s_dax()
>  
>  	local attributes=$($XFS_IO_PROG -c 'statx -r' $target | awk '/stat.attributes / { print $3 }')
>  	if [ $exp_s_dax -eq 0 ]; then
> -		(( attributes & 0x2000 )) && echo "$target has unexpected S_DAX flag"
> +		(( attributes & 0x00200000 )) && echo "$target has unexpected S_DAX flag"
>  	else
> -		(( attributes & 0x2000 )) || echo "$target doesn't have expected S_DAX flag"
> +		(( attributes & 0x00200000 )) || echo "$target doesn't have expected S_DAX flag"

I suppose you could add a test for 0x2000 in this failure case, and echo "Is your kernel missing
commit xxxxxx?" as another hint.

-Eric

>  	fi
>  }
>  
> 
