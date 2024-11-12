Return-Path: <linux-fsdevel+bounces-34390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3040E9C4E62
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 06:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA86128447E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 05:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D46209F29;
	Tue, 12 Nov 2024 05:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DKj5KCPi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FFC1A3BDA
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 05:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731390252; cv=none; b=fvHwlo5YQzwQ65XZU6IravzAEfpdV7Vx7KxhQqTYzDgYcbu+8+fu8paLe4EByE0V+iv/LfuUyATI3HFnPee3+EZZ8Bm3zUd233+pn9ntva6TJhhLgS87iJabCClWodBYNPa63FTQOKSBb5C3WDDCupK3Lt4rH0cgKCYwOiKg2k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731390252; c=relaxed/simple;
	bh=oMPqhiRxOS6+1RGsJhc1hEyHSZG1fleVLuk9IYZwgr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NC80h7jSWRg0DLz0OEljF2h3nW8Yx178eHiSwPCpvQXyzRg2u7wojzyEGjDhsAyQQNBzI+AE1ZpyR1CM2BKTHekmHhMOKE95z4JnszCxhsZ4a2XDnC1kaF63YTao5VyO8XtkY6ZVjJra+Zbmji5x0MS4M4c4Djzh9KuRe4N35d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DKj5KCPi; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=nhXVlUGnvwLlrdmqkdk2gIbhddPQXqFcNJvuAIHGsLY=; b=DKj5KCPi5dB8085dJkW77ag4zZ
	E5VRdp3+R0IwZB/a78rHnVJ8u03zqPm6TqPlKmDf1xtUml3mk1PwFusWc3zZB5EdPCxk4e4t7N8KG
	MVH9ewpfV1tZIv6zwfRLp/TUlQ1pxpbJcFHxsTuw4adXt8EcfGJGJ/FTIYkK//kv0bz5ub0hO1zVi
	+p0RKdbvFCoxTUrq/c7q+/rqqXKY0c8/lMbIg9id0AHmmHRFggePjyi620Nj7xDXwuf/Poj/jPh1E
	ydCEn37ck7Tne8CC/FYLWfuwUyr8UIkXEAVbhSI4I0v1Vpo0Vymjnj/4FHSnwyKIj+3018owibo4E
	HIDnfj4w==;
Received: from 2a02-8389-2341-5b80-9a3d-4734-1162-bba0.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:9a3d:4734:1162:bba0] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tAjhC-00000002HQj-03Eh;
	Tue, 12 Nov 2024 05:44:10 +0000
From: Christoph Hellwig <hch@lst.de>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] writeback: add a __releases annoation to wbc_attach_and_unlock_inode
Date: Tue, 12 Nov 2024 06:43:54 +0100
Message-ID: <20241112054403.1470586-2-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241112054403.1470586-1-hch@lst.de>
References: <20241112054403.1470586-1-hch@lst.de>
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
Reviewed-by: Jan Kara <jack@suse.cz>
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


