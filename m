Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 103FF1B39B5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Apr 2020 10:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgDVIKn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Apr 2020 04:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725842AbgDVIKn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Apr 2020 04:10:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBDBC03C1A6;
        Wed, 22 Apr 2020 01:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=67WpxxlCgmhP33pDM7+RRLK1Dw/Wlqp6Mzgtcg8F0+s=; b=CtPbMAnP7cpzodaISmc1Wdoj00
        2ojUWAmmpSmN1TFTleYUebzjMSwlh8pw1C4LDZAM7BI/5vd44YDklxmJGVq33vu9939PUzqZyCvSM
        d3oLyz2n+XFctDKmW2cRhZnPLLmeIRyCo9PbvCS2f5JSPTkzIYZ/GAsz2B9DPfMLMESpafZ3A37dM
        kuhv7SZXlnMBRrRAvj+1fOi1E/OR1UPt1f9i9rVjYc68381u9Azn83v/CsMlUFKvIlL4c6lkbXozV
        5szWgtf/8d4UdKL5e1bw8b/kuiQgqNaz/6uGaAr1YIWwxEHuLfgoct85LnxSNG7vuO/HwE5XvTsQe
        ydyoqRfQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRASR-000054-Eh; Wed, 22 Apr 2020 08:10:11 +0000
Date:   Wed, 22 Apr 2020 01:10:11 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org, mhocko@suse.com, yukuai3@huawei.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 03/10] blktrace: fix debugfs use after free
Message-ID: <20200422081011.GA22409@infradead.org>
References: <20200419194529.4872-1-mcgrof@kernel.org>
 <20200419194529.4872-4-mcgrof@kernel.org>
 <20200422072715.GC19116@infradead.org>
 <20200422074802.GS11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422074802.GS11244@42.do-not-panic.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 22, 2020 at 07:48:02AM +0000, Luis Chamberlain wrote:
> > I don't see why we need this check.  If it is valueable enough we
> > should have a debugfs_create_dir_exclusive or so that retunrns an error
> > for an exsting directory, instead of reimplementing it in the caller in
> > a racy way.  But I'm not really sure we need it to start with.
> 
> In short races, and even with synchronous request_queue removal I'm
> seeing the race is still possible, but that's due to some other races
> I'm going to chase down now.
> 
> The easier solution really is to just have a debugfs dir created for
> each partition if debugfs is enabled, this way the directory will
> always be there, and the lookups are gone.

That sounds like the best plan to me.

> 
> > > +
> > > +	q->debugfs_dir = debugfs_create_dir(kobject_name(q->kobj.parent),
> > > +					    blk_debugfs_root);
> > > +	if (!q->debugfs_dir)
> > > +		return -ENOMEM;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +void blk_queue_debugfs_unregister(struct request_queue *q)
> > > +{
> > > +	debugfs_remove_recursive(q->debugfs_dir);
> > > +	q->debugfs_dir = NULL;
> > > +}
> > 
> > Which to me suggests we can just fold these two into the callers,
> > with an IS_ENABLED for the creation case given that we check for errors
> > and the stub will always return an error.
> 
> Sorry not sure I follow this.

Don't both with the two above functions and just open code them in
the callers.  IFF you still want to check for errors after the
discussion with Greg, wrap the call in a

	if (IS_ENABLED(CONFIG_DEBUG_FS))

to ensure that you don't fail queue creation in the !DEBUG_FS
case.
