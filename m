Return-Path: <linux-fsdevel+bounces-22871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B8391DEC9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 14:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91B42B2290A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 12:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0A7149DE8;
	Mon,  1 Jul 2024 12:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="njc/Yaaq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABD322066;
	Mon,  1 Jul 2024 12:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719835906; cv=none; b=coCiytJXzt34GqGSyYl93xPKXR8/ne9s5fLThBmR4blrB+33G9J2/0WDef3vn8hGpM8nBAI4ICgXZ72TCEjLM8E9TZL417rivPdnOXpphc41SQZVHpWyGPdUrXud7Eh/tE+aMLJkBZ7hef90JlBTIXm6DobaM5OO7kt3ZaIXJ2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719835906; c=relaxed/simple;
	bh=0sVw9TXBbsnWqjAoMf8n5pIzsQWxqqaRorP6LNzEm1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+PFYrbOoQsPuxxGnRajGWhaB7K2vU7bDgcCP67SeKLk6tT0t/kb1KbMwpbrYEBCJbOuI6suSPTzPRn/ZskDu6XVKuFHdbJ04oNXEmb6lSHsxj1rvJMSw1sD6jLN0r22lEmXp5F3aJOVdIhgKKHQSAwnj7oK4sW4UfQ9cfK7eic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=njc/Yaaq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EB40C116B1;
	Mon,  1 Jul 2024 12:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719835906;
	bh=0sVw9TXBbsnWqjAoMf8n5pIzsQWxqqaRorP6LNzEm1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=njc/YaaqoV7Uigz8Os7rg1IdYC8rE2rqlXclcyl/LMSd3Xntb2NdP5UzLfE+mAAyu
	 Hkv0/BPRY4AqPp4MmqcczzVy6lkQm3QE0Wfd7BzzAqJT+RAUOI+QT1FONVjrNlj8jl
	 YlfWSwO/t4nkI2kEkHN2D9EWZkIfOoY+5t87TZUAw/WovjLs7fz/C8u5nHadgGXyNC
	 gwJuJP9+iexhGLFjN55DdF+MHoBp6YKkxWxCoOhTXJUGwLH2iIpt55hEv+EBrZDpxg
	 zRQbI2kmSq4O2+Mxedh7vN2AiYzEj3WE9YIGmvr70GJzOIQYrig+z1phAqhrMWpE+v
	 m6+zwK9EmGWxg==
Date: Mon, 1 Jul 2024 14:10:31 +0200
From: Christian Brauner <brauner@kernel.org>
To: Alexander Larsson <alexl@redhat.com>
Cc: Ian Kent <ikent@redhat.com>, Jan Kara <jack@suse.cz>, 
	Matthew Wilcox <willy@infradead.org>, Lucas Karpinski <lkarpins@redhat.com>, viro@zeniv.linux.org.uk, 
	raven@themaw.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Eric Chanudet <echanude@redhat.com>
Subject: Re: [RFC v3 1/1] fs/namespace: remove RCU sync for MNT_DETACH umount
Message-ID: <20240701-treue-irrtum-e695ee5efe83@brauner>
References: <Znx-WGU5Wx6RaJyD@casper.infradead.org>
 <50512ec3-da6d-4140-9659-58e0514a4970@redhat.com>
 <20240627115418.lcnpctgailhlaffc@quack3>
 <20240627-abkassieren-grinsen-6ce528fe5526@brauner>
 <d1b449cb-7ff8-4953-84b9-04dd56ddb187@redhat.com>
 <20240628-gelingen-erben-0f6e14049e68@brauner>
 <CAL7ro1HtzvcuQbRpdtYAG1eK+0tekKYaTh-L_8FqHv_JrSFcZg@mail.gmail.com>
 <97cf3ef4-d2b4-4cb0-9e72-82ca42361b13@redhat.com>
 <20240701-zauber-holst-1ad7cadb02f9@brauner>
 <CAL7ro1FOYPsN3Y18tgHwpg+VB=rU1XB8Xds9P89Mh4T9N98jyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL7ro1FOYPsN3Y18tgHwpg+VB=rU1XB8Xds9P89Mh4T9N98jyA@mail.gmail.com>

On Mon, Jul 01, 2024 at 10:41:40AM GMT, Alexander Larsson wrote:
> On Mon, Jul 1, 2024 at 7:50 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > > I always thought the rcu delay was to ensure concurrent path walks "see" the
> > >
> > > umount not to ensure correct operation of the following mntput()(s).
> > >
> > >
> > > Isn't the sequence of operations roughly, resolve path, lock, deatch,
> > > release
> > >
> > > lock, rcu wait, mntput() subordinate mounts, put path.
> >
> > The crucial bit is really that synchronize_rcu_expedited() ensures that
> > the final mntput() won't happen until path walk leaves RCU mode.
> >
> > This allows caller's like legitimize_mnt() which are called with only
> > the RCU read-lock during lazy path walk to simple check for
> > MNT_SYNC_UMOUNT and see that the mnt is about to be killed. If they see
> > that this mount is MNT_SYNC_UMOUNT then they know that the mount won't
> > be freed until an RCU grace period is up and so they know that they can
> > simply put the reference count they took _without having to actually
> > call mntput()_.
> >
> > Because if they did have to call mntput() they might end up shutting the
> > filesystem down instead of umount() and that will cause said EBUSY
> > errors I mentioned in my earlier mails.
> 
> But such behaviour could be kept even without an expedited RCU sync.
> Such as in my alternative patch for this:
> https://www.spinics.net/lists/linux-fsdevel/msg270117.html
> 
> I.e. we would still guarantee the final mput is called, but not block
> the return of the unmount call.

That's fine but the patch as sent doesn't work is my point. It'll cause
exactly the issues described earlier, no? So I'm confused why this
version simply ended up removing synchronize_rcu_expedited() when
the proposed soluton seems to have been to use queue_rcu_work().

But anyway, my concern with this is still that this changes the way
MNT_DETACH behaves when you shut down a non-busy filesystem with
MNT_DETACH as outlined in my other mail.

If you find a workable version I'm not entirely opposed to try this but
I wouldn't be surprised if this causes user visible issues for anyone
that uses MNT_DETACH on a non-used filesystem.

