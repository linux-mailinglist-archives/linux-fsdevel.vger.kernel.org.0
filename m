Return-Path: <linux-fsdevel+bounces-73203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F26B2D11993
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 10:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA2063059924
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 09:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A042749D2;
	Mon, 12 Jan 2026 09:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EH3TaVVu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6416F27145F;
	Mon, 12 Jan 2026 09:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768211153; cv=none; b=iQdsHQYHNkAfJyBj3nrL21AzJ7ctKby5hs7Qa+DiK5XDquXP6WdubQ84yHGoaGljNe4UWh3kqUcpd2i70TbHvGofHhIt+IgkrbW8SSqRc7uaNz5Plx/43gW3SvVOD0zwX0+DGJMgAaeBMpfcJC2zqk96aahwkpXuXhpOhslIEYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768211153; c=relaxed/simple;
	bh=cHg0HkRiQ+aLyaTwC6nw3bp9LBVMtpjUHYe2eJQf2N8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKj0lLFczYlDMqE1tMX6jLeHHg9mIf5eGDn9QbkXKdJUO7LwGIF84X26F/s9qqkdt3kIjPVYLw+yc911cz3KzotmTRVkiXh8dFyQoS5MIX46x3sNuQCqjMToViVIqt74tZ4aNf3S1OWyxQnx7DRuT2QAODE6nFhlR87dh+PtPGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EH3TaVVu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E819C116D0;
	Mon, 12 Jan 2026 09:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768211152;
	bh=cHg0HkRiQ+aLyaTwC6nw3bp9LBVMtpjUHYe2eJQf2N8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EH3TaVVuw+RtKndrI239BmeJJ0+rGrf+JKyDBVJAJEUr7eHmqHktORY6C2bkv7uKT
	 fbTMbxPbT5W0JQCt2fhDz7QosNhfHDIQvqX7kqz31YOVRard1mUAZJgiDqXJECEUxH
	 Tu4jknDaawzupGpAJjTPqrB5u68Eb+saECE6bVfDdtFLvXYrnTrzQeaI/c6P0TR2vT
	 lfI0HqOAbl1M0gX9B6d+qRq+4J6HJR159HvfNKQc0N/JYj+K8wInqfhRt/sP9Hbqv4
	 HIa4j9ZK7Xz7X1n1Y4hq4QvkpK8pP+esDTtLfQSYJ3IMnoUIH8UmZ7kk6H7vdrRAK7
	 pGlCq9q0gs7cQ==
Date: Mon, 12 Jan 2026 10:45:49 +0100
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Bernd Schubert <bernd@bsbernd.com>, 
	Thorsten Leemhuis <linux@leemhuis.info>, Miklos Szeredi <miklos@szeredi.hu>, 
	Linux kernel regressions list <regressions@lists.linux.dev>, LKML <linux-kernel@vger.kernel.org>, 
	Linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [REGRESSION] fuse: xdg-document-portal gets stuck and causes
 suspend to fail in mainline
Message-ID: <20260112-textil-bepflanzen-c6225a477747@brauner>
References: <7d4ac21f-491f-4f0a-bc50-7601cd1140ca@leemhuis.info>
 <ff46166e-6795-4cab-bfef-d0724200bc62@bsbernd.com>
 <176819030053.16766.15730807505551833487@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <176819030053.16766.15730807505551833487@noble.neil.brown.name>

