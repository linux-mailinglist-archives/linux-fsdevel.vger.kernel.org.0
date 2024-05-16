Return-Path: <linux-fsdevel+bounces-19577-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 513E68C75B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 14:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB5FFB20F64
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 12:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF615145A13;
	Thu, 16 May 2024 12:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="ACnZW+Kc";
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="DiNDXPGj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0BF145B12;
	Thu, 16 May 2024 12:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715861466; cv=none; b=M46/SHhCQeiMmTJ9zO+4UKGLto9tDv2nqMIxgU7b/ZOobkVSSN/v+/nsQ61yxEmFak0m8EC7MmzqnC/Jb9Z95LCqnNOAOsrZY82QTdRqsudv29YFrZi1YRYwcxhO/RE1t3KCRqdsv+3m2jkOAoKSaW81V2OSDlYjXTd10u7HqYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715861466; c=relaxed/simple;
	bh=F6WO1aR+Qxv99DM4oHOPG9apgSeKLUE9nrEBhqRH5D0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TpCaYD7pTkNqqVkX1Baswo01pgj7eHsSPNWyiVS6Dm64tPJ5xjOW5g2sKP3YFXiTAjPN6y/62os6nWKIEYCZSJ7A7Eye0G/jazK7qGVOL1B63BZYSCt5xcRfDMKWs8GpIGmbaXtwXoKmJOdx+dTbrOIoP0mkJKPVYqeHVgZfAEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=ACnZW+Kc; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=DiNDXPGj; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id B6CCF1F86;
	Thu, 16 May 2024 11:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1715860392;
	bh=GOGJaz9UJqKRi2i7pMYNMK4sWlylteCj88ffOeaMKGQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ACnZW+KcT0fYGBHLAlEIKlGjw8yCdUEqWqze1R37u3nNcT4VJ//Yv7b1W+srOZsZK
	 Zcr5lSAXwf37mTjEQXkDRjgpRoRZGHLAnM2IKaeL7Zhyk1j2//kZPC0aRIMdj2PoE4
	 zUpz4/MnQ2wZJCa7+LB3m524h6aUL47u7kqxgAYI=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id D77FE21CF;
	Thu, 16 May 2024 12:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1715860855;
	bh=GOGJaz9UJqKRi2i7pMYNMK4sWlylteCj88ffOeaMKGQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=DiNDXPGjfoHIRP/89L7R2yge4Qse7mfKIBekMGUtGs85UsqSQZbAEuP3U+76jmvt+
	 nChTzXKmco6hoaFshnnFBZEPIiEtYe6DIYX050Kt1bppcKQDNF2eH9odSAu/A9EysS
	 zo5Y8lLSKqur84a9RuSJUqPSZVE+tXIBy940FFx0=
Received: from ntfs3vm.paragon-software.com (192.168.211.154) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 16 May 2024 15:00:55 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	<stable@vger.kernel.org>
Subject: [PATCH v2] fs/ntfs3: Fix case when index is reused during tree transformation
Date: Thu, 16 May 2024 15:00:29 +0300
Message-ID: <20240516120029.5113-1-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423144155.10219-1-almaz.alexandrovich@paragon-software.com>
References:
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

In most cases when adding a cluster to the directory index,
they are placed at the end, and in the bitmap, this cluster corresponds
to the last bit. The new directory size is calculated as follows:

	data_size = (u64)(bit + 1) << indx->index_bits;

In the case of reusing a non-final cluster from the index,
data_size is calculated incorrectly, resulting in the directory size
differing from the actual size.

A check for cluster reuse has been added, and the size update is skipped.

Fixes: 82cae269cfa95 ("fs/ntfs3: Add initialization of super block")
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: stable@vger.kernel.org
---
 fs/ntfs3/index.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index daabaad63aaf..14284f0ed46a 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1533,6 +1533,11 @@ static int indx_add_allocate(struct ntfs_index *indx, struct ntfs_inode *ni,
 		goto out1;
 	}
 
+	if (data_size <= le64_to_cpu(alloc->nres.data_size)) {
+		/* Reuse index. */
+		goto out;
+	}
+
 	/* Increase allocation. */
 	err = attr_set_size(ni, ATTR_ALLOC, in->name, in->name_len,
 			    &indx->alloc_run, data_size, &data_size, true,
@@ -1546,6 +1551,7 @@ static int indx_add_allocate(struct ntfs_index *indx, struct ntfs_inode *ni,
 	if (in->name == I30_NAME)
 		i_size_write(&ni->vfs_inode, data_size);
 
+out:
 	*vbn = bit << indx->idx2vbn_bits;
 
 	return 0;
-- 
2.34.1


