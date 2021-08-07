Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABCE03E34C8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Aug 2021 12:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbhHGKcr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Aug 2021 06:32:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:60826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231687AbhHGKc3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Aug 2021 06:32:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 18487610FC;
        Sat,  7 Aug 2021 10:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628332329;
        bh=q0JbSC4fX4Crhi1HrqSNaN67de1iCkzSUaCVowYclWc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fsKTwecZe161gdAJQQnyQfzWRCWKtSI17t3EW2r28Gew517Y3JIG85wSBnFhNDI3r
         yGBQpyi7/ih3s7Q+f6DT0xIKDfvkzFbjVbBY1WK/mbWYGJRxJlsh1y9LX+FbBh46eV
         JYiIs0+AXJ/mjkz1PkHvHD7P5i2Wc3h8ZZeelre82v6V3CC02Rqs7WmF2gIZ/IVtuw
         zxAknc/fQcFuL0DLvtfzYQiaYcoRw1xmG91FwgwYzfzPa2zb9zFs777Tla0VmvJ1WT
         cXAViWgi2TVIv/pUNGCJZmG8JasYImcSxG/g01QJcscEsR0FzAKD8eTLbclBkET1uh
         xGUmkqO6QNU9Q==
Date:   Sat, 7 Aug 2021 13:32:00 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Zi Yan <ziy@nvidia.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>,
        Ying Chen <chenying.kernel@bytedance.com>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 08/15] fs: proc: use PAGES_PER_SECTION for page
 offline checking period.
Message-ID: <YQ5hIFZX02BMS+Yb@kernel.org>
References: <20210805190253.2795604-1-zi.yan@sent.com>
 <20210805190253.2795604-9-zi.yan@sent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805190253.2795604-9-zi.yan@sent.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 05, 2021 at 03:02:46PM -0400, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> It keeps the existing behavior after MAX_ORDER is increased beyond
> a section size.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Ying Chen <chenying.kernel@bytedance.com>
> Cc: Feng Zhou <zhoufeng.zf@bytedance.com>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  fs/proc/kcore.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
> index 3f148759a5fd..77b7ba48fb44 100644
> --- a/fs/proc/kcore.c
> +++ b/fs/proc/kcore.c
> @@ -486,7 +486,7 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
>  			}
>  		}
>  
> -		if (page_offline_frozen++ % MAX_ORDER_NR_PAGES == 0) {
> +		if (page_offline_frozen++ % PAGES_PER_SECTION == 0) {

The behavior changes here. E.g. with default configuration on x86 instead
of cond_resched() every 2M we get cond_resched() every 128M.

I'm not saying it's wrong but at least it deserves an explanation why.

>  			page_offline_thaw();
>  			cond_resched();
>  			page_offline_freeze();
> -- 
> 2.30.2
> 

-- 
Sincerely yours,
Mike.
