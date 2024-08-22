Return-Path: <linux-fsdevel+bounces-26691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DBD95B0F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 10:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C6B91F22078
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 08:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB54216EBED;
	Thu, 22 Aug 2024 08:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pTysZ2OU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBCB16DEB4
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 08:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724316835; cv=none; b=C9EOg9D1vIOfjyCWWL6ATjEBlrB8WSO4Vn7YrdBiHeGaqS262bLazOm8SvtfVozGKnNMncscSQGuFGx6nOJseVIau3agTTVrUDfhP+1LubCb+GuRoaM6N5tnSAADO1BGphcfAxX0ufFkz+0JbMdatKo73HfGOSopVvMqGEe9Rl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724316835; c=relaxed/simple;
	bh=VBUZ9a94snb1UwxfdooO1UuV32+v4Cy7G2iDXQB5k9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q7OXRvJGGCrftLNvfd9Ll5SR7X8W/PdvU4aLxwyI9TXT3Rk/SpqvR5M949XUfe5WuvyOd09WzWnQY1Y7U3imRZ/z7drcJaK2Hjw7pL1ZczoPJJ8lezHi1RVQkBtp03vqn1Ndl8oaUVPdfYfA4FgJc4PZqQmBLwSJWQEIcMKee0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pTysZ2OU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C234C4AF0B;
	Thu, 22 Aug 2024 08:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724316834;
	bh=VBUZ9a94snb1UwxfdooO1UuV32+v4Cy7G2iDXQB5k9c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pTysZ2OUzSQbUGrHxQTBprKKlgI79jpKWvxTSZu0qwY+DP2/h0lEsvLN3aMLzzjXr
	 DHKGxLscQImhHPO7QxTRIWXYE8p2Pg9fM2Y0CtV1jPTOuZR+GDW5jY4KcZUA6aozj/
	 ugr/ozKJkXorJsu4DePnecv1buGWIOR8IGHaMA5mXllu7Khr0DLOPUMMw1+azUON/U
	 o3E1UoqqQBvj1JgszOn+O8wS+MxUl/TzhnBKgvvL5lAPGy7LKDg9BxVl9pq80YoS5G
	 pMRp4ekxsn19Wz/STu4B27Y1Uh0551zVvKBRuKMekFJkEeEtiz7UOcNJMuBA57v328
	 g8sHB4kJeWMPw==
Date: Thu, 22 Aug 2024 10:53:50 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	NeilBrown <neilb@suse.de>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v2 5/6] inode: port __I_LRU_ISOLATING to var event
Message-ID: <20240822-wachdienst-mahnmal-b25d2f0fb350@brauner>
References: <20240821-work-i_state-v2-0-67244769f102@kernel.org>
 <20240821-work-i_state-v2-5-67244769f102@kernel.org>
 <fcf964b8b46af36e31f9dda2a8f2180eb999f35c.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fcf964b8b46af36e31f9dda2a8f2180eb999f35c.camel@kernel.org>

On Wed, Aug 21, 2024 at 03:41:45PM GMT, Jeff Layton wrote:
> On Wed, 2024-08-21 at 17:47 +0200, Christian Brauner wrote:
> > Port the __I_LRU_ISOLATING mechanism to use the new var event mechanism.
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  fs/inode.c | 26 +++++++++++++++++---------
> >  1 file changed, 17 insertions(+), 9 deletions(-)
> > 
> > diff --git a/fs/inode.c b/fs/inode.c
> > index d18e1567c487..c8a5c63dc980 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -510,8 +510,7 @@ static void inode_unpin_lru_isolating(struct inode *inode)
> >  	spin_lock(&inode->i_lock);
> >  	WARN_ON(!(inode->i_state & I_LRU_ISOLATING));
> >  	inode->i_state &= ~I_LRU_ISOLATING;
> > -	smp_mb();
> > -	wake_up_bit(&inode->i_state, __I_LRU_ISOLATING);
> > +	inode_wake_up_bit(inode, __I_LRU_ISOLATING);
> >  	spin_unlock(&inode->i_lock);
> >  }
> >  
> > @@ -519,13 +518,22 @@ static void inode_wait_for_lru_isolating(struct inode *inode)
> >  {
> >  	lockdep_assert_held(&inode->i_lock);
> >  	if (inode->i_state & I_LRU_ISOLATING) {
> > -		DEFINE_WAIT_BIT(wq, &inode->i_state, __I_LRU_ISOLATING);
> > -		wait_queue_head_t *wqh;
> > -
> > -		wqh = bit_waitqueue(&inode->i_state, __I_LRU_ISOLATING);
> > -		spin_unlock(&inode->i_lock);
> > -		__wait_on_bit(wqh, &wq, bit_wait, TASK_UNINTERRUPTIBLE);
> > -		spin_lock(&inode->i_lock);
> > +		struct wait_bit_queue_entry wqe;
> > +		struct wait_queue_head *wq_head;
> > +
> > +		wq_head = inode_bit_waitqueue(&wqe, inode, __I_LRU_ISOLATING);
> > +		for (;;) {
> > +			prepare_to_wait_event(wq_head, &wqe.wq_entry,
> > +					      TASK_UNINTERRUPTIBLE);
> > +			if (inode->i_state & I_LRU_ISOLATING) {
> > +				spin_unlock(&inode->i_lock);
> > +				schedule();
> > +				spin_lock(&inode->i_lock);
> > +				continue;
> > +			}
> > +			break;
> > +		}
> 
> nit: personally, I'd prefer this, since you wouldn't need the brackets
> or the continue:
> 
> 			if (!(inode->i_state & LRU_ISOLATING))
> 				break;
> 			spin_unlock();
> 			schedule();

Yeah, that's nicer. I'll use that.

