Return-Path: <linux-fsdevel+bounces-53071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CFAAE9A68
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 11:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6D131C4137C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 09:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81753295DAD;
	Thu, 26 Jun 2025 09:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Es/nqOpR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [45.157.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A31239E79
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jun 2025 09:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750931441; cv=none; b=RLEyGb4akLt97Qc8Wwa5WWijoq1oNS9X3VbFRTKtY8T0NME0rHJ24D1y+/qef3A839a2JSjH+0dvjV55JbhG4Q7uCdIBCm2oBxqqWHhMOUSCEX/kM2vcwzBNufIVg0IEx8t8eB6n//l5L9N3a39OTqpWXdppaNZQlewcNj7Wc8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750931441; c=relaxed/simple;
	bh=jxrqVWlNu9OTIwE5HUzDPcHmbqs+mlSWJ9SdYDE/kkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8QOfrJSzoGNDvnQsVs/qsgGbPVUf/xbGA7jLE/QtKg2KwQ8be9p9CuziVfQmf0KQtoZ5KquLJ47KmfpjEggyU0gXMlyIL+MjsKA2pvgjFaR/lg77PAo1dYHOwXAd6jjJh+2KRXhklMDdUaizTP8ZTlC65v8zACJsOvinnCKlYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Es/nqOpR; arc=none smtp.client-ip=45.157.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bSYfb3HJLzhXX;
	Thu, 26 Jun 2025 11:43:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1750931031;
	bh=Z/uNTZquS++80fsem6ySxdoivWSYkihrZf+FpIs4Vc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Es/nqOpRPK/X1DZtD1Gki12xHc9rguh5Tr/5wSoWATCvAdcpwUj3sD1lOKTUluF5A
	 64ftEmAcWVYq1zaSH8n3Lt90Nzvkm5fwKfciI3XCP2n3ocopQ7l1la8Acyr19ljcu9
	 mbE74nvsOmrC1MEW70Jjmitphhon/2VSjabNGBQs=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4bSYfZ1m9czlKv;
	Thu, 26 Jun 2025 11:43:50 +0200 (CEST)
Date: Thu, 26 Jun 2025 11:43:49 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Song Liu <songliubraving@meta.com>
Cc: NeilBrown <neil@brown.name>, Tingmao Wang <m@maowtm.org>, 
	Song Liu <song@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, "brauner@kernel.org" <brauner@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, "andrii@kernel.org" <andrii@kernel.org>, 
	"eddyz87@gmail.com" <eddyz87@gmail.com>, "ast@kernel.org" <ast@kernel.org>, 
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "martin.lau@linux.dev" <martin.lau@linux.dev>, 
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "jack@suse.cz" <jack@suse.cz>, 
	"kpsingh@kernel.org" <kpsingh@kernel.org>, "mattbobrowski@google.com" <mattbobrowski@google.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Subject: Re: [PATCH v5 bpf-next 0/5] bpf path iterator
Message-ID: <20250626.eifo4iChohWo@digikod.net>
References: <4577db64-64f2-4102-b00e-2e7921638a7c@maowtm.org>
 <175089992300.2280845.10831299451925894203@noble.neil.brown.name>
 <9BD19ABC-08B8-4976-912D-DFCC06C29CAA@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9BD19ABC-08B8-4976-912D-DFCC06C29CAA@meta.com>
X-Infomaniak-Routing: alpha

On Thu, Jun 26, 2025 at 05:52:50AM +0000, Song Liu wrote:
> 
> 
> > On Jun 25, 2025, at 6:05 PM, NeilBrown <neil@brown.name> wrote:
> 
> [...]
> 
> >> 
> >> I can't speak for Mickaël, but a callback-based interface is less flexible
> >> (and _maybe_ less performant?).  Also, probably we will want to fallback
> >> to a reference-taking walk if the walk fails (rather than, say, retry
> >> infinitely), and this should probably use Song's proposed iterator.  I'm
> >> not sure if Song would be keen to rewrite this iterator patch series in
> >> callback style (to be clear, it doesn't necessarily seem like a good idea
> >> to me, and I'm not asking him to), which means that we will end up with
> >> the reference walk API being a "call this function repeatedly", and the
> >> rcu walk API taking a callback.  I think it is still workable (after all,
> >> if Landlock wants to reuse the code in the callback it can just call the
> >> callback function itself when doing the reference walk), but it seems a
> >> bit "ugly" to me.
> > 
> > call-back can have a performance impact (less opportunity for compiler
> > optimisation and CPU speculation), though less than taking spinlock and
> > references.  However Al and Christian have drawn a hard line against
> > making seq numbers visible outside VFS code so I think it is the
> > approach most likely to be accepted.
> > 
> > Certainly vfs_walk_ancestors() would fallback to ref-walk if rcu-walk
> > resulted in -ECHILD - just like all other path walking code in namei.c.
> > This would be largely transparent to the caller - the caller would only
> > see that the callback received a NULL path indicating a restart.  It
> > wouldn't need to know why.

Given the constraints this looks good to me.  Here is an updated API
with two extra consts, an updated walk_cb() signature, and a new
"flags" and without @root:

int vfs_walk_ancestors(struct path *path,
                       bool (*walk_cb)(const struct path *ancestor, void *data),
                       void *data, int flags)

The walk continue while walk_cb() returns true.  walk_cb() can then
check if @ancestor is equal to a @root, or other properties.  The
walk_cb() return value (if not bool) should not be returned by
vfs_walk_ancestors() because a walk stop doesn't mean an error.

@path would be updated with latest ancestor path (e.g. @root).
@flags could contain LOOKUP_RCU or not, which enables us to have
walk_cb() not-RCU compatible.

When passing LOOKUP_RCU, if the first call to vfs_walk_ancestors()
failed with -ECHILD, the caller can restart the walk by calling
vfs_walk_ancestors() again but without LOOKUP_RCU.

> 
> I guess I misunderstood the proposal of vfs_walk_ancestors() 
> initially, so some clarification:
> 
> I think vfs_walk_ancestors() is good for the rcu-walk, and some 
> rcu-then-ref-walk. However, I don’t think it fits all use cases. 
> A reliable step-by-step ref-walk, like this set, works well with 
> BPF, and we want to keep it. 

The above updated API should work for both use cases: if the caller wants
to walk only one level, walk_cb() can just always return false (and
potentially save that it was called) and then stop the walk the first
time it is called.  This makes it possible to write an eBPF helper with
the same API as path_walk_parent(), while making the kernel API more
flexible.

> 
> Can we ship this set as-is (or after fixing the comment reported
> by kernel test robot)? I really don’t think we need figure out 
> all details about the rcu-walk here. 
> 
> Once this is landed, we can try implementing the rcu-walk
> (vfs_walk_ancestors or some variation). If no one volunteers, I
> can give it a try. 

My understanding is that Christian only wants one helper (that should
handle both use cases).  I think this updated API should be good enough
for everyone.  Most of your code should stay the same.  What do you
think?

> 
> Thanks,
> Song
> 

