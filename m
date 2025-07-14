Return-Path: <linux-fsdevel+bounces-54872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 482ADB045F0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 18:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26D1C3B8486
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 16:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE3F25F97F;
	Mon, 14 Jul 2025 16:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e8Xzyxqq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686301D54EE
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 16:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752512115; cv=none; b=oFTFE8Vc2xkdFmd9kjYBSa5crnsHNVCuoUTB+qLy2z/o3E8hlX0XUv7j8RTcbkeX1bIU+cUPXC+/JTInN/Hgo5XORkFoAqB/VI6+WrVi7goK74Qmxky/I7HZqOo2ZxpBDpKcM+r7B+hE1KR1TEp4BoSAandPNnSymASIprZpvt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752512115; c=relaxed/simple;
	bh=y+GLaDL66C9VDwzymSD4abHaMrzJXLrblcxNy62FaDI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=brn6s56GAc/MtiwHXJzjcCBlGed/9QigrZP0/8XBPIX+7vXcZj3RL/LAn8xSs+4jaeKBDUJ6Ea1E8FNrUsSurrK01LHH2TuShuw903ZyLDL9CgdNET/FlFbPsuf1OGIa1QbR8Adq49was1K/9ePWFkQVBzLIzUQlZc2s6Uyi/e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e8Xzyxqq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752512112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5tU8Yu2IZNs4g5oOYPTSxj+GzwkJtimszh7lcPTSzY8=;
	b=e8XzyxqqshNkVBxy98MMbdDG3ITCPnB0pHuPTZEXdi6EoQ9Mzq0Gkz3AQnXlz6wKOaErTp
	UUFGStyAk7RH44PeIvK3Choay3dPokvNHX6HW4ALIbaFrYRbUAMVBxSzPsQoQ2IBWIyQn8
	Qf4RNn45l+bfalkaNZQifToOiARrcV8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-151-g_UeVYpgMja1uWKOiFfcfA-1; Mon,
 14 Jul 2025 12:55:05 -0400
X-MC-Unique: g_UeVYpgMja1uWKOiFfcfA-1
X-Mimecast-MFC-AGG-ID: g_UeVYpgMja1uWKOiFfcfA_1752512105
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E86361800290;
	Mon, 14 Jul 2025 16:55:04 +0000 (UTC)
Received: from b.redhat.com (unknown [10.42.28.125])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 297D13000198;
	Mon, 14 Jul 2025 16:55:02 +0000 (UTC)
From: Andrew Price <anprice@redhat.com>
To: agruenba@redhat.com
Cc: gfs2@lists.linux.dev,
	willy@infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] gfs2: Set .migrate_folio in gfs2_{rgrp,meta}_aops
Date: Mon, 14 Jul 2025 17:54:59 +0100
Message-ID: <20250714165459.54771-1-anprice@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Clears up the warning added in 7ee3647243e5 ("migrate: Remove call to
->writepage") that occurs in various xfstests, causing "something found
in dmesg" failures.

[  341.136573] gfs2_meta_aops does not implement migrate_folio
[  341.136953] WARNING: CPU: 1 PID: 36 at mm/migrate.c:944 move_to_new_folio+0x2f8/0x300

Signed-off-by: Andrew Price <anprice@redhat.com>
---
 fs/gfs2/meta_io.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index 9dc8885c95d07..66ee10929736f 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -103,6 +103,7 @@ const struct address_space_operations gfs2_meta_aops = {
 	.invalidate_folio = block_invalidate_folio,
 	.writepages = gfs2_aspace_writepages,
 	.release_folio = gfs2_release_folio,
+	.migrate_folio = buffer_migrate_folio_norefs,
 };
 
 const struct address_space_operations gfs2_rgrp_aops = {
@@ -110,6 +111,7 @@ const struct address_space_operations gfs2_rgrp_aops = {
 	.invalidate_folio = block_invalidate_folio,
 	.writepages = gfs2_aspace_writepages,
 	.release_folio = gfs2_release_folio,
+	.migrate_folio = buffer_migrate_folio_norefs,
 };
 
 /**
-- 
2.49.0