On Mon, Jan 12, 2026 at 02:58:20PM +1100, NeilBrown wrote:
> On Mon, 12 Jan 2026, Bernd Schubert wrote:
> > 
> > On 1/11/26 12:37, Thorsten Leemhuis wrote:
> > > Lo! I can reliably get xdg-document-portal stuck on latest -mainline
> > > (and -next, too; 6.18.4. works fine) trough the Signal flatpak, which
> > > then causes suspend to fail:
> > > 
> > > """
> > >> [  194.439381] PM: suspend entry (s2idle)
> > >> [  194.454708] Filesystems sync: 0.015 seconds
> > >> [  194.696767] Freezing user space processes
> > >> [  214.700978] Freezing user space processes failed after 20.004 seconds (1 tasks refusing to freeze, wq_busy=0):
> > >> [  214.701143] task:xdg-document-po state:D stack:0     pid:2651  tgid:2651  ppid:1939   task_flags:0x400000 flags:0x00080002
> > >> [  214.701151] Call Trace:
> > >> [  214.701154]  <TASK>
> > >> [  214.701167]  __schedule+0x2b8/0x5e0
> > >> [  214.701181]  schedule+0x27/0x80
> > >> [  214.701188]  request_wait_answer+0xce/0x260 [fuse]
> > >> [  214.701202]  ? __pfx_autoremove_wake_function+0x10/0x10
> > >> [  214.701212]  __fuse_simple_request+0x120/0x340 [fuse]
> > >> [  214.701219]  fuse_lookup_name+0xc3/0x210 [fuse]
> > >> [  214.701235]  fuse_lookup+0x99/0x1c0 [fuse]
> > >> [  214.701242]  ? srso_alias_return_thunk+0x5/0xfbef5
> > >> [  214.701247]  ? fuse_dentry_init+0x23/0x50 [fuse]
> > >> [  214.701257]  lookup_one_qstr_excl+0xa8/0xf0
> > 
> > Introduced by c9ba789dad15 ("VFS: introduce start_creating_noperm() and
> > start_removing_noperm()")?
> > 
> > Why is the new code doing a lookup on an entry that is about to be
> > invalidated?
> > 
> > 
> > In order to handle this at least one fuse server process needs to be
> > available, but for this specific case the lookup still doesn't make sense.
> > 
> > We could do something like this
> > 
> > diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> > index 4b6b3d2758ff..7edbace7eddc 100644
> > --- a/fs/fuse/dir.c
> > +++ b/fs/fuse/dir.c
> > @@ -1599,6 +1599,15 @@ int fuse_reverse_inval_entry(struct fuse_conn
> > *fc, u64 parent_nodeid,
> >         if (!dir)
> >                 goto put_parent;
> > 
> > +       /* Check dcache first - if not cached, nothing to invalidate */
> > +       name->hash = full_name_hash(dir, name->name, name->len);
> > +       entry = d_lookup(dir, name);
> > +       if (!entry) {
> > +               err = 0;
> > +               dput(dir);
> > +               goto put_parent;
> > +       }
> > +
> >         entry = start_removing_noperm(dir, name);
> >         dput(dir);
> >         if (IS_ERR(entry))
> > 
> > 
> > But let's assume the dentry exists - start_removing_noperm() will now
> > trigger a revalidate and get the same issue. From my point of view the
> > above commit should be reverted for fuse.
> > 
> > 
> > >> [  214.701264]  start_removing_noperm+0x59/0x80
> > >> [  214.701268]  ? d_find_alias+0x82/0xd0
> > >> [  214.701273]  fuse_reverse_inval_entry+0x7d/0x1f0 [fuse]
> > >> [  214.701280]  ? fuse_copy_do+0x5f/0xa0 [fuse]
> > >> [  214.701287]  fuse_notify+0x4a1/0x750 [fuse]
> > >> [  214.701295]  ? iov_iter_get_pages2+0x1d/0x40
> > >> [  214.701301]  ? srso_alias_return_thunk+0x5/0xfbef5
> > >> [  214.701305]  fuse_dev_do_write+0x2e4/0x440 [fuse]
> > >> [  214.701313]  fuse_dev_write+0x6b/0xa0 [fuse]
> > >> [  214.701320]  do_iter_readv_writev+0x161/0x260
> > >> [  214.701327]  vfs_writev+0x168/0x3c0
> > >> [  214.701334]  ? ksys_write+0xcd/0xf0
> > >> [  214.701338]  ? do_writev+0x7f/0x110
> > >> [  214.701341]  do_writev+0x7f/0x110
> > >> [  214.701344]  do_syscall_64+0x7e/0x6b0
> > >> [  214.701350]  ? srso_alias_return_thunk+0x5/0xfbef5
> > >> [  214.701352]  ? __handle_mm_fault+0x445/0x690
> > >> [  214.701359]  ? srso_alias_return_thunk+0x5/0xfbef5
> > >> [  214.701363]  ? srso_alias_return_thunk+0x5/0xfbef5
> > >> [  214.701365]  ? count_memcg_events+0xd6/0x210
> > >> [  214.701371]  ? srso_alias_return_thunk+0x5/0xfbef5
> > >> [  214.701373]  ? handle_mm_fault+0x212/0x340
> > >> [  214.701377]  ? srso_alias_return_thunk+0x5/0xfbef5
> > >> [  214.701379]  ? do_user_addr_fault+0x2b4/0x7b0
> > >> [  214.701387]  ? srso_alias_return_thunk+0x5/0xfbef5
> > >> [  214.701389]  ? irqentry_exit+0x6d/0x540
> > >> [  214.701393]  ? srso_alias_return_thunk+0x5/0xfbef5
> > >> [  214.701395]  ? exc_page_fault+0x7e/0x1a0
> > >> [  214.701398]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > >> [  214.701402] RIP: 0033:0x7f3c144f9982
> > >> [  214.701467] RSP: 002b:00007fff80e2f388 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
> > >> [  214.701470] RAX: ffffffffffffffda RBX: 00007f3bec000cf0 RCX: 00007f3c144f9982
> > >> [  214.701472] RDX: 0000000000000003 RSI: 00007fff80e2f460 RDI: 0000000000000007
> > >> [  214.701474] RBP: 00007fff80e2f3b0 R08: 0000000000000000 R09: 0000000000000000
> > >> [  214.701475] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > >> [  214.701477] R13: 00007f3bec000cf0 R14: 00007f3c14bb8280 R15: 00007f3be8001200
> > >> [  214.701481]  </TASK>
> > > """
> > > 
> > > Killing the mentioned process using "kill -9" doesn't help. I can
> > > reliably trigger this in -mainline and -next using the Signal flatpak on
> > > Fedora 43 by trying to send a picture (which gets xdg-document-portal
> > > involved). It works the first time, but trying again won't and will
> > > cause Signal to get stuck for a few seconds. Works fine in 6.18.4.
> > > 
> > > Is this maybe known already or does anybody have an idea what's wrong?
> > > If not I guess I'll have to bisect this.
> > > 
> > > Ciao, Thorsten
> > > 
> > > #regzbot introduced: v6.18..
> > > #regzbot title: fuse: xdg-document-portal gets stuck and causes suspend
> > > to fail
> > > 
> > > 
> > 
> > Thanks,
> > Bernd
> > 
> 
> I post a fix
> 
>   https://lore.kernel.org/all/176454037897.634289.3566631742434963788@noble.neil.brown.name/
> 
> a while ago.  There was some talk in that thread of reverting the
> breaking change instead.  I seems nothing happened.

I pinged a bunch of times but nobody ever responded.
So then let's just apply your patch. I picked it up.

