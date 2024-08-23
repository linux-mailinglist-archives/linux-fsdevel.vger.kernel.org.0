Return-Path: <linux-fsdevel+bounces-26896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CC995CB28
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 13:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8174B1F23B3D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 11:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2F8185B75;
	Fri, 23 Aug 2024 11:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9lpYFDu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1DA143879
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 11:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724411260; cv=none; b=lMi0UtbDXhYxX6jDzF8YFV5JrzK2OJWYB0OQh63F1MZ7FrGa+LDJpK3PvsOjyI+LtiLQksg5aKqFfqljHnOkpKwN6PxtggK7k4hwR+HejtDcIS5USgK5eAPoATtJpgh9uoAl/D6CWbkdSx4SHl61EZylgMBKuVgli8tTjMwBjLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724411260; c=relaxed/simple;
	bh=hW92HOO4KmJ4CqjAzjxg6c6xrhF16A7B1iPLx3ASpRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E17m6gxEJ9Xh8xDw+pcdU4kQuf06VFiJe/OWh1A3ksja+39mOFvrNmzEE6+Zvq1I9Hq8JkgsT1GIc8wZeAba5X3Wc5D1poo0dSG9vXvyeZl6+Pqn2rqtTTvUWOEaz3c8VQoq6KNZozrRNr1XEcS579TxaTryRvODMOULr1lYYQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9lpYFDu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A4B1C32786;
	Fri, 23 Aug 2024 11:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724411260;
	bh=hW92HOO4KmJ4CqjAzjxg6c6xrhF16A7B1iPLx3ASpRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h9lpYFDu/vHb57FNFdxlUqgnh7NPUdW3z8vgnChJBonCV0Q8LkaINdpJX67yHtYde
	 lQNjZhmn626gShisUYoep74mw2hwETiBfVEnDgnb8vg3oPM2kNr7SvFxphNfWuMMq/
	 hxAydbJRGnJcFa/YV2Je23j1fqSSs/b4zvH9SPe7xiINxcTsZLSGTnGOgJcLWNVpXk
	 zXRcncyueXDNXgPOAqAx2FjyFjiBquqDEC1DduUmyaxuMTfhGYQUDFfJiGcEPT/w6D
	 r7dRlonqaklydmE+q0VGMujEpHcRRnEAYtuH0cuj0GjJjv+IYIOcwAn3ij7B9v24bH
	 s0C/ITdbn2F1Q==
Date: Fri, 23 Aug 2024 13:07:35 +0200
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jeff Layton <jlayton@kernel.org>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v2 4/6] inode: port __I_NEW to var event
Message-ID: <20240823-fanpost-ableisten-33928d6abf9d@brauner>
References: <20240821-work-i_state-v2-0-67244769f102@kernel.org>
 <20240821-work-i_state-v2-4-67244769f102@kernel.org>
 <172437311532.6062.13754145971447516576@noble.neil.brown.name>
 <20240823-bersten-besiedeln-d19f7547ad7a@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240823-bersten-besiedeln-d19f7547ad7a@brauner>

On Fri, Aug 23, 2024 at 10:20:31AM GMT, Christian Brauner wrote:
> On Fri, Aug 23, 2024 at 10:31:55AM GMT, NeilBrown wrote:
> > On Thu, 22 Aug 2024, Christian Brauner wrote:
> > > Port the __I_NEW mechanism to use the new var event mechanism.
> > > 
> > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > ---
> > >  fs/bcachefs/fs.c          | 10 ++++++----
> > >  fs/dcache.c               |  3 +--
> > >  fs/inode.c                | 18 ++++++++----------
> > >  include/linux/writeback.h |  3 ++-
> > >  4 files changed, 17 insertions(+), 17 deletions(-)
> > > 
> > > diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
> > > index 94c392abef65..c0900c0c0f8a 100644
> > > --- a/fs/bcachefs/fs.c
> > > +++ b/fs/bcachefs/fs.c
> > > @@ -1644,14 +1644,16 @@ void bch2_evict_subvolume_inodes(struct bch_fs *c, snapshot_id_list *s)
> > >  				break;
> > >  			}
> > >  		} else if (clean_pass && this_pass_clean) {
> > > -			wait_queue_head_t *wq = bit_waitqueue(&inode->v.i_state, __I_NEW);
> > > -			DEFINE_WAIT_BIT(wait, &inode->v.i_state, __I_NEW);
> > > +			struct wait_bit_queue_entry wqe;
> > > +			struct wait_queue_head *wq_head;
> > >  
> > > -			prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
> > > +			wq_head = inode_bit_waitqueue(&wqe, &inode->v, __I_NEW);
> > 
> > I don't think you EXPORT inode_bit_waitqueue() so you cannot use it in
> > this module.
> 
> I had already fixed that in-tree because I got a build failure on one of
> my test machines.
> 
> > 
> > And maybe it would be good to not export it so that this code can get
> > cleaned up.
> 
> Maybe but I prefer this just to be a follow-up. So that we get hung up

*don't

> on ever more details.

