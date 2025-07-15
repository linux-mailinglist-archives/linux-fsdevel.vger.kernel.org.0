Return-Path: <linux-fsdevel+bounces-54938-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D3AB057A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 12:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73A071706D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 10:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5FE2D7806;
	Tue, 15 Jul 2025 10:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ck0fVEUx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE442475E3;
	Tue, 15 Jul 2025 10:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752574690; cv=none; b=bjNXVF5C4DqZBLeTSH2R8haK0wu0CMBw5wwWFZtNAISP5UdwqzYJZ4bgKfE42zk4PrzpIlQ5tb+f2Hel0nIAVzyU+3Gn9XN5pTpx0PG29yxEXXxPqqhfWWzzNtNKyHBwX0/ZvLn2bz5RwEywASJ2tM2+cAtjymYnkwCAadh8TSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752574690; c=relaxed/simple;
	bh=MR6q/geuJGxm8/wZrl4YYFQ5XKIXGNHi6Rtqi170EHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TAvC6Clas2hB+YjVdcnw1d98UQxaWL1gsVyrNSvtflsXJcdsozSfjobp2BywserIoI2zFWZJGPGGrKoYaWJM2RniDDA/AUauAuTMQiEj4rZMGgngm0kQddvsoKKBV+5swyOZW9clRmX1LCjrRieY5CoKAhKTtzGLDwZuluDb3t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ck0fVEUx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24204C4CEE3;
	Tue, 15 Jul 2025 10:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752574689;
	bh=MR6q/geuJGxm8/wZrl4YYFQ5XKIXGNHi6Rtqi170EHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ck0fVEUx2KEdhj3ok/Wm3DEMI8e6ZuXmmpXA3SZqyaJvVSHhT3egfr19RmV/Hxb9h
	 qSal6nwSBBvrSJflFMO2kgf1nM6PQcW6mUB98MntVpxFOsTciA9HSfw8LGddZHfBmI
	 d3PZk2nb0z341rntBAMatM766ucxWLO90DGo3rI7iCyWYYFmkUwWcMTNjwq9PquYWt
	 TFFMi/rSJAkAkZOMedTK4AFTdRF9xf/Mh4IuqNl3bhl+8yXQbWGWb2V9SSt7RJ3aag
	 pL64AaDUiV4SkQ35D4DqGAq/XApDsXJOLiHLAb2yX2K4bNdhLWa16/M9b1B4ue0zuF
	 YLbkb54PyprIQ==
Date: Tue, 15 Jul 2025 12:18:00 +0200
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
Message-ID: <20250715-knattern-hochklassig-ddc27ddd4557@brauner>
References: <20250708230504.3994335-1-song@kernel.org>
 <20250709102410.GU1880847@ZenIV>
 <CAHC9VhSS1O+Cp7UJoJnWNbv-Towia72DitOPH0zmKCa4PBttkw@mail.gmail.com>
 <1959367A-15AB-4332-B1BC-7BBCCA646636@meta.com>
 <20250710-roden-hosen-ba7f215706bb@brauner>
 <5EB3EFBC-69BA-49CC-B416-D4A7398A2B47@meta.com>
 <20250711-pfirsich-worum-c408f9a14b13@brauner>
 <4EE690E2-4276-41E6-9D8C-FBF7E90B9EB3@meta.com>
 <20250714-ansonsten-shrimps-b4df1566f016@brauner>
 <3ACFCAB1-9FEC-4D4E-BFB0-9F37A21AA204@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3ACFCAB1-9FEC-4D4E-BFB0-9F37A21AA204@meta.com>

