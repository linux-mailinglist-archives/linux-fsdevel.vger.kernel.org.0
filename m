Return-Path: <linux-fsdevel+bounces-73817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7B5D21589
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 22:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8F5F930101C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 21:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282FC3587C9;
	Wed, 14 Jan 2026 21:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtvkIwjv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92D72E1F02
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 21:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768426368; cv=none; b=YLSSgGTuuRmKUNFww/OiAt79rLMt78ZNkZZJNWthvzAr6G6AI9GVyd10wFUogyNWQsSd4ws0BHBGB7VWZNVqb4rKIeSKkq0om6O0ZnnD8wHdSVNk/w5Eb57RCUcVDN0ZBTOh5bsjOyKuUHW6R3RnaD210wi5q80WBgCSV90GZec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768426368; c=relaxed/simple;
	bh=rl+jQFmW9bJctWZaIMhOgi7nvti71S9dTb0lCysIN04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M/9uJ90zPyOrpY23U4zWob3IP55n6rSRBQt01GdMmrtNAiSEJuNYMvDTCq2VCmYJmIxPduLsFFbZCne9mKuVr8ZKVNny1d9J9+I9FfHeUdCOg35plrA7q/cltkOWnpWjwyvZT6kbpErLrMkYyjSgMUvxKjm7KwsO3vP1u23vwMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DtvkIwjv; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7ce2b14202fso143460a34.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 13:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768426365; x=1769031165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+ZFzB1bOq1z4EOZD4cYTHTPj9h8hzHs0/3N91Bb6XY=;
        b=DtvkIwjvXfYtf/To5+Fx2Hg9xeKVhr5+4S/kYC9GDIKtL1Ocb1tLNBm1JYvtrcSrDy
         KIpKbv7TyOBPgtuqtavqCobaLpGEIEH9ozpJXn3HaRPeBBIV9V+MerOT3Y977RIv4L5p
         J44aeEvWfaM9O30vqRibyH8titOwGRPtVx2RLuuie60hZhN643yxeuKBCmjynZ/k/rqp
         sK28s4ONTINstsrJT2s0aC+pDh8RXjfZc2EHg5wpTS0nwu8uroRL/u2fwsfznPnw5Hwr
         oDr7Cd8ses94H52hMhe/QlyKCrtx8kmOu3gw4uVTwDQ/G3YhxpOgytASSfTIxy3HDtJ5
         nsdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768426365; x=1769031165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5+ZFzB1bOq1z4EOZD4cYTHTPj9h8hzHs0/3N91Bb6XY=;
        b=RFfTPRjImUakB1wtjYMBEgQsNchC4Vg7atqUI1o5kk5AoJuFQE6e6qfpTdCJWQB7Q1
         fBbzb0Xm3PISEYTAxjXH2vRtxpyd8CJPmdIE+kfukB++0vq5QVdJR/O6Z7PQk+Im6a0h
         HQaukNWhLoTYa3FkmA0v9wy0I07KwYN3xyzt5O63fblLtAqopPzw2I8xGZJ/pAZCb6q8
         FhSGUa5Wgbmx0VbeWeFwCB6hapAsv7AOWuC6cfC1cRtNvISUImGEf2g+WrK1u6zXlb3c
         fOM97LVj4mjXsunYf2o40xe4k6lpttGmKWd53Sz+PaIDthwHQ2WtiBCMadPSw8u/5689
         5PvA==
X-Forwarded-Encrypted: i=1; AJvYcCU73Auz8imCuLUFtMTYQDVsVNz+j24QO9C8wbKZz0gND25ixw/B1Xv0whWK65HL3KPbFtp0rD6xS9kKJhFs@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5/Wa67lUfedTkj7JJ3n80lvoJi6AwTArBd1HSW/RR193WrKAy
	sTaeOLuTaxIkR9s6DrP2fiF3x+s4WefASPZ/01Dmqk2AwRbb/LnnYp2q
X-Gm-Gg: AY/fxX5tbm/m//lQhlC9GE4ogogco1An5+hD5KAVrxiuhefFI7PssZWhW5bw9uo3q5R
	hnGKJaQga5m8gTKns0xy8ge+r+N9ZTddhuKM8dyFWVTyENfPS3uo0OvMdkb4M4wR94YMJZhBc9Z
	xOFHwShN4uRqHzVlNludbzCvus09AtH5Ku3b+WBB1ljsntf5/n3MKzbXzad6y/QW6P38Q19ILgq
	/ftZpMK3TxkC2WBjZJf51c8GhuplR4gBRiMNEcCdoO/uDeqOi1Mn0x2vK+WABXIcExFsabHz5Hf
	oIk1UJFG4GEvZjZkfcLQ0P+jnppxCRNFZripDbDetSJWYGUie4bsN3SFuU3winD1PqHfPftTo4t
	jZj3pH3ytOy3HbjrHdMs0ewoqFBK192gThHW0t6IP2CRmvgjjtQOa53ezvPJcGOqR57FOUMCmtM
	KVVXnio5ErkFujQMZ1MXhy/+Rn9WQXja07h4DNYuuxgBaG
