Return-Path: <linux-fsdevel+bounces-59386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 316B3B38593
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 16:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52FDA1793A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 14:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82E624DD17;
	Wed, 27 Aug 2025 14:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0CQwJeU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DDC1EB5D6;
	Wed, 27 Aug 2025 14:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756306653; cv=none; b=lEeXzVWH7BZPCnqcqDomfo2sPIFq4spPlrkyTCrV6L2Lb7iyJWrjV/F4OJPExGyrdhVv1c2pIAGgEYkJEgQ+6V7xW5Z0uyyIbx8EUeSHQk4bZlmlIQooEQKpB/br29tzubRFJiAIHIWpvQr37naEBnb78ZvJKzwSwvO32tZwPts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756306653; c=relaxed/simple;
	bh=i4SHYDxOiIZN8HFLM9Wh/5X71e+T00Dv3GVNSGrmoY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Waqbmoc6vfSX6pZEEYWd8RSe07umoTDm2FGyYKqAOAdeqOMWwM6PDi7VQ2V1blYEPTmNoiGI4Xu1kTG4R8TOsHW+gGfDPujVTifbYZ/R1HXFPwb+DbPkDom4jmvnhuPRz0DEPGSKnwagAFpMhv1IP6n7dvzGTK7xWdI5sLO7KYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0CQwJeU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E95C4CEEB;
	Wed, 27 Aug 2025 14:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756306651;
	bh=i4SHYDxOiIZN8HFLM9Wh/5X71e+T00Dv3GVNSGrmoY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G0CQwJeUVy+tqfwSAaLIVnazBx2eTebZrKS/u0TjBGQcgS5Z4nEepOWFN9Uvs88Rx
	 isexd979rm8D+NNVe1fuhcLkL2UArPmnVnNuF9FS0NUB9nmifmamEewjDoUpsMPdzW
	 J6PAfSi3TpxNi/tnBLpRJfvGzdwTbyNLzPtFNKbxcc0GzBrbakkJ1Q+wTotX15Ca03
	 YVJvVBQHcghnIYSa6FUaaGcf20uHBCu3JVvs9daGgn/k6N344z/mtIvHZWSi6OvpTv
	 uub4w70HeRQs7wqEmzC4xdgPPOn90+5xiXSigbrFwG0I3gKHKd5DJc9v3WI+IGhcD5
	 WJkiBRxkqZJQw==
Date: Wed, 27 Aug 2025 16:57:26 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, kernel-team@fb.com, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org, viro@zeniv.linux.org.uk, amir73il@gmail.com
Subject: Re: [PATCH v2 03/54] fs: rework iput logic
Message-ID: <20250827-kraut-anekdote-35789fddbb0b@brauner>
References: <cover.1756222464.git.josef@toxicpanda.com>
 <be208b89bdb650202e712ce2bcfc407ac7044c7a.1756222464.git.josef@toxicpanda.com>
 <rrgn345nemz5xeatbrsggnybqech74ogub47d6au45mrmgch4d@jqzorhulkvre>
 <n6z2jkdgmgm2xfxc7y3a2a7psnkeboziffkt6bjoggrff4dlxe@vpsyl3ky6w6v>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <n6z2jkdgmgm2xfxc7y3a2a7psnkeboziffkt6bjoggrff4dlxe@vpsyl3ky6w6v>

On Wed, Aug 27, 2025 at 04:18:55PM +0200, Mateusz Guzik wrote:
> On Wed, Aug 27, 2025 at 02:58:51PM +0200, Mateusz Guzik wrote:
> > On Tue, Aug 26, 2025 at 11:39:03AM -0400, Josef Bacik wrote:
> > > Currently, if we are the last iput, and we have the I_DIRTY_TIME bit
> > > set, we will grab a reference on the inode again and then mark it dirty
> > > and then redo the put.  This is to make sure we delay the time update
> > > for as long as possible.
> > > 
> > > We can rework this logic to simply dec i_count if it is not 1, and if it
> > > is do the time update while still holding the i_count reference.
> > > 
> > > Then we can replace the atomic_dec_and_lock with locking the ->i_lock
> > > and doing atomic_dec_and_test, since we did the atomic_add_unless above.
> > > 
> > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > > ---
> > >  fs/inode.c | 23 ++++++++++++++---------
> > >  1 file changed, 14 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/fs/inode.c b/fs/inode.c
> > > index a3673e1ed157..13e80b434323 100644
> > > --- a/fs/inode.c
> > > +++ b/fs/inode.c
> > > @@ -1911,16 +1911,21 @@ void iput(struct inode *inode)
> > >  	if (!inode)
> > >  		return;
> > >  	BUG_ON(inode->i_state & I_CLEAR);
> > > -retry:
> > > -	if (atomic_dec_and_lock(&inode->i_count, &inode->i_lock)) {
> > > -		if (inode->i_nlink && (inode->i_state & I_DIRTY_TIME)) {
> > > -			atomic_inc(&inode->i_count);
> > > -			spin_unlock(&inode->i_lock);
> > > -			trace_writeback_lazytime_iput(inode);
> > > -			mark_inode_dirty_sync(inode);
> > > -			goto retry;
> > > -		}
> > > +
> > > +	if (atomic_add_unless(&inode->i_count, -1, 1))
> > > +		return;
> > > +
> > > +	if (inode->i_nlink && (inode->i_state & I_DIRTY_TIME)) {
> > > +		trace_writeback_lazytime_iput(inode);
> > > +		mark_inode_dirty_sync(inode);
> > > +	}
> > > +
> > > +	spin_lock(&inode->i_lock);
> > > +	if (atomic_dec_and_test(&inode->i_count)) {
> > > +		/* iput_final() drops i_lock */
> > >  		iput_final(inode);
> > > +	} else {
> > > +		spin_unlock(&inode->i_lock);
> > >  	}
> > >  }
> > >  EXPORT_SYMBOL(iput);
> > > -- 
> > > 2.49.0
> > > 
> > 
> > This changes semantics though.
> > 
> > In the stock kernel the I_DIRTY_TIME business is guaranteed to be sorted
> > out before the call to iput_final().
> > 
> > In principle the flag may reappear after mark_inode_dirty_sync() returns
> > and before the retried atomic_dec_and_lock succeeds, in which case it
> > will get cleared again.
> > 
> > With your change the flag is only handled once and should it reappear
> > before you take the ->i_lock, it will stay there.

