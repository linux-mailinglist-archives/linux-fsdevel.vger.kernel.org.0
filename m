Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8A7D2EEFC1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jan 2021 10:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbhAHJhE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jan 2021 04:37:04 -0500
Received: from verein.lst.de ([213.95.11.211]:43255 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727294AbhAHJhE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jan 2021 04:37:04 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id BE02E67373; Fri,  8 Jan 2021 10:36:21 +0100 (CET)
Date:   Fri, 8 Jan 2021 10:36:21 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Satya Tangirala <satyat@google.com>
Cc:     Bob Peterson <rpeterso@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] fs: Fix freeze_bdev()/thaw_bdev() accounting of
 bd_fsfreeze_sb
Message-ID: <20210108093621.GA3788@lst.de>
References: <20201224044954.1349459-1-satyat@google.com> <20210107162000.GA2693@lst.de> <1137375419.42956970.1610036857271.JavaMail.zimbra@redhat.com> <X/eUd4iLxnl2nYRF@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/eUd4iLxnl2nYRF@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 07, 2021 at 11:08:39PM +0000, Satya Tangirala wrote:
> >  		error = sb->s_op->freeze_super(sb);
> >  	else
> > @@ -600,6 +602,7 @@ int thaw_bdev(struct block_device *bdev)
> >  	if (!sb)
> >  		goto out;
> >  
> > +	bdev->bd_fsfreeze_sb = NULL;
> This causes bdev->bd_fsfreeze_sb to be set to NULL even if the call to
> thaw_super right after this line fail. So if a caller tries to call
> thaw_bdev() again after receiving such an error, that next call won't even
> try to call thaw_super(). Is that what we want here?  (I don't know much
> about this code, but from a cursory glance I think this difference is
> visible to emergency_thaw_bdev() in fs/buffer.c)

Yes, that definitively is an issue.

> 
> I think the second difference (decrementing bd_fsfreeze_count when
> get_active_super() returns NULL) doesn't change anything w.r.t the
> use-after-free. It does however, change the behaviour of the function
> slightly, and it might be caller visible (because from a cursory glance, it
> looks like we're reading the bd_fsfreeze_count from some other places like
> fs/super.c). Even before 040f04bd2e82, the code wouldn't decrement
> bd_fsfreeze_count when get_active_super() returned NULL - so is this change
> in behaviour intentional? And if so, maybe it should go in a separate
> patch?

Yes, that would be a change in behavior.  And I'm not sure why we would
want to change it.  But if so we should do it in a separate patch that
documents the why, on top of the patch that already is in the block tree.
