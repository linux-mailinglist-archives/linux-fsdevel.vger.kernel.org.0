Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88CCC83055
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2019 13:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732627AbfHFLMO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Aug 2019 07:12:14 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34973 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731281AbfHFLMO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Aug 2019 07:12:14 -0400
Received: by mail-ed1-f67.google.com with SMTP id w20so81908922edd.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Aug 2019 04:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IVUZ3vCUTZaoNKcACCnsP7M9ScGcHtHaH8K8c7i8HGE=;
        b=dzc5ZzSlafWAy4fTC2ybrGXSCublaxnDUYbea0pzEG0z1VVySMMflBJVhE69+xqsxQ
         ESDT9/Cp7bfZI3bAbHXvis/zbWvnBL2Tt5UimOA9lpTrAdZc/C2ry9LQNpbmWXzDlqEI
         Uv2TeJm+Zisvbj8s0NnelXo1te8MM6RBy56cFCUBrFEBGLwOhQJX5pQ5s/Fi5zOv1P3N
         vxUj4YVvG++IvGchx4EZYQq6T2UHYO58Gx0S8bgicbKPJVYzkmuJrWWXexEv9O9yPDpe
         TLWBH3Igl7oDCOQj92KYngp53w9jybNVCctzRFInXAgzw/hzdUgcgskgBuK259f86s2x
         WiOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IVUZ3vCUTZaoNKcACCnsP7M9ScGcHtHaH8K8c7i8HGE=;
        b=oj0CgTT1ni1YM6VpKs6aBOMD4wTaa3FK+vy0v748umlM7wA8joO0dYuVOyTpkXYD7s
         TEe5UcykfF9R6eM+7SpNZTCdkyw+gbnq9gbNw+ObQOYEc9djemlNmBEeGpUt6QGLLBFS
         XiFzOgqyx2YBZroxtZW1DjZ767SosUTBJX4TYfp1bWamGUqoCJ7jee8e2jsiuPBkCpOH
         937Bc99UJtWGXlsQfQDYZpwi642LsN2JBaam6vESIrmltZzQ85n/xJXq2lUm61dT0Dqx
         L3TJpoWoOTWCNDYUjkAAhQpWi89ItB3ZpyUQaQzM9h6/aRa/7tGGzVvnG+MFJwzV29aS
         YWyA==
X-Gm-Message-State: APjAAAUHoNInuzXrWy91tlw4Yzf7sGTTPE0qzwXnjqX2pd5k/sP3L6+h
        wm992a1bQESldawfhPzJr34KzQ==
X-Google-Smtp-Source: APXvYqztbyBgleEnQ54uuSvw10HgZnTrh29ZTTFUfYTHSJDyykKw0nXSNOlE5//gAzIYtisxx3tk1Q==
X-Received: by 2002:a50:f98a:: with SMTP id q10mr3146171edn.267.1565089931994;
        Tue, 06 Aug 2019 04:12:11 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id c48sm20888241edb.10.2019.08.06.04.12.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 04:12:11 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id CC6D01003C7; Tue,  6 Aug 2019 14:12:10 +0300 (+03)
Date:   Tue, 6 Aug 2019 14:12:10 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     William Kucharski <william.kucharski@oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Bob Kasten <robert.a.kasten@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Chad Mynhier <chad.mynhier@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Johannes Weiner <jweiner@fb.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 2/2] mm,thp: Add experimental config option
 RO_EXEC_FILEMAP_HUGE_FAULT_THP
Message-ID: <20190806111210.7xpmjsd4hq54vuml@box>
References: <20190731082513.16957-1-william.kucharski@oracle.com>
 <20190731082513.16957-3-william.kucharski@oracle.com>
 <20190801123658.enpchkjkqt7cdkue@box>
 <c8d02a3b-e1ad-2b95-ce15-13d3ed4cca87@oracle.com>
 <20190805132854.5dnqkfaajmstpelm@box.shutemov.name>
 <19A86A16-B440-4B73-98FE-922A09484DFD@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19A86A16-B440-4B73-98FE-922A09484DFD@oracle.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 05, 2019 at 09:56:45AM -0600, William Kucharski wrote:
> >> I don't really care if the start of the VMA is suitable, just whether I can map
> >> the current faulting page with a THP. As far as I know, there's nothing wrong
> >> with mapping all the pages before the VMA hits a properly aligned bound with
> >> PAGESIZE pages and then aligned chunks in the middle with THP.
> > 
> > You cannot map any paged as huge into wrongly aligned VMA.
> > 
> > THP's ->index must be aligned to HPAGE_PMD_NR, so if the combination VMA's
> > ->vm_start and ->vm_pgoff doesn't allow for this, you must fallback to
> > mapping the page with PTEs. I don't see it handled properly here.
> 
> It was my assumption that if say a VMA started at an address say one page
> before a large page alignment, you could map that page with a PAGESIZE
> page but if VMA size allowed, there was a fault on the next page, and
> VMA size allowed, you could map that next range with a large page, taking
> taking the approach of mapping chunks of the VMA with the largest page
> possible.
> 
> Is it that the start of the VMA must always align or that the entire VMA
> must be properly aligned and a multiple of the PMD size (so you either map
> with all large pages or none)?

IIUC, you are missing ->vm_pgoff from the picture. The newly allocated
page must land into page cache aligned on HPAGE_PMD_NR boundary. In other
word you cannout have huge page with ->index, let say, 1.

VMA is only suitable for at least one file-THP page if:

 - (vma->vm_start >> PAGE_SHIFT) % (HPAGE_PMD_NR - 1) is equal to
    vma->vm_pgoff % (HPAGE_PMD_NR - 1)

    This guarantees right alignment in the backing page cache.

 - *and* vma->vm_end - round_up(vma->vm_start, HPAGE_PMD_SIZE) is equal or
   greater than HPAGE_PMD_SIZE.

Does it make sense?

> 
> >> This is the page that content was just read to; readpage() will unlock the page
> >> when it is done with I/O, but the page needs to be locked before it's inserted
> >> into the page cache.
> > 
> > Then you must to lock the page properly with lock_page().
> > 
> > __SetPageLocked() is fine for just allocated pages that was not exposed
> > anywhere. After ->readpage() it's not the case and it's not safe to use
> > __SetPageLocked() for them.
> 
> In the current code, it's assumed it is not exposed, because a single read
> of a large page that does no readahead before the page is inserted into the
> cache means there are no external users of the page.

You've exposed the page to the filesystem once you call ->readpage().
It *may* track the page somehow after the call.

-- 
 Kirill A. Shutemov
