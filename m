Return-Path: <linux-fsdevel+bounces-42149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 543D7A3D382
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 09:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E22E3BDC58
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 08:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1288D1EE7A7;
	Thu, 20 Feb 2025 08:41:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from thyestes.tartarus.org (thyestes.tartarus.org [5.196.91.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534841E571F;
	Thu, 20 Feb 2025 08:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.196.91.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740040915; cv=none; b=brtbo+DyfiaAy4fLZIDJRT6TB8gTuUbBFWhpLmSebuFUSFWsAbg5rRwTf9Wq75kTrs9krflt5J5l+mTLRdaFY4mXIES5rEfs8YXbi6U0XXc4YpNdRyVLNpAG408QvgFBsZIrnCvEpF3tUNNy6gnhK+Qm36h91Ni2ce9d7g9w5vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740040915; c=relaxed/simple;
	bh=Aj+eHx0bj6t0Rq60hDFoNIBUfkKnLnCg3JxcsFiljsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sQ+mswKm4oW168F9fO5Dy3rBatX30bV8v2AS8nSbO/ol0C48oNmgV43vP+M8Na3we2V52ToQPrYxV8WGeVLXbBBtD9gZwuwdLtoxDuHxWaRJTaXI8nvBSaHW2tP/iDGmp9XHI3wp4T/+xJYcW7tgfKN7KunlB2UL/2kvSIcytGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=thyestes.tartarus.org; arc=none smtp.client-ip=5.196.91.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thyestes.tartarus.org
Received: from simon by thyestes.tartarus.org with local (Exim 4.92)
	(envelope-from <simon@thyestes.tartarus.org>)
	id 1tl1iA-0006rl-D8; Thu, 20 Feb 2025 08:15:10 +0000
From: Simon Tatham <anakin@pobox.com>
To: David Sterba <dsterba@suse.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Simon Tatham <anakin@pobox.com>
Subject: [PATCH 2/2] affs: don't write overlarge OFS data block size fields
Date: Thu, 20 Feb 2025 08:14:44 +0000
Message-ID: <20250220081444.3625446-2-anakin@pobox.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220081444.3625446-1-anakin@pobox.com>
References: <20250220081444.3625446-1-anakin@pobox.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a data sector on an OFS floppy contains a value > 0x1e8 (the
largest amount of data that fits in the sector after its header), then
an Amiga reading the file can return corrupt data, by taking the
overlarge size at its word and reading past the end of the buffer it
read the disk sector into!

The cause: when affs_write_end_ofs() writes data to an OFS filesystem,
the new size field for a data block was computed by adding the amount
of data currently being written (into the block) to the existing value
of the size field. This is correct if you're extending the file at the
end, but if you seek backwards in the file and overwrite _existing_
data, it can lead to the size field being larger than the maximum
legal value.

This commit changes the calculation so that it sets the size field to
the max of its previous size and the position within the block that we
just wrote up to.

Signed-off-by: Simon Tatham <anakin@pobox.com>
---
 fs/affs/file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/affs/file.c b/fs/affs/file.c
index 226308f8627e..7a71018e3f67 100644
--- a/fs/affs/file.c
+++ b/fs/affs/file.c
@@ -724,7 +724,8 @@ static int affs_write_end_ofs(struct file *file, struct address_space *mapping,
 		tmp = min(bsize - boff, to - from);
 		BUG_ON(boff + tmp > bsize || tmp > bsize);
 		memcpy(AFFS_DATA(bh) + boff, data + from, tmp);
-		be32_add_cpu(&AFFS_DATA_HEAD(bh)->size, tmp);
+		AFFS_DATA_HEAD(bh)->size = cpu_to_be32(
+			max(boff + tmp, be32_to_cpu(AFFS_DATA_HEAD(bh)->size)));
 		affs_fix_checksum(sb, bh);
 		mark_buffer_dirty_inode(bh, inode);
 		written += tmp;
-- 
2.43.0


