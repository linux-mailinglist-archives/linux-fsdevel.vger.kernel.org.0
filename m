Return-Path: <linux-fsdevel+bounces-48668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A565AB216C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 May 2025 08:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5FEA502047
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 May 2025 06:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FE71DDC0B;
	Sat, 10 May 2025 06:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="XhSO5obu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F401A38F9
	for <linux-fsdevel@vger.kernel.org>; Sat, 10 May 2025 06:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746856973; cv=none; b=GM+NthotpL0/aHGZJ69HyohZpIqBv+zX8SLT9lO1fdTVph82WVu69pRaQ+hwtEk3t7O1SaVph9VhhvyjY02zqWXPE9xIZQ1Zbdec4OTaPZ/UZwEwqk+g2AMaGxdxjezb2MMgSCMeTapV1dO4Vw4fOayLp2f+QNx3XqqvkIc2F1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746856973; c=relaxed/simple;
	bh=spCOcnS4VuS78g8De1fZocBOij5mh1v/QUqXB8ALiek=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OtmtQE5h0pQeJCFrztg4oNeyMxxcSOfTiJCWqDr3lDVykzvH7Cx/q63vrRHDARJyF2sMSa84b5K8/k9cz44rVInMN8OFV5bBM6qIg+oDGYdaA8PcFGMaHCZjbgjNRR1YTNBlQEuJ+3cAgN4x964PoetoWkVe7gVxoLtpgyid6T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=XhSO5obu; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=/ajDayNosf1vAimYD0Vb1rM8NxK6+S02dzVkm2L2w80=; b=XhSO5obum3J4YUEgnCiM7cMYwH
	76wyVumiwwfUfC3Gm6dxBt/H/+R1ionMd25QI8Z4z+2Ge3XW07LrBzh0EEgWlqEvaK66DmM/YC/uG
	YDly/ESTY0guWVkk3zN+sYl8dseob4EMsvKxrI5IIK10NAw7MFYAFfPuWZSs0pWZiPHc9+I6ULcNN
	Q1N0OtQukcMYSivpOwfeqVG1dGhq7eeIbMWKcdkgkX9Y5/tVkPUEmSB1lOEqte7IVKacX6oRrZfcD
	PgXcP1v25Ss8MYM453lu+f3eCzpje1dr76WvucLhCLK93PC+y3WGygfRxfzA2iuNngGMoLPbHAqci
	IdAwk82g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDdIO-0000000GaR3-3QVy;
	Sat, 10 May 2025 06:02:48 +0000
Date: Sat, 10 May 2025 07:02:48 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [git pull] several mount fixes
Message-ID: <20250510060248.GX2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

More stuff caught in mount code audit.  There's more, but those'll have to
wait for several days...

A couple of races around legalize_mnt vs. umount (both fairly old and hard to
hit) plus two bugs in move_mount(2) - both around "move detached subtree in
place" logics.

The following changes since commit 92a09c47464d040866cf2b4cd052bc60555185fb:

  Linux 6.15-rc5 (2025-05-04 13:55:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

for you to fetch changes up to d1ddc6f1d9f0cf887834eb54a5a68bbfeec1bb77:

  fix IS_MNT_PROPAGATING uses (2025-05-09 18:06:27 -0400)

----------------------------------------------------------------
assorted namespace fixes

----------------------------------------------------------------
Al Viro (4):
      __legitimize_mnt(): check for MNT_SYNC_UMOUNT should be under mount_lock
      do_umount(): add missing barrier before refcount checks in sync case
      do_move_mount(): don't leak MNTNS_PROPAGATING on failures
      fix IS_MNT_PROPAGATING uses

 fs/namespace.c | 17 +++++++----------
 fs/pnode.c     | 17 +++++++++--------
 fs/pnode.h     |  2 +-
 3 files changed, 17 insertions(+), 19 deletions(-)

