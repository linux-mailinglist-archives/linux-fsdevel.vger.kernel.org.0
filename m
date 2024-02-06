Return-Path: <linux-fsdevel+bounces-10517-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7475084BE88
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 21:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 125411F27422
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 20:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C141D1BDDC;
	Tue,  6 Feb 2024 20:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fwScqX0m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993651B275
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 20:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707250755; cv=none; b=sMIwnCGK1EVZwZEKfpsNCOFlZmpLMc1EDg3gH0NRbeqliJlMFjzORjx2mcbq77oWQnT5TJo0aU04PNDmWgtjGMZBGOp5gcn582IuQHNJe1mGGewOZOwqxphJmVT7/5MdUfxedQ1wAYlq61odklo9hmGTf0oro4fCaeN3ORGsWmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707250755; c=relaxed/simple;
	bh=BmbZGsFxwakjn0IikUsjUWm3IXpJHfHD1/as7Xt9Pcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cw/EBFZPJJ8mRim3UzHcuynp2xJcAuvxkIcWiYVTp9d949FKAr0N5duj4SBC/vDnE7cQ4Qqxgc2CyEArrmRCB0S8A4i0MfG4GiMEaN2pR4qAO69g6BUsHYXBhlnTBOlTt3GTHQvvu6OMHUblTOywCDpMkfAiUwB+y5boSMsh104=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fwScqX0m; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707250751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ORZ3NxtyAsFtX+LQqgBHca7yU+LThn04BGVHp9Ql3Xo=;
	b=fwScqX0mnWDNlYrU6EpWlu3bS17zj2d/+yx3GJV7H8mqYcnwQLUTmo0E3m/Lxpforau8JM
	O+M+wuxH0ZwvKEc+AP7mBE9c3gA2HhDVpS0NAZHr+sq1enlGS+NtJ+yDqcmeBxzVjNW5BR
	M6CJaUFkFsWGlVLN1DWOT3IYg+QzLKc=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH v2 4/7] fat: Hook up sb->s_uuid
Date: Tue,  6 Feb 2024 15:18:52 -0500
Message-ID: <20240206201858.952303-5-kent.overstreet@linux.dev>
In-Reply-To: <20240206201858.952303-1-kent.overstreet@linux.dev>
References: <20240206201858.952303-1-kent.overstreet@linux.dev>
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
 fs/fat/inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index 1fac3dabf130..5c813696d1ff 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -1762,6 +1762,9 @@ int fat_fill_super(struct super_block *sb, void *data, int silent, int isvfat,
 	else /* fat 16 or 12 */
 		sbi->vol_id = bpb.fat16_vol_id;
 
+	__le32 vol_id_le = cpu_to_le32(sbi->vol_id);
+	super_set_uuid(sb, (void *) &vol_id_le, sizeof(vol_id_le));
+
 	sbi->dir_per_block = sb->s_blocksize / sizeof(struct msdos_dir_entry);
 	sbi->dir_per_block_bits = ffs(sbi->dir_per_block) - 1;
 
-- 
2.43.0


