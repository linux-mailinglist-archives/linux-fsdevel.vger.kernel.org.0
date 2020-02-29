Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE369174894
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Feb 2020 19:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbgB2SHV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Feb 2020 13:07:21 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38323 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbgB2SHV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Feb 2020 13:07:21 -0500
Received: by mail-wr1-f66.google.com with SMTP id t11so919898wrw.5;
        Sat, 29 Feb 2020 10:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Hm4cXoI43gAgA4nrBIzRUu2EXt/W1xMMI5Bz6Dkvkes=;
        b=DzOsEVcnoPDDcnCrYbqOwyMAfCHTk4hVp350pagLtf0e8yUqiX4bYAB6arg9Ha1HaZ
         fxx5/OuZVKTC/u5SxkwkduKZzr1wfgY9wwL077PralTWgckdDaostS3XFsADegvqHpnX
         TRRbpfQYRfqDGXMyaEzPDTQH0Ru6v8K4OgI0AO2c9gFdbqgI+8ERgWP+pWzIVqgJ1pc0
         +FXw5/YqH3X1ooa1YLP7YmBIeRLTYzIA62LuA/Hr/Pve9pFjwkBoiH8IfyQoxdn+CRnf
         HNnEM/Bj0gjgCOzMNBvJt+qphVXaJpmhQVtIsC7iTSJMbPxk/JSErOlsicQ6nfr0Nug9
         PqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hm4cXoI43gAgA4nrBIzRUu2EXt/W1xMMI5Bz6Dkvkes=;
        b=b0UbeXQ/LDROrFETHbYFeR9fRj6yMyIbkemwZyBO6a0o+9NYwNgHyXplcQC75znC9g
         oJs27yesroha8kx/2y4yufaP5LL83xJ3xd8kq/j+z5gbarb6BZuJWc/bhKsijYAii2+N
         HjOFLwcMCJ1w3YNi/TlluaXtFyJ8RDZrH6F5UAM3hS/vaBqqNkAG4FD3z3O195DUytDG
         tgVnz7T3N1hwxudVAuwqiujK+e3/ekknmFSB9c0OFYebGR/wKyVt4RtF0VrFliIXHkUU
         VTSta7fO9xmP5WvfardgdxhyZpfMmif3ZvD+9juI2gj7qtsZeqAZp4Gf9b2oiA5YJisc
         rbew==
X-Gm-Message-State: APjAAAXqIUYoTFdXaL1gWVAU7stLQjR2VYoX1JU+j1PAIM4Ae0FYUJ9Q
        u/WvVHxMyz9HXvf2Z8pP+6gIOV4a8wM=
X-Google-Smtp-Source: APXvYqwUneac0lxNm13oGXPVtzsZ9kIY4PmsP3KRqDCEIl7C9+O/clOnE6+5Bbu2z+3/hHY7U3cMuA==
X-Received: by 2002:adf:9521:: with SMTP id 30mr11361559wrs.349.1582999639162;
        Sat, 29 Feb 2020 10:07:19 -0800 (PST)
Received: from dumbo (ip4da2e549.direct-adsl.nl. [77.162.229.73])
        by smtp.gmail.com with ESMTPSA id m19sm7272467wmc.34.2020.02.29.10.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Feb 2020 10:07:18 -0800 (PST)
Date:   Sat, 29 Feb 2020 19:07:16 +0100
From:   Domenico Andreoli <domenico.andreoli@linux.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-pm@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, mkleinsoft@gmail.com, hch@lst.de,
        akpm@linux-foundation.org, rjw@rjwysocki.net, len.brown@intel.com,
        pavel@ucw.cz
Subject: Re: [PATCH] hibernate: unlock swap bdev for writing when uswsusp is
 active
Message-ID: <20200229180716.GA31323@dumbo>
References: <20200229170825.GX8045@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200229170825.GX8045@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 29, 2020 at 09:08:25AM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> It turns out that there /is/ one use case for programs being able to
> write to swap devices, and that is the userspace hibernation code.  The
> uswsusp ioctls allow userspace to lease parts of swap devices, so turn
> S_SWAPFILE off when invoking suspend.
> 
> Fixes: 1638045c3677 ("mm: set S_SWAPFILE on blockdev swap devices")
> Reported-by: Domenico Andreoli <domenico.andreoli@linux.com>
> Reported-by: Marian Klein <mkleinsoft@gmail.com>

