Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 655D23B4AC2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jun 2021 00:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhFYW4k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Jun 2021 18:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbhFYW4j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Jun 2021 18:56:39 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B076C061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Jun 2021 15:54:18 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id 69so5465887plc.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Jun 2021 15:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SctU8VYjZto5yPGDEO1zd7HL8tKqrgwRqwln1qca9fQ=;
        b=DGSFFisjYXTwcTGs9hNZ+AVJex+7qUjVMVwsnBat8dy/FIiA+rQErl2P9HNZXHNw8p
         uAnOSUf9Q+jnDr0jK5ad6yYUR94/KZza3zRZmD7ybsutJBh1dTwGuDYmvq34LCnTGgiu
         oP2/0y+uxAAJhKyS7ol62WjVn0TeOOHQQcHSf8k1dIO5DdWhGEWsjiK7K9N2m/QohKIF
         wXVerxJmqS2IGTX2l8RYc0eM8DVwS1GW/8kHQykmOWBOxleehioLG95PcgsX15KLy/mo
         WUQ3TedNJsWBLzUCAOASWeoeTqaJ+TYhWJO5bukdv1IT/c+SosSsjTfI8qxtXrHBLFsl
         f3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SctU8VYjZto5yPGDEO1zd7HL8tKqrgwRqwln1qca9fQ=;
        b=JfYXtOLRMYvDg1MaTeFgotMN7KBCOPq5xhy1p6RJxJG7W2wXWO65JSFlonBYKsuSbC
         KG9Xlbksyi8WvRwOjWJHGY80+/nDBwg8S5EhYWfXlxrvHZiPdV/gZ+HQRnG1+D9rkzZc
         dRARa6ieqlkmBNwC73ocPKgrkY6F9qL7afMlAx+LOAU+zbj7o3k0C44Z9fsVwBwBagiu
         4LANmFkwL+aRkL/fTtn12MmPYuUAVz4lEW+JuyiVHF5kgSgg9uJ65xTyuqF9sgl2chdq
         iget9RyYBXXJx+CNUtDRr2QnsYRdEHg9SGVTuD3K0XOYiSxSQG+GGPF/tuFFzepqcB7s
         U9Vg==
X-Gm-Message-State: AOAM531zqWSzpQV5u7xIf9ij5zaBw0bM7J/q9Rj4Xde+3YrhznfcEa9z
        PXIqEsYfjANzq7EgQ0R1FgAy8HHK84+v0zXwkNbJbg==
X-Google-Smtp-Source: ABdhPJz2eT5i809/nFgSpYCGw4wc3vd8A/PFmxznJ0olFj8dU25QdTgozl3VmnlM91slle9v57cvJjZJR0ZEe5jtSe0=
X-Received: by 2002:a17:90a:8589:: with SMTP id m9mr23009244pjn.168.1624661657646;
 Fri, 25 Jun 2021 15:54:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210622160015.18004-1-jack@suse.cz>
In-Reply-To: <20210622160015.18004-1-jack@suse.cz>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 25 Jun 2021 15:54:06 -0700
Message-ID: <CAPcyv4jkQxfuaPbH5PefKF8Tp+0LCuNN08m0eXWJb3j5x5fcFQ@mail.gmail.com>
Subject: Re: [PATCH] dax: Fix ENOMEM handling in grab_mapping_entry()
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jan,

I was out for a few days...

On Tue, Jun 22, 2021 at 9:00 AM Jan Kara <jack@suse.cz> wrote:
>
> grab_mapping_entry() has a bug in handling of ENOMEM condition. Suppose
> we have a PMD entry at index I which we are downgrading to a PTE entry.
> grab_mapping_entry() will set pmd_downgrade to true, lock the entry,
> clear the entry in xarray, and decrement mapping->nrpages. The it will
> call:
>
>         entry = dax_make_entry(pfn_to_pfn_t(0), flags);
>         dax_lock_entry(xas, entry);
>
> which inserts new PTE entry into xarray. However this may fail
> allocating the new node. We handle this by:
>
>         if (xas_nomem(xas, mapping_gfp_mask(mapping) & ~__GFP_HIGHMEM))
>                 goto retry;
>
> however pmd_downgrade stays set to true even though 'entry' returned
> from get_unlocked_entry() will be NULL now. And we will go again through
> the downgrade branch. This is mostly harmless except that
> mapping->nrpages is decremented again and we temporarily have invalid
> entry stored in xarray. Fix the problem by setting pmd_downgrade to
> false each time we lookup the entry we work with so that it matches
> the entry we found.
>
> Fixes: b15cd800682f ("dax: Convert page fault handlers to XArray")
> Signed-off-by: Jan Kara <jack@suse.cz>

Looks good to me:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

I notice that Andrew already picked this up and I'm ok to let it
percolate up to Linus through -mm.