X-Received: by 2002:a05:6830:268c:b0:7c7:6e32:dc7f with SMTP id 46e09a7af769-7cfcb46d690mr2240341a34.0.1768426364916;
        Wed, 14 Jan 2026 13:32:44 -0800 (PST)
Received: from localhost.localdomain ([2603:8080:1500:3d89:4c85:2962:e438:72c4])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cfcb084c89sm2440494a34.12.2026.01.14.13.32.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 14 Jan 2026 13:32:44 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: John Groves <John@Groves.net>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Dan Williams <dan.j.williams@intel.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Alison Schofield <alison.schofield@intel.com>
Cc: John Groves <jgroves@micron.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	David Hildenbrand <david@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	James Morse <james.morse@arm.com>,
	Fuad Tabba <tabba@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Shivank Garg <shivankg@amd.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Gregory Price <gourry@gourry.net>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	venkataravis@micron.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH V4 01/19] dax: move dax_pgoff_to_phys from [drivers/dax/] device.c to bus.c
Date: Wed, 14 Jan 2026 15:31:48 -0600
Message-ID: <20260114213209.29453-2-john@groves.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114213209.29453-1-john@groves.net>
References: <20260114153133.29420.compound@groves.net>
 <20260114213209.29453-1-john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This function will be used by both device.c and fsdev.c, but both are
loadable modules. Moving to bus.c puts it in core and makes it available
to both.

No code changes - just relocated.

Signed-off-by: John Groves <john@groves.net>
---
 drivers/dax/bus.c    | 24 ++++++++++++++++++++++++
 drivers/dax/device.c | 23 -----------------------
 2 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index fde29e0ad68b..a73f54eac567 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -1417,6 +1417,30 @@ static const struct device_type dev_dax_type = {
 	.groups = dax_attribute_groups,
 };
 
+/* see "strong" declaration in tools/testing/nvdimm/dax-dev.c */
+__weak phys_addr_t dax_pgoff_to_phys(struct dev_dax *dev_dax, pgoff_t pgoff,
+			      unsigned long size)
+{
+	int i;
+
+	for (i = 0; i < dev_dax->nr_range; i++) {
+		struct dev_dax_range *dax_range = &dev_dax->ranges[i];
+		struct range *range = &dax_range->range;
+		unsigned long long pgoff_end;
+		phys_addr_t phys;
+
+		pgoff_end = dax_range->pgoff + PHYS_PFN(range_len(range)) - 1;
+		if (pgoff < dax_range->pgoff || pgoff > pgoff_end)
+			continue;
+		phys = PFN_PHYS(pgoff - dax_range->pgoff) + range->start;
+		if (phys + size - 1 <= range->end)
+			return phys;
+		break;
+	}
+	return -1;
+}
+EXPORT_SYMBOL_GPL(dax_pgoff_to_phys);
+
 static struct dev_dax *__devm_create_dev_dax(struct dev_dax_data *data)
 {
 	struct dax_region *dax_region = data->dax_region;
diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 22999a402e02..132c1d03fd07 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -57,29 +57,6 @@ static int check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,
 			   vma->vm_file, func);
 }
 
-/* see "strong" declaration in tools/testing/nvdimm/dax-dev.c */
-__weak phys_addr_t dax_pgoff_to_phys(struct dev_dax *dev_dax, pgoff_t pgoff,
-		unsigned long size)
-{
-	int i;
-
-	for (i = 0; i < dev_dax->nr_range; i++) {
-		struct dev_dax_range *dax_range = &dev_dax->ranges[i];
-		struct range *range = &dax_range->range;
-		unsigned long long pgoff_end;
-		phys_addr_t phys;
-
-		pgoff_end = dax_range->pgoff + PHYS_PFN(range_len(range)) - 1;
-		if (pgoff < dax_range->pgoff || pgoff > pgoff_end)
-			continue;
-		phys = PFN_PHYS(pgoff - dax_range->pgoff) + range->start;
-		if (phys + size - 1 <= range->end)
-			return phys;
-		break;
-	}
-	return -1;
-}
-
 static void dax_set_mapping(struct vm_fault *vmf, unsigned long pfn,
 			      unsigned long fault_size)
 {
-- 
2.52.0


