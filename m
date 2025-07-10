Return-Path: <linux-fsdevel+bounces-54477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42304B000C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 13:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EFB01C22CA6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 11:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E95624A05D;
	Thu, 10 Jul 2025 11:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmy2T+mx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9A1946F;
	Thu, 10 Jul 2025 11:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752148012; cv=none; b=ji8mdKpBBG0aJtQ+7iUEJq3yK9oVhz2+0g1KJT7TDXDbcByiaIjZogJP6480tiRgV0JkprbJLJPbjLG9G0CSrBeO7oMAhtML7JFEICeQSbBCmpuKEdpmYrFVGcjsciwf1SkeiGE1AeVUXJO64g4vEO6rTGVZIaOIVHplenxpzr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752148012; c=relaxed/simple;
	bh=t/OeAvIh8DyOgjIIocAvYTIOO6EsHiE6fqTQPT+2lQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BeA+5v6uDYHW/GYQ7pIRaTJ0vy7J27tgju/GkAa6w+SVjhpDZPAdmGRXtorH19xgKuFAvjDVJqq5fYbSrD9LN9SJTZnkYNDjQs41AlMi+oA8c3j/X4NbAdBJrpgM6vGtljLitwUDpFNGSuMPPb0SjwEN6IRAVOtDYASwjy8FFLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmy2T+mx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78A4C4CEE3;
	Thu, 10 Jul 2025 11:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752148012;
	bh=t/OeAvIh8DyOgjIIocAvYTIOO6EsHiE6fqTQPT+2lQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kmy2T+mxE+7xOOMDTL8TRFHexoTeE0G4VAikvj3fcRgN4jfOqsJtdyjMyzE46/SXt
	 u3fVlUmIO/B6hi2vHg9m8YC8Bqyvilj+TJVzLDeK7wFYDMBo5MtFtW/EvXYZAF8tn3
	 w2b6s3ETa3JNlIUg2Wk74516+WI08ZvVDCQVnBxTUg+o/zokk4qZDp7dL2G480vhX9
	 nZY+InRMFy3JgfTByCWsPrSdorvtM+3Jzy35IC5jLmWWtjSenXTHNTzjNL0UoPJCNW
	 nBDBboyVOf0dPPH4SRBEmKwamyu1YjdIWZQlzEuZQrxfDxcsVspPgnKBs2rpsxE0k4
	 m6Mao47ynwhDQ==
Date: Thu, 10 Jul 2025 13:46:42 +0200
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
Message-ID: <20250710-roden-hosen-ba7f215706bb@brauner>
References: <20250708230504.3994335-1-song@kernel.org>
 <20250709102410.GU1880847@ZenIV>
 <CAHC9VhSS1O+Cp7UJoJnWNbv-Towia72DitOPH0zmKCa4PBttkw@mail.gmail.com>
 <1959367A-15AB-4332-B1BC-7BBCCA646636@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1959367A-15AB-4332-B1BC-7BBCCA646636@meta.com>

On Wed, Jul 09, 2025 at 05:06:36PM +0000, Song Liu wrote:
> Hi Al and Paul, 
> 
> Thanks for your comments!
> 
> > On Jul 9, 2025, at 8:19 AM, Paul Moore <paul@paul-moore.com> wrote:
> > 
> > On Wed, Jul 9, 2025 at 6:24 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >> On Tue, Jul 08, 2025 at 04:05:04PM -0700, Song Liu wrote:
> >>> security_sb_mount handles multiple types of mounts: new mount, bind
> >>> mount, etc. When parameter dev_name is a path, it need to be parsed
> >>> with kern_path.
> > 
> > ...
> > 
> >> security_sb_mount() is and had always been a mind-boggling trash of an API.
> >> 
> >> It makes no sense in terms of operations being requested.  And any questions
> >> regarding its semantics had been consistently met with blanket "piss off,
> >> LSM gets to do whatever it wants to do, you are not to question the sanity
> >> and you are not to request any kind of rules - give us the fucking syscall
> >> arguments and let us at it".
> > 
> > I'm not going to comment on past remarks made by other devs, but I do
> > want to make it clear that I am interested in making sure we have LSM
> > hooks which satisfy both the needs of the existing in-tree LSMs while
> > also presenting a sane API to the kernel subsystems in which they are
> > placed.  I'm happy to revisit any of our existing LSM hooks to
> > restructure them to better fit these goals; simply send some patches
> > and let's discuss them.
> > 
> >> Come up with a saner API.  We are done accomodating that idiocy.  The only
> >> changes you get to make in fs/namespace.c are "here's our better-defined
> >> hooks, please call <this hook> when you do <that>".
> 
> Right now, we have security_sb_mount and security_move_mount, for 
> syscall “mount” and “move_mount” respectively. This is confusing 
> because we can also do move mount with syscall “mount”. How about 
> we create 5 different security hooks:
> 
> security_bind_mount
> security_new_mount
> security_reconfigure_mount
> security_remount
> security_change_type_mount
> 
> and remove security_sb_mount. After this, we will have 6 hooks for
> each type of mount (the 5 above plus security_move_mount).

I've multiple times pointed out that the current mount security hooks
aren't working and basically everything in the new mount api is
unsupervised from an LSM perspective.

My recommendation is make a list of all the currently supported
security_*() hooks in the mount code (I certainly don't have them in my
head). Figure out what each of them allow to mediate effectively and how
the callchains are related.

Then make a proposal how to replace them with something that a) doesn't
cause regressions which is probably something that the LSMs care about
and b) that covers the new mount API sufficiently to be properly
mediated.

I'll happily review proposals. Fwiw, I'm pretty sure that this is
something that Mickael is interested in as well.

