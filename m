Return-Path: <linux-fsdevel+bounces-57962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD8EB272F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 01:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 812BE728880
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 23:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2226B2857F0;
	Thu, 14 Aug 2025 23:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="wvP+SuBm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168981A08AF
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Aug 2025 23:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755213681; cv=none; b=gZfM60youRF3oAi/LEcybdc0xLl6DvEV7jiMxnPNi1x/QRf5nrDHqJ76W8H8nWHVIV7qUOfHH4mBID7UXjTlw5w2YPLFtt8xwjHlp8D82rh9dFM18FRPJmIeuNV3C1DV6x2EwF5khFwi2KEy9VISswK1UIYUv3AElbMhwldmPbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755213681; c=relaxed/simple;
	bh=RYxogqJN5mT0aIAZ929Kps/iDTg5LW+NqMg1kIb1BGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNje5etTuWvSnC6uE4QNc8K/up7tbgHLLyoabkhF8Hy+TbIn2nogusUO5D1Yd20136FIhTCdi+ZgdJ9hdnHZ09lJ/D7tcPVi28/TtA0UG/de/l7h471EP1uUrhMaUfUAG1Xg/mK1bPmNszNzeJTzHAHeWTmCWUwNznX6FOH8nHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=wvP+SuBm; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DIQuABK+adePOE+22lOudI3E+hHbfIN+K8yFv0DjiOg=; b=wvP+SuBm1C6nuQ0h0rcuyC8Vby
	ayg1pTsjINzfqVZ9gnVLM2zXC/eQGBUPIqS3IwecXsnEj9/EFHS5vsNu0OHQNsAHM+PjlEqU5jthP
	Tk1QJ18S1aXBDXhpba+yTwsKorQU8UGc0hBuY+ZZWxhENB8zzEqv4NaElnkIxu/Qls/Folqc2S93Z
	63K8I38R2Q5sqYxlQrAb7pby2rWRbRgKVIm0mXmlsLaNoyObbz/RswLMuTR4QjSHvuDuEnKcHPtpL
	TAqswPv3JOpMf0LQdhXMAiZ7qClqlrvbyxBX/XUU2iFkDiQwiSFjX1mZAhT8j94R/7hAOZdUfVlhF
	E8IyqGcg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umhFy-0000000ABhM-3cF6;
	Thu, 14 Aug 2025 23:21:14 +0000
Date: Fri, 15 Aug 2025 00:21:14 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Lai, Yi" <yi1.lai@linux.intel.com>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, yi1.lai@intel.com,
	ebiederm@xmission.com, jack@suse.cz, torvalds@linux-foundation.org
Subject: Re: [PATCH v3 44/48] copy_tree(): don't link the mounts via mnt_list
Message-ID: <20250814232114.GQ222315@ZenIV>
References: <20250630025148.GA1383774@ZenIV>
 <20250630025255.1387419-1-viro@zeniv.linux.org.uk>
 <20250630025255.1387419-44-viro@zeniv.linux.org.uk>
 <aJw0hU0u9smq8aHq@ly-workstation>
 <20250813071303.GH222315@ZenIV>
 <20250813073224.GI222315@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813073224.GI222315@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Aug 13, 2025 at 08:32:24AM +0100, Al Viro wrote:
> On Wed, Aug 13, 2025 at 08:13:03AM +0100, Al Viro wrote:
> > On Wed, Aug 13, 2025 at 02:45:25PM +0800, Lai, Yi wrote:
> > > Syzkaller repro code:
> > > https://github.com/laifryiee/syzkaller_logs/tree/main/250813_093835_attach_recursive_mnt/repro.c
> > 
> > 404: The main branch of syzkaller_logs does not contain the path 250813_093835_attach_recursive_mnt/repro.c.
> 
> https://github.com/laifryiee/syzkaller_logs/blob/main/250813_093835_attach_recursive_mnt/repro.c
> 
> does get it...  Anyway, I'm about to fall down right now (half past 3am here),
> will take a look once I get some sleep...

OK, I think I understand what's going on there.  FWIW, reproducer can be
greatly simplified:

cd /tmp
mkdir a
mount --bind a a
mount --make-shared a
while mount --bind a a do echo splat; done

Beginning of that thing is to make it possible to clean the resulting mess
out, when after about 16 iterations you run out of limit on the number of
mounts - you are explicitly asking to double the number under /tmp/a
on each iteration.  And default /proc/sys/fs/mount-max is set to 100000...

As for cleaning up, umount2("/tmp/a", MNT_DETACH); will do it...

The minimal fix should be to do commit_tree() just *before* the preceding
if (q) {...} in attach_recursive_mnt().

Said that, this is not the only problem exposed by that reproducer - with
that kind of long chain of overmounts, all peers to each other, we hit
two more stupidities on the umount side - reparent() shouldn't fucking
bother if the overmount is also going to be taken out and change_mnt_type()
only needs to look for propagation source if the victim has slaves (those
will need to be moved to new master) *or* if the victim is getting turned
into a slave.

See if the following recovers the performance:

diff --git a/fs/namespace.c b/fs/namespace.c
index a191c6519e36..88db58061919 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1197,10 +1197,7 @@ static void commit_tree(struct mount *mnt)
 
 	if (!mnt_ns_attached(mnt)) {
 		for (struct mount *m = mnt; m; m = next_mnt(m, mnt))
-			if (unlikely(mnt_ns_attached(m)))
-				m = skip_mnt_tree(m);
-			else
-				mnt_add_to_ns(n, m);
+			mnt_add_to_ns(n, m);
 		n->nr_mounts += n->pending_mounts;
 		n->pending_mounts = 0;
 	}
@@ -2704,6 +2701,7 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 			lock_mnt_tree(child);
 		q = __lookup_mnt(&child->mnt_parent->mnt,
 				 child->mnt_mountpoint);
+		commit_tree(child);
 		if (q) {
 			struct mountpoint *mp = root.mp;
 			struct mount *r = child;
@@ -2713,7 +2711,6 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 				mp = shorter;
 			mnt_change_mountpoint(r, mp, q);
 		}
-		commit_tree(child);
 	}
 	unpin_mountpoint(&root);
 	unlock_mount_hash();
diff --git a/fs/pnode.c b/fs/pnode.c
index 81f7599bdac4..040a8559b8f5 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -111,7 +111,8 @@ void change_mnt_propagation(struct mount *mnt, int type)
 		return;
 	}
 	if (IS_MNT_SHARED(mnt)) {
-		m = propagation_source(mnt);
+		if (type == MS_SLAVE || !hlist_empty(&mnt->mnt_slave_list))
+			m = propagation_source(mnt);
 		if (list_empty(&mnt->mnt_share)) {
 			mnt_release_group_id(mnt);
 		} else {
@@ -595,6 +596,8 @@ static void reparent(struct mount *m)
 	struct mount *p = m;
 	struct mountpoint *mp;
 
+	if (will_be_unmounted(m))
+		return;
 	do {
 		mp = p->mnt_mp;
 		p = p->mnt_parent;

