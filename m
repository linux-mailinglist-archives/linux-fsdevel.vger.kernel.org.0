Return-Path: <linux-fsdevel+bounces-17470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C977A8ADDB8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 08:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A2031F22FE0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 06:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99E154735;
	Tue, 23 Apr 2024 06:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="UoGh5+pK";
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="EEYmEV2b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EA653E0C;
	Tue, 23 Apr 2024 06:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713854733; cv=none; b=kBqgtziA0WuSIc6cbTufOZGQS2A9y7UKczFQ7tesx2FElx9XYTQcY1phH/dO4MBEg4H0LJfDyoz9BEjWE+9TJ6d0u7r1JuxdQl4ZCuOn5MrmPQZ9ity+IE85IUPAukJmsuw2Mmm5CepGZZJX6IuTDU78oOk/gWgp/IsUp5ufxdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713854733; c=relaxed/simple;
	bh=zIXsydJ0OFAdAw7O+5l7FhA6iuyUaBpAfrhoIuPnWjw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J2Hf+1pQxehuu1yw1hMy3Ur2+kytkODa+Fq4SaG6ocaLnHC6LVDnjFmifOkQatLWdj5wU+xV0qeMmcp36EJkbOpCygVMAavsXXJsBvOXqoG7TVo+dm26BaIZ5SXHXeYKDZ6M1/+UTNejl2e+d6QjQXvM40PQKlnQ+fZBVq3fmrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=UoGh5+pK; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=EEYmEV2b; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 7787E1E80;
	Tue, 23 Apr 2024 06:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1713854278;
	bh=cm+UXusAdhDpHBRIxdmZISx0r6b6stnWsNu0gUCqeh4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=UoGh5+pK2M2QxcyXDG2zma+Rk1cSwbCNF0fSMgJmFhuD00RTRwSKjHB1Ls7xTWh98
	 b7fL1JM8cT07wR/sl8EIDSq3ksa2P8O6APDtDErdf5KfcmG0faajw2A2MaWgaMWraP
	 c0rHyPnG1cLcCCk+bfV+KkENM+p3FXiUfoJE8k8A=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 3B680214E;
	Tue, 23 Apr 2024 06:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1713854730;
	bh=cm+UXusAdhDpHBRIxdmZISx0r6b6stnWsNu0gUCqeh4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=EEYmEV2bcD9JxCZNwpZ+s8YgmMC49a8qdoEotQ//Hkw07Qf3hXcHKjyn1ukplIVub
	 I2sWPqFYSkWLDNlEbxFIvwcCohoCAM7DpLFRZz0whDyg98ZV5Rfemuer+WLI/G7CN3
	 1aUBFhiD+CKVOUSBzPFXnGcQh+YJO90by6gUkkCA=
Received: from ntfs3vm.paragon-software.com (192.168.211.160) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 23 Apr 2024 09:45:29 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 9/9] fs/ntfs3: Mark volume as dirty if xattr is broken
Date: Tue, 23 Apr 2024 09:44:28 +0300
Message-ID: <20240423064428.8289-10-almaz.alexandrovich@paragon-software.com>
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

Mark a volume as corrupted if the name length exceeds the space
occupied by ea.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/xattr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 53e7d1fa036a..73785dece7a7 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -219,8 +219,11 @@ static ssize_t ntfs_list_ea(struct ntfs_inode *ni, char *buffer,
 		if (!ea->name_len)
 			break;
 
-		if (ea->name_len > ea_size)
+		if (ea->name_len > ea_size) {
+			ntfs_set_state(ni->mi.sbi, NTFS_DIRTY_ERROR);
+			err = -EINVAL; /* corrupted fs */
 			break;
+		}
 
 		if (buffer) {
 			/* Check if we can use field ea->name */
-- 
2.34.1


