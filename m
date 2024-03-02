Return-Path: <linux-fsdevel+bounces-13366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D889286F071
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 13:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B04CBB23F9B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 12:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083A9171A5;
	Sat,  2 Mar 2024 12:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6hgbQrC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639928F5A;
	Sat,  2 Mar 2024 12:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709383435; cv=none; b=VqAuPk7tJuTTWV9nRRV/uyhCcvlh0F33xoUCXnV38hLqpN9CC2/SNMoAEtuwLaon1LlMLlFrySg5dm2KYNsQM6i0N9xG9zmZsSeAFJPFpON97jmRv8gCnsxqGzX232unMVNUFkbkROrQXTU7SYBwQXBmrrINiHA0qE5CSYelep0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709383435; c=relaxed/simple;
	bh=q60y/AngEcKNnm24/YSZKU0RVipBlYt31yXvpaj/VeM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hm1+uUhS/Bskwv82MpY6rDWJPikagnKfr+qL2VqUQODHim0FAszWh6qK8cRoxw08XK45mwpsJI/MozXt+7aZl36PuW4mx1hTdvxhQKQ7EEKnS/kL950H6whg4C17gQjgiHC2oVmcgi874rR/7jGZi2XSG0OvN+SW6OZu9y/a3nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u6hgbQrC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65308C433F1;
	Sat,  2 Mar 2024 12:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709383434;
	bh=q60y/AngEcKNnm24/YSZKU0RVipBlYt31yXvpaj/VeM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=u6hgbQrCzKIdQ1UvI8XNEE7i5dU7MYJ3HntjMbeJ7qLDZR48JyJOD6qx4X9bmb54J
	 ZOLvLVENZDJVYp+ft0dQMv6cSl2oQicwE2bywE+OM8wxqzWjRdMaaubzh2x0p09lVC
	 Js+WZelx4m46iZujKr5AogwJ3tea2ZjTnLCHBQD8yjmI4YxkxUTRIJHQxsX2Z6+KC/
	 laaXVMcgUSgeW9fXlyzU31zI3vOEuR+EqNyw8tkxUcRWYkx9ZSWEYAwDikr5oFgbr4
	 LqYMwIcvO+igcZ/MNG7pK3jgMmF/pN1odFgO12EgpZQKrLBZpsnZjHFUfJQudA18fr
	 4EiV5GcFdQKXw==
Message-ID: <98b41ce0e577cffcc45c7d29781ca2d85ed19d5e.camel@kernel.org>
Subject: Re: [PATCH 14/13] xfs: make XFS_IOC_COMMIT_RANGE freshness data
 opaque
From: Jeff Layton <jlayton@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, hch@lst.de
Date: Sat, 02 Mar 2024 07:43:53 -0500
In-Reply-To: <20240302024831.GL1927156@frogsfrogsfrogs>
References: <170900011604.938268.9876750689883987904.stgit@frogsfrogsfrogs>
	 <20240227174649.GL6184@frogsfrogsfrogs>
	 <CAOQ4uxiPfno-Hx+fH3LEN_4D6HQgyMAySRNCU=O2R_-ksrxSDQ@mail.gmail.com>
	 <20240229232724.GD1927156@frogsfrogsfrogs>
	 <bf2f4a0e7033091d34139540737674dc998fe010.camel@kernel.org>
	 <20240302024831.GL1927156@frogsfrogsfrogs>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
	kZWuOsJdJQdmwlWC5L5ln9xgfr/4mOY38B0U=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-03-01 at 18:48 -0800, Darrick J. Wong wrote:
> On Fri, Mar 01, 2024 at 08:31:21AM -0500, Jeff Layton wrote:
> > On Thu, 2024-02-29 at 15:27 -0800, Darrick J. Wong wrote:
> > > On Tue, Feb 27, 2024 at 08:52:58PM +0200, Amir Goldstein wrote:
> > > > On Tue, Feb 27, 2024 at 7:46=E2=80=AFPM Darrick J. Wong <djwong@ker=
nel.org> wrote:
> > > > >=20
> > > > > From: Darrick J. Wong <djwong@kernel.org>
> > > > >=20
> > > > > To head off bikeshedding about the fields in xfs_commit_range, le=
t's
> > > > > make it an opaque u64 array and require the userspace program to =
call
> > > > > a third ioctl to sample the freshness data for us.  If we ever co=
nverge
> > > > > on a definition for i_version then we can use that; for now we'll=
 just
> > > > > use mtime/ctime like the old swapext ioctl.
> > > >=20
> > > > This addresses my concerns about using mtime/ctime.
> > >=20
> > > Oh good! :)
> > >=20
> > > > I have to say, Darrick, that I think that referring to this concern=
 as
