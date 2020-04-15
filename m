Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 529731A9391
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 08:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635041AbgDOGrf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 02:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2634963AbgDOGr1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 02:47:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EECFC061A0C;
        Tue, 14 Apr 2020 23:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2gmDYLi4/Kmt66vaVwEAhPniYnGKhZzhEZo2/uC5wIA=; b=K9+bRfkIbjPRAj6/hm1WXdcGYq
        RKI3+ySEt4A6WXG3J1GKfCgXt06KUGaBEvkJIq+Ie1IZuw2l9X2O6i4sieH18zY4z3skuFesVclAN
        BzDFLAlYhdBM4ie6U2u3ELSTPd/eCBvy+OjM7KO7k4qcRkz7xTxNN6JrW15dsWYFQSdozekpJTamE
        y1JskYiFntJpdpNo7Vr8fxBfqhHY62ENK3TN1b/rFEAEXkNUniJITN6C4B88EMz0k45doOCEKueRC
        XkVe8IHDFCyGId329J0iVUv8TlpM2rz884iyI4vRivowvIeJw6pDmZO55b9WOc1/ewo+lyxeh1CPb
        DB4NnBhg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOboq-00041j-2i; Wed, 15 Apr 2020 06:46:44 +0000
Date:   Tue, 14 Apr 2020 23:46:44 -0700
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
Subject: Re: [PATCH 5/5] block: revert back to synchronous request_queue
 removal
Message-ID: <20200415064644.GA28112@infradead.org>
References: <20200414041902.16769-1-mcgrof@kernel.org>
 <20200414041902.16769-6-mcgrof@kernel.org>
 <20200414154725.GD25765@infradead.org>
 <20200414205852.GP11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414205852.GP11244@42.do-not-panic.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 14, 2020 at 08:58:52PM +0000, Luis Chamberlain wrote:
> > I think this needs a WARN_ON thrown in to enforece the calling context.
> 
> I considered adding a might_sleep() but upon review with Bart, he noted
> that this function already has a mutex_lock(), and if you look under the
> hood of mutex_lock(), it has a might_sleep() at the very top. The
> warning then is implicit.

It might just be a personal preference, but I think the documentation
value of a WARN_ON_ONCE or might_sleep with a comment at the top of
the function is much higher than a blurb in a long kerneldoc text and
a later mutex_lock.
