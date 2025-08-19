Return-Path: <linux-fsdevel+bounces-58322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8E7B2C943
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 18:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DBEB5C0843
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 16:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2781F2BF3DF;
	Tue, 19 Aug 2025 16:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="LdL24r4y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C16B2BE7BB
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Aug 2025 16:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755619957; cv=none; b=faEyCsJ2VQuiI1aOROU5DYC3XLkCix7rYlHMPlPtWn06p4KHUdGjdZJcHpT8zClwqH7I+Fd9x9gMB2qBcbC+5zVQOKWab3PdPIknOmT2+O1iuEP98ZMPdaHEHgJmRLWVLNEizyOLs9xDMUszu04rkSEIP7lX1GcMbNetsWvKzKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755619957; c=relaxed/simple;
	bh=paW2nIsTj6S45jSQpQpm8aluAUHpyijaXYi1BdxRB4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wq/e4XleLEr8c5rKXgd22Qycqxy0cUk47E7/omHjruM3E3Q44bPStvvlIoI56wu8cL/WUraWR7SIOSv0m9w3f7T81906sj7UPGRfhI4abPC39LeXQQkVTbvx0tSQ0XBzMipbmmrYDPHIQxyS7nk3UCjVAaU4nwYuyGWw7xgoh9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=LdL24r4y; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kYG6iyEYdpDOVOD/b6HtD1y5FjyKu7em72ssEq7Khmk=; b=LdL24r4y/Dop7JftKT7mJdgM/X
	MLGFFnNRhZIKjb8lGLqIRbbDhuiWdOtfaxtH/nHKJKu9OTtVE1BU18ul7bi+45ZU0OCggKK3ZrytI
	JKwBSn0cAvpvKOX1E+7BOLZB6om6Yt7pCO6o7Pni/K+djxJWC2F/KMPveXhjJ7z+OKMdBI8Sv2kO/
	WqHme3pYbvZp29ihTLza6spe41bDhgH/9VQ/G4e621QEPId8WWeqwzevzCh2AF0OSdYoN1951SQaP
	jI7TyAEJF7QsE29llNwkcszUbHjesUzhdDHOrIeIeyTlu6RWUmWF7WxdAcRaOUCuz0Ze7i73ZtvY8
	w+Xb02BQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoOwm-00000000ACQ-2qeX;
	Tue, 19 Aug 2025 16:12:28 +0000
Date: Tue, 19 Aug 2025 17:12:28 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"Lai, Yi" <yi1.lai@linux.intel.com>,
	Tycho Andersen <tycho@tycho.pizza>,
	Andrei Vagin <avagin@google.com>,
	Pavel Tikhomirov <snorcht@gmail.com>, linux-fsdevel@vger.kernel.org
Subject: [git pull] mount fixes
Message-ID: <20250819161228.GH222315@ZenIV>
References: <20250815233316.GS222315@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815233316.GS222315@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

(collected *-by and slightly cleaned the text in commit message of [3/4]; otherwise
identical to what had been posted and sat in #fixes)

The following changes since commit 8742b2d8935f476449ef37e263bc4da3295c7b58:

  Merge tag 'pull-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs (2025-08-12 12:10:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

for you to fetch changes up to fb924b7b8669503582e003dd7b7340ee49029801:

  change_mnt_propagation(): calculate propagation source only if we'll need it (2025-08-19 12:05:59 -0400)

----------------------------------------------------------------
fixes for several recent mount-related regressions

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (4):
      fix the softlockups in attach_recursive_mnt()
      propagate_umount(): only surviving overmounts should be reparented
      use uniform permission checks for all mount propagation changes
      change_mnt_propagation(): calculate propagation source only if we'll need it

 fs/namespace.c | 41 ++++++++++++++++++++++-------------------
 fs/pnode.c     | 10 ++++++----
 2 files changed, 28 insertions(+), 23 deletions(-)

