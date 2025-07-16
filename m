Return-Path: <linux-fsdevel+bounces-55119-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E94DB0709D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 10:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B8D41881973
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 08:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E192EE982;
	Wed, 16 Jul 2025 08:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjGFTVb7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110A12EA749;
	Wed, 16 Jul 2025 08:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752654724; cv=none; b=LTYaCrc7jaZNRT3jOS+miyLLaounv2F9IzWDOJFMeNaZ6Z6ZtkEy5x0scIRgDQ0iWqfOLNPjQgJRfY6p4g5nX3zkbMTAYpEdXVoy9aad5r8ux9Yv++bZeDOo8eCcxQlzogy8qwjhj6YgRsmdIvSPMZ+Qs0ogbdyd0CRGpDc9/JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752654724; c=relaxed/simple;
	bh=pixhDAk3NXF+ez/UC4sCfxH4mfu5c2ZCe/3FOrSKxmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1JbmuQZwm0092RdX2YZ7GlHmrhDEIqFhdeWHDlSm+awzmxhyD68HsrB2c7vYn225sVKi8QFggtfDiGmfjasHezQ8Gj3OmuuvlFpEMH4AZSBThLlweJE8h+a3LAx3cn0aZ236m9eugpMK/vr2L4oBIZQo19KVEHtNN7kjqgCQfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjGFTVb7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC1AC4CEF0;
	Wed, 16 Jul 2025 08:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752654723;
	bh=pixhDAk3NXF+ez/UC4sCfxH4mfu5c2ZCe/3FOrSKxmA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TjGFTVb7WA8CXJ6fa9ZunnX0H7E3pACvrqlm6U6kufhsPuFT7/qKNj+2PuK4rf422
	 +/Vz5U7FyZF1IKEu6uwNqPHz+FJaWsNVM3NJmGFvApIa55S4kznSr5h0dOm9jqrvcS
	 ZPWl1dYW0SDaotH84/KEdVcBl9HWmemC76mRyRv1mFee8RuPfM+aSSgy4AsWsR0Jtt
	 2428KtOR29kVeXOrvqufoE3TflupQjHHf5sr6r2T2XqQCjsHhG0vGUZPWgvobe7gw3
	 YiaNk0muRgqqvpTWNR8BqdV5pCZV+sLz8AY6vym0qlT1Prz0py2hxARudlILw5soG7
	 GJGCOYu1gVsYQ==
Date: Wed, 16 Jul 2025 10:31:53 +0200
From: Christian Brauner <brauner@kernel.org>
To: Song Liu <songliubraving@meta.com>
Cc: Paul Moore <paul@paul-moore.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Song Liu <song@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, "apparmor@lists.ubuntu.com" <apparmor@lists.ubuntu.com>, 
	"selinux@vger.kernel.org" <selinux@vger.kernel.org>, 
	"tomoyo-users_en@lists.sourceforge.net" <tomoyo-users_en@lists.sourceforge.net>, 
	"tomoyo-users_ja@lists.sourceforge.net" <tomoyo-users_ja@lists.sourceforge.net>, Kernel Team <kernel-team@meta.com>, 
	"andrii@kernel.org" <andrii@kernel.org>, "eddyz87@gmail.com" <eddyz87@gmail.com>, 
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, 
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "jack@suse.cz" <jack@suse.cz>, 
	"kpsingh@kernel.org" <kpsingh@kernel.org>, "mattbobrowski@google.com" <mattbobrowski@google.com>, 
	"amir73il@gmail.com" <amir73il@gmail.com>, "repnop@google.com" <repnop@google.com>, 
	"jlayton@kernel.org" <jlayton@kernel.org>, "josef@toxicpanda.com" <josef@toxicpanda.com>, 
	"mic@digikod.net" <mic@digikod.net>, "gnoack@google.com" <gnoack@google.com>, 
	"m@maowtm.org" <m@maowtm.org>, "john.johansen@canonical.com" <john.johansen@canonical.com>, 
	"john@apparmor.net" <john@apparmor.net>, 
	"stephen.smalley.work@gmail.com" <stephen.smalley.work@gmail.com>, "omosnace@redhat.com" <omosnace@redhat.com>, 
	"takedakn@nttdata.co.jp" <takedakn@nttdata.co.jp>, 
	"penguin-kernel@i-love.sakura.ne.jp" <penguin-kernel@i-love.sakura.ne.jp>, "enlightened@chromium.org" <enlightened@chromium.org>
Subject: Re: [RFC] vfs: security: Parse dev_name before calling
 security_sb_mount
