Return-Path: <linux-fsdevel+bounces-30461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2EA98B807
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 11:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1717E1C22056
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 09:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593EF19F11A;
	Tue,  1 Oct 2024 09:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="FBFjD67p";
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="jsfhYNx2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0896F19D090;
	Tue,  1 Oct 2024 09:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727773873; cv=none; b=mFmu4qHC2Fosc5M9qUJ1EhQvf1pFo3TqWKeJGHkYnnVV9HC9JrN8hoFyivs8jMa0H5QIZECm8TSZ/T0giRH09qReRpMhLCJ9qX/bVy/DDyIyBtc5vJaTg2iwYuORmxO+wKwWQW4FUSiYtu5qxXS88+JSvdafR2nN+KHYLAxdmI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727773873; c=relaxed/simple;
	bh=lAKuALHKzZtCcrl0kxZtaUCqo8Eoo6FfNB9E6g7p9TE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UexltbP/owy4HYRnyAHoiF1G+lQ90dD5ha+FJ7VZLoFM09EnT8MNlG8yPDkeApNDWPE1UWioUQXVnrZPmbU1Jevp51Yh/grJOY+eA/Dson7XO1UFH2zp6de6I5fhpMj72in/GvgYO42eY1tGP5SJMSYqQNvX1wWl8BqxK4loDAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=FBFjD67p; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=jsfhYNx2; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id C1F8121B8;
	Tue,  1 Oct 2024 08:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1727772832;
	bh=oUMBbVWITqGhjFAASrazf2BjnWcJotBaiYZTDmTKvVE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=FBFjD67p/ezfyu4CI8p+fCmvNF6BD7FUWkcLzuppKutWdlPL9ooDx6UqgxFMzgXYo
	 gFocO3Xpar52HzqbGCGM4U1zog1zfgMfjJGMiEG9ns3VZlM1nV9aeeYLVbvfmXoTRo
	 gGTI1aMQgg2BYe9FsEjGuQ6NfVipUcTsKuSh/5wE=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 7238C21F1;
	Tue,  1 Oct 2024 09:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1727773286;
	bh=oUMBbVWITqGhjFAASrazf2BjnWcJotBaiYZTDmTKvVE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=jsfhYNx20aZJOkM6hxkmIzdlDPkZIYLfv2/VLc/JgGySYioVvaISSP/h6QRGCcAgq
	 7AlDZzhHFBxco9cOrvDB3faENsBg+WOdplgmsitqaSZ9Gq4gSCIlkeq/Kq29kp+rjb
	 ZgcsbpRJAzY8y8SPbxEwkka1vBjNJC6boVHRFjvM=
Received: from ntfs3vm.paragon-software.com (192.168.211.162) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 1 Oct 2024 12:01:25 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	<syzbot+3bfd2cc059ab93efcdb4@syzkaller.appspotmail.com>
Subject: [PATCH 2/6] fs/ntfs3: Additional check in ni_clear()
Date: Tue, 1 Oct 2024 12:01:00 +0300
Message-ID: <20241001090104.15313-3-almaz.alexandrovich@paragon-software.com>
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

Checking of NTFS_FLAGS_LOG_REPLAYING added to prevent access to
uninitialized bitmap during replay process.

Reported-by: syzbot+3bfd2cc059ab93efcdb4@syzkaller.appspotmail.com
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/frecord.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 7d4e54161291..41c7ffad2790 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -102,7 +102,9 @@ void ni_clear(struct ntfs_inode *ni)
 {
 	struct rb_node *node;
 
-	if (!ni->vfs_inode.i_nlink && ni->mi.mrec && is_rec_inuse(ni->mi.mrec))
+	if (!ni->vfs_inode.i_nlink && ni->mi.mrec &&
+	    is_rec_inuse(ni->mi.mrec) &&
+	    !(ni->mi.sbi->flags & NTFS_FLAGS_LOG_REPLAYING))
 		ni_delete_all(ni);
 
 	al_destroy(ni);
-- 
2.34.1


