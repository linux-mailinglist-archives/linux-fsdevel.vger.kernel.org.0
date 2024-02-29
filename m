Return-Path: <linux-fsdevel+bounces-13161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C295A86C0AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 07:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6322E1F22BA3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 06:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CBF3D0BE;
	Thu, 29 Feb 2024 06:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uUj2DiMA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461CE20335
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Feb 2024 06:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709188225; cv=none; b=eeCzM6F9jrMQoeUd9FBGlbr6E2Fqq7dSL42Vy+4KsqdtADUEO+HJ+w4Hy65kz89lZ6mt5KJg+tY+0nZDz0WXCjJtL3nm11lLXW20H7ZnF27sexHl42i9M/bkdWhIIDoijAYIN7cDiy02zDxCbg3uVk8/tuP4FmdqR2TVhs73QVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709188225; c=relaxed/simple;
	bh=4zL9imxi3/7SfnSRHTTLFP/ufPAV8u3BI2Gd9wj+KMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rIuuFOgBAYsq6egRAXwsFh/zq4XPotA9QAvYPO3NoO6wTgASeBwUB+hZRdO3jt6WxbuurIvw6evC5V/kkWEfz5R3iIxNdmnWMUR/waOuaN+M9omEik2AGZAPORz69oKcs3y1mpinUugj3FXNRGseYMa1AEfIZnHX5zb/r0P/AA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uUj2DiMA; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709188219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pg7J6RbvacNvwMRulFIzUbDizD8sxkMXgSftNlWyMUo=;
	b=uUj2DiMA/3/PjV0agfJadIZHvkN3SZ8uUIXPug7mI2VQs+Qe1++flNquFOceKgbc5Mt57i
	91+E/RKtwQmL8pwQb66hme/Vpvo6+SfJYkYXMSsXNBILDHhRfmTxgtaYEwTD349xkkpHmb
	m+suuoAMCHvg/iZbNcQ9hnvWPIoVQds=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	david@fromorbit.com,
	mcgrof@kernel.org,
	torvalds@linux-foundation.org,
	hch@lst.de,
	willy@infradead.org
Subject: [PATCH 0/2] buffered write path without inode lock (for bcachefs)
Date: Thu, 29 Feb 2024 01:30:06 -0500
Message-ID: <20240229063010.68754-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

this is going in my for-next branch - it's tested and I think all the
corner cases are handled to my satisfaction (there are some fun ones!)

Kent Overstreet (2):
  fs: file_remove_privs_flags()
  bcachefs: Buffered write path now can avoid the inode lock

 fs/bcachefs/errcode.h        |   3 +-
 fs/bcachefs/fs-io-buffered.c | 145 +++++++++++++++++++++++++----------
 fs/inode.c                   |   7 +-
 include/linux/fs.h           |   1 +
 4 files changed, 112 insertions(+), 44 deletions(-)

-- 
2.43.0


