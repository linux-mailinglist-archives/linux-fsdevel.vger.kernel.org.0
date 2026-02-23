Return-Path: <linux-fsdevel+bounces-78013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mI3dBk/ZnGkFLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:48:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F56917E8FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A07D3128FDF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 22:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED38B37BE64;
	Mon, 23 Feb 2026 22:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJKRUAnt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7904E83A14;
	Mon, 23 Feb 2026 22:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771886778; cv=none; b=Gv+a1fofLm1jlbR2OJIdgqbZOx4kzNBNY4Ld2BejV7PU148jBZxTLkfBu8rl9R70N2GXy0p07cJWTT1Z6kEXoPdBKE18o5A6jlgWp5VuFK5lc5k+61PdJKiGwrY5IA9Jq//xbYjwqBkCtsNViFEFMlPWWHxEfsCxM9bE4NBm704=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771886778; c=relaxed/simple;
	bh=dDqm3M/UUJINYrVqHDCxExjWkuLu8A/UfuHCHHnJhwM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GmKfpI8BaJ3rOESHb/xkL/ULD//05xDbgDaiXMYNX+Zjl7rXI/pcywzRmjVRsI1vHbfzxCZ5Y4iH6w4jvfr7xbOKde+61LUOjP/XBsClgK4vmql2UBRGXTEskJUdJLDtvxnyAYHlD036s6kMXFMij24/3I39U1aVWm2o8ZLREs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJKRUAnt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18973C116C6;
	Mon, 23 Feb 2026 22:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771886778;
	bh=dDqm3M/UUJINYrVqHDCxExjWkuLu8A/UfuHCHHnJhwM=;
	h=Date:From:To:Cc:Subject:From;
	b=WJKRUAntho7cZHN8rTDNJI7ieKd9HiRFwIpfqFdu7OL6UBDSljJLVGK1w9ko4VF9G
	 xuZEjuIasH4luO4t6J/9ZpI/1aZsfy9zd5NOgPcKLNar6FlxhOdevt5J/c+5ZaL+l7
	 r+uBGZSaUi1SWSKLTzlhiEEM+dQSirqmoob7CQ2msNO7dMa0LN2v+XGZEzMwqz8kEJ
	 u9pYaONC+HHe/BnIckWQQ4FpPsezotrC3jjiFzGcqgsz2K2Unoqenal8v/Yc+snNm3
	 /aus4wpH41ca4UJS84jkJ2mjogXHaiASpVM0h1+a0rUMI/3/Ky3nC8IG/nVrQw9PJ8
	 q6NyI4QvsszdA==
Date: Mon, 23 Feb 2026 14:46:17 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>, bpf@vger.kernel.org,
	linux-ext4 <linux-ext4@vger.kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bernd@bsbernd.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Theodore Ts'o <tytso@mit.edu>, Neal Gompa <neal@gompa.dev>,
	Amir Goldstein <amir73il@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>, John@groves.net,
	demiobenour@gmail.com
Subject: [PATCHBLIZZARD v7] fuse/libfuse/e2fsprogs: containerize ext4 for
 safer operation
Message-ID: <20260223224617.GA2390314@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78013-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[szeredi.hu,bsbernd.com,gmail.com,mit.edu,gompa.dev,kernel.org,groves.net];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6F56917E8FD
X-Rspamd-Action: no action

This is the seventh public draft of a prototype to connect the Linux
fuse driver to fs-iomap for regular file IO operations to and from files
whose contents persist to locally attached storage devices.  With this
release, I show that it's possible to build a fuse server for a real
filesystem (ext4) that runs entirely in userspace yet maintains most of
its performance.  Furthermore, I also show that the userspace program
runs with minimal privilege, which means that we no longer need to have
filesystem metadata parsing be a privileged (== risky) operation.

Why would you want to do that?  Most filesystem drivers are seriously
vulnerable to metadata parsing attacks, as syzbot has shown repeatedly
over almost a decade of its existence.  Faulty code can lead to total
kernel compromise, and I think there's a very strong incentive to move
all that parsing out to userspace where we can containerize the fuse
server process.

