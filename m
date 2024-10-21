Return-Path: <linux-fsdevel+bounces-32489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4D59A6B7F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 16:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D63D1C21C6E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 14:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B5D1FA27B;
	Mon, 21 Oct 2024 14:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPaq+kI6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D21D1EF083;
	Mon, 21 Oct 2024 14:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729519491; cv=none; b=bhu+qKYyOrdFR1dNfk2oDOPNOztkAbOgXbehHUjL2xsCylf5vF5JtaU3HNb2WGdeR/0Q9/obj95rpBJ82n6xiujW5ttgIVlORn8aLYvRi14VxVFjDBpLX1p1iJ7ohmPzoQskFEYJrAUnh/p4JmiTtw2y/+kqw7SRowa32d49mJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729519491; c=relaxed/simple;
	bh=hrH2V6c/8cK4Iw7xtP5MFio7Xe3xp/y84khNAEgpvGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jpIFV1UVj8UIYHdNVdrlfe5uLGDtDCL1AUvjwR+H+ZHkQ7nFdCyClkdR7VICbcAAu/XAa9el3BFeymK6doBhZGGe1asWbmaSo3P6PeWbRfAYSN6uowmfGDNglZcZ48Mi0REWY2in6/97UKug2m6f2uo3z6jk5viaGbdyAff6tuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPaq+kI6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A51C4CEC3;
	Mon, 21 Oct 2024 14:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729519491;
	bh=hrH2V6c/8cK4Iw7xtP5MFio7Xe3xp/y84khNAEgpvGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CPaq+kI6GVcjfPmwaGq9FXFlYBJvoHxZV/L57+ykmug4wnEiR0yeQ+L7KsXnTkBlk
	 EWdrxGMrr8NTVJCOxBBIbhSUCrMRoJBIBCd/5EcZGF28QvFqihqt3Hvj+clBMfRism
	 oI1TUNBbANJ4mSpP96LvbrNNm4LVWdHMZgNCc3Od77fs+ljcCkQAqCDJNK5h1OgP0o
	 /ka04wbmSeTV/nAb5RL8kjMfQiwYzKYTq3aOE9+G6jUOW6Nli/HX+WB1UMU7Qj5e0A
	 aFqkMV2YWOmKk46vzH69vSuR1AV/4olauY3VurzktTRwf7T3W6fEZPHE2FwJAF0W11
	 rFDdYwLnzgRRQ==
Date: Mon, 21 Oct 2024 16:04:45 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, 
	Christoph Hellwig <hch@infradead.org>, Trond Myklebust <trondmy@hammerspace.com>, 
	"jack@suse.cz" <jack@suse.cz>, "mic@digikod.net" <mic@digikod.net>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "anna@kernel.org" <anna@kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, "audit@vger.kernel.org" <audit@vger.kernel.org>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: Re: [RFC PATCH v1 1/7] fs: Add inode_get_ino() and implement
 get_ino() for NFS
Message-ID: <20241021-geldpolitik-holzschnitt-b7f87ef4df02@brauner>
References: <20241010152649.849254-1-mic@digikod.net>
 <20241016-mitdenken-bankdaten-afb403982468@brauner>
 <CAHC9VhRd7cRXWYJ7+QpGsQkSyF9MtNGrwnnTMSNf67PQuqOC8A@mail.gmail.com>
 <5bbddc8ba332d81cbea3fce1ca7b0270093b5ee0.camel@hammerspace.com>
 <CAHC9VhQVBAJzOd19TeGtA0iAnmccrQ3-nq16FD7WofhRLgqVzw@mail.gmail.com>
 <ZxEmDbIClGM1F7e6@infradead.org>
 <CAHC9VhTtjTAXdt_mYEFXMRLz+4WN2ZR74ykDqknMFYWaeTNbww@mail.gmail.com>
 <5a5cfe8cb8155c2bb91780cc75816751213e28d7.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5a5cfe8cb8155c2bb91780cc75816751213e28d7.camel@kernel.org>

On Thu, Oct 17, 2024 at 01:05:54PM -0400, Jeff Layton wrote:
> On Thu, 2024-10-17 at 11:15 -0400, Paul Moore wrote:
> > On Thu, Oct 17, 2024 at 10:58 AM Christoph Hellwig <hch@infradead.org> wrote:
> > > On Thu, Oct 17, 2024 at 10:54:12AM -0400, Paul Moore wrote:
> > > > Okay, good to know, but I was hoping that there we could come up with
> > > > an explicit list of filesystems that maintain their own private inode
> > > > numbers outside of inode-i_ino.
> > > 
> > > Anything using iget5_locked is a good start.  Add to that file systems
> > > implementing their own inode cache (at least xfs and bcachefs).
> > 
> > Also good to know, thanks.  However, at this point the lack of a clear
> > answer is making me wonder a bit more about inode numbers in the view
> > of VFS developers; do you folks care about inode numbers?  I'm not
> > asking to start an argument, it's a genuine question so I can get a
> > better understanding about the durability and sustainability of
> > inode->i_no.  If all of you (the VFS folks) aren't concerned about
> > inode numbers, I suspect we are going to have similar issues in the
> > future and we (the LSM folks) likely need to move away from reporting
> > inode numbers as they aren't reliably maintained by the VFS layer.
> > 
> 
> Like Christoph said, the kernel doesn't care much about inode numbers.
> 
> People care about them though, and sometimes we have things in the
> kernel that report them in some fashion (tracepoints, procfiles, audit
> events, etc.). Having those match what the userland stat() st_ino field
> tells you is ideal, and for the most part that's the way it works.
> 
> The main exception is when people use 32-bit interfaces (somewhat rare
> these days), or they have a 32-bit kernel with a filesystem that has a
> 64-bit inode number space (NFS being one of those). The NFS client has
> basically hacked around this for years by tracking its own fileid field
> in its inode. That's really a waste though. That could be converted
> over to use i_ino instead if it were always wide enough.
> 
> It'd be better to stop with these sort of hacks and just fix this the
> right way once and for all, by making i_ino 64 bits everywhere.
> 
> A lot of the changes can probably be automated via coccinelle. I'd
> probably start by turning all of the direct i_ino accesses into static
> inline wrapper function calls. The hard part will be parceling out that
> work into digestable chunks. If you can avoid "flag day" changes, then
> that's ideal.  You'd want a patch per subsystem so you can collect
> ACKs. 
> 
> The hardest part will probably be the format string changes. I'm not
> sure you can easily use coccinelle for that, so that may need to be
> done by hand or scripted with python or something.

The problem where we're dealing with 64 bit inode numbers even on 32 bit
systems is one problem and porting struct inode to use a 64 bit type for
i_ino is a good thing that I agree we should explore.

I'm still not sure how that would stolve the audit problem though. The
inode numbers that audit reports, even if always 64 bit, are not unique
with e.g., btrfs and bcachefs. Audit would need to report additional
information for both filesystems like the subvolume number which would
make this consistent.

We should port to 64 bit and yes that'll take some time. Then audit may
want to grow support to report additional information such as the
subvolume number. And that can be done in various ways without having to
burden struct inode_operations with any of this. Or, document the 20
year reality that audit inode numbers aren't unique on some filesystems.

