Return-Path: <linux-fsdevel+bounces-9550-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4B0842A19
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 17:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0E9B1C24578
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 16:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6875F12C52F;
	Tue, 30 Jan 2024 16:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Wcnaeton"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8B41272C4;
	Tue, 30 Jan 2024 16:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706633592; cv=none; b=RNhhTa20+alBOi43RAV+PMUzm2rZs0arc8rssEg5Jp6//3J0m4tjI5yrMuFd10Y49uUYyi3ws9AVWGbqLLR+PIbfmVPU8fyC4ioAl47AceyBsOTAhhg8VWg6IA6z5tWSaYW13niSxmbKgQ7F8NYqG0zBEK7XYl+Hd+OAkUN3afY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706633592; c=relaxed/simple;
	bh=uiS0GJbwiYIsdO+sIgYuUHJda29PtI1SD0eG+t25LF0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KGFadOUJgFCxyTEan/uaItEoMrE9UWSbg2Ekkg1RES7iLfwrtxj6chTury+AtPaLuW4V8N/gqbutHLIPS5h6aaAFxqrCgZmfyAplII2GoHCl2vRSFE9lBiQ74Pbmn9jwq3+PqqFP6UZ7gQqK5UPBgPTdr/Gcdlyrs+hfr7z99PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Wcnaeton; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1706633583;
	bh=uiS0GJbwiYIsdO+sIgYuUHJda29PtI1SD0eG+t25LF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WcnaetonRB2ptA6rH20S85ZN2YuQ+85XKCChqN/hPetKt9hQMa6MYuz0WYUDKu0dk
	 TRGXuMhSd/MORPXaikKViQvSex0XCt4qww89GEbtegcsxugJg/8FWVmU0KleFZRdCg
	 URgK6HV/mhdB93faG1hohYtpg/CFikQ89UPVO2+6YBcInuB/TQTAvO+CrRwLUkoP7T
	 z7OOTR2aZt+IPrulE57GALlHaC/QeSShs+vFVabk0vuwHLfQxrsFjCnepf8ePGwLlQ
	 RlY0xR0urzM2jWXOR+egACe18PkdIYEzPUmiqu3yKbeMxFrG6CdDKqTLmZedfeFS5e
	 mXznuQ/oV967A==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TPWSb2qKWzVlT;
	Tue, 30 Jan 2024 11:53:03 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jan Kara <jack@suse.com>,
	linux-ext4@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Russell King <linux@armlinux.org.uk>,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v2 3/8] ext2: Use dax_is_supported()
Date: Tue, 30 Jan 2024 11:52:50 -0500
Message-Id: <20240130165255.212591-4-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240130165255.212591-1-mathieu.desnoyers@efficios.com>
References: <20240130165255.212591-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use dax_is_supported() to validate whether the architecture has
virtually aliased data caches at mount time. Print an error and disable
DAX if dax=always is requested as a mount option on an architecture
which does not support DAX.

This is relevant for architectures which require a dynamic check
to validate whether they have virtually aliased data caches.

Fixes: d92576f1167c ("dax: does not work correctly with virtual aliasing caches")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Jan Kara <jack@suse.com>
Cc: linux-ext4@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-arch@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@armlinux.org.uk>
Cc: nvdimm@lists.linux.dev
Cc: linux-cxl@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
---
 fs/ext2/super.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 01f9addc8b1f..30ff57d47ed4 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -955,7 +955,11 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
 	blocksize = BLOCK_SIZE << le32_to_cpu(sbi->s_es->s_log_block_size);
 
 	if (test_opt(sb, DAX)) {
-		if (!sbi->s_daxdev) {
+		if (!dax_is_supported()) {
+			ext2_msg(sb, KERN_ERR,
+				"DAX unsupported by architecture. Turning off DAX.");
+			clear_opt(sbi->s_mount_opt, DAX);
+		} else if (!sbi->s_daxdev) {
 			ext2_msg(sb, KERN_ERR,
 				"DAX unsupported by block device. Turning off DAX.");
 			clear_opt(sbi->s_mount_opt, DAX);
-- 
2.39.2


