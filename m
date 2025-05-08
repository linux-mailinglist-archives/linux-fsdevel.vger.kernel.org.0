Return-Path: <linux-fsdevel+bounces-48506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4CDAB0448
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 22:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 223B917A7DA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 20:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDDB29A0;
	Thu,  8 May 2025 20:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="MRklNKlb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3641835976
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 May 2025 20:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746734457; cv=none; b=CbNxxEJ5kDLzNm4DxFpM1c6rVHobPnf7GUqJtM2N4nPMqBQ6wY5R9ZdcQ5RKR6UHudR3PRA8FXyWMxM4S/Z+tLBoMnKaL6PCTCUTcZsCGCTLxQ/5IZua0YufKc2DKpTXH2cqkG5qMIgPqHOfvPL9psCjFrMfAxgoIYMQYz+Ukiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746734457; c=relaxed/simple;
	bh=MpkjFBMKVOucT4i3nZtAUUZVODeJSCVjVxoSdRvhfK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uw2lSLZ2RpSdjlf8P4K0Dr1Uo5eQ2qzkYfzPQWAp6V1DKNNHCYN/knUiFsWm4eCD9yf3z+y1BDHrqQfE4wLs26MKMuw9eHC204EzqIkB/O05Wjv6Rx44VRZJjG55TvylSLpAIvkb1K56flFdMGC0u0iE7TIyO+zkPwpoPLwl0w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=MRklNKlb; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=S26+hQPrfAo2Xu+KYRr2SwB7lXb3YOdJ1Q/ZsW+QvpU=; b=MRklNKlbm7VS8yiYf52W5iHvFN
	FPPGuxD9G2t/212kc9Sd60BkjEQXl0KSgW3xhFwKSX+0iXtPwppTT10tr5G/VIWBdyxLEfA8s9X3I
	9aq7+H+r6y04GAgo9/sEfSfA+uGvcKgl8t8ilISXtBkZ3cGJck+J1iK3IbfwGEV8EjGS6PmRV1fau
	KMVOCLol0Zjn4z5ZQItOe3LbUWW+aI+aFNfBJ3U/B3ZfFn7KtNnLnairIwTmebuY6mv07StazzTHJ
	Y2yoDadRAuZlsHLWimMuiqlXxZmvpI5kZ4YBOUHYE5pTZ2ow3Cu2pa/H2rrhRivVpb2JLUr6YJjbR
	gAKz+imA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD7QL-00000007pxS-2I1Z;
	Thu, 08 May 2025 20:00:53 +0000
Date: Thu, 8 May 2025 21:00:53 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 1/4] __legitimize_mnt(): check for MNT_SYNC_UMOUNT should be
 under mount_lock
Message-ID: <20250508200053.GD2023217@ZenIV>
References: <20250428063056.GL2023217@ZenIV>
 <20250428070353.GM2023217@ZenIV>
 <20250428-wortkarg-krabben-8692c5782475@brauner>
 <20250428185318.GN2023217@ZenIV>
 <20250508055610.GB2023217@ZenIV>
 <20250508195916.GC2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508195916.GC2023217@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

... or we risk stealing final mntput from sync umount - raising mnt_count
after umount(2) has verified that victim is not busy, but before it
has set MNT_SYNC_UMOUNT; in that case __legitimize_mnt() doesn't see
that it's safe to quietly undo mnt_count increment and leaves dropping
the reference to caller, where it'll be a full-blown mntput().

Check under mount_lock is needed; leaving the current one done before
taking that makes no sense - it's nowhere near common enough to bother
with.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 98a5cd756e9a..eba4748388b1 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -790,12 +790,8 @@ int __legitimize_mnt(struct vfsmount *bastard, unsigned seq)
 	smp_mb();			// see mntput_no_expire()
 	if (likely(!read_seqretry(&mount_lock, seq)))
 		return 0;
-	if (bastard->mnt_flags & MNT_SYNC_UMOUNT) {
-		mnt_add_count(mnt, -1);
-		return 1;
-	}
 	lock_mount_hash();
-	if (unlikely(bastard->mnt_flags & MNT_DOOMED)) {
+	if (unlikely(bastard->mnt_flags & (MNT_SYNC_UMOUNT | MNT_DOOMED))) {
 		mnt_add_count(mnt, -1);
 		unlock_mount_hash();
 		return 1;
-- 
2.39.5


