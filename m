Return-Path: <linux-fsdevel+bounces-22872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C3D91DED8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 14:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51A4F1F2185C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 12:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E9914B94B;
	Mon,  1 Jul 2024 12:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRMeNBRR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6820664C6;
	Mon,  1 Jul 2024 12:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719836060; cv=none; b=kWPwatxrjCOj3CXFA2BQ3/Fy8Na/4uL/mUccrjVKEdnYKTlXC1BU9yAv9l/vTweec3h4zT7/o61SYEe8LYGSawWACLfegsL6H2OHcLzYb1St1cmCl7UR5aKif1vRdDpX0qr4iinyzgA48hRs6JZEISNf1SXLQhcKAWhZvRoR2xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719836060; c=relaxed/simple;
	bh=1MluUAgSp3pJc1y2+DA4vG/J/+82dGk6KWuKj5Eet5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJGtlRUuOPCzcUQOaLZvu9/mbv8r/wS+jGEv41BJ2rP9H4PpQh+o0z3d+gn+y1v1AfMTmYgLo5HHyOt7dvuHZ2sx+m+tvbSeLPZObHlUwPU/fq26D9NNsRoQc9N6T6mojP/lk29HkFKChWu7IdaXWaOASqKNYdJuYIvmZqyInpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRMeNBRR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF49C2BD10;
	Mon,  1 Jul 2024 12:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719836060;
	bh=1MluUAgSp3pJc1y2+DA4vG/J/+82dGk6KWuKj5Eet5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eRMeNBRRTnG479A1nEZ4sri1AUSt7D3haskD2rUoXOKBX4RifJFpBwVN0qqZsEE9Q
	 j+PdywAWnSs75M4SVgVlzJU4tFl3SmojhKkGVXbXBxr0ffkigB6sD6UG+nnEAz8+05
	 nPS9rhbS2GsPOaCRix2OifPyKudpif3lOqGOEv9XN/o2shFG1B4PUo2HjCmAuQLIrc
	 nkzCoOk2xk0zTPj/BhUJ50IxQ+B/FIFymXSRhLMD3ZubjzkLFAQ4db9EdMr/Zibtiu
	 lsXNw4+G3Mrq0a7cHPkL9iEiZBnjLZkHOvfg3hOQH5f8+02Gm9Nmcv8C4iEOGReyYq
	 z3Nx8ma7F87bQ==
Date: Mon, 1 Jul 2024 14:13:47 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Alexander Larsson <alexl@redhat.com>, Ian Kent <ikent@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Lucas Karpinski <lkarpins@redhat.com>, viro@zeniv.linux.org.uk, 
	raven@themaw.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Eric Chanudet <echanude@redhat.com>
Subject: Re: [RFC v3 1/1] fs/namespace: remove RCU sync for MNT_DETACH umount
Message-ID: <20240701-vortrag-riesig-bbedb130d443@brauner>
References: <50512ec3-da6d-4140-9659-58e0514a4970@redhat.com>
 <20240627115418.lcnpctgailhlaffc@quack3>
 <20240627-abkassieren-grinsen-6ce528fe5526@brauner>
 <d1b449cb-7ff8-4953-84b9-04dd56ddb187@redhat.com>
 <20240628-gelingen-erben-0f6e14049e68@brauner>
 <CAL7ro1HtzvcuQbRpdtYAG1eK+0tekKYaTh-L_8FqHv_JrSFcZg@mail.gmail.com>
 <97cf3ef4-d2b4-4cb0-9e72-82ca42361b13@redhat.com>
 <20240701-zauber-holst-1ad7cadb02f9@brauner>
 <CAL7ro1FOYPsN3Y18tgHwpg+VB=rU1XB8Xds9P89Mh4T9N98jyA@mail.gmail.com>
 <20240701101536.jb452t25xds6x7f3@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240701101536.jb452t25xds6x7f3@quack3>

On Mon, Jul 01, 2024 at 12:15:36PM GMT, Jan Kara wrote:
> On Mon 01-07-24 10:41:40, Alexander Larsson wrote:
> > On Mon, Jul 1, 2024 at 7:50 AM Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > > I always thought the rcu delay was to ensure concurrent path walks "see" the
> > > >
> > > > umount not to ensure correct operation of the following mntput()(s).
> > > >
> > > >
> > > > Isn't the sequence of operations roughly, resolve path, lock, deatch,
> > > > release
> > > >
> > > > lock, rcu wait, mntput() subordinate mounts, put path.
> > >
> > > The crucial bit is really that synchronize_rcu_expedited() ensures that
> > > the final mntput() won't happen until path walk leaves RCU mode.
> > >
> > > This allows caller's like legitimize_mnt() which are called with only
> > > the RCU read-lock during lazy path walk to simple check for
> > > MNT_SYNC_UMOUNT and see that the mnt is about to be killed. If they see
> > > that this mount is MNT_SYNC_UMOUNT then they know that the mount won't
> > > be freed until an RCU grace period is up and so they know that they can
> > > simply put the reference count they took _without having to actually
> > > call mntput()_.
> > >
> > > Because if they did have to call mntput() they might end up shutting the
> > > filesystem down instead of umount() and that will cause said EBUSY
> > > errors I mentioned in my earlier mails.
> > 
> > But such behaviour could be kept even without an expedited RCU sync.
> > Such as in my alternative patch for this:
> > https://www.spinics.net/lists/linux-fsdevel/msg270117.html
> > 
> > I.e. we would still guarantee the final mput is called, but not block
> > the return of the unmount call.
> 
> So FWIW the approach of handing off the remainder of namespace_unlock()
> into rcu callback for lazy unmount looks workable to me. Just as Al Viro
> pointed out you cannot do all the stuff right from the RCU callback as the
> context doesn't allow all the work to happen there, so you just need to
> queue work from RCU callback and then do the real work from there (but OTOH
> you can avoid the task work in mnput_noexpire() in that case - will need a
> bit of refactoring).

Yes, but that wasn't what this patch did. As I said I'm not opposed to
trying a _working_ version of this but I suspect we'll slightly change
MNT_DETACH and cause user visible changes (But then we may end up adding
MNT_ASYNC or something which I wouldn't consider the worst idea ever.).

