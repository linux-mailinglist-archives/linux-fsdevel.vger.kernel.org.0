Return-Path: <linux-fsdevel+bounces-71448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D060CCC1100
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 07:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 62296301C3F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 06:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417BA3358BD;
	Tue, 16 Dec 2025 06:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ppfnkKY7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3D0335083;
	Tue, 16 Dec 2025 06:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765864976; cv=none; b=LyxCo8D2mtvZ1QHvDDzAHNWOIB4Tm+wLQyHFNsVIlioxieeL8t6LuKeQbIIdNF5bEmhU0Eq74LXqonZo42FMakZ3b37b/IcQhaGGDI7cCzMTsYYYUYUG+8phcC6WxnImZFCeomGyWFAJgYNUmcWoq5c76EJ6FT8tJaZSLlgvc0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765864976; c=relaxed/simple;
	bh=+EiJi2dgZ41KXZ+jHq9KcfPuXtbTCClkdkEGP4BqqU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jnBcMIJ9ytufMDIf7eER1uA3Gt+Z8RFzlWRpZg+DKWILAQnhGMqk+dX//J3PaIm2nKDXPXaOakRazc1hkgTK1+n4fevtpf1mYJRx1BGb5Ocm0N1iOp4l9XKrWt9kx1sMCu9VjTuSmsqiCmxrsMp1iipK6G5RyqEjoVpnyq9ijJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ppfnkKY7; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bGOzFJ500PVcaV+dapTFWlqwnBWmCrsv5S7CUpeyCVo=; b=ppfnkKY7+lW/TrUdYUcUZz/VBf
	mVHSjplGyr5b7kvrsfYcAa6FHRAoKduG90Sq0d+lfpJ8OQc8fJNWW727UgUrQufhcw6qqWCXzrDoI
	y+dL73y+NuEsCXyUIILRYOjZUHomjVK4BADfM5aHQF9h46Cv2eejD8vuOSB4GSzQfJRF8DQxz0BjQ
	ITHRnZo85JRS/es/qs8IhOhw/PlC0Ju8UpE2d0KC67aVVDHxWPkVFyHZKcXS9Rg6tLhyUA4zTiiJu
	XJJHAQl6CGxNmbRa+mIRb2HdWF+weGJtIZKr4YobrFWIGdvHRKU7Upc3x0/BoJCTUBt0tWptYSb3y
	4CnUxzWQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vVO9B-000000010Pq-0AiR;
	Tue, 16 Dec 2025 06:02:57 +0000
Date: Tue, 16 Dec 2025 06:02:57 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Chuck Lever <chuck.lever@oracle.com>,
	Hugh Dickins <hughd@google.com>
Subject: [git pull] shmem rename fixes
Message-ID: <20251216060257.GP1712166@ZenIV>
References: <47e9d03c-7a50-2c7d-247d-36f95a5329ed@google.com>
 <20251212050225.GD1712166@ZenIV>
 <20251212053452.GE1712166@ZenIV>
 <8ab63110-38b2-2188-91c5-909addfc9b23@google.com>
 <20251212063026.GF1712166@ZenIV>
 <2a102c6d-82d9-2751-cd31-c836b5c739b7@google.com>
 <bed18e79-ab2b-2a8f-0c32-77e6d27e2a05@google.com>
 <20251213072241.GH1712166@ZenIV>
 <20251214032734.GL1712166@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251214032734.GL1712166@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

The following changes since commit 0048fbb4011ec55c32d3148b2cda56433f273375:

  Merge tag 'locking-futex-2025-12-10' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2025-12-10 17:21:30 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

for you to fetch changes up to e1b4c6a58304fd490124cc2b454d80edc786665c:

  shmem: fix recovery on rename failures (2025-12-16 00:57:29 -0500)

----------------------------------------------------------------
a couple of shmem rename fixes - recent regression from tree-in-dcache
series and older breakage from stable directory offsets stuff.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (2):
      shmem_whiteout(): fix regression from tree-in-dcache series
      shmem: fix recovery on rename failures

 fs/libfs.c         | 50 +++++++++++++++++++++-----------------------------
 include/linux/fs.h |  2 +-
 mm/shmem.c         | 32 ++++++++++++++------------------
 3 files changed, 36 insertions(+), 48 deletions(-)

