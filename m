Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCDC6912D2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Feb 2023 22:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjBIVyD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Feb 2023 16:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBIVyC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Feb 2023 16:54:02 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D476312D
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Feb 2023 13:54:01 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id v18-20020a17090ae99200b00230f079dcd9so6688711pjy.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Feb 2023 13:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0oX/lGmYsdyx5VnhUGqtR+KDAdmrsp9Y/YPHFCTjwNA=;
        b=Dka+5DdMdyuJvweTAJtER7ujyyrCUwCe7DZogFEspsK7zh/SU9WcyEFz8K9FPImVEx
         fVJTz1DCFLQFbRcXrYhMAlDtL42Wzyqv1YdFqNdD4i5wX2o6LFQiHw/Ut3SZ8mSYDaFt
         ajAqsQ/eWwraRs5nLh46MxwPRfQQkHe9xu3WRyeB2E0nIA9pqT//ImS/ilF3reKnS318
         s52iLbBbRBMvr91PhWvVABusRn4qwzys1mmvDkN1XyMveU2OpjzikGbARFQy6DbNufEX
         vmI8ThZrgVJ4hsy8KfZl3B/uOduwMhMaCn3oewsfyEeMuFYZwKkdG+z9Hsi2iiU7xIWN
         P88A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0oX/lGmYsdyx5VnhUGqtR+KDAdmrsp9Y/YPHFCTjwNA=;
        b=viXA484HjUbaSmItsjHnyn4Fx7+DDGBbQvLMDnyekANUrB1x/lL8Q99QhM19WZmF7+
         f02393GZWI75lx5W4oRLxcP9IWqfxOlFZ/eabBr/qXtQjEg2k5SBD1g4CsCnShzkfT+f
         3FWuevmgWEYBYzUdO5/C/Mpznq4AP07b9O2Ftfa4BRTN4PRCYYIwz/e259oVwftsKCL/
         ZNHOpehEAWc+ZggO3fE+mx5XJxRdI2s8KvZZeFtcfPrwx4btREcb5s4Cgz7WkQxpssYe
         b7pazcRtzNU+R78KQ9hfGFADg7pqGjMWbg1uIETs3+MEvdICE8TQVjFUvariA2i1Voe5
         s23g==
X-Gm-Message-State: AO0yUKUl5N3M/ucHOetIp1CcmDBxBy6ujKsil3tXYuttb3KA3HS1lbvV
        1LBlgcc7pxeYau4CUpQuOee3bQ==
X-Google-Smtp-Source: AK7set+AzVGstAfdK4z0lHZ07rf0XD9ogpNvaI86WtR3MzF0pWUdM+mcOrZ5j7LF7wQNCocTD+G2iQ==
X-Received: by 2002:a05:6a20:7f8e:b0:c0:b55b:8259 with SMTP id d14-20020a056a207f8e00b000c0b55b8259mr14663046pzj.0.1675979641353;
        Thu, 09 Feb 2023 13:54:01 -0800 (PST)
Received: from dread.disaster.area (pa49-181-4-128.pa.nsw.optusnet.com.au. [49.181.4.128])
        by smtp.gmail.com with ESMTPSA id j16-20020a62e910000000b0058d9a5bac88sm1885080pfh.203.2023.02.09.13.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 13:54:00 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pQEre-00DO2z-CV; Fri, 10 Feb 2023 08:53:58 +1100
Date:   Fri, 10 Feb 2023 08:53:58 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH 1/3] xfs: Remove xfs_filemap_map_pages() wrapper
Message-ID: <20230209215358.GG360264@dread.disaster.area>
References: <20230208145335.307287-1-willy@infradead.org>
 <20230208145335.307287-2-willy@infradead.org>
 <Y+PQN8cLdOXST20D@magnolia>
 <Y+PX5tPyOP2KQqoD@casper.infradead.org>
 <20230208215311.GC360264@dread.disaster.area>
 <Y+ReBH8DFxf+Iab4@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+ReBH8DFxf+Iab4@casper.infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 09, 2023 at 02:44:20AM +0000, Matthew Wilcox wrote:
> On Thu, Feb 09, 2023 at 08:53:11AM +1100, Dave Chinner wrote:
> > > If XFS really needs it,
> > > it can trylock the semaphore and return 0 if it fails, falling back to
> > > the ->fault path.  But I don't think XFS actually needs it.
> > >
> > > The ->map_pages path trylocks the folio, checks the folio->mapping,
> > > checks uptodate, then checks beyond EOF (not relevant to hole punch).
> > > Then it takes the page table lock and puts the page(s) into the page
> > > tables, unlocks the folio and moves on to the next folio.
> > > 
> > > The hole-punch path, like the truncate path, takes the folio lock,
> > > unmaps the folio (which will take the page table lock) and removes
> > > it from the page cache.
> > > 
> > > So what's the race?
> > 
> > Hole punch is a multi-folio operation, so while we are operating on
> > invalidating one folio, another folio in the range we've already
> > invalidated could be instantiated and mapped, leaving mapped
> > up-to-date pages over a range we *require* the page cache to empty.
> 
> Nope.  ->map_pages is defined to _not_ instantiate new pages.
> If there are uptodate pages in the page cache, they can be mapped, but
> missing pages will be skipped, and left to ->fault to bring in.

Sure, but *at the time this change was made* other operations could
instantiate pages whilst an invalidate was running, and then
->map_pages could also find them and map them whilst that
invalidation was still running. i.e. the race conditions that
existed before the mapping->invalidate_lock was introduced (ie. we
couldn't intercept read page faults instantiating pages in the page
cache at all) didn't require ->map_pages to instantiate the page for
it to be able to expose incorrect data to userspace when page faults
raced with an ongoing invalidation operation.

While this may not be able to happen now if everything is using the
mapping->invalidate_lock correctly (because read faults are now
intercepted before they can instatiate new page cache pages), it
doesn't mean it wasn't possible in the past.....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
