Return-Path: <linux-fsdevel+bounces-14426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DB487C822
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 04:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71D5B2832E1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 03:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74320125C7;
	Fri, 15 Mar 2024 03:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u5D6vHOw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A424ED534
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Mar 2024 03:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710474803; cv=none; b=lB5U/Wpm5CpbqA8kffwJGkl1TRrDgR1iDgZosbyi33JLnHYyjvDSwStty6R+bIE0SEeiORQRAQL4/O+vMFHC6Uv/WF5rvElasHi7N29eqqU0l8Chp6bBLxy0uf0zQaENKNry31eUhlMDt+Tf8/2rOgGhe4mKj9UOX24SDG1jVro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710474803; c=relaxed/simple;
	bh=ETe7xjHWW1b2dyWEqu+mzr7jH/S4kWsRcee5sNWNUGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RWqikZ9XZ07JZbk3nKpwIPds2nNiDQoMxbtDBqxLCGQrcHDQwlORFld19jMeeMx0fB8L3d5fTBfwZePTpATcBO89Wd5Xoghe9k2pFecYskwDMdhuGr92DteyHK6maSKt/ulr1UCp3LlfLVxOKG8f/1d97cc2u8BHETROFYxh1Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u5D6vHOw; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710474799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=38/wt83nJ9aR6snVd8vXn5qYmIdiido/GJdtnp1qpj0=;
	b=u5D6vHOwZvchQp6ixuQd6dz4r6idaKFDKTcaZiRCoPeUnOz8dkiLIFPU+hPcDyLUey1wgr
	IX7H4UpcQloK5ugvhmpX6jlrV0aR6xfjja6TYxY+toxhvkT82pa+KrWZel/Nwjx0dwoGmU
	h6sds6520v3+duicIQ6eg7ID/7ou+Hw=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: torvalds@linux-foundation.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 2/3] bcachefs: Initialize super_block->s_uuid
Date: Thu, 14 Mar 2024 23:53:01 -0400
Message-ID: <20240315035308.3563511-3-kent.overstreet@linux.dev>
In-Reply-To: <20240315035308.3563511-1-kent.overstreet@linux.dev>
References: <20240315035308.3563511-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Need to fix this oversight for the new UUID/sysfspath ioctls; also,
initialize the sysfs path.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/bcachefs/fs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
index ec9cf4b8faf1..cfc9d90ab179 100644
--- a/fs/bcachefs/fs.c
+++ b/fs/bcachefs/fs.c
@@ -1881,6 +1881,9 @@ static struct dentry *bch2_mount(struct file_system_type *fs_type,
 	c->vfs_sb		= sb;
 	strscpy(sb->s_id, c->name, sizeof(sb->s_id));
 
+	super_set_uuid(sb, c->sb.user_uuid.b, 16);
+	super_set_sysfs_name_uuid(sb);
+
 	ret = super_setup_bdi(sb);
 	if (ret)
 		goto err_put_super;
-- 
2.43.0


