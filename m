Return-Path: <linux-fsdevel+bounces-42259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC1FA3FAAB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 17:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD65919E3452
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 16:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E50B215F41;
	Fri, 21 Feb 2025 16:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="JMea8GlX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC9F1DED6F;
	Fri, 21 Feb 2025 16:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740154203; cv=none; b=t1ZfwJWOyXFlS8dDfbZg5bWhkThlbUdjsfSxR2WD2BFJWxek0Gq/twIpgpEn2jvvXM0jDC7tAOaXTer+aTG8NWoKnDhgaSLsbBqI8s7q9gLugmHI9oUasu5KnMoTbxjYUqkRxCrqKapVWJr+N3WlyiDqF5gqeVr3WmeOJxnPzr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740154203; c=relaxed/simple;
	bh=dIOAfK5l5sMZ60sYBpNsqkLigE4M7dUL8qlJb1jIvmQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DaMyPtPt/vtTzY6V8QGS6vxPVA39QJyeG0k9F551Ha0FUujW/Zvnbs4MBqnz4mehHHTY4NuQ5rG7pAVIBZlDQtKgI/a8lG/OqamybmzzRbyAn1H6KghLeBUKxr8tnWBVlpDdlO6C/uuE3oMuhfU/op4Q6lpasxM6HoLqe6f05e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=JMea8GlX; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazon201209; t=1740154202; x=1771690202;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wwl9CfOz4nL59ff0Ja+pcR3q7EpeB2Q7d6wZSz1xGZE=;
  b=JMea8GlX2dVqjI1nB9GKEjIc7wW4hhhUfASVZqak7aglAUM3I5Wp2U0z
   GZnoJFgRI6bF+eggp6n2ImidCvy3ai8P+KNY7N841rFamPyd0fTk3HWyZ
   nspGaaYvnNfGwUKxtttGiUQw2n8M1S4ec/UhcR/bc26H4tPJw6KT9IKUt
   o=;
X-IronPort-AV: E=Sophos;i="6.13,305,1732579200"; 
   d="scan'208";a="720844356"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 16:09:59 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.43.254:12663]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.36.43:2525] with esmtp (Farcaster)
 id 192c89ae-60a6-433f-922e-de8d53f429b1; Fri, 21 Feb 2025 16:09:57 +0000 (UTC)
X-Farcaster-Flow-ID: 192c89ae-60a6-433f-922e-de8d53f429b1
Received: from EX19D014EUC002.ant.amazon.com (10.252.51.161) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 21 Feb 2025 16:09:45 +0000
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19D014EUC002.ant.amazon.com (10.252.51.161) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 21 Feb 2025 16:09:44 +0000
Received: from email-imr-corp-prod-pdx-all-2b-c1559d0e.us-west-2.amazon.com
 (10.43.8.6) by mail-relay.amazon.com (10.252.135.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.39 via Frontend Transport; Fri, 21 Feb 2025 16:09:44 +0000
Received: from ua2d7e1a6107c5b.ant.amazon.com (dev-dsk-roypat-1c-dbe2a224.eu-west-1.amazon.com [172.19.88.180])
	by email-imr-corp-prod-pdx-all-2b-c1559d0e.us-west-2.amazon.com (Postfix) with ESMTPS id 8AF5E404D5;
	Fri, 21 Feb 2025 16:09:36 +0000 (UTC)
From: Patrick Roy <roypat@amazon.co.uk>
To: <rppt@kernel.org>, <david@redhat.com>, <seanjc@google.com>
CC: Patrick Roy <roypat@amazon.co.uk>, <pbonzini@redhat.com>,
	<corbet@lwn.net>, <willy@infradead.org>, <akpm@linux-foundation.org>,
	<song@kernel.org>, <jolsa@kernel.org>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <martin.lau@linux.dev>,
	<eddyz87@gmail.com>, <yonghong.song@linux.dev>, <john.fastabend@gmail.com>,
	<kpsingh@kernel.org>, <sdf@fomichev.me>, <haoluo@google.com>,
	<Liam.Howlett@oracle.com>, <lorenzo.stoakes@oracle.com>, <vbabka@suse.cz>,
	<jannh@google.com>, <shuah@kernel.org>, <kvm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>, <bpf@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <tabba@google.com>, <jgowans@amazon.com>,
	<graf@amazon.com>, <kalyazin@amazon.com>, <xmarcalx@amazon.com>,
	<derekmn@amazon.com>, <jthoughton@google.com>
Subject: [PATCH v4 05/12] KVM: Documentation: document KVM_GMEM_NO_DIRECT_MAP flag
Date: Fri, 21 Feb 2025 16:07:18 +0000
Message-ID: <20250221160728.1584559-6-roypat@amazon.co.uk>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221160728.1584559-1-roypat@amazon.co.uk>
References: <20250221160728.1584559-1-roypat@amazon.co.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain

Signed-off-by: Patrick Roy <roypat@amazon.co.uk>
---
 Documentation/virt/kvm/api.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 2b52eb77e29c..fc0d2314fae6 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6388,6 +6388,19 @@ a single guest_memfd file, but the bound ranges must not overlap).
 
 See KVM_SET_USER_MEMORY_REGION2 for additional details.
 
+The following flags are defined:
+
+KVM_GMEM_NO_DIRECT_MAP
+   Ensure memory backing this guest_memfd inode is unmapped from the kernel's
+   address space. Check KVM_CAP_GMEM_NO_DIRECT_MAP for support.
+
+Errors:
+
+  ========== ===============================================================
+  EINVAL     The specified `flags` were invalid or not supported.
+  ========== ===============================================================
+
+
 4.143 KVM_PRE_FAULT_MEMORY
 ---------------------------
 
-- 
2.48.1


