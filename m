Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73F372E7CB7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Dec 2020 22:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgL3Vhc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Dec 2020 16:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgL3Vhb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Dec 2020 16:37:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B99C061573;
        Wed, 30 Dec 2020 13:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=x5hbWwksukb8/0wEBDh++Rv5diH8gy8V0T7YtvmU4ss=; b=Bpk/eKrMv0ipYNfN1Y3N2fPfeg
        Utl9j8h2Q9cG7pglDxwqYKt0Rq38KDs5/NuOMQUqEOdZ9bXwAMIyg3okjT+jlOrxAMzfAIvewEftu
        xnIryAzIZCCvTVyYLbXkufF80ahQgMycI5zzTQUfalzhtGboCi80QKnSDrS6AjaOSmbwb0iUGGKAU
        zdORkBOA8IAKkrCNkdn62u4c7QwMyf8NIDv7XQrry1rt0Y59eaXByRcGWxGdOmu4Y0CjydmE7PbKl
        PFIyHr5bkIdiwfRBr2CuyinpGxESycv7Wmu11lUiTU7/hCfExhLtalGAy8vrxc7WUh3HlFmjx85Qi
        r1jDEbBw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1kuj92-0004zV-VA; Wed, 30 Dec 2020 21:36:38 +0000
Date:   Wed, 30 Dec 2020 21:36:36 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     YANG LI <abaci-bugfix@linux.alibaba.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: fix: second lock in function d_prune_aliases().
Message-ID: <20201230213636.GA18640@casper.infradead.org>
References: <1609311685-99562-1-git-send-email-abaci-bugfix@linux.alibaba.com>
 <20201230200449.GF3579531@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201230200449.GF3579531@ZenIV.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 30, 2020 at 08:04:49PM +0000, Al Viro wrote:
> On Wed, Dec 30, 2020 at 03:01:25PM +0800, YANG LI wrote:
> > Goto statement jumping will cause lock to be executed again without
> > executing unlock, placing the lock statement in front of goto
> > label to fix this problem.
> > 
> > Signed-off-by: YANG LI <abaci-bugfix@linux.alibaba.com>
> > Reported-by: Abaci <abaci@linux.alibaba.com>
> 
> I am sorry, but have you even attempted to trigger that codepath?
> Just to test your patch...
> 
> FWIW, the patch is completely broken.  Obviously so, since you
> have dput() done just before goto restart and dput() in very
> much capable of blocking.  It should never be called with spinlocks
> held.  And if you look at __dentry_kill() (well, dentry_unlink_inode()
> called by __dentry_kill()), you will see that it bloody well *DOES*
> drop inode->i_lock.

Not only that, but the function is even _annotated_ to that effect.
So this 'abaci' tool you have isn't even capable of the bare minimum.
