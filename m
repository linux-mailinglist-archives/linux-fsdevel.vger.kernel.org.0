Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 224C11AA16B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 14:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S369960AbgDOMkN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 08:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S369948AbgDOMkB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 08:40:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F07DC061A0E;
        Wed, 15 Apr 2020 05:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OpYwUgGG4Pb20qcOBAt9KPUOd70RO1ILur2iFtvmRqE=; b=YkgiKgPbP6RXmASVdUYPElgM1K
        wh7Q9Qd8VUh+tLGVrguFfnCnNMjrl6Gg7XisbTiLxn28tQ9Nafj2cL6wQwMFeWyjTX+6fBCH2TJo0
        THcXpmVieX15bdY2SWWLDhR6NCNnH5TwkEPhKnenSkHvOHUp3JhUvfYyV1M3QbC5zyrFd/ul9mY74
        f2Sp2AUuIVC7GsONZyhaMW7TxPElmmVZolhuNu4HjoL5n9ubLsaNxIouvLtgxg90T5x5trn277hnS
        7RUzKq7oK4xcL1V6VYNqJgl2Fx8/YMwX6FraWQDMSaFx9ApXvXOPDoPfXTIO/NQ33YHpjaI7TJ0NU
        /bwLwcAg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOhK9-0003yq-Tg; Wed, 15 Apr 2020 12:39:25 +0000
Date:   Wed, 15 Apr 2020 05:39:25 -0700
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
Message-ID: <20200415123925.GA14925@infradead.org>
References: <20200414041902.16769-1-mcgrof@kernel.org>
 <20200414041902.16769-4-mcgrof@kernel.org>
 <20200414154044.GB25765@infradead.org>
 <20200415061649.GS11244@42.do-not-panic.com>
 <20200415071425.GA21099@infradead.org>
 <20200415123434.GU11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415123434.GU11244@42.do-not-panic.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 15, 2020 at 12:34:34PM +0000, Luis Chamberlain wrote:
> I'll pile up a fix. I've also considered doing a full review of callers
> outside of the core block layer using it, and maybe just unexporting
> this. It was originally exported due to commit d86e0e83b ("block: export
> blk_{get,put}_queue()") to fix a scsi bug, but I can't find such
> respective fix. I suspec that using bdgrab()/bdput() seems more likely
> what drivers should be using. That would allow us to keep this
> functionality internal.
> 
> Think that's worthy review?

Probably.  I did in fact very quickly look into that but then gave
up due to the fair amount of modular users.
