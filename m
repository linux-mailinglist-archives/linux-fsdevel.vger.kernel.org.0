Return-Path: <linux-fsdevel+bounces-26786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB12A95BAC4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 17:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48D1B1F249D2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 15:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A87C1CCED8;
	Thu, 22 Aug 2024 15:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jutt/uDU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F491CB33B;
	Thu, 22 Aug 2024 15:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724341375; cv=none; b=mIdt51kyK1/gnNWrcilpdZY7WsOOsTJcmitrOXsY8GcX2uLxPRfi100vFuD0A6IuH1bsyMme50CM91y+bF538J+vQCdOo8jG0g0Sscwclbe0VOVyMOBQBAOb1sUtMi3PWwiqQvaR9qEf/FWTR61k7HWIHXf38jRgNCGYBQoThFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724341375; c=relaxed/simple;
	bh=ojie3VqMs9kYUbD0jFUJxxhgltx0IW1JZegnU4u/Iyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UVUguQUPOM/Q2a6baLGb2CeGkNOpTctBcQJAI6rgNZs5cetiOvVkWom5GiwKW3q5KtKG+axkmGI1uyezoV8lD5MedkWLfdJ7g+C0YyIvhnD9bDAcEPtPSOVluRK3ZdQAAAzOBvQ7fEsIx+vbeQIc/KUwi1tV7aaU7d9flLr+J2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jutt/uDU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F2AC32782;
	Thu, 22 Aug 2024 15:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724341375;
	bh=ojie3VqMs9kYUbD0jFUJxxhgltx0IW1JZegnU4u/Iyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jutt/uDUXThTU/R78WDcv7nZXDL+ezlRME9ZnrMc+dPRWIORDKGiRlog7Kn0yJjI1
	 4cV3SBG++S4+wqHx/a+ZsqAoAvKv+1cd0i5HrUgFBAig9jN6CQ4FvbpBEKZvxUyT/v
	 UCCOlyPb+XJPrrahWY3p4+q/77/6kmzT08/JQF6FE7f2hoVseQWd5ptRoSSLs/VZM7
	 kbDdXfYt0i7OCD4eKNILXqRuUoL7RpOZKlEZTnmAOdHvZgKe870VibYM/Ma+/fYcPT
	 YYnP4Wlz0QHOKzkhYbEQgKco85PxvO/pqsZBea7ZENRT0Ra5lJwE2bC2hskmP5qhBy
	 ZFigeZM34vOBQ==
Date: Thu, 22 Aug 2024 11:42:54 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Neil Brown <neilb@suse.de>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v12 00/24] nfs/nfsd: add support for localio
Message-ID: <Zsdcfk19yN9wK9Rm@kernel.org>
References: <20240819181750.70570-1-snitzer@kernel.org>
 <9dc7ec9b3d8a9a722046be2626b2d05fa714c8e6.camel@kernel.org>
 <ZsabuLQPj4BJzYqF@kernel.org>
 <F07C319B-2B87-4C5C-850C-4B68C57AA6D6@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F07C319B-2B87-4C5C-850C-4B68C57AA6D6@oracle.com>

On Thu, Aug 22, 2024 at 03:18:56PM +0000, Chuck Lever III wrote:
> 
> 
> > On Aug 21, 2024, at 10:00 PM, Mike Snitzer <snitzer@kernel.org> wrote:
> > 
> > Hey Jeff,
> > 
> > On Wed, Aug 21, 2024 at 03:20:55PM -0400, Jeff Layton wrote:
> >> 
> >> This looks much improved. I didn't see anything that stood out at me as
> >> being problematic code-wise with the design or final product, aside
> >> from a couple of minor things.
> > 
> > BTW, thanks for this feedback, much appreciated!
> > 
> >> But...this patchset is hard to review. My main gripe is that there is a
> >> lot of "churn" -- places where you add code, just to rework it in a new
> >> way in a later patch.
> >> 
> >> For instance, the nfsd_file conversion should be integrated into the
> >> new infrastructure much earlier instead of having a patch that later
> >> does that conversion. Those kinds extraneous changes make this much
> >> harder to review than it would be if this were done in a way that
> >> avoided that churn.
> > 
> > I think I've addressed all your v12 review comments from earlier
> > today.  I've pushed the new series out to my git repo here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/log/?h=nfs-localio-for-next
> > 
> > No code changes, purely a bunch of rebasing to clean up like you
> > suggested.  Only outstanding thing is the nfsd tracepoints handling of
> > NULL rqstp (would like to get Chuck's expert feedback on that point).
> > 
> > Please feel free to have a look at my branch while I wait for any
> > other v12 feedback from Chuck and/or others before I send out v13.
> > I'd like to avoid spamming the list like I did in the past ;)
> 
> Was looking for an appropriate place to reply with this question,
> but didn't see one. So here goes:
> 
> One of the issues Neil mentioned was dealing with the case where
> a server file system is unexported and perhaps unmounted while
> there is LOCALIO ongoing.

Yes, that was a problem with v11 and prior because the client was
holding a reference on the nfsd_file's underlying file (nf->nf_file)
for the duration of the open (within nfs_open_ctx).  That client-side
caching of the open file was done for performance reasons, but with
client-side use of nfsd_file we can claw back ~50% of that performance
by using the filecache's GC (patch 23 in this series details the
comparative performance numbers I'm talking about).

So I removed that extra client-side reference entirely, and just rely
on nfsd's filecache to hold the file open by nfsd_file_acquire_local()
taking reference on nfsd_file (so server does the normal thing on
shutdown where it walks the filecache's hlist during shutdown).

> Can you describe what the client and application see in this
> case? Do you have test cases for this scenario?

No, I've been testing it manually:

Client is using localio for /mnt/test2:

# python3
>>> f = open("/mnt/test2/testfile", encoding = "ISO-8859-1")
>>> s = f.read(8)
>>>

Server (happens to be running in container) is shutdown:

podman exec -ti nfs_12 /bin/bash
[root@6baf567b559a /]# systemctl stop nfs-server.service
[root@6baf567b559a /]# umount /export/cvol_12_0

(even easier to test without server in a container)

> Obviously we don't want a crash or deadlock, but I would guess the
> client/app should behave just like remote NFSv3 -- there, the
> server returns ESTALE on a READ or WRITE, and read(2) or write(2)
> on the client returns EIO. Ie, behavior should be deterministic.

Yes, that is how it works: exactly like remote NFSv3.

