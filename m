Return-Path: <linux-fsdevel+bounces-68261-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9585C57B80
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 14:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB29F50052A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 13:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1E9351FDF;
	Thu, 13 Nov 2025 13:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="au9Fnep+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960543446AA;
	Thu, 13 Nov 2025 13:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763039963; cv=none; b=KTNquhmG8LRbWLuzhIze8JjDzdEfgz7HgXpYfGfQp31STqv01wnOJ6QK+TkxE44qz0BxiXmVjiGHl5vmce3ux/rH/DaNBS+XKqhQRfYNU9nZXII0weo4+sPyp14HJRz3h9meM9uh04VxrnwAimbthV9fkVgMVNMHnPmMS6+t088=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763039963; c=relaxed/simple;
	bh=P9s2h/Wjy9Na7b+ftnoX7l3kupSsVDNWwRbP5AEB8Og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lf7TkrGPArqa6waLmV8so8CGNQ9DNU+WmzZZZ39+WDuQzRWFj1M4UzFxat9kOC+PH4fMBg0Yb5uRkAaxs22Th6BAZW8KEy6NuFQKjRFDH1YwwEFYg2Bk2U/KCeooL5g61otuq1+em9cp0ajVy2TUlpzeRLmd9NNtrHf76SqXapY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=au9Fnep+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBEE4C113D0;
	Thu, 13 Nov 2025 13:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763039963;
	bh=P9s2h/Wjy9Na7b+ftnoX7l3kupSsVDNWwRbP5AEB8Og=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=au9Fnep+e1nlh+6Akcy9xh1n7jklf2ToFt2W0nDV9torlK6X0yoWA3O/Pmq+p4QSg
	 1FaO9fNr95zNVNcIsYGrd/7eBUSbUmZBtE0hXmihERVhqAHi9NPrvPPKnsB7Yfpnwg
	 +tweOCW7HnYA4G3vEvAkLtFVEdtJqX5Lj7jYjKabIFhUgo2KPgD5kRSQxkIagEa7U8
	 AstTMiCzIsw1Cc0j54FHQJ/zkPBfdFUv9ZXbqKiK+wTa4u8pSdxIIAaZXXwaJOMdC8
	 GTHx58pq2iZT14EzsnthsvR6lPZKOkjUyaAilZZERWCqxaBRqrj044f+vLvUkEA+Z2
	 mBQsZf+OVaxgQ==
Date: Thu, 13 Nov 2025 14:19:19 +0100
From: Christian Brauner <brauner@kernel.org>
To: Ian Kent <raven@themaw.net>
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
	Kernel Mailing List <linux-kernel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 2/2] autofs: dont trigger mount if it cant succeed
Message-ID: <20251113-gechartert-klargemacht-542a0630c88b@brauner>
References: <20251111060439.19593-1-raven@themaw.net>
 <20251111060439.19593-3-raven@themaw.net>
 <20251111-zunahm-endeffekt-c8fb3f90a365@brauner>
 <20251111102435.GW2441659@ZenIV>
 <20251111-ortseinfahrt-lithium-21455428ab30@brauner>
 <bd4fc8ce-ca3f-4e0f-86c0-f9aaa931a066@themaw.net>
 <20251112-kleckern-gebinde-d8dbe0d50e03@brauner>
 <0dfa7fc6-3a15-4adc-ad1d-81bb43f62919@themaw.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0dfa7fc6-3a15-4adc-ad1d-81bb43f62919@themaw.net>

