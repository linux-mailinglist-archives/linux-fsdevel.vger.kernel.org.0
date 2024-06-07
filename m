Return-Path: <linux-fsdevel+bounces-21175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4C490032C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 14:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9ED1283519
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 12:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D64819307F;
	Fri,  7 Jun 2024 12:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="H+8aHVOb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5EC15B0F8;
	Fri,  7 Jun 2024 12:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717762575; cv=none; b=NAGuiLOd+kmys8ue6NHWHxTH/KlmMpWmpqCZPz9o+26J1P8/ea9PqleVG+Is1Bl4dtecbMobUybaxaig/PfX2U4ha3eVwPCT6p6T2NhMa8A1JXrsP7Lebqz/uYaMcQE6xSOsgZsHWCNk4E4lFKLiU04WiHtracTsFpyQG9KThmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717762575; c=relaxed/simple;
	bh=39brRrOkSyHjVx1NS6TpkELccKG+ycIqjB0w7/UFVLY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XSTl+H6s1aQXPuh1TQSyzKDh2Qskvtw/SKVPIU2QGPDfoDXoI+KZuehdmoYwb9km6UTKEQYt8rSSHFKU9ECbgX/rjVYoLpohlqbX2WJiVzwWFnXLylzFy7idMZ9h60wa2qjlGDY6tHncooANlvdknL1TzPZu5suICegfycxMlf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=H+8aHVOb; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 3E1C22113;
	Fri,  7 Jun 2024 12:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1717762097;
	bh=aobg9M4myEoXktEVGRM+0xcAgpfxxQ9zjd9s/UmvLs8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=H+8aHVObd4lXT/Ta5dL1HBTR62lfD7fXbTMCZarCqU3cCUc04ASL60LAzRYbFYbcv
	 YjKLZtpVFiz20lHjcUHzo8J81EkJ3JABZ2cjbuo5FsABbC5/H08G0IlSV0h6y8GT5/
	 Io8IyTG7F3xx5C5uQmy5Ia8K4vzZZJn5znp7M3ds=
Received: from ntfs3vm.paragon-software.com (192.168.211.95) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 7 Jun 2024 15:16:10 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 06/18] fs/ntfs3: Fix getting file type
Date: Fri, 7 Jun 2024 15:15:36 +0300
Message-ID: <20240607121548.18818-7-almaz.alexandrovich@paragon-software.com>
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

An additional condition causes the mft record to be read from disk
and get the file type dt_type.

Fixes: 22457c047ed97 ("fs/ntfs3: Modified fix directory element type detection")
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/dir.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
index 1937e8e612f8..858efe255f6f 100644
--- a/fs/ntfs3/dir.c
+++ b/fs/ntfs3/dir.c
@@ -326,7 +326,8 @@ static inline int ntfs_filldir(struct ntfs_sb_info *sbi, struct ntfs_inode *ni,
 	 * It does additional locks/reads just to get the type of name.
 	 * Should we use additional mount option to enable branch below?
 	 */
-	if ((fname->dup.fa & FILE_ATTRIBUTE_REPARSE_POINT) &&
+	if (((fname->dup.fa & FILE_ATTRIBUTE_REPARSE_POINT) ||
+	     fname->dup.ea_size) &&
 	    ino != ni->mi.rno) {
 		struct inode *inode = ntfs_iget5(sbi->sb, &e->ref, NULL);
 		if (!IS_ERR_OR_NULL(inode)) {
-- 
2.34.1


