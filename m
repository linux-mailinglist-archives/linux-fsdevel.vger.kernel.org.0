Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6824B251F29
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Aug 2020 20:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgHYSlU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Aug 2020 14:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbgHYSlT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Aug 2020 14:41:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4073BC061574;
        Tue, 25 Aug 2020 11:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=v1o5EjwkeGZhMaYJqq7UjDrf/EQeIGnJO5LmpUpDa7I=; b=RlPZ7hKAVwzbotlvImDEtjyRuk
        cybL1i9Ml7SuONIIVQ5eP2y+dONtc9FmV8j5N5aEXjGNjyzy/+/rYg+iLzLrJmJytbXpUq5QiDNBu
        VGU1UzQJsME1WjHE1P1NhgWkmp5X9dTh+w0k033+GxIMo/D8/X5hgxTM1dwmOuhnYAqE/TMn3xgyk
        lo+N3FChYJ6c3oNJuJQMatqJrl+MV8kJyOtH5r0G8y/Yk9rUZPu+ZmNM+vh0lcijSyX1Xca1uZB8Y
        vJpg300AJH9MYi9QcDWs5Ii3/0gU5aJ1xnA5jirY18XIZ+P+BNiINhco9NI80p50PIc0qIekheApU
        PdQIacoQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kAdsZ-00029p-Nl; Tue, 25 Aug 2020 18:41:07 +0000
Date:   Tue, 25 Aug 2020 19:41:07 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, yebin <yebin10@huawei.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH RFC 2/2] block: Do not discard buffers under a mounted
 filesystem
Message-ID: <20200825184107.GP17456@casper.infradead.org>
References: <20200825120554.13070-1-jack@suse.cz>
 <20200825120554.13070-3-jack@suse.cz>
 <20200825121616.GA10294@infradead.org>
 <20200825141020.GA668551@mit.edu>
 <20200825151256.GD32298@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825151256.GD32298@quack2.suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 25, 2020 at 05:12:56PM +0200, Jan Kara wrote:
> On Tue 25-08-20 10:10:20, Theodore Y. Ts'o wrote:
> > (Adding the OCFS2 maintainers, since my possibly insane idea proposed
> > below would definitely impact them!)
> > 
> > On Tue, Aug 25, 2020 at 01:16:16PM +0100, Christoph Hellwig wrote:
> > > On Tue, Aug 25, 2020 at 02:05:54PM +0200, Jan Kara wrote:
> > > > Discarding blocks and buffers under a mounted filesystem is hardly
> > > > anything admin wants to do. Usually it will confuse the filesystem and
> > > > sometimes the loss of buffer_head state (including b_private field) can
> > > > even cause crashes like:
> > > 
> > > Doesn't work if the file system uses multiple devices.  I think we
> > > just really need to split the fs buffer_head address space from the
> > > block device one.  Everything else is just going to cause a huge mess.
> > 
> > I wonder if we should go a step further, and stop using struct
> > buffer_head altogether in jbd2 and ext4 (as well as ocfs2).
> 
> What about the cache coherency issues I've pointed out in my reply to
> Christoph?

If journal_heads pointed into the page cache as well, then you'd get
coherency.  These new journal heads would have to be able to cope with
the page cache being modified underneath them, of course.

