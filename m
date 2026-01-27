Return-Path: <linux-fsdevel+bounces-75565-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PM8GXUheGk/oQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75565-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 03:22:45 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 873048EFBB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 03:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F26263008C83
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 02:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066232BEFF6;
	Tue, 27 Jan 2026 02:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5ApBLhT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890923398A;
	Tue, 27 Jan 2026 02:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769480556; cv=none; b=qfiW+7gw1MexE61SnuJlK6sesUikguy9jF/UEUGKT1FBDrR9rhsMfIztx36bhuQzhuuYQ8GU5d0KwuUhdJ/AiumGdFhnb8ilJx37uZZAvbuaMepwuWEzItr3RxjZTB4mgDmLj+1/sL9plkl1TV0mWiBcq0HNa/c0NfKGBoU027s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769480556; c=relaxed/simple;
	bh=8NAS8ZwSuZX9BpXZwVPtapt6VfdmE6WttJtnP0HYla0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KXK/lLN8579z2Dlpp/BOM5XLEQzTHbSvw25AZ0jPenopav2qpUo2qB+EoNKPZjxVf8wP2jvrYKOl0lRNsUmdraOU/Ij9taxubjMUb490R+ZMA9NF5rjAENCP0W7cyaK2oNCIrgsnpXIBK1jztqiyJxeU55j9iskiuHeE8pthncQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5ApBLhT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159E0C116C6;
	Tue, 27 Jan 2026 02:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769480556;
	bh=8NAS8ZwSuZX9BpXZwVPtapt6VfdmE6WttJtnP0HYla0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T5ApBLhTIKQnxIjgd50S7d2UqhhwZY5Cl7gkgP2VNXOK6zwNNl/AAhp+CaW8kSZcg
	 WgGSnvtixqlNYm4kXQS4wNc11VMITbd85Q8zRE4snS63v5S9VCXFyC9QbJ0yMsOl6D
	 unW9JHOqV0ms93DVufxVtGVfu/JFd8cl/nLgHeE5I+Z2dgOsC8s6RLj31yFcaxflEf
	 oHGmRWyy37KK/e6uYi1aavLwObN40jZs4ZwF8tncPIB8/mNnIQ+vLbmU0NbzY3bzIA
	 y8aZDz5Bllxffho7xOB0tjbQZMM54HX/yo1bs8p5shGVIvvRTFM8LLIfCWCOW0hknt
	 GxMq/CW418YoQ==
Date: Mon, 26 Jan 2026 18:22:35 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, neal@gompa.dev,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCHSET v6 4/8] fuse: allow servers to use iomap for better
 file IO performance
Message-ID: <20260127022235.GG5900@frogsfrogsfrogs>
References: <20251029002755.GK6174@frogsfrogsfrogs>
 <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
 <CAJnrk1Z05QZmos90qmWtnWGF+Kb7rVziJ51UpuJ0O=A+6N1vrg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1Z05QZmos90qmWtnWGF+Kb7rVziJ51UpuJ0O=A+6N1vrg@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75565-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 873048EFBB
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 04:59:16PM -0800, Joanne Koong wrote:
> On Tue, Oct 28, 2025 at 5:38 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > Hi all,
> >
> > This series connects fuse (the userspace filesystem layer) to fs-iomap
> > to get fuse servers out of the business of handling file I/O themselves.
> > By keeping the IO path mostly within the kernel, we can dramatically
> > improve the speed of disk-based filesystems.  This enables us to move
> > all the filesystem metadata parsing code out of the kernel and into
> > userspace, which means that we can containerize them for security
> > without losing a lot of performance.
> 
> I haven't looked through how the fuse2fs or fuse4fs servers are
> implemented yet (also, could you explain the difference between the
> two? Which one should we look at to see how it all ties together?),

fuse4fs is a lowlevel fuse server; fuse2fs is a high(?) level fuse
server.  fuse4fs is the successor to fuse2fs, at least on Linux and BSD.

> but I wonder if having bpf infrastructure hooked up to fuse would be
> especially helpful for what you're doing here with fuse iomap. afaict,
> every read/write whether it's buffered or direct will incur at least 1
> call to ->iomap_begin() to get the mapping metadata, which will be 2
> context-switches (and if the server has ->iomap_end() implemented,
> then 2 more context-switches).

Yes, I agree that's a lot of context switching for file IO...

> But it seems like the logic for retrieving mapping
> offsets/lengths/metadata should be pretty straightforward?

...but it gets very cheap if the fuse server can cache mappings in the
kernel to avoid all that.  That is, incidentally, what patchset #7
implements.

https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-cache_2026-01-22

> If the extent lookups are table lookups or tree
> traversals without complex side effects, then having
> ->iomap_begin()/->iomap_end() be executed as a bpf program would avoid
> the context switches and allow all the caching logic to be moved from
> the kernel to the server-side (eg using bpf maps).

