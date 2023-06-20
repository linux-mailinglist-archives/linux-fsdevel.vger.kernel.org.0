Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BA0736AEE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jun 2023 13:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbjFTL36 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 07:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjFTL35 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 07:29:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B395DFE;
        Tue, 20 Jun 2023 04:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UKyYq6BGI39qHhF54xUygHPomuDqkxU7QRjFYmovbx4=; b=W1Jc02jkF0C3QoO2PnI6v5v1JO
        OhhgE+axnAn29hvFgiuVzAQ0n1r8yyQNnk4RFyxJHRHqh1lI/dAet6cDsU/hZ61h0fooilWFVYcXd
        GchWarvyAtByVmBemboRBS/9Rqjyd6FvP60DGEacPpTUyD6xfuITc9ljdgNLPbthaYdKTerxPbzYy
        vcLzjAzEAAqD8meSqR/eeOYczecDiqm8vBlq/pi1Bi2oCi9mRsLK/0hDtNGmtOAGflAVeSHen2uGc
        uHn0+GMSSLWkv+xtXVSiEBc4PuUl1lvk//8uyVTckBK6FZtbXvo51jmRF8cKiB5KKOn1Ba2F1yv+L
        LyMt4R2A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qBZYX-00B7u9-1X;
        Tue, 20 Jun 2023 11:29:53 +0000
Date:   Tue, 20 Jun 2023 04:29:53 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>, Ted Tso <tytso@mit.edu>,
        yebin <yebin@huaweicloud.com>, linux-fsdevel@vger.kernel.org,
        Kees Cook <keescook@google.com>,
        Alexander Popov <alex.popov@linux.com>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH] block: Add config option to not allow writing to mounted
 devices
Message-ID: <ZJGNsVDhZx0Xgs2H@infradead.org>
References: <20230612161614.10302-1-jack@suse.cz>
 <ZIf6RrbeyZVXBRhm@infradead.org>
 <20230613205614.atlrwst55bpqjzxf@quack3>
 <ZIlqLJ6dFs1P4aj7@infradead.org>
 <20230620104111.pnjoouegp2dx6pcp@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620104111.pnjoouegp2dx6pcp@quack3>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 20, 2023 at 12:41:11PM +0200, Jan Kara wrote:
> I can see several solutions but since you've just reworked the code and I'm
> not 100% certain about the motivation, I figured I'll ask you first before
> spending significant time on something you won't like:
> 
> 1) Just return the mode argument to blkdev_put().
> 
> 2) Only pass to blkdev_put() whether we have write access or not as a
> separate argument.
> 
> 3) Don't track number of opens for writing, instead check whether writes
> are blocked on each write access. I think this has a number of downsides
> but I mention it for completeness. One problem is we have to add checks to
> multiple places (buffered IO, direct IO) and existing mmap in particular
> will be very hard to deal with (need to add page_mkwrite() handler). All
> these checks add performance overhead. It is practically impossible
> (without significant performance overhead or new percpu datastructures) to
> properly synchronize open that wants to block writers against already
> running writes.

I think 3 is out for the reasons you mention.  2 feels a bit ugly,
but so does 1 given that we only really need the write flag.  One thing
I through about earlier but decided was overkill at that time is to
return a cookie from blkdev_get_* that needs to be passed back to
blkdev_put.  That could either be opaque to the caller, or replace the
bdev ala:

struct bdev_handle {
	struct block_device *bdev;
	void *holder;
	bool for_write;
};

Given that fixups we needed to pass the right holder back in, it feels
like that would be the least error prone API, even if it is a fair
amount of churn.

