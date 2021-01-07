Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 220B52ED747
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jan 2021 20:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbhAGTKu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jan 2021 14:10:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:42146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbhAGTKu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jan 2021 14:10:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6CB4123432;
        Thu,  7 Jan 2021 19:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610046609;
        bh=ugnw0oxMzEvCu/VUG9GeA+AsDxtnUhs9qU+595smXXc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uzAA66kWcPLR+x63v+LqKAzMM+XIi7OLLeFPJnrnJr8HiXBD0cpnycMS7Qc3/itD4
         1RahCBIag+8k6tMafM4Y6NrdDnUHTWzvpcpEc1udfzBenqBXNFs4UGnN9lm1A4Oem7
         1zXX31jYIsOi8AHDvw1+aGei6dLaXkMaNRx1hI2k2adYhVV31wF9S1l6aUn9WcGniB
         L71IfDgf/Tdi4KOkiOr/3HXW06QcTVpFyeTERgdtUitkJHusKeFuTeIpGveCOYzBYJ
         ayT/ALAvXzfY/PMg8U8pR2z1cMP4KHNCDQljnu9ApQ7gmO/B+3I2E+vZlMWLLNT9+3
         bV5gdGJokgPkg==
Date:   Thu, 7 Jan 2021 11:10:07 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 04/13] fat: only specify I_DIRTY_TIME when needed in
 fat_update_time()
Message-ID: <X/dcjzkF0Ac4t66J@gmail.com>
References: <20210105005452.92521-1-ebiggers@kernel.org>
 <20210105005452.92521-5-ebiggers@kernel.org>
 <20210107131328.GC12990@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107131328.GC12990@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 07, 2021 at 02:13:28PM +0100, Jan Kara wrote:
> On Mon 04-01-21 16:54:43, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > As was done for generic_update_time(), only pass I_DIRTY_TIME to
> > __mark_inode_dirty() when the inode's timestamps were actually updated
> > and lazytime is enabled.  This avoids a weird edge case where
> > I_DIRTY_TIME could be set in i_state when lazytime isn't enabled.
> > 
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> 
> ...
> > +	if ((flags & S_VERSION) && inode_maybe_inc_iversion(inode, false))
> > +		dirty_flags |= I_DIRTY_SYNC;
> >  
> > -	if (dirty)
> > -		iflags |= I_DIRTY_SYNC;
> >  	__mark_inode_dirty(inode, iflags);
> 				  ^^^ dirty_flags here?
> 
> Otherwise the change looks good to me.

Yeah, I'll fix that.  I accidentally didn't have CONFIG_FAT_FS enabled.

- Eric
