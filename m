Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCA8437F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 17:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733095AbfFMPCP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 11:02:15 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37348 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732516AbfFMO1e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jun 2019 10:27:34 -0400
Received: by mail-qk1-f196.google.com with SMTP id d15so12872255qkl.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2019 07:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Zpqnm/x/AdsYycdl11Nd+V+IfO9WFcP66DZDngrAd9E=;
        b=vIdt/h5+tPMSzsO2WKNiQQDQMPwbBZbBm9OHyAHyx4n4yPEPu33aL/2jtnT9p70MVL
         F+qhjp0HOftKSWyWCPGK+P2vNwSwohfNdHX/LcHmc5kAQu0QsNp7he5b4V312LKw+B43
         y9krIVhmC8HG4q8LZM91gw8AN/Zq2CpBcY8tFJtHMQPB1he2syEi85gzP+vydfgrEXsA
         o728y38cWbkN6/T0fVNcWbX87K728NKLE4BuAEY8gvdrbrTLI5w5Cx+3W90amkL9VBMV
         z16Tu4jECWiEGPEow45o7izIqWeGmBToyagWwpaEUaScJjq93T1uyPEdpSWoLV2QKN0D
         otKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zpqnm/x/AdsYycdl11Nd+V+IfO9WFcP66DZDngrAd9E=;
        b=Kl24nALPPxOxYdPNsNyUxVrS7gEozLscbb0Gw37lIIExb9NK9MYBBhV6IcdgO9z9Dr
         RDRQhFxkhKQ5HUlvXkouil/0gMJ1pTv5C6vCORYHHWC5lC7h+kCh9nrTPHJfDTs+MHXR
         jv3wLYWNTP5GkwseyVIcJ3+JIc69UYIEo5IXZF519Xa2+V8exwKj+7kJ02VYweqT+RsD
         6dZdSMlyMabRe/ZH53hZuyLDPlEYuJTQum4hhrStOr9t8Jw48D9gjWrg+ZcRUxePQGad
         zRrcG687EPUrKZmMoztD21DxDMajjE+2Ns99vS//0MJsuYDZtTMBrxUXDcCxT9CMnX97
         mycg==
X-Gm-Message-State: APjAAAVmLbZEA4OjSKiIcekyY/gOVlZqaSmw0kqubA5E8x9HpokNz2ya
        xpV4so2TOkpg0f0U5ZkzQxYPJ6XQYqC//Ap2
X-Google-Smtp-Source: APXvYqxlxUbFUomnC9jt1Ud6035b35BwuPIkorhnO2Uqejg7ZM5g6I6GS7yNiFHC3c23lchL6G6ZhQ==
X-Received: by 2002:a05:620a:14a1:: with SMTP id x1mr71416914qkj.164.1560436053376;
        Thu, 13 Jun 2019 07:27:33 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::9d6b])
        by smtp.gmail.com with ESMTPSA id x7sm1732042qth.37.2019.06.13.07.27.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 07:27:33 -0700 (PDT)
Date:   Thu, 13 Jun 2019 10:27:31 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <wqu@suse.com>, Nikolay Borisov <nborisov@suse.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 17/19] btrfs: shrink delayed allocation size in HMZONED
 mode
Message-ID: <20190613142731.mgitehmuyz2566no@MacBook-Pro-91.local>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
 <20190607131025.31996-18-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607131025.31996-18-naohiro.aota@wdc.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 07, 2019 at 10:10:23PM +0900, Naohiro Aota wrote:
> In a write heavy workload, the following scenario can occur:
> 
> 1. mark page #0 to page #2 (and their corresponding extent region) as dirty
>    and candidate for delayed allocation
> 
> pages    0 1 2 3 4
> dirty    o o o - -
> towrite  - - - - -
> delayed  o o o - -
> alloc
> 
> 2. extent_write_cache_pages() mark dirty pages as TOWRITE
> 
> pages    0 1 2 3 4
> dirty    o o o - -
> towrite  o o o - -
> delayed  o o o - -
> alloc
> 
> 3. Meanwhile, another write dirties page #3 and page #4
> 
> pages    0 1 2 3 4
> dirty    o o o o o
> towrite  o o o - -
> delayed  o o o o o
> alloc
> 
> 4. find_lock_delalloc_range() decide to allocate a region to write page #0
>    to page #4
> 5. but, extent_write_cache_pages() only initiate write to TOWRITE tagged
>    pages (#0 to #2)
> 
> So the above process leaves page #3 and page #4 behind. Usually, the
> periodic dirty flush kicks write IOs for page #3 and #4. However, if we try
> to mount a subvolume at this timing, mount process takes s_umount write
> lock to block the periodic flush to come in.
> 
> To deal with the problem, shrink the delayed allocation region to have only
> expected to be written pages.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/btrfs/extent_io.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index c73c69e2bef4..ea582ff85c73 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3310,6 +3310,33 @@ static noinline_for_stack int writepage_delalloc(struct inode *inode,
>  			delalloc_start = delalloc_end + 1;
>  			continue;
>  		}
> +
> +		if (btrfs_fs_incompat(btrfs_sb(inode->i_sb), HMZONED) &&
> +		    (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages) &&
> +		    ((delalloc_start >> PAGE_SHIFT) <
> +		     (delalloc_end >> PAGE_SHIFT))) {
> +			unsigned long i;
> +			unsigned long end_index = delalloc_end >> PAGE_SHIFT;
> +
> +			for (i = delalloc_start >> PAGE_SHIFT;
> +			     i <= end_index; i++)
> +				if (!xa_get_mark(&inode->i_mapping->i_pages, i,
> +						 PAGECACHE_TAG_TOWRITE))
> +					break;
> +
> +			if (i <= end_index) {
> +				u64 unlock_start = (u64)i << PAGE_SHIFT;
> +
> +				if (i == delalloc_start >> PAGE_SHIFT)
> +					unlock_start += PAGE_SIZE;
> +
> +				unlock_extent(tree, unlock_start, delalloc_end);
> +				__unlock_for_delalloc(inode, page, unlock_start,
> +						      delalloc_end);
> +				delalloc_end = unlock_start - 1;
> +			}
> +		}
> +

Helper please.  Really for all this hmzoned stuff I want it segregated as much
as possible so when I'm debugging or cleaning other stuff up I want to easily be
able to say "oh this is for zoned devices, it doesn't matter."  Thanks,

Josef
