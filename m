Return-Path: <linux-fsdevel+bounces-49703-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D44C2AC19B2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 03:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0220A2011E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 01:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC9318FDD8;
	Fri, 23 May 2025 01:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bUnf6NJN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B9A2DCBE0
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 May 2025 01:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747963942; cv=none; b=V8uM2jWr4Yg/d/W95BHBSDADKq5NCvJgHWK1VktXMk+E09R0y8DU/gqPu3L2Yu9Fu+tPfLZ3tLl7I5ZBicPnNcTvpKZzekUaQSE+AO4kJjktTnJlyGmPWeDdqja/p1Jt091TL4AcTEzQxMeYRDIjrWJyWoDur6ACqArrw9L7xGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747963942; c=relaxed/simple;
	bh=43GG+nK/VP9J/MxR3VCZtwb69ooU0HThuyCeYdCYyJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Dx4kiXvWD3ZQBbv7GbsEJAD4BK2MEu8owvP6um4C4Pbo56+rdlVqLWacJiazaZjzORFk2sTMVU3jAmqBtWjj6ge/06DPY61bWzf9GQiQUQDcQRzzzoSN1at1EapDCSH7yD3RKkot0zyrEcu4XhqxQHG9uQja4lZSv7QzUTZhJGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bUnf6NJN; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 22 May 2025 21:31:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747963927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=tmBs0a0pY9TPVe9tBCids2CPMpLMPxoSQO7RwsamZdU=;
	b=bUnf6NJN+el8tZkTwfZD92KGAqUXxujzzxWeXCIOSUhR1fDlSXQCKDuD00s9l40t07RK1c
	fwMoGY0sSYTG93DkLtgaEpszrpAen8N1Lf2C8smWabB52Vf4HgPvYOvwvM9ac6iKyQnLBy
	Hk0TFPOLiKnSO4RsRaSW39dRIDLaZ8o=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs fixes for 6.15
Message-ID: <t4kz463dyrlych7ags2fczrgeyafkkjdppe2zmk7zxdmvdywmb@cs2b2txhexje>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

The following changes since commit 9c09e59cc55cdf7feb29971fd792fc1947010b79:

  bcachefs: fix wrong arg to fsck_err() (2025-05-14 18:59:15 -0400)

are available in the Git repository at:

  git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-05-22

for you to fetch changes up to 010c89468134d1991b87122379f86feae23d512f:

  bcachefs: Check for casefolded dirents in non casefolded dirs (2025-05-21 20:13:14 -0400)

----------------------------------------------------------------
bcachefs fixes for 6.15

Small stuff, main ones users will be interested in:

- Couple more casefolding fixes; we can now detect and repair casefolded
  dirents in non-casefolded dir and vice versa
- Fix for massive write inflation with mmapped io, which hit certain
  databases

----------------------------------------------------------------
Kent Overstreet (6):
      bcachefs: Fix bch2_btree_path_traverse_cached() when paths realloced
      bcachefs: fix extent_has_stripe_ptr()
      bcachefs: mkwrite() now only dirties one page
      bcachefs: Fix casefold opt via xattr interface
      bcachefs: Fix bch2_dirent_create_snapshot() for casefolding
      bcachefs: Check for casefolded dirents in non casefolded dirs

 fs/bcachefs/btree_iter.c       |  2 +-
 fs/bcachefs/btree_key_cache.c  | 25 +++++++++++++++++--------
 fs/bcachefs/btree_key_cache.h  |  3 +--
 fs/bcachefs/dirent.c           | 33 +++++++++++++++------------------
 fs/bcachefs/dirent.h           |  2 +-
 fs/bcachefs/ec.c               | 20 +++++++-------------
 fs/bcachefs/extents.h          |  7 -------
 fs/bcachefs/fs-io-pagecache.c  | 18 +++++++++++-------
 fs/bcachefs/fs.c               | 26 +-------------------------
 fs/bcachefs/fsck.c             | 37 +++++++++++++++++++++++++++++++++++++
 fs/bcachefs/inode.c            | 36 ++++++++++++++++++++++++++++++++++++
 fs/bcachefs/inode.h            |  4 +++-
 fs/bcachefs/namei.c            |  2 --
 fs/bcachefs/sb-errors_format.h |  8 +++++++-
 fs/bcachefs/xattr.c            |  6 ++++++
 15 files changed, 143 insertions(+), 86 deletions(-)

