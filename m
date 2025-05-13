Return-Path: <linux-fsdevel+bounces-48887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2509FAB5456
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 14:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2F8419E5D9F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 12:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F50025525C;
	Tue, 13 May 2025 12:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="XLWVk9+8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F4A28DB43
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 12:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747138144; cv=none; b=qxV9MEfniBJd5lgNr5DYQV0i797qKteNPnTMbh0jDjQharVwKSK5SIsv8ckbsJwwAvwCgI63t2kyZAkCv6hr0tymeqEVNCYCf6qEA7043ID28Pa8argNCKViL3CttFPybS4Luvnym7azSQYlR7Yxd+oBhwZ7CbSPD+07QHQ22OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747138144; c=relaxed/simple;
	bh=ss4u6YcE4mAdLAihaE/rDdvPNRPkNrolbgZVQwVbMBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FdUfWzv1Xba+b2Dq6kO6AlegJPo3fgVisFWuxovsbexlsTYK93/ZeQI9aWgiSmqqoqwft7ATXtlvT1sf9ILMkjXPrIa5tIidU6qIozYRaMJdczqn3Sn0yhU6bAYG1MqquvTs8I81F2USZAIOr2+7WOX3BECCeNSJ6rqPy+U9Df4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=XLWVk9+8; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kV16oFuATrxM2aMHoOFhCpkKZxYAA9+xHlDn5lJ58OQ=; b=XLWVk9+8zuuJ7ECejUaREM3NN9
	fAs0JsAD32y4nnURWIv88d79NnzPImjZLNElDof4Luq76K8Q01wwNtXnFgES6Bhpi7w8TJX/U32Vm
	nyQH7VFnN484PPFqbx+oGZuIscUZCiwf+EqzY9Yao0VdQYAU0Lv4VxdWqn4Am2xk7yZErh6Vby/h2
	JuZDUGoc0hHhSdIS0+Wfv8eOoOy19YifQ8MgFfbfR7h0erTy6sbSKq+dPssE7uQJAU5AJMEwIX5gx
	B7toG+MMhatRmhDQ4vmDcne4xkfPoQpasfRKVjsDiqpfn7iHlhmK7Y1RtdDo+xCsTl2+d6nhPKBrv
	nsq9sMMg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEoRO-00000002eFl-18YP;
	Tue, 13 May 2025 12:08:58 +0000
Date: Tue, 13 May 2025 13:08:58 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Lai, Yi" <yi1.lai@linux.intel.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>, yi1.lai@intel.com
Subject: Re: [PATCH 3/4] do_move_mount(): don't leak MNTNS_PROPAGATING on
 failures
Message-ID: <20250513120858.GG2023217@ZenIV>
References: <20250428063056.GL2023217@ZenIV>
 <20250428070353.GM2023217@ZenIV>
 <20250428-wortkarg-krabben-8692c5782475@brauner>
 <20250428185318.GN2023217@ZenIV>
 <20250508055610.GB2023217@ZenIV>
 <20250508195916.GC2023217@ZenIV>
 <20250508200211.GF2023217@ZenIV>
 <aCMm8r48BuZ8+DTo@ly-workstation>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCMm8r48BuZ8+DTo@ly-workstation>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, May 13, 2025 at 07:03:14PM +0800, Lai, Yi wrote:
> Hi Al Viro,
> 
> Greetings!
> 
> I used Syzkaller and found that there is general protection fault in do_move_mount in linux v6.15-rc6.
> 
> After bisection and the first bad commit is:
> "
> 267fc3a06a37 do_move_mount(): don't leak MNTNS_PROPAGATING on failures
> "
> 
> All detailed into can be found at:
> https://github.com/laifryiee/syzkaller_logs/tree/main/250513_095133_do_move_mount
> Syzkaller repro code:
> https://github.com/laifryiee/syzkaller_logs/tree/main/250513_095133_do_move_mount/repro.c
> Syzkaller repro syscall steps:
> https://github.com/laifryiee/syzkaller_logs/tree/main/250513_095133_do_move_mount/repro.prog
> Syzkaller report:
> https://github.com/laifryiee/syzkaller_logs/tree/main/250513_095133_do_move_mount/repro.report
> Kconfig(make olddefconfig):
> https://github.com/laifryiee/syzkaller_logs/tree/main/250513_095133_do_move_mount/kconfig_origin
> Bisect info:
> https://github.com/laifryiee/syzkaller_logs/tree/main/250513_095133_do_move_mount/bisect_info.log
> bzImage:
> https://github.com/laifryiee/syzkaller_logs/raw/refs/heads/main/250513_095133_do_move_mount/bzImage_82f2b0b97b36ee3fcddf0f0780a9a0825d52fec3
> Issue dmesg:
> https://github.com/laifryiee/syzkaller_logs/blob/main/250513_095133_do_move_mount/bzImage_82f2b0b97b36ee3fcddf0f0780a9a0825d52fec3

Are you sure that stack traces are from the same reproducer?  Because they
look nothing like what it's doing...

I'm pretty sure I see the problem there, but I don't see how it could
fail to oops right in do_move_mount() itself if triggered...

As a quick check, could you see if the same kernel + diff below still
gives the same report?

diff --git a/fs/namespace.c b/fs/namespace.c
index 1b466c54a357..a5983726e51d 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3722,7 +3722,7 @@ static int do_move_mount(struct path *old_path,
 	if (attached)
 		put_mountpoint(old_mp);
 out:
-	if (is_anon_ns(ns))
+	if (!IS_ERR_OR_NULL(ns) && is_anon_ns(ns))
 		ns->mntns_flags &= ~MNTNS_PROPAGATING;
 	unlock_mount(mp);
 	if (!err) {

