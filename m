Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA3B470A39
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Dec 2021 20:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343597AbhLJTWt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Dec 2021 14:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343559AbhLJTWs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Dec 2021 14:22:48 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BB2C061746
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Dec 2021 11:19:13 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id z9so9317247qtj.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Dec 2021 11:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=uPGW5ROteU5Fpf16TNGTuiysra125ZlvW3Q6FYu12Ms=;
        b=iPHEafCooGeQCkTPhS32asxz8gKfEZ0aooITZcjULaTirjc5u5YarrPCgxX2TWK4EX
         HwNQKwY1aJDPxGP4hobw0YUsiA49xEoFilYIRWMzGAcCS85ZW0sqUTmMPfNufaqRXFSQ
         imHOMwznVuvRk7MWOiawkN+cv+Sz/Z+VOR+HNcpTKecM9sCgC5rduMrlMsVkJgHtj6pa
         9cYkn9Gj/WUHxRreDsaKKTWqWxQW5orCBGWGOpFt0bXseu5wnkKi/J6Ue24jn3e0I2ku
         G2U4Y5sh0YK+xM8wuFcDIFeyGlq1OmV38D6bkJQDNFXVSFqNt/en743D8/zzcZiEmsvu
         UuEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=uPGW5ROteU5Fpf16TNGTuiysra125ZlvW3Q6FYu12Ms=;
        b=ALXxcGePgjJjb4aeP42X8ApDw2HYBS0gCcfVgL7ADvaQ3jNP0MOtj1CgbJ+g82U+zC
         dvZVV0bqEqwAY1sj5h8Dm5sSnJ2HH2uYSys7Q5S9H7KCvquP2WQozUOENFmGUY5f8vev
         tCRYuUhPUAKgEP4MBorY16FOZZ21BtvtKm4B3499bmefIc+PuUIDVHKFEzo4E+r+7UM9
         oXDMZxc+DZp0Jzr+wQt17t67uSY4tlnT0QCgjZKQkfIgXQAvoBkntneDCUJlQhl0RqLt
         /hoSnvlGIoZBnGycEcSquiWKeb3450EqYKIO9BOKINRwuVie38Gs3QqvWP1eM3cZflHP
         B2Mg==
X-Gm-Message-State: AOAM530g7gN9AxdVgRz7JGbETbOMI9/9rQdaQ0ARN9KB8UtiGJwSjSJR
        RsEOEEVS5at4OlGiuJXml5Dqxg==
X-Google-Smtp-Source: ABdhPJzoGmsQ9RX8SkvmJQMMv/lm4Mg8AzKdjOAay9UJKgN2FM00BrE2R0eQ/+j/lW2UZ5ub0gliOQ==
X-Received: by 2002:a05:622a:1d4:: with SMTP id t20mr29279044qtw.84.1639163952383;
        Fri, 10 Dec 2021 11:19:12 -0800 (PST)
Received: from [192.168.1.227] (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id f18sm1787318qko.34.2021.12.10.11.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 11:19:12 -0800 (PST)
Date:   Fri, 10 Dec 2021 11:18:59 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: delete unsafe BUG from
 page_cache_add_speculative()
In-Reply-To: <20211210092003.cf84354b406a47253afc868c@linux-foundation.org>
Message-ID: <7e783f99-148f-c7aa-08a-4c4c45c5506a@google.com>
References: <8b98fc6f-3439-8614-c3f3-945c659a1aba@google.com> <20211210092003.cf84354b406a47253afc868c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 10 Dec 2021, Andrew Morton wrote:
> On Wed, 8 Dec 2021 23:19:18 -0800 (PST) Hugh Dickins <hughd@google.com> wrote:
> 
> > It is not easily reproducible, but on 5.16-rc I have several times hit
> > the VM_BUG_ON_PAGE(PageTail(page), page) in page_cache_add_speculative():
> > usually from filemap_get_read_batch() for an ext4 read, yesterday from
> > next_uptodate_page() from filemap_map_pages() for a shmem fault.
> > 
> > That BUG used to be placed where page_ref_add_unless() had succeeded,
> > but now it is placed before folio_ref_add_unless() is attempted: that
> > is not safe, since it is only the acquired reference which makes the
> > page safe from racing THP collapse or split.
> > 
> > We could keep the BUG, checking PageTail only when folio_ref_try_add_rcu()
> > has succeeded; but I don't think it adds much value - just delete it.
> > 
> > Fixes: 020853b6f5ea ("mm: Add folio_try_get_rcu()")
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> 
> I added cc:stable to this.

Thanks, but no, cc:stable not needed: the fixed commit went into 5.16-rc1,
and did not go to stable itself. There was an identical VM_BUG_ON_PAGE in
the old __page_cache_add_speculative(), but that one was correctly placed,
so there's no need for the old one to be removed.

Hugh
