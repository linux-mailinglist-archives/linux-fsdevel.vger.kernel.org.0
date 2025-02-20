Return-Path: <linux-fsdevel+bounces-42150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2031A3D37C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 09:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D7247A8350
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 08:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C041EE7D6;
	Thu, 20 Feb 2025 08:42:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from thyestes.tartarus.org (thyestes.tartarus.org [5.196.91.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230471E9B16;
	Thu, 20 Feb 2025 08:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.196.91.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740040928; cv=none; b=ZCkGaM5K8NIKQHyPsYXkfK0r0oU7AqkQn1OD8+/FdASN5w97YhN3h+26BrgAF6prY8WP7TuOZ8hH5xICeNj6uORaxQN7qXAOe2IKXz8BjZQiFNRhl7MgS7S/cqK7j6+0Wx0TQlU91B+RVKhzDCDHlChfPRWi22dUnAUKbzBErZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740040928; c=relaxed/simple;
	bh=oOY9pUPRU/LFLiFkT35A2NYgJ2ZtjzVml5WcxCpqw6E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YR0lRnO629Lk2Ll2VNru3pe4U7YYRTGahfxJFUv8+Ol9DXiqInmm/yscdk09ZFPqnKlSYDfkAI1rbwm+6kChSVYjAfuDuRYmI57G0yOt9bIgxC1S18wcmcmuomV6/CgX/zhrEyVcUfORw+CHTwKmGwALDd0DNyQQhSDG973mKbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=thyestes.tartarus.org; arc=none smtp.client-ip=5.196.91.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thyestes.tartarus.org
Received: from simon by thyestes.tartarus.org with local (Exim 4.92)
	(envelope-from <simon@thyestes.tartarus.org>)
	id 1tl1i6-0006oS-4s; Thu, 20 Feb 2025 08:15:06 +0000
From: Simon Tatham <anakin@pobox.com>
To: David Sterba <dsterba@suse.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Simon Tatham <anakin@pobox.com>
Subject: [PATCH 1/2] affs: generate OFS sequence numbers starting at 1
Date: Thu, 20 Feb 2025 08:14:43 +0000
Message-ID: <20250220081444.3625446-1-anakin@pobox.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If I write a file to an OFS floppy image, and try to read it back on
an emulated Amiga running Workbench 1.3, the Amiga reports a disk
error trying to read the file. (That is, it's unable to read it _at
all_, even to copy it to the NIL: device. It isn't a matter of getting
the wrong data and being unable to parse the file format.)

This is because the 'sequence number' field in the OFS data block
header is supposed to be based at 1, but affs writes it based at 0.
All three locations changed by this patch were setting the sequence
number to a variable 'bidx' which was previously obtained by dividing
a file position by bsize, so bidx will naturally use 0 for the first
block. Therefore all three should add 1 to that value before writing
it into the sequence number field.

With this change, the Amiga successfully reads the file.

Signed-off-by: Simon Tatham <anakin@pobox.com>
---
 fs/affs/file.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/affs/file.c b/fs/affs/file.c
index a5a861dd5223..226308f8627e 100644
--- a/fs/affs/file.c
+++ b/fs/affs/file.c
@@ -596,7 +596,7 @@ affs_extent_file_ofs(struct inode *inode, u32 newsize)
 		BUG_ON(tmp > bsize);
 		AFFS_DATA_HEAD(bh)->ptype = cpu_to_be32(T_DATA);
 		AFFS_DATA_HEAD(bh)->key = cpu_to_be32(inode->i_ino);
-		AFFS_DATA_HEAD(bh)->sequence = cpu_to_be32(bidx);
+		AFFS_DATA_HEAD(bh)->sequence = cpu_to_be32(bidx + 1);
 		AFFS_DATA_HEAD(bh)->size = cpu_to_be32(tmp);
 		affs_fix_checksum(sb, bh);
 		bh->b_state &= ~(1UL << BH_New);
@@ -746,7 +746,7 @@ static int affs_write_end_ofs(struct file *file, struct address_space *mapping,
 		if (buffer_new(bh)) {
 			AFFS_DATA_HEAD(bh)->ptype = cpu_to_be32(T_DATA);
 			AFFS_DATA_HEAD(bh)->key = cpu_to_be32(inode->i_ino);
-			AFFS_DATA_HEAD(bh)->sequence = cpu_to_be32(bidx);
+			AFFS_DATA_HEAD(bh)->sequence = cpu_to_be32(bidx + 1);
 			AFFS_DATA_HEAD(bh)->size = cpu_to_be32(bsize);
 			AFFS_DATA_HEAD(bh)->next = 0;
 			bh->b_state &= ~(1UL << BH_New);
@@ -780,7 +780,7 @@ static int affs_write_end_ofs(struct file *file, struct address_space *mapping,
 		if (buffer_new(bh)) {
 			AFFS_DATA_HEAD(bh)->ptype = cpu_to_be32(T_DATA);
 			AFFS_DATA_HEAD(bh)->key = cpu_to_be32(inode->i_ino);
-			AFFS_DATA_HEAD(bh)->sequence = cpu_to_be32(bidx);
+			AFFS_DATA_HEAD(bh)->sequence = cpu_to_be32(bidx + 1);
 			AFFS_DATA_HEAD(bh)->size = cpu_to_be32(tmp);
 			AFFS_DATA_HEAD(bh)->next = 0;
 			bh->b_state &= ~(1UL << BH_New);
-- 
2.43.0


