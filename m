Return-Path: <linux-fsdevel+bounces-5745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F8280F8CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 21:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03CE21C20DE0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 20:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41CA65A7F;
	Tue, 12 Dec 2023 20:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mGCZv0XN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [IPv6:2001:41d0:1004:224b::bb])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324A7DC
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 12:59:34 -0800 (PST)
Date: Tue, 12 Dec 2023 15:59:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702414772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5KnN3ljfuTYGp9hX2FLbp07YKOMtvTUvRo4r4xNC1+A=;
	b=mGCZv0XNDsrnIOKoYYmeNDldBZbDfUVOSv1o6hJwMCztonxRRPQBZufza3Ct0vwWfchC2H
	NrkwFImiF5Qd+ZNuZuZORo2rCg63/QNnSrPNUzGYeWqCQwqCfHhSY7P2d/dLjHzgbw7xPJ
	fAgPpxpL/4RNo6TiSJhQanW9fBwZOCI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: David Howells <dhowells@redhat.com>
Cc: NeilBrown <neilb@suse.de>, Donald Buczek <buczek@molgen.mpg.de>,
	linux-bcachefs@vger.kernel.org,
	Stefan Krueger <stefan.krueger@aei.mpg.de>,
	linux-fsdevel@vger.kernel.org
Subject: Re: file handle in statx (was: Re: How to cope with subvolumes and
 snapshots on muti-user systems?)
Message-ID: <20231212205929.op6tq3pqobwmix5a@moria.home.lan>
References: <170181366042.7109.5045075782421670339@noble.neil.brown.name>
 <97375d00-4bf7-4c4f-96ec-47f4078abb3d@molgen.mpg.de>
 <170199821328.12910.289120389882559143@noble.neil.brown.name>
 <20231208013739.frhvlisxut6hexnd@moria.home.lan>
 <170200162890.12910.9667703050904306180@noble.neil.brown.name>
 <20231208024919.yjmyasgc76gxjnda@moria.home.lan>
 <630fcb48-1e1e-43df-8b27-a396a06c9f37@molgen.mpg.de>
 <20231208200247.we3zrwmnkwy5ibbz@moria.home.lan>
 <170233460764.12910.276163802059260666@noble.neil.brown.name>
 <2799307.1702338016@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2799307.1702338016@warthog.procyon.org.uk>
X-Migadu-Flow: FLOW_OUT

On Mon, Dec 11, 2023 at 11:40:16PM +0000, David Howells wrote:
> Kent Overstreet <kent.overstreet@linux.dev> wrote:
> 
> > I was chatting a bit with David Howells on IRC about this, and floated
> > adding the file handle to statx. It looks like there's enough space
> > reserved to make this feasible - probably going with a fixed maximum
> > size of 128-256 bits.
> 
> We can always save the last bit to indicate extension space/extension record,
> so we're not that strapped for space.

So we'll need that if we want to round trip NFSv4 filehandles, they
won't fit in existing struct statx (nfsv4 specs 128 bytes, statx has 96
bytes reserved).

Obvious question (Neal): do/will real world implementations ever come
close to making use of this, or was this a "future proofing gone wild"
thing?

Say we do decide we want to spec it that large: _can_ we extend struct
statx? I'm wondering if the userspace side was thought through, I'm
sure glibc people will have something to say.

Kernel side we can definitely extend struct statx, and we know how many
bytes to copy to userspace because we know what fields userspace
requested. The part I'm concerned about is that if we extend userspace's
struct statx, that introduces obvious ABI compabitibility issues.

So this would probably force glibc to introduce a new version of struct
statx, if I'm not mistaken.

Or: another option would be to reserve something small and sane in
struct statx (32 bytes max, I'd say), and then set a flag to tell
userspace they need to use name_to_handle_at() if it didn't fit.

