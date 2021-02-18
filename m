Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C739D31ED10
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Feb 2021 18:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbhBRRNr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Feb 2021 12:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233274AbhBRQWh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Feb 2021 11:22:37 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05354C0613D6;
        Thu, 18 Feb 2021 08:21:56 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id e9so1794093pjj.0;
        Thu, 18 Feb 2021 08:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7vviwcmISf9SauaMuvs/shrly/ZIB570cD7CHEN4n8M=;
        b=aee4RfHC3S11MQQnocAxac6OvJxnqTUJpJs6OeBXqnvBK7VUpL3Rq16ldY2nn4n7Mm
         Qdqf6nGxbqEbQdiMAY7X0nsfgi/8/O7Osio/lFdO2BdTpVvx/ILfACQpZf59JSfEK8/H
         aS+i5uAZM/UTzYRHFcUaJI6owz3dZBSCmdFwy2INXL1GtDtHyebkQ4Hph66cUvFQGBfA
         lerhWNQ/XXlU1Y5hdXQIVa/iZLTaETmlghxAFW4Wh6RmbtgkI4wETNGD3E/iDmVSBa3j
         z5z9zpGAoAbpuCyDlvWyM0QYJzQRYgwh6AN1+goDsZ5ESYNUh+yfM+pRXPB0tWkLZzO3
         8UHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=7vviwcmISf9SauaMuvs/shrly/ZIB570cD7CHEN4n8M=;
        b=p9AcU+pDfnlcXPrBeZZdrdpoWtz9kSIKXFp8Q2dBht7IMDduIKZyZJ2S7qCoEnE/KZ
         2s7BbLiQzzCvyIvVkfQzaMunFPM8C68d2bpmNhhSPrcoEZA68p9xHBhTV/AIv5DjP9Ph
         6ZvetPY1/GUbt0afnXvQCKGYa+YsufIy0Pc+bHTDz2zbFq3zm+kgFPRhBZIPU0yH0squ
         6Ge5xcMcG0BDqjgywGYKmAfZFjrxzuQXeEjCMy44vc6dDTXLiIm8VlXxnQ0IDtA6b2kN
         V+IUmj4JMLkJmThHN0UxkZZbWg1UGDsb1VYoWGJTMV1l+ZnSxSDmTbq/+6U17BONPISb
         HHHg==
X-Gm-Message-State: AOAM533AtQHLWC5qc6WQC4Asujt0hRqs2lKyaCveTRgn6UOCBuwkFA+g
        MRu64omAmkSYFCkO+JUsFig=
X-Google-Smtp-Source: ABdhPJxrM9/dyqY4UwBfRlHLEX1b7TPs6emR6tomMd97RsPWpc+hpGIzJXcYC88DpB8T88emHCtCzg==
X-Received: by 2002:a17:902:6bca:b029:e2:c5d6:973e with SMTP id m10-20020a1709026bcab02900e2c5d6973emr4655370plt.40.1613665315616;
        Thu, 18 Feb 2021 08:21:55 -0800 (PST)
Received: from google.com ([2620:15c:211:201:157d:8a19:5427:ea9e])
        by smtp.gmail.com with ESMTPSA id x17sm6727848pfq.132.2021.02.18.08.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 08:21:54 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 18 Feb 2021 08:21:52 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, cgoldswo@codeaurora.org,
        linux-fsdevel@vger.kernel.org, david@redhat.com, vbabka@suse.cz,
        viro@zeniv.linux.org.uk, joaodias@google.com
Subject: Re: [RFC 1/2] mm: disable LRU pagevec during the migration
 temporarily
Message-ID: <YC6UIEqNyPdRpmiq@google.com>
References: <20210216170348.1513483-1-minchan@kernel.org>
 <YCzbCg3+upAo1Kdj@dhcp22.suse.cz>
 <YC2Am34Fso5Y5SPC@google.com>
 <20210217211612.GO2858050@casper.infradead.org>
 <YC2LVXO6e2NVsBqz@google.com>
 <YC4ifqXYEeWrj4aF@dhcp22.suse.cz>
 <YC6NOVBy5J4bUjfD@google.com>
 <YC6RGiemaQHQScsZ@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YC6RGiemaQHQScsZ@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 18, 2021 at 05:08:58PM +0100, Michal Hocko wrote:
> On Thu 18-02-21 07:52:25, Minchan Kim wrote:
> > On Thu, Feb 18, 2021 at 09:17:02AM +0100, Michal Hocko wrote:
> > > On Wed 17-02-21 13:32:05, Minchan Kim wrote:
> > > > On Wed, Feb 17, 2021 at 09:16:12PM +0000, Matthew Wilcox wrote:
> > > > > On Wed, Feb 17, 2021 at 12:46:19PM -0800, Minchan Kim wrote:
> > > > > > > I suspect you do not want to add atomic_read inside hot paths, right? Is
> > > > > > > this really something that we have to microoptimize for? atomic_read is
> > > > > > > a simple READ_ONCE on many archs.
> > > > > > 
> > > > > > It's also spin_lock_irq_save in some arch. If the new synchonization is
> > > > > > heavily compilcated, atomic would be better for simple start but I thought
> > > > > > this locking scheme is too simple so no need to add atomic operation in
> > > > > > readside.
> > > > > 
> > > > > What arch uses a spinlock for atomic_read()?  I just had a quick grep and
> > > > > didn't see any.
> > > > 
> > > > Ah, my bad. I was confused with update side.
> > > > Okay, let's use atomic op to make it simple.
> > > 
> > > Thanks. This should make the code much more simple. Before you send
> > > another version for the review I have another thing to consider. You are
> > > kind of wiring this into the migration code but control over lru pcp
> > > caches can be used in other paths as well. Memory offlining would be
> > > another user. We already disable page allocator pcp caches to prevent
> > > regular draining. We could do the same with lru pcp caches.
> > 
> > I didn't catch your point here. If memory offlining is interested on
> > disabling lru pcp, it could call migrate_prep and migrate_finish
> > like other places. Are you suggesting this one?
> 
> What I meant to say is that you can have a look at this not as an
> integral part of the migration code but rather a common functionality
> that migration and others can use. So instead of an implicit part of
> migrate_prep this would become disable_lru_cache and migrate_finish
> would become lruc_cache_enable. See my point? 
> 
> An advantage of that would be that this would match the pcp page
> allocator disabling and we could have it in place for the whole
> operation to make the page state more stable wrt. LRU state (PageLRU).

Understood. Thanks for the clarification.
