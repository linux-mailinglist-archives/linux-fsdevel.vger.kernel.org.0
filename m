Return-Path: <linux-fsdevel+bounces-30451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BA498B7D0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 11:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C82E4B25F42
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 09:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5BF19D09B;
	Tue,  1 Oct 2024 09:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="CeRRCjfZ";
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="EoPstPcs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BF419ABCB;
	Tue,  1 Oct 2024 09:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727773296; cv=none; b=XHCz6ghuIkGj4ONj9o2JjV8a5DJEDKC8yFn4vVbyYIJMsSZhCtjuCBXDXXPjiHjOn1vl+T6155YzxAISpx3LddR8E87/UwLFWgpRa6384Jll9LKwEzyvyrLhjQCsUWYvWboDQe83p/cgslJ3lNEnYQpY228RrW2rTvXnhFqLFWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727773296; c=relaxed/simple;
	bh=qWjK1RsYyKSUzUBD+yADyl36UD/grgHqx9G+jDdtfTw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DVnRqae6Q0EwyYN+AgH8sG25Vz9w1bkXHaAJlgp5jfgQKR9IqwnlRo2X7mhoOIjqTBsMGI0BPOyeacBFaJSKv4UB1WDw91jv1CM4az6KubRyi511aRQ8BhvjlxLeOtKa9GwPyBZqCuWxeDCT5GGclIk9JIICxOS6XsEkiLkI0IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=CeRRCjfZ; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=EoPstPcs; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 7B57C21BC;
	Tue,  1 Oct 2024 08:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1727772834;
	bh=jlLbgdrAfNBCBg4R6vHQVbLSiuo7T5iPhjtMGiclWGM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=CeRRCjfZzk2Ad3xaHUT7Su/DgIFcCYGDAF/u4VnXHHCAZKzdAYmzJAKsZf/HitWBC
	 tK5DhdMMGOwFH2M42QdHVQOnzURC38szVhT2MRdZCLF2Kfu4VqBEmwv9RPp57QI9Bi
	 61HVMOvXit6m/zsjdzZsisNiMllfpSie+oYO5mJw=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 2A9DD21F1;
	Tue,  1 Oct 2024 09:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1727773288;
	bh=jlLbgdrAfNBCBg4R6vHQVbLSiuo7T5iPhjtMGiclWGM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=EoPstPcsAfFq5iDPvzGV0uNhZ84UO8sizoPpH7OfPq03zCeaTK0suh4mLRBuZBjo9
	 oYglpsHbzwx7kljUDHauMtXwbWwsNKtORuqC0IZrQtXOqjb+ey+rZG3b6uaX+E3KWQ
	 XaR0GNZrxRqhH2uCW1MH6Vmqh1sm8ozhauF9OrHA=
Received: from ntfs3vm.paragon-software.com (192.168.211.162) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 1 Oct 2024 12:01:27 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	<syzbot+8c652f14a0fde76ff11d@syzkaller.appspotmail.com>
Subject: [PATCH 5/6] fs/ntfs3: Additional check in ntfs_file_release
Date: Tue, 1 Oct 2024 12:01:03 +0300
Message-ID: <20241001090104.15313-6-almaz.alexandrovich@paragon-software.com>
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

Reported-by: syzbot+8c652f14a0fde76ff11d@syzkaller.appspotmail.com
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/file.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 4fdcb5177ea1..eb935d4180c0 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -1314,7 +1314,14 @@ static int ntfs_file_release(struct inode *inode, struct file *file)
 	/* If we are last writer on the inode, drop the block reservation. */
 	if (sbi->options->prealloc &&
 	    ((file->f_mode & FMODE_WRITE) &&
-	     atomic_read(&inode->i_writecount) == 1)) {
+	     atomic_read(&inode->i_writecount) == 1)
+	   /*
+	    * The only file when inode->i_fop = &ntfs_file_operations and
+	    * init_rwsem(&ni->file.run_lock) is not called explicitly is MFT.
+	    *
+	    * Add additional check here.
+	    */
+	    && inode->i_ino != MFT_REC_MFT) {
 		ni_lock(ni);
 		down_write(&ni->file.run_lock);
 
-- 
2.34.1


