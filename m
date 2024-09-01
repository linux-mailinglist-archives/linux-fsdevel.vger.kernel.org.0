Return-Path: <linux-fsdevel+bounces-28138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8C0967437
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 04:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 503591C20F48
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 02:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD002BB05;
	Sun,  1 Sep 2024 02:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KKTC2J6E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F061EEE3;
	Sun,  1 Sep 2024 02:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725158660; cv=none; b=aSKLChAeqEbkwIMwfB6lp24J6aCrWd+XwBPdCXgALy2+sOSoScoJFaX4jyurBCchB5q6vxTJ5EPT1N/ba+pqtR3wdCMucFxWbc2JzlEyAqrTPE/r0EVKy5si4Hm9218FW7nkA1skuEjFnQ1M3j6oEjtdhSLf9PRq1DDTIXoT00A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725158660; c=relaxed/simple;
	bh=T0vJEr20YR9EI6JvkFASOgeagEnispNIS2R7rjFHidQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dja2Y5bFmFgbF2cKmiRFJjXTDp1oGz5+32j4zFC5EWUfJbwF8hdr1LhAPAzcEsT2sJmqF8wCpIHdh6koKxzp1tZPritvqMV8qKJGW7Le1wA/N9ItUmXPAvRjMIgX7AY8UgGQFz6agMUwQpb6Zwbx97cskgZj6NiyUf3i15R5BzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KKTC2J6E; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 31 Aug 2024 22:44:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725158652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=ClXa1gmMCVObHX6r1bSkfS0W6OLKBF4+9diKlyGhcm4=;
	b=KKTC2J6Ef7EIK5vwWYxWuT84ObtZbm97oDZCEO0mw25aFP1+4gvP8eYHL0yDE1oB7lqCsh
	yyZ3lx3C6i/6IIsSRDaEBOJJ1/d7LQuPqKJYh7oIk0QqWiNE3Eb/vciISvOraDW+bIfQpY
	JJ0/MrzjzokfPYA1MjGdmNgq1dgTKRU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs fixes for 6.11-rc6
Message-ID: <erydumpfxcjakfllmh3y4d7wtgwz7omkg44pyvpesoisolt44v@kfa4jcpo7i73>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Hi Linus, just a couple small ones.

the data corruption in the buffered write path is troubling; inode lock
should not have been able to cause that...

Cheers,
Kent

The following changes since commit 49aa7830396bce33b00fa7ee734c35de36521138:

  bcachefs: Fix rebalance_work accounting (2024-08-24 10:16:21 -0400)

are available in the Git repository at:

  git://evilpiepirate.org/bcachefs.git tags/bcachefs-2024-08-21

for you to fetch changes up to 3d3020c461936009dc58702e267ff67b0076cbf2:

  bcachefs: Mark more errors as autofix (2024-08-31 19:27:01 -0400)

----------------------------------------------------------------
bcachefs fixes for 6.11-rc6

- Fix a rare data corruption in the rebalance path, caught as a nonce
  inconsistency on encrypted filesystems
- Revert lockless buffered write path
- Mark more errors as autofix

----------------------------------------------------------------
Kent Overstreet (4):
      bcachefs: Fix failure to return error in data_update_index_update()
      bcachefs: Fix bch2_extents_match() false positive
      bcachefs: Revert lockless buffered IO path
      bcachefs: Mark more errors as autofix

 fs/bcachefs/data_update.c      |   1 +
 fs/bcachefs/errcode.h          |   1 -
 fs/bcachefs/extents.c          |  23 ++++++-
 fs/bcachefs/fs-io-buffered.c   | 149 +++++++++++------------------------------
 fs/bcachefs/sb-errors_format.h |  10 +--
 5 files changed, 68 insertions(+), 116 deletions(-)

