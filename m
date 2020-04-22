Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2C91B38FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Apr 2020 09:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgDVHaC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Apr 2020 03:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726066AbgDVHaB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Apr 2020 03:30:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6405C03C1A6;
        Wed, 22 Apr 2020 00:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5cVmyOjgumSARbZn4H6K6b40Zl/grVWVzKEi+V2Sn5o=; b=s7u78fW9AIC121y/gwJInXjgts
        xeKqGqc6q2u6w+gdV/7xfa0ndbM09QQqG2q97ouH1DduCn6eSgGCZAExg0On9/O7zBwzQMRUttqol
        QKvRti9jABJjMzc/KsWtpiq0JKcUoiErFDaJ0rnOYKKrtl7SgWXtAI5r/IQ1I1gS4rkjolsUkQXRr
        mJsgvEAM5ePZBELt4pstUI4ppFhBsgITDj1T0sFZkOr0+bMXjoCGmzMgykF0Yekeq+J7UpYDf30bO
        JW4t7/mGmV0NUo3S2RY90apIrLYamJQrS3fJVJskmKcWbQoEGGSuMem0WXYtl9ZEzYOCH+PZArUpd
        nThtTpqg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jR9pG-0000tj-Nu; Wed, 22 Apr 2020 07:29:42 +0000
Date:   Wed, 22 Apr 2020 00:29:42 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, bvanassche@acm.org, rostedt@goodmis.org,
        mingo@redhat.com, jack@suse.cz, ming.lei@redhat.com,
        nstange@suse.de, akpm@linux-foundation.org, mhocko@suse.com,
        yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 03/10] blktrace: fix debugfs use after free
Message-ID: <20200422072942.GD19116@infradead.org>
References: <20200419194529.4872-1-mcgrof@kernel.org>
 <20200419194529.4872-4-mcgrof@kernel.org>
 <20200420201615.GC302402@kroah.com>
 <20200420204156.GO11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420204156.GO11244@42.do-not-panic.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 20, 2020 at 08:41:56PM +0000, Luis Chamberlain wrote:
> Its already there. And yes, after my changes it is technically possible
> to just re-use it directly. But this is complicated by a few things. One
> is that at this point in time, asynchronous request_queue removal is
> still possible, and so a race was exposed where a requeust_queue may be
> lingering but its old device is gone. That race is fixed by reverting us
> back to synchronous request_queue removal, therefore ensuring that the
> debugfs dir exists so long as the device does.
> 
> I can remove the debugfs_lookup() *after* we revert to synchronous
> request_queue removal, or we just re-order the patches so that the
> revert happens first. That should simplify this patch.

Yes, please move the synchronous removal first instead of working around
the current problems.
