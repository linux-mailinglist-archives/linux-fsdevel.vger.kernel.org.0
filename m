Return-Path: <linux-fsdevel+bounces-14574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5B687DE47
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 17:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33E7E2820D8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 16:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397FC1CABF;
	Sun, 17 Mar 2024 16:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bfnez/E2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E0F1CA96;
	Sun, 17 Mar 2024 16:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710692395; cv=none; b=lzDHBZyyomu0Tp0EO6Q4b4diQKSRDA37VsCNMpFhSI1I7PQcUFAm+Cfgm6yrAkDKNBUZ1htVJvRApvGLCfcT4KZ2mEOShdHUXTu5HNCI4WaQVU8x+DNtKpoYkwddwSQLuba1iYxnj09O6AMWle/8XyZM9Xys6o9z3Jc0Cjlkf8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710692395; c=relaxed/simple;
	bh=E+T1vQ/xEMAMlQLK0Pd1u/Z1aGPLAVcc3i35PCsDEJU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CQyX07kZWA+fxy75OcWwhtRaIIPrVtPZXRzK2U03ndWTNCSXPkuK0JXO8sJHGTb4CrX0Bj86kgKr3/ut4+fCfKj8YXgoA0ZtxTtsKIxojxkK3+32COy9Ulg0CfPTYJq5n23id6AQaujLxSEkc/JP9rUQu5On+dP2QCjbJBKpUu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bfnez/E2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03CACC433F1;
	Sun, 17 Mar 2024 16:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710692395;
	bh=E+T1vQ/xEMAMlQLK0Pd1u/Z1aGPLAVcc3i35PCsDEJU=;
	h=Date:From:To:Cc:Subject:From;
	b=Bfnez/E28T/g2MrO3u5Hx0M9fTxReWpsw4pjxkailammrVGmbKP0hijW1PFTZvD3P
	 YZP6DciRdS0+PjIjndNmD+UNeQUNpZb1jgUmip2jcn0aco4RjBdj4nAXsNVr9MSyAS
	 KNf1R4rIFMItFNqITIxdy3abUlsbJ4FDuXS7Hy3jRoHFUSDVAMF9FBGFAgGw6tk2it
	 UB32Ng9PPvLJeMh+pFmXCZcQPkSYiG56yos262JBPRW0uSYJuVf+WBDtJcbjIPh09F
	 3TIsheqiWNMrE91r7KxGIn5N/71V8vn1Z8YwinRnEf3vh8IOihk3TTezlTaDVvtX+8
	 kUbXUS/UdG/mA==
Date: Sun, 17 Mar 2024 09:19:54 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org
Cc: linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org
Subject: [PATCHBOMB v5.3] fs-verity support for XFS
Message-ID: <20240317161954.GC1927156@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi everyone,

I've mostly finished rounding out xfs_db and both fsck support for
fsverity.  I'm now sending out a full set of patches for everything I've
got, which is quite a bit more since the v5.2 stuff the other day.

This time around I've applied some more optimizations to the
implementation, including getting rid of the incore validation bitmap,
not storing trailing zeroes to reduce overhead, and eliding merkle tree
blocks that contain hashes of zeroed data blocks.  This last one is very
useful for reducing overhead of gold master disk images on vm farms.

Note that metadump is kinda broken and xfs_scrub media scans do not yet
know how to read verity files.  All that is actually fixed in the
version that's lodged in my development trees, but since Andrey's base
is the 6.9 for-next branch plus only a few of the parent pointers
patches, none of that stuff was easy to port to make a short dev branch.

Full versions are here:
https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=fsverity
https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfsprogs-dev.git/log/?h=fsverity

--D

