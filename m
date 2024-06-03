Return-Path: <linux-fsdevel+bounces-20768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1968D79F9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 03:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D06A1C21211
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 01:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D3E5CB8;
	Mon,  3 Jun 2024 01:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qpmR0ZX/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39A13236
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jun 2024 01:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717379349; cv=none; b=KEF/GlJceRhXXLbM0X2HPJQs7CFULONRJdIVWb1WBvs9k6VW9nWoHvbCAk2U2/f3cmonJI6pIkurECuMIxYAd93/CaGoKl2evSVm9kT8fzJJ9goGFwCzSV7Eg/VFSCZCbnOEQqjzsTivNOwm/mN5uZCRAWGoobXHo0QVQP3SQ00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717379349; c=relaxed/simple;
	bh=sg/MaKEkNTcSYkhOqzw6C30ReoEJBzAJpq6wC5MeBZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iQG706kjv7eBJ1B3q7Vawexv9MJ9WrgwrHgFntzSAasAfxX4vl8HsJIXQi6jwkZ4VcUeoqaFKtoK6bnjpjFjd12ThwWPhML7TfBnYLT302cVsgWi3Bc/rQoMs82XMO2gixlTtZqm8r6j5Dtay0VMWxF/wbcOlEjwHaOeiAaX2T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qpmR0ZX/; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: viro@zeniv.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717379343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IuEN8PuEp5zAf5cuG+NcBuj/QAlTcY1rhuZq1w0IU2M=;
	b=qpmR0ZX/ZxljhCkopWDzQMovYtPE8Grn4aPV3cqGFGeCLNHckmBGNuCfdTW/qYso+DIoRf
	CpwJM8nBd/6wGl3MWtXHlSx02xDTZCmtggJzndpCA7sB+pV7bNr7ow4PMn/2bEwoNA4L0d
	zqXUSh3z1GYsqECwvr5fu0d/AXcPGGA=
X-Envelope-To: brauner@kernel.org
X-Envelope-To: jack@suse.cz
X-Envelope-To: linux-fsdevel@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: tangyouling@kylinos.cn
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH] fs/direct-io: Remove linux/prefetch.h include
Date: Mon,  3 Jun 2024 09:48:34 +0800
Message-Id: <20240603014834.45294-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Youling Tang <tangyouling@kylinos.cn>

After commit c22198e78d52 ("direct-io: remove random prefetches"), Nothing
in this file needs anything from `linux/prefetch.h`.

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 fs/direct-io.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index b0aafe640fa4..bbd05f1a2145 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -37,7 +37,6 @@
 #include <linux/rwsem.h>
 #include <linux/uio.h>
 #include <linux/atomic.h>
-#include <linux/prefetch.h>
 
 #include "internal.h"
 
@@ -1121,11 +1120,6 @@ ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 	struct blk_plug plug;
 	unsigned long align = offset | iov_iter_alignment(iter);
 
-	/*
-	 * Avoid references to bdev if not absolutely needed to give
-	 * the early prefetch in the caller enough time.
-	 */
-
 	/* watch out for a 0 len io from a tricksy fs */
 	if (iov_iter_rw(iter) == READ && !count)
 		return 0;
-- 
2.34.1


