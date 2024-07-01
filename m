Return-Path: <linux-fsdevel+bounces-22844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A6B91D7AA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 07:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65F091C22234
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 05:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7486341C72;
	Mon,  1 Jul 2024 05:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJOkfmYk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9852CCB7;
	Mon,  1 Jul 2024 05:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719813030; cv=none; b=YRPnaco/DAwKs3xU9rm97KjFaqnhbOGjI3gdFOdCFKu/jtahUXhbluLu8UqFRHn7VWQYn5rwtFxNF3R3te9iQc364XXyw0/naYcA5k8KXDpJaECAzY7dNQG2MltDEp/G94X7uV9vR8RAyC0n3A51Ty9Gpzp3AIKk5r+Ox5tENb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719813030; c=relaxed/simple;
	bh=CggASGndVY2hRAe4b7g7gUovcHQroxoUVYzI/gZU+1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fWAsWQQcD/omAdDJVf56NNvMIyBWofnB/OCi9RvOVCBcbzCjsbqB4fpyaqe0tfVwqnrzHdhR1N5sqr657acJ1pEnqMAWn/MAWNfcC4t2GNpEeqekTO2XlJ1HHCkNE4dPF/auirO1jCxbQw8uqft7w6grDaWDQ2howhwQwKY/9XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJOkfmYk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACFEEC116B1;
	Mon,  1 Jul 2024 05:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719813030;
	bh=CggASGndVY2hRAe4b7g7gUovcHQroxoUVYzI/gZU+1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gJOkfmYkatWF9NWIpFH+N+JjmQQaypWEN0VPjo97n2fLXeYD54U8rw7DsE8ayKq0d
	 aM+EZcugBP/jcjx6cBhMsFYf8svKHR8QIG6boql1PBNMjUq8kbGhlc43Hwar0e3MqM
	 SMyoVxO2iP91mLIV0c1n8Gd+AncP3Eh9COte7oIeCtdeEG450kHUokfoIrXBddAc8I
	 cYpwcMMjktcRwCTu6tm8ps1Qap/+SMLpI6F/dDSIPIElrEz2Yj6ciCmViyD/78f1kI
	 kln9fHY4tJo+r95nMWjV5BzhEp2OfpNuq2Ar7wPhL5fdHbnACOrCyFHDuOR5FjlWwi
	 TZdNyD34OiqKw==
Date: Mon, 1 Jul 2024 07:50:24 +0200
From: Christian Brauner <brauner@kernel.org>
To: Ian Kent <ikent@redhat.com>
Cc: Alexander Larsson <alexl@redhat.com>, Jan Kara <jack@suse.cz>, 
	Matthew Wilcox <willy@infradead.org>, Lucas Karpinski <lkarpins@redhat.com>, viro@zeniv.linux.org.uk, 
	raven@themaw.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Eric Chanudet <echanude@redhat.com>
Subject: Re: [RFC v3 1/1] fs/namespace: remove RCU sync for MNT_DETACH umount
Message-ID: <20240701-zauber-holst-1ad7cadb02f9@brauner>
References: <20240626201129.272750-2-lkarpins@redhat.com>
 <20240626201129.272750-3-lkarpins@redhat.com>
 <Znx-WGU5Wx6RaJyD@casper.infradead.org>
 <50512ec3-da6d-4140-9659-58e0514a4970@redhat.com>
 <20240627115418.lcnpctgailhlaffc@quack3>
 <20240627-abkassieren-grinsen-6ce528fe5526@brauner>
 <d1b449cb-7ff8-4953-84b9-04dd56ddb187@redhat.com>
 <20240628-gelingen-erben-0f6e14049e68@brauner>
 <CAL7ro1HtzvcuQbRpdtYAG1eK+0tekKYaTh-L_8FqHv_JrSFcZg@mail.gmail.com>
 <97cf3ef4-d2b4-4cb0-9e72-82ca42361b13@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <97cf3ef4-d2b4-4cb0-9e72-82ca42361b13@redhat.com>

> I always thought the rcu delay was to ensure concurrent path walks "see" the
> 
> umount not to ensure correct operation of the following mntput()(s).
> 
> 
> Isn't the sequence of operations roughly, resolve path, lock, deatch,
> release
> 
> lock, rcu wait, mntput() subordinate mounts, put path.

The crucial bit is really that synchronize_rcu_expedited() ensures that
the final mntput() won't happen until path walk leaves RCU mode.

This allows caller's like legitimize_mnt() which are called with only
the RCU read-lock during lazy path walk to simple check for
MNT_SYNC_UMOUNT and see that the mnt is about to be killed. If they see
that this mount is MNT_SYNC_UMOUNT then they know that the mount won't
be freed until an RCU grace period is up and so they know that they can
simply put the reference count they took _without having to actually
call mntput()_.

Because if they did have to call mntput() they might end up shutting the
filesystem down instead of umount() and that will cause said EBUSY
errors I mentioned in my earlier mails.

> 
> 
> So the mount gets detached in the critical section, then we wait followed by
> 
> the mntput()(s). The catch is that not waiting might increase the likelyhood
> 
> that concurrent path walks don't see the umount (so that possibly the umount
> 
> goes away before the walks see the umount) but I'm not certain. What looks
> to
> 
> be as much of a problem is mntput() racing with a concurrent mount beacase
> while
> 
> the detach is done in the critical section the super block instance list
> deletion
> 
> is not and the wait will make the race possibility more likely. What's more

Concurrent mounters of the same filesystem will wait for each other via
grab_super(). That has it's own logic based on sb->s_active which goes
to zero when all mounts are gone.

> 
> mntput() delegates the mount cleanup (which deletes the list instance) to a
> 
> workqueue job so this can also occur serially in a following mount command.

No, that only happens when it's a kthread. Regular umount() call goes
via task work which finishes before the caller returns to userspace
(same as closing files work).

> 
> 
> In fact I might have seen exactly this behavior in a recent xfs-tests run
> where I
> 
> was puzzled to see occasional EBUSY return on mounting of mounts that should
> not
> 
> have been in use following their umount.

That's usually very much other bugs. See commit 2ae4db5647d8 ("fs: don't
misleadingly warn during thaw operations") in vfs.fixes for example.

> 
> 
> So I think there are problems here but I don't think the removal of the wait
> for
> 
> lazy umount is the worst of it.
> 
> 
> The question then becomes, to start with, how do we resolve this unjustified
> EBUSY
> 
> return. Perhaps a completion (used between the umount and mount system
> calls) would
> 
> work well here?

Again, this already exists deeper down the stack...

