Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2555940C4AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 13:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237573AbhIOL57 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 07:57:59 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45714 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232824AbhIOL56 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 07:57:58 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C25912219B;
        Wed, 15 Sep 2021 11:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631706998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ljaWHC1T8Skn0Rf1cGPURwlxvxHk7GU37PQK7AHo5Ak=;
        b=iVg5vqyA8HnewlU0YSSvcXOSiOTRI257ABgLY0+39SFVopH5uL8Kus61aAmyvhnfAnO2f9
        kDJyyAOBJhNHYpLeyvousEo9JTKZFJp6PQtHk8yDj7Ni4c9lHSz7iL2lqJSm6eQ5shG8Y0
        whOq9QkH7iAj1o7t9a7tF+X1Fz+UlGU=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 85764A3B8F;
        Wed, 15 Sep 2021 11:56:38 +0000 (UTC)
Date:   Wed, 15 Sep 2021 13:56:38 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.com>, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] MM: annotate congestion_wait() and
 wait_iff_congested() as ineffective.
Message-ID: <YUHfdtth69qKvk8r@dhcp22.suse.cz>
References: <163157808321.13293.486682642188075090.stgit@noble.brown>
 <163157838437.13293.15392955714346973750.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163157838437.13293.15392955714346973750.stgit@noble.brown>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 14-09-21 10:13:04, Neil Brown wrote:
> Only 4 subsystems call set_bdi_congested() or clear_bdi_congested():
>  block/pktcdvd, fs/ceph fs/fuse fs/nfs
> 
> It may make sense to use congestion_wait() or wait_iff_congested()
> within these subsystems, but they have no value outside of these.
> 
> Add documentation comments to these functions to discourage further use.

This is an unfortunate state. The MM layer still relies on the API.
While adding a documentation to clarify the current status can stop more
usage I am wondering what is a real alternative. My experience tells me
that a lack of real alternative will lead to new creative ways of doing
things instead.
 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  include/linux/backing-dev.h |    7 +++++++
>  mm/backing-dev.c            |    9 +++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
> index ac7f231b8825..cc9513840351 100644
> --- a/include/linux/backing-dev.h
> +++ b/include/linux/backing-dev.h
> @@ -153,6 +153,13 @@ static inline int wb_congested(struct bdi_writeback *wb, int cong_bits)
>  	return wb->congested & cong_bits;
>  }
>  
> +/* NOTE congestion_wait() and wait_iff_congested() are
> + * largely useless except as documentation.
> + * congestion_wait() will (almost) always wait for the given timeout.
> + * wait_iff_congested() will (almost) never wait, but will call
> + * cond_resched().
> + * Were possible an alternative waiting strategy should be found.
> + */
>  long congestion_wait(int sync, long timeout);
>  long wait_iff_congested(int sync, long timeout);
>  
> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index 4a9d4e27d0d9..53472ab38796 100644
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -1023,6 +1023,11 @@ EXPORT_SYMBOL(set_bdi_congested);
>   * Waits for up to @timeout jiffies for a backing_dev (any backing_dev) to exit
>   * write congestion.  If no backing_devs are congested then just wait for the
>   * next write to be completed.
> + *
> + * NOTE: in the current implementation, hardly any backing_devs are ever
> + * marked as congested, and write-completion is rarely reported (see calls
> + * to clear_bdi_congested).  So this should not be assumed to ever wake before
> + * the timeout.
>   */
>  long congestion_wait(int sync, long timeout)
>  {
> @@ -1054,6 +1059,10 @@ EXPORT_SYMBOL(congestion_wait);
>   * The return value is 0 if the sleep is for the full timeout. Otherwise,
>   * it is the number of jiffies that were still remaining when the function
>   * returned. return_value == timeout implies the function did not sleep.
> + *
> + * NOTE: in the current implementation, hardly any backing_devs are ever
> + * marked as congested, and write-completion is rarely reported (see calls
> + * to clear_bdi_congested).  So this should not be assumed to sleep at all.
>   */
>  long wait_iff_congested(int sync, long timeout)
>  {
> 

-- 
Michal Hocko
SUSE Labs
