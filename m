Return-Path: <linux-fsdevel+bounces-30923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3F298FB39
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 01:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B19B0B21954
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 23:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8A21CEAA3;
	Thu,  3 Oct 2024 23:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="PfdFtXsQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8750A142E9F
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Oct 2024 23:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727999956; cv=none; b=RwkpNXbhMf+pysH2Z5IE53K4IUlKqHwNpZ3zV0Cb79gN28webXXuuKHQE+EKWUxSvBc6Q0z/CQaS+OYAVGrtwEqGmbzGEAVvhcGb+GKBK0EFw9hEpg+1ez+/RjzBDjVnGI90eNRj8elXQh9F1o76gStesHNhGgH5qJRHgtIgDn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727999956; c=relaxed/simple;
	bh=5Hn0PdNRwEqYqGpl7i+owEWrTGwqpxCHwXMXei/lpG0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=J4OiNHZmsFcVl2J5/5Qqvg/0xb2aUUOsgcGQ6Maoo3Ws88xu5nIyz/JInHcW/cKob1lr9Y6R0JnYizOjszp6qI63YvMxE748r3xyYU7wT4atY9jv9ZMTc9CdIQPJxlErq4axjY6mGq+RB+MHSNPWzwC3Nluyh7q2dmUhG23x5x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=PfdFtXsQ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=82P1cjt7e/KUYgaKd0ck3r7CgdG3tliCoe0TabFfuNo=; b=PfdFtXsQQGkvo8O5qvInWc8aR+
	pU8UIe+MB9fMNceQPkyOCmlnZxfsbL0gFz03U+3h3PIagbvaPVBWkUbsQ10ls0FODnqNOw8stUpkT
	q6q/kLqY5tlQykOwMDvc1uvniBR4wXW/UDd0/+fc5cOLnKHxlux8OfMiibSF6wZ8PtS10UvcypMQR
	CP2NdiLJlm0Kc9c1OK32DF4tZJsj+aAYBgbmOhPOmks8nO2rJ6Q4/gh+Mdlz8ZBZC25GLL6W6qIKC
	jw5ZrrUxFvfnBg1gLUT1VL4CCNZAWpcTNOUmzOLVXHfS8Vym3GEtBIXwulIwQUAxfz6zDwZiz87NK
	2KmaA6ew==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1swViy-00000000ce4-0vcw;
	Thu, 03 Oct 2024 23:59:12 +0000
Date: Fri, 4 Oct 2024 00:59:12 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [git pull] ufs regression fix
Message-ID: <20241003235912.GN4017910@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	"folio_release_kmap(dir_folio, new_dir)" in ufs_rename() part of
folio conversion should've been getting a pointer to ufs directory entry
within the page, rather than a pointer to directory struct inode...

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes.ufs

for you to fetch changes up to 0d0b8646a66de7f3bf345106f2034a2268799d67:

  ufs_rename(): fix bogus argument of folio_release_kmap() (2024-10-02 00:05:09 -0400)

----------------------------------------------------------------
fix ufs_rename() braino introduced this cycle

----------------------------------------------------------------
Al Viro (1):
      ufs_rename(): fix bogus argument of folio_release_kmap()

 fs/ufs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

