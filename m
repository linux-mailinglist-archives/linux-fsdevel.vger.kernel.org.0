Return-Path: <linux-fsdevel+bounces-32483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9237B9A69CA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 15:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D0471F228B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 13:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62881F4731;
	Mon, 21 Oct 2024 13:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCaVSN9d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1E326ACD;
	Mon, 21 Oct 2024 13:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729516406; cv=none; b=O1dWEjxpSm+Q4Jzztm5AWe9XpWvxc5c74PzP9ZQ+5qsiyHmhWeyLtyW9jB28LbzniHsLHwCz5QbxfR+gzcpW404UTyzsou/Gpm5BlRdqFeUE87SnJdMJxdOM8PauN14Srqt60JtnhK5lD5+smAT7kMMXgTrLwYWHosZGh+gyuec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729516406; c=relaxed/simple;
	bh=EmRhKWOSYYuWLKvPGQXVgmL4h7IfTxQWrgR1R9tpH9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kcaarta7j3xjWi9K36Cpoidn+8R0cTV6+tHKGLrvtFOsHbTtIDirwH6+WhFbKXLkm5oFChWy4DXAkJkXJUrmXwFeE6/lMizbbNznVmfI4o9itKn9lxToGxvPU8cGQJBqbnTzjXDJKlFlywyaK0Yr4dJ7sR+X59IeqsyX9lsuieQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCaVSN9d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E77FDC4CEC3;
	Mon, 21 Oct 2024 13:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729516405;
	bh=EmRhKWOSYYuWLKvPGQXVgmL4h7IfTxQWrgR1R9tpH9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VCaVSN9dURA9zYAY3uImNi5qLazdbe6a2oNN9dDIdK9SKGXJypGFSKDbW1zZZgz5C
	 Q2FjkH3Y5zkG4We999HkJnuJNHfoq6lu/xBOUxUM6pbinhzdZeTGOEktECYOt5v2Pw
	 n8IuF3DdDQ1Uyixlm+r0gppHIbk0qru+/rzrnxPDXk6XCgq8mhdkfd1Bd/5Ga5JFqS
	 8Yy5Zd//cWWK/y/+Aif1UXy4cfCcCQdjglW+2lLn/ZpnVqlC29ontCDM2L4vYghy5J
	 NoXhjEkV0zXBHg6hReNac75yNRGWkCOQ0sU5sIVG7a/OdIJ7x/PiQDS+guTmEiMTW2
	 lzw/z0bIjXE4Q==
Date: Mon, 21 Oct 2024 15:13:20 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Paul Moore <paul@paul-moore.com>, Jeff Layton <jlayton@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, Trond Myklebust <trondmy@hammerspace.com>, 
	"mic@digikod.net" <mic@digikod.net>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"anna@kernel.org" <anna@kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, "audit@vger.kernel.org" <audit@vger.kernel.org>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: Re: [RFC PATCH v1 1/7] fs: Add inode_get_ino() and implement
 get_ino() for NFS
Message-ID: <20241021-forsten-sitzreihen-45035569f83b@brauner>
References: <20241010152649.849254-1-mic@digikod.net>
 <20241016-mitdenken-bankdaten-afb403982468@brauner>
 <CAHC9VhRd7cRXWYJ7+QpGsQkSyF9MtNGrwnnTMSNf67PQuqOC8A@mail.gmail.com>
 <5bbddc8ba332d81cbea3fce1ca7b0270093b5ee0.camel@hammerspace.com>
 <CAHC9VhQVBAJzOd19TeGtA0iAnmccrQ3-nq16FD7WofhRLgqVzw@mail.gmail.com>
 <ZxEmDbIClGM1F7e6@infradead.org>
 <CAHC9VhTtjTAXdt_mYEFXMRLz+4WN2ZR74ykDqknMFYWaeTNbww@mail.gmail.com>
 <5a5cfe8cb8155c2bb91780cc75816751213e28d7.camel@kernel.org>
 <CAHC9VhR=-MMA3JoUABhwdqkraDp_vvsK2k7Nh0NA4yomtn855w@mail.gmail.com>
 <20241018122543.cxbbtsmeksegoeh3@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241018122543.cxbbtsmeksegoeh3@quack3>

