Return-Path: <linux-fsdevel+bounces-77429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEMuDrHvlGmOJAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 23:46:09 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B2715199D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 23:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D5E5D3046F3D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 22:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EC427B357;
	Tue, 17 Feb 2026 22:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqo8c5H8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265951A9F83;
	Tue, 17 Feb 2026 22:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771368361; cv=none; b=P/K8DHCyH69SbFOlcmj/HjGRoCvCt90sRh19cLojt8lqAZEq7eIl2ctEH1igrPArX/TApRH5ffYiqN07UdwP8GabR9VmbyqGrf5XP0RACQiiRkgmEVOI4NFUEm439vcyGVsHWgkXUGQQgvP/xmq79uNe8fx/9soULTVpFI7kAuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771368361; c=relaxed/simple;
	bh=IA0KJ8qlcIfjt6ChC5mEPNg1N7IRegvYFKFbw03Jb1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+yedU/XPncqjrLlgFWgJWlv6ykrsk2q+r5NZBteE/CoBTf54c34z2mPkJ7GqwQNjZKUsCDArOQe1tl2Rlpk4ehM4rivdYH+bQ/r3q7xDwr1MaYUyBRqbTs4iP2cMne2nwoaJnZpTeycAGW5vQvvc3ImzNQcgUlYffkvLusJxNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqo8c5H8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3DABC4CEF7;
	Tue, 17 Feb 2026 22:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771368360;
	bh=IA0KJ8qlcIfjt6ChC5mEPNg1N7IRegvYFKFbw03Jb1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hqo8c5H8ggMwsYSveXVxtxUOXCxKypC2JTZQ3yeCid2QUmSkGX7l7m3gEWjxex2R/
	 BYkUqHCm7otpwfwYVtLXEvC9suoYlEtvxPyZbJrx/egY4jo6PKrzgv1/UIwpyM/nm0
	 9j7r7dH0ge3kG1VZQIbAhAecf+ovU7liDXlc4XfZ/EM+pron/dotA89afLXXOaE2pK
	 DRtfXeLMmCUy3VavZuB4VGLNXDjiNNhgQrx96ShaoA/GN9bL35V0vWQHkhssUJSXum
	 FGrn18Rh2xzrkwkRohyP7FKZR42yf9Tdm+CE/AOUNWOz6XpUZ9HWhh6BMcPKEuOnhP
	 n2c5jiREVaxlg==
Date: Wed, 18 Feb 2026 09:45:46 +1100
From: Dave Chinner <dgc@kernel.org>
To: Andres Freund <andres@anarazel.de>
Cc: Amir Goldstein <amir73il@gmail.com>, Christoph Hellwig <hch@lst.de>,
	Pankaj Raghav <pankaj.raghav@linux.dev>, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	lsf-pc@lists.linux-foundation.org, djwong@kernel.org,
	john.g.garry@oracle.com, willy@infradead.org, ritesh.list@gmail.com,
	jack@suse.cz, ojaswin@linux.ibm.com,
	Luis Chamberlain <mcgrof@kernel.org>, dchinner@redhat.com,
	Javier Gonzalez <javier.gonz@samsung.com>, gost.dev@samsung.com,
	tytso@mit.edu, p.raghav@samsung.com, vi.shah@samsung.com
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Buffered atomic writes
Message-ID: <aZTvmpOL7NC4_kDq@dread>
References: <d0c4d95b-8064-4a7e-996d-7ad40eb4976b@linux.dev>
 <20260217055103.GA6174@lst.de>
 <CAOQ4uxgdWvJPAi6QMWQjWJ2TnjO=JP84WCgQ+ShM3GiikF=bSw@mail.gmail.com>
 <ndwqem2mzymo6j3zw3mmxk2vh4mnun2fb2s5vrh4nthatlze3u@qjemcazy4agv>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ndwqem2mzymo6j3zw3mmxk2vh4mnun2fb2s5vrh4nthatlze3u@qjemcazy4agv>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77429-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dgc@kernel.org,linux-fsdevel@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,lst.de,linux.dev,vger.kernel.org,kvack.org,lists.linux-foundation.org,kernel.org,oracle.com,infradead.org,suse.cz,linux.ibm.com,redhat.com,samsung.com,mit.edu];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sgi.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E8B2715199D
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 10:47:07AM -0500, Andres Freund wrote:
> Hi,
> 
> On 2026-02-17 10:23:36 +0100, Amir Goldstein wrote:
> > On Tue, Feb 17, 2026 at 8:00 AM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > I think a better session would be how we can help postgres to move
> > > off buffered I/O instead of adding more special cases for them.
> 
> FWIW, we are adding support for DIO (it's been added, but performance isn't
> competitive for most workloads in the released versions yet, work to address
> those issues is in progress).
> 
> But it's only really be viable for larger setups, not for e.g.:
> - smaller, unattended setups
> - uses of postgres as part of a larger application on one server with hard to
>   predict memory usage of different components
> - intentionally overcommitted shared hosting type scenarios
> 
> Even once a well configured postgres using DIO beats postgres not using DIO,
> I'll bet that well over 50% of users won't be able to use DIO.
> 
> 
> There are some kernel issues that make it harder than necessary to use DIO,
> btw:
> 
> Most prominently: With DIO concurrently extending multiple files leads to
> quite terrible fragmentation, at least with XFS. Forcing us to
> over-aggressively use fallocate(), truncating later if it turns out we need
> less space.

