Return-Path: <linux-fsdevel+bounces-6964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B2281F08D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 17:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B38E22821AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 16:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131A946454;
	Wed, 27 Dec 2023 16:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HLFGYXWA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6111646430
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Dec 2023 16:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 27 Dec 2023 11:44:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703695492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Qzd1caz05K/xE53jshd6MnEUX9CmT0d0snVI44ZJT2g=;
	b=HLFGYXWAmOa6kRGv18uOqeedFmMrjUWL47x3z9T0/SkflWjMlJgIe1mmhuOeLiKUnkVU0G
	3LpuADhAT11Azvcmxe3sLaqvTDprUfCM2JzW55p2KS6CVLdJ2RBTqDQcKMYIPm4JHnJ09V
	BNMx8g7N1BSXz2QvzZ0E3ymslGWFpoI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] more bcachefs fixes for 6.7
Message-ID: <2uukaswjjfuudinozm3igqtfwx2sgkmpwxp7t4jgq2icseoygm@sr3pst2cwvlq>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Hi Linus, few more small fixes for you

Cheers,
Kent


The following changes since commit 247ce5f1bb3ea90879e8552b8edf4885b9a9f849:

  bcachefs: Fix bch2_alloc_sectors_start_trans() error handling (2023-12-19 19:01:52 -0500)

are available in the Git repository at:

  https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2023-12-27

for you to fetch changes up to 7b474c77daddaf89bbb72594737538f4e0dce2fd:

  bcachefs: Fix promotes (2023-12-26 19:31:11 -0500)

----------------------------------------------------------------
More bcachefs bugfixes for 6.7:

Just a few fixes: besides a few one liners, we have a fix for snapshots
+ compression where the extent update path didn't account for the fact
that with snapshots, we might split an existing extent into three, not
just two; and a small fixup for promotes which were broken by the recent
changes in the data update path to correctly take into account device
durability.

----------------------------------------------------------------
Kent Overstreet (4):
      bcachefs: fix BCH_FSCK_ERR enum
      bcachefs: Fix insufficient disk reservation with compression + snapshots
      bcachefs: Fix leakage of internal error code
      bcachefs: Fix promotes

 fs/bcachefs/btree_update.c | 15 ++++++++-------
 fs/bcachefs/data_update.c  |  3 ++-
 fs/bcachefs/error.h        |  2 +-
 fs/bcachefs/journal_io.c   |  6 ++++--
 fs/bcachefs/sb-errors.h    |  2 +-
 5 files changed, 16 insertions(+), 12 deletions(-)


