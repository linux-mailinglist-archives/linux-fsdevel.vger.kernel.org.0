Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C25503AA8A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jun 2021 03:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbhFQBcw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 21:32:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:37468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231942AbhFQBcw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 21:32:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E114613DE;
        Thu, 17 Jun 2021 01:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1623893444;
        bh=W0OF5R3t53yx4zub1670pkWGrC9nfpb1vIKuqiJaCh4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=w6VhJc4sSRYSgeu7Evu4pcjgqmgza4fFFpEAocIgswoG/i8H03pH+4tUPcm1QA6zY
         TUqV4M4q0XnpDTXsL3EEumxGeqMPeY40D7SQdUVHkuhZrzR3Ztoo0JosUiL+N5YCJW
         wbaJJwVAMhkcLHeBqab6NfnoBqK1quFSsuEycK4s=
Date:   Wed, 16 Jun 2021 18:30:43 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Dave Chinner <david@fromorbit.com>, Roman Gushchin <guro@fb.com>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 4/4] vfs: keep inodes with page cache off the inode
 shrinker LRU
Message-Id: <20210616183043.cdd36c5ca6bee8614c609a90@linux-foundation.org>
In-Reply-To: <YMmD9xhBm9wGqYhf@cmpxchg.org>
References: <20210614211904.14420-1-hannes@cmpxchg.org>
        <20210614211904.14420-4-hannes@cmpxchg.org>
        <20210615062640.GD2419729@dread.disaster.area>
        <YMj2YbqJvVh1busC@cmpxchg.org>
        <20210616012008.GE2419729@dread.disaster.area>
        <YMmD9xhBm9wGqYhf@cmpxchg.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 16 Jun 2021 00:54:15 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:

> On Wed, Jun 16, 2021 at 11:20:08AM +1000, Dave Chinner wrote:
> > On Tue, Jun 15, 2021 at 02:50:09PM -0400, Johannes Weiner wrote:
> > > On Tue, Jun 15, 2021 at 04:26:40PM +1000, Dave Chinner wrote:
> > > > On Mon, Jun 14, 2021 at 05:19:04PM -0400, Johannes Weiner wrote:
> > > > > @@ -1123,6 +1125,9 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
> > > > >  			shadow = workingset_eviction(page, target_memcg);
> > > > >  		__delete_from_page_cache(page, shadow);
> > > > >  		xa_unlock_irq(&mapping->i_pages);
> > > > > +		if (mapping_shrinkable(mapping))
> > > > > +			inode_add_lru(mapping->host);
> > > > > +		spin_unlock(&mapping->host->i_lock);
> > > > >  
> > > > 
> > > > No. Inode locks have absolutely no place serialising core vmscan
> > > > algorithms.
> > > 
> > > What if, and hear me out on this one, core vmscan algorithms change
> > > the state of the inode?
> > 
> > Then the core vmscan algorithm has a layering violation.
> 
> You're just playing a word game here.

Don't think so.  David is quite correct in saying that vmscan shouldn't
mess with inode state unless it's via address_space_operations?

