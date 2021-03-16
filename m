Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3956433DC8C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 19:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239979AbhCPS1f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 14:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239933AbhCPS1D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 14:27:03 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71610C06174A;
        Tue, 16 Mar 2021 11:27:03 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id kr3-20020a17090b4903b02900c096fc01deso1887888pjb.4;
        Tue, 16 Mar 2021 11:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D8YsQYBoQjPDDMW69OS6mCHbDqccTlAKm8s8N7LlDSk=;
        b=bmyjPih5zqJ7pZpcDaH7m0PIZ9CQebcwZosOmpNmVdTgNKeCj88xdUfEiyglhW/sNl
         jdbXG2f5TbDwQ3WL6aOH3pqusvQtJ6Uz1zKBVw7UwDRjE2dldL78J3HxWcxRoKUvqWwO
         knrJLtWuJThFIuQIEaHCxHxzvq7DaDBUkM4jsyyt7RVm6ehLjZkwstrEVp1rp9F2969S
         Fg10dRN0vN68RO82XUIOfBtHxp0BV9v48y06jReibl6eGayWUwnJCJmygDs6xH9BFJu/
         E9XP+N5EkzKTFaVDuCxz/duW02o/M8hF6gVPqx8NPSMMvaTuAXuL0stX5a2tDron4guq
         zU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=D8YsQYBoQjPDDMW69OS6mCHbDqccTlAKm8s8N7LlDSk=;
        b=Dxf/4rgG3EJjKwZNg3Kqu2K6mKGYoqGnACPe/PODj0QUPUojFSqeiMz/WDRgKHT8My
         eXhlYl0fT0olnoeNuTF8JXBy58ltqAybkwIMOs0MdCVSRcQ6eDOQzk7kLR4XU7WEZ9R2
         506HCshZIuZUCx97EcAIRhlaJhjadyi51L9tojt8+zHvsVH/jV5swErof5UitcRDnjCg
         SCr6NMKHHJL3Hk/RdWLx4rWGlmCuD5or/Ezc7L7UuwT5p6r8itBgdrBbcANF17zE6+tk
         s39ej7aALCqALRxfUSyuRWcTPrMSAwTXZZA15aagGpPRQ+q6LFtY2Rzuyp7Z6t4Z/BXv
         P6cg==
X-Gm-Message-State: AOAM530m9R/IFd6zY8P4qXBRDHiFKm29bGu2XNgq4JGkrSbrwzJxIqax
        W70mZcQqdfq0QEX68+YZv+Y=
X-Google-Smtp-Source: ABdhPJxMeDodEibdMrTXnC8riuuAXLEO++SyWRb9epjcRt7KQF7yuxzfs9IwS+cyCHokDZhwzvUaLw==
X-Received: by 2002:a17:902:7d8d:b029:e6:4061:b767 with SMTP id a13-20020a1709027d8db02900e64061b767mr704232plm.32.1615919222506;
        Tue, 16 Mar 2021 11:27:02 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:4160:1d48:d43e:7513])
        by smtp.gmail.com with ESMTPSA id z1sm17220500pfn.127.2021.03.16.11.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 11:27:01 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 16 Mar 2021 11:26:59 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, joaodias@google.com,
        surenb@google.com, cgoldswo@codeaurora.org, willy@infradead.org,
        mhocko@suse.com, vbabka@suse.cz, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] mm: fs: Invalidate BH LRU during page migration
Message-ID: <YFD4cz6+0U2jgTzH@google.com>
References: <20210310161429.399432-1-minchan@kernel.org>
 <20210310161429.399432-3-minchan@kernel.org>
 <1bdc93e5-e5d4-f166-c467-5b94ac347857@redhat.com>
 <1527f16f-4376-a10d-4e72-041926cf38da@redhat.com>
 <YEuiI44IRjBOQ8Wy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEuiI44IRjBOQ8Wy@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 12, 2021 at 09:17:23AM -0800, Minchan Kim wrote:
> On Fri, Mar 12, 2021 at 10:33:48AM +0100, David Hildenbrand wrote:
> > On 12.03.21 10:03, David Hildenbrand wrote:
> > > On 10.03.21 17:14, Minchan Kim wrote:
> > > > ffer_head LRU caches will be pinned and thus cannot be migrated.
> > > > This can prevent CMA allocations from succeeding, which are often used
> > > > on platforms with co-processors (such as a DSP) that can only use
> > > > physically contiguous memory. It can also prevent memory
> > > > hot-unplugging from succeeding, which involves migrating at least
> > > > MIN_MEMORY_BLOCK_SIZE bytes of memory, which ranges from 8 MiB to 1
> > > > GiB based on the architecture in use.
> > > 
> > > Actually, it's memory_block_size_bytes(), which can be even bigger
> > > (IIRC, 128MiB..2 GiB on x86-64) that fails to get offlined. But that
> > > will prevent bigger granularity (e.g., a whole DIMM) from getting unplugged.
> > > 
> > > > 
> > > > Correspondingly, invalidate the BH LRU caches before a migration
> > > > starts and stop any buffer_head from being cached in the LRU caches,
> > > > until migration has finished.
> > > 
> > > Sounds sane to me.
> > > 
> > 
> > Diving a bit into the code, I am wondering:
> > 
> > 
> > a) Are these buffer head pages marked as movable?
> > 
> > IOW, are they either PageLRU() or __PageMovable()?
> > 
> > 
> > b) How do these pages end up on ZONE_MOVABLE or MIGRATE_CMA?
> > 
> > I assume these pages come via
> > alloc_page_buffers()->alloc_buffer_head()->kmem_cache_zalloc(GFP_NOFS |
> > __GFP_ACCOUNT)
> > 
> 
> It's indirect it was not clear
> 
> try_to_release_page
>     try_to_free_buffers
>         buffer_busy
>             failed
> 
> Yeah, comment is misleading. This one would be better.
> 
>         /*
>          * the refcount of buffer_head in bh_lru prevents dropping the
>          * attached page(i.e., try_to_free_buffers) so it could cause
>          * failing page migrationn.
>          * Skip putting upcoming bh into bh_lru until migration is done.
>          */

Hi Andrew,

Could you fold this comment fix patch? If you prefer formal patch,
let me know. I will resend it.

Thank you.

From 0774f21e2dc8220fc2be80c25f711cb061363519 Mon Sep 17 00:00:00 2001
From: Minchan Kim <minchan@kernel.org>
Date: Fri, 12 Mar 2021 09:17:34 -0800
Subject: [PATCH] comment fix

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 fs/buffer.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index ca9dd736bcb8..8602dcbe0327 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1265,8 +1265,9 @@ static void bh_lru_install(struct buffer_head *bh)
 
 	check_irqs_on();
 	/*
-	 * buffer_head in bh_lru could increase refcount of the page
-	 * until it will be invalidated. It causes page migraion failure.
+	 * the refcount of buffer_head in bh_lru prevents dropping the
+	 * attached page(i.e., try_to_free_buffers) so it could cause
+	 * failing page migratoin.
 	 * Skip putting upcoming bh into bh_lru until migration is done.
 	 */
 	if (lru_cache_disabled())
-- 
2.31.0.rc2.261.g7f71774620-goog

