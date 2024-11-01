Return-Path: <linux-fsdevel+bounces-33461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AA89B9112
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 13:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B79D428333E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 12:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9A819DF41;
	Fri,  1 Nov 2024 12:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asahilina.net header.i=@asahilina.net header.b="xNoiSdfS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B47C13C;
	Fri,  1 Nov 2024 12:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.63.210.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730463774; cv=none; b=M+V1l4ES+VvonFDxXBIpzTfe+XZsN7sbOOjg6xw0eRxL9ZTVmOn2Ef4OpiGD/hgjRMpWNSTnMtnYXDmHAS0m4y57yQEvXDA4ILtlvN7Ryex2rma0yJ1ur7PHMF2J4b//S4xThBH9CMeO+QjwprpWDxaJKf1yJ9W1tMDxoeC04NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730463774; c=relaxed/simple;
	bh=/TA+HIVRRCw8dKJUti+Jl47C1Bz15V0Orwm12b4BAQo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OibAUpu0koSHLcpM9Gjk6kgTw9yvNRzCJVFKPSVIggDPFKktXJLoi8d3+TT9Ff/Uk3fiBBbtOjZ9+8xw44bgL0NnAl1008T0uykdnZmPpbM9OjYVFni5ZEvC1NQf+OBXhaKOPT3UXj/26Og8EaBuHSjInKr81l05LKTKvEPnpZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asahilina.net; spf=pass smtp.mailfrom=asahilina.net; dkim=pass (2048-bit key) header.d=asahilina.net header.i=@asahilina.net header.b=xNoiSdfS; arc=none smtp.client-ip=212.63.210.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asahilina.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asahilina.net
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sendonly@marcansoft.com)
	by mail.marcansoft.com (Postfix) with ESMTPSA id 0025F432AE;
	Fri,  1 Nov 2024 12:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
	s=default; t=1730463768;
	bh=/TA+HIVRRCw8dKJUti+Jl47C1Bz15V0Orwm12b4BAQo=;
	h=From:Date:Subject:To:Cc;
	b=xNoiSdfS611jDnBHnoMcOBL5g9pU7Hl804x7mbaxffwGon4vQUVIfWf0f7zhxFKMo
	 fyhJ5KLUy5siPpuOYs17FeECUzvgzfo4oIM9iyj0ViDVirwvZQUkrA17MyzmJXeTD2
	 dmu7p+ExDLVOHgdEKNh7x0eCYWudlP8A0em5V+qaxSLN+ZLji3jHz54tisc4Tjf/2p
	 Cn+rs1gFwvYCaz/+MnVh9nTGYlhpdOBiP17NdALfj4xPnvdr8Tg0V+pBQ1dC03/rfS
	 Lj+ueaf2BNjR+fVuCLRtfYreV3k2TK/TtGNkIwYZXglkw8hTWxHtkH29cFoa1QuWP3
	 u61x5um0uKguA==
From: Asahi Lina <lina@asahilina.net>
Date: Fri, 01 Nov 2024 21:22:31 +0900
Subject: [PATCH] dax: Allow block size > PAGE_SIZE
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241101-dax-page-size-v1-1-eedbd0c6b08f@asahilina.net>
X-B4-Tracking: v=1; b=H4sIAAbIJGcC/x2MQQqAIBAAvyJ7TnBTKPpKdNDcai8mCiGJf086z
 sBMhUyJKcMiKiR6OPMdOuAgYL9sOEmy7wyjGg2iQultkdF2n/klOWuLatLOEDroTUx0cPl/69b
 aB5XInvBfAAAA
X-Change-ID: 20241101-dax-page-size-83a1073b4e1b
To: Dan Williams <dan.j.williams@intel.com>, 
 Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>
Cc: Sergio Lopez Pascual <slp@redhat.com>, linux-fsdevel@vger.kernel.org, 
 nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org, asahi@lists.linux.dev, 
 Asahi Lina <lina@asahilina.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730463767; l=1369;
 i=lina@asahilina.net; s=20240902; h=from:subject:message-id;
 bh=/TA+HIVRRCw8dKJUti+Jl47C1Bz15V0Orwm12b4BAQo=;
 b=sme8DUTSaze8Opt4hubzoO/tMB7K2MMTGXJNmRMpSSZwtZbnDp236oTHUIuMtt0wgQmzowHlX
 0ZM9LKYWCV6CcgFSXnPTS8pR4ZWkuJQwC/gZWnNoAcAfqUUxKU671+O
X-Developer-Key: i=lina@asahilina.net; a=ed25519;
 pk=tpv7cWfUnHNw5jwf6h4t0gGgglt3/xcwlfs0+A/uUu8=

For virtio-dax, the file/FS blocksize is irrelevant. FUSE always uses
large DAX blocks (2MiB), which will work with all host page sizes. Since
we are mapping files into the DAX window on the host, the underlying
block size of the filesystem and its block device (if any) are
meaningless.

For real devices with DAX, the only requirement should be that the FS
block size is *at least* as large as PAGE_SIZE, to ensure that at least
whole pages can be mapped out of the device contiguously.

Fixes warning when using virtio-dax on a 4K guest with a 16K host,
backed by tmpfs (which sets blksz == PAGE_SIZE on the host).

Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 fs/dax.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dax.c b/fs/dax.c
index c62acd2812f8d4981aaba82acfeaf972f555362a..406fb75bdbe9d17a6e4bf3d4cb92683e90f05910 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1032,7 +1032,7 @@ int dax_writeback_mapping_range(struct address_space *mapping,
 	int ret = 0;
 	unsigned int scanned = 0;
 
-	if (WARN_ON_ONCE(inode->i_blkbits != PAGE_SHIFT))
+	if (WARN_ON_ONCE(inode->i_blkbits < PAGE_SHIFT))
 		return -EIO;
 
 	if (mapping_empty(mapping) || wbc->sync_mode != WB_SYNC_ALL)

---
base-commit: 81983758430957d9a5cb3333fe324fd70cf63e7e
change-id: 20241101-dax-page-size-83a1073b4e1b

Cheers,
~~ Lina


