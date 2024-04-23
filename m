Return-Path: <linux-fsdevel+bounces-17461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8753D8ADD9E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 08:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B90811C21419
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 06:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71E52556E;
	Tue, 23 Apr 2024 06:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="ICQGqULk";
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="ruEYtP5K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D8023759;
	Tue, 23 Apr 2024 06:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713854705; cv=none; b=mFgp0k8RI3qxnrrgJYDsHBR27AfeVVXkd5zJKT0iq1i2gltaoXybNMHyd3l7H0tw9eazwlhH7Rw33yliVgO7EhsVFABVEsNQPRNID4Zwha/TP6UM7NB6g5P6kTGlDLBV1UDOX/5Rps/I4OIK+vPV4aZw4YbhPAKjHOs8V1rCN6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713854705; c=relaxed/simple;
	bh=IulC/ATCcoLSPdrAFZWg4ug+gueZGiT3MDCm8W28Vq4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nYWO049WV3v6Mn7ckYVKUXS5jGoiT/wxfl3/QBy1WT9uLGsuORTkjtnCetk69CwksusSgnI0dqvt3im5kYDbyqY4xF1cOCI40x56gQHUddJQFG4QmZenAnbJD5UqL2sEtd055Cli2jb1HUAgyUyak1CPm95hAbNWEbprPkvX2IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=ICQGqULk; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=ruEYtP5K; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id F0E1A1F9F;
	Tue, 23 Apr 2024 06:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1713854250;
	bh=/TmnypWkd4e3Jhx5tOr+iDQBILNtv2PoZ4t0EcJVSoU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ICQGqULkaNxoyW/vsSSM0bDRfeoBUrvhe1+0wFfTniVC/RD0kNFd/DVFXTTH5Q2Ak
	 1S+htBAhy5rYjEGbPhc3r4CppR0KHfGGipXJ4mO3EggWdsYFxTV9VP6BpJS9BCbRdJ
	 K5wcnSqw/dfsHpqHw/F0s3zQ9gQqJwm4y80xLzhU=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 7D586214E;
	Tue, 23 Apr 2024 06:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1713854701;
	bh=/TmnypWkd4e3Jhx5tOr+iDQBILNtv2PoZ4t0EcJVSoU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ruEYtP5KTnM9ENk7pIrTbcCP1UEBEZtUYc18eQNB3NxxWncVAX8GMbmufjMFo3IcY
	 TrEHwi/CFrRfoz93Z0ZeQ48RHDKC7ty3lC4nS3lqPgEKS4D7dmniDJIFftWOeCon1B
	 jWgddj2W/WAW9P2MUxe6Uhb42EosgJfZ6JYU4ZlY=
Received: from ntfs3vm.paragon-software.com (192.168.211.160) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 23 Apr 2024 09:45:00 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	<stable@vger.kernel.org>
Subject: [PATCH 1/9] fs/ntfs3: Taking DOS names into account during link counting
Date: Tue, 23 Apr 2024 09:44:20 +0300
Message-ID: <20240423064428.8289-2-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423064428.8289-1-almaz.alexandrovich@paragon-software.com>
References: <20240423064428.8289-1-almaz.alexandrovich@paragon-software.com>
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

When counting and checking hard links in an ntfs file record,

  struct MFT_REC {
    struct NTFS_RECORD_HEADER rhdr; // 'FILE'
    __le16 seq;		    // 0x10: Sequence number for this record.
>>  __le16 hard_links;	// 0x12: The number of hard links to record.
    __le16 attr_off;	// 0x14: Offset to attributes.
  ...

the ntfs3 driver ignored short names (DOS names), causing the link count
to be reduced by 1 and messages to be output to dmesg.

For Windows, such a situation is a minor error, meaning chkdsk does not report
errors on such a volume, and in the case of using the /f switch, it silently
corrects them, reporting that no errors were found. This does not affect
the consistency of the file system.

Nevertheless, the behavior in the ntfs3 driver is incorrect and
changes the content of the file system. This patch should fix that.

PS: most likely, there has been a confusion of concepts
MFT_REC::hard_links and inode::__i_nlink.

Fixes: 82cae269cfa95 ("fs/ntfs3: Add initialization of super block")
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: stable@vger.kernel.org
---
 fs/ntfs3/inode.c  |  7 ++++---
 fs/ntfs3/record.c | 11 ++---------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index eb7a8c9fba01..05f169018c4e 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -37,7 +37,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 	bool is_dir;
 	unsigned long ino = inode->i_ino;
 	u32 rp_fa = 0, asize, t32;
-	u16 roff, rsize, names = 0;
+	u16 roff, rsize, names = 0, links = 0;
 	const struct ATTR_FILE_NAME *fname = NULL;
 	const struct INDEX_ROOT *root;
 	struct REPARSE_DATA_BUFFER rp; // 0x18 bytes
@@ -200,11 +200,12 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 		    rsize < SIZEOF_ATTRIBUTE_FILENAME)
 			goto out;
 
+		names += 1;
 		fname = Add2Ptr(attr, roff);
 		if (fname->type == FILE_NAME_DOS)
 			goto next_attr;
 
-		names += 1;
+		links += 1;
 		if (name && name->len == fname->name_len &&
 		    !ntfs_cmp_names_cpu(name, (struct le_str *)&fname->name_len,
 					NULL, false))
@@ -429,7 +430,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 		ni->mi.dirty = true;
 	}
 
-	set_nlink(inode, names);
+	set_nlink(inode, links);
 
 	if (S_ISDIR(mode)) {
 		ni->std_fa |= FILE_ATTRIBUTE_DIRECTORY;
diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index 6aa3a9d44df1..6c76503edc20 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -534,16 +534,9 @@ bool mi_remove_attr(struct ntfs_inode *ni, struct mft_inode *mi,
 	if (aoff + asize > used)
 		return false;
 
-	if (ni && is_attr_indexed(attr)) {
+	if (ni && is_attr_indexed(attr) && attr->type == ATTR_NAME) {
 		u16 links = le16_to_cpu(ni->mi.mrec->hard_links);
-		struct ATTR_FILE_NAME *fname =
-			attr->type != ATTR_NAME ?
-				NULL :
-				resident_data_ex(attr,
-						 SIZEOF_ATTRIBUTE_FILENAME);
-		if (fname && fname->type == FILE_NAME_DOS) {
-			/* Do not decrease links count deleting DOS name. */
-		} else if (!links) {
+		if (!links) {
 			/* minor error. Not critical. */
 		} else {
 			ni->mi.mrec->hard_links = cpu_to_le16(links - 1);
-- 
2.34.1