On Fri, Oct 18, 2024 at 02:25:43PM +0200, Jan Kara wrote:
> On Thu 17-10-24 16:21:34, Paul Moore wrote:
> > On Thu, Oct 17, 2024 at 1:05 PM Jeff Layton <jlayton@kernel.org> wrote:
> > > On Thu, 2024-10-17 at 11:15 -0400, Paul Moore wrote:
> > > > On Thu, Oct 17, 2024 at 10:58 AM Christoph Hellwig <hch@infradead.org> wrote:
> > > > > On Thu, Oct 17, 2024 at 10:54:12AM -0400, Paul Moore wrote:
> > > > > > Okay, good to know, but I was hoping that there we could come up with
> > > > > > an explicit list of filesystems that maintain their own private inode
> > > > > > numbers outside of inode-i_ino.
> > > > >
> > > > > Anything using iget5_locked is a good start.  Add to that file systems
> > > > > implementing their own inode cache (at least xfs and bcachefs).
> > > >
> > > > Also good to know, thanks.  However, at this point the lack of a clear
> > > > answer is making me wonder a bit more about inode numbers in the view
> > > > of VFS developers; do you folks care about inode numbers?  I'm not
> > > > asking to start an argument, it's a genuine question so I can get a
> > > > better understanding about the durability and sustainability of
> > > > inode->i_no.  If all of you (the VFS folks) aren't concerned about
> > > > inode numbers, I suspect we are going to have similar issues in the
> > > > future and we (the LSM folks) likely need to move away from reporting
> > > > inode numbers as they aren't reliably maintained by the VFS layer.
> > > >
> > >
> > > Like Christoph said, the kernel doesn't care much about inode numbers.
> > >
> > > People care about them though, and sometimes we have things in the
> > > kernel that report them in some fashion (tracepoints, procfiles, audit
> > > events, etc.). Having those match what the userland stat() st_ino field
> > > tells you is ideal, and for the most part that's the way it works.
> > >
> > > The main exception is when people use 32-bit interfaces (somewhat rare
> > > these days), or they have a 32-bit kernel with a filesystem that has a
> > > 64-bit inode number space (NFS being one of those). The NFS client has
> > > basically hacked around this for years by tracking its own fileid field
> > > in its inode.
> > 
> > When I asked if the VFS dev cared about inode numbers this is more of
> > what I was wondering about.  Regardless of if the kernel itself uses
> > inode numbers for anything, it does appear that users do care about
> > inode numbers to some extent, and I wanted to know if the VFS devs
> > viewed the inode numbers as a first order UAPI interface/thing, or if
> > it was of lesser importance and not something the kernel was going to
> > provide much of a guarantee around.  Once again, I'm not asking this
> > to start a war, I'm just trying to get some perspective from the VFS
> > dev side of things.
> 
> Well, we do care to not break our users. So our opinion about "first order
> UAPI" doesn't matter that much. If userspace is using it, we have to
> avoid breaking it. And there definitely is userspace depending on st_ino +
> st_dev being unique identifier of a file / directory so we want to maintain
> that as much as possible (at least as long as there's userspace depending
> on it which I don't see changing in the near future).
> 
> That being said historically people have learned NFS has its quirks,
> similarly as btrfs needing occasionally a special treatment and adapted to
> it, bcachefs is new enough that userspace didn't notice yet, that's going
> to be interesting.
> 
> There's another aspect that even 64-bits start to be expensive to pack
> things into for some filesystems (either due to external protocol
> constraints such as for AFS or due to the combination of features such as
> subvolumes, snapshotting, etc.). Going to 128-bits for everybody seems
> like a waste so at last LSF summit we've discussed about starting to push
> file handles (output of name_to_handle_at(2)) as a replacement of st_ino
> for file/dir identifier in a filesystem. For the kernel this would be
> convenient because each filesystem can pack there what it needs. But
> userspace guys were not thrilled by this (mainly due to the complexities of
> dynamically sized identifier and passing it around). So this transition
> isn't currently getting much traction and we'll see how things evolve.

It's also not an answer for every filesystem. For example, you don't
want to use file handles for pidfds when you are guaranteed that the
inode numbers will be unique. So file handles will not be used for that
where a simple statx() and comparing inode numbers can do.

