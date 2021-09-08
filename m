Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81B3A403CC1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Sep 2021 17:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352164AbhIHPqa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 11:46:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50107 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352139AbhIHPq1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 11:46:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631115919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=muFBPGCZFIWVbsihvqYd16/c7qHbhJgPf0c3eVU/dH4=;
        b=DNBV4C5hbHMe7uBmtulzYgTKD1VfukQxXfrbm1FY9xWcdlWZayV4gr0i3eSUolRr9XiSE1
        ZNRdbRt91MrNSoDiZPzVbSZMY5RE/GihaaP2KQdBnEUTKzci4HJgTvtV4HA7zzz+vxyIhC
        NkQSfjgjczthCKypxe0DB275MPmw4gk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-vRY6YULoN0y3rGhWnlRXaQ-1; Wed, 08 Sep 2021 11:45:16 -0400
X-MC-Unique: vRY6YULoN0y3rGhWnlRXaQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90DCA1927800;
        Wed,  8 Sep 2021 15:45:14 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.195.121])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 93F4C1A26A;
        Wed,  8 Sep 2021 15:45:07 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-s390@vger.kernel.org, linux-mm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v1] hugetlbfs: s390 is always 64bit
Date:   Wed,  8 Sep 2021 17:45:06 +0200
Message-Id: <20210908154506.20764-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

No need to check for 64BIT. While at it, let's just select
ARCH_SUPPORTS_HUGETLBFS from arch/s390x/Kconfig.

Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: linux-s390@vger.kernel.org
Cc: linux-mm@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/Kconfig | 1 +
 fs/Kconfig        | 3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index a0e2130f0100..0113e8f703e5 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -110,6 +110,7 @@ config S390
 	select ARCH_STACKWALK
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_DEBUG_PAGEALLOC
+	select ARCH_SUPPORTS_HUGETLBFS
 	select ARCH_SUPPORTS_NUMA_BALANCING
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF
diff --git a/fs/Kconfig b/fs/Kconfig
index a7749c126b8e..44f5dba9f704 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -228,8 +228,7 @@ config ARCH_SUPPORTS_HUGETLBFS
 
 config HUGETLBFS
 	bool "HugeTLB file system support"
-	depends on X86 || IA64 || SPARC64 || (S390 && 64BIT) || \
-		   ARCH_SUPPORTS_HUGETLBFS || BROKEN
+	depends on X86 || IA64 || SPARC64 || ARCH_SUPPORTS_HUGETLBFS || BROKEN
 	help
 	  hugetlbfs is a filesystem backing for HugeTLB pages, based on
 	  ramfs. For architectures that support it, say Y here and read

base-commit: 7d2a07b769330c34b4deabeed939325c77a7ec2f
-- 
2.31.1

