Return-Path: <linux-fsdevel+bounces-13874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F91E874E8A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 13:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B907DB231D9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 12:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E739A12AAFF;
	Thu,  7 Mar 2024 12:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrAqheib"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5609112A170
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Mar 2024 12:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709813048; cv=none; b=iYkNTrSG6mRlOBQfrZR8YO8IWp5ti7NKOIrRXJ4HD/eOCZ0gHQPJCwDMaekFhSgoi7cx3DtEeO0dr97EwmAyTsSn08vAiso1mQCjFpvbW6RalU5WA2v40jceRHah3d2v0wvqd0YPP393WQpW/NM4q18e4yodAzRfKkOMJ7RUUlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709813048; c=relaxed/simple;
	bh=VSFKkp0gSk6y/6V0qooLBHYbpXoyQbhtVNMOV6KC4Ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3uqXWDZRAArGd6iKxC2eQIIebLHTQjZ/icsbcXf1m9SZp/zlA2ebRe5FHNkmXbmHUSjg3qVnPp0trix337Mhfkd/GCC/3zEGmgczpXRldN+nM9pn512nIL3DMdbsCLVbRP9n8aMV9P3LNLBtBuYuRU1pAe8uVkpxdsk1nfFVV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrAqheib; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AFAFC433C7;
	Thu,  7 Mar 2024 12:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709813047;
	bh=VSFKkp0gSk6y/6V0qooLBHYbpXoyQbhtVNMOV6KC4Ic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZrAqheibCeVyjZ96SpihtuK8b+DkJ1DcQosEQTc7Hh56wRBdRL1LrD3vwuRmaP5qt
	 ZkPIrxFHcxiYFa5KehyHV3uXiNVyy8qe/5HIg4qAap6hewTB1rKnOJsyjT5AGCBcRO
	 rrvnCJA62Lwe9dq9tyPQcXX4RfcvlOACZ104KnpzmqWku3pARn6Ue6kJGCIWePlLYs
	 /puppnkpb9xoudmTHZXzDn5EVf07lSCK8QIKDREV8wxpIMmFBNiNk6HBJjW5xm6Yoo
	 sbhZ6iIU0DTyV0wNVp8irHkCvw++u/3RGxHhQlk8iMR5YIvuNVPQE6p5mUkpQcFtOy
	 GVwK1sSwBPaKg==
Date: Thu, 7 Mar 2024 13:04:02 +0100
From: Christian Brauner <brauner@kernel.org>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Eric Sandeen <sandeen@redhat.com>, 
	linux-fsdevel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Bill O'Donnell <billodo@redhat.com>, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 1/2] vfs: Convert debugfs to use the new mount API
Message-ID: <20240307-winkelmesser-funkkontakt-845889326073@brauner>
References: <cfdebcc3-b9de-4680-a764-6bdf37c0accb@redhat.com>
 <49d1f108-46e3-443f-85a3-6dd730c5d076@redhat.com>
 <20240306-beehrt-abweichen-a9124be7665a@brauner>
 <CAJfpeguCKgMPBbD_ESD+Voxq5ChS9nGQFdYrA4+YWBz17yFADA@mail.gmail.com>
 <20240306-alimente-tierwelt-01d46f2b9de7@brauner>
 <49751ee4-d2ce-4db9-af85-f9acf65a4b85@sandeen.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <49751ee4-d2ce-4db9-af85-f9acf65a4b85@sandeen.net>

