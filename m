Return-Path: <linux-fsdevel+bounces-4177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 075937FD6D9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 13:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 391371C20D0B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 12:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998261B26D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 12:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZzELFqm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3CB1B28F;
	Wed, 29 Nov 2023 10:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94271C433C7;
	Wed, 29 Nov 2023 10:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701254419;
	bh=iKieYKjmhXyoDHJ49WSunuW7X7vUfEU0PZW1oROsCk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sZzELFqmBUyah57j1ZKM1zr8FlGi50GrzanaKJ9RqKuPMAslwPYxTuZqWx6H2E7OY
	 NQ91r0USX+7RhQMjaEr2AmjxLWKAA5XZVEYWX7WE+7FrX+oH+4geTCaKJEzkhmXydL
	 MixnLSukFRhxPThH9gMnegrLbwY+iHUz16xhWpvIVFSbT8puKBwdyF0jK56SG40zbh
	 TUwcfFqmgt8p1Z0sprEjTke1eBDAKSzKSeZIEh77LdAs48mUFeOPqGvDq98mUkMDhs
	 pIHHTqfXewywrI1mRRaYkMGY+5gV+StfJWR+Xl2w5K0A7Cu6xPBNDROLHD5JqtflV6
	 NUyxGmFRAaERQ==
Date: Wed, 29 Nov 2023 11:40:13 +0100
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-api@vger.kernel.org,
	linux-man@vger.kernel.org, linux-security-module@vger.kernel.org,
	Karel Zak <kzak@redhat.com>, linux-fsdevel@vger.kernel.org,
	Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 0/4] listmount changes
Message-ID: <20231129-bilden-rappen-892ca237abf9@brauner>
References: <20231128160337.29094-1-mszeredi@redhat.com>
 <20231129-rinnen-gekapert-c3875be7c9da@brauner>
 <CAJfpegsTGq0TW0oFDnYiTeM+z66M73k1jXXjFE6GwebPQYSgGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegsTGq0TW0oFDnYiTeM+z66M73k1jXXjFE6GwebPQYSgGA@mail.gmail.com>

On Wed, Nov 29, 2023 at 11:22:03AM +0100, Miklos Szeredi wrote:
> On Wed, 29 Nov 2023 at 10:53, Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Tue, 28 Nov 2023 17:03:31 +0100, Miklos Szeredi wrote:
> > > This came out from me thinking about the best libc API.  It contains a few
> > > changes that simplify and (I think) improve the interface.
> > >
> > > Tree:
> > >
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git#vfs.mount
> > >
> > > [...]
> >
> > Afaict, all changes as discussed. Thanks. I folded the fixes into the
> > main commit. Links to the patches that were folded are in the commit
> > message and explained in there as well. The final commit is now rather
> > small and easy to read.
> 
> Looks good, thanks for folding the patches.
> 
> >    * Remove explicit LISTMOUNT_UNREACHABLE flag (cf. [1]). That
> >      functionality can simply be made available by checking for required
> >      privileges. If the caller is sufficiently privileged then list mounts
> >      that can't be reached from the current root. If the caller isn't skip
> >      mounts that can't be reached from the current root. This also makes
> >      permission checking consistent with statmount() (cf. [3]).
> 
> Skipping mounts based on privileges was what the initial version did.
> That inconsistency was the reason for introducing
> LISTMOUNT_UNREACHABLE.  The final version doesn't skip mounts based on
> privileges, either all submounts are listed or the request is rejected
> with -EPERM.

Yeah, I phrased that badly. What I meant to convey is that mounts not
reachable from the current root are not reported as in skipped in the
loop. I've simplified this down to:

* Remove explicit LISTMOUNT_UNREACHABLE flag (cf. [1]) and fail if mount
  is unreachable from current root. This also makes permission checking
  consistent with statmount() (cf. [3]).

