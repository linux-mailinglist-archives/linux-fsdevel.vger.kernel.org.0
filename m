Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA0771A93E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 09:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441112AbgDOHPB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 03:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390559AbgDOHO6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 03:14:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E15C061A0C;
        Wed, 15 Apr 2020 00:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JzUzg/mW68+ufFV5qcTuM5sEEYmvYc+6RGs1lG03lg0=; b=FmMuX+JibdIFYgAXEY1r2PHZfA
        B6B5zj7G5Q0xig3P+EqdOp9okOT/6pUfs/hJ6jp3mokJUa2kVkgxvL0o268Dmm//QdY3sCehn9W/M
        8LBFnKP6FW+f4rCqJG2SKKOW4szpZ30CA8uej5/nzN9v4V8w1eMM78y7m5L1w0jwgoVaMQaGE+PIA
        mc5Xhco0YqAsDEootkgKFBn8fqXCExSnuOm+EFhD0RGpSTbBaXunYLtrlVqd6nSEPpnIsaxcgCNP1
        nyLiRlxsxPNphoVRfgE/zZY6hPfr9yvrzGiWBcrqSxNt7F4sXyMllwf8EIYvlgdEtNmnFLJN4JVvC
        RLvFKpzw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOcFd-0004Uk-AU; Wed, 15 Apr 2020 07:14:25 +0000
Date:   Wed, 15 Apr 2020 00:14:25 -0700
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
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 3/5] blktrace: refcount the request_queue during ioctl
Message-ID: <20200415071425.GA21099@infradead.org>
References: <20200414041902.16769-1-mcgrof@kernel.org>
 <20200414041902.16769-4-mcgrof@kernel.org>
 <20200414154044.GB25765@infradead.org>
 <20200415061649.GS11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415061649.GS11244@42.do-not-panic.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 15, 2020 at 06:16:49AM +0000, Luis Chamberlain wrote:
> The BLKTRACESETUP above works on request_queue which later
> LOOP_CTL_DEL races on and sweeps the debugfs dir underneath us.
> If you use this commit alone though, this doesn't fix the race issue
> however, and that's because of both still the debugfs_lookup() use
> and that we're still using asynchronous removal at this point.
> 
> refcounting will just ensure we don't take the request_queue underneath
> our noses.
> 
> Should I just add this to the commit log?

That sounds much more useful than the trace.

Btw, Isn't blk_get_queue racy as well?  Shouldn't we check
blk_queue_dying after getting the reference and undo it if the queue is
indeeed dying?
