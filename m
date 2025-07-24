Return-Path: <linux-fsdevel+bounces-55961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3693B1107C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 19:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 249A15A7862
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 17:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6359B2EBBA2;
	Thu, 24 Jul 2025 17:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="YBkgsVL/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D3A1922FB
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Jul 2025 17:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753379099; cv=none; b=SkW6Uik6L5FVgN4rzPEhIlwOaUXC+kp5QRPFs1XIczI8VLlznQa/0pvz879unvgs3tC64OfXKXK4F6Y4FdhSa/5UYGp0UnCzNYGJFAIAOOvzRfl9PpItPprNTw2XeB+rsBoYopwn0GIaiXkGHaBVjGrDaLQ0evfSmVRgt/McIJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753379099; c=relaxed/simple;
	bh=D2M/54N8zJdjcIvoq97yxEel8qGk9C9JommktQkhxgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEH7a22T2jb4a9AEGR0yloSiAkbHtxoPLDaR6K86zB8C03BQBPvfCwwMW0eSDqDj1Vow8IAb26ijMKa9fNqo2clTg9Pr8Bya3Q2JI+jHNbVWsvPda0ToQi8VxJjLdtYZX5Mcp8w2g07Z3tcJUpQv1f7Z3oHdveFVMm6a2Hc948U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=YBkgsVL/; arc=none smtp.client-ip=83.166.143.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bnypN0JkbzZFV;
	Thu, 24 Jul 2025 19:35:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1753378555;
	bh=HbR89xL0fAs890Zk4g+qtVNW0JcpnRM+e9fsbsymfzQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YBkgsVL/y/clichoX+1MWFq35vB9gAha7jDqPq3GNLrkjbKlA1dq6EwQchjig3Ci8
	 1bVaB4Cpj8L7lWGdAH8lrtKArewe0lM3Jz3rrUKQXRafhD7sUaeYYpZz5YKndRT1d/
	 0GR03WaeVnf4t+P7BIXoYtfVPSaXZzE1AIK6HLJg=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4bnypM0b6NzxQB;
	Thu, 24 Jul 2025 19:35:55 +0200 (CEST)
Date: Thu, 24 Jul 2025 19:35:54 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Song Liu <songliubraving@meta.com>
Cc: NeilBrown <neil@brown.name>, Christian Brauner <brauner@kernel.org>, 
	Tingmao Wang <m@maowtm.org>, Song Liu <song@kernel.org>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, Kernel Team <kernel-team@meta.com>, 
	"andrii@kernel.org" <andrii@kernel.org>, "eddyz87@gmail.com" <eddyz87@gmail.com>, 
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, 
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, 
	"jack@suse.cz" <jack@suse.cz>, "kpsingh@kernel.org" <kpsingh@kernel.org>, 
	"mattbobrowski@google.com" <mattbobrowski@google.com>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Jann Horn <jannh@google.com>
Subject: Re: [PATCH v5 bpf-next 0/5] bpf path iterator
Message-ID: <20250724.ij7AhF9quoow@digikod.net>
References: <474C8D99-6946-4CFF-A925-157329879DA9@meta.com>
 <175210911389.2234665.8053137657588792026@noble.neil.brown.name>
 <B33A07A6-6133-486D-B333-970E1C4C5CA3@meta.com>
 <2243B959-AA11-4D24-A6D0-0598E244BE3E@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2243B959-AA11-4D24-A6D0-0598E244BE3E@meta.com>
X-Infomaniak-Routing: alpha

