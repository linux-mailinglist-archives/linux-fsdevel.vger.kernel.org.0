Return-Path: <linux-fsdevel+bounces-17466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 159C18ADDA9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 08:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA256281EEF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 06:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2694644C;
	Tue, 23 Apr 2024 06:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="bswXqhWj";
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="MPPu7JOk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF2B4595D;
	Tue, 23 Apr 2024 06:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713854718; cv=none; b=klo3PEUt2gtEsUZeGIMc9DNdxmgyXouljF3i7E+/9SKcLYIS8r7vTEe/r3juSikQViJbLI8TYHWBzvLivY2DbsGr1ej4KuOFwUClB5CGTPTlPMJ1RTBPuG94A/E66GTVODCLg+EcyDbeH5C7WyaCCJ0iz/sCXpuIsb8+iv3Hs6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713854718; c=relaxed/simple;
	bh=PpNCeX2vIZbOq5pHOwaTjW24wzz7Yp+rH1lhM8h6+gk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s7mqhPfax672plxb7oTye85MtcTDxEMhnzqorHx5BsZ9T1wZTpcr6VBwMnUl9YepivT+liMUBibCKEDTTOGzBkn2/h6TDqKaI5y+svKlCETC0a7+JXlHHtmbtR9QsbnMd00DqSke022P8vK8U8TAmdMsujJIx3dkUzd+R5nuNm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=bswXqhWj; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=MPPu7JOk; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 2A6441E80;
	Tue, 23 Apr 2024 06:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1713854263;
	bh=XTKHZat80LdFM14j9Ei2s+Mcqpv92Rbg2DEI+Yn1jpM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=bswXqhWj1nD1rtJSCDQX/LnWM+Co7nxCPVdMYZJOTzg/XrsMALg5PexxgecsuDXN7
	 GbERE4t+a1kP+rnjTgCoaVi3PZXNnOFXAbiE3d0fZtHNpKI5YDUD9zBHg3dro0UbCL
	 9nWTlZEPYhFmIsINaEOgXJzoR8mSATAM0C4Jx3Lo=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id E35C5214E;
	Tue, 23 Apr 2024 06:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1713854714;
	bh=XTKHZat80LdFM14j9Ei2s+Mcqpv92Rbg2DEI+Yn1jpM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=MPPu7JOkahmadcrZKOd06cD0yPtyYdK2Ho5qFlbACjEDh0vYIuniNCqTo9AUChTh4
	 rDzqR/L5a3kPUB3ZEvFhcIr7MsffUbo0r6t1nBiopVEdgneRabi9uVaKvBxnY4Ix4z
	 X2dPbqw6hzgRjs23FbnJ+zEy1QYI/QSnPLnTVKtA=
Received: from ntfs3vm.paragon-software.com (192.168.211.160) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 23 Apr 2024 09:45:14 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 5/9] fs/ntfs3: Use 64 bit variable to avoid 32 bit overflow
Date: Tue, 23 Apr 2024 09:44:24 +0300
Message-ID: <20240423064428.8289-6-almaz.alexandrovich@paragon-software.com>
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

For example, in the expression:
	vbo = 2 * vbo + skip

Fixes: b46acd6a6a627 ("fs/ntfs3: Add NTFS journal")
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/fslog.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index d9d08823de62..d7807d255dfe 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -1184,7 +1184,8 @@ static int read_log_page(struct ntfs_log *log, u32 vbo,
 static int log_read_rst(struct ntfs_log *log, bool first,
 			struct restart_info *info)
 {
-	u32 skip, vbo;
+	u32 skip;
+	u64 vbo;
 	struct RESTART_HDR *r_page = NULL;
 
 	/* Determine which restart area we are looking for. */
-- 
2.34.1


