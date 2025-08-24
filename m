Return-Path: <linux-fsdevel+bounces-58899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD5AB33327
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 00:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E9911881A11
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Aug 2025 22:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE2D2571CD;
	Sun, 24 Aug 2025 22:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HynLNXxe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA8021ABB1;
	Sun, 24 Aug 2025 22:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756073460; cv=none; b=l9/+wTabTZXsELcu5bgjz3vp2i5PTeBgFtlv1kBMCQmgYdA5PMsZi8B3MFKcdEbranJDctaqIPM6ew2F6F8OpWbzADI2VdXeJM8OGp0nnQkV5lQn3ised7hcGfwF/o9qXhTbzJXe6zZNZxqEpQDxfTzWvjAu0jhUekQbcwbbGRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756073460; c=relaxed/simple;
	bh=F2I8ehYbuOZkroeVyTJBplw4uA0f86+T2vgg5gXzd4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EAUuuniBjSTb+LKR+1UQQ5Ah9czbeEW+pmI8EQmHdnwTyK8tcXDzPEpTlrEQCDiSxO6Ocgx7P6/ZPeYEizlvMeliNT3icHTqmcZJ4zDfqxgFEuOk+YZ8/cm/OyOWtajHSBBkU9WtkwukkUNd71vbLs3LCUZShXjWlnSo6BAncRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HynLNXxe; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=zOkyzVYHPHDLXgXeS6e7XGbTKHi06uVL/QHgq6g0IY8=; b=HynLNXxe/bZhVm0/0FOqHqQl5q
	JZx5GKNa/J7ryvKZEtWykMeS3U9D5YlJVRfuYBDaf7HpC7t2xcnB1aeAozOEqP0JNIYNdBwdIE6M5
	QcCid2oqWIDYHMYz7w2/UV4IqVeKtsqnc9U2JXkNKGT68E2gX6fF1Uq5ize+iziXCH8NSOPPacasK
	mm+xmLgTCt6DVAamypIofiCepPqNq9XfB9riS/LaXsfFBfFC8iGu7EyytjUqJdMLHia8j4bH9GtI0
	79IkRSmlytTH+1dTsUH8GVzU3W6uOGTqnBSfgDy48FuCS1+ixhZ5wXsAtd9fH+W6/ONhSG/j336kl
	3orhoxbA==;
Received: from [50.53.25.54] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqIvQ-00000006aHc-1oZn;
	Sun, 24 Aug 2025 22:10:56 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: [PATCH] uapi/fcntl: conditionally define AT_RENAME* macros
Date: Sun, 24 Aug 2025 15:10:55 -0700
Message-ID: <20250824221055.86110-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Don't define the AT_RENAME_* macros when __USE_GNU is defined since
/usr/include/stdio.h defines them in that case (i.e. when _GNU_SOURCE
is defined, which causes __USE_GNU to be defined).

Having them defined in 2 places causes build warnings (duplicate
definitions) in both samples/watch_queue/watch_test.c and
samples/vfs/test-statx.c.

Fixes: b4fef22c2fb9 ("uapi: explain how per-syscall AT_* flags should be allocated")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Cc: Alexander Aring <alex.aring@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
CC: linux-api@vger.kernel.org

 include/uapi/linux/fcntl.h |    2 ++
 1 file changed, 2 insertions(+)

--- linux-next-20250819.orig/include/uapi/linux/fcntl.h
+++ linux-next-20250819/include/uapi/linux/fcntl.h
@@ -155,10 +155,12 @@
  * as possible, so we can use them for generic bits in the future if necessary.
  */
 
+#ifndef __USE_GNU
 /* Flags for renameat2(2) (must match legacy RENAME_* flags). */
 #define AT_RENAME_NOREPLACE	0x0001
 #define AT_RENAME_EXCHANGE	0x0002
 #define AT_RENAME_WHITEOUT	0x0004
+#endif
 
 /* Flag for faccessat(2). */
 #define AT_EACCESS		0x200	/* Test access permitted for