Hrmm.  Now that /is/ an interesting proposal.  Does BPF have a data
structure that supports interval mappings?  I think the existing bpf map
only does key -> value.  Also, is there an upper limit on the size of a
map?  You could have hundreds of millions of maps for a very fragmented
regular file.

At one point I suggested to the famfs maintainer that it might be
easier/better to implement the interleaved mapping lookups as bpf
programs instead of being stuck with a fixed format in the fuse
userspace abi, but I don't know if he ever implemented that.

> Is this your
> assessment of it as well or do you think the server-side logic for
> iomap_begin()/iomap_end() is too complicated to make this realistic?
> Asking because I'm curious whether this direction makes sense, not
> because I think it would be a blocker for your series.

For disk-based filesystems I think it would be difficult to model a bpf
program to do mappings, since they can basically point anywhere and be
of any size.

OTOH it would be enormously hilarious to me if one could load a file
mapping predictive model into the kernel as a bpf program and use that
as a first tier before checking the in-memory btree mapping cache from
patchset 7.  Quite a few years ago now there was a FAST paper
establishing that even a stupid linear regression model could in theory
beat a disk btree lookup.

--D

> Thanks,
> Joanne
> 
> >
> > If you're going to start using this code, I strongly recommend pulling
> > from my git trees, which are linked below.
> >
> > This has been running on the djcloud for months with no problems.  Enjoy!
> > Comments and questions are, as always, welcome.
> >
> > --D
> >
> > kernel git tree:
> > https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-fileio
> > ---
> > Commits in this patchset:
> >  * fuse: implement the basic iomap mechanisms
> >  * fuse_trace: implement the basic iomap mechanisms
> >  * fuse: make debugging configurable at runtime
> >  * fuse: adapt FUSE_DEV_IOC_BACKING_{OPEN,CLOSE} to add new iomap devices
> >  * fuse_trace: adapt FUSE_DEV_IOC_BACKING_{OPEN,CLOSE} to add new iomap devices
> >  * fuse: flush events and send FUSE_SYNCFS and FUSE_DESTROY on unmount
> >  * fuse: create a per-inode flag for toggling iomap
> >  * fuse_trace: create a per-inode flag for toggling iomap
> >  * fuse: isolate the other regular file IO paths from iomap
> >  * fuse: implement basic iomap reporting such as FIEMAP and SEEK_{DATA,HOLE}
> >  * fuse_trace: implement basic iomap reporting such as FIEMAP and SEEK_{DATA,HOLE}
> >  * fuse: implement direct IO with iomap
> >  * fuse_trace: implement direct IO with iomap
> >  * fuse: implement buffered IO with iomap
> >  * fuse_trace: implement buffered IO with iomap
> >  * fuse: implement large folios for iomap pagecache files
> >  * fuse: use an unrestricted backing device with iomap pagecache io
> >  * fuse: advertise support for iomap
> >  * fuse: query filesystem geometry when using iomap
> >  * fuse_trace: query filesystem geometry when using iomap
> >  * fuse: implement fadvise for iomap files
> >  * fuse: invalidate ranges of block devices being used for iomap
> >  * fuse_trace: invalidate ranges of block devices being used for iomap
> >  * fuse: implement inline data file IO via iomap
> >  * fuse_trace: implement inline data file IO via iomap
> >  * fuse: allow more statx fields
> >  * fuse: support atomic writes with iomap
> >  * fuse_trace: support atomic writes with iomap
> >  * fuse: disable direct reclaim for any fuse server that uses iomap
> >  * fuse: enable swapfile activation on iomap
> >  * fuse: implement freeze and shutdowns for iomap filesystems
> > ---
> >  fs/fuse/fuse_i.h          |  161 +++
> >  fs/fuse/fuse_trace.h      |  939 +++++++++++++++++++
> >  fs/fuse/iomap_i.h         |   52 +
> >  include/uapi/linux/fuse.h |  219 ++++
> >  fs/fuse/Kconfig           |   48 +
> >  fs/fuse/Makefile          |    1
> >  fs/fuse/backing.c         |   12
> >  fs/fuse/dev.c             |   30 +
> >  fs/fuse/dir.c             |  120 ++
> >  fs/fuse/file.c            |  133 ++-
> >  fs/fuse/file_iomap.c      | 2230 +++++++++++++++++++++++++++++++++++++++++++++
> >  fs/fuse/inode.c           |  162 +++
> >  fs/fuse/iomode.c          |    2
> >  fs/fuse/trace.c           |    2
> >  14 files changed, 4056 insertions(+), 55 deletions(-)
> >  create mode 100644 fs/fuse/iomap_i.h
> >  create mode 100644 fs/fuse/file_iomap.c
> >
> 

