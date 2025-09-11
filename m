Return-Path: <linux-fsdevel+bounces-60976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D49B53EC5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 00:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C75D7B28E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 22:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F162A2F3638;
	Thu, 11 Sep 2025 22:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="scbJpxos"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9285325EF97;
	Thu, 11 Sep 2025 22:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757630674; cv=none; b=HaB3lofEqsJ8X8Y2CzQpx5OeFcfSH+MPkJeiTuV/8HmlzXt7chPWutEcHwO195rlzXY7dBAYoYfIRJNFagQdBMrxB8dcsi98XPZH94Z8Gk2OSa/a2DpfSIPw1p9vz3+v+jSg27A0fDKkn4JWBOcX9XpPY4He7kZGWHJ9ucKOSC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757630674; c=relaxed/simple;
	bh=CnOt4plMlh0rVnHRBBb8R4K15PcFqIC42ihrE1s3sqM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Gr6EibHFdZKx9T8t1Wi03tdMplW+tjsKuBezd0XDHr/EMzQUsUNMHkdD4mkUMXIYizsLLjpitBFx4qFtJujlrr4Luco9ttv68e+5arePUOXTdveAvPN/aYB57cl5inNQPvfKjc4+ZSlqCK+56Ec4j73e7D3sRz05X5HgM2prDYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=scbJpxos; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=AUjmsLVv4RpkUXwO8No0+qYf9VhZ0LasRqEzDQdvU1A=; b=scbJpxosx1UD+E00iVR0ZWkFIC
	i96TJ1gTMGvZv66GCqoSlIpLRp+gdHdCVFv7Ply3lBT2iib4TOWbLVAJQmtwR8Qnq0WFj5+rQAnIt
	J9EOl3Wk6klGMTrFosymv7AWbMZ5HI6op+xT6tG0x+S4k64JfEkv9qeCQ8pqYuao90gTiWwfAnQWE
	YXm8ayaUNsmgAIzJRWsO0OINN3uT8uHUxbwicIC2/cxWqIm6WyQt7Ew7pf0zCNiGiyokOt76eqF9b
	K7GT9gORIp5BJSYrZ596lScAlA5+eNLcsYuWcAL2BOH7kiRa73CZCNxhZ7b7leSBUQ6HzWWZRV6Ss
	IqfAJDow==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwq1l-00000006ex7-2zHk;
	Thu, 11 Sep 2025 22:44:29 +0000
Date: Thu, 11 Sep 2025 23:44:29 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>
Subject: [PATCHES] nfsctl fix and cleanups
Message-ID: <20250911224429.GX39973@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	More stuff pulled out of tree-in-dcache pile, this time nfsctl.
The first one in the series is a fix for minor bogosity, the rest -
cleanups.  Elimination of more d_alloc_name() call sites on conversions
to simple_start_creating() is what got that into preparation parts of
tree-in-dcache...

Branch in -rc5-based, lives in
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.nfsctl
individual patches in followups.  If nobody objects, into -next it goes...

Shortlog:
      nfsctl: symlink has no business bumping link count of parent directory
      nfsd_mkdir(): switch to simple_start_creating()
      _nfsd_symlink(): switch to simple_start_creating()
      nfsdfs_create_files(): switch to simple_start_creating()
      nfsd_get_inode(): lift setting ->i_{,f}op to callers.

Diffstat:
 fs/nfsd/nfsctl.c | 137 ++++++++++++++++++++-----------------------------------
 1 file changed, 49 insertions(+), 88 deletions(-)