Demi Marie Obenour pointed out that libguestfs exists.  That project
creates a minimum rootfs, spins up a libvirt VM with a disk image
attached, and has a fuse server that can talk to the VM to provide file
access.  This provides the safety and isolation that I discussed above,
though the performance is not great, the memory and disk space
consumption are rather amazing (500MB and 350MB, respectively!), and
startup times are very slow.  This project avoids those overheads,
though I concede that libguestfs already exists and probably works in
more places than, say, lklfuse.

willy's folios conversion project (and to a certain degree RH's new
mount API) have also demonstrated that treewide changes to the core
mm/pagecache/fs code are very very difficult to pull off and take years
because you have to understand every filesystem's bespoke use of that
core code.  Eeeugh.

The fuse command plumbing is very simple -- the ->iomap_begin,
->iomap_end, and iomap ->ioend calls within iomap are turned into
upcalls to the fuse server via a trio of new fuse commands.  Pagecache
writeback is now a directio write.  The fuse server can upsert mappings
into the kernel for cached access (== zero upcalls for rereads and pure
overwrites!) and the iomap cache revalidation code works.

At this stage I still get about 95% of the kernel ext4 driver's
streaming directio performance on streaming IO, and 110% of its
streaming buffered IO performance.  Random buffered IO is about 85% as
fast as the kernel.  Random direct IO is about 80% as fast as the
kernel; see the cover letter for the fuse2fs iomap changes for more
details.  Unwritten extent conversions on random direct writes are
especially painful for fuse+iomap (~90% more overhead) due to upcall
overhead.  And that's with (now dynamic) debugging turned on!

These items have been addressed since the sixth RFC:

1. Setting current->flags didn't work for fuse servers running inside
   a systemd service, so that's now fixed.

2. Joanne and I worked together to build a prototype of allowing the
   fuse server to override the iomap ops via the BPF struct_ops device.
   This might take care of the interleaved mapping code in John Groves'
   famfs patchset.  This worked great back when my dev branch was
   based off of 6.19.

   Unfortunately it's broken in 7.0-rc1 because ... something changed
   in how BTF gets generated and now I get weird compiler warnings and
   the kernel build fails.  I don't currently know what in gcc 14.2 is
   allergic let alone how to fix this. :(

   The BPF parts of this submission are RFC because at this point I
   still have a lot of unresolved questions, such as:

   a> If you're building a file server for a distro package, there seems
      to be very little consistency as to where vmlinux.h might be
      found.

   b> Can we just compile the bpf at runtime?  That would introduce a
      lot of runtime dependencies (bpftool, clang, etc.) and precludes
      the possibility of vendor-signed bpf binaries.

   c> Are the memory protections implemented by the RFC series adequate
      to prevent data theft and/or kernel memory corruption?  struct ops
      seem to have a lot of capabilities.

   d> Does anyone else in filesystem-land think this is a good idea?

3. The mapping cache isn't invalidated at file close anymore.

4. Cleaned up the header files so that we're not just dumping tons of
   symbols in fuse_i.h.

5. Various review complaints from Chris Mason's AI reviewer.

There are some warts remaining:

a. I would like to continue the discussion about how the design review
   of this code should be structured, and how might I go about creating
   new userspace filesystem servers -- lightweight new ones based off
   the existing userspace tools?  Or by merging lklfuse?

b. ext4 doesn't support out of place writes so I don't know if that
   actually works correctly.

c. fuse2fs doesn't support the ext4 journal.  Urk.

d. There's a VERY large quantity of fuse2fs improvements that need to be
   applied before we get to the fuse-iomap parts.  I'm not sending these
   (or the fstests changes) to keep the size of the patchbomb at
   "unreasonably large". :P  As a result, the fstests and e2fsprogs
   postings are very targeted.

e. I've dropped the fstests part of the patchbomb because v6 was just
   way too long.

I would like to get the main parts of this submission reviewed for 7.1
now that this has been collecting comments and tweaks in non-rfc status
for 3.5 months.

Kernel:
https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-bpf

libfuse:
https://git.kernel.org/pub/scm/linux/kernel/git/djwong/libfuse.git/log/?h=fuse-iomap-bpf

e2fsprogs:
https://git.kernel.org/pub/scm/linux/kernel/git/djwong/e2fsprogs.git/log/?h=fuse-iomap-bpf

fstests:
https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfstests-dev.git/log/?h=fuse2fs

--Darrick