<ahem>

seriously, fallocate() is considered harmful for exactly these sorts
of reasons. XFS has vastly better mechanisms built into it that
mitigate worst case fragmentation without needing to change
applications or increase runtime overhead.

So, lets go way back - 32 years ago to 1994:

commit 32766d4d387bc6779e0c432fb56a0cc4e6b96398
Author: Doug Doucette <doucette@engr.sgi.com>
Date:   Thu Mar 3 22:17:15 1994 +0000

    Add fcntl implementation (F_FSGETXATTR, F_FSSETXATTR, and F_DIOINFO).
    Fix xfs_setattr new xfs fields' implementation to split out error checking
    to the front of the routine, like the other attributes.  Don't set new
    fields in xfs_getattr unless one of the fields is requested.

.....

+       case F_FSSETXATTR: {
+               struct fsxattr fa;
+               vattr_t va;
+
+               if (copyin(arg, &fa, sizeof(fa))) {
+                       error = EFAULT;
+                       break;
+               }
+               va.va_xflags = fa.fsx_xflags;
+               va.va_extsize = fa.fsx_extsize;
                                ^^^^^^^^^^^^^^^
+               error = xfs_setattr(vp, &va, AT_XFLAGS|AT_EXTSIZE, credp);
+               break;
+           }


This was the commit that added user controlled extent size hints to
XFS. These already existed in EFS, so applications using this
functionality go back to the even earlier in the 1990s.

So, let's set the extent size hint on a file to 1MB. Now whenever a
data extent allocation on that file is attempted, the extent size
that is allocated will be rounded up to the nearest 1MB.  i.e. XFS
will try to allocate unwritten extents in aligned multiples of the
extent size hint regardless of the actual IO size being performed.

Hence if you are doing concurrent extending 8kB writes, instead of
allocating 8kB at a time, the extent size hint will force a 1MB
unwritten extent to be allocated out beyond EOF. The subsequent
extending 8kB writes to that file now hit that unwritten extent, and
only need to convert it to written. The same will happen for all
other concurrent extending writes - they will allocate in 1MB
chunks, not 8KB.

The result will be that the files will interleave 1MB sized extents
across files instead of 8kB sized extents. i.e. we've just reduced
the worst case fragmentation behaviour by a factor of 128. We've
also reduced allocation overhead by a factor of 128, so the use of
extent size hints results in the filesystem behaving in a far more
efficient way and hence this results in higher performance.