On Mon, Jul 14, 2025 at 03:10:57PM +0000, Song Liu wrote:
> 
> 
> > On Jul 14, 2025, at 1:45 AM, Christian Brauner <brauner@kernel.org> wrote:
> > 
> > On Fri, Jul 11, 2025 at 04:22:52PM +0000, Song Liu wrote:
> >> 
> >> 
> >>> On Jul 11, 2025, at 2:36 AM, Christian Brauner <brauner@kernel.org> wrote:
> >> 
> >> [...]
> >> 
> >>>>> 
> >>>> To make sure I understand the comment. By “new mount api”, do you mean 
> >>>> the code path under do_new_mount()?
> >>> 
> >>> fsopen()
> >>> fsconfig()
> >>> fsmount()
> >>> open_tree()
> >>> open_tree_attr()
> >>> move_mount()
> >>> statmount()
> >>> listmount()
> >>> 
> >>> I think that's all.
> >> 
> >> Thanks for the clarification and pointer!
> >> 
> >>> 
> >>>> 
> >>>>> My recommendation is make a list of all the currently supported
> >>>>> security_*() hooks in the mount code (I certainly don't have them in my
> >>>>> head). Figure out what each of them allow to mediate effectively and how
> >>>>> the callchains are related.
> >>>>> 
> >>>>> Then make a proposal how to replace them with something that a) doesn't
> >>>>> cause regressions which is probably something that the LSMs care about
> >>>>> and b) that covers the new mount API sufficiently to be properly
> >>>>> mediated.
> >>>>> 
> >>>>> I'll happily review proposals. Fwiw, I'm pretty sure that this is
> >>>>> something that Mickael is interested in as well.
> >>>> 
> >>>> So we will consider a proper redesign of LSM hooks for mount syscalls, 
> >>>> but we do not want incremental improvements like this one. Do I get 
> >>>> the direction right?
> >>> 
> >>> If incremental is workable then I think so yes. But it would be great to
> >>> get a consistent picture of what people want/need.
> >> 
> >> In short term, we would like a way to get struct path of dev_name for  
> > 
> > You scared me for a second. By "dev_name" you mean the source path.
> 
> Right, we need to get struct path for the source path specified by 
> string “dev_name”.
> 
> > 
> >> bind mount. AFAICT, there are a few options:
> >> 
> >> 1. Introduce bpf_kern_path kfunc.
> >> 2. Add new hook(s), such as [1].
> >> 3. Something like this patch.
> >> 
> >> [1] https://lore.kernel.org/linux-security-module/20250110021008.2704246-1-enlightened@chromium.org/ 
> >> 
> >> Do you think we can ship one of them?
> > 
> > If you place a new security hook into __do_loopback() the only thing
> > that I'm not excited about is that we're holding the global namespace
> > semaphore at that point. And I want to have as little LSM hook calls
> > under the namespace semaphore as possible.
> 
> do_loopback() changed a bit since [1]. But if we put the new hook 
> in do_loopback() before lock_mount(), we don’t have the problem with
> the namespace semaphore, right? Also, this RFC doesn’t seem to have 
> this issue either. 

While the mount isn't locked another mount can still be mounted on top
of it. lock_mount() will detect this and lookup the topmost mount and
use that. IOW, the value of old_path->mnt may have changed after
lock_mount().

> > If you have 1000 containers each calling into
> > security_something_something_bind_mount() and then you do your "walk
> > upwards towards the root stuff" and that root is 100000 directories away
> > you've introduced a proper DOS or at least a severe new bottleneck into
> > the system. And because of mount namespace propagation that needs to be
> > serialized across all mount namespaces the namespace semaphore isn't
> > something we can just massage away.
> 
> AFAICT, a poorly designed LSM can easily DoS a system. Therefore, I 
> don’t think we need to overthink about a LSM helper causing DoS in 
> some special scenarios. The owner of the LSM, either built-in LSM or 
> BPF LSM, need to be aware of such risks and design the LSM rules 
> properly to avoid DoS risks. For example, if the path tree is really 
> deep, the LSM may decide to block the mount after walking a preset 
> number of steps. 

The scope of the lock matters _a lot_. If a poorly designed LSM happens
to take exorbitant amount of time under the inode_lock() it's annoying:
to anyone else wanting to grab the inode_lock() _for that single inode_.

If a poorly designed LSM does broken stuff under the namespace semaphore
any mount event on the whole system will block, effectively deadlocking
the system in an instant. For example, if anything even glances at
/proc/<pid>/mountinfo it's game over. It's already iffy that we allow
security_sb_statfs() under there but that's at least guaranteed to be
fast.

If you can make it work so that we don't have to place security_*()
under the namespace semaphore and you can figure out how to deal with a
potential overmount racing you then this would be ideal for everyone.

