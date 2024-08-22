Return-Path: <linux-fsdevel+bounces-26798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C655295BB0E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 17:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7232D1F220B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 15:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4AB1CEAB0;
	Thu, 22 Aug 2024 15:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="PQNNV7CA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F0D1CCEC6;
	Thu, 22 Aug 2024 15:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724341952; cv=none; b=OWJmAKVB4DMwT9GfhGEZEkqoL3kMRim7KQBkRi/89ErOW/dPZTN010G7wxurPJei1Gy6w7EpE4tygoLWg/n4r7thgyElQ9yWy+BCHaAnpk85NeSqan/BDcVqWbsvlSTVD4WVnMQbBrpSlSVNmkrWW3kgcYr7xnjSSPU2kMQLzJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724341952; c=relaxed/simple;
	bh=mqGutHXJbiWpVEpXeq/7YvwwYdkIW4TpWSxzZZfut7k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=akRVz3C9KsPSPerjzMjc2IMFSWp7bKh4l1Bb/paij1FpJi6gnUOfr1tHCTOV124Fe4KNejOx7/0M3niG8e4A033X6MfvxXQGgE/esLJdr66bAByln87lIXwPFdnPAJxgfgfTwTDw6+ri5Fv9Lnc6nSmJG9HkzlqmKL/5RwMh6Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=PQNNV7CA; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 0F84D21DB;
	Thu, 22 Aug 2024 15:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1724341465;
	bh=kK185aN2r7QEHWnYIRgs4HSrjA3COKSz4R/In5QiFrM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=PQNNV7CArbgIL6bIU8Fn33BKEPg2G5OUgSPjE94Xs8wY5a+azOPg0bkFYnGLElZc4
	 3OLkltGZ7HMUhnIIOKJllPgvY5w9ieXFJ/IP0DYINKp8dOfdeaSrAIYc+BTRvwotXk
	 DPJxfzwgxmtauiSs/D5T1GX8s6NEZYwMRmaNfcs8=
Received: from ntfs3vm.paragon-software.com (192.168.211.133) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 22 Aug 2024 18:52:21 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Dan Carpenter
	<dan.carpenter@linaro.org>
Subject: [PATCH 07/14] fs/ntfs3: Refactor enum_rstbl to suppress static checker
Date: Thu, 22 Aug 2024 18:52:00 +0300
Message-ID: <20240822155207.600355-8-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822155207.600355-1-almaz.alexandrovich@paragon-software.com>
References: <20240822155207.600355-1-almaz.alexandrovich@paragon-software.com>
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

Comments and brief description of function enum_rstbl added.

Fixes: b46acd6a6a62 ("fs/ntfs3: Add NTFS journal")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/fslog.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index c64dd114ac65..d0d530f4e2b9 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -609,14 +609,29 @@ static inline void add_client(struct CLIENT_REC *ca, u16 index, __le16 *head)
 	*head = cpu_to_le16(index);
 }
 
+/*
+ * Enumerate restart table.
+ *
+ * @t - table to enumerate.
+ * @c - current enumerated element.
+ *
+ * enumeration starts with @c == NULL
+ * returns next element or NULL
+ */
 static inline void *enum_rstbl(struct RESTART_TABLE *t, void *c)
 {
 	__le32 *e;
 	u32 bprt;
-	u16 rsize = t ? le16_to_cpu(t->size) : 0;
+	u16 rsize;
+
+	if (!t)
+		return NULL;
+
+	rsize = le16_to_cpu(t->size);
 
 	if (!c) {
-		if (!t || !t->total)
+		/* start enumeration. */
+		if (!t->total)
 			return NULL;
 		e = Add2Ptr(t, sizeof(struct RESTART_TABLE));
 	} else {
-- 
2.34.1


