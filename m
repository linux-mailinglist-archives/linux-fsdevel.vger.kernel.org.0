Return-Path: <linux-fsdevel+bounces-52977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16351AE90E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 00:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC2391898AA0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 22:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490C228A727;
	Wed, 25 Jun 2025 22:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="TlQxlEwn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1DC289E04
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 22:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750889729; cv=none; b=n3LazAwCp3aveBcXvwDmgfFKkDtqYcdOHl6npjAwnL/6D+1R5jg/a4f/77UB0ZDRc8VJdzqv13cqTr36EP9KHyHvv6KSp5JVhlm0hOqKO/AB8/m/RON7LJbZYPmIK4KFiwEreHvggMBGqyo1MyHPxsTsTSQK7fBkMG1oza5KquU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750889729; c=relaxed/simple;
	bh=v15e1fsq/k9wQogGeLwjM8pmdEUQe6ZiBZIG2tnr5JY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AHg3/8dy90MzlCAc+h7W59NpJsIQhy31oxBDsYqQxpUsQE2CdMQFldYCZoOfrKda+p+kCTInCfI4C6s2ZkZCg30EEBuZnyrGf3sudvMnDQVL8XRiez+ga3f03srhiPWTs8j4BulHnZPQszf/NFikbTb5xFktJJ5u7mddQFi067s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=TlQxlEwn; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=kQdQW1VonLksORmc2reTI2hT7Dsgy6YNZ601dpB97cY=; b=TlQxlEwnNKSlXQTvtno40Pnstw
	j8exmbCvvpqH8drKVqTJMFHErD1+E72gCJ+HCWOAAbMwslaiZXNrVZqjQBcxmPLzkmElb7TlGq7WN
	YoALCYXXlIyhMyZbcvP/QHpO83GlumXg9fywHl9YIG3TzJGI0gPvfUDk+4riXP971nwrCzr1lhuLm
	IezfI3eQ08fBgHcSbw0rDgTDyZbG5359aAdh2/GYKmMqsJtUiTUTVLltcU4riKiIUHz0cMLJuXYw3
	zHoqK622gfnAuE0uRoCBpB3CfOdD42p+/p5wTURDXjgHmhHV9sS13sltUf4XdK64PX+NHNNv3Ma6e
	AS+kvu1w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUYOq-00000006eI8-1az2;
	Wed, 25 Jun 2025 22:15:24 +0000
Date: Wed, 25 Jun 2025 23:15:24 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: [git pull] more mount fixes
Message-ID: <20250625221524.GT1880847@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

More fallout from struct mount audit...

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

for you to fetch changes up to 0748e553df0225754c316a92af3a77fdc057b358:

  userns and mnt_idmap leak in open_tree_attr(2) (2025-06-24 10:25:04 -0400)

----------------------------------------------------------------
Several mount-related fixes

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (3):
      replace collect_mounts()/drop_collected_mounts() with a safer variant
      attach_recursive_mnt(): do not lock the covering tree when sliding something under it
      userns and mnt_idmap leak in open_tree_attr(2)

 Documentation/filesystems/porting.rst |   9 +++
 fs/namespace.c                        | 115 +++++++++++++++++++---------------
 fs/pnode.h                            |   2 -
 include/linux/mount.h                 |   6 +-
 kernel/audit_tree.c                   |  63 ++++++++++---------
 5 files changed, 111 insertions(+), 84 deletions(-)

