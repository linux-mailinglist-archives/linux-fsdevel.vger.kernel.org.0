Return-Path: <linux-fsdevel+bounces-54602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9360CB01816
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 11:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A135F188F73A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 09:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0827927A90E;
	Fri, 11 Jul 2025 09:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OfDSUfdR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5479E253F12;
	Fri, 11 Jul 2025 09:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752226592; cv=none; b=ORotkoGB9yoOtX+0Gc6/qElvah8/5Py/61nExpXjwcB/fN8jA7ZVHhR3hvVg15IB6HGR+zduL6xPMwGLSjZwlX5xpIvd32+DLSM2yVcp9ZnjQy8BadJkKEa+KlifqZykRToVwWLv5mhdPomETENAWZ/vFnmcTmuW6V6STOTGoDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752226592; c=relaxed/simple;
	bh=wravLw2QyrJLSNCdmXnM24JOPnV05g3lbLl4G+9JMH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qS7qBFU8pf8uQeqcRle30bMpnHcX4mqwbG5phFs8p00GwjP66+2HeVES4ooOWkUesArvJZTlFgPlGCwPDUwlNQ2AvIk6ZZfES+wqz5+JuHYaorVJelZta8xovKCYs4iWjjLIvUOW/Qbbwi5gHTOyXoZCOM1UgmaLqqkvlpwlaSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OfDSUfdR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6DFAC4CEED;
	Fri, 11 Jul 2025 09:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752226591;
	bh=wravLw2QyrJLSNCdmXnM24JOPnV05g3lbLl4G+9JMH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OfDSUfdRw476/lz/ONpYwW1LihVsJP6g0T4SmP1iy2bvr6qRewRf+NN6qbBh4loy4
	 XRACTQsVQQKkeVgPiZ+RWxgjPwc4mFpA7ovzYbzspNEdtIOM16+PsVIznQZuGXTAjO
	 YZepOneoK/wohc6HXIs4ZC6Dw0BMRD2fZXWkmRYafw+nYnYuohAHbnQyfuMF4JKUzo
	 b/kZEPC8SbEEm0PHcf5sIEjBTqR4I9EN5tqD8XTVmuUcTUJyvUBSuDhq4FG32/pV4q
	 Nk1uYNjkE5XN2AF5ImMIUTv0KevWM9wO4dVYjLt97vGrQgXCndA8TJQLrAVNEasasg
	 H4O1AEKzCaDFg==
Date: Fri, 11 Jul 2025 11:36:22 +0200
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
Message-ID: <20250711-pfirsich-worum-c408f9a14b13@brauner>
References: <20250708230504.3994335-1-song@kernel.org>
 <20250709102410.GU1880847@ZenIV>
 <CAHC9VhSS1O+Cp7UJoJnWNbv-Towia72DitOPH0zmKCa4PBttkw@mail.gmail.com>
 <1959367A-15AB-4332-B1BC-7BBCCA646636@meta.com>
 <20250710-roden-hosen-ba7f215706bb@brauner>
 <5EB3EFBC-69BA-49CC-B416-D4A7398A2B47@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5EB3EFBC-69BA-49CC-B416-D4A7398A2B47@meta.com>

On Thu, Jul 10, 2025 at 05:00:18PM +0000, Song Liu wrote:
> 
> 
> > On Jul 10, 2025, at 4:46 AM, Christian Brauner <brauner@kernel.org> wrote:
> 
> [...]
> 
> >> Right now, we have security_sb_mount and security_move_mount, for 
> >> syscall “mount” and “move_mount” respectively. This is confusing 
> >> because we can also do move mount with syscall “mount”. How about 
> >> we create 5 different security hooks:
> >> 
> >> security_bind_mount
> >> security_new_mount
> >> security_reconfigure_mount
> >> security_remount
> >> security_change_type_mount
> >> 
> >> and remove security_sb_mount. After this, we will have 6 hooks for
> >> each type of mount (the 5 above plus security_move_mount).
> > 
> > I've multiple times pointed out that the current mount security hooks
> > aren't working and basically everything in the new mount api is
> > unsupervised from an LSM perspective.
> 
> To make sure I understand the comment. By “new mount api”, do you mean 
> the code path under do_new_mount()? 

fsopen()
fsconfig()
fsmount()
open_tree()
open_tree_attr()
move_mount()
statmount()
listmount()

I think that's all.

> 
> > My recommendation is make a list of all the currently supported
> > security_*() hooks in the mount code (I certainly don't have them in my
> > head). Figure out what each of them allow to mediate effectively and how
> > the callchains are related.
> > 
> > Then make a proposal how to replace them with something that a) doesn't
> > cause regressions which is probably something that the LSMs care about
> > and b) that covers the new mount API sufficiently to be properly
> > mediated.
> > 
> > I'll happily review proposals. Fwiw, I'm pretty sure that this is
> > something that Mickael is interested in as well.
> 
> So we will consider a proper redesign of LSM hooks for mount syscalls, 
> but we do not want incremental improvements like this one. Do I get 
> the direction right?

If incremental is workable then I think so yes. But it would be great to
get a consistent picture of what people want/need.

