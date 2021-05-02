Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1719370A75
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 May 2021 08:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbhEBGcZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 May 2021 02:32:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:59418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229526AbhEBGcY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 May 2021 02:32:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 622FB6134F;
        Sun,  2 May 2021 06:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619937093;
        bh=SUTF4qHvvsvOCxRaO7XMs9cQTJeY156G3PPBU4Gks2Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SOUpNoydb/Dr01KO8+naCCL9W/VNTnBaeUOGgAEKVeY9Ki8wwSN/8gQXKYt4Eejj9
         5ODj0fMX/fFoQnrlDWf0DIuyNGXeU1B5VzF9LMwxHZvEJ1+jVEHYmegGhZQdSqqiQT
         2ElXY9X/fhAd0ms8gpUWE1EGsl7CF7uNmtg6MVqQFqTTLjG3BmSYNwDRoUlOQRKwsM
         /iHufKPwlGmiUSK1jvdTa0yM/xMbUgA6M1PZCE9EDYujnE/iBkj6SsVbqbz8pbkeSe
         +rB0HbrVWvKcCyAEeRj+m4of7Ad3w2qUphuxf/+YhkT5sygsX45ePs3e9C7cDv9Zn3
         HCmDkz5w5Tw2A==
Date:   Sun, 2 May 2021 09:31:21 +0300
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
Subject: Re: [PATCH v1 2/7] fs/proc/kcore: pfn_is_ram check only applies to
 KCORE_RAM
Message-ID: <YI5HOad9T+752CBg@kernel.org>
References: <20210429122519.15183-1-david@redhat.com>
 <20210429122519.15183-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429122519.15183-3-david@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 29, 2021 at 02:25:14PM +0200, David Hildenbrand wrote:
> Let's resturcture the code, using switch-case, and checking pfn_is_ram()
> only when we are dealing with KCORE_RAM.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  fs/proc/kcore.c | 35 +++++++++++++++++++++++++++--------
>  1 file changed, 27 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
> index 09f77d3c6e15..ed6fbb3bd50c 100644
> --- a/fs/proc/kcore.c
> +++ b/fs/proc/kcore.c
> @@ -483,25 +483,36 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
>  				goto out;
>  			}
>  			m = NULL;	/* skip the list anchor */
> -		} else if (!pfn_is_ram(__pa(start) >> PAGE_SHIFT)) {
> -			if (clear_user(buffer, tsz)) {
> -				ret = -EFAULT;
> -				goto out;
> -			}
> -		} else if (m->type == KCORE_VMALLOC) {
> +			goto skip;
> +		}
> +
> +		switch (m->type) {
> +		case KCORE_VMALLOC:
>  			vread(buf, (char *)start, tsz);
>  			/* we have to zero-fill user buffer even if no read */
>  			if (copy_to_user(buffer, buf, tsz)) {
>  				ret = -EFAULT;
>  				goto out;
>  			}
> -		} else if (m->type == KCORE_USER) {
> +			break;
> +		case KCORE_USER:
>  			/* User page is handled prior to normal kernel page: */
>  			if (copy_to_user(buffer, (char *)start, tsz)) {
>  				ret = -EFAULT;
>  				goto out;
>  			}
> -		} else {
> +			break;
> +		case KCORE_RAM:
> +			if (!pfn_is_ram(__pa(start) >> PAGE_SHIFT)) {
> +				if (clear_user(buffer, tsz)) {
> +					ret = -EFAULT;
> +					goto out;
> +				}
> +				break;
> +			}
> +			fallthrough;
> +		case KCORE_VMEMMAP:
> +		case KCORE_TEXT:
>  			if (kern_addr_valid(start)) {
>  				/*
>  				 * Using bounce buffer to bypass the
> @@ -525,7 +536,15 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
>  					goto out;
>  				}
>  			}
> +			break;
> +		default:
> +			pr_warn_once("Unhandled KCORE type: %d\n", m->type);
> +			if (clear_user(buffer, tsz)) {
> +				ret = -EFAULT;
> +				goto out;
> +			}
>  		}
> +skip:
>  		buflen -= tsz;
>  		*fpos += tsz;
>  		buffer += tsz;
> -- 
> 2.30.2
> 

-- 
Sincerely yours,
Mike.
