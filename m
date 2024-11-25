Return-Path: <linux-fsdevel+bounces-35750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA589D7A3D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 04:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EA90B21EBF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 03:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D7A10A1F;
	Mon, 25 Nov 2024 03:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="byQEvRGK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B8D383
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2024 03:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732503678; cv=none; b=p5qVunW+t2z4+YQ6jew8rxtpi+UIpX5JJ1Y1iO99DXjmQc0hScZtusYBr4h457s1H89D6QZb8+FNJq4hZrX1XU/x2T2GL53puhtNDBLYkh+oKPdu9bSOHM3rCSDPMP1hly120WcM8CCF/3w425ArCDRCofDFqhVHU5VgGwvtqFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732503678; c=relaxed/simple;
	bh=GTXL8Ok3VoBTsoX3b+da91zTqZi8vFqDIx13OFRg/RQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GHfcDMbVpuTAkz2w2lhH8uc7ip7ciW3GL/QwaQZ6oJh4ZyCvH/yCxhU/4mDr7WlsrJy/fGBhnPEpQAWj9U+o9PfAJqhoN/+kv8XKjafl8MFzLxJ+tGC9KugMTFwanFG5UnvfeTKfl3JlzUoW3nrEUD1N5uCUrRPE05/MiRnR5lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=byQEvRGK; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (syn-098-147-040-133.biz.spectrum.com [98.147.40.133])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4AP30xkh008918
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 24 Nov 2024 22:01:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1732503663; bh=PPt+wKM/h97jD1N6HKRy2W7YRkwKIcTc0NcIYKxzgw8=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=byQEvRGKKJEwLixaCjQxllAyZY7L4d0W3OsK8OJpjRnG9JopN6Wb6+Fg0TQQ006p8
	 YfH+zgCOwXooTr/sqt8ozDqCA9xcc/TGM1ojJxaAB45CfAOKVa41FoywTcddPV501C
	 eENy+LZwxnJhfIMbLP3sxCaOWrS5vxmm562EP18pPfYYCodgWZUYuSGQ/cmZTQboaB
	 UB51rVD4NgVamZSmVmrCUT54HKRe8ojPcAjib+4WewuIJD1kt+ZsPNKnWCgwy37Xyh
	 rW7Di8f6LW225tthHWvEmXyTMji7gRFIoq1sGJEdw4YrdkOpwbsahSTRyRPWIeoy0j
	 dDE2U+MTT0H9g==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 0477C34127F; Sun, 24 Nov 2024 22:00:59 -0500 (EST)
Date: Sun, 24 Nov 2024 17:00:58 -1000
From: "Theodore Ts'o" <tytso@mit.edu>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: syzbot <syzbot+320c57a47bdabc1f294b@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        surajsonawane0215@gmail.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] WARNING in minix_unlink
Message-ID: <20241125030058.GE3874922@mit.edu>
References: <CAHiZj8jbd9SQwKj6mvDQ3Kgi2z8rrCCwsqgjOgFtCzsk5MVPzQ@mail.gmail.com>
 <6743814d.050a0220.1cc393.0049.GAE@google.com>
 <20241124194701.GY3387508@ZenIV>
 <20241124201009.GZ3387508@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241124201009.GZ3387508@ZenIV>

On Sun, Nov 24, 2024 at 08:10:09PM +0000, Al Viro wrote:
> > What happens there is that on a badly corrupt image we have an on-disk
> > inode with link count below the actual number of links.  And after
> > unlinks remove enough of those to drive the link count to 0, inode
> > is freed.  After that point, all remaining links are pointing to a freed
> > on-disk inode, which is discovered when they need to decrement of link
> > count that is already 0.  Which does deserve a warning, probably without
> > a stack trace.
> > 
> > There's nothing the kernel can do about that, short of scanning the entire
> > filesystem at mount time and verifying that link counts are accurate...
> 
> Theoretically we could check if there's an associated dentry at the time of
> decrement-to-0 and refuse to do that decrement in such case, marking the
> in-core inode so that no extra dentries would be associated with it
> from that point on.  Not sure if that'd make for a good mitigation strategy,
> though - and it wouldn't help in case of extra links we hadn't seen by
> that point; they would become dangling pointers and reuse of on-disk inode
> would still be possible...

Yeah, what we do with ext4 in that case is that we mark the file
system as corrupted, and print an ext4_error() message, but we don't
call WARN_ON.  At this point, you cam either (a) force a reboot, so
that it can get fixed up at fsck time --- this might be appropriate if
you have a failover setup, where bringing the system *down* so the
backup system can do its thing without further corrupting user data,
(b) remount the file system read-only, so that you don't actually do
any further damage to the system, or (c) if the file system is marked
"don't worry, be happy, continue running because some silly security
policy says that bringing the system down is a denial of service
attack and we can't have that (**sigh**), it might be a good idea to
mark the block group as "corrupted" and refuse to do any further block
or inode allocations out of that block group until the file system can
be properly checked.

Anyway, this is why I now ignore any syzkaller report that involves a
badly corrupted file system being mounted.  That's not something I
consider a valid threat model, and if someone wants to pay an engineer
to work through all of those issues, *great*, but I don't have the
time to deal with what I consider a super-low-priority issue.

					- Ted

