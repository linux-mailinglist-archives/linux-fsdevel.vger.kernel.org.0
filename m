Return-Path: <linux-fsdevel+bounces-29987-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F328984A45
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 19:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FE9C1C229A8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 17:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6221AC43D;
	Tue, 24 Sep 2024 17:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MdKBK11q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8821AAE13;
	Tue, 24 Sep 2024 17:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727198890; cv=none; b=JqDEyI6zM8lLQwWH7m5dM+yere4ipYa3m/Q1In04ZMGttxAtG7/rfAjKJ+cjgvE37kUY/xutT56v+ILXhoKYFS68Elomp0DhgUGg0dMZCwVLOsjrRRgAvngkGzeu/3cb42/UGLZAOmmpz11HGy4VxHPJYG/0ewRO1mV9hzcM3w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727198890; c=relaxed/simple;
	bh=rbage4Mu9PWJpsU8iA5o8nALeDkyI2dknoRoU5xWROQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ekdSEVSKk6CRDxydOspiYdt09mTfeveBS3rpxlmWbd9+ZarYdXN1Y7R9uByRefJZMlR7lqIdXtgXVMhjpzPtUG7bsf3GY5Qac1lhXVLTwFGt1p9wSZQNR/QHgwh7PCUGp710k1Jbm36JoOwYTI+ITHQbDs+lNHXWauKOYhFQAPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MdKBK11q; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 24 Sep 2024 13:27:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727198884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KgxW7wh84kcEvbiiac6qDFbN3PtT+BG+2hxUgMcl8Vk=;
	b=MdKBK11q9jDtY18AvJoLgdwpUjhUbOiU0Vd1gsAqlhG2Ns6M/BghDeAeQ5GOfPqTvqXCD5
	carzCgyTkJEzukH/EOl8Ytw4hIaeJu0u0Wy1kFAcRdSFb4+wKFvjzH6b043hB/0xrgGZZe
	1gr0NM3gakVMuB5nKedAsXZl4RO15zQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dave Chinner <david@fromorbit.com>, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
Subject: Re: [GIT PULL] bcachefs changes for 6.12-rc1
Message-ID: <4osy4zuxehj5ikbxl7nf3cgnvusntd4vcygz7ou2f25dxidjwl@3fq447jxq2mp>
References: <dtolpfivc4fvdfbqgmljygycyqfqoranpsjty4sle7ouydycez@aw7v34oibdhm>
 <CAHk-=whQTx4xmWp9nGiFofSC-T0U_zfZ9L8yt9mG5Qvx8w=_RQ@mail.gmail.com>
 <6vizzdoktqzzkyyvxqupr6jgzqcd4cclc24pujgx53irxtsy4h@lzevj646ccmg>
 <ZvIHUL+3iO3ZXtw7@dread.disaster.area>
 <CAHk-=whbD0zwn-0RMNdgAw-8wjVJFQh4o_hGqffazAiW7DwXSQ@mail.gmail.com>
 <CAHk-=wh+atcBWa34mDdG1bFGRc28eJas3tP+9QrYXX6C7BX0JQ@mail.gmail.com>
 <ZvI4N55fzO7kg0W/@dread.disaster.area>
 <CAHk-=wjNPE4Oz2Qn-w-mo1EJSUCQ+XJfeR3oSgQtM0JJid2zzg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjNPE4Oz2Qn-w-mo1EJSUCQ+XJfeR3oSgQtM0JJid2zzg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Sep 24, 2024 at 09:57:13AM GMT, Linus Torvalds wrote:
> On Mon, 23 Sept 2024 at 20:55, Dave Chinner <david@fromorbit.com> wrote:
> >
> > That's effectively what the patch did - it added a spinlock per hash
> > list.
> 
> Yeah, no, I like your patches, they all seem to be doing sane things
> and improve the code.
> 
> The part I don't like is how the basic model that your patches improve
> seems quite a bit broken.
> 
> For example, that whole superblock list lock contention just makes me
> go "Christ, that's stupid". Not because your patches to fix it with
> Waiman's fancy list would be wrong or bad, but because the whole pain
> is self-inflicted garbage.
> 
> And it's all historically very very understandable. It wasn't broken
> when it was written.
> 
> That singly linked list is 100% sane in the historical context of "we
> really don't want anything fancy for this". The whole list of inodes
> for a superblock is basically unimportant, and it's main use (only
> use?) is for the final "check that we don't have busy inodes at umount
> time, remove any pending stuff".
> 
> So using a stupid linked list was absolutely the right thing to do,
> but now that just the *locking* for that list is a pain, it turns out
> that we probably shouldn't use a list at all. Not because the list was
> wrong, but because a flat list is such a pain for locking, since
> there's no hierarchy to spread the locking out over.

Well, lists are just a pain. They should really be radix trees, we're
not doing actual LRU anyways.

> > [ filesystems doing their own optimized thing ]
> >
> > IOWs, it's not clear to me that this is a caching model we really
> > want to persue in general because of a) the code duplication and b)
> > the issues such an inode life-cycle model has interacting with the
> > VFS life-cycle expectations...
> 
> No, I'm sure you are right, and I'm just frustrated with this code
> that probably _should_ look a lot more like the dcache code, but
> doesn't.
> 
> I get the very strong feeling that we should have a per-superblock
> hash table that we could also traverse the entries of. That way the
> superblock inode list would get some structure (the hash buckets) that
> would allow the locking to be distributed (and we'd only need one lock
> and just share it between the "hash inode" and "add it to the
> superblock list").

I was considering that - that's what the bcachefs btree key cache does,
the shrinker just iterates over the rhashtable.

But referenced inodes aren't kept on the shrinker lists; I hate the
overhead of adding/removing, but Dave was emphatic on there being
workloads where that was really necessary and I'm somewhat convinced.

The other big issue is memcg; I think for that to work we'd need reclaim
to coalesce shrinker calls and shrink from multiple memcgs at the same
time.

