Return-Path: <linux-fsdevel+bounces-7857-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B72BB82BBC6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 08:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 217E2B22CDF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 07:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CD95C918;
	Fri, 12 Jan 2024 07:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="nejn+f+J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08AC5C8FD
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jan 2024 07:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=gjfYNVuTrDaYPdjyYgvf2nHcZRNPs9ErZjTCtgnWnn4=; b=nejn+f+JXJFnYyZukWgxSJmgF7
	t9J6ZtGCB2zwFbSikBqd7kGflBOE7bWgkqZnP0pmg6AVJUjcCpzd0oTGSg7Nj/u8G/kdzmKS+lBF1
	nXFke9eVCJyv2KwUZw47ZeEIpzikC/rJl7oXlqYezcsHKtAFT5HOIeuSkPy/hTxD/ut8STAKxY3Mf
	+aoaIoF5gXUyTrHg2qdJozoE8K7Qqlxg3dyG2tki99ON86womNFBE93IWWdzHYCCbZKkqdqxRYGXF
	EQX7Qi1bWbwgqXQ5xVFJNwr1u72AWOcX8l5JHhrZwasTUtEHHsA8C44ZBo0nN1KdKJezYaFWT8u2L
	D+Cyg+og==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rOBzG-00E7D4-31;
	Fri, 12 Jan 2024 07:29:55 +0000
Date: Fri, 12 Jan 2024 07:29:54 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	linux-fsdevel@vger.kernel.org
Subject: [git pull] bcachefs locking fix
Message-ID: <20240112072954.GC1674809@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

Looks like Kent hadn't merged that into his branch for some reason;
IIRC, he'd been OK with the fix and had no objections to that stuff
sitting in -next, so...

Kent, if you *do* have objections, please make them now.

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-bcachefs-fix

for you to fetch changes up to bbe6a7c899e7f265c5a6d01a178336a405e98ed6:

  bch2_ioctl_subvolume_destroy(): fix locking (2023-11-15 22:47:58 -0500)

----------------------------------------------------------------
fix buggered locking in bch2_ioctl_subvolume_destroy()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (2):
      new helper: user_path_locked_at()
      bch2_ioctl_subvolume_destroy(): fix locking

 fs/bcachefs/fs-ioctl.c | 31 +++++++++++++++++--------------
 fs/namei.c             | 16 +++++++++++++---
 include/linux/namei.h  |  1 +
 3 files changed, 31 insertions(+), 17 deletions(-)

