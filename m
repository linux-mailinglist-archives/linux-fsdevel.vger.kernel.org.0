Return-Path: <linux-fsdevel+bounces-16886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2058A41FF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Apr 2024 13:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0841E1F2132C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Apr 2024 11:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0963610A;
	Sun, 14 Apr 2024 11:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="McePP7BR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C5A23759
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Apr 2024 11:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713092971; cv=none; b=H/x3Vd/vzM4tj3hrKZxGua8ZMJBd5mET7A9+otksXSO2iZPE7NcJoE4JQkJpDS2E3qhY7S/kRShu+JwutViILRJ6f/t5RDuHV/vRGRPqgJxWE3meKJdBN0GziBzvDPJf/+VwsCFfgfSUNvO8wZHlCETnPNUaoqqOTJlQFeDoIJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713092971; c=relaxed/simple;
	bh=seFK/L5TpeVanGLobB6XLc7+Hnht6QgMMY0Q8XYqJnA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=a/zItvvKGdS6h6Ci+YQVy9n4jp5Qj9/wfmKaeVXvXxLmqV8B6ESgk8M7gbSJDf56wa32irbL20LDmdyhlhcET8exbG+oUda68ghL2LBUJAqjv1ePxxzAZY2Zz0aI+IW7IIH899DbHb/gdjeFVqLED2trdSWsh0qCUeXI7h4cnDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=McePP7BR; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=vZG5wWPPgn+Ywzu2fSLro+xyXEKnLiAa5+PAkmLidVM=; b=McePP7BRdJYbzGhfidcm0awRFC
	nZmw+ytJcZW8GH2FmDG50Q03QPA75qMmx5PgIXnjCdf8p7PWKUyNZvhCIziWRGIC+Y+3gvYN+Qu2u
	fnyVCyPBdhDAXW+1+PLQ/EnjuiZUuoNhIOSsEVZ6g8d+iw7rQL/34ihpg/OKt7i3LWQVxg2B/VuOO
	/8wC75+o7SJ71cqZOsOYJzMGjaEwLf/+BRDq2gTGGPP0Bm4v/0lPplao3k7d1qn7tv1Jxjb3rBPPD
	c9/YTd4f7DnTPw6BWyqL81Y9gwNNJPAudPkqEG2pJsj+INmMyvMjGeJg1PrOCIm04Y3ssRpjZ9TsS
	bJHTZYqA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rvxjh-00C6ds-2N;
	Sun, 14 Apr 2024 11:09:25 +0000
Date: Sun, 14 Apr 2024 12:09:25 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: [git pull] fix lockdep false positives around sysfs/overlayfs
 interactions
Message-ID: <20240414110925.GS2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

syzbot has uncovered a class of lockdep false positives for
setups with sysfs being one of the backing layers in overlayfs.
The root cause is that of->mutex allocated when opening
a sysfs file read-only (which overlayfs might do) is confused
with of->mutex of a file opened writable (held in write to sysfs
file, which overlayfs won't do).

Assigning them separate lockdep classes fixes that bunch and it's
obviously safe.

The following changes since commit fec50db7033ea478773b159e0e2efb135270e3b7:

  Linux 6.9-rc3 (2024-04-07 13:22:46 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-sysfs-annotation-fix

for you to fetch changes up to 16b52bbee4823b01ab7fe3919373c981a38f3797:

  kernfs: annotate different lockdep class for of->mutex of writable files (2024-04-14 06:55:46 -0400)

----------------------------------------------------------------
	Get rid of lockdep false positives around sysfs/overlayfs

----------------------------------------------------------------
Amir Goldstein (1):
      kernfs: annotate different lockdep class for of->mutex of writable files

 fs/kernfs/file.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

