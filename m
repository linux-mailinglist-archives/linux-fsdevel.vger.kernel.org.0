Return-Path: <linux-fsdevel+bounces-44227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6382CA66260
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 00:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DA033B7E17
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 23:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CC1205AB3;
	Mon, 17 Mar 2025 23:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AcW+LTzW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF8A18C33B
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Mar 2025 23:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742252686; cv=none; b=QpvakNTShzob0YPzfFShE/u3hHupIniX0JAD3lLagto/zbEvInGOTW6uCoUtDy2dWciHACRxw0RHHE++9IUbW3WA42HQ0DZxdlCvIJYBQWfFBRTHpOxC7r92r6v4+AT0vNMt4EMp6oKU32ikjQF22nxLlra/aDBlSvmAYxaO8I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742252686; c=relaxed/simple;
	bh=Yy70oMWOZQMwd3RKb7kqvh4omvBAkjSXrQ+l1ZlMjnY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oBhzfNVenRccdchCdOSyZAlhcDpb4BTVPxbFuWHRA+DpgbB8M3bk70GbKpE7n00JymGsIMCnn2Dss7ODLb8mncPR/xAptcgeMDi1By+n7Vda8AVP6XF4mbStqLMNx3oSv1iR0uMmASjQmVOP00PGqv49gk4VIagWrOgr1fITuOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AcW+LTzW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742252682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AHO8/RMWauQedkj7l6Avu6Pc03g5Wf/i1/CgriQQ/qQ=;
	b=AcW+LTzWE+faAAdeJqEgT0ZTh7czRF334SBka0BAjk97s7XsYjOpD0jmcjqha4cEPTELrF
	VfLTMAquhJGUufzBu3xSxYrueIQA3P+mjCKdu9zHcRahcmWQl1lAbK7o8+FEA21YRGLQVO
	Dfu0cPPoq8ioULeyp6jCtyis0Pm46To=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-568-h-QEZmJNMPqDOO63agHSmw-1; Mon,
 17 Mar 2025 19:04:39 -0400
X-MC-Unique: h-QEZmJNMPqDOO63agHSmw-1
X-Mimecast-MFC-AGG-ID: h-QEZmJNMPqDOO63agHSmw_1742252677
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C6D941955DCF;
	Mon, 17 Mar 2025 23:04:36 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.64.116])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BE1961955BE4;
	Mon, 17 Mar 2025 23:04:32 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kirill.shutemov@linux.intel.com
Cc: corbet@lwn.net,
	akpm@linux-foundation.org,
	surenb@google.com,
	pasha.tatashin@soleen.com,
	catalin.marinas@arm.com,
	david@redhat.com,
	jeffxu@chromium.org,
	andrii@kernel.org,
	xu.xin16@zte.com.cn
Subject: [PATCH] Documentation: Add "Unaccepted" meminfo entry
Date: Mon, 17 Mar 2025 17:04:03 -0600
Message-ID: <20250317230403.79632-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Commit dcdfdd40fa82 ("mm: Add support for unaccepted memory") added a
entry to meminfo but did not document it in the proc.rst file.

This counter tracks the amount of "Unaccepted" guest memory for some
Virtual Machine platforms, such as Intel TDX or AMD SEV-SNP.

Add the missing entry in the documentation.

Signed-off-by: Nico Pache <npache@redhat.com>
---
 Documentation/filesystems/proc.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 09f0aed5a08b..8fcf19c31b18 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -1060,6 +1060,7 @@ Example output. You may not have all of these fields.
     FilePmdMapped:         0 kB
     CmaTotal:              0 kB
     CmaFree:               0 kB
+    Unaccepted:            0 kB
     HugePages_Total:       0
     HugePages_Free:        0
     HugePages_Rsvd:        0
@@ -1228,6 +1229,8 @@ CmaTotal
               Memory reserved for the Contiguous Memory Allocator (CMA)
 CmaFree
               Free remaining memory in the CMA reserves
+Unaccepted
+              Memory that has not been accepted by the guest
 HugePages_Total, HugePages_Free, HugePages_Rsvd, HugePages_Surp, Hugepagesize, Hugetlb
               See Documentation/admin-guide/mm/hugetlbpage.rst.
 DirectMap4k, DirectMap2M, DirectMap1G
-- 
2.48.1


