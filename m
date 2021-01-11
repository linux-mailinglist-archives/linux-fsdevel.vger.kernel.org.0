Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0342F20AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 21:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404228AbhAKUYZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 15:24:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:33318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404215AbhAKUYW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 15:24:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ADBE1225AC;
        Mon, 11 Jan 2021 20:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610396621;
        bh=GuikJIMMynj1JoVdFBbBDyTl6eY4ObOVr2EhJzbluqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h9UJs0tr0HoLvfoM0v704ZMwvpGKTk+NgiLZEjtFVRGKupALugn+LTjpCVAzgGoDt
         fnvgqZCF48gZoGU8LQOWMLdCBR5SUO9onTJHG74h3wmPwtP+ZqD8Uc1bVk8LPSBTxa
         yUdoD94NOU5fUPYrHZIa26l1w+y22BfW7zuWvitBcnnpKeJZ5tWmMijqpzTW2T8RBB
         v9/ZLCNXfoJCPVqOY000S6pHMovE+IDHJouQmhR6KR2ZjYAtHmgJcISwR8/kY3ESw+
         cTvhL/H7nkTKjLz0FryNvH1qL4khOQKIgNyGy1b/Ygf2RyfL1stItYLsoFgFUCLJgg
         u5yjhlG30NShA==
Date:   Mon, 11 Jan 2021 12:23:40 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v2 11/12] ext4: simplify i_state checks in
 __ext4_update_other_inode_time()
Message-ID: <X/yzzKhysdFUY/6o@sol.localdomain>
References: <20210109075903.208222-1-ebiggers@kernel.org>
 <20210109075903.208222-12-ebiggers@kernel.org>
 <20210111105342.GE2502@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111105342.GE2502@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 11, 2021 at 11:53:42AM +0100, Christoph Hellwig wrote:
> On Fri, Jan 08, 2021 at 11:59:02PM -0800, Eric Biggers wrote:
> >  	if ((inode->i_state & (I_FREEING | I_WILL_FREE | I_NEW |
> > -			       I_DIRTY_INODE)) ||
> > -	    ((inode->i_state & I_DIRTY_TIME) == 0))
> > +			       I_DIRTY_TIME)) != I_DIRTY_TIME)
> >  		return;
> >  
> >  	spin_lock(&inode->i_lock);
> > -	if (((inode->i_state & (I_FREEING | I_WILL_FREE | I_NEW |
> > -				I_DIRTY_INODE)) == 0) &&
> > -	    (inode->i_state & I_DIRTY_TIME)) {
> > +	if ((inode->i_state & (I_FREEING | I_WILL_FREE | I_NEW |
> > +			       I_DIRTY_TIME)) == I_DIRTY_TIME) {
> 
> I think a descriptively named inline helper in fs.h would really improve
> this..

Do you want this even though it is specific to how ext4 opportunisticly updates
other inodes in the same inode block as the inode being updated?  That's the
only reason that I_FREEING|I_WILL_FREE|I_NEW need to be checked; everywhere else
justs want I_DIRTY_TIME.

We could add:

	static inline bool other_inode_has_dirtytime(struct inode *inode)
	{
		return (inode->state & (I_FREEING | I_WILL_FREE |
					I_NEW | I_DIRTY_TIME)) == I_DIRTY_TIME;
	}

But it seems a bit weird when it's specific to ext4 at the moment.

Are you thinking that other filesystems will implement the same sort of
opportunistic update, so we should add the helper now?

- Eric
