Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F051AB7C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 08:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436619AbgDPGLV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 02:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2436573AbgDPGLQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 02:11:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA6EC061A0C;
        Wed, 15 Apr 2020 23:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=V1wMHJ2x48pyw+NR7zdN4GOKdt2x+SXrmagOcNfJte4=; b=Mzvh1yHYOTLa3L3LaVPa5JXfPS
        Rf9pgkQMbfyhlhjMqkSjUZVyD+TtqIhOyr9qQc/XoeVGxWHqJWpL4kg8L52u9EK4YgmdL8f1aUPIv
        I222yD1U2T2e0X/oiXB/1infIrckH515ONIedvsmoLFoS9gx28SxhOeKj9d8YaRe/YeX5h0B0gUJi
        xyxehntxUIVxmCX23CATwOPcWuptTLPJBImxRolnY6jZpCtOFqY9JGAJdywGFUmkLk6cFlPhXP+LA
        OVVpENRirSjFP7obaAFks1nWIIh9E5caWZ32HZXLcxPFiY53WGqclwB25hklE9P6LkDkw/1gJ79cq
        +qKexh9A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOxjc-0004DX-QD; Thu, 16 Apr 2020 06:10:48 +0000
Date:   Wed, 15 Apr 2020 23:10:48 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Alan Jenkins <alan.christopher.jenkins@gmail.com>,
        axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org, mhocko@suse.com, yukuai3@huawei.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 4/5] mm/swapfile: refcount block and queue before using
 blkcg_schedule_throttle()
Message-ID: <20200416061048.GA1342@infradead.org>
References: <20200414041902.16769-1-mcgrof@kernel.org>
 <20200414041902.16769-5-mcgrof@kernel.org>
 <20200414154447.GC25765@infradead.org>
 <20200415054234.GQ11244@42.do-not-panic.com>
 <20200415072712.GB21099@infradead.org>
 <20200415073443.GA21036@infradead.org>
 <20200415131915.GV11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415131915.GV11244@42.do-not-panic.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 15, 2020 at 01:19:15PM +0000, Luis Chamberlain wrote:
> >  	if (current->throttle_queue)
> >  		return;
> > +	if (unlikely(current->flags & PF_KTHREAD))
> > +		return;
> >  
> >  	spin_lock(&swap_avail_lock);
> >  	plist_for_each_entry_safe(si, next, &swap_avail_heads[node],
> >  				  avail_lists[node]) {
> > -		if (si->bdev) {
> > -			blkcg_schedule_throttle(bdev_get_queue(si->bdev),
> > -						true);
> > -			break;
> > +		if (!si->bdev)
> > +			continue;
> > +		if (blk_get_queue(dev_get_queue(si->bdev))) {
> > +			current->throttle_queue = dev_get_queue(si->bdev);
> > +			current->use_memdelay = true;
> > +			set_notify_resume(current);
> >  		}
> > +		break;
> >  	}
> >  	spin_unlock(&swap_avail_lock);
> >  }
> 
> Sorry, its not clear to me  who calls the respective blk_put_queue()
> here?

If you look at blkcg_schedule_throttle, it only puts the queue that
was in current->throttle_queue.  But mem_cgroup_throttle_swaprate
exits early when current->throttle_queue is non-zero (first two lines
quote above).  So when called from mem_cgroup_throttle_swaprate,
blkcg_schedule_throttle should never actually put a queue.  Open
coding the few relevant lines from blkcg_schedule_throttle in
mem_cgroup_throttle_swaprate makes that obvious.