> > > > bikeshedding is not being honest.
> > > >=20
> > > > I do hate nit picking reviews and I do hate "maybe also fix the wor=
ld"
> > > > review comments, but I think the question about using mtime/ctime i=
n
> > > > this new API was not out of place
> > >=20
> > > I agree, your question about mtime/ctime:
> > >=20
> > > "Maybe a stupid question, but under which circumstances would mtime
> > > change and ctime not change? Why are both needed?"
> > >=20
> > > was a very good question.  But perhaps that statement referred to the
> > > other part of that thread.
> > >=20
> > > >                                   and I think that making the fresh=
ness
> > > > data opaque is better for everyone in the long run and hopefully, t=
his will
> > > > help you move to the things you care about faster.
> > >=20
> > > I wish you'd suggested an opaque blob that the fs can lay out however=
 it
> > > wants instead of suggesting specifically the change cookie.  I'm very
> > > much ok with an opaque freshness blob that allows future flexibility =
in
> > > how we define the blob's contents.
> > >=20
> > > I was however very upset about the Jeff's suggestion of using i_versi=
on.
> > > I apologize for using all caps in that reply, and snarling about it i=
n
> > > the commit message here.  The final version of this patch will not ha=
ve
> > > that.
> > >=20
> > > That said, I don't think it is at all helpful to suggest using a file
> > > attribute whose behavior is as yet unresolved.  Multigrain timestamps
> > > were a clever idea, regrettably reverted.  As far as I could tell whe=
n I
> > > wrote my reply, neither had NFS implemented a better behavior and
> > > quietly merged it; nor have Jeff and Dave produced any sort of candid=
ate
> > > patchset to fix all the resulting issues in XFS.
> > >=20
> > > Reading "I realize that STATX_CHANGE_COOKIE is currently kernel
> > > internal" made me think "OH $deity, they wants me to do that work
> > > too???"
> > >=20
> > > A better way to have woreded that might've been "How about switching
> > > this to a fs-determined structure so that we can switch the freshness
> > > check to i_version when that's fully working on XFS?"
> > >=20
> > > The problem I have with reading patch review emails is that I can't
> > > easily tell whether an author's suggestion is being made in a casual
> > > offhand manner?  Or if it reflects something they feel strongly needs
> > > change before merging.
> > >=20
> > > In fairness to you, Amir, I don't know how much you've kept on top of
> > > that i_version vs. XFS discussion.  So I have no idea if you were awa=
re
> > > of the status of that work.
> > >=20
> >=20
> > Sorry, I didn't mean to trigger anyone, but I do have real concerns
> > about any API that attempts to use timestamps to detect whether
> > something has changed.
> >=20
> > We learned that lesson in NFS in the 90's. VFS timestamp resolution is
> > just not enough to show whether there was a change to a file -- full
> > stop.
> >=20
> > I get the hand-wringing over i_version definitions and I don't care to
> > rehash that discussion here, but I'll point out that this is a
> > (proposed) XFS-private interface:
> >=20
> > What you could do is expose the XFS change counter (the one that gets
> > bumped for everything, even atime updates, possibly via different
> > ioctl), and use that for your "freshness" check.
> >=20
> > You'd unfortunately get false negative freshness checks after read
> > operations, but you shouldn't get any false positives (which is real
> > danger with timestamps).
>=20
> I don't see how would that work for this usecase?  You have to sample
> file2 before reflinking file2's contents to file1, writing the changes
> to file1, and executing COMMIT_RANGE.  Setting the xfs-private REFLINK
> inode flag on file2 will trigger an iversion update even though it won't
> change mtime or ctime.  The COMMIT then fails due to the inode flags
> change.
>=20
> Worse yet, applications aren't going to know if a particular access is
> actually the one that will trigger an atime update.  So this will just
> fail unpredictably.
>=20
> If iversion was purely a write counter then I would switch the freshness
> implementation to use it.  But it's not, and I know this to be true
> because I tried that and could not get COMMIT_RANGE to work reliably.
> I suppose the advantage of the blob thing is that we actually /can/
> switch over whenever it's ready.
>=20

Yeah, that's the other part -- you have to be willing to redrive the I/O
every time the freshness check fails, which can get expensive depending
on how active the file is. Again this is an XFS interface, so I don't
really have a dog in this fight. If you think timestamps are good
enough, then so be it.

All I can do is mention that it has been our experience in the NFS world
that relying on timestamps like this will eventually lead to data
corruption. The race conditions may be tight, and much of the time the
race may be benign, but if you do this enough you'll eventually get
bitten, and end up exchanging data when you shouldn't have.

All of that said, I think this is great discussion fodder for LSF this
year. I feel like the time is right to consider these sorts of
interfaces that do synchronized I/O without locking. I've already
proposed a discussion around the state of the i_version counter, so
maybe we can chat about it then?
--=20
Jeff Layton <jlayton@kernel.org>

