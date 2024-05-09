Return-Path: <linux-fsdevel+bounces-19142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1753C8C08F8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 03:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40A331C20B7A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 01:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFD613BC3A;
	Thu,  9 May 2024 01:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="RGotQh6L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E6013FFC
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 May 2024 01:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715217168; cv=none; b=fyBs3nqfyIAnXSjvMJcx3FDbTEHzc0YCM9UIg2lVywfKdENlLj/V/cNEaADya0XcGvW8ZvUxPJVCEr8WlKB6hJDudyRS7IaxWzAEootuKAsfeGPFedAfX28BDtRKEHKkD9DyuOLCx32t41PP7355dGow6Fz/8cSEc267KfNAWuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715217168; c=relaxed/simple;
	bh=oPMEYYdTcUbGJ0OMQCeee/S0CWrfgfqF0eaeULdi80M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YdGh9N9wF2hFtgnIvM5FEY+yfuGSSDWQfplco8zDJVjrzhzGWODFcbstECU8baAlCXw3WURiGXtyB5LpygLGpRFmU3WdkUQpzqSS66+Q7VAM4ADuBqIsHBuHb43gooe9yFSTivUeZ+iD88i4Dlr/Z12dVkir1E7UzjfD7Invs2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=RGotQh6L; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=2yF7wh+8bTLIiWV0J0Tj7XDCKDOeobnh3MxcOh8WvAs=; b=RGotQh6LbJWv6Px4YwxHa9BOzs
	De3CmP8NvDSDRNhbvVSRBVliRqzjm+9TECQwQZoxLAxWQBnLxKw2nYK34Jzt1Om9G974wQ2aWKTnt
	hYaKRfPMBjGczFWU20QJEHurkBv519YPg7YHyVEVHZxOzG0td63mJj7+qdItBdUC7zlZeu64h64Rv
	CCCN6EahwE77fTAmAos2qq+rb++Z5FIspSzKzKX2sKkUm92OXGBIpMfGtXCf7gQlZF0Yby++iOovj
	jPL0kjpRnF1aOnQnrltkRwKDkhrN9LMPmcbHuQ8GL/jgeBXGLq1op/ZokHByRO6PH7yyK1uq1c5p6
	JIB499vQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s4sKx-00HAbJ-0j;
	Thu, 09 May 2024 01:12:43 +0000
Date: Thu, 9 May 2024 02:12:43 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [git pull] vfs.git qibfs leak fix
Message-ID: <20240509011243.GQ2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

A fix I forgot to send a pull request for ;-/  My apologies - it
actually sat in vfs.git#fixes for more than two months...

The following changes since commit 2c88c16dc20e88dd54d2f6f4d01ae1dce6cc9654:

  erofs: fix handling kern_mount() failure (2024-02-20 02:09:02 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

for you to fetch changes up to aa23317d0268b309bb3f0801ddd0d61813ff5afb:

  qibfs: fix dentry leak (2024-02-25 23:58:42 -0500)

----------------------------------------------------------------
qibfs leak fix

----------------------------------------------------------------
Al Viro (1):
      qibfs: fix dentry leak

 drivers/infiniband/hw/qib/qib_fs.c | 1 +
 1 file changed, 1 insertion(+)

