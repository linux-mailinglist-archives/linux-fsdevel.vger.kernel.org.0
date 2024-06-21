Return-Path: <linux-fsdevel+bounces-22142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 650C8912D13
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 20:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3952B24E21
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 18:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7F317B42E;
	Fri, 21 Jun 2024 18:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OsMUY6L+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C611017B40F
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Jun 2024 18:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718993564; cv=none; b=huBA+Quze6afKJ6MS4iuPrbz+HEkSb1XDU1LONN/J62aViCMEKD3b3de7N7CQmEUKYgJqT9TC66RioqoDA/KFzTredH2aPrX5D3GH9hIcfrpzQJjR4WhKVE8Udo7wrE4W85WLCIqkoj+bBJR12aWweBPG0aPWVKMI6immDIn4pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718993564; c=relaxed/simple;
	bh=qkKdzACF1keOV6J4gFQTNFSJosbImY3UiiUaqJIsSvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b5cAmNI9PrHo3kimwubGpHi2RN5Ys1kjoD/MkaLe44VV4M6nv5T62Dp06Tpoic6h2d2UYvRQKxhEKIL0hRbCuMnKFTP4W5eDN0Tsj7wNhe4OYLhkh47cluQH5WG66p94eO1MgxtKgYbt5cZHRY4j8bysoCNkEUEXc/4+dRUF2wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OsMUY6L+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718993561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=udTceohd6Xr0o0t6E07fDA2ozt9gdMnkrdCtTzzon0Y=;
	b=OsMUY6L+QEUy44HxbeyYpFohLSxmoVFX3WpU3UMYrstzrOLCvpK6ob3W9WOFLKdv/eDJ02
	2OsFcbw7iUY2ZLfcBjzGtFFEXA63b6je8Dghr+w4i0gh2IGkUW2G1vlurvwSwfoBXuvDZj
	4eN76bkKeqJRYAeIT1A9sCIlCBnPr/Y=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-215-1EwU5UKBM66XOkdkmdarqQ-1; Fri,
 21 Jun 2024 14:12:36 -0400
X-MC-Unique: 1EwU5UKBM66XOkdkmdarqQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C4AB819560B8;
	Fri, 21 Jun 2024 18:12:34 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.33.154])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4F6AE1956056;
	Fri, 21 Jun 2024 18:12:31 +0000 (UTC)
From: Audra Mitchell <audra@redhat.com>
To: viro@zeniv.linux.org.uk
Cc: brauner@kernel.org,
	jack@suse.cz,
	aarcange@redhat.com,
	akpm@linux-foundation.org,
	rppt@linux.vnet.ibm.com,
	shli@fb.com,
	peterx@redhat.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	raquini@redhat.com
Subject: [PATCH v2 2/3] Update uffd-stress to handle EINVAL for unset config features
Date: Fri, 21 Jun 2024 14:12:23 -0400
Message-ID: <20240621181224.3881179-2-audra@redhat.com>
In-Reply-To: <20240621181224.3881179-1-audra@redhat.com>
References: <20240621181224.3881179-1-audra@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Now that we have updated userfaultfd_api to correctly return
EIVAL when a feature is requested but not available, let's fix
the uffd-stress test to only set the UFFD_FEATURE_WP_UNPOPULATED
feature when the config is set. In addition, still run the test if
the CONFIG_PTE_MARKER_UFFD_WP is not set, just dont use the corresponding
UFFD_FEATURE_WP_UNPOPULATED feature.

Signed-off-by: Audra Mitchell <audra@redhat.com>
---
 tools/testing/selftests/mm/uffd-stress.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index f78bab0f3d45..b9b6d858eab8 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -38,6 +38,8 @@
 
 #ifdef __NR_userfaultfd
 
+uint64_t features;
+
 #define BOUNCE_RANDOM		(1<<0)
 #define BOUNCE_RACINGFAULTS	(1<<1)
 #define BOUNCE_VERIFY		(1<<2)
@@ -247,10 +249,14 @@ static int userfaultfd_stress(void)
 	unsigned long nr;
 	struct uffd_args args[nr_cpus];
 	uint64_t mem_size = nr_pages * page_size;
+	int flags = 0;
 
 	memset(args, 0, sizeof(struct uffd_args) * nr_cpus);
 
-	if (uffd_test_ctx_init(UFFD_FEATURE_WP_UNPOPULATED, NULL))
+	if (features & UFFD_FEATURE_WP_UNPOPULATED && test_type == TEST_ANON)
+		flags = UFFD_FEATURE_WP_UNPOPULATED;
+
+	if (uffd_test_ctx_init(flags, NULL))
 		err("context init failed");
 
 	if (posix_memalign(&area, page_size, page_size))
@@ -385,8 +391,6 @@ static void set_test_type(const char *type)
 
 static void parse_test_type_arg(const char *raw_type)
 {
-	uint64_t features = UFFD_API_FEATURES;
-
 	set_test_type(raw_type);
 
 	if (!test_type)
@@ -409,8 +413,8 @@ static void parse_test_type_arg(const char *raw_type)
 	 * feature.
 	 */
 
-	if (userfaultfd_open(&features))
-		err("Userfaultfd open failed");
+	if (uffd_get_features(&features))
+		err("failed to get available features");
 
 	test_uffdio_wp = test_uffdio_wp &&
 		(features & UFFD_FEATURE_PAGEFAULT_FLAG_WP);
-- 
2.44.0