Yeah, good spotting.

> > 
> > I agree the stock handling is pretty crap though.
> > 
> > Your change should test the flag again after taking the spin lock but
> > before messing with the refcount and if need be unlock + retry.
> > 
> > I would not hurt to assert in iput_final that the spin lock held and
> > that this flag is not set.
> > 
> > Here is my diff to your diff to illustrate + a cosmetic change, not even
> > compile-tested:
> > 
> > diff --git a/fs/inode.c b/fs/inode.c
> > index 421e248b690f..a9ae0c790b5d 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -1911,7 +1911,7 @@ void iput(struct inode *inode)
> >  	if (!inode)
> >  		return;
> >  	BUG_ON(inode->i_state & I_CLEAR);
> > -
> > +retry:
> >  	if (atomic_add_unless(&inode->i_count, -1, 1))
> >  		return;
> >  
> > @@ -1921,12 +1921,19 @@ void iput(struct inode *inode)
> >  	}
> >  
> >  	spin_lock(&inode->i_lock);
> > +
> > +	if (inode->i_count == 1 && inode->i_nlink && (inode->i_state & I_DIRTY_TIME)) {
> > +		spin_unlock(&inode->i_lock);
> > +		goto retry;
> > +	}
> > +
> >  	if (atomic_dec_and_test(&inode->i_count)) {
> > -		/* iput_final() drops i_lock */
> > -		iput_final(inode);
> > -	} else {
> >  		spin_unlock(&inode->i_lock);
> > +		return;
> >  	}
> > +
> > +	/* iput_final() drops i_lock */
> > +	iput_final(inode);
> >  }
> >  EXPORT_SYMBOL(iput);
> >  
> 
> Sorry for spam, but the more I look at this the more fucky the entire
> ordeal appears to me.
> 
> Before I get to the crux, as a side note I did a quick check if atomics
> for i_count make any sense to begin with and I think they do, here is a
> sample output from a friend tracing the ref value on iput:
> 
> bpftrace -e 'kprobe:iput /arg0 != 0/ { @[((struct inode *)arg0)->i_count.counter] = count(); }'
> 
> @[5]: 66
> @[4]: 4625
> @[3]: 11086
> @[2]: 30937
> @[1]: 151785
> 
> ... so plenty of non-last refs after all.
> 
> I completely agree the mandatory ref trip to handle I_DIRTY_TIME is lame
> and needs to be addressed.
> 
> But I'm uneasy about maintaining the invariant that iput_final() does
> not see the flag if i_nlink != 0 and my proposal as pasted is dodgy af
> on this front.
> 
> While here some nits:
> 1. it makes sense to try mere atomics just in case someone else messed
> with the count between handling of the dirty flag and taking the spin lock

Which on mainline is a thing for sure.

> 2. according to my quick test with bpftrace the I_DIRTY_TIME flag is
> seen way less frequently than i_nlink != 0, so it makes sense to swap
> the order in which they are checked. Interested parties can try it out
> with:
> bpftrace -e 'kprobe:iput /arg0 != 0/ { @[((struct inode *)arg0)->i_nlink != 0, ((struct inode *)arg0)->i_state & (1 << 11)] = count(); }'
> 3. touch up the iput_final() unlock comment
> 
> All that said, how about something like the thing below as the final
> routine building off of your change. I can't submit a proper patch and
> can't even compile-test. I don't need any credit should this get
> grabbed.
> 
> void iput(struct inode *inode)
> {
>         if (!inode)
>                 return;
>         BUG_ON(inode->i_state & I_CLEAR);
> retry:
>         if (atomic_add_unless(&inode->i_count, -1, 1))
>                 return;
> 
>         if ((inode->i_state & I_DIRTY_TIME) && inode->i_nlink) {
>                 trace_writeback_lazytime_iput(inode);
>                 mark_inode_dirty_sync(inode);
>                 goto retry;
>         }
> 
>         spin_lock(&inode->i_lock);
>         if ((inode->i_state & I_DIRTY_TIME) && inode->i_nlink) {
>                 spin_unlock(&inode->i_lock);
>                 goto retry;
>         }
> 
>         if (!atomic_dec_and_test(&inode->i_count)) {
>                 spin_unlock(&inode->i_lock);
>                 return;
>         }
> 
>         /*
>          * iput_final() drops ->i_lock, we can't assert on it as the inode may
>          * be deallocated by the time it returns
>          */
>         iput_final(inode);
> }

I've taken this. Though I had Josef convince me that the retry is sane
and doesn't end up stealing a ref. Thanks.

