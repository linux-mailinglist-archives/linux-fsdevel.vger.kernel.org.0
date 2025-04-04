Return-Path: <linux-fsdevel+bounces-45779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E66A7C0E6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 17:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 662BC17C610
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 15:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F17B1F8729;
	Fri,  4 Apr 2025 15:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ltAzl5/F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59961F63EA;
	Fri,  4 Apr 2025 15:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743781513; cv=none; b=E/LHCd3IoR6p9nMrVuDYZv8LyGYvoigsuEpIuCsfgBO938hU719TvEGQZdQpy/WOUVHrPIKaoJlM4MWYX7KbGSyQubWlyPXVHK5ILt2RVwNY2N2Fu6LXklbReQPno0KUY96HEiYp9jJ4/As4YJwKbMjHCyFmkkwWU2bRuwLCKPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743781513; c=relaxed/simple;
	bh=KFCrx1jPJ3whNiHmZiSGu/LtWqL28KB0MKrtuiAq/94=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WUfToVC2Cc42UtwEkJsnG3g70yodLznA1/JsCUxQSGIaIqD/MbS4ofcHg9Eal2L46CRP8Z345asvqjCALN0ul3FxwLWWVu1wMZybql4HlQrmZCF3brZkL0/JUjZUrxu1gNBaPDxKRvcVcYkzf3TmnAwxyREh7kYcCOvAAU50X3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ltAzl5/F; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1743781512; x=1775317512;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GO+fOmyXj9EkRr/gRISxH91V61Pvwt+WgpsvJXpM3FY=;
  b=ltAzl5/FzdcR+5YRIBDrBkkwZcuXlRpC7t69j7SEhEzu/nBALuaz5It8
   fPSwAgL/qlzWNphY7JqTodRWQ/bXmAZ2eiOaBQiukDEYrvyvrzj8s7wwM
   QbFpAxRlIQuEklHrS7Z7cOn8SBbF1hiaSVy/XXgyOVWoHYQFFNwpMNrnC
   s=;
X-IronPort-AV: E=Sophos;i="6.15,188,1739836800"; 
   d="scan'208";a="393099257"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 15:45:08 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:38032]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.140:2525] with esmtp (Farcaster)
 id fdc68b7e-a4fc-4834-afdf-ba6792da542c; Fri, 4 Apr 2025 15:45:07 +0000 (UTC)
X-Farcaster-Flow-ID: fdc68b7e-a4fc-4834-afdf-ba6792da542c
Received: from EX19D003UWB002.ant.amazon.com (10.13.138.11) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 4 Apr 2025 15:45:01 +0000
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19D003UWB002.ant.amazon.com (10.13.138.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 4 Apr 2025 15:45:00 +0000
Received: from email-imr-corp-prod-iad-all-1b-3ae3de11.us-east-1.amazon.com
 (10.43.8.6) by mail-relay.amazon.com (10.252.135.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Fri, 4 Apr 2025 15:45:00 +0000
Received: from dev-dsk-kalyazin-1a-a12e27e2.eu-west-1.amazon.com (dev-dsk-kalyazin-1a-a12e27e2.eu-west-1.amazon.com [172.19.103.116])
	by email-imr-corp-prod-iad-all-1b-3ae3de11.us-east-1.amazon.com (Postfix) with ESMTPS id A0B33A0242;
	Fri,  4 Apr 2025 15:44:58 +0000 (UTC)
From: Nikita Kalyazin <kalyazin@amazon.com>
To: <akpm@linux-foundation.org>, <pbonzini@redhat.com>, <shuah@kernel.org>,
	<viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <muchun.song@linux.dev>,
	<hughd@google.com>
CC: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-fsdevel@vger.kernel.org>, <jack@suse.cz>,
	<lorenzo.stoakes@oracle.com>, <Liam.Howlett@Oracle.com>, <jannh@google.com>,
	<ryan.roberts@arm.com>, <david@redhat.com>, <jthoughton@google.com>,
	<peterx@redhat.com>, <graf@amazon.de>, <jgowans@amazon.com>,
	<roypat@amazon.co.uk>, <derekmn@amazon.com>, <nsaenz@amazon.es>,
	<xmarcalx@amazon.com>, <kalyazin@amazon.com>
Subject: [PATCH v3 5/6] mm: userfaultfd: add UFFD_FEATURE_MINOR_GUEST_MEMFD
Date: Fri, 4 Apr 2025 15:43:51 +0000
Message-ID: <20250404154352.23078-6-kalyazin@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250404154352.23078-1-kalyazin@amazon.com>
References: <20250404154352.23078-1-kalyazin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain

Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
---
 fs/userfaultfd.c                 | 3 ++-
 include/uapi/linux/userfaultfd.h | 8 +++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 97c4d71115d8..32152bfa462a 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1954,7 +1954,8 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
 	uffdio_api.features = UFFD_API_FEATURES;
 #ifndef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
 	uffdio_api.features &=
-		~(UFFD_FEATURE_MINOR_HUGETLBFS | UFFD_FEATURE_MINOR_SHMEM);
+		~(UFFD_FEATURE_MINOR_HUGETLBFS | UFFD_FEATURE_MINOR_SHMEM |
+		UFFD_FEATURE_MINOR_GUEST_MEMFD);
 #endif
 #ifndef CONFIG_HAVE_ARCH_USERFAULTFD_WP
 	uffdio_api.features &= ~UFFD_FEATURE_PAGEFAULT_FLAG_WP;
diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
index 2841e4ea8f2c..ed688797eba7 100644
--- a/include/uapi/linux/userfaultfd.h
+++ b/include/uapi/linux/userfaultfd.h
@@ -42,7 +42,8 @@
 			   UFFD_FEATURE_WP_UNPOPULATED |	\
 			   UFFD_FEATURE_POISON |		\
 			   UFFD_FEATURE_WP_ASYNC |		\
-			   UFFD_FEATURE_MOVE)
+			   UFFD_FEATURE_MOVE |			\
+			   UFFD_FEATURE_MINOR_GUEST_MEMFD)
 #define UFFD_API_IOCTLS				\
 	((__u64)1 << _UFFDIO_REGISTER |		\
 	 (__u64)1 << _UFFDIO_UNREGISTER |	\
@@ -230,6 +231,10 @@ struct uffdio_api {
 	 *
 	 * UFFD_FEATURE_MOVE indicates that the kernel supports moving an
 	 * existing page contents from userspace.
+	 *
+	 * UFFD_FEATURE_MINOR_GUEST_MEMFD indicates the same support as
+	 * UFFD_FEATURE_MINOR_HUGETLBFS, but for guest_memfd-backed pages
+	 * instead.
 	 */
 #define UFFD_FEATURE_PAGEFAULT_FLAG_WP		(1<<0)
 #define UFFD_FEATURE_EVENT_FORK			(1<<1)
@@ -248,6 +253,7 @@ struct uffdio_api {
 #define UFFD_FEATURE_POISON			(1<<14)
 #define UFFD_FEATURE_WP_ASYNC			(1<<15)
 #define UFFD_FEATURE_MOVE			(1<<16)
+#define UFFD_FEATURE_MINOR_GUEST_MEMFD		(1<<17)
 	__u64 features;
 
 	__u64 ioctls;
-- 
2.47.1


