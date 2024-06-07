Return-Path: <linux-fsdevel+bounces-21184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E39FF90033F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 14:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF2CD1C20E08
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 12:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6D3197521;
	Fri,  7 Jun 2024 12:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="gIGVhle3";
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="i99mM42n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27588195808;
	Fri,  7 Jun 2024 12:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717762586; cv=none; b=PG+SynQUnuJ6+gZwXoXQK0frT/p5UQIatsIa23xqTiOAhVaOAXG5owwIiwS9WKphOW1nKFO1QNy1Zeg4e7PP45xSBx/0yAAqWjYlwTxrvMYKGCt1d1AXYMVzcoaUvnIr0qkA4un/a918GDoG91DUnJEWY/XiBzFnYSnkeHX8s8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717762586; c=relaxed/simple;
	bh=5kjkfThvuQA69/cISjSLIfgcj+LkJZeORavkgbHvrf4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L0WtQcFQiC5/H8Su7fAiwEuGdXGSSJmn3awCcBVdTTBlIM/w5lqcajyE5UVmsfUnZNijVpkeacJv6NIXSjy/a8rYF5My7l06cg/fliBL2DpWqJqYUKsmC5ojkM3iu2HloO31LyEMkl0t2e/RIyk8cWDSY/pbtbDwCCc0sRrYcoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=gIGVhle3; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=i99mM42n; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 7F39F2111;
	Fri,  7 Jun 2024 12:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1717762109;
	bh=vVAUSjzFV74Wpp24l92pd4CdaVxe69nKA4VMgiDOHv0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=gIGVhle32vQyUOIxlJavOPxkw55gqCD3WVSANt92+1MXooz9Q3ZeCzpE77Hf9bNw7
	 14byoUlbRLg6sA4ldbzPCehcztG1faO/VGsWTQMVlKh5AzatpWa1huNJVapS7rPDw/
	 OeDmiNdrf+2XmPMe+KnXJcyq1Cmu9T+zBeOYGI0I=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 63FF2195;
	Fri,  7 Jun 2024 12:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1717762583;
	bh=vVAUSjzFV74Wpp24l92pd4CdaVxe69nKA4VMgiDOHv0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=i99mM42nD/tKucft2XWC/ek4ljynfG1A2cLP7UbllwuqJb7YIYvvQvqPlXFpaz0Ms
	 iqKiK59uUeJjfUCyi0lS+gjHCb6XXdsPhxYzuzElPoCeMe0id7IdGDxrYKDmrW3y9Q
	 v1vt+LWn6KhGmz71Xf5zbfwC3ok2RGeFtO6hz5qo=
Received: from ntfs3vm.paragon-software.com (192.168.211.95) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 7 Jun 2024 15:16:22 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 15/18] fs/ntfs3: Remove sync_blockdev_nowait()
Date: Fri, 7 Jun 2024 15:15:45 +0300
Message-ID: <20240607121548.18818-16-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240607121548.18818-1-almaz.alexandrovich@paragon-software.com>
References: <20240607121548.18818-1-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

Flush the file mapping directly.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index f3f6af10a586..46130cbd08d4 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -1093,7 +1093,7 @@ int ntfs_flush_inodes(struct super_block *sb, struct inode *i1,
 	if (!ret && i2)
 		ret = writeback_inode(i2);
 	if (!ret)
-		ret = sync_blockdev_nowait(sb->s_bdev);
+		ret = filemap_flush(sb->s_bdev_file->f_mapping);
 	return ret;
 }
 
-- 
2.34.1


