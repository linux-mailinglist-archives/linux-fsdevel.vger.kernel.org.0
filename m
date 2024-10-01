Return-Path: <linux-fsdevel+bounces-30459-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8FB98B802
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 11:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D13BC283E55
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 09:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776B019DF9A;
	Tue,  1 Oct 2024 09:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="mj9MBD6h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1821D19D09C;
	Tue,  1 Oct 2024 09:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727773872; cv=none; b=arW8xrsHOY2Nw2zhvwvfXL7GbqM5gXTPbNGowu0gg4EGtEhjdlio8xnXbuGop5xBPW3npkBdNyFW52AoF73MdBMLhiNnp5zqzfXcasozfK1JP0Uq1nAIzKWUz4tl+FhAwswYTjhvqlgdVKQP6SVwjBxRx2ovAbMoSGRRGOC6260=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727773872; c=relaxed/simple;
	bh=Aq8rlex9plu17O93Y02qKf6CqtUUO6dcSbSp3Q0dCkE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G8viWWHlXWv9AYHLOvRsTRblJ50EE/xA6Ix7NCttUDmRHGWlmgKsaKyY5mv4oJ0cHcA7FBgy72KpSLMj+GHpJuyYJgCZBoEPBMMVinGnLcRA+PzwOLulnGPiM+vssh8xh1ZwdbZ0uSi2l10G3VraKst2T6pYFcEH0FHqbgzvc8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=mj9MBD6h; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 94F3E21BA;
	Tue,  1 Oct 2024 08:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1727772833;
	bh=e/jxg4L2Jqrti7kGJ1jq2Z5/4N2btjuaQe4g4VrM1Fc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=mj9MBD6h6ylJa+2MoA2r/z3nZ4v8dD3WCyAuzerSCHad3rMphGpl6FCkR5yz5vH7Y
	 ckB8tfLyACTAIWZWql9ZylSwBV6ejH8XFWK+G3kPp/zUgLIW6CNCVk2pej/JTr6JAE
	 6bpqZUdR06vQdpiMWaU1Vr3/xdRo9fMh5xzOtzwM=
Received: from ntfs3vm.paragon-software.com (192.168.211.162) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 1 Oct 2024 12:01:27 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	<syzbot+9af29acd8f27fbce94bc@syzkaller.appspotmail.com>
Subject: [PATCH 4/6] fs/ntfs3: Fix general protection fault in run_is_mapped_full
Date: Tue, 1 Oct 2024 12:01:02 +0300
Message-ID: <20241001090104.15313-5-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001090104.15313-1-almaz.alexandrovich@paragon-software.com>
References: <20241001090104.15313-1-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

Fixed deleating of a non-resident attribute in ntfs_create_inode()
rollback.

Reported-by: syzbot+9af29acd8f27fbce94bc@syzkaller.appspotmail.com
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/inode.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 81746a959b47..5dc261404957 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -1718,7 +1718,10 @@ int ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
 	attr = ni_find_attr(ni, NULL, NULL, ATTR_EA, NULL, 0, NULL, NULL);
 	if (attr && attr->non_res) {
 		/* Delete ATTR_EA, if non-resident. */
-		attr_set_size(ni, ATTR_EA, NULL, 0, NULL, 0, NULL, false, NULL);
+		struct runs_tree run;
+		run_init(&run);
+		attr_set_size(ni, ATTR_EA, NULL, 0, &run, 0, NULL, false, NULL);
+		run_close(&run);
 	}
 
 	if (rp_inserted)
-- 
2.34.1


