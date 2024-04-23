Return-Path: <linux-fsdevel+bounces-17519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8BE8AE9BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 16:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FB161C21BA8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 14:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05B58F5E;
	Tue, 23 Apr 2024 14:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="FV95OFNv";
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="cX/OlauS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6AA37144;
	Tue, 23 Apr 2024 14:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713883426; cv=none; b=k+JAzpQ8jdesr8AGeYt51r/KfDM+wtmnWwLHxxJSodlONANFbDNTgyxMW0qXCIdKNMz+YRk1Mvus2zH0zPInLJDA1gSPsGNoRydPVHlHyowKDbtxsIyLVIUTs6qwlyFkT9aTlaGDFLKTeRkpAC3zP4u0Xl+tTCrl3e1ocpKYR7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713883426; c=relaxed/simple;
	bh=WbCw9nUWuNlue0JTbw7KKe+Klt1Zl5siF7ReQQs1Orc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=taIuJ/6Rlv4CMU8ZEmQE4/1d/Wzg0kl6Y247TjV4bq6A5ga6ezuLEwVmfAUdVD+asZSHUduVv5MStLVKBnx0t5XCGWw9pUv3tyS5FET9AXgPHkognqWwGnDEZdb7lYI9uCeEKDRwnZs99rJiARfuJVzgAGOf7WrWTjRUVxyxmg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=FV95OFNv; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=cX/OlauS; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id D33172111;
	Tue, 23 Apr 2024 14:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1713882969;
	bh=fEEWQ5PXpVshURSalmdzx3oghb8b7D3y9U6SgDq2pmQ=;
	h=From:To:CC:Subject:Date;
	b=FV95OFNvh3IC0MpiuUATwUNaXvKnItIH6eelfFs+NBlXaRfj9cwo2Xo2yrKgBbKky
	 LitGvrHpuWbNOzZfmYwp+GHb+9VO8bO19WiqRuMdZapyDdmJfLigkv5TO88hNJU9ST
	 8MaE56RRRfcX6nhUmKwd0aXTe8XGFMsujlPq7VQ8=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id BF8D821B6;
	Tue, 23 Apr 2024 14:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1713883421;
	bh=fEEWQ5PXpVshURSalmdzx3oghb8b7D3y9U6SgDq2pmQ=;
	h=From:To:CC:Subject:Date;
	b=cX/OlauSd62Up47RVYWQ+MvU7prIaVwTzs2IAR1rxJvAVqSgby0/8/G9w3/0LlbIB
	 3hsSWXlLRUyABU+Qs8eqD3nMM/koaAAoOdsnRrYyveJEVQhmylvdHnHA20a27VLCXi
	 NYTgdupc6m9J0rxllAD5ga4JAarOCel0OGNpZhlM=
Received: from ntfs3vm.paragon-software.com (192.168.211.186) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 23 Apr 2024 17:43:41 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	<stable@vger.kernel.org>
Subject: [PATCH] fs/ntfs3: Fix case when index is reused during tree transformation
Date: Tue, 23 Apr 2024 17:41:54 +0300
Message-ID: <20240423144155.10219-1-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.34.1
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


