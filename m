Return-Path: <linux-fsdevel+bounces-43386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0363A55AE4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 00:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35621177680
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 23:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5DC27CCED;
	Thu,  6 Mar 2025 23:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h6Qjbsm4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B745259C9F
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Mar 2025 23:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741303549; cv=none; b=iYpNT8wTABpecL5nzE7fg68OGl2ja+O2RWYDpgP79SWE/OSjLZ57X77NP+nPUxRH0clUEa96Zu5hnixTkwnYQlOXOpwcrYTCp6/ogFxDDDy6O7LKzT66gdMHm3e1U+2Rgcimm47AzrCzRgxfjHeqzhHsjgFj6tS+23h08bv9CrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741303549; c=relaxed/simple;
	bh=pdN6FrzsJA5IzqA1/486ZuvCyc3XEYEHvWiUVKeLFiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mEwlEz4c+uBvocGnxTs6ka5pI1mBvGisKR+yPrFRoscDslVBJGN5BH9Z3htXgdQI9+v405B/qI+JJjWkGaQDFgZ8wnktJOmRCqSi5lC27nLsmCsRtTo4YYozr37O8JccDQnhqOvDpiCaCTpr+/3b9I1JEpE+mQFHqDjlGPtPIfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h6Qjbsm4; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 6 Mar 2025 18:25:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741303534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=ngSD2sW6trZI0t+VBXHdmR5g+7y+JC2jU9Hbm6ucJZE=;
	b=h6Qjbsm4Vm0+xwEjGGaEtk74NOtLl3FaaUSTW14GpdmTXGW5mdRI+IIoNxV8K3C1ERY4Mq
	ST77wGs+OLx/69btU/alzJ4iI8GxR2zWjNJ0W2W5u58upPHeqcScB9Pm4Msq9W7q6W96li
	Ce2b3trjW7AvdRbOwWvu9Cix4KzmplI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs fixes for 6.14-rc6
Message-ID: <ww7iqi2mto3fvyhrgpyxcdzcndcr527evvzktb5xp56o32lwg4@zlvkrwuiki6i>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

The following changes since commit eb54d2695b57426638fed0ec066ae17a18c4426c:

  bcachefs: Fix truncate sometimes failing and returning 1 (2025-02-26 19:31:05 -0500)

are available in the Git repository at:

  git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-03-06

for you to fetch changes up to 8ba73f53dc5b7545776e09e6982115dcbcbabec4:

  bcachefs: copygc now skips non-rw devices (2025-03-06 18:15:01 -0500)

----------------------------------------------------------------
bcachefs fixes for 6.14-rc6

- Fix a compatibility issue: we shouldn't be setting incompat feature
  bits unless explicitly requested
- Fix another bug where the journal alloc/resize path could spuriously
  fail with -BCH_ERR_open_buckets_empty
- Copygc shouldn't run on read-only devices: fragmentation isn't an
  issue if we're not currently writing to a given device, and it may not
  have anywhere to move the data to.

----------------------------------------------------------------
Kent Overstreet (3):
      bcachefs: Don't set BCH_FEATURE_incompat_version_field unless requested
      bcachefs: Fix bch2_dev_journal_alloc() spuriously failing
      bcachefs: copygc now skips non-rw devices

 fs/bcachefs/journal.c  | 59 +++++++++++++++++++++++++++-----------------------
 fs/bcachefs/movinggc.c | 25 ++++++++++-----------
 fs/bcachefs/super-io.c | 24 +++++++++++++-------
 fs/bcachefs/super-io.h | 11 ++++------
 4 files changed, 64 insertions(+), 55 deletions(-)