IOWs, the extent size hint effectively sets a minimum extent size
that the filesystem will create for a given file, thereby mitigating
the worst case fragmentation that can occur. However, the use of
fallocate() in the application explicitly prevents the filesystem
from doing this smart, transparent IO path thing to mitigate
fragmentation.

One of the most important properties of extent size hints is that
they can be dynamically tuned *without changing the application.*
The extent size hint is a property of the inode, and it can be set
by the admin through various XFS tools (e.g. mkfs.xfs for a
filesystem wide default, xfs_io to set it on a directory so all new
files/dirs created in that directory inherit the value, set it on
individual files, etc). It can be changed even whilst the file is in
active use by the application.

Hence the extent size hint it can be changed at any time, and you
can apply it immediately to existing installations as an active
mitigation. Doing this won't fix existing fragmentation (that's what
xfs_fsr is for), but it will instantly mitigate/prevent new
fragmentation from occurring. It's much more difficult to do this
with applications that use fallocate()...

Indeed, the case for using fallocate() instead of extent size hints
gets worse the more you look at how extent size hints work.

Extent size hints don't impact IO concurrency at all. Extent size
hints are only applied during extent allocation, so the optimisation
is applied naturally as part of the existing concurrent IO path.
Hence using extent size hints won't block/stall/prevent concurrent
async IO in any way.

fallocate(), OTOH, causes a full IO pipeline stall (blocks submission
of both reads and writes, then waits for all IO in flight to drain)
on that file for the duration of the syscall. You can't do any sort
of IO (async or otherwise) and run fallocate() at the same time, so
fallocate() really sucks from the POV of a high performance IO app.

fallocate() also marks the files as having persistent preallocation,
which means that when you close the file the filesystem does not
remove excessive extents allocated beyond EOF.  Hence the reported
problems with excessive space usage and needing to truncate files
manually (which also cause a complete IO stall on that file) are
brought on specifically because fallocate() is being used by the
application to manage worst case fragmentation.

This problem does not exist with extent size hints - unused blocks
beyond EOF will be trimmed on last close or when the inode is cycled
out of cache, just like we do for excess speculative prealloc beyond
EOF for buffered writes (the buffered IO fragmentation mitigation
mechanism for interleaving concurrent extending writes).

The administrator can easily optimise extent size hints to match the
optimal characteristics of the underlying storage (e.g. set them to
be RAID stripe aligned), etc. Fallocate() requires the application
to provide tunables to modify it's behaviour for optimal storage
layout, and depending on how the application uses fallocate(), this
level of flexibility may not even be possible.

And let's not forget that an fallocate() based mitigation that helps
one filesystem type can actively hurt another type (e.g. ext4) by
introducing an application level extent allocation boundary vector
where there was none before.

Hence, IMO, micromanaging filesystem extent allocation with
fallocate() is -almost always- the wrong thing for applications to
be doing. There is no one "right way" to use fallocate() - what is
optimal for one filesystem will be pessimal for another, and it is
impossible to code optimal behaviour in the application for all
filesystem types the app might run on.

> The fallocate in turn triggers slowness in the write paths, as
> writing to uninitialized extents is a metadata operation.

That is not the problem you think it is. XFS is using unwritten
extents for all buffered IO writes that use delayed allocation, too,
and I don't see you complaining about that....

Yes, the overhead of unwritten extent conversion is more visible
with direct IO, but that's only because DIO has much lower overhead
and much, much higher performance ceiling than buffered IO. That
doesn't mean unwritten extents are a performance limiting factor...

> It'd be great if
> the allocation behaviour with concurrent file extension could be improved and
> if we could have a fallocate mode that forces extents to be initialized.

<sigh>

You mean like FALLOC_FL_WRITE_ZEROES?

That won't fix your fragmentation problem, and it has all the same
pipeline stall problems as allocating unwritten extents in
fallocate().

Only much worse now, because the IO pipeline is stalled for the
entire time it takes to write the zeroes to persistent storage. i.e.
long tail file access latencies will increase massively if you do
this regularly to extend files.

-Dave.
-- 
Dave Chinner
dgc@kernel.org

