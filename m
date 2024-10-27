Return-Path: <linux-fsdevel+bounces-33022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0759B1D7C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Oct 2024 12:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83242B21099
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Oct 2024 11:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF3A15442D;
	Sun, 27 Oct 2024 11:43:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869CF14A09A;
	Sun, 27 Oct 2024 11:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730029429; cv=none; b=ef12hk734wyDNmTLyLZxqK4AvXlrSascw9qFc546X6ZLy6UywFvuT3+K3k5qaag6y0ucsySZrABJC9bELgd7T4BvQvgaqHNyg/ns113AnVs5E4RpIofOl0+BcfvNL1MZew4bGxnU5hWFcthC5+xXmTbGWurpNoZlzXvtaqyzaP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730029429; c=relaxed/simple;
	bh=VhaA53Zp+2mrXZXUnUwu3gnRPns6El5q4T/OURux8kQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SMElyFJDnOwoRY8dnIQfHUD2ag4nhua9YBkM3APAB57ExFbTliPi7TbPtR+lAMISrdLHIO7w/i/es/SELICpxCV2ne/+xVL2ZX0o1VobH0/ywLygGpPrN8Jh5a+d674kWlNlaalwz/oDbK57buDuue7DsS0tKP7bt7d8sBGgWfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id EF5A4435C4;
	Sun, 27 Oct 2024 12:43:37 +0100 (CET)
From: Christian Ebner <c.ebner@proxmox.com>
To: dhowells@redhat.com,
	jlayton@kernel.org,
	stable@vger.kernel.org
Cc: netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Ebner <c.ebner@proxmox.com>
Subject: [PATCH stable 6.11.y] netfs: reset subreq->iov_iter before netfs_clear_unread() tail clean
Date: Sun, 27 Oct 2024 12:43:15 +0100
Message-Id: <20241027114315.730407-1-c.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes file corruption issues when reading contents via ceph client.

Call netfs_reset_subreq_iter() to align subreq->io_iter before
calling netfs_clear_unread() to clear tail, as subreq->io_iter count
and subreq->transferred might not be aligned after incomplete I/O,
having the subreq's NETFS_SREQ_CLEAR_TAIL set.

Based on ee4cdf7b ("netfs: Speed up buffered reading"), which
introduces a fix for the issue in mainline.

Fixes: 92b6cc5d ("netfs: Add iov_iters to (sub)requests to describe various buffers")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219237
Signed-off-by: Christian Ebner <c.ebner@proxmox.com>
---
Sending this patch in an attempt to backport the fix introduced by
commit ee4cdf7b ("netfs: Speed up buffered reading"), which however
can not be cherry picked for older kernels, as the patch is not
independent from other commits and touches a lot of unrelated (to
the fix) code.

 fs/netfs/io.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/netfs/io.c b/fs/netfs/io.c
index d6ada4eba744..500119285346 100644
--- a/fs/netfs/io.c
+++ b/fs/netfs/io.c
@@ -528,6 +528,7 @@ void netfs_subreq_terminated(struct netfs_io_subrequest *subreq,
 
 incomplete:
 	if (test_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags)) {
+		netfs_reset_subreq_iter(rreq, subreq);
 		netfs_clear_unread(subreq);
 		subreq->transferred = subreq->len;
 		goto complete;
-- 
2.39.5



