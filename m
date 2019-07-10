Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7CB64C64
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2019 20:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfGJSsP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jul 2019 14:48:15 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46833 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbfGJSsO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jul 2019 14:48:14 -0400
Received: by mail-pg1-f193.google.com with SMTP id i8so1636060pgm.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jul 2019 11:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y9kooNntoKsSjfBoyAT/Wl3OUMWao+tgpJsSDEV/3mY=;
        b=OFjD/iLuYrkg1RhYeN3VKM0/ELOCopxGEBIDDqvo5swD04JGSTNq3LyO5brgEAqGsz
         UALrJXenvXS3YoCtUXy1CBNOI/pwmTHCuw1BEj4n86Ll2AEYX2iZ+SfVRUjx5S15W7RH
         33kEls+0jpJZbSW7GcqyjXCHCAByMD4WHssllukI4Py2WXt6L9Ad+H0i8h7E/WSQphKg
         RLLmcPbF1sWNvg8/UeJfoQwz3J9c8A9TsX8KPp/38Rp7oVTCobf/hHCqPtJqFMy7sNkW
         AYN0vfhtiynvE5ZxG7n4/uXDHiUgnIzwMO5st4VDEViLo5enzimobH+MdiHGRzTrhzD2
         +bGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y9kooNntoKsSjfBoyAT/Wl3OUMWao+tgpJsSDEV/3mY=;
        b=PimJtsUX30ZPnrG6W/kqqZqXKF38o1njbDODa0p3ma4ZDqj/UEnobkXKMaWEEQlSJF
         DkLeSyi8lD2Z8UMTNjfg8sTVPRwLeCxF4G2U+OXwG0KtOevl/KRaQjxaaa/CA1ET447X
         txNGl+DOwRcYKRexGSnqPoGILTXmNunapSIf/lOJ0/sPQC0F3cvmgiUMVc6FsQUS+iSY
         CzQBJTjLGiYo6F6aQbR+9CrcPKMmz06muu2QfchAnOtfT3QRO64Weg+KU/CdUc/KBGNj
         75Xgmy9VVKbCN4uPagsGWShiDwowjd+fditCFFO0sXwZvelHYMRhkWg0G7KYgfxb7zRB
         CPsw==
X-Gm-Message-State: APjAAAWdvpJDbVIHBNP+iM1V8SmIu9P67STbD3+79pn4giC/W9ruBp9u
        iWNDRvxXyDHczhntpJS49WIHoA==
X-Google-Smtp-Source: APXvYqw+kZW6sO6JboWw1tOGgmgFR3oUqPRhYylozUo7bOJrFZM3xbWs7lUQ85zycV3bVRZjD38Cyw==
X-Received: by 2002:a63:4404:: with SMTP id r4mr38331577pga.245.1562784493365;
        Wed, 10 Jul 2019 11:48:13 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:5b9d])
        by smtp.gmail.com with ESMTPSA id k184sm2700588pgk.7.2019.07.10.11.48.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 11:48:12 -0700 (PDT)
Date:   Wed, 10 Jul 2019 14:48:11 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, matthew.wilcox@oracle.com,
        kirill.shutemov@linux.intel.com, kernel-team@fb.com,
        william.kucharski@oracle.com, akpm@linux-foundation.org,
        hdanton@sina.com
Subject: Re: [PATCH v9 5/6] mm,thp: add read-only THP support for (non-shmem)
 FS
Message-ID: <20190710184811.GF11197@cmpxchg.org>
References: <20190625001246.685563-1-songliubraving@fb.com>
 <20190625001246.685563-6-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625001246.685563-6-songliubraving@fb.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 24, 2019 at 05:12:45PM -0700, Song Liu wrote:
