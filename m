Return-Path: <linux-fsdevel+bounces-45709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40725A7B68C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 05:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A55633B8F46
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 03:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC0F13AA2E;
	Fri,  4 Apr 2025 03:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="tqV0URDs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10817E0E4
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Apr 2025 03:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743735993; cv=none; b=s6DJWexQGQISYKBUcxRIFzP303iNURq8am5RUjPH3cBzsZaxGUaY7a9z8ft5qLZfT7bMkI0R3yhkC1YIAvIL4JD4eW4RMNceXPjR6FoOhpsMKjjo/UI2SDzZJN6wtwzejW3rju+0Iloh7oVeWGfIiuPS7jwPJfIaIQbi02i21lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743735993; c=relaxed/simple;
	bh=SrFXuEcQgK8Z5GabN3Dq1BLDq4uQKy3e66q/0ZF+rj8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=D4svh4D6YnjdERUl1boLJDLG6YTPEDoBk/AvQDXAF4YLzmLaiFlP7QptJ/m9AZGzaDeln+xnIN8HhzEDsZgC6RxnqsLulslOrnQY437Lmvs6IUt20cVWKgIzfs1yfhI+Up/bCEsVLxOYRYQmN3pDdirbOqOaJ7EL+h2F1w9eo4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=tqV0URDs; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=WpAfRQ/6qAjIAdfa0yV0EG78neDH9kufPdkhII1E3OY=; b=tqV0URDscUCkmlFbEt2zOBSTwa
	xusOc0x8V7khRvsyKME22Yjw05YZ5CZI2uIdXqNrvJfsSmkXL7H7M+tFSQBgf5Z99TrQBb2AMjXgQ
	nTW3+OYqK9X109co1e8WNzPc/150NjTwZPuAUc1Z4vktS2DwDKYl5zdnZbFd4cDyecCRewj4gCf06
	yoCrJZuXwPBJjPDmNL/p/ivG7bJwGfZJhd/gFiovsZ66l1CtlyheAoblfJtzbpN639iZo/7Dq7/fp
	dnRHvUHx/CjhQh0iQVeW5igqj+OkYHZ0e2GQlBTaJ9bX0E+bXXAPApsL6o6ItaDIwTS5tHKckUOaS
	9avMw8Sg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0XNz-000000015Vb-2Jff;
	Fri, 04 Apr 2025 03:06:27 +0000
Date: Fri, 4 Apr 2025 04:06:27 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fixes for bugs caught as part of tree-in-dcache work
Message-ID: <20250404030627.GN2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	Fixes for assorted bugs caught in tree-in-dcache work.
Most of that stuff is dentry refcount mishandling...

The following changes since commit 80e54e84911a923c40d7bee33a34c1b4be148d7a:

  Linux 6.14-rc6 (2025-03-09 13:45:25 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

for you to fetch changes up to 00cdfdcfa0806202aea56b02cedbf87ef1e75df8:

  hypfs_create_cpu_files(): add missing check for hypfs_mkdir() failure (2025-03-17 22:06:04 -0400)

----------------------------------------------------------------
Al Viro (5):
      spufs: fix a leak on spufs_new_file() failure
      spufs: fix gang directory lifetimes
      spufs: fix a leak in spufs_create_context()
      qibfs: fix _another_ leak
      hypfs_create_cpu_files(): add missing check for hypfs_mkdir() failure

 arch/powerpc/platforms/cell/spufs/gang.c  |  1 +
 arch/powerpc/platforms/cell/spufs/inode.c | 63 ++++++++++++++++++++++++++-----
 arch/powerpc/platforms/cell/spufs/spufs.h |  2 +
 arch/s390/hypfs/hypfs_diag_fs.c           |  2 +
 drivers/infiniband/hw/qib/qib_fs.c        |  1 +
 5 files changed, 59 insertions(+), 10 deletions(-)

