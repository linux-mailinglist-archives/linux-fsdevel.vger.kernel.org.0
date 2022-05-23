Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E8D531334
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 May 2022 18:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236989AbiEWOXC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 May 2022 10:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236991AbiEWOXB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 May 2022 10:23:01 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2702C544DE
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 May 2022 07:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RRXoZ9lzbS+a12tLFUttftt+cJsMMxAKV3BhuEP5IqU=; b=sXHtzS+4OFKpDkuv7LQxGIbLar
        UKdRf/+mUuHmKsSJF5p3WFurvDUGHs4LQgDucUssUjN6DKMhvu5HNEVwYopF6270Kivf9D0j77zP6
        3hQT+RHihoYGw5lHRd6c6I1XKgJ6Z0dBsyljI9/F7BVM85s9JaqwtN4KlxEiOhbkON8+9jEU3yP9k
        Z+ybKxxkT6FudJieJRW8KBMJglAsUekh8G8IOhcfeZ1Y2/r+6apBpIafqOtvExmdI+iHnAMbxHtJL
        jtTsJQkkDkpZE7b8cQYmXGG1VjCVhXeVUC0EsazphCYVwctnFsPXHJ6ynta/EfvdnPTxIKBZ2ZwrV
        vLlIaRIw==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nt8xT-00HVW0-CD; Mon, 23 May 2022 14:22:55 +0000
Date:   Mon, 23 May 2022 14:22:55 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] what to do with IOCB_DSYNC?
Message-ID: <YouYvxEl1rF2QO5K@zeniv-ca.linux.org.uk>
References: <41f4fba6-3ab2-32a6-28d9-8c3313e92fa5@kernel.dk>
 <YoqDTV9sa4k9b9nb@zeniv-ca.linux.org.uk>
 <737a889f-93b9-039f-7708-c15a21fbca2a@kernel.dk>
 <YoqJROtrPpXWv948@zeniv-ca.linux.org.uk>
 <1b2cb369-2247-8c10-bd6e-405a8167f795@kernel.dk>
 <YorYeQpW9nBJEeSx@zeniv-ca.linux.org.uk>
 <290daf40-a5f6-01f8-0764-2f4eb96b9d40@kernel.dk>
 <22de2da8-7db0-68c5-2c85-d752a67f9604@kernel.dk>
 <9c3a6ad4-cdb5-8e0d-9b01-c2825ea891ad@kernel.dk>
 <6ea33ba8-c5a3-a1e7-92d2-da8744662ed9@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ea33ba8-c5a3-a1e7-92d2-da8744662ed9@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 22, 2022 at 08:43:26PM -0600, Jens Axboe wrote:

> Branch here:
> 
> https://git.kernel.dk/cgit/linux-block/log/?h=iov-iter
> 
> First 5 are generic ones, and some of them should just be folded with
> your changes.
> 
> Last 2 are just converting io_uring to use it where appropriate.
> 
> We can also use it for vectored readv/writev and recvmsg/sendmsg with
> one segment. The latter is mostly single segment in the real world
> anyway, former probably too. Though not sure it's worth it when we're
> copying a single iovec first anyway? Something to test...

Not a good idea.  Don't assume that all users of iov_iter are well-behaving;
not everything is flavour-agnostic.  If nothing else, you'll break the hell
out of infinibarf - both qib and hfi check that ->write_iter() gets
IOV_ITER target and fail otherwise.

BTW, #work.iov_iter is going to be rebased and reordered; if nothing else,
a bunch of places like
        dio->should_dirty = iter_is_iovec(iter) && iov_iter_rw(iter) == READ;
need to be dealt with before we switch new_sync_read() and new_sync_write()
to ITER_UBUF.

I'm trying to sort out the /dev/fuse breakage at the moment - that thing
expects ITER_IOVEC in ->read_iter() and ->write_iter().  Needs to be dealt
with before new_sync_{read,write}() part, or we'll get bisection hazard...