Message-ID: <20250716-unsolidarisch-sagst-e70630ddf6b7@brauner>
References: <CAHC9VhSS1O+Cp7UJoJnWNbv-Towia72DitOPH0zmKCa4PBttkw@mail.gmail.com>
 <1959367A-15AB-4332-B1BC-7BBCCA646636@meta.com>
 <20250710-roden-hosen-ba7f215706bb@brauner>
 <5EB3EFBC-69BA-49CC-B416-D4A7398A2B47@meta.com>
 <20250711-pfirsich-worum-c408f9a14b13@brauner>
 <4EE690E2-4276-41E6-9D8C-FBF7E90B9EB3@meta.com>
 <20250714-ansonsten-shrimps-b4df1566f016@brauner>
 <3ACFCAB1-9FEC-4D4E-BFB0-9F37A21AA204@meta.com>
 <20250715-knattern-hochklassig-ddc27ddd4557@brauner>
 <B2872298-BC9C-4BFD-8C88-CED88E0B7E3A@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B2872298-BC9C-4BFD-8C88-CED88E0B7E3A@meta.com>

On Tue, Jul 15, 2025 at 10:31:39PM +0000, Song Liu wrote:
> 
> > On Jul 15, 2025, at 3:18 AM, Christian Brauner <brauner@kernel.org> wrote:
> > On Mon, Jul 14, 2025 at 03:10:57PM +0000, Song Liu wrote:
> 
> 
> [...]
> 
> >>> If you place a new security hook into __do_loopback() the only thing
> >>> that I'm not excited about is that we're holding the global namespace
> >>> semaphore at that point. And I want to have as little LSM hook calls
> >>> under the namespace semaphore as possible.
> >> 
> >> do_loopback() changed a bit since [1]. But if we put the new hook 
> >> in do_loopback() before lock_mount(), we don’t have the problem with
> >> the namespace semaphore, right? Also, this RFC doesn’t seem to have 
> >> this issue either.
> > 
> > While the mount isn't locked another mount can still be mounted on top
> > of it. lock_mount() will detect this and lookup the topmost mount and
> > use that. IOW, the value of old_path->mnt may have changed after
> > lock_mount().
> 
> I am probably confused. Do you mean path->mnt (instead of old_path->mnt) 
> may have changed after lock_mount()? 

I mean the target path. I forgot that the code uses @old_path to mean
the source path not the target path. And you're interested in the source
path, not the target path.

> 
> > If you have 1000 containers each calling into
> >>> security_something_something_bind_mount() and then you do your "walk
> >>> upwards towards the root stuff" and that root is 100000 directories away
> >>> you've introduced a proper DOS or at least a severe new bottleneck into
> >>> the system. And because of mount namespace propagation that needs to be
> >>> serialized across all mount namespaces the namespace semaphore isn't
> >>> something we can just massage away.
> >> 
> >> AFAICT, a poorly designed LSM can easily DoS a system. Therefore, I 
> >> don’t think we need to overthink about a LSM helper causing DoS in 
> >> some special scenarios. The owner of the LSM, either built-in LSM or 
> >> BPF LSM, need to be aware of such risks and design the LSM rules 
> >> properly to avoid DoS risks. For example, if the path tree is really 
> >> deep, the LSM may decide to block the mount after walking a preset 
> >> number of steps.
> > 
> > The scope of the lock matters _a lot_. If a poorly designed LSM happens
> > to take exorbitant amount of time under the inode_lock() it's annoying:
> > to anyone else wanting to grab the inode_lock() _for that single inode_.
> > 
> > If a poorly designed LSM does broken stuff under the namespace semaphore
> > any mount event on the whole system will block, effectively deadlocking
> > the system in an instant. For example, if anything even glances at
> > /proc/<pid>/mountinfo it's game over. It's already iffy that we allow
> > security_sb_statfs() under there but that's at least guaranteed to be
> > fast.
> > 
> > If you can make it work so that we don't have to place security_*()
> > under the namespace semaphore and you can figure out how to deal with a
> > potential overmount racing you then this would be ideal for everyone.
> 
> I am trying to understand all the challenges here. 

As long as you're only interested in the source path's mount, you're
fine.

> 
> It appears to me that do_loopback() has the tricky issue:
> 
> static int do_loopback(struct path *path, ...)
> {
> 	...
> 	/* 
> 	 * path may still change, so not a good point to add
> 	 * security hook 
> 	 */
> 	mp = lock_mount(path);
> 	if (IS_ERR(mp)) {
> 		/* ... */
> 	}
> 	/* 
> 	 * namespace_sem is locked, so not a good point to add
> 	 * security hook
> 	 */
> 	...
> }
> 
> Basically, without major work with locking, there is no good 
> spot to insert a security hook into do_loopback(). Or, maybe 
> we can add a hook somewhere in lock_mount()? 

You can't really because the lookup_mnt() call in lock_mount() happens
under the namespace semaphore already and if it's the topmost mount it
won't be dropped again and you can't drop it again without risking
overmounts again.

But again, as long as you are interested in the source mount you should
be fine.

