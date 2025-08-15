Return-Path: <linux-fsdevel+bounces-58056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BB1B288CE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Aug 2025 01:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D5755E2FDE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 23:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE81A283C83;
	Fri, 15 Aug 2025 23:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="wJ5nhkB+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9FE23C503
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Aug 2025 23:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755300804; cv=none; b=P0JJ9uf18GLBJ7NUC1EtAylTM4JTwnZiiLRqx7l0LQiaH+ruKhQVKxtwDhu07mgnBCnXH6epyxTeJs+JSA8GvDOeVo5+6n1CwQIY/7OfxJ+Q71rAqOybosoJLEpkAS9DSyLBNHfWzPBSGd+t54GfOfe92yvk4wkuqQPhbzD9jJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755300804; c=relaxed/simple;
	bh=e/pbUvfTFUIJE0bSkW1WyaSAYaa/dgude3ZRnqRLiZI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MpYyn8SPm+6HzxJbwu9YyNndgpdBF1SWcFJhMi5WM7SH3bVHu+v6K3em+HU4NadHEoeCyIwoAPpx05w13EgYFGQOwDMao2AmlflE5X2yWvhrpfV1fXfxrHxnkQ7yeQ6kiWBB0NHN/JdsO2K13pZe9Iq1UhmrVlTUC+1TC+0Hb0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=wJ5nhkB+; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=UHVnpwBjq5muW/X2uC3+Zohsa8nz/GoKvgdlZhtrSgM=; b=wJ5nhkB+rQCX5BTGeywIHiTcTd
	8Yn96NNe4TmzjkC5UAwY9vHUVXST5QHC8wVk4T0JMH6aSXiLo4xgfW26ujEz2a5yUL/F6Sucx9VRq
	6WZx0SUpDIPAcA6RR3Wj34GIiOb60//VXEx09YYgEitAjZluZgf2UPLWpKdb+tdl63PGttZCtS2Qm
	ApN7c0hFBeeswG/pzJkUkFtkJNoHaZS+qqSjfXlx+25Gyb6tzKNOC/LVEi7coeJD1CWdP15pMT1Vj
	uzDkDog9OyP+lb7LRw8WpXn7qDoct3PWeWlX5JEt+12LgmXV2LEdNTSyWhIl8DQ5VytR0/mpXoxaC
	hr/umiKQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1un3vA-00000008srz-1XtH;
	Fri, 15 Aug 2025 23:33:16 +0000
Date: Sat, 16 Aug 2025 00:33:16 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"Lai, Yi" <yi1.lai@linux.intel.com>,
	Tycho Andersen <tycho@tycho.pizza>,
	Andrei Vagin <avagin@google.com>,
	Pavel Tikhomirov <snorcht@gmail.com>
Subject: [PATCHES][RFC][CFT] mount fixes
Message-ID: <20250815233316.GS222315@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	Several regression fixes of varying severity; live in
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git, individual
patches in followups.  Help with testing and reviewing would be very
welcome.

1) attach_recursive_mnt() slowdown - severe in some pathological cases.
This cycle regression, fortunately trivial to fix.  Underlying mechanism
of slowdown (bypassed by that fix) is due to bad semantics of skip_mnt_tree(),
but that's a separate story.
The case with severe slowdown is mounting on top of a long chain of overmounts,
all peers with each other.  Ends up being time-quardatic by the depth of chain,
easily triggers softlockup warnings.  Since the slow part is under mount_lock,
all pathname resolution pretty much stops for the duration.  Kudos for catching
that to "Lai, Yi" <yi1.lai@linux.intel.com>...

2) reparenting in propagate_umount() should *NOT* be done to mounts that are
themselves going to be taken out.  I'd even put "<argument> is not to going
away, and it overmounts the top of a stack of mounts that are going away"
right on top of reparent()...  and lost the logics in its caller that used
to check that at some point during reshuffling the queue ;-/  This cycle's
regression and that one is not just a slowdown - in some cases it might end
up as data corruptor.  Trivial to fix...

3) permission checks for --make-{shared,slave,private,unlinkable} (i.e.
MS_{SHARED,...} in mount(2) flags) ended up being too restrictive.
The checks used to be too weak until the last cycle.  Then they were
made stricter - basically to "mount is a part of our namespace and we have
admin permissions there".  Turns out that CRIU userland depended upon the
weak^Wabsent checks we used to have there before.  Sane replacement that
would suffice for them is "mount is a part of *SOME* namespace that we have
admin permissions for".  Last cycle userland regression...

4) change_mnt_propagation() slowdown in some cases.  On umount we want all
victims out of propagation graph and propagation between the surviving mounts
to be unchanged.  So if victim used to have slaves, they need to be transfered
to its peer (if any) or master.  In case when victim had many peers, all
taken out by that umount(), that ended up with all its slaves being gradually
transferred between all peers until we finally ran out of those.  It can
easily lead to quadratic time.  The patch in -rc1 switched that to "just
find where they'll end up upfront, and move them once", which eliminated
that... except that I hadn't noticed that on massage of change_mnt_propagation()
we ended up calculating the place where they'd be transferred in cases
when there had been nothing to transfer.  With obvious effects when there
had been a large peer group entirely taken out, with not a single slave between
them.  The minimal fix ("call propagation_source() only if we are going to
use its return value") is enough to recover in all cases.
Longer term we should kick all victims out of propagation graph at once
and I have that plotted out, but that's for the next merge window; for
now the minimal obvious fix is good enough.

