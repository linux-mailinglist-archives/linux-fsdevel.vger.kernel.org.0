Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D24232D737
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 16:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235912AbhCDP4E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Mar 2021 10:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234366AbhCDPzz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Mar 2021 10:55:55 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3959C061574;
        Thu,  4 Mar 2021 07:55:15 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id e6so19151231pgk.5;
        Thu, 04 Mar 2021 07:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U3iTluQgGyqxe4+jJndhNTExcQnQsciF6nhWB0kk+pw=;
        b=ei+wYitBRmGEEn/UcyXoLKra3hocBkpQN/35lFTbFSvabwNZKmRexsZ9R9hvjzxVSl
         mytwFZSkZJqRySVE/m4MMhASeuhRSKW3HH7+6Zvl0a2c3dyAyCDWsmQKa8v/CYQMNbgY
         KCohb0qYJ+9ruOM3pkm/zoYVonzIgVDu3Ty2ezKU7P7EoCEDFc704qQ+H2eRTsWE4a12
         CkNy2S64lGzcdpt1yNvUPvBFUMD/xPqzzYHRvunH9GR7g7bICR18EamWIgkYCN9uRYFB
         2kVxp7NM0m4s96vpwXXAdKYYvD7Cmb9lPMQNKyczsIAoVzExeF0QLPmAhTnxLjLYTB8r
         bvSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=U3iTluQgGyqxe4+jJndhNTExcQnQsciF6nhWB0kk+pw=;
        b=jGmpS88Ss1Tm2XzzcZfIbC1MyVs0g4Be3S8jl1jrmoiKKMm3152V2CuVWtRnxfJP5W
         1LwiNMzQVFFIh8qz17arMDz89g+OlEly7E8ZfNmxGEB2kSI4Ia7sNviGszYg0hRjV8HL
         uDkTa8r++P47ZwJFrJB5LU14/lmQ/BQYwpWW1oJjV14Vxj1PCy6X/+GkI7LC10S9xrIS
         4MW+Wqkj8EYqcUxGMSmhsJN9+DKDSt3wCrHKz/tddfToat7AkP0Q5xH3qrKZGuKo0Gf5
         MPtor6sue1DVi7avyvvvccKPTKIHr69CRLBx5o+K3Wj5ypxn5IlAJ+V6fR6zpgHb7QqX
         OHxg==
X-Gm-Message-State: AOAM532lwaCz1y9xqsH1GQJfbyF7+F861Ee/wbj1eL3dNN2DFMsEGwoX
        xQUdcgLNSAr9+zmfMmK2gf0=
X-Google-Smtp-Source: ABdhPJz8Xzi+8fVrR6B2TEpOBJ3j4oO00zfVw3RtfA4v1iffBj4R4AC4xnLpAvhDgp6wiUUwBP5pvw==
X-Received: by 2002:a63:e442:: with SMTP id i2mr4094318pgk.12.1614873315168;
        Thu, 04 Mar 2021 07:55:15 -0800 (PST)
Received: from google.com ([2620:15c:211:201:edb1:8010:5c27:a8cc])
        by smtp.gmail.com with ESMTPSA id l3sm28030868pfc.81.2021.03.04.07.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 07:55:14 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 4 Mar 2021 07:55:12 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, joaodias@google.com,
        surenb@google.com, cgoldswo@codeaurora.org, willy@infradead.org,
        vbabka@suse.cz, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: disable LRU pagevec during the migration
 temporarily
Message-ID: <YEEC4EjxKB5+zl6t@google.com>
References: <20210302210949.2440120-1-minchan@kernel.org>
 <YD+F4LgPH0zMBDGW@dhcp22.suse.cz>
 <YD/wOq3lf9I5HK85@google.com>
 <fc76eca3-f986-3980-065f-64c8dc92530a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc76eca3-f986-3980-065f-64c8dc92530a@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 04, 2021 at 09:07:28AM +0100, David Hildenbrand wrote:
> On 03.03.21 21:23, Minchan Kim wrote:
> > On Wed, Mar 03, 2021 at 01:49:36PM +0100, Michal Hocko wrote:
> > > On Tue 02-03-21 13:09:48, Minchan Kim wrote:
> > > > LRU pagevec holds refcount of pages until the pagevec are drained.
> > > > It could prevent migration since the refcount of the page is greater
> > > > than the expection in migration logic. To mitigate the issue,
> > > > callers of migrate_pages drains LRU pagevec via migrate_prep or
> > > > lru_add_drain_all before migrate_pages call.
> > > > 
> > > > However, it's not enough because pages coming into pagevec after the
> > > > draining call still could stay at the pagevec so it could keep
> > > > preventing page migration. Since some callers of migrate_pages have
> > > > retrial logic with LRU draining, the page would migrate at next trail
> > > > but it is still fragile in that it doesn't close the fundamental race
> > > > between upcoming LRU pages into pagvec and migration so the migration
> > > > failure could cause contiguous memory allocation failure in the end.
> > > > 
> > > > To close the race, this patch disables lru caches(i.e, pagevec)
> > > > during ongoing migration until migrate is done.
> > > > 
> > > > Since it's really hard to reproduce, I measured how many times
> > > > migrate_pages retried with force mode below debug code.
> > > > 
> > > > int migrate_pages(struct list_head *from, new_page_t get_new_page,
> > > > 			..
> > > > 			..
> > > > 
> > > > if (rc && reason == MR_CONTIG_RANGE && pass > 2) {
> > > >         printk(KERN_ERR, "pfn 0x%lx reason %d\n", page_to_pfn(page), rc);
> > > >         dump_page(page, "fail to migrate");
> > > > }
> > > > 
> > > > The test was repeating android apps launching with cma allocation
> > > > in background every five seconds. Total cma allocation count was
> > > > about 500 during the testing. With this patch, the dump_page count
> > > > was reduced from 400 to 30.
> > > 
> > > Have you seen any improvement on the CMA allocation success rate?
> > 
> > Unfortunately, the cma alloc failure rate with reasonable margin
> > of error is really hard to reproduce under real workload.
> > That's why I measured the soft metric instead of direct cma fail
> > under real workload(I don't want to make some adhoc artificial
> > benchmark and keep tunes system knobs until it could show
> > extremly exaggerated result to convice patch effect).
> > 
> > Please say if you belive this work is pointless unless there is
> > stable data under reproducible scenario. I am happy to drop it.
> 
> Do you have *some* application that triggers such a high retry count?

I have no idea what the specific appliction could trigger the high
retry count since the LRUs(the VM LRU and buffer_head LRU) are
common place everybody could use and every process could trigger.

> 
> I'd love to run it along with virtio-mem and report the actual allocation
> success rate / necessary retries. That could give an indication of how
> helpful your work would be.

If it could give stable report, that would be very helpful.

> 
> Anything that improves the reliability of alloc_contig_range() is of high
> interest to me. If it doesn't increase the reliability but merely does some
> internal improvements (less retries), it might still be valuable, but not
> that important.

less retrial is good but I'd like to put more effort to close the race
I mentioned completely since the cma allocation failure for our usecases
are critical for user experience.
