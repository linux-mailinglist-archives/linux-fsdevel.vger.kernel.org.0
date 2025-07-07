Return-Path: <linux-fsdevel+bounces-54168-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 954EBAFBBB8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 21:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B83B42517F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 19:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417D526462B;
	Mon,  7 Jul 2025 19:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="g3ZNJUsR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B5D2E3717;
	Mon,  7 Jul 2025 19:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751916679; cv=none; b=bKjrDuxe674wFbHCvgvHSwEW6eenWwp8dNkSN1AppfJMott/55azMWieojrHhzfQqGFx6X6VKIpR2tHPgcHB8TmGDZQ047E3A8rRHSNPth1JW6iFR5xKTvnhBbcRbMCbQTjdiAHA3FlrQyqqgOsgoA9Ywz3cNLvNFt49P0VmAvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751916679; c=relaxed/simple;
	bh=er1bFv8ZYHWjAZxrRlj3OzEWSMk/8yNh1brflf1trco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KizxRY3vrKfgrGXIoxJxLiq6SpNoD9HZhQYQJnK/vGhI/2g2jxPVg+gNErLfrAtE6lKC+r/53jVXloCwd/DkLIF7/Gl3aJtHDpKpeBfxF5yeeOGH6MC9obbyjaeVhU0GN/I6y8/8mFLXftRNHnZhnYOkHt+IMvALs8LydZzraT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=g3ZNJUsR; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=2YqD1/MrlWeY4D5rvhRKHLBb5BvHMUGODl0dhwdd2xI=; b=g3ZNJUsRCw9mcHko2DNoRFGRRC
	rUGklLWUNga4Y4KyPd6BBNV7jo0aIPhNYu+cEObrTRr6vppDO5z/VZIgd8M4azdyHN3JsgU0c3x8F
	AtGkUfKt2lM/mQGdtLnnX3R1MSze7Ng2b9WDznXy+bKDesGn20nflc7sVdjOaGP/IjirsPVbKTR5C
	4gznykrA5999HAkIkCq7thLvBvMnCZx4pkruhx3e00qwR7zMJFy4ezbHkPucrsMLRTk2Qp+FFcZZx
	NDPIYO8l3pKGFJBlvk1iQyL1y1E7fkNuahJGuJ6KHlZ7uVb8huk57LX/6PEhdvyQeCU7hTc3oUB43
	q+zwnfmw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYrYZ-00000003EZ4-0Z2p;
	Mon, 07 Jul 2025 19:31:15 +0000
Date: Mon, 7 Jul 2025 20:31:15 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 20/21] __dentry_kill(): new locking scheme
Message-ID: <20250707193115.GH1880847@ZenIV>
References: <20231124060200.GR38156@ZenIV>
 <20231124060422.576198-1-viro@zeniv.linux.org.uk>
 <20231124060422.576198-20-viro@zeniv.linux.org.uk>
 <CAKPOu+_Ktbp5OMZv77UfLRyRaqmK1kUpNHNd1C=J9ihvjWLDZg@mail.gmail.com>
 <20250707172956.GF1880847@ZenIV>
 <CAKPOu+87UytVk_7S4L-y9We710j4Gh8HcacffwG99xUA5eGh7A@mail.gmail.com>
 <20250707180026.GG1880847@ZenIV>
 <CAKPOu+-QzSzUw4q18FsZFR74OJp90rs9X08gDxWnsphfwfwxoQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKPOu+-QzSzUw4q18FsZFR74OJp90rs9X08gDxWnsphfwfwxoQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jul 07, 2025 at 08:11:43PM +0200, Max Kellermann wrote:
> On Mon, Jul 7, 2025 at 8:00 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > Well, it tries to evict all non-busy dentries, along with the ones that
> > are only busy due to (non-busy) children, etc.
> 
> But why did you add code that keeps looping if a dead/killed dentry
> was found, even though there is no code to do anything with such a
> dentry?

Huh?  That dentry contributes a soon-to-be-gone reference to parent;
it's still there in the tree, but it's already in process of being
evicted.  The parent will remain busy the end of __dentry_kill().

It is *not* dead; if you want slightly distrubing metaphors, it is already
beyond resuscitation (that's what the negative refcount indicates), but
it has not finished dying yet.  DCACHE_DENTRY_KILLED in flags ==
"it's dead", and those can't be found in the tree/hash/list of aliases/etc.
Negative refcount on something found in the tree == "it's busy dying at
the moment" and parent is kept busy until that's over.

And we *want* those to be findable in the tree - think e.g. of umount.
We really don't want to progress to destroying fs-private data structures
before all dentries are disconnected from inodes, etc.

