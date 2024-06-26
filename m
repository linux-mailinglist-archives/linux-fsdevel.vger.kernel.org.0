Return-Path: <linux-fsdevel+bounces-22493-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D699F918128
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 14:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81F061F23CD2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 12:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4431822DC;
	Wed, 26 Jun 2024 12:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="n7uEK5v7";
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="m65lEN10"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C9517D8A3;
	Wed, 26 Jun 2024 12:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719405798; cv=none; b=CUyk0dBwrVtYEKK9qjLAN95T/h+qqlrgKHdwta0LS/a0QPQJ/pgccFeI60M0W62W/35zx9z97NP6tZByPt5w3y3hdY39KClk7aUCDZC7a0FBT4A9+WQp1h3As8bjHEd8LuSICK/iZs+1VeHdpUWL4WCDHLCkeBrCTa/uPNwwwXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719405798; c=relaxed/simple;
	bh=kz1EypB+DZnML6sUC0srknCPoYRu8kj6ZJcRPuxb73w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CdIRcg0ysu+WimrlbpzQEwdcjszdYQHk6X00J8hgWTuRyzprudeabCjSFysaPDDeBxDIfm0hetIXG5QIZ5nJOTCl/sjI7q9BhWauxvwxXZj4Cua62zuJwkFoN+9k1GMKdL2x6FHavLaiVykcO+kGABC1G7gFCA8At0Fs4KWBUE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=n7uEK5v7; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=m65lEN10; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id BB1DB217F;
	Wed, 26 Jun 2024 12:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1719405306;
	bh=zY8u7c6UWJRxlL22qEEciC7s/iWC6LhTY2LBY6749MY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=n7uEK5v7P6WT1Wv1A7fEQMk+KrAt5OstcFhjsq+rDtu5F+Drubkg08AK6LtQxZkh9
	 TMF+vpyW2B1L0lYpW2wzSLo1Iq3Z3MUKAQcGutmJGo//uoleQ43eBIOYWQ04iJaB8R
	 mfV9HaMJwb/tPd5xy4CLL9oXjFEsACbyZBrNSNhE=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id E8F9E3E3;
	Wed, 26 Jun 2024 12:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1719405789;
	bh=zY8u7c6UWJRxlL22qEEciC7s/iWC6LhTY2LBY6749MY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=m65lEN10mSwEYedC5K4rnVNwjU48sAiVNNLcEONuBuBqq6mKCc2qSDkY2/MGL2rnC
	 oDFcau0/HGx3CDj4j5UUrX1DBGMKbJLEAay57Cv6htSy8UWvHuTZ8FN518tMQfJUP5
	 noaKUyJrjfEoae7d/Hbml0jpX3umiATQT0JDfbAQ=
Received: from ntfs3vm.paragon-software.com (192.168.211.129) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 26 Jun 2024 15:43:09 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 01/11] fs/ntfs3: Fix field-spanning write in INDEX_HDR
Date: Wed, 26 Jun 2024 15:42:48 +0300
Message-ID: <20240626124258.7264-2-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626124258.7264-1-almaz.alexandrovich@paragon-software.com>
References: <20240626124258.7264-1-almaz.alexandrovich@paragon-software.com>
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

Fields flags and res[3] replaced with one 4 byte flags.

Fixes: 4534a70b7056 ("fs/ntfs3: Add headers and misc files")
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/index.c | 4 ++--
 fs/ntfs3/ntfs.h  | 9 +++++----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index d0f15bbf78f6..9089c58a005c 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -978,7 +978,7 @@ static struct indx_node *indx_new(struct ntfs_index *indx,
 		hdr->used =
 			cpu_to_le32(eo + sizeof(struct NTFS_DE) + sizeof(u64));
 		de_set_vbn_le(e, *sub_vbn);
-		hdr->flags = 1;
+		hdr->flags = NTFS_INDEX_HDR_HAS_SUBNODES;
 	} else {
 		e->size = cpu_to_le16(sizeof(struct NTFS_DE));
 		hdr->used = cpu_to_le32(eo + sizeof(struct NTFS_DE));
@@ -1683,7 +1683,7 @@ static int indx_insert_into_root(struct ntfs_index *indx, struct ntfs_inode *ni,
 	e->size = cpu_to_le16(sizeof(struct NTFS_DE) + sizeof(u64));
 	e->flags = NTFS_IE_HAS_SUBNODES | NTFS_IE_LAST;
 
-	hdr->flags = 1;
+	hdr->flags = NTFS_INDEX_HDR_HAS_SUBNODES;
 	hdr->used = hdr->total =
 		cpu_to_le32(new_root_size - offsetof(struct INDEX_ROOT, ihdr));
 
diff --git a/fs/ntfs3/ntfs.h b/fs/ntfs3/ntfs.h
index a5ca08db6dc5..241f2ffdd920 100644
--- a/fs/ntfs3/ntfs.h
+++ b/fs/ntfs3/ntfs.h
@@ -693,14 +693,15 @@ static inline bool de_has_vcn_ex(const struct NTFS_DE *e)
 	      offsetof(struct ATTR_FILE_NAME, name) + \
 	      NTFS_NAME_LEN * sizeof(short), 8)
 
+#define NTFS_INDEX_HDR_HAS_SUBNODES cpu_to_le32(1)
+
 struct INDEX_HDR {
 	__le32 de_off;	// 0x00: The offset from the start of this structure
 			// to the first NTFS_DE.
 	__le32 used;	// 0x04: The size of this structure plus all
 			// entries (quad-word aligned).
 	__le32 total;	// 0x08: The allocated size of for this structure plus all entries.
-	u8 flags;	// 0x0C: 0x00 = Small directory, 0x01 = Large directory.
-	u8 res[3];
+	__le32 flags;	// 0x0C: 0x00 = Small directory, 0x01 = Large directory.
 
 	//
 	// de_off + used <= total
@@ -748,7 +749,7 @@ static inline struct NTFS_DE *hdr_next_de(const struct INDEX_HDR *hdr,
 
 static inline bool hdr_has_subnode(const struct INDEX_HDR *hdr)
 {
-	return hdr->flags & 1;
+	return hdr->flags & NTFS_INDEX_HDR_HAS_SUBNODES;
 }
 
 struct INDEX_BUFFER {
@@ -768,7 +769,7 @@ static inline bool ib_is_empty(const struct INDEX_BUFFER *ib)
 
 static inline bool ib_is_leaf(const struct INDEX_BUFFER *ib)
 {
-	return !(ib->ihdr.flags & 1);
+	return !(ib->ihdr.flags & NTFS_INDEX_HDR_HAS_SUBNODES);
 }
 
 /* Index root structure ( 0x90 ). */
-- 
2.34.1


