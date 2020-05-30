Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 300491E8F13
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 May 2020 09:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbgE3HjX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 May 2020 03:39:23 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:3292 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbgE3HjX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 May 2020 03:39:23 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ed20d9e0000>; Sat, 30 May 2020 00:39:11 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sat, 30 May 2020 00:39:22 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sat, 30 May 2020 00:39:22 -0700
Received: from [10.2.56.10] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 30 May
 2020 07:39:22 +0000
Subject: Re: [PATCH v2] orangefs: convert get_user_pages() -->
 pin_user_pages()
To:     LKML <linux-kernel@vger.kernel.org>
CC:     Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        <devel@lists.orangefs.org>, <linux-fsdevel@vger.kernel.org>
References: <20200523035909.418683-1-jhubbard@nvidia.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <89244e74-f619-e515-083a-3bf2586fa5c3@nvidia.com>
Date:   Sat, 30 May 2020 00:39:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200523035909.418683-1-jhubbard@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590824351; bh=wcBfOkMknkl4oXGX1PfJTteciHFn5HKiXybtSk4Mz1c=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=cT6rr3oKxlKszzXLfMo4tLjt4eyFyHuy94doVPN3x2vZRpzuNqRwqWwYrjcQPekti
         ajgZV5hipGC0yaYCGarr2qtD+DvUKAa+HLVvH1oBhyxvvyZKk1FOYyOjCHpnTeLR1Y
         05P7hUmXT7MjcS8FXC2kU10aaEY0IgKjr+vyuLPRkbyPPNoGw6jhVSe++NtgAE/EuK
         9DTcelNp+RkTLRs5VS5MCM0JON5CK9OH5UQj+kgSRGJSeiIoNiQFRrqDCHoep8iPek
         xCAISw30vhYrdE6fV9QXw9eN58+hI0whp1adIANqjdrgXQyBLN3U29HCPhnRvHWS7k
         SbDtZQrUgeKHQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-05-22 20:59, John Hubbard wrote:
> This code was using get_user_pages*(), in a "Case 1" scenario
> (Direct IO), using the categorization from [1]. That means that it's
> time to convert the get_user_pages*() + put_page() calls to
> pin_user_pages*() + unpin_user_pages() calls.
> 
> There is some helpful background in [2]: basically, this is a small
> part of fixing a long-standing disconnect between pinning pages, and
> file systems' use of those pages.
> 
> [1] Documentation/core-api/pin_user_pages.rst
> 
> [2] "Explicit pinning of user-space pages":
>      https://lwn.net/Articles/807108/
> 
> Cc: Mike Marshall <hubcap@omnibond.com>
> Cc: Martin Brandenburg <martin@omnibond.com>
> Cc: devel@lists.orangefs.org
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
> 
> Hi,
> 
> Note that I have only compile-tested this patch, although that does
> also include cross-compiling for a few other arches.

An update on the run-time testing: Just now, I got basic orangefs tests
running in xfstests, with this patch applied, and it all looks normal.

thanks,
-- 
John Hubbard
NVIDIA

> 
> Changes since v1 [3]: correct the commit description, so that
> it refers to "Case 1" instead of "Case 2".
> 
> 
> [3] https://lore.kernel.org/r/20200518060139.2828423-1-jhubbard@nvidia.com
> 
> thanks,
> John Hubbard
> NVIDIA
> 
>   fs/orangefs/orangefs-bufmap.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/orangefs/orangefs-bufmap.c b/fs/orangefs/orangefs-bufmap.c
> index 2bb916d68576..538e839590ef 100644
> --- a/fs/orangefs/orangefs-bufmap.c
> +++ b/fs/orangefs/orangefs-bufmap.c
> @@ -168,10 +168,7 @@ static DEFINE_SPINLOCK(orangefs_bufmap_lock);
>   static void
>   orangefs_bufmap_unmap(struct orangefs_bufmap *bufmap)
>   {
> -	int i;
> -
> -	for (i = 0; i < bufmap->page_count; i++)
> -		put_page(bufmap->page_array[i]);
> +	unpin_user_pages(bufmap->page_array, bufmap->page_count);
>   }
>   
>   static void
> @@ -268,7 +265,7 @@ orangefs_bufmap_map(struct orangefs_bufmap *bufmap,
>   	int offset = 0, ret, i;
>   
>   	/* map the pages */
> -	ret = get_user_pages_fast((unsigned long)user_desc->ptr,
> +	ret = pin_user_pages_fast((unsigned long)user_desc->ptr,
>   			     bufmap->page_count, FOLL_WRITE, bufmap->page_array);
>   
>   	if (ret < 0)
> @@ -280,7 +277,7 @@ orangefs_bufmap_map(struct orangefs_bufmap *bufmap,
>   
>   		for (i = 0; i < ret; i++) {
>   			SetPageError(bufmap->page_array[i]);
> -			put_page(bufmap->page_array[i]);
> +			unpin_user_page(bufmap->page_array[i]);
>   		}
>   		return -ENOMEM;
>   	}
> 

