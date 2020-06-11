Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD0AF1F6153
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jun 2020 07:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgFKFko (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jun 2020 01:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbgFKFkn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jun 2020 01:40:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8F2C08C5C1;
        Wed, 10 Jun 2020 22:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nBcFQJGzJiEbDICiDXoaT+SkntQ3fuvNt0VNHFjSgyk=; b=Ep/0TGcRRFvDTNncjorrzAlS1t
        uBwCTucTGScB5pbbDZx9vslfW9Z0mIzzLY/SsE/G5vx1ZSk99lqNHEtaxjoMOpWaiv8DN8n++AERG
        fdLwww2/st6O6m4Tm0LALmQU/R8ug+VYSRV8nyhBiR1kzFNoVI+1Csc0tRlNXeNy/E7hV08CBjf+C
        rexEqTsiuZitiFCW9wTUQ4bLVl3FrFIX17F5oly+MpJk2iM23f+3TIeWs3mjLR2yQfTBuDBNYZq/J
        bwRHxWR4lAqEz4fiUOCWDPWMhOUKc4nbQNbCQ2QURpZKfQYbLb5hP9IloOIkU/brrMfTCxwYbl5kQ
        lOAbNbag==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jjFwb-0007iI-9y; Thu, 11 Jun 2020 05:40:05 +0000
Date:   Wed, 10 Jun 2020 22:40:05 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        ming.lei@redhat.com, nstange@suse.de, akpm@linux-foundation.org,
        mhocko@suse.com, yukuai3@huawei.com, martin.petersen@oracle.com,
        jejb@linux.ibm.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
Subject: Re: [PATCH v6 6/6] blktrace: fix debugfs use after free
Message-ID: <20200611054005.GA25742@infradead.org>
References: <20200608170127.20419-1-mcgrof@kernel.org>
 <20200608170127.20419-7-mcgrof@kernel.org>
 <20200609150602.GA7111@infradead.org>
 <20200609172922.GP11244@42.do-not-panic.com>
 <20200609173218.GA7968@infradead.org>
 <20200609175359.GR11244@42.do-not-panic.com>
 <20200610064234.GB24975@infradead.org>
 <20200610210917.GH11244@42.do-not-panic.com>
 <20200610215213.GH13911@42.do-not-panic.com>
 <20200610233116.GI13911@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610233116.GI13911@42.do-not-panic.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 10, 2020 at 11:31:16PM +0000, Luis Chamberlain wrote:
> On Wed, Jun 10, 2020 at 09:52:13PM +0000, Luis Chamberlain wrote:
> > diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> > index 7ff2ea5cd05e..5cea04c05e09 100644
> > --- a/kernel/trace/blktrace.c
> > +++ b/kernel/trace/blktrace.c
> > @@ -524,10 +524,16 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
> >  	if (!bt->msg_data)
> >  		goto err;
> >  
> > -	ret = -ENOENT;
> > -
> > -	dir = debugfs_lookup(buts->name, blk_debugfs_root);
> > -	if (!dir)
> > +	/*
> > +	 * When tracing whole make_request drivers (multiqueue) block devices,
> > +	 * reuse the existing debugfs directory created by the block layer on
> > +	 * init. For request-based block devices, all partitions block devices,
> > +	 * and scsi-generic block devices we create a temporary new debugfs
> > +	 * directory that will be removed once the trace ends.
> > +	 */
> > +	if (queue_is_mq(q))
> 
> And this should be instead:
> 
> if (queue_is_mq(q) && bdev && bdev == bdev->bd_contains)

Yes.  But I think keeping the queue_is_mq out and always creating the
debugfs dir is an improvement as we'll sooner or later grow more debugfs
files and than the whole set of problmes reappears.  But I'd be fine
with doing the above in the first patch that is tiny and backportable,
and then have another patch that always creates the debugfs directory.
