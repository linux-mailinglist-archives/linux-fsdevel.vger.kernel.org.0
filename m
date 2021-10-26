Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9ED43B140
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 13:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234903AbhJZLb0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 07:31:26 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58976 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbhJZLbZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 07:31:25 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E8AC0218A8;
        Tue, 26 Oct 2021 11:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635247740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1jmbsMYMBnwRLDZZZODInYHlDPDdcNd8+Y3UhCIDNAY=;
        b=l04Ah1inYgpyluUguCEBsLjXBsuLa8C/kDjPsksFKBY/8/Ii5ws62SBB1cGtlGi+S2a/nz
        YhcryyBI1BjKnXDEzAdwpmrLLK3N5/MTcGnCBz+fQLUmZzhBxv0WZiCCxqJXMfaXJJda+4
        Uj+ZSSlzAq1kOhCnw+hzw0rmhqSp80c=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9F783A3B81;
        Tue, 26 Oct 2021 11:29:00 +0000 (UTC)
Date:   Tue, 26 Oct 2021 13:29:00 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     NeilBrown <neilb@suse.de>
Cc:     linux-mm@kvack.org, Dave Chinner <david@fromorbit.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH 2/4] mm/vmalloc: add support for __GFP_NOFAIL
Message-ID: <YXfmfKDYE2P1LTUv@dhcp22.suse.cz>
References: <20211025150223.13621-1-mhocko@kernel.org>
 <20211025150223.13621-3-mhocko@kernel.org>
 <163520277623.16092.15759069160856953654@noble.neil.brown.name>
 <YXeoJbzICpNsEEBr@dhcp22.suse.cz>
 <163524425265.8576.7853645770508739439@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163524425265.8576.7853645770508739439@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 26-10-21 21:30:52, Neil Brown wrote:
> On Tue, 26 Oct 2021, Michal Hocko wrote:
> > On Tue 26-10-21 09:59:36, Neil Brown wrote:
> > > On Tue, 26 Oct 2021, Michal Hocko wrote:
> > [...]
> > > > @@ -3032,6 +3036,10 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
> > > >  		warn_alloc(gfp_mask, NULL,
> > > >  			"vmalloc error: size %lu, vm_struct allocation failed",
> > > >  			real_size);
> > > > +		if (gfp_mask & __GFP_NOFAIL) {
> > > > +			schedule_timeout_uninterruptible(1);
> > > > +			goto again;
> > > > +		}
> > > 
> > > Shouldn't the retry happen *before* the warning?
> > 
> > I've done it after to catch the "depleted or fragmented" vmalloc space.
> > This is not related to the memory available and therefore it won't be
> > handled by the oom killer. The error message shouldn't imply the vmalloc
> > allocation failure IMHO but I am open to suggestions.
> 
> The word "failed" does seem to imply what you don't want it to imply...
> 
> I guess it is reasonable to have this warning, but maybe add " -- retrying"
> if __GFP_NOFAIL.

I do not have a strong opinion on that. I can surely do
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 602649919a9d..3489928fafa2 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3033,10 +3033,11 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 				  VM_UNINITIALIZED | vm_flags, start, end, node,
 				  gfp_mask, caller);
 	if (!area) {
+		bool nofail = gfp_mask & __GFP_NOFAIL;
 		warn_alloc(gfp_mask, NULL,
-			"vmalloc error: size %lu, vm_struct allocation failed",
-			real_size);
-		if (gfp_mask & __GFP_NOFAIL) {
+			"vmalloc error: size %lu, vm_struct allocation failed%s",
+			real_size, (nofail) ? ". Retrying." : "");
+		if (nofail) {
 			schedule_timeout_uninterruptible(1);
 			goto again;
 		}
-- 
Michal Hocko
SUSE Labs