> This patch is (hopefully) the first step to enable THP for non-shmem
> filesystems.
> 
> This patch enables an application to put part of its text sections to THP
> via madvise, for example:
> 
>     madvise((void *)0x600000, 0x200000, MADV_HUGEPAGE);
> 
> We tried to reuse the logic for THP on tmpfs.
> 
> Currently, write is not supported for non-shmem THP. khugepaged will only
> process vma with VM_DENYWRITE. sys_mmap() ignores VM_DENYWRITE requests
> (see ksys_mmap_pgoff). The only way to create vma with VM_DENYWRITE is
> execve(). This requirement limits non-shmem THP to text sections.
> 
> The next patch will handle writes, which would only happen when the all
> the vmas with VM_DENYWRITE are unmapped.
> 
> An EXPERIMENTAL config, READ_ONLY_THP_FOR_FS, is added to gate this
> feature.
> 
> Acked-by: Rik van Riel <riel@surriel.com>
> Signed-off-by: Song Liu <songliubraving@fb.com>

This is really cool, and less invasive than I anticipated. Nice work.

I only have one concern and one question:

> @@ -1392,6 +1401,29 @@ static void collapse_file(struct mm_struct *mm,
>  				result = SCAN_FAIL;
>  				goto xa_unlocked;
>  			}
> +		} else if (!page || xa_is_value(page)) {
> +			xas_unlock_irq(&xas);
> +			page_cache_sync_readahead(mapping, &file->f_ra, file,
> +						  index, PAGE_SIZE);
> +			/* drain pagevecs to help isolate_lru_page() */
> +			lru_add_drain();
> +			page = find_lock_page(mapping, index);
> +			if (unlikely(page == NULL)) {
> +				result = SCAN_FAIL;
> +				goto xa_unlocked;
> +			}
> +		} else if (!PageUptodate(page)) {
> +			VM_BUG_ON(is_shmem);
> +			xas_unlock_irq(&xas);
> +			wait_on_page_locked(page);
> +			if (!trylock_page(page)) {
> +				result = SCAN_PAGE_LOCK;
> +				goto xa_unlocked;
> +			}
> +			get_page(page);
> +		} else if (!is_shmem && PageDirty(page)) {
> +			result = SCAN_FAIL;
> +			goto xa_locked;
>  		} else if (trylock_page(page)) {
>  			get_page(page);
>  			xas_unlock_irq(&xas);

The many else ifs here check fairly complex page state and are hard to
follow and verify mentally. In fact, it's a bit easier now in the
patch when you see how it *used* to work with just shmem, but the end
result is fragile from a maintenance POV.

The shmem and file cases have little in common - basically only the
trylock_page(). Can you please make one big 'if (is_shmem) {} {}'
structure instead that keeps those two scenarios separate?

> @@ -1426,6 +1458,12 @@ static void collapse_file(struct mm_struct *mm,
>  			goto out_unlock;
>  		}
>  
> +		if (page_has_private(page) &&
> +		    !try_to_release_page(page, GFP_KERNEL)) {
> +			result = SCAN_PAGE_HAS_PRIVATE;
> +			break;
> +		}
> +
>  		if (page_mapped(page))
>  			unmap_mapping_pages(mapping, index, 1, false);

> @@ -1607,6 +1658,17 @@ static void khugepaged_scan_file(struct mm_struct *mm,
>  			break;
>  		}
>  
> +		if (page_has_private(page) && trylock_page(page)) {
> +			int ret;
> +
> +			ret = try_to_release_page(page, GFP_KERNEL);
> +			unlock_page(page);
> +			if (!ret) {
> +				result = SCAN_PAGE_HAS_PRIVATE;
> +				break;
> +			}
> +		}
> +
>  		if (page_count(page) != 1 + page_mapcount(page)) {
>  			result = SCAN_PAGE_COUNT;
>  			break;

There is already a try_to_release() inside the page lock section in
collapse_file(). I'm assuming you added this one because private data
affects the refcount. But it seems a bit overkill just for that; we
could also still fail the check, in which case we'd have dropped the
buffers in vain. Can you fix the check instead?

There is an is_page_cache_freeable() function in vmscan.c that handles
private fs references:

static inline int is_page_cache_freeable(struct page *page)
{
	/*
	 * A freeable page cache page is referenced only by the caller
	 * that isolated the page, the page cache and optional buffer
	 * heads at page->private.
	 */
	int page_cache_pins = PageTransHuge(page) && PageSwapCache(page) ?
		HPAGE_PMD_NR : 1;
	return page_count(page) - page_has_private(page) == 1 + page_cache_pins;
}

Wouldn't this work here as well?

The rest looks great to me.
