Return-Path: <linux-fsdevel+bounces-50240-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DECAC95EB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 21:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0F6F503685
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 19:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FB5277032;
	Fri, 30 May 2025 19:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="fe900jDU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2179DBE5E
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 19:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748631892; cv=none; b=qHnrKRdmsFkTSA2otRUmtKDx99fzYXE3t9rd0whCF41yWjLPpbh43gKIyTBDkNThR6k69GPhfxDwfHUHsgCIvu8AUPQKq4I+8eI7ErPAyfaIf7tqbiuVzARm7ZP31QMh7IQNVd4YdBFBVmJPK11b7g9vE8hRi4ONUq3jHxvc/NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748631892; c=relaxed/simple;
	bh=2DoQswIBme2/I2AzErLiU9vbulBhDA+TWhhJfj5A8E4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RZMXNxC8R3SwVy6djDJJcte+lR+2OWE6YD8qiCqPYFNIrJyJpMUjLP+ny3a0LyiOxdQYRQpRQ3mGzKS+wUPNf4xmW2fk5NfX5/ESIqtcQSachYJShsOV8220IMvVJlTSt/1CGutq+7nkRXvkbXbaDCiP/xuqUB/2nYgq5IFT5T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=fe900jDU; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=NvjUi8pEYMecNrYiHmiusx0qhY5rKrt0/qwxQfFv4Vc=; b=fe900jDUQkdBUJR0yId/xu19an
	UaQGkqq98WAc+Yz4Vmf6bPV9jWRj6Aq4x6TttbLnGVfaFywKnVdBasDY8HnnSEUpPBViLIjnloauy
	wn+2X2X8IX66ZdknyynNLXpdvqGMrmGG+mBnPOODR8+B7Dn/X04WmcaZiFpkhwhd+YWa/IbzJgmo5
	bWd746RjcoiPG88Vqt+MamZEwL5IpN7BekMhpnYDivB5WX2evHxS2lIcHsR/gYsm/dXzVwFxomUMN
	1jZNyrc0pFGWKTU66lcRvhuEqa2ttHOqU1o6i1p/E1lCAfUyRSofuQaR9yxoP/3+Y5a0a+iHOOHOG
	naVsp3aQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uL527-0000000F1xL-0W5s;
	Fri, 30 May 2025 19:04:47 +0000
Date: Fri, 30 May 2025 20:04:47 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Allison Karlitskaya <lis@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: [git pull] regression fix for mount propagation in detached trees
Message-ID: <20250530190447.GA3574388@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

6.15 allowed mount propagation to destinations in detached trees;
unfortunately, that breaks existing userland, so the old behaviour
needs to be restored.

It's not exactly a revert - original behaviour had a bug, where existence
of detached tree might disrupt propagation between locations not in
detached trees.  Thankfully, userland did not upon that bug, so we
want to keep the fix.

The following changes since commit d1ddc6f1d9f0cf887834eb54a5a68bbfeec1bb77:

  fix IS_MNT_PROPAGATING uses (2025-05-09 18:06:27 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

for you to fetch changes up to 3b5260d12b1fe76b566fe182de8abc586b827ed0:

  Don't propagate mounts into detached trees (2025-05-26 17:35:32 -0400)

----------------------------------------------------------------
6.15 behaviour wrt mount propagation into detached trees breaks userland.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (1):
      Don't propagate mounts into detached trees

 fs/mount.h     |  5 -----
 fs/namespace.c | 15 ++-------------
 fs/pnode.c     |  4 ++--
 3 files changed, 4 insertions(+), 20 deletions(-)

