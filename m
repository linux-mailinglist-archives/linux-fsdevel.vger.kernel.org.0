Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF0181BDB58
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 14:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgD2MEZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 08:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726554AbgD2MEZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 08:04:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1111FC03C1AD;
        Wed, 29 Apr 2020 05:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=O385uY4zHGIJRbWSoL99UmJmEY6lnZgJqFnu8+7Cu40=; b=CXmhYwSfXlX1ebl+S79JE2NY6q
        XnbTqO+F0IktLJMaZ8QCyjvIaMilP1HM0OlazqM9rA2EOGDQVi6NHpZ9pqFV5Fe6AR+VZEClZ6dZj
        l4Z1seG7fVFOxDf3beKsjJYigCFR3RFYpqlfcuHEKYMp4PT3GN5gz24f14GG8Xqq6ImWpsAfPE6jb
        hP1Li8bNfuQx7/eCptaxMWX3vgnAvo9HzXfUUvQQIwp23DCBWlqYhRnVos739pnxtIoPeZUMnDQIC
        Wb31Bv4cGYfn+WdRK28KbdMYbowLQRS6urnSfU35qXmQcXe+q+w30oN4p8SSj0uysStV5c7WTt9/p
        Jwp7qi5g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTlRf-0000p0-1K; Wed, 29 Apr 2020 12:04:07 +0000
Date:   Wed, 29 Apr 2020 05:04:06 -0700
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
Subject: Re: [PATCH v3 4/6] blktrace: fix debugfs use after free
Message-ID: <20200429120406.GA913@infradead.org>
References: <20200429074627.5955-1-mcgrof@kernel.org>
 <20200429074627.5955-5-mcgrof@kernel.org>
 <20200429112637.GD21892@infradead.org>
 <20200429114542.GJ11244@42.do-not-panic.com>
 <20200429115051.GA27378@infradead.org>
 <20200429120230.GK11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429120230.GK11244@42.do-not-panic.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 29, 2020 at 12:02:30PM +0000, Luis Chamberlain wrote:
> > Err, that function is static and has two callers.
> 
> Yes but that is to make it easier to look for who is creating the
> debugfs_dir for either the request_queue or partition. I'll export
> blk_debugfs_root and we'll open code all this.

No, please not.  exported variables are usually a bad idea.  Just
skip the somewhat pointless trivial static function.
