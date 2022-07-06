Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7609C567C56
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jul 2022 05:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbiGFDLT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jul 2022 23:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiGFDLT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jul 2022 23:11:19 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39FC15FEC
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Jul 2022 20:11:17 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id n10so12600620plp.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Jul 2022 20:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=adFlPjTSINJCwR4o3G3QqAu+rrKuZ/5CiQjZIvPrt6U=;
        b=QQVf20B70sKkMkdDRS2X9H/Gy0P9G4+wRlQUDrOOM3ODgwNRc34pZQ6ShWpRZ2VF8b
         6e0NXc1TdtUMm7dUiy0La2zAHDfAHwL/oAtlw6YpEx1nbyJTwdDvD9rUylkrkrIZRvpc
         AqruyeXhRmYI0WGztsajKRlP3mfxbiD5T2FlXBv2ZiA8ab9yYzHJJyO6Is14SkPQTS1n
         FHt3l0mz+8KsFeMI6FPsjkloq75VzeFvb3h8OAcwcJnj76MkAz5rOGv23GzmG6YhSWi7
         s0zQlap60DojPdxiRU2vuH/0v6wxEmcMoLu7Qh76mEUHQcNIA5yfWZmsqTsjy6lHjezq
         P9WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=adFlPjTSINJCwR4o3G3QqAu+rrKuZ/5CiQjZIvPrt6U=;
        b=nPAn9gw4/lOUOUkkN6J+wSB1u2xkg+KqVg59vL93VP+83dMuChO0KsepIQDj2HoNyj
         9qHzGjxghjrc+t+Ey8rZOfjTjr0YkW2BQUxc3nhLOZaTeKpkl1wNplVCzjbF2xHJ8yGi
         iEJKUVxf++pYYXWPTLrLyuNT35AW7YMjFsyQTHJlaTa/sWWZ2gVBWHvRjf/hXKhjakiT
         Ba2uT2NWBNXjAIo3NGlmEkQXGJIdQ+VhrpsSYzp7wa3Mg5CKhOS4MbHOTKkE41uFcohB
         dlHMwRDSjgNPRu9ZqFxDKmFVj9G4fJVvbLDGGhp6Mm5IJ7rk8ypZzlQVzrwA8R0yQjJp
         w+KA==
X-Gm-Message-State: AJIora8DePTBqitMDp8PNXviJshoUv4okAvmiDtzsAg0UvyywDheuzq/
        seUVrgaGAlr3QKeIgEYzqbf+Ng==
X-Google-Smtp-Source: AGRyM1s3V0NQlgPNuKYtnFzkzn7TTCJeEo7FS9YZcDvQY+f/8qJVv7GX3mN/8eXl8vbzPMBuvQyY7g==
X-Received: by 2002:a17:902:aa05:b0:16a:5113:229d with SMTP id be5-20020a170902aa0500b0016a5113229dmr44555941plb.111.1657077077539;
        Tue, 05 Jul 2022 20:11:17 -0700 (PDT)
Received: from localhost ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id ij21-20020a170902ab5500b0016bedcced2fsm3399375plb.35.2022.07.05.20.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 20:11:17 -0700 (PDT)
Date:   Wed, 6 Jul 2022 11:11:13 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>, jgg@ziepe.ca,
        jhubbard@nvidia.com, william.kucharski@oracle.com,
        dan.j.williams@intel.com, jack@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        nvdimm@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm: fix missing wake-up event for FSDAX pages
Message-ID: <YsT9UQoR8cgPRmKZ@FVFYT0MHHV2J.usts.net>
References: <20220705123532.283-1-songmuchun@bytedance.com>
 <20220705141819.804eb972d43be3434dc70192@linux-foundation.org>
 <YsTLgQ45ESpsNEGV@casper.infradead.org>
 <20220705164710.9541b5cf0e5819193213ea5c@linux-foundation.org>
 <YsT3xFSLJonnA2XC@FVFYT0MHHV2J.usts.net>
 <20220705200042.26ddd5e2e106df4e65adcc74@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705200042.26ddd5e2e106df4e65adcc74@linux-foundation.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 05, 2022 at 08:00:42PM -0700, Andrew Morton wrote:
> On Wed, 6 Jul 2022 10:47:32 +0800 Muchun Song <songmuchun@bytedance.com> wrote:
> 
> > > If this wakeup is not one of these, then are there reports from the
> > > softlockup detector?
> > > 
> > > Do we have reports of processes permanently stuck in D state?
> > >
> > 
> > No. The task is in an TASK_INTERRUPTIBLE state (see __fuse_dax_break_layouts). 
> > The hung task reporter only reports D task (TASK_UNINTERRUPTIBLE).
> 
> Thanks, I updated the changelog a bit.
> 
> : FSDAX page refcounts are 1-based, rather than 0-based: if refcount is
> : 1, then the page is freed.  The FSDAX pages can be pinned through GUP,
> : then they will be unpinned via unpin_user_page() using a folio variant
> : to put the page, however, folio variants did not consider this special
> : case, the result will be to miss a wakeup event (like the user of
> : __fuse_dax_break_layouts()).  This results in a task being permanently
> : stuck in TASK_INTERRUPTIBLE state.
> : 
> : Since FSDAX pages are only possibly obtained by GUP users, so fix GUP
> : instead of folio_put() to lower overhead.
> 
> I believe these details are helpful for -stable maintainers who are
> wondering why they were sent stuff.  Also for maintainers of
> downstreeam older kernels who are scratching heads over some user bug
> report, trying to find a patch which might fix it - for this they want
> to see a description of the user-visible effects, for matching with
> that bug report.
>

Thanks Andrew, it's really helpful.
