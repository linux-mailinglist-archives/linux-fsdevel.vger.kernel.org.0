Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE39A370A87
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 May 2021 08:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbhEBGfO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 May 2021 02:35:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:32784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229526AbhEBGfO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 May 2021 02:35:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D49E61408;
        Sun,  2 May 2021 06:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619937263;
        bh=cByN/RcKM8xbB6KsfcBCkuoO/9VHkzKGkqsC7qrvyPM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s8Xy8pvyPi42yMVDvXg8Iv0BIywloo7o7xzc9wKr/4UrRbkY0CKZvRozbvzXENCa4
         UUZaptLpgkRVVl3eR/YC8PbVKT6jw+SaSxYKecOHesP02+UCu+CWqXDCDmDfeK5Epg
         TfWYkhVsqTcmoiSZqgqK4mCwfSmt5qEU0zNYzSrjKqR4WPmb2Uek8LX8JDwShqSbgd
         Nhc5IGoeN86yH1RMJLQJtCfYHjdLHre9EZDOJ4QxJqjrVDKP400NkwXCMi9Q6Pvf4k
         75xNE+1dK5Z9hV3/Yl+I8kGsk724zbVqOKaVmkB0ixJBwLZhxQFMsdk1UI8ZsRmifT
         tlR+6/+IGZspg==
Date:   Sun, 2 May 2021 09:34:11 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Steven Price <steven.price@arm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Aili Yao <yaoaili@kingsoft.com>, Jiri Bohac <jbohac@suse.cz>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 7/7] fs/proc/kcore: use page_offline_(freeze|unfreeze)
Message-ID: <YI5H4yV/c6ReuIDt@kernel.org>
References: <20210429122519.15183-1-david@redhat.com>
 <20210429122519.15183-8-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429122519.15183-8-david@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 29, 2021 at 02:25:19PM +0200, David Hildenbrand wrote:
> Let's properly synchronize with drivers that set PageOffline(). Unfreeze
> every now and then, so drivers that want to set PageOffline() can make
> progress.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  fs/proc/kcore.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
> index 92ff1e4436cb..3d7531f47389 100644
> --- a/fs/proc/kcore.c
> +++ b/fs/proc/kcore.c
> @@ -311,6 +311,7 @@ static void append_kcore_note(char *notes, size_t *i, const char *name,
>  static ssize_t
>  read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
>  {
> +	size_t page_offline_frozen = 0;
>  	char *buf = file->private_data;
>  	size_t phdrs_offset, notes_offset, data_offset;
>  	size_t phdrs_len, notes_len;
> @@ -509,6 +510,18 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
>  			pfn = __pa(start) >> PAGE_SHIFT;
>  			page = pfn_to_online_page(pfn);

Can't this race with page offlining for the first time we get here?
 
> +			/*
> +			 * Don't race against drivers that set PageOffline()
> +			 * and expect no further page access.
> +			 */
> +			if (page_offline_frozen == MAX_ORDER_NR_PAGES) {
> +				page_offline_unfreeze();
> +				page_offline_frozen = 0;
> +				cond_resched();
> +			}
> +			if (!page_offline_frozen++)
> +				page_offline_freeze();
> +

Don't we need to freeze before doing pfn_to_online_page()?

>  			/*
>  			 * Don't read offline sections, logically offline pages
>  			 * (e.g., inflated in a balloon), hwpoisoned pages,
> @@ -565,6 +578,8 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
>  	}
>  
>  out:
> +	if (page_offline_frozen)
> +		page_offline_unfreeze();
>  	up_read(&kclist_lock);
>  	if (ret)
>  		return ret;
> -- 
> 2.30.2
> 

-- 
Sincerely yours,
Mike.
