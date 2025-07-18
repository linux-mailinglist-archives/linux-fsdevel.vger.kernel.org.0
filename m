Return-Path: <linux-fsdevel+bounces-55398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FDBB098B3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 02:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3318D4A7722
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 00:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95F23C01;
	Fri, 18 Jul 2025 00:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U7WJofQb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C4A1DDE9
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jul 2025 00:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752797018; cv=none; b=E6zgiCkA7scisTHM+f5+LTpuUB+X0C4XwJzGMOPINpdkOcnlYFqFgokC38DsOdAGg3ivpwM3zS7o780Mmh4tyU2IHvo1RvmIgVbzYf3kc9VsDkTY1q5H/9TC7ChCZI/19Y5kEpJnpiy2X9k764Orl5Bb54is5SwKI0GyfWVOSGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752797018; c=relaxed/simple;
	bh=j8XoN8wm5vMCLiPaNNF2pggRUi/IpnaqN6r5ZSfiOO0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=K+X80BpNFWzt5fdAQvfmF+ytC8ZgqYDEjol9/59bW28lhSm+G9bPZpd4ztES7azhJfh9SuCIxUfaG0QL4fRFW9zxpew4kqFNopbbOcIK4QkrG/dewVj1dS+tyjQ6VujCcOB9z4Vq0p0Q6ADjF6LvWGZwOr+yT4Sq0vtMF7r7toY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U7WJofQb; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 17 Jul 2025 20:03:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752797013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=RkUy0/eddyr1B+B24sjHKUq1x4/Az8aRCiU5ZGMSaXk=;
	b=U7WJofQb7Q/ChRaWzco0brOEVtq8F3U8H2fip4xDaCZi6014PmxpEK9KuEE6o45ThlA5pt
	2bVyuuIuyxP6rvcWebOwAhCe8uf6Gr7PsbykKVm0DuDOKIkI/vpaPPK7s6mGd0o1XtQWgL
	Sa/pHwI0sfkOROezK2+ep7UKhUd6DzU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs fixes for 6.16-rc7
Message-ID: <bgaxbeebayrzhkawwhrxrrdgc6xtsk5h454ejv7py4g74hxjs2@yyvkmakatffx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

The following changes since commit 347e9f5043c89695b01e66b3ed111755afcf1911:

  Linux 6.16-rc6 (2025-07-13 14:25:58 -0700)

are available in the Git repository at:

  git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-07-17

for you to fetch changes up to 89edfcf710875feedc4264a6c9c4e7fb55486422:

  bcachefs: Fix bch2_maybe_casefold() when CONFIG_UTF8=n (2025-07-16 17:32:33 -0400)

----------------------------------------------------------------
bcachefs fixes for 6.16-rc7

- two small syzbot fixes
- fix discard behaviour regression; we no longer wait until the number
  of buckets needing discard is greater than the number of buckets
  available before kicking off discards
- fix a fast_list leak when async object debugging is enabled
- fixes for casefolding when CONFIG_UTF8 != y

----------------------------------------------------------------
Kent Overstreet (7):
      bcachefs: io_read: remove from async obj list in rbio_done()
      bcachefs: Fix triggering of discard by the journal path
      bcachefs: Tweak threshold for allocator triggering discards
      bcachefs: Don't build aux search tree when still repairing node
      bcachefs: Fix reference to invalid bucket in copygc
      bcachefs: Fix build when CONFIG_UNICODE=n
      bcachefs: Fix bch2_maybe_casefold() when CONFIG_UTF8=n

 fs/bcachefs/alloc_foreground.c | 3 ++-
 fs/bcachefs/btree_io.c         | 6 +++---
 fs/bcachefs/dirent.c           | 4 ++++
 fs/bcachefs/dirent.h           | 8 ++++++++
 fs/bcachefs/io_read.c          | 5 +++++
 fs/bcachefs/journal_io.c       | 1 +
 fs/bcachefs/movinggc.c         | 2 +-
 7 files changed, 24 insertions(+), 5 deletions(-)