On Mon, Jul 14, 2025 at 09:09:42PM +0000, Song Liu wrote:
> 
> > On Jul 9, 2025, at 11:28 PM, Song Liu <songliubraving@meta.com> wrote:
> 
> [...]
> 
> >>>> It isn't clear to me that vfs_walk_ancestors() needs to return anything.
> >>>> All the communication happens through walk_cb()
> >>>> 
> >>>> walk_cb() is called with a path, the data, and a "may_sleep" flag.
> >>>> If it needs to sleep but may_sleep is not set, it returns "-ECHILD"
> >>>> which causes the walk to restart and use refcounts.
> >>>> If it wants to stop, it returns 0.
> >>>> If it wants to continue, it returns 1.
> >>>> If it wants a reference to the path then it can use (new)
> >>>> vfs_legitimize_path() which might fail.
> >>>> If it wants a reference to the path and may_sleep is true, it can use
> >>>> path_get() which won't fail.
> >>>> 
> >>>> When returning -ECHILD (either because of a need to sleep or because
> >>>> vfs_legitimize_path() fails), walk_cb() would reset_data().
> >>> 
> >>> This might actually work. 
> >>> 
> >>> My only concern is with vfs_legitimize_path. It is probably safer if 
> >>> we only allow taking references with may_sleep==true, so that path_get
> >>> won’t fail. In this case, we will not need walk_cb() to call 
> >>> vfs_legitimize_path. If the user want a reference, the walk_cb will 
> >>> first return -ECHILD, and call path_get when may_sleep is true.
> >> 
> >> What is your concern with vfs_legitimize_path() ??
> >> 
> >> I've since realised that always restarting in response to -ECHILD isn't
> >> necessary and isn't how normal path-walk works.  Restarting might be
> >> needed, but the first response to -ECHILD is to try legitimize_path().
> >> If that succeeds, then it is safe to sleep.
> >> So returning -ECHILD might just result in vfs_walk_ancestors() calling
> >> legitimize_path() and then calling walk_cb() again.  Why not have
> >> walk_cb() do the vfs_legitimize_path() call (which will almost always
> >> succeed in practice).
> > 
> > After reading the emails and the code more, I think I misunderstood 
> > why we need to call vfs_legitimize_path(). The goal of “legitimize” 
> > is to get a reference on @path, so a reference-less walk may not
> > need legitimize_path() at all. Do I get this right this time? 
> > 
> > However, I still have some concern with legitimize_path: it requires
> > m_seq and r_seq recorded at the beginning of the walk, do we want
> > to pass those to walk_cb()? IIUC, one of the reason we prefer a 
> > callback based solution is that it doesn’t expose nameidata (or a
> > subset of it). Letting walk_cb to call legitimize_path appears to 
> > defeat this benefit, no? 

Yes, walk_cb() should be very light and non-blocking/non-sleepable.  If
the caller cannot give these guarantees, then it can just pass NULL
instead of a valid walk_cb(), and continue the walk (if needed) by
calling the vfs_walk_ancentors() helper again, which would not benefit
from the RCU optimization in this case.

Before this patch series land, handling of disconnected directories
should be well defined, or at least let the caller deal with it.  How do
you plan to handle disconnected directories for the eBPF use case?  See
https://lore.kernel.org/all/20250719104204.545188-1-mic@digikod.net/
Unfortunately, this issue is not solved for Landlock yet.

> > 
> > 
> > A separate question below. 
> > 
> > I still have some question about how vfs_walk_ancestors() and the 
> > walk_cb() interact. Let’s look at the landlock use case: the user 
> > (landlock) just want to look at each ancestor, but doesn’t need to 
> > take any references. walk_cb() will check @path against @root, and 
> > return 0 when @path is the same as @root. 
> > 
> > IIUC, in this case, we will record m_seq and r_seq at the beginning
> > of vfs_walk_ancestors(), and check them against mount_lock and 
> > rename_lock at the end of the walk. (Maybe we also need to check 
> > them at some points before the end of the walk?) If either seq
> > changed during the walk, we need to restart the walk, and take
> > reference on each step. Did I get this right so far? 

I think so.  You should get some inspiration from prepend_path().

> > 
> > If the above is right, here are my questions about the 
> > reference-less walk above: 
> > 
> > 1. Which function (vfs_walk_ancestors or walk_cb) will check m_seq 
> >   and r_seq? I think vfs_walk_ancestors should check them. 

Yes, walk_cb() should be as simple as possible: the simpler version
should just return a constant.

> > 2. When either seq changes, which function will call reset_data?
> >   I think there are 3 options here:
> >  2.a: vfs_walk_ancestors calls reset_data, which will be another
> >       callback function the caller passes to vfs_walk_ancestors. 
> >  2.b: walk_cb will call reset_data(), but we need a mechanism to
> >       tell walk_cb to do it, maybe a “restart” flag?
> >  2.c: Caller of vfs_walk_ancestors will call reset_data(). In 
> >       this case, vfs_walk_ancestors will return -ECHILD to its
> >       caller. But I think this option is NACKed. 
> > 
> > I think the right solution is to have vfs_walk_ancestors check
> > m_seq and r_seq, and have walk_cb call reset_data. But this is
> > Different to the proposal above. 

I'm not sure a reset_data() would be useful if walk_cb() never sleep.

If we really need such reset_data(), a fourth option would be for
walk_cb() to return a specific value (an enum instead of a bool) to
trigger the reset.

> > 
> > Do my questions above make any sense? Or maybe I totally 
> > misunderstood something?
> 
> Hi Neil, 
> 
> Did my questions/comments above make sense? I am hoping we can 
> agree on some design soon. 
> 
> Christian and Mickaël, 
> 
> Could you please also share your thoughts on this?
> 
> Current requirements from BPF side is straightforward: we just
> need a mechanism to “walk up one level and hold reference”. So
> most of the requirement comes from LandLock side. 

Have you thought about how to handle disconnected directories?

> 
> Thanks,
> Song
> 