On Thu, Nov 13, 2025 at 08:14:36AM +0800, Ian Kent wrote:
> On 12/11/25 19:01, Christian Brauner wrote:
> > On Tue, Nov 11, 2025 at 08:27:42PM +0800, Ian Kent wrote:
> > > On 11/11/25 18:55, Christian Brauner wrote:
> > > > On Tue, Nov 11, 2025 at 10:24:35AM +0000, Al Viro wrote:
> > > > > On Tue, Nov 11, 2025 at 11:19:59AM +0100, Christian Brauner wrote:
> > > > > 
> > > > > > > +	sbi->owner = current->nsproxy->mnt_ns;
> > > > > > ns_ref_get()
> > > > > > Can be called directly on the mount namespace.
> > > > > ... and would leak all mounts in the mount tree, unless I'm missing
> > > > > something subtle.
> > > > Right, I thought you actually wanted to pin it.
> > > > Anyway, you could take a passive reference but I think that's nonsense
> > > > as well. The following should do it:
> > > Right, I'll need to think about this for a little while, I did think
> > > 
> > > of using an id for the comparison but I diverged down the wrong path so
> > > 
> > > this is a very welcome suggestion. There's still the handling of where
> > > 
> > > the daemon goes away (crash or SIGKILL, yes people deliberately do this
> > > 
> > > at times, think simulated disaster recovery) which I've missed in this
> > Can you describe the problem in more detail and I'm happy to help you
> > out here. I don't yet understand what the issue is.
> 
> I thought the patch description was ok but I'll certainly try.

I'm sorry, we're talking past each other: I was interested in your
SIGKILL problem when the daemon crashes. You seemed to say that you
needed additional changes for that case. So I'm trying to understand
what the fundamental additional problem is with a crashing daemon that
would require additional changes here.

> 
> 
> Consider using automount in a container.
> 
> 
> For people to use autofs in a container either automount(8) in the init
> 
> mount namespace or an independently running automount(8) entirely within
> 
> the container can be used. The later is done by adding a volume option
> 
> (or options) to the container to essentially bind mount the autofs mount
> 
> into the container and the option syntax allows the volume to be set
> 
> propagation slave if it is not already set by default (shared is bad,
> 
> the automounts must not propagate back to where they came from). If the
> 
> automount(8) instance is entirely within the container that also works
> 
> fine as everything is isolated within the container (no volume options
> 
> are needed).
> 
> 
> Now with unshare(1) (and there are other problematic cases, I think systemd
> 
> private temp gets caught here too) where using something like "unshare -Urm"
> 
> will create a mount namespace that includes any autofs mounts and sets them
> 
> propagation private. These mounts cannot be unmounted within the mount
> 
> namepsace by the namespace creator and accessing a directory within the

Right, but that should only be true for unprivileged containers where we
lock mounts at copy_mnt_ns().

> 
> autofs mount will trigger a callback to automount(8) in the init namespace
> 
> which mounts the requested mount. But the newly created mount namespace is
> 
> propagation private so the process in the new mount namespace loops around
> 
> sending mount requests that cannot be satisfied. The odd thing is that on
> the
> 
> second callback to automount(8) returns an error which does complete the
> 
> ->d_automount() call but doesn't seem to result in breaking the loop in
> 
> __traverse_mounts() for some unknown reason. One way to resolve this is to
> 
> check if the mount can be satisfied and if not bail out immediately and
> 
> returning an error in this case does work.

Yes, that's sensible. And fwiw, I think for private mounts that's the
semantics you want. You have disconnected from the "managing" mount
namespace - for lack of a better phrase - so you shouldn't get the mount
events.

> I was tempted to work out how to not include the autofs mounts in the cloned
> 
> namespace but that's file system specific code in the VFS which is not ok
> and
> 
> it (should) also be possible for the namespace creator to "mount
> --make-shared"
> 
> in the case the creator wants the mount to function and this would prevent
> that.
> 
> So I don't think this is the right thing to do.
> 
> 
> There's also the inability of the mount namespace creator to umount the
> autofs
> 
> mount which could also resolve the problem which I haven't looked into yet.

Ok, again, that should only be an issue with unprivileged mount
namespaces, i.e., owned by another user namespace. This isn't easily
doable. If the unprivileged mount namespaces can unmount the automount
it might reveal hidden/overmounted directories that weren't supposed to
be exposed to the container - I hate these semantics btw.

> 
> 
> Have I made sense?

Yes, though that's not the question I tried to ask you. :)

> 
> 
> Clearly there's nothing on autofs itself and why one would want to use it
> 
> but I don't think that matters for the description.
> 
> 
> Ian
> 

