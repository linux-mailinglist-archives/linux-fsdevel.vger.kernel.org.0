Return-Path: <linux-fsdevel+bounces-26882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2959395C7E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 10:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1C051F260A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 08:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB9A142904;
	Fri, 23 Aug 2024 08:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wx3d8UyQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FB636AEC
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 08:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724401237; cv=none; b=gE8C0WDMdlup1utVFPdttvsQlmuGgkhgki++bf08LgtEHv7KBl/gsFZeUs7QGADRcFaRYva0Ee+Uy9jaOa2lUmyLEnGoJfXqeQzHFuxzwJyNxxlYeAlRB73ym2kxoyCSHvwTTEbPpwjdF+RK6jEmVYeYVdVO/FdCe1wDyv8+tTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724401237; c=relaxed/simple;
	bh=tWm1cywBT0CriXA0bmuRvTWswfw3jDJ1mDxzWhYNNpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NbHgbTm4pDqJYlD5d/zqj6NOOH7dx4MkWLux/sYUj+PMBuj7+281GQdJa7muvsoaAKxE2yagl+VnbHsncLMzvToLn5B5vIuaxH01KCWVjwXHrNwlimB13jwHwv6Nb+ipkUFwNaFVsVi7MOHBHLoeL1opEm4+HP/dOPk/QfwqtFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wx3d8UyQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAAC8C32786;
	Fri, 23 Aug 2024 08:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724401236;
	bh=tWm1cywBT0CriXA0bmuRvTWswfw3jDJ1mDxzWhYNNpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wx3d8UyQhfEyTApq/hGb9HLL5+Lj9bwhbF7J4JUIqx3WXJfb/1PwZLjorrb7tv4SR
	 4t8ncGbf9r0xbA/dJtAYXiw81cXDgzI6d39FogC3NZGp0I2s5YCY4WluNCD9f3Vrt6
	 JOyuB+xwiJRKHQ+bZcP476bFCy8jIbhcE1Ef+b455xGhoZPhM+Y3fKQTnyGSHLNBD5
	 SUTh5OapG51JdSY5OC9MhxdtI6RSTRwiB9NsbKBim+JgDw/zk1wAgaOh6jS2ayGWo5
	 JqEzOv2ceRMK5VJdpJoG8iyJfPOyusPG8cJHRRFpjwLvpwwN3edbFlRYrsbx7/9+zm
	 UYbnKIi9gFh5Q==
Date: Fri, 23 Aug 2024 10:20:31 +0200
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jeff Layton <jlayton@kernel.org>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v2 4/6] inode: port __I_NEW to var event
Message-ID: <20240823-bersten-besiedeln-d19f7547ad7a@brauner>
References: <20240821-work-i_state-v2-0-67244769f102@kernel.org>
 <20240821-work-i_state-v2-4-67244769f102@kernel.org>
 <172437311532.6062.13754145971447516576@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <172437311532.6062.13754145971447516576@noble.neil.brown.name>

On Fri, Aug 23, 2024 at 10:31:55AM GMT, NeilBrown wrote:
> On Thu, 22 Aug 2024, Christian Brauner wrote:
> > Port the __I_NEW mechanism to use the new var event mechanism.
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  fs/bcachefs/fs.c          | 10 ++++++----
> >  fs/dcache.c               |  3 +--
> >  fs/inode.c                | 18 ++++++++----------
> >  include/linux/writeback.h |  3 ++-
> >  4 files changed, 17 insertions(+), 17 deletions(-)
> > 
> > diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
> > index 94c392abef65..c0900c0c0f8a 100644
> > --- a/fs/bcachefs/fs.c
> > +++ b/fs/bcachefs/fs.c
> > @@ -1644,14 +1644,16 @@ void bch2_evict_subvolume_inodes(struct bch_fs *c, snapshot_id_list *s)
> >  				break;
> >  			}
> >  		} else if (clean_pass && this_pass_clean) {
> > -			wait_queue_head_t *wq = bit_waitqueue(&inode->v.i_state, __I_NEW);
> > -			DEFINE_WAIT_BIT(wait, &inode->v.i_state, __I_NEW);
> > +			struct wait_bit_queue_entry wqe;
> > +			struct wait_queue_head *wq_head;
> >  
> > -			prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
> > +			wq_head = inode_bit_waitqueue(&wqe, &inode->v, __I_NEW);
> 
> I don't think you EXPORT inode_bit_waitqueue() so you cannot use it in
> this module.

I had already fixed that in-tree because I got a build failure on one of
my test machines.

> 
> And maybe it would be good to not export it so that this code can get
> cleaned up.

Maybe but I prefer this just to be a follow-up. So that we get hung up
on ever more details.

