Return-Path: <linux-fsdevel+bounces-56116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B49B132D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 03:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41A273B600B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 01:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367A11A841E;
	Mon, 28 Jul 2025 01:51:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0CD1FC8;
	Mon, 28 Jul 2025 01:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753667487; cv=none; b=E/0IO1v1pMc8wKUAwgV6J82GD7GkvEvOOaUS76tidrcLsjoqqFRv4wpKwP8jL+sUKLNN4I1B23EwHZMUVy2JRtKfoiW+JJGiJK5sTCJ6/XZuUmFVKoN4s31O1NpqoWkVmbzcn2+wUgTrl0uoMwLr/d2TZXEjFfzCRyTPAYhMjfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753667487; c=relaxed/simple;
	bh=+jS9uwkoO555xcOqKHVM8dEr1nuJ+3c41Oax3W2z7ao=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=MvDeZgysO3P2pRdLV9VUakpJlegGfpIAEg3co+VUACBCxBwhambiyYPPf+baHG5eFW1tLI1QcAe70YBBn0ekCprww9sNlM72PoYSqsZd7lVfv0ZyET8wt7MahmAHiHdfqCVUKy3WJI9NLEIM6rQIkg0vrjBI8cSuYC2wo2Ey7nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ugD1H-003fUZ-T1;
	Mon, 28 Jul 2025 01:51:17 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Trond Myklebust" <trondmy@hammerspace.com>,
 "Anna Schumaker" <anna@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH v3 3/8] vfs: add ATTR_CTIME_SET flag
In-reply-to: <3d02578c8fa2c6b17d4fde12af328d0b5f93ca5e.camel@kernel.org>
References: <>, <3d02578c8fa2c6b17d4fde12af328d0b5f93ca5e.camel@kernel.org>
Date: Mon, 28 Jul 2025 11:51:15 +1000
Message-id: <175366747582.2234665.13002356331033442863@noble.neil.brown.name>

On Mon, 28 Jul 2025, Jeff Layton wrote:
> On Mon, 2025-07-28 at 10:04 +1000, NeilBrown wrote:
> > On Mon, 28 Jul 2025, Jeff Layton wrote:
> > > When ATTR_ATIME_SET and ATTR_MTIME_SET are set in the ia_valid mask, the
> > > notify_change() logic takes that to mean that the request should set
> > > those values explicitly, and not override them with "now".
> > > 
> > > With the advent of delegated timestamps, similar functionality is needed
> > > for the ctime. Add a ATTR_CTIME_SET flag, and use that to indicate that
> > > the ctime should be accepted as-is. Also, clean up the if statements to
> > > eliminate the extra negatives.
> > 
> > I don't feel entirely comfortable with this.  ctime is a fallback for
> > "has anything changed" - mtime can be changed but ctime is always
> > reliable, controlled by VFS and FS.
> > 
> > Until now.
> > 
> 
> I know. I have many of the same reservations, but the specification is
> pretty clear (now that I understand it better). I don't see a better
> way to do this.
> 
> > I know you aren't exposing this to user-space, but then not doing so
> > blocks user-space file servers from using this functionality.
> > 
> > I see that you also move vetting of the value out of vfs code and into
> > nfsd code.  I don't really understand why you did that.  Maybe nfsd has
> > more information about previous timestamps than the vfs has?
> > 
> 
> Yes. We need to track the timestamps of the inode at the time that the
> delegation was handed out. nfsd is (arguably) in a better position to
> do this than the VFS is. Patch #5 adds this functionality.
> 
> > Anyway I would much prefer that ATTR_CTIME_SET could only change the
> > ctime value to something between the old ctime value and the current
> > time (inclusive).
> > 
> 
> That will be a problem. What you're suggesting is the current status
> quo with the delegated attrs code, and that behavior was the source of
> the problems that we were seeing in the git regression testsuite.
> 
> 
> When git checks out an object, it opens a file, writes to it and then
> stats it so that it can later see whether it changed. If it gets a
> WRITE_ATTRS_DELEG delegation, the client doesn't wait on writeback
> before returning from that stat().
> 
> Then later, we go to do writeback. The mtime and ctime on the server
> get set to the server's local time (which is later than the time that
> git has recorded). Finally, the client does the SETATTR+DELEGRETURN and
> tries to set the timestamps to the same times that git has recorded,
> but those times are too early vs. the current timestamps on the file
> and they get ignored (in accordance with the spec).
> 
> This was the source of my confusion with the spec. When it says
> "original time", it means the timestamps at the time that the
> delegation was created, but I interpreted it the same way you did.
> 
> Unfortunately, if we want to do this, then we have to allow nfsd to set
> the ctime to a time earlier than the current ctime on the inode. I too
> have some reservations with this. This means that applications on the
> server may see the ctime go backward, which I really do not like. 

An alternate approach would be to allow the writeback through a
delegation to skip the mtime/ctime update, possibly making use of
FMODE_NOCMTIME.

It would be nice to have some mechanism in the VFS to ensure there was
an ATTR_CTIME_SET request on any file which had made use of
FMODE_NOCMTIME before that file was closed, else the times would be set
to the time of the close.  That wouldn't be entirely straight forward,
but should be manageable.  (I would allow some way to avoid the ctime
update on close so XFS_IOC_OPENBY_HANDLE could still be supported, but
it would need to be explicit somewhere).

While FMODE_NOCMTIME also distorts the meaning of ctime, I think it is
better than making it too easy for ctime to go backwards.

How would you feel about that approach?

> 
> Interesting. I don't think they have any immediate plans to upstream
> the server (the priority is the client), but having this functionality
> in the VFS would make it easier to integrate.

I think that splitting the client from the server is a non-trivial task
that brings no benefit to anyone.  Any chance I get I advocate
upstreaming both at once.

Thanks,
NeilBrown

