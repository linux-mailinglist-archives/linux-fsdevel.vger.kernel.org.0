Return-Path: <linux-fsdevel+bounces-65992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E673CC17978
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 213EF1C67694
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE682D1F44;
	Wed, 29 Oct 2025 00:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTF8tLfM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083AA23D7C4;
	Wed, 29 Oct 2025 00:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761698542; cv=none; b=F7Y7vGybxhLXicawsq5ZbA3H/Nmiq6ylJ9V2HTj7EB2uGEbhY8Qos9S0dGDNnuzFrE7gXau/UykpM8n4yWAqi/KvnRo36wGht8Q66r0u2GCvElvpYhSTau1T/R05sN5OUD8zFpQPw9iNTrcqlMWTSd9kXfSoR4s7PXJbG0rr6c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761698542; c=relaxed/simple;
	bh=+PSn3ll6trzznOycGK52DASCfLhjBIC+wl7DPdbtZ6U=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SxWzSotxcoLD503y5eZ+JSainginQ2CFlV/GszK/mtZ8X3qo1iAf3eIBe54+PnDtd8c+Fk6dsXBuSj7X6PC5cOulxvccFM8lZkYr+w9EAryQxLMKlJ8bB1uJIxetOnmgQ4bW5/IZiVTSR4yfg/97ajvffuus6BcVyVNRULabkFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTF8tLfM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A0AC4CEE7;
	Wed, 29 Oct 2025 00:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761698541;
	bh=+PSn3ll6trzznOycGK52DASCfLhjBIC+wl7DPdbtZ6U=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=WTF8tLfMia3quZes7NSD12XA/uPXc43ld/BlHh8zxiZL5BMoy8fnJWnK6O/XYLrHz
	 bRekh3ZSM8C/e10+843oQwrDzKhX9TlvLb5STs7G3k3dUGJPCfvLJlON8HCkDAuxuO
	 dAO4ET0vr8+VMrdG+V4zqnKOPfZ1Bd2xNQVj5j7uAehIa/Md1PBBiouAYhV3Qv4XgL
	 5UIx7G0p2OAgqkL0BlEuivE3upuOgnQWUeeuI++lKRG+07e2tr/7k9zDryZePZB4Nw
	 o1NCHTQKeuZRVOtpIaxfXSozHiSXdglWO4hLHJuvo8Z5C/qwyOpSO6LGlJRPWZPVwQ
	 BanH70Xqu03QQ==
Date: Tue, 28 Oct 2025 17:42:21 -0700
Subject: [PATCHSET v6 5/6] fuse2fs: improve block and inode caching
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com,
 neal@gompa.dev, miklos@szeredi.hu, linux-ext4@vger.kernel.org
Message-ID: <176169818736.1431012.5858175697736904225.stgit@frogsfrogsfrogs>
In-Reply-To: <20251029002755.GK6174@frogsfrogsfrogs>
References: <20251029002755.GK6174@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

This series ports the libext2fs inode cache to the new cache.c hashtable
code that was added for fuse4fs unlinked file support and improves on
the UNIX I/O manager's block cache by adding a new I/O manager that does
its own caching.  Now we no longer have statically sized buffer caching
for the two fuse servers.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

Comments and questions are, as always, welcome.

e2fsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/e2fsprogs.git/log/?h=fuse2fs-caching
---
Commits in this patchset:
 * libsupport: add caching IO manager
 * iocache: add the actual buffer cache
 * iocache: bump buffer mru priority every 50 accesses
 * fuse2fs: enable caching IO manager
 * fuse2fs: increase inode cache size
 * libext2fs: improve caching for inodes
---
 lib/ext2fs/ext2fsP.h    |   13 +
 lib/support/cache.h     |    1 
 lib/support/iocache.h   |   17 +
 debugfs/Makefile.in     |    8 
 e2fsck/Makefile.in      |   12 -
 fuse4fs/Makefile.in     |   11 -
 fuse4fs/fuse4fs.c       |    8 
 lib/ext2fs/Makefile.in  |   14 -
 lib/ext2fs/inode.c      |  215 ++++++++++---
 lib/ext2fs/io_manager.c |    3 
 lib/support/Makefile.in |    6 
 lib/support/cache.c     |   16 +
 lib/support/iocache.c   |  765 +++++++++++++++++++++++++++++++++++++++++++++++
 misc/Makefile.in        |   12 -
 misc/fuse2fs.c          |   10 +
 resize/Makefile.in      |   11 -
 tests/fuzz/Makefile.in  |    4 
 tests/progs/Makefile.in |    4 
 18 files changed, 1040 insertions(+), 90 deletions(-)
 create mode 100644 lib/support/iocache.h
 create mode 100644 lib/support/iocache.c


