Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 902121F4262
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jun 2020 19:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbgFIRct (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 13:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726848AbgFIRct (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:32:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D0CC05BD1E;
        Tue,  9 Jun 2020 10:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1CWK56Bk1GHrXr3w3wzon+FcpFohKqu88sAYSOQgEFM=; b=SgB1Sx4bvrGnT6eCMKkEU2oRDe
        aEDNmi4SqOfNTU2RS6Uo9FTIA80ZIRAVjR4R9xmjvj6jF/lYVsaBAIiV8pU/0krzPgXowjGlqkkQC
        z7RcZIIbY4PFTJT5Gm3zIMBvI5uCJ8VFmDwCoyH7hIMR+KJW3u6wjzMKQPHSW/7QXkL9i3bmFrxKv
        wQphVfi3F3EgFov+NqfSD33cizDNsjdBTZanKVDRox1HYJZc4o5BNYVWDpEEwhvZvms3loyYaCwbi
        wwt8+K970BTHWvvaN9z8Syq+/454isZbXPaz5YULTfJtGYA6hu4jjrDiHELsJiYkjkByTF+Q9vbaF
        MkIz44FQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jii6k-0004OT-Be; Tue, 09 Jun 2020 17:32:18 +0000
Date:   Tue, 9 Jun 2020 10:32:18 -0700
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
Message-ID: <20200609173218.GA7968@infradead.org>
References: <20200608170127.20419-1-mcgrof@kernel.org>
 <20200608170127.20419-7-mcgrof@kernel.org>
 <20200609150602.GA7111@infradead.org>
 <20200609172922.GP11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609172922.GP11244@42.do-not-panic.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 09, 2020 at 05:29:22PM +0000, Luis Chamberlain wrote:
> Is scsi-generic is the only unwanted ugly child blktrace has to deal
> with? For some reason I thought drivers/md/md.c was one but it seems
> like it is not. Do we have an easy way to search for these? I think
> this would just affect how we express the comment only.

grep for blk_trace_setup.  For all blk devices that setup comes in
through the block device ioctl path, and that relies on having a
struct block_device and queue.  sg on the other hand calls
blk_trace_setup directly with a NULL bdev argument.

> >  		 */
> > -		dir = q->sg_debugfs_dir;
> > +		dir = debugfs_create_dir(buts->name, blk_debugfs_root);
> > +		bt->dir = dir;
> 
> The other chicken and egg problem to consider at least in the comments
> is that the debugfs directory for these types of devices *have* an
> exposed path, but the data structure is rather opaque to the device and
> even blktrace.  Fortunately given the recent set of changes around the
> q->blk_trace and clarifications around its use we have made it clear now
> that so long as hold the q->blk_trace_mutex *and* check q->blk_trace we
> *should* not race against two separate creations of debugfs directories,
> so I think this is safe, so long as these indpendent drivers don't end
> up re-using the same path for some other things later in the future, and
> since we have control over what goes under debugfsroot block / I think
> we should be good.
> 
> But I think that the concern for race on names may still be worth
> explaining a bit here.

Feel free to add more comments, but please try to keep them short
and crisp.  At the some point long comments really distract from what
is going on.
