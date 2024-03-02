Return-Path: <linux-fsdevel+bounces-13372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB0586F17D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 17:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A997D1F222A4
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 16:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818D224A0E;
	Sat,  2 Mar 2024 16:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GXVcMWzf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538B018658
	for <linux-fsdevel@vger.kernel.org>; Sat,  2 Mar 2024 16:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709398413; cv=none; b=PT1oUwILaP1EOVP3Eg2OCBdZqjKawb/mSrsdhv3e1dciY9NAf1xjAU/thxBzTyPsNm8wYtN+iegof7bRMaSjdz+U6UGTWMGa+9juzHxPVeZZXAfbqJW157XjmKTM6IwZVU04ph+A0+EhrnbgGaQ0rSR88omzr5nfsAAI8uMsB7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709398413; c=relaxed/simple;
	bh=XIAAJF7Achog34mfEKOhOQ507b/ore8zyrZYY0bcj2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L++yluQndilf+/4oHFbs49OuB5xUQfAC7D8sBFdvZTfYHMisoPkQVh7CtpKUqeLX4iIFx+M/W+v309TFzc9+q+M4hUXEGRcA4GDX/OzK7hllRK0+NvpbvDJLGMhgOWg1ZT2Ie5U1GJZAzmdyvgHP1QCZKxpmo1KN/AHq96Ogfcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GXVcMWzf; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UFN/0TjiqmfLk9k3ExuSBGoIo3YJIBTGV1vH7lZZMpM=; b=GXVcMWzfibpk1fj4ERagE5xWl8
	mQEsFbgHFD8BlBlm68Z5ZaqUwnwRdh7hjqPcjItVuKwdqkeFggyX4vYY/5LLMuRP9VXtidlVXw2yR
	bb2Fwq7OjbGUeRELvBSUeH9dxX0rfiYdmBP+6APDZhXHgFQY8Q/fHF2NfXxC8X/7aSBw6RTkLovm+
	Tt09DXXt5V/Bo0SmpfU4xZTERoGwqPIykiL6h+UyrsGTH83S4GozF7Z5ZZdMTItgEtFIP++pPyZ1U
	b5MaFHkxOH3KuLNy5u1oF4cWElY27t3z6/c2DPT1AJTR1bURmEhNJ46wzcGR4bjgv7JCYAdi8cdue
	yrHW7ZEw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rgSbm-0000000E8qI-2l2b;
	Sat, 02 Mar 2024 16:53:10 +0000
Date: Sat, 2 Mar 2024 16:53:10 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, NeilBrown <neilb@suse.de>,
	Dave Chinner <david@fromorbit.com>,
	Amir Goldstein <amir73il@gmail.com>, paulmck@kernel.org,
	lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Reclamation interactions with RCU
Message-ID: <ZeNZdu8tUXmU67Cq@casper.infradead.org>
References: <c6321dd1-ec0e-4fed-87cc-50d297d2be30@paulmck-laptop>
 <CAOQ4uxhiOizDDDJZ+hth4KDvUAYSyM6FRr_uqErAvzQ-=2VydQ@mail.gmail.com>
 <Zd-LljY351NCrrCP@casper.infradead.org>
 <170925937840.24797.2167230750547152404@noble.neil.brown.name>
 <ZeFtrzN34cLhjjHK@dread.disaster.area>
 <pv2chxwnrufut6wecm47q2z7222tzdl3gi6s5wgvmk3b2gq3n5@d23qr5odwyxl>
 <170933687972.24797.18406852925615624495@noble.neil.brown.name>
 <xbjw7mn57qik3ica2k6o7ykt7twryod6rt3uvu73w6xahrrrql@iaplvz7t5tgv>
 <a2ac50aa-0f68-4a01-9c49-adfc19430af5@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2ac50aa-0f68-4a01-9c49-adfc19430af5@I-love.SAKURA.ne.jp>

On Sat, Mar 02, 2024 at 08:33:34PM +0900, Tetsuo Handa wrote:
> On 2024/03/02 9:02, Kent Overstreet wrote:
> > Getting rid of those would be a really nice cleanup beacuse then gfp
> > flags would mostly just be:
> >  - the type of memory to allocate (highmem, zeroed, etc.)
> >  - how hard to try (don't block at all, block some, block forever)
> 
> I really wish that __GFP_KILLABLE is added, so that we can use like
> mutex_trylock()/mutex_lock_killable()/mutex_lock().
> 
> Memory allocations from LSM modules for access control are willing to
> give up when the allocating process is killed, for userspace won't know
> about whether the request succeed. But such allocations are hardly
> acceptable to give up unless the allocating process is killed or
> allocation hit PAGE_ALLOC_COSTLY_ORDER, for ENOMEM failure returned by
> e.g. open() can break the purpose of executing userspace processes
> (i.e. as bad as being killed by the OOM killer).

I'd be open to adding that, but does it really happen?  For it to be
useful, we'd have to have an allocation spending a significant amount of
time in memory allocation such that the signal arrives while we're
retrying.  Do you have any details about times when you've seen this,
eg sizes, other GFP flags, ... ?

