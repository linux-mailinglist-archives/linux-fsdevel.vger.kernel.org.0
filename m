Return-Path: <linux-fsdevel+bounces-42264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1F6A3FADC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 17:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F8E7443DEE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 16:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EFE21D003;
	Fri, 21 Feb 2025 16:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="r6teND8v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15CB21B1AC;
	Fri, 21 Feb 2025 16:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740154231; cv=none; b=g2ST/uWU90Kqh59GCXCFxCZOJ4SbVbM/5RWTZlHiBjzX8yVJeN0fCIKIKiV965lrWUrTWT3rtUz4t3CbIAxWZm44/MkbGkTjLd+WdPHaRsl2B53dtmE7kduQMu57NUCN0JkqBMs+icE3RtG2nCKHDj0r4oOURsvyqA4wuixiSQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740154231; c=relaxed/simple;
	bh=bbIVRYL8HcyT6MQvZ6nFMNJ2D27lb3VKCpz3qUBzb6E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CY5jQXCfm9Dw5ZN1CW/l8jc4MbafqDdNuVM7sMFT+SadB0JG4FJ7ZV2iS6DUchZMlyLO79+p314NVtR38f9FAsH601J/B2tivlZz61IiOP22ydG1+9SWMaLSRKOhgG8E5YN2PJpbhjvgNzVhjk0kjzmNfmQynC1hLDdL+Ps1iu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=r6teND8v; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazon201209; t=1740154229; x=1771690229;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ME/kRw8cLTb8MhNQKJaRb/2Fz6mJpWbtU0d0jgLL2rk=;
  b=r6teND8vAQbCzYOknIYKxgAQql/84Ee73f+SEjG8CIcppQ8MHZub/CG5
   /QwoNr5PPjij0WK2lBIWHtSfEmnaZh0l5lef1ZQPcljvV/L1jIv3JLOtB
   F5rh+9QR9w/BLHOHwrQxyr3LKCholwMblyeEuSbllWNXXEMiHZc/vaY7m
   A=;
X-IronPort-AV: E=Sophos;i="6.13,305,1732579200"; 
   d="scan'208";a="68171971"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 16:10:27 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.10.100:11823]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.30.133:2525] with esmtp (Farcaster)
 id 30f1aa8e-25c6-4aeb-b42f-8993fd44c7bb; Fri, 21 Feb 2025 16:10:26 +0000 (UTC)
X-Farcaster-Flow-ID: 30f1aa8e-25c6-4aeb-b42f-8993fd44c7bb
Received: from EX19D022EUA002.ant.amazon.com (10.252.50.201) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 21 Feb 2025 16:10:26 +0000
Received: from EX19MTAUEC002.ant.amazon.com (10.252.135.146) by
 EX19D022EUA002.ant.amazon.com (10.252.50.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 21 Feb 2025 16:10:25 +0000
Received: from email-imr-corp-prod-pdx-all-2b-c1559d0e.us-west-2.amazon.com
 (10.43.8.6) by mail-relay.amazon.com (10.252.135.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.39 via Frontend Transport; Fri, 21 Feb 2025 16:10:24 +0000
Received: from ua2d7e1a6107c5b.ant.amazon.com (dev-dsk-roypat-1c-dbe2a224.eu-west-1.amazon.com [172.19.88.180])
	by email-imr-corp-prod-pdx-all-2b-c1559d0e.us-west-2.amazon.com (Postfix) with ESMTPS id BED16404C9;
	Fri, 21 Feb 2025 16:10:16 +0000 (UTC)
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
Subject: [PATCH v4 10/12] KVM: selftests: adjust test_create_guest_memfd_invalid
Date: Fri, 21 Feb 2025 16:07:23 +0000
Message-ID: <20250221160728.1584559-11-roypat@amazon.co.uk>
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

BIT(0) is now a valid flag, corresponding to KVM_GMEM_NO_DIRECT_MAP, so
adjust test_create_guest_memfd_invalid to no longer assert it as an
invalid flag.

Signed-off-by: Patrick Roy <roypat@amazon.co.uk>
---
 tools/testing/selftests/kvm/guest_memfd_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index 38c501e49e0e..b2e7d4c96802 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -170,7 +170,7 @@ static void test_create_guest_memfd_invalid(struct kvm_vm *vm)
 			    size);
 	}
 
-	for (flag = BIT(0); flag; flag <<= 1) {
+	for (flag = BIT(1); flag; flag <<= 1) {
 		fd = __vm_create_guest_memfd(vm, page_size, flag);
 		TEST_ASSERT(fd == -1 && errno == EINVAL,
 			    "guest_memfd() with flag '0x%lx' should fail with EINVAL",
-- 
2.48.1


