Return-Path: <linux-fsdevel+bounces-10276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F164C84998D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 13:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30B4D1C23225
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 12:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B671B94C;
	Mon,  5 Feb 2024 12:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="kcEW2jEB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468BD1B80F;
	Mon,  5 Feb 2024 12:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134626; cv=none; b=Z6n1QEHQXpQ9dBaQHl8UfHgkOPaQMANm3/dGOEpILfMmKHSlRU2fj73/PGHxwAKyHDXiu8OLiY1JxVX8sHFP1iI2qotLeR3yFwCj3vQTN25YuTVs4TuEXaVwpQuyqg6ksOUtlJgCNNf8dtthJcInKoviObyGtg9Nd0+4weX9VJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134626; c=relaxed/simple;
	bh=vP7xqQVckvYXPZog0UglD7fg0Qi7KmKUf6ygoE4dg1o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n9TQJb1gJJpw68htqAJ4g5fFJb9negbe3kIsW24w6g3D8ozBKRuUZJ5VTEQ60SyntvpKE+ZhNy1CTZIvsKKc/fd69RQTtDHPU6XVl2R3mNsR5FiciPMRXvctBgD4M7wUB1M6ZDGayyzyEDg9+MoGZcv601iyaztHOJzDZ9vdiX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=kcEW2jEB; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1707134626; x=1738670626;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GuAtgRmAwOIaihgufqnss82d+hBkVwofjU/pF2m60/o=;
  b=kcEW2jEB1SevwyiGV9tiPNgSpSSB4Eb54eOLEyLccIv4DAiivPzXAGdS
   9wOFjIVdVzVLx6YG1T11NREeoN35/V7msL4/WDiRJ5SeQMU/NAEWMVTsQ
   SeU/vkmJ4JlP2YuDU6wH0Azevl/s1u72Sf980FYpMlpeIR/3y0hulM5zX
   0=;
X-IronPort-AV: E=Sophos;i="6.05,245,1701129600"; 
   d="scan'208";a="702146151"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 12:03:45 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.43.254:55484]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.32.190:2525] with esmtp (Farcaster)
 id 54deb5d5-b17f-4ae2-b6be-2dc346f855b1; Mon, 5 Feb 2024 12:03:43 +0000 (UTC)
X-Farcaster-Flow-ID: 54deb5d5-b17f-4ae2-b6be-2dc346f855b1
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 5 Feb 2024 12:03:40 +0000
Received: from dev-dsk-jgowans-1a-a3faec1f.eu-west-1.amazon.com
 (172.19.112.191) by EX19D014EUC004.ant.amazon.com (10.252.51.182) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 5 Feb
 2024 12:03:33 +0000
From: James Gowans <jgowans@amazon.com>
To: <linux-kernel@vger.kernel.org>
CC: Eric Biederman <ebiederm@xmission.com>, <kexec@lists.infradead.org>,
	"Joerg Roedel" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	<iommu@lists.linux.dev>, Alexander Viro <viro@zeniv.linux.org.uk>, "Christian
 Brauner" <brauner@kernel.org>, <linux-fsdevel@vger.kernel.org>, Paolo Bonzini
	<pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>,
	<kvm@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	<linux-mm@kvack.org>, Alexander Graf <graf@amazon.com>, David Woodhouse
	<dwmw@amazon.co.uk>, "Jan H . Schoenherr" <jschoenh@amazon.de>, Usama Arif
	<usama.arif@bytedance.com>, Anthony Yznaga <anthony.yznaga@oracle.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	<madvenka@linux.microsoft.com>, <steven.sistare@oracle.com>,
	<yuleixzhang@tencent.com>
Subject: [RFC 06/18] init: Add liveupdate cmdline param
Date: Mon, 5 Feb 2024 12:01:51 +0000
Message-ID: <20240205120203.60312-7-jgowans@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240205120203.60312-1-jgowans@amazon.com>
References: <20240205120203.60312-1-jgowans@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC001.ant.amazon.com (10.13.139.218) To
 EX19D014EUC004.ant.amazon.com (10.252.51.182)

This will allow other subsystems to know when we're going a LU and hence
when they should be restoring rather than reinitialising state.
---
 include/linux/init.h |  1 +
 init/main.c          | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/linux/init.h b/include/linux/init.h
index 266c3e1640d4..d7c68c7bfaf0 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -146,6 +146,7 @@ extern int do_one_initcall(initcall_t fn);
 extern char __initdata boot_command_line[];
 extern char *saved_command_line;
 extern unsigned int saved_command_line_len;
+extern bool liveupdate;
 extern unsigned int reset_devices;
 
 /* used by init/main.c */
diff --git a/init/main.c b/init/main.c
index e24b0780fdff..7807a56c3473 100644
--- a/init/main.c
+++ b/init/main.c
@@ -165,6 +165,16 @@ static char *ramdisk_execute_command = "/init";
 bool static_key_initialized __read_mostly;
 EXPORT_SYMBOL_GPL(static_key_initialized);
 
+bool liveupdate __read_mostly;
+EXPORT_SYMBOL(liveupdate);
+
+static int __init set_liveupdate(char *param)
+{
+	liveupdate = true;
+	return 0;
+}
+early_param("liveupdate", set_liveupdate);
+
 /*
  * If set, this is an indication to the drivers that reset the underlying
  * device before going ahead with the initialization otherwise driver might
-- 
2.40.1


