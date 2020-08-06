Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A904023D924
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Aug 2020 12:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729250AbgHFKL1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Aug 2020 06:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728971AbgHFKLO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Aug 2020 06:11:14 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BEBC061575
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Aug 2020 03:11:13 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id h8so25803900lfp.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Aug 2020 03:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FmHNrmiGc1oEc9Yta/aBuQn+1EulEN2xZuLGLoeLXHQ=;
        b=vdAe04pQJi4piGZ5+mZ0j2zhjTn6XVtWXoKVvfYvjkZt497I/uZbgq0bCXUw9yqxv1
         aDwbG4fQLRxllT940g4JJIoLaihdHAzLTznrUByrMW1Sxn0NV4LG6ITrocLkxfQ/UbR8
         /22r5p3LxUUJDP/bT5Lo9OvmnoXmRxUSyOPo0gH4uKUH+elU8Mn1VlYg4xH7/Swt6AEz
         woNXvCrI7kpsrhxnMJDhchfVxMGgUKsXYC/i/xUa92sA04Rdaab+RLuwLDiP7hERRYMU
         MGSXXRnFS4yE+plzwECIlQPOIq5Q9sL11BNdJXjz4h7FpV4jOJJQ0vybui6R3DGZ4y4F
         e/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FmHNrmiGc1oEc9Yta/aBuQn+1EulEN2xZuLGLoeLXHQ=;
        b=ZtPOg+5VaEGhdFASf/Eo+bZE6Ybu6l3AiTbbeOsQOhOgTiZjDwPcDh9QuGcgC+E8wI
         hLxJndg+S0EQOBcRBItCdXFEuqto6n5flN0OHfJ/Wam/5aTpra7uNB8P6ru84MFGF2VS
         bN3AQFWcHKE5CbHr0JoW+UP5mARzmcq/J1r33ginq7gNVt6vTk8CwKdJheyyJX4BQHGr
         y0/IO08z3hwBIpYKrPs+/wqmkPG+Uv05tneGjLL33YfbbQB0uP1YA+Km4TXB9lwresps
         krpl3dRE5mY6CmUIbkDN5JOW71TT75sdljd5pDiWoizj0XFdnc+j1jPfJJjOdcCLUyHo
         U0dA==
X-Gm-Message-State: AOAM531r9gA8wgZlBZjCjX2JSmLjJyBJUAE1RLxCNPNJPdQvaastjj36
        Wzhh7noEqUtClFhQ7rRpg7OemA==
X-Google-Smtp-Source: ABdhPJztxQdmUqdlmLCUV07uqArQbN1pckvCcR5Q9hxz1Dr0Q7jnsmbBT95GM1N8CkcdipmeoNGGIA==
X-Received: by 2002:a19:70c:: with SMTP id 12mr3611270lfh.207.1596708665300;
        Thu, 06 Aug 2020 03:11:05 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id v9sm2356183lja.81.2020.08.06.03.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 03:11:04 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 92823102E1B; Thu,  6 Aug 2020 13:11:12 +0300 (+03)
Date:   Thu, 6 Aug 2020 13:11:12 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
Subject: Re: [PATCH v3 1/6] mm: add definition of PMD_PAGE_ORDER
Message-ID: <20200806101112.bjw4mxu2odpsg2hh@box>
References: <20200804095035.18778-1-rppt@kernel.org>
 <20200804095035.18778-2-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804095035.18778-2-rppt@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 04, 2020 at 12:50:30PM +0300, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> The definition of PMD_PAGE_ORDER denoting the number of base pages in the
> second-level leaf page is already used by DAX and maybe handy in other
> cases as well.
> 
> Several architectures already have definition of PMD_ORDER as the size of
> second level page table, so to avoid conflict with these definitions use
> PMD_PAGE_ORDER name and update DAX respectively.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  fs/dax.c                | 10 +++++-----
>  include/linux/pgtable.h |  3 +++
>  2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 11b16729b86f..b91d8c8dda45 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -50,7 +50,7 @@ static inline unsigned int pe_order(enum page_entry_size pe_size)
>  #define PG_PMD_NR	(PMD_SIZE >> PAGE_SHIFT)
>  
>  /* The order of a PMD entry */
> -#define PMD_ORDER	(PMD_SHIFT - PAGE_SHIFT)
> +#define PMD_PAGE_ORDER	(PMD_SHIFT - PAGE_SHIFT)

Hm. Wouldn't it conflict with definition in pgtable.h? Or should we
include it instead?

> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 56c1e8eb7bb0..79f8443609e7 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -28,6 +28,9 @@
>  #define USER_PGTABLES_CEILING	0UL
>  #endif
>  
> +/* Number of base pages in a second level leaf page */
> +#define PMD_PAGE_ORDER	(PMD_SHIFT - PAGE_SHIFT)
> +
>  /*
>   * A page table page can be thought of an array like this: pXd_t[PTRS_PER_PxD]
>   *

-- 
 Kirill A. Shutemov