I also tested it yesterday but was not satisfied, unfortunately I did
not come with my comment in time.

Yes, I confirm that the uswsusp works again but also checked that
swap_relockall() is not triggered at all and therefore after the first
hibernation cycle the S_SWAPFILE bit remains cleared and the whole
swap_relockall() is useless.

I'm not sure this patch should be merged in the current form.

Regards,
Domenico

> Tested-by: Marian Klein <mkleinsoft@gmail.com>
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> ---
>  include/linux/swap.h |    1 +
>  kernel/power/user.c  |   11 ++++++++++-
>  mm/swapfile.c        |   26 ++++++++++++++++++++++++++
>  3 files changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 1e99f7ac1d7e..add93e205850 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -458,6 +458,7 @@ extern void swap_free(swp_entry_t);
>  extern void swapcache_free_entries(swp_entry_t *entries, int n);
>  extern int free_swap_and_cache(swp_entry_t);
>  extern int swap_type_of(dev_t, sector_t, struct block_device **);
> +extern void swap_relockall(void);
>  extern unsigned int count_swap_pages(int, int);
>  extern sector_t map_swap_page(struct page *, struct block_device **);
>  extern sector_t swapdev_block(int, pgoff_t);
> diff --git a/kernel/power/user.c b/kernel/power/user.c
> index 77438954cc2b..b11f7037ce5e 100644
> --- a/kernel/power/user.c
> +++ b/kernel/power/user.c
> @@ -271,6 +271,8 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
>  			break;
>  		}
>  		error = hibernation_restore(data->platform_support);
> +		if (!error)
> +			swap_relockall();
>  		break;
>  
>  	case SNAPSHOT_FREE:
> @@ -372,10 +374,17 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
>  			 */
>  			swdev = new_decode_dev(swap_area.dev);
>  			if (swdev) {
> +				struct block_device *bd;
> +
>  				offset = swap_area.offset;
> -				data->swap = swap_type_of(swdev, offset, NULL);
> +				data->swap = swap_type_of(swdev, offset, &bd);
>  				if (data->swap < 0)
>  					error = -ENODEV;
> +
> +				inode_lock(bd->bd_inode);
> +				bd->bd_inode->i_flags &= ~S_SWAPFILE;
> +				inode_unlock(bd->bd_inode);
> +				bdput(bd);
>  			} else {
>  				data->swap = -1;
>  				error = -EINVAL;
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index b2a2e45c9a36..439bfb7263d3 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1799,6 +1799,32 @@ int swap_type_of(dev_t device, sector_t offset, struct block_device **bdev_p)
>  	return -ENODEV;
>  }
>  
> +/* Re-lock swap devices after resuming from userspace suspend. */
> +void swap_relockall(void)
> +{
> +	int type;
> +
> +	spin_lock(&swap_lock);
> +	for (type = 0; type < nr_swapfiles; type++) {
> +		struct swap_info_struct *sis = swap_info[type];
> +		struct block_device *bdev = bdgrab(sis->bdev);
> +
> +		/*
> +		 * uswsusp only knows how to suspend to block devices, so we
> +		 * can skip swap files.
> +		 */
> +		if (!(sis->flags & SWP_WRITEOK) ||
> +		    !(sis->flags & SWP_BLKDEV))
> +			continue;
> +
> +		inode_lock(bdev->bd_inode);
> +		bdev->bd_inode->i_flags |= S_SWAPFILE;
> +		inode_unlock(bdev->bd_inode);
> +		bdput(bdev);
> +	}
> +	spin_unlock(&swap_lock);
> +}
> +
>  /*
>   * Get the (PAGE_SIZE) block corresponding to given offset on the swapdev
>   * corresponding to given index in swap_info (swap type).

-- 
rsa4096: 3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
ed25519: FFB4 0CC3 7F2E 091D F7DA  356E CC79 2832 ED38 CB05
