Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6CAC1F5878
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 17:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730446AbgFJP6n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 11:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728217AbgFJP6m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 11:58:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A811EC03E96B
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2020 08:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QQ5a1Bdi0Ay1Qo4+NGaTgq+k6u7PgiEhAy8MlJFR2Fk=; b=PSwQ4njn1EILUJdQ+MRQolDTVo
        mgYgkl0/r5wvycxoFl1oTN6020KSVJz7VnrNgpBuuPqDdkJp+6T43icjOQ37hYH6G2in+q28gfMbJ
        M2hqUwkRs/lx8mr1W8VL9OkUIJj/7x5/aHs2/ppiBLjrFj8MKSiHECf4eWNIKdEvsncwQYGhIHyVd
        cidAtOEf9L0xyZTnB72C/tiNVdHaeQndgj5CDEiaBMedivJsuBv5BZ4ScOddrYR7YtJdDA6mHy1n1
        31iyu6ucrhFlfL0dSU+kOi+QaPMeEpdef/ILJ1SUDvfejj3tYmGc4p0PXXglJJi+ePTw7Gt0V1MlX
        FYoBmSjA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jj37i-0005Fy-4J; Wed, 10 Jun 2020 15:58:42 +0000
Date:   Wed, 10 Jun 2020 08:58:42 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, Ted Tso <tytso@mit.edu>,
        Martijn Coenen <maco@android.com>, tj@kernel.org
Subject: Re: [PATCH 2/3] writeback: Fix sync livelock due to b_dirty_time
 processing
Message-ID: <20200610155842.GA20113@infradead.org>
References: <20200601091202.31302-1-jack@suse.cz>
 <20200601091904.4786-2-jack@suse.cz>
 <20200610150614.GB21733@infradead.org>
 <20200610155456.GB20677@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610155456.GB20677@quack2.suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 10, 2020 at 05:54:56PM +0200, Jan Kara wrote:
> On Wed 10-06-20 08:06:14, Christoph Hellwig wrote:
> > On Mon, Jun 01, 2020 at 11:18:56AM +0200, Jan Kara wrote:
> > > When we are processing writeback for sync(2), move_expired_inodes()
> > > didn't set any inode expiry value (older_than_this). This can result in
> > > writeback never completing if there's steady stream of inodes added to
> > > b_dirty_time list as writeback rechecks dirty lists after each writeback
> > > round whether there's more work to be done. Fix the problem by using
> > > sync(2) start time is inode expiry value when processing b_dirty_time
> > > list similarly as for ordinarily dirtied inodes. This requires some
> > > refactoring of older_than_this handling which simplifies the code
> > > noticeably as a bonus.
> > 
> > Looks sane, but if you touch all the older_than_this users can we
> > rename it to something more reasonable like oldest or oldest_jif?
> 
> OK, I can certainly rename this. I've just realized that 'oldest' is really
> misleading since we are in fact processing inodes that were dirtied before
> the given time. So maybe name that 'dirtied_before'?

Sounds good to me.
