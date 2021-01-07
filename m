Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A088A2ED734
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jan 2021 20:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbhAGTHd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jan 2021 14:07:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:41722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbhAGTHd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jan 2021 14:07:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C66ED2343E;
        Thu,  7 Jan 2021 19:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610046413;
        bh=TozHh8L5vYEuR54Tj/jUaA6Qe0QF9OsgDOXAbm07fiA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q8xVK9Z8yvGQiz7qgq4RnAT33rH+kBsUlJ4SJZhUcUlZ6xyWlpOb0gNuTMgxqoICc
         fPXQ9k7hD9U5EC2IHF1mmAwr4hjUUptnniBEZV2T7PUV1jTIO6yerBkcQhNByM91gS
         mnu3XB+t9CAlLXDQdVaGyPtWIW8RGcmRVmCA3SpeFtmY5AmpnQywDN4T8d7XU2KoI7
         J2Qa2lG3n5UYUbEObzt4d0xd52mFrgpzIBF4hVCVd/9gSN3+TZ5AE3pVnFQ4vRvzd0
         6woZyzRvt2oZbwmqEuZn79y+dpKpfqnnQ0EnqQi2uWCc+4CeP0ZZml/sOnapbgUFDR
         eI/4T7W3lJrOQ==
Date:   Thu, 7 Jan 2021 11:06:51 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 08/13] ext4: simplify i_state checks in
 __ext4_update_other_inode_time()
Message-ID: <X/dbyxqr9iyf7ZbO@gmail.com>
References: <20210105005452.92521-1-ebiggers@kernel.org>
 <20210105005452.92521-9-ebiggers@kernel.org>
 <20210107132412.GE12990@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107132412.GE12990@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 07, 2021 at 02:24:12PM +0100, Jan Kara wrote:
> On Mon 04-01-21 16:54:47, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > Since I_DIRTY_TIME and I_DIRTY_INODE are mutually exclusive in i_state,
> > there's no need to check for I_DIRTY_TIME && !I_DIRTY_INODE.  Just check
> > for I_DIRTY_TIME.
> > 
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > ---
> >  fs/ext4/inode.c | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > index 4cc6c7834312f..9e34541715968 100644
> > --- a/fs/ext4/inode.c
> > +++ b/fs/ext4/inode.c
> > @@ -4962,14 +4962,12 @@ static void __ext4_update_other_inode_time(struct super_block *sb,
> >  		return;
> >  
> >  	if ((inode->i_state & (I_FREEING | I_WILL_FREE | I_NEW |
> > -			       I_DIRTY_INODE)) ||
> > -	    ((inode->i_state & I_DIRTY_TIME) == 0))
> > +			       I_DIRTY_TIME)) != I_DIRTY_TIME)
> >  		return;
> 
> This is OK.
> 
> >  	spin_lock(&inode->i_lock);
> > -	if (((inode->i_state & (I_FREEING | I_WILL_FREE | I_NEW |
> > -				I_DIRTY_INODE)) == 0) &&
> > -	    (inode->i_state & I_DIRTY_TIME)) {
> > +	if ((inode->i_state & (I_FREEING | I_WILL_FREE | I_NEW |
> > +			       I_DIRTY_TIME)) != I_DIRTY_TIME) {
> 
> But this condition is negated AFAICT. We should have == I_DIRTY_TIME here
> AFAICT.

Indeed, I'll fix that.  Thanks for catching this!

- Eric
