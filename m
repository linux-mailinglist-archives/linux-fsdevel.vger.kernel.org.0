Return-Path: <linux-fsdevel+bounces-1858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 106BB7DF75A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 17:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF000281997
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 16:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B651D6A6;
	Thu,  2 Nov 2023 16:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S614BJSF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B906E1CF90
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 16:06:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B545C433C8;
	Thu,  2 Nov 2023 16:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698941160;
	bh=UgIfY2e/1GwS/qPtqovboQbQpaP7TE90s0DZ8tQ0iRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S614BJSFT7BJvumCGUSsNjQC9lRioVkT7a+bzf7xkyqp7PtpwHniE3ecVJlWP4L52
	 /4dGheZ6/izO1mpTMuwKLzrblwWNxMfcYx/kzuJE5/pxmVgtlOLSsVfMomKJesIdEG
	 NVL8tN4hNVzH/nICpx0PreDcCXFAlpLSznCM5kv8VfmKAO+tqGV2rp7i9VSYJC51di
	 Pi9o9kaTirwYxDTTaAOAWDs64MvvPSQ7Sb9O7n/2yNrk4LR0rQauIkyDlD9uW0Jbbo
	 aqnHbKaI0Wj7lORDugPN1e6Dv8zeKFo+OWNOG8sw0UPjTcC0Y9CntkhIBDA6Pe+2wE
	 g5nzN3GZcWEQA==
Date: Thu, 2 Nov 2023 17:05:56 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] fs: make s_count atomic_t
Message-ID: <20231102-kopfzerbrechen-liquidieren-f8622892e6da@brauner>
References: <20231027-neurologie-miterleben-a8c52a745463@brauner>
 <20231102134842.tu26pykjpzgi4veo@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231102134842.tu26pykjpzgi4veo@quack3>

On Thu, Nov 02, 2023 at 02:48:42PM +0100, Jan Kara wrote:
> On Fri 27-10-23 11:35:20, Christian Brauner wrote:
> > So, I believe we can drop the sb_lock in bdev_super_lock() for all
> > holder operations if we turn s_count into an atomic. It will slightly
> > change semantics for list walks like iterate_supers() but imho that's
> > fine. It'll mean that list walkes need a acquire sb_lock, then try to
> > get reference via atomic_inc_not_zero().
> > 
> > The logic there is simply that if you still found the superblock on the
> > list then yes, someone could now concurrently drop s_count to zero
> > behind your back. But because you hold sb_lock they can't remove it from
> > the list behind your back.
> > 
> > So if you now fail atomic_inc_not_zero() then you know that someone
> > concurrently managed to drop the ref to zero and wants to remove that sb
> > from the list. So you just ignore that super block and go on walking the
> > list. If however, you manage to get an active reference things are fine
> > and you can try to trade that temporary reference for an active
> > reference. So my theory at least...
> > 
> > Yes, ofc we add atomics but for superblocks we shouldn't care especially
> > we have less and less list walkers. Both get_super() and
> > get_active_super() are gone after all.
> > 
> > I'm running xfstests as I'm sending this and I need to start finishing
> > PRs so in RFC mode. Thoughts?
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> 
> So in principle I agree we can get rid of some sb_lock use if we convert
> sb->s_count to an atomic type. However does this bring any significant
> benefit? I would not expect sb_lock to be contended and as you say you need
> to be more careful about the races then so that is a reason against such
> change.

I like that we elide the spinlock in cases where we go from block device
to superblock. It's more elegant. But in practice I think it won't
matter. It's not that bdev_*() calls are extremely performant.

