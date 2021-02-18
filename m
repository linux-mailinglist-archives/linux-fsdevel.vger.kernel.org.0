Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E2B31ED04
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Feb 2021 18:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbhBRRMs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Feb 2021 12:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbhBRPxR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Feb 2021 10:53:17 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6838FC061756;
        Thu, 18 Feb 2021 07:52:29 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id e9so1734636pjj.0;
        Thu, 18 Feb 2021 07:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=trbbw9gkdkd105IaA7h2JtZJ5hEDJNcNLn2bkNlm+4I=;
        b=SzE6MBiZb5aCdj45XpkSS9tohyDUfNdxO8chVfAf8ilCtUKf6KYwYkUN2cHQs/F476
         kjlsryICuRkiYgiRUs5fKZoJhIJSTRFb66CV12mFr5V8KNwCw+9Z+QX4my2shC8IMLn7
         02TYhaVdUI+OEJtOlvBFY50T7s5jcT2uY2cKXog6TKadvdC5MfevYEP5HW9iR727Vwwp
         d8C3tayt1khUnAq7b4gqilQbHvZfcaTu+OXO/wTEtoZGOz8vo3d8E4gEmHSmOiB7ODIp
         V03IXdBTha9TEdsMRFNa80eKSLOVDGUUFLnLKu+C19lVAgFP3VPzH2RgSXrZ1/DVOLXY
         poWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=trbbw9gkdkd105IaA7h2JtZJ5hEDJNcNLn2bkNlm+4I=;
        b=RzV43YZus5gK5Uh+z1ePsCs1CDo7DYQYInO1LivwWTikccqlNZGmGFDo+gCW+DGpx3
         +DLuIGkyd9WRMD/5QsdUIz/VlAFL3DRw1clo8NEOZqtX3N3GIcTnZ0vHxSCW4Co5cXCH
         KUUSp2OuSw2Pw1fvPSl/3Y6wiF69Z/uSW/sOOwyTLVnklc73oCYb+tp5APSbU9Z6b/SL
         AO+cBi7JQfE8uwZtanSg4zYQSthY9xphrZrDfyn64tBtxPLanKCPWi0QwUTJcSq+4RPn
         Tdvj+d2vDsN9XsvpnLVXu0b7XeD4osGCNCJdhJFz2Wggwqaj98UMTsp0yZ8fVeVBJbIf
         dFfg==
X-Gm-Message-State: AOAM533VdHuQjAwTeXVkTKaiPpFud1YiqErUjqbNSTe2hHOReKL3rHWT
        mXsNNlqntEEV4+piHS4f/kU=
X-Google-Smtp-Source: ABdhPJyd3O6GMj59MJrT2TGhOYJO4n8wZwHwSqWUCOe2jnjaDuLrcfqlkBZW8Xuoyik/vStFt7YAow==
X-Received: by 2002:a17:902:ee46:b029:e3:74e1:24e8 with SMTP id 6-20020a170902ee46b02900e374e124e8mr4639333plo.85.1613663548995;
        Thu, 18 Feb 2021 07:52:28 -0800 (PST)
Received: from google.com ([2620:15c:211:201:157d:8a19:5427:ea9e])
        by smtp.gmail.com with ESMTPSA id y29sm227702pff.81.2021.02.18.07.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 07:52:27 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 18 Feb 2021 07:52:25 -0800
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
Message-ID: <YC6NOVBy5J4bUjfD@google.com>
References: <20210216170348.1513483-1-minchan@kernel.org>
 <YCzbCg3+upAo1Kdj@dhcp22.suse.cz>
 <YC2Am34Fso5Y5SPC@google.com>
 <20210217211612.GO2858050@casper.infradead.org>
 <YC2LVXO6e2NVsBqz@google.com>
 <YC4ifqXYEeWrj4aF@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YC4ifqXYEeWrj4aF@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 18, 2021 at 09:17:02AM +0100, Michal Hocko wrote:
> On Wed 17-02-21 13:32:05, Minchan Kim wrote:
> > On Wed, Feb 17, 2021 at 09:16:12PM +0000, Matthew Wilcox wrote:
> > > On Wed, Feb 17, 2021 at 12:46:19PM -0800, Minchan Kim wrote:
> > > > > I suspect you do not want to add atomic_read inside hot paths, right? Is
> > > > > this really something that we have to microoptimize for? atomic_read is
> > > > > a simple READ_ONCE on many archs.
> > > > 
> > > > It's also spin_lock_irq_save in some arch. If the new synchonization is
> > > > heavily compilcated, atomic would be better for simple start but I thought
> > > > this locking scheme is too simple so no need to add atomic operation in
> > > > readside.
> > > 
> > > What arch uses a spinlock for atomic_read()?  I just had a quick grep and
> > > didn't see any.
> > 
> > Ah, my bad. I was confused with update side.
> > Okay, let's use atomic op to make it simple.
> 
> Thanks. This should make the code much more simple. Before you send
> another version for the review I have another thing to consider. You are
> kind of wiring this into the migration code but control over lru pcp
> caches can be used in other paths as well. Memory offlining would be
> another user. We already disable page allocator pcp caches to prevent
> regular draining. We could do the same with lru pcp caches.

I didn't catch your point here. If memory offlining is interested on
disabling lru pcp, it could call migrate_prep and migrate_finish
like other places. Are you suggesting this one?

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index a969463bdda4..0ec1c13bfe32 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1425,8 +1425,12 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
                node_clear(mtc.nid, nmask);
                if (nodes_empty(nmask))
                        node_set(mtc.nid, nmask);
+
+               migrate_prep();
                ret = migrate_pages(&source, alloc_migration_target, NULL,
                        (unsigned long)&mtc, MIGRATE_SYNC, MR_MEMORY_HOTPLUG);
+
+               migrate_finish();
                if (ret) {
                        list_for_each_entry(page, &source, lru) {
                                pr_warn("migrating pfn %lx failed ret:%d ",

