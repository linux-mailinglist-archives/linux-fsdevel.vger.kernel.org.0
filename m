Return-Path: <linux-fsdevel+bounces-10351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D86084A7B0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 22:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D01151C27879
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 21:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AAA12BF00;
	Mon,  5 Feb 2024 20:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Dg8R9kdj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6557B12AAEE
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Feb 2024 20:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707163571; cv=none; b=t7GPFGD6/xyt3Fei3wKU6H88C4ewzyXClROEBbcB12tfkFIvxA/Nf3YnL/mudocIB0agsqvU21iZqByXGVrxZB6FFlNiaFHBELlxa58aAYDuWjspWRgR5OCFyOmzMK8SGDPH715HQkKAX4jIxpJqO3a7pipV3A3hl0Qkhj/r5H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707163571; c=relaxed/simple;
	bh=e2lTROAYcoM/HDLzlNIvyaAd2xWkASoCHOPzvyTKoeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gH92YWGnOqRXVcTNiyS/XUYsDPYqKdYfcJHUqhhDuwJ9VmUhZXmxHRzkc7DTVza5CAFwbqpF8++4TK6eO5TmyP/jyhAtYe11i3zypad47wKwyObLlsfGcj2C/Lv4q3R/JEr8jp08rIcJXJHAYo1mN2BXm9OdxJawrigjIFdv63c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Dg8R9kdj; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707163567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Y3gjAfbNTQAYItYsU5COE7+yozdE8QNyrcmsyi3W+A=;
	b=Dg8R9kdj58O0ZqQd8Z7H3MJ/Xo+17XcsMUPoyC294HD/6wNiULMRl/SvP5MfWcctiuI5Io
	t6CsU8lFKiS3p/H+xykTaZ3BnRI4WQGh1bEXwdtcL+5YOwxMPZjB8OrKC4sytClnNQmBdQ
	OH6F7iJCR/fZItMA4ZecGTa8HqOC7p4=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 3/6] fat: Hook up sb->s_uuid
Date: Mon,  5 Feb 2024 15:05:14 -0500
Message-ID: <20240205200529.546646-4-kent.overstreet@linux.dev>
In-Reply-To: <20240205200529.546646-1-kent.overstreet@linux.dev>
References: <20240205200529.546646-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Now that we have a standard ioctl for querying the filesystem UUID,
initialize sb->s_uuid so that it works.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/fat/inode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index 1fac3dabf130..a3d3478442d1 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -1762,6 +1762,10 @@ int fat_fill_super(struct super_block *sb, void *data, int silent, int isvfat,
 	else /* fat 16 or 12 */
 		sbi->vol_id = bpb.fat16_vol_id;
 
+	__le32 vol_id_le = cpu_to_le32(sbi->vol_id);
+	memcpy(&sb->s_uuid, &vol_id_le, sizeof(vol_id_le));
+	sb->s_uuid_len = sizeof(vol_id_le);
+
 	sbi->dir_per_block = sb->s_blocksize / sizeof(struct msdos_dir_entry);
 	sbi->dir_per_block_bits = ffs(sbi->dir_per_block) - 1;
 
-- 
2.43.0


