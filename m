Return-Path: <linux-fsdevel+bounces-54823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3895FB039C1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 10:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91DC33B5B8C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 08:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F9823C4EA;
	Mon, 14 Jul 2025 08:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9vtttmg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E143818D;
	Mon, 14 Jul 2025 08:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752482733; cv=none; b=SjrJ1dc88jkKfLnDZhUNF87r1e8CrhW7hbZmmTmMCu/FyUX/ykhkVpgCaq/+KeU9kGqERvZyJJKxA2m6pyee8mTN+SVM0wOdIqW/LJkyRcG+bGrkmj9SV8R7PEaujX7MqFMuCfhFTcsl3k3O363/1GdfUIkOUBTCdodrbNDGk2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752482733; c=relaxed/simple;
	bh=uWgTuZEfGEQlFAIzby7m941mcIUfPc5iq7G/VhSX6Lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JdK1hXVU3eiMS2b2W8ybg4TeZRLwqt0AYPqClZAkO+ieHGuC8BBLLCtIzD1KLED7KS3F9Qqt4bk27EJ6XrEJ2ttiwHqC2j78VCMBB3KK9fBIHS6fVKg7t6x+IwLnxvK5OXqng6nrLjO82hnydny0Pzb7EUcXpjHiazGOu5tGqps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9vtttmg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDB82C4CEED;
	Mon, 14 Jul 2025 08:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752482732;
	bh=uWgTuZEfGEQlFAIzby7m941mcIUfPc5iq7G/VhSX6Lg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G9vtttmg8KpJLC3L6ALc4psh6hNervKHrkJ95I+zLXXGhfQDl9zHdr0fbeJR5l28o
	 1MP3JkIHuJ3GvtN9j6qHNO3sUcPHoOyU/dSLBNw0JX55h2lOI8UXAPhkkFh4Rmiq3f
	 1OdduCvVHcoZ2NeIkZgxnaHr3nq19Q9A8SzFEFXErT4csNrPvG/sRAEwjO8C0omxKf
	 Sb3zCCr1yKaqPBZTFdwy018NxzJw7DS2BVQLuwQwmnzFm1Mju4nlfPa1P6HLED/Z3W
	 dUFjM4OEWJ1Wf7jKNDR0O5od9xhIZsCTEn8D2I7e/QArr8SNEzNtNxkiUYUHe3S53E
	 faxth8ZpMJM5A==
Date: Mon, 14 Jul 2025 10:45:22 +0200
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
Message-ID: <20250714-ansonsten-shrimps-b4df1566f016@brauner>
References: <20250708230504.3994335-1-song@kernel.org>
 <20250709102410.GU1880847@ZenIV>
 <CAHC9VhSS1O+Cp7UJoJnWNbv-Towia72DitOPH0zmKCa4PBttkw@mail.gmail.com>
 <1959367A-15AB-4332-B1BC-7BBCCA646636@meta.com>
 <20250710-roden-hosen-ba7f215706bb@brauner>
 <5EB3EFBC-69BA-49CC-B416-D4A7398A2B47@meta.com>
 <20250711-pfirsich-worum-c408f9a14b13@brauner>
 <4EE690E2-4276-41E6-9D8C-FBF7E90B9EB3@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4EE690E2-4276-41E6-9D8C-FBF7E90B9EB3@meta.com>

On Fri, Jul 11, 2025 at 04:22:52PM +0000, Song Liu wrote:
> 
> 
> > On Jul 11, 2025, at 2:36 AM, Christian Brauner <brauner@kernel.org> wrote:
> 
> [...]
> 
> >>> 
> >> To make sure I understand the comment. By “new mount api”, do you mean 
> >> the code path under do_new_mount()?
> > 
> > fsopen()
> > fsconfig()
> > fsmount()
> > open_tree()
> > open_tree_attr()
> > move_mount()
> > statmount()
> > listmount()
> > 
> > I think that's all.
> 
> Thanks for the clarification and pointer!
> 
> > 
> >> 
> >>> My recommendation is make a list of all the currently supported
> >>> security_*() hooks in the mount code (I certainly don't have them in my
> >>> head). Figure out what each of them allow to mediate effectively and how
> >>> the callchains are related.
> >>> 
> >>> Then make a proposal how to replace them with something that a) doesn't
> >>> cause regressions which is probably something that the LSMs care about
> >>> and b) that covers the new mount API sufficiently to be properly
> >>> mediated.
> >>> 
> >>> I'll happily review proposals. Fwiw, I'm pretty sure that this is
> >>> something that Mickael is interested in as well.
> >> 
> >> So we will consider a proper redesign of LSM hooks for mount syscalls, 
> >> but we do not want incremental improvements like this one. Do I get 
> >> the direction right?
> > 
> > If incremental is workable then I think so yes. But it would be great to
> > get a consistent picture of what people want/need.
> 
> In short term, we would like a way to get struct path of dev_name for  

You scared me for a second. By "dev_name" you mean the source path.

> bind mount. AFAICT, there are a few options:
> 
> 1. Introduce bpf_kern_path kfunc.
> 2. Add new hook(s), such as [1].
> 3. Something like this patch.
> 
> [1] https://lore.kernel.org/linux-security-module/20250110021008.2704246-1-enlightened@chromium.org/
> 
> Do you think we can ship one of them? 

If you place a new security hook into __do_loopback() the only thing
that I'm not excited about is that we're holding the global namespace
semaphore at that point. And I want to have as little LSM hook calls
under the namespace semaphore as possible.

If you have 1000 containers each calling into
security_something_something_bind_mount() and then you do your "walk
upwards towards the root stuff" and that root is 100000 directories away
you've introduced a proper DOS or at least a severe new bottleneck into
the system. And because of mount namespace propagation that needs to be
serialized across all mount namespaces the namespace semaphore isn't
something we can just massage away.

