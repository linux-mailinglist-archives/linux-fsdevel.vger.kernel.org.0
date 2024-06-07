Return-Path: <linux-fsdevel+bounces-21176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D79E790032F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 14:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64029B219C2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 12:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADCC19408A;
	Fri,  7 Jun 2024 12:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="TuFhbLCE";
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="u+COEebs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC370192B6A;
	Fri,  7 Jun 2024 12:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717762576; cv=none; b=NfOSDgjre2dyAuhrh86991Kk7zQ75RBPKpD+cK5ym07odV07WvNdz3fFtFB4kd7RdO/rHOswe6iQX9Q24C+9V3UlFTYfUY8kenbULQsgqFBVJbghyj65vbZ9rWgUl3DE1j+7KYi4X5oZwLWS6WdAktWyzsHrzrCpX6HZ639z/Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717762576; c=relaxed/simple;
	bh=bdc7v58U5+YV3a/IoeHMrgpoIua9Z6Fq3QWkfoSP3PU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=szl6aFqyco7UXYujHN4kzBk8nna/q83q3GD4sN/UtDznbCAOufvSFsW+D/Rza+BAg5RVGtgbMX36xNhltR70piFpVdi+ezcaDjl0Ov6CPfI7ZM1t+AcgL/VV+c/AaJ8UM9GVDl26c+ecdGc+2Tz7sCcQqwpZ4wYQs+6qIq0+CmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=TuFhbLCE; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=u+COEebs; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 4CF8A2117;
	Fri,  7 Jun 2024 12:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1717762098;
	bh=fGX3LJWvmJiBdb0H+MRYhaCDPeTRkfcYEhh/amy+hjk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=TuFhbLCE8i0x0ddVOmat7uFqkzGS1GP/vhjvUUXb8T0JwTUeqnl5RDYodMtIAxt/y
	 7+WrIzba4yyidYkLp27aOhJ/y3lYl/MYQMiOESUrkoxXlY8I6MeJDa4jpVCQ6I/+Ay
	 NECtFXXke3LKXmQ6yjz68kjZLDfOf2DJyPKcoYT8=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 30766195;
	Fri,  7 Jun 2024 12:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1717762572;
	bh=fGX3LJWvmJiBdb0H+MRYhaCDPeTRkfcYEhh/amy+hjk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=u+COEebs+OlPEuYDJfV+IZ+YkWEkhYSGN1h6Yh2mLjuGt+xqtS4WR18+DJu2Jmwfd
	 esTFccXsru7pGmrWK5vx9fQjCCI5+kf4jrIldSMVSHzeaUe8wJTmabruz+PWkbrzDu
	 VA3MdBremMERJ9/GeCCTibZFkl0kTWZxOOGn5HCc=
Received: from ntfs3vm.paragon-software.com (192.168.211.95) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 7 Jun 2024 15:16:11 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 07/18] fs/ntfs3: Add missing .dirty_folio in address_space_operations
Date: Fri, 7 Jun 2024 15:15:37 +0300
Message-ID: <20240607121548.18818-8-almaz.alexandrovich@paragon-software.com>
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

After switching from pages to folio [1], it became evident that
the initialization of .dirty_folio for page cache operations was missed for
compressed files.

[1] https://lore.kernel.org/ntfs3/20240422193203.3534108-1-willy@infradead.org

Fixes: 82cae269cfa95 ("fs/ntfs3: Add initialization of super block")
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 2a3522bbeeb4..d43a87a79ff2 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -2131,5 +2131,6 @@ const struct address_space_operations ntfs_aops = {
 const struct address_space_operations ntfs_aops_cmpr = {
 	.read_folio	= ntfs_read_folio,
 	.readahead	= ntfs_readahead,
+	.dirty_folio	= block_dirty_folio,
 };
 // clang-format on
-- 
2.34.1