On Wed, Mar 06, 2024 at 10:35:02AM -0600, Eric Sandeen wrote:
> On 3/6/24 6:17 AM, Christian Brauner wrote:
> > On Wed, Mar 06, 2024 at 01:13:05PM +0100, Miklos Szeredi wrote:
> >> On Wed, 6 Mar 2024 at 11:57, Christian Brauner <brauner@kernel.org> wrote:
> >>
> >>> There's a tiny wrinkle though. We currently have no way of letting
> >>> userspace know whether a filesystem supports the new mount API or not
> >>> (see that mount option probing systemd does we recently discussed). So
> >>> if say mount(8) remounts debugfs with mount options that were ignored in
> >>> the old mount api that are now rejected in the new mount api users now
> >>> see failures they didn't see before.
> 
> Oh, right - the problem is the new mount API rejects unknown options
> internally, right?
> 
> >>> For the user it's completely intransparent why that failure happens. For
> >>> them nothing changed from util-linux's perspective. So really, we should
> >>> probably continue to ignore old mount options for backward compatibility.
> >>
> >> The reject behavior could be made conditional on e.g. an fsopen() flag.
> > 
> > and fspick() which I think is more relevant.
> > 
> >>
> >> I.e. FSOPEN_REJECT_UNKNOWN would make unknown options be always
> >> rejected.  Without this flag fsconfig(2) would behave identically
> >> before/after the conversion.
> > 
> > Yeah, that would work. That would only make sense if we make all
> > filesystems reject unknown mount options by default when they're
> > switched to the new mount api imho. When we recognize the request comes
> > from the old mount api fc->oldapi we continue ignoring as we did before.
> > If it comes from the new mount api we reject unless
> > FSOPEN/FSPICK_REJECT_UKNOWN was specified.

I actually did misparse that I now realize. I read that as "ignore
unknown" instead of "reject unknown".

> 
> Ok, good point. Just thinking out loud, I guess an fsopen/fspick flag does
> make more sense than i.e. each filesystem deciding whether it should reject
> unknown options in its ->init_fs_context(), for consistency?

Yes, I think so. The interesting case for util-linux according to Karel
was remounting where mount(8) wants to gather all options from fstab and
mountinfo, add new options from the command line and send it to the
kernel without having to care about filesystems specific options that
cannot be changed on remount.

However, other users that do use the api programatically do care about
this. They want to get an error when changing a mount property doesn't
work.

I think doing this on a per-fs basis just leads to more inconsistency.
I'd rather have this be something we enforce on a higher level if we do
it at all.

> 
> Right now it looks like the majority of filesystems do reject unknown
> options internally, already.

Yeah, it's mostly pseudo fses that don't, I reckon.

> 
> (To muddy the waters more, other inconsistencies I've thought about are
> re: how the fileystem handles remount. For example, which options are
> remountable and which are not, and should non-remountable options fail?

Yes, they should but similar to fsopen() we should have an fspick()
flag. This was what I mentioned earlier in my response to Miklos.

But I'm not yet clear whether FSOPEN/FSPICK_IGNORE_UNKNOWN wouldn't make
more sense than FSOPEN/FSPICK_REJECT_UNKNOWN. IOW, invert the logic.

Because as you said most filesystems do already reject unknown mount
options and it's a few that don't. So I think we should focus on the
remount case and for that I think we want FSOPEN_IGNORE_UNKNOWN
otherwise default to rejecting unknown options if coming from the new
mount api? I'm not sure.

> Also whether the filesystem internally preserves the original set of
> options and applies the new set as a delta, or whether it treats the
> new set as the exact set of options requested post-remount, but that's
> probably a topic for another day.)

For vfs mount properties it's a delta in the new mount api. The old
mount api didn't have a concept of add or subtract. If you had a
read-only mount and you wanted to also make it noexec then you'd have to
specify "ro" again otherwise the mount would be made rw. mount(8) hides
that behavior by retrieving the current mountflags from mountinfo and
adding it to the remount call if the old mount api is used.
mount_setattr() does that directly in the kernel and always does a
delta.

For filesystem specific properties it's probably irrelevant because
remount already is effectively a delta for most filesystems. IOW, you
don't suddenly get "usrquota" unset because you've changed the "dax"
property on your xfs filesystem which would be worrisome. :)

The thing is though that changing one mount option might implicitly
change other mount options. But that's something that only the
filesystem should decide. So I don't think this is something we need to
worry about?

The way I see mount(8) currently doing it is to change:

(1) filesystem specific mount properties via fspick()+fsconfig()
(2) generic mount properties via mount_setattr()

during a remount call.

