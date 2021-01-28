Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C68307BD9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 18:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbhA1RK3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 12:10:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbhA1RJc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 12:09:32 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9361CC061756;
        Thu, 28 Jan 2021 09:08:52 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id h15so3677477pli.8;
        Thu, 28 Jan 2021 09:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Eo7YqWQBCcFkdPqhZVQNavqepeQ68HEN5jwH3Pe06LY=;
        b=PSXZPV2PGcYCORh03LAExDRm//dtpbmlQdkRnLGm2IHokgcmx/QVBMHljq9G6ugOwp
         8PWkma942L0sD2iGqORCSebADuGEs6zh11Ybm6fYmcxTHwPeIYvcEx2PqmnqIVf6/DVP
         gZ+Im/L6FSpMXdIZAywTMTde+PeRKoHPWMeXO1YKhpb6MP9/hxDXbB648KP/7pZHXoMM
         x/fcs9SZpdnydL09qPO4Q1ioWAhkq/ZEL/Kug/HkEzIMKlfMsDm3OvlA+vP86bTMN3We
         Zj9zq3N74jYJQOUEtsb7BzybJHhFW9H2xWivWv+SVubo0/yR7VlWjcDC9WIWwg/mTJJU
         vybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Eo7YqWQBCcFkdPqhZVQNavqepeQ68HEN5jwH3Pe06LY=;
        b=mx2VF/Npr4ZExK/TUjI22FZfR/8SSR1GphIdhQK73Fh3yPEm9h7ifqOE9o4IFlHWo6
         l07x1dxgUFzLIFZWQf6FZUw435jiFuugX70M6MS/PiUVjxKK7GeBySMnlVjP/TRneDDh
         45jfK9CNMhfJt6dDtjwvJzdiBow94YmXahBbuy5FUkHIn1ZyQWjWdUXVFi9HvEdJbc69
         kEe/l9n7VrMUFrVxv56yuKQX8RJopIrVDYdI9PEKmNOpzF1xMN2cHYNpUX6SwQ5yLcJH
         Gsyron+QqCndiApHiGkqYvqijvI+B6kCwddM1/pvO/n9bQnUDI/BPWKsuPseiwD40tWp
         vRNA==
X-Gm-Message-State: AOAM532NpRJQTPCcXAV8ZXDS8E1gMffVMfQMEya9wc5JlgaTC0QilpQG
        NFatx3E89R15971jyjsbPKnvQT8fO2A=
X-Google-Smtp-Source: ABdhPJz4EpdYvJlBEH+NWTvyfVz9S8QAVVeQdtDe17ipA/RvnjUUbiwi5CKQafnbLQn2vN2XBw98jg==
X-Received: by 2002:a17:90a:f98c:: with SMTP id cq12mr299869pjb.191.1611853732155;
        Thu, 28 Jan 2021 09:08:52 -0800 (PST)
Received: from google.com ([2620:15c:211:201:885b:c20e:b832:f82])
        by smtp.gmail.com with ESMTPSA id x21sm6432373pgi.75.2021.01.28.09.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 09:08:50 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 28 Jan 2021 09:08:48 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Chris Goldsworthy <cgoldswo@codeaurora.org>
Cc:     Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Laura Abbott <lauraa@codeaurora.org>
Subject: Re: [PATCH v4] fs/buffer.c: Revoke LRU when trying to drop buffers
Message-ID: <YBLvoBC1iNmZ7eTD@google.com>
References: <cover.1611642038.git.cgoldswo@codeaurora.org>
 <e8f3e042b902156467a5e978b57c14954213ec59.1611642039.git.cgoldswo@codeaurora.org>
 <YBCexclveGV2KH1G@google.com>
 <20210127025922.GS308988@casper.infradead.org>
 <4d034ea4228be568db62243bfe238e0d@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d034ea4228be568db62243bfe238e0d@codeaurora.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 28, 2021 at 12:28:37AM -0800, Chris Goldsworthy wrote:
> On 2021-01-26 18:59, Matthew Wilcox wrote:
> > On Tue, Jan 26, 2021 at 02:59:17PM -0800, Minchan Kim wrote:
> > > The release buffer_head in LRU is great improvement for migration
> > > point of view.
> > > 
> > > A question:
> 
> Hey guys,
> 
> > > Can't we invalidate(e.g., invalidate_bh_lrus) bh_lru in migrate_prep
> > > or
> > > elsewhere when migration found the failure and is about to retry?
> > > 
> > > Migration has done such a way for other per-cpu stuffs for a long
> > > time,
> > > which would be more consistent with others and might be faster
> > > sometimes
> > > with reducing IPI calls for page.
> > Should lru_add_drain_all() also handle draining the buffer lru for all
> > callers?  A quick survey ...
> > 
> > invalidate_bdev() already calls invalidate_bh_lrus()
> > compact_nodes() would probably benefit from the BH LRU being invalidated
> > POSIX_FADV_DONTNEED would benefit if the underlying filesystem uses BHs
> > check_and_migrate_cma_pages() would benefit
> > khugepaged_do_scan() doesn't need it today
> > scan_get_next_rmap_item() looks like it only works on anon pages (?) so
> > 	doesn't need it
> > mem_cgroup_force_empty() probably needs it
> > mem_cgroup_move_charge() ditto
> > memfd_wait_for_pins() doesn't need it
> > shake_page() might benefit
> > offline_pages() would benefit
> > alloc_contig_range() would benefit
> > 
> > Seems like most would benefit and a few won't care.  I think I'd lean
> > towards having lru_add_drain_all() call invalidate_bh_lrus(), just to
> > simplify things.
> 
> 
> Doing this sounds like a good idea.  We would still need a call to
> invalidate_bh_lrus() inside of drop_buffers() in the event that we find
> busy buffers, since they can be re-added back into the BH LRU - I believe
> it isn't until this point that a BH can't be added back into the BH LRU,
> when we acquire the private_lock for the mapping:
> 
> https://elixir.bootlin.com/linux/v5.10.10/source/fs/buffer.c#L3240

I am not sure it's good deal considering IPI overhead per page release
at worst case.

A idea is to disable bh_lrus in migrate_prep and enable it when
migration is done(need to introduce "migrate_done".
It's similar approach with marking pageblock MIGRATE_ISOLATE to
disable pcp during the migration.
