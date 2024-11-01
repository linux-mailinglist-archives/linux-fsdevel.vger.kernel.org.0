Return-Path: <linux-fsdevel+bounces-33449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 263BC9B8CFC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 09:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C64E21F22C47
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 08:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83A9157E6B;
	Fri,  1 Nov 2024 08:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="V1ZTFrkn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023F0156222;
	Fri,  1 Nov 2024 08:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730449590; cv=none; b=t8KqIjjLBB8WcuUJ+hDAoVHkGmrs5UUuUcNLLFA1BABxp6Zmg5CiS9HJo8KyCXst7yPr3uQ4capHFzb6aLNAe6xjKS325Venx1cTCSRDxG8FVVyj5fspUKhriUp1BjcejgskQeegQzZW2qVxlCWnP3wS/qZoT5NN8STmoTY1Y7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730449590; c=relaxed/simple;
	bh=0oZBY97lul7yUbBl6y6b03JAdxgFn9GXH59r3A5xrqI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KZPIcmPRUhTPj2v0WtL+BanoofZarsB+PP7zS4v9W7GMs2Lt15A9L7Gnx0IWdDJsI14Lyo79NFk3NdaIlWX/Otf6cDfDFMW/IW7RLrYJ68D2vdlCa6ULBZR2EVc0TUlx7D1Fh5pdvy78gnNyOZ11NQHKDDiZWJONbgoOzSw0sxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=V1ZTFrkn; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id BB6912193;
	Fri,  1 Nov 2024 08:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1730448623;
	bh=Zc8pWLu9PmdBKNyMNiH6MkfNdkErJ9Xuv7AE62v9sLE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=V1ZTFrknpeI4XZnwMs0ggOh2xVuTbomK9t0+TFDjON2Vt7pW4KOEc5P6v8L0KrxOg
	 HxwR0S2peQUKBNDNyFIJl82V0yBtepcy0uDDA7SnRX2pvv2gy8udybnTCYbffYnUeD
	 9gGml0eIL2vVgdWhjqF3tjf0Qre5KtJkibwE6uxE=
Received: from ntfs3vm.paragon-software.com (192.168.211.142) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 1 Nov 2024 11:18:07 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, lei lu
	<llfamsec@gmail.com>
Subject: [PATCH 4/7] fs/ntfs3: Add more checks in mi_enum_attr (part 2)
Date: Fri, 1 Nov 2024 11:17:50 +0300
Message-ID: <20241101081753.10585-5-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241101081753.10585-1-almaz.alexandrovich@paragon-software.com>
References: <20241101081753.10585-1-almaz.alexandrovich@paragon-software.com>
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

Add offset check before access to attr->non_res field as mentioned in [1].

[1] https://lore.kernel.org/ntfs3/20241010110005.42792-1-llfamsec@gmail.com/

Suggested-by: lei lu <llfamsec@gmail.com>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/record.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index f810f0419d25..61d53d39f3b9 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -212,7 +212,7 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 			return NULL;
 
 		if (off >= used || off < MFTRECORD_FIXUP_OFFSET_1 ||
-		    !IS_ALIGNED(off, 4)) {
+		    !IS_ALIGNED(off, 8)) {
 			return NULL;
 		}
 
@@ -236,8 +236,11 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 		off += asize;
 	}
 
-	/* Can we use the first field (attr->type). */
-	/* NOTE: this code also checks attr->size availability. */
+	/*
+	 * Can we use the first fields:
+	 * attr->type,
+	 * attr->size
+	 */
 	if (off + 8 > used) {
 		static_assert(ALIGN(sizeof(enum ATTR_TYPE), 8) == 8);
 		return NULL;
@@ -259,10 +262,17 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 
 	asize = le32_to_cpu(attr->size);
 
+	if (!IS_ALIGNED(asize, 8))
+		return NULL;
+
 	/* Check overflow and boundary. */
 	if (off + asize < off || off + asize > used)
 		return NULL;
 
+	/* Can we use the field attr->non_res. */
+	if (off + 9 > used)
+		return NULL;
+
 	/* Check size of attribute. */
 	if (!attr->non_res) {
 		/* Check resident fields. */
-- 
2.34.1


