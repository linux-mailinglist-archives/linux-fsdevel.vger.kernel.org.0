Return-Path: <linux-fsdevel+bounces-54232-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9784AFC4D4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 09:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29BEA4A2E6D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 07:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81B129C33B;
	Tue,  8 Jul 2025 07:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="qthWr76Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3AB29B797;
	Tue,  8 Jul 2025 07:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751961486; cv=none; b=dZOwhsKXjH1npExA2Ds7GVkc+sDBmp0QbKSc49EEf/1fY9mwhHGNrrVV2QN+jAsMvxlc9x5iOQ2CypklCT3vtl8U2fYTF71NfOTrqYOZUl8XRIBm69FI9DTPpFuwDGC0dHZT9IA4CX5gXjpLZcbm2ghi+Bts6X785OSgKXTA1M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751961486; c=relaxed/simple;
	bh=U1Ihyv6JEYMY+/2H63MoHcvRpy0YoqMTrtio+QfjEO4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GJp4blUmR3gSbE0mcVaLeCRQ31wmdn6Do3PbZ7bjn9H2pJDXu/i14tcly1qhUa3DuZXXUDbAqwxlvEIwWmXQj6tGxtQF3otCwIqE4hwEi2PyG7RP7iLY/Wz2LXm4tHy6Aput0gw1JmQACAoGNoe/DGsVl5MPU/PBZr/QZS7f6Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=qthWr76Q; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 447401CC;
	Tue,  8 Jul 2025 07:56:56 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=qthWr76Q;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 796F321ED;
	Tue,  8 Jul 2025 07:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1751961481;
	bh=8EzE0KyPCRoabRtPC3XYbwuX1/3nOaJPo5gc1Ts2SJc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=qthWr76QLibDRqGBdIM5JPOQcl47xXm44r0fL7nj8fR5Q+zwVe3Ei4kKRy1XUR2G9
	 4oOWw8VC72YhC93L8rsDd3d8JngmPK9S89A6GNNkD/CARH+ukDYhqOr9xuXCi9j8um
	 ZILPAGPEO+0DVtdV6ePVqURD/BX48iPI6P4BpvxQ=
Received: from localhost.localdomain (172.30.20.199) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 8 Jul 2025 10:57:59 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	<syzbot+a91fcdbd2698f99db8f4@syzkaller.appspotmail.com>, Lorenzo Stoakes
	<lorenzo.stoakes@oracle.com>
Subject: [PATCH v2] Revert "fs/ntfs3: Replace inode_trylock with inode_lock"
Date: Tue, 8 Jul 2025 09:57:09 +0200
Message-ID: <20250708075709.5688-1-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <d18a4aa3-bd7d-4c4b-a34c-48ba7f907ecf@lucifer.local>
References: <d18a4aa3-bd7d-4c4b-a34c-48ba7f907ecf@lucifer.local>
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

This reverts commit 69505fe98f198ee813898cbcaf6770949636430b.

Initially, conditional lock acquisition was removed to fix an xfstest bug
that was observed during internal testing. The deadlock reported by syzbot
is resolved by reintroducing conditional acquisition. The xfstest bug no
longer occurs on kernel version 6.16-rc1 during internal testing. I
assume that changes in other modules may have contributed to this.

Fixes: 69505fe98f19 ("fs/ntfs3: Replace inode_trylock with inode_lock")
Reported-by: syzbot+a91fcdbd2698f99db8f4@syzkaller.appspotmail.com
Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/file.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 65fb27d1e17c..2e321b84a1ed 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -322,7 +322,10 @@ static int ntfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 		}
 
 		if (ni->i_valid < to) {
-			inode_lock(inode);
+			if (!inode_trylock(inode)) {
+				err = -EAGAIN;
+				goto out;
+			}
 			err = ntfs_extend_initialized_size(file, ni,
 							   ni->i_valid, to);
 			inode_unlock(inode);
-- 
2.43.0


