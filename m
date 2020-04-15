Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72E411A9454
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 09:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635163AbgDOHff (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 03:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2635160AbgDOHfP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 03:35:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A477DC061A0C;
        Wed, 15 Apr 2020 00:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Spel49OH3kq+f0h1cQE64vdlWjbJubQE7iWfCRxff4E=; b=gAg7IFfDoCtoS3lw9q5kB7iF3u
        8et/F09oG1/mSQ6pPTclzNQTE0cp8m3Op/n5PXekX9gKp8drR/EOoquZq8CxWmZf7V7Jf3DzEuR2i
        n/Pjcy9rylY/B9Pzm6lE+HeVM9aA70RBJaPI+Xh2WHG9ltoFE5PE9tiI0ca7GPILuSYolnYEXemrM
        HbJ2xOXJO++cxn7bICbx6AmSvGj3DcBvix1wjr9CZOTy6K4xGYnKxxEVDZjnVk9utgN+ON8fztiIR
        dt2c/xCo4N9YwqeWs6P00Lb0FTUAwdUIr5EoB8A3LR1ocdCwEm2Gg3yAOmjFRmx11RaYsO0uBbVWk
        LaUyIZgQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOcZH-0000l3-Ho; Wed, 15 Apr 2020 07:34:43 +0000
Date:   Wed, 15 Apr 2020 00:34:43 -0700
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
Message-ID: <20200415073443.GA21036@infradead.org>
References: <20200414041902.16769-1-mcgrof@kernel.org>
 <20200414041902.16769-5-mcgrof@kernel.org>
 <20200414154447.GC25765@infradead.org>
 <20200415054234.GQ11244@42.do-not-panic.com>
 <20200415072712.GB21099@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415072712.GB21099@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 15, 2020 at 12:27:12AM -0700, Christoph Hellwig wrote:
> On Wed, Apr 15, 2020 at 05:42:34AM +0000, Luis Chamberlain wrote:
> > > I don't understand the atomic part of the comment.  How does
> > > bdgrab/bdput help us there?
> > 
> > The commit log above did a better job at explaining this in terms of our
> > goal to use the request_queue and how this use would prevent the risk of
> > releasing the request_queue, which could sleep.
> 
> So bdput eventually does and iput, but what leads to an out of context
> offload?
> 
> But anyway, isn't the original problem better solved by simply not
> releasing the queue from atomic context to start with?  There isn't
> really any good reason we keep holding the spinlock once we have a
> reference on the queue, so something like this (not even compile tested)
> should do the work:

Actually - mem_cgroup_throttle_swaprate already checks for a non-NULL
current->throttle_queue above, so we should never even call
blk_put_queue here.  Was this found by code inspection, or was there
a real report?

In the latter case we need to figure out what protects >throttle_queue,
as the way blkcg_schedule_throttle first put the reference and only then
assign a value to it already looks like it introduces a tiny race
window.

Otherwise just open coding the applicable part ofblkcg_schedule_throttle
in mem_cgroup_throttle_swaprate seems easiest:

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 5871a2aa86a5..e16051ef074c 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3761,15 +3761,20 @@ void mem_cgroup_throttle_swaprate(struct mem_cgroup *memcg, int node,
 	 */
 	if (current->throttle_queue)
 		return;
+	if (unlikely(current->flags & PF_KTHREAD))
+		return;
 
 	spin_lock(&swap_avail_lock);
 	plist_for_each_entry_safe(si, next, &swap_avail_heads[node],
 				  avail_lists[node]) {
-		if (si->bdev) {
-			blkcg_schedule_throttle(bdev_get_queue(si->bdev),
-						true);
-			break;
+		if (!si->bdev)
+			continue;
+		if (blk_get_queue(dev_get_queue(si->bdev))) {
+			current->throttle_queue = dev_get_queue(si->bdev);
+			current->use_memdelay = true;
+			set_notify_resume(current);
 		}
+		break;
 	}
 	spin_unlock(&swap_avail_lock);
 }
