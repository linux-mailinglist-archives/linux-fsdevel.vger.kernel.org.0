Return-Path: <linux-fsdevel+bounces-61491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 894EEB58923
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5249F2A1328
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879FB1A01C6;
	Tue, 16 Sep 2025 00:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6eLTOid"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E220F625;
	Tue, 16 Sep 2025 00:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982227; cv=none; b=h8yJAifekReleJr9kpUqk2+gBfnHSnWyiQFquf4eGPSSf7GdteTN+q+MVHmYxx3r0YmSu2hoiOMHpbJqiCfS/DE/SVlpStjqOVerrMx7JZMlCtyelT9olA8xqJ8D6cZaAQejBDZg6sOtE5gpifqNLS+/wuvZC9iRxMMC0Fb58Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982227; c=relaxed/simple;
	bh=yY0D6DtPR1TZEQgDX8mSMd6/mM9v/4/K/HjK46/NY/o=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XX7Si3K9NIK9HccX1EW2a5AHCN1cSquVAYNhpc7HX8GdicBRwEJk1gpmbFNI20pXbi8754cW5PTKMIsvzgMRdy7SzPzQSPqF6jyjy0ONRCQwvO+eDaTmNIa4TyJbDqQZB4EXIpptzkK9TEZoFKhBFfi6x7IDNivOkvus70qrqTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6eLTOid; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70302C4CEF5;
	Tue, 16 Sep 2025 00:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757982226;
	bh=yY0D6DtPR1TZEQgDX8mSMd6/mM9v/4/K/HjK46/NY/o=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=i6eLTOidiogroAf8QCQZj5wC+lY0YJkN3P/VcYgAaIRQ2Dt02gsqpD+whhB4nsdnK
	 l7MVL1PbKK4yvuWPYQ4rAEC8dRIV7J7l+yD1kY0uI1Q3JsnL0O0ONJ9ig/4mR1ukNH
	 IhejHpfjnrXkx4pQnNDZJpjEkcTPMIV827SkcYpQ9hCHj4RRknUy1JERlanZshNBLx
	 17VyAU7kugZzGEtP084u4OOP83MfnJkySchKuKCirSojg82e0zLdTouyq5PT5ViUnO
	 dJBvlk2KIpu4Uou++90NUc2ITz8sGfQiAdkN3XihygQwf1VzdyW16P3JdC7Bsv3P9o
	 Ap2RbNQx3Cmbw==
Date: Mon, 15 Sep 2025 17:23:46 -0700
Subject: [PATCHSET RFC v5 8/9] fuse2fs: improve block and inode caching
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, John@groves.net, bernd@bsbernd.com,
 joannelkoong@gmail.com
Message-ID: <175798162827.391868.5088762964182041258.stgit@frogsfrogsfrogs>
In-Reply-To: <20250916000759.GA8080@frogsfrogsfrogs>
References: <20250916000759.GA8080@frogsfrogsfrogs>
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
 debugfs/Makefile.in     |    4 
 e2fsck/Makefile.in      |    4 
 fuse4fs/Makefile.in     |    3 
 fuse4fs/fuse4fs.1.in    |    6 
 fuse4fs/fuse4fs.c       |   75 +----
 lib/ext2fs/Makefile.in  |    4 
 lib/ext2fs/inode.c      |  215 +++++++++++---
 lib/ext2fs/io_manager.c |    3 
 lib/support/Makefile.in |    6 
 lib/support/cache.c     |   16 +
 lib/support/iocache.c   |  740 +++++++++++++++++++++++++++++++++++++++++++++++
 misc/Makefile.in        |    4 
 misc/fuse2fs.1.in       |    6 
 misc/fuse2fs.c          |   77 +----
 resize/Makefile.in      |    4 
 tests/progs/Makefile.in |    4 
 19 files changed, 992 insertions(+), 210 deletions(-)
 create mode 100644 lib/support/iocache.h
 create mode 100644 lib/support/iocache.c


