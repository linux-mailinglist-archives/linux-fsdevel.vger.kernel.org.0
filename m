Return-Path: <linux-fsdevel+bounces-33444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 036AC9B8CD3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 09:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCECF286FE4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 08:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD35156F55;
	Fri,  1 Nov 2024 08:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="DgjM7FMR";
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="XnwjQLen"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6F715665E;
	Fri,  1 Nov 2024 08:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730449097; cv=none; b=q9A01B9lJs3xEw9iaHLtveUV8uZLTfZVBO1bQO811D63kgZYebyet7njMK99yov2lwLzpz8GRmol8TJxoFCA8H63KshbaUXGvJUAxK7QCXAbz2NWJNjjfO4mjt4xbdolrmib9j32x6IMYy6Wv3qk9YsXwx51Ketn5GifkRVUAz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730449097; c=relaxed/simple;
	bh=tYU9NbbtAgq70BsaYYUR2bmcBrBdVA3gIQJ+XtgVBwU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g/g8vyERDMoii6MAF085XlcHcSGITdDTnGD5IImUywkCspo/o6y+ihll9TxNHRN3ex5vqpT6PtC8gBNo+1uRsREEhSmRPMYTyifNdsTI3x4GutwjyTHDOgiE19SKBZxJnA7OUhvjbze1XN3GEKLR5iTsjB7OkK+ahF1fyn8vjUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=DgjM7FMR; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=XnwjQLen; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 74FBA2194;
	Fri,  1 Nov 2024 08:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1730448624;
	bh=lyTvVE83tJLRVQjKOlhu4Y9VF3FY60VMH0YBNXt7z3s=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=DgjM7FMRRxlEU+6pG+gCZ7j9kh7kY51AE3wrgz5sCR66RZIOpADWYgUaZ/l2qJ1QS
	 dQAi78FtdVmI4tbrusGzbnDUXpYa0UOkgErDiIde1odIf7Mvmv69BBUPkNjaSZRL6y
	 1mcmnYvZMKenN+5xBGn6Mixce2yLwvfg/n2qEulA=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 0682F220E;
	Fri,  1 Nov 2024 08:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1730449088;
	bh=lyTvVE83tJLRVQjKOlhu4Y9VF3FY60VMH0YBNXt7z3s=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=XnwjQLenQNWnFVucW6OVxc4giGNvOrSZmBvx58Zvxq5d1xhyV/JCq2XURzypDj17g
	 fflxKmpo5GeVMmJSdGKJv3Ot7KiXzuHh99U5w8RzSfY5QAZRf90QN0ot8QRrm6gLJS
	 IxKx9Uf0jzCOsoCL0fZYRix6KSE9NuZkTmwQFBxE=
Received: from ntfs3vm.paragon-software.com (192.168.211.142) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 1 Nov 2024 11:18:07 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 5/7] fs/ntfs3: Add check in ntfs_extend_initialized_size
Date: Fri, 1 Nov 2024 11:17:51 +0300
Message-ID: <20241101081753.10585-6-almaz.alexandrovich@paragon-software.com>
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

Check arguments again after lock.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index f704ceef9539..0063e2351aa9 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -182,13 +182,15 @@ static int ntfs_extend_initialized_size(struct file *file,
 	loff_t pos = valid;
 	int err;
 
+	if (valid >= new_valid)
+		return 0;
+
 	if (is_resident(ni)) {
 		ni->i_valid = new_valid;
 		return 0;
 	}
 
 	WARN_ON(is_compressed(ni));
-	WARN_ON(valid >= new_valid);
 
 	for (;;) {
 		u32 zerofrom, len;
-- 
2.34.1


