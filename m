Return-Path: <linux-fsdevel+bounces-33866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 026AD9BFF05
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 08:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 348171C214BF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 07:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9393197A9F;
	Thu,  7 Nov 2024 07:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="v8SApLJa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98671957E2
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Nov 2024 07:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730964403; cv=none; b=GSIQSq2GJedb9aeTOwSSIamLLW+Bbepbpg6rsJoUNRRz+gNUCsv2qGq9jSQ6UqngqsDcyo4ipgar+sTegN5c/0acALFIU5LFmj0aNwdxlU2Xwl3FauOI+N/EUrzGnqGE5JOwJUF9dgFgsh3IwANfXo4Q6D3H5HOAbk+lwf4va6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730964403; c=relaxed/simple;
	bh=74vwiq/BlGDI9n27JKVFrzdZk+YHS28VLkgr8+t+cRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HF+jyWvfb8XwFujzSnIB1QrZXL0Xe1Z7IQ3Zimrom3CmSyVqi4+QMTJ3Zu0ZxlOAg2oEypI4cqyVFzdo9mbnVDVj5Ms3lovGoKeF/j+zgnJsYjhWS/bz0IAlSAXjn7lztqt/u6/c7XjOcY2vvEtRLgnjZ1F/BjEfd1AEbbawIBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=v8SApLJa; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Dz1X2tJ71Gp213qZvnK6zAlASTYmQFcawsayGG9EXXY=; b=v8SApLJa5h7WuoFyJmgQODao+M
	QjAPqVgQ5jzIiSwdPB/HaVNBBkX/fdOGFhYZjCrMClSK6+8naNvle/BWwJWZjW7SylWrkWnu5BGjg
	i1ZFHOzccX3FSMAttt8WCypN5miE/pLefSH+XiF+ZhziVzFyE5X6uBQJyZUJbOuvX/erhi+f/K3Z6
	xBtPY6dRVo/aa780PtTUYIrkVTYXlJ5QiyBSLxJ1Zki6URzpP9+lpEGkfwLIM3SVA2ncf0n/xS77X
	8rikqV/TGhTeseie/9eqyizykiHJSlUpYZCZ1zT5VMivOQBMy99t17RJQ5mmsIVKIG6twDS+ys6oS
	KBbmpzAA==;
Received: from 213-147-165-243.nat.highway.webapn.at ([213.147.165.243] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t8wue-00000005z7Z-2y46;
	Thu, 07 Nov 2024 07:26:41 +0000
From: Christoph Hellwig <hch@lst.de>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] writeback: add a __releases annoation to wbc_attach_and_unlock_inode
Date: Thu,  7 Nov 2024 07:26:18 +0000
Message-ID: <20241107072632.672795-2-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241107072632.672795-1-hch@lst.de>
References: <20241107072632.672795-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

This shuts up a sparse lock context tracking warning.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/fs-writeback.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index d8bec3c1bb1f..3fb115ae44b1 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -733,6 +733,7 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
  */
 void wbc_attach_and_unlock_inode(struct writeback_control *wbc,
 				 struct inode *inode)
+	__releases(&inode->i_lock)
 {
 	if (!inode_cgwb_enabled(inode)) {
 		spin_unlock(&inode->i_lock);
-- 
2.45.2


