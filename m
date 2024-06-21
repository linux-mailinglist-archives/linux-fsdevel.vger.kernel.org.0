Return-Path: <linux-fsdevel+bounces-22141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 643D3912D0E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 20:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11E0D1F25AA9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 18:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F99179202;
	Fri, 21 Jun 2024 18:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RQl5Q5CU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE336156227
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Jun 2024 18:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718993558; cv=none; b=ijku81m3KuPclHwjDjqps85K2G6RSyLboQJ8WsO2YOkiB1KhJm5ZIn4kiwWXT3UPR6rxLcNdXNX/GjmnyJEhgHcA/0wt+CkLLGlqcifd51HrefTjHkoNIa9/e3rXKlaIz51A9WKW1/uuM5ze5U4XWAQwPAPBiSLMvpY+GtYmTlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718993558; c=relaxed/simple;
	bh=zn0J5hnyo6dVCxNaGHylzs/o0p86kxCsjWOV/SevYqw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sacmyqp13bzouOd8ga1Xc9RvWfmhrMaWV4kPq4cCFuIs4i7VlIBxdLfPHni8p2nOQtIUsjD+YeQBYUHjPZkCq1HVQ0yq2gZ4ZEltU5CfsnmaDwf9c6WNHrFhxmpOL8rr4dnI9NaOmHv53gh88xeWNeoGdp2ivoFrRqk2WHVzgfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RQl5Q5CU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718993555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Mr03uo/qNadzOQlFY//QZdUfSWytOj/GgGVXQ4GRB8Q=;
	b=RQl5Q5CUGP+WN80rpAole8uPiINqK/u/SGTokYsDx97IdwXpbzynmaLwIRh5kfmWUJq3eb
	iGK/ARwXowPgXT+HedJ64M6c4r8KXdkKWvSrmztvQz2FIiVmzJMpqCojkqCo4fp39R1tV2
	ZBq03tyfPyN7JfHHrqx2EcNRvhxuOWI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-333-RT0_tw-tOvOI7aOA-C_GCg-1; Fri,
 21 Jun 2024 14:12:32 -0400
X-MC-Unique: RT0_tw-tOvOI7aOA-C_GCg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2923219560A2;
	Fri, 21 Jun 2024 18:12:30 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.33.154])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 73F821956048;
	Fri, 21 Jun 2024 18:12:27 +0000 (UTC)
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
Subject: [PATCH v2 1/3] Fix userfaultfd_api to return EINVAL as expected
Date: Fri, 21 Jun 2024 14:12:22 -0400
Message-ID: <20240621181224.3881179-1-audra@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Currently if we request a feature that is not set in the Kernel
config we fail silently and return all the available features. However,
the man page indicates we should return an EINVAL.

We need to fix this issue since we can end up with a Kernel warning
should a program request the feature UFFD_FEATURE_WP_UNPOPULATED on
a kernel with the config not set with this feature.

 [  200.812896] WARNING: CPU: 91 PID: 13634 at mm/memory.c:1660 zap_pte_range+0x43d/0x660
 [  200.820738] Modules linked in:
 [  200.869387] CPU: 91 PID: 13634 Comm: userfaultfd Kdump: loaded Not tainted 6.9.0-rc5+ #8
 [  200.877477] Hardware name: Dell Inc. PowerEdge R6525/0N7YGH, BIOS 2.7.3 03/30/2022
 [  200.885052] RIP: 0010:zap_pte_range+0x43d/0x660

Fixes: e06f1e1dd499 ("userfaultfd: wp: enabled write protection in userfaultfd API")
Signed-off-by: Audra Mitchell <audra@redhat.com>
---
 fs/userfaultfd.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index eee7320ab0b0..17e409ceaa33 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -2057,7 +2057,7 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
 		goto out;
 	features = uffdio_api.features;
 	ret = -EINVAL;
-	if (uffdio_api.api != UFFD_API || (features & ~UFFD_API_FEATURES))
+	if (uffdio_api.api != UFFD_API)
 		goto err_out;
 	ret = -EPERM;
 	if ((features & UFFD_FEATURE_EVENT_FORK) && !capable(CAP_SYS_PTRACE))
@@ -2081,6 +2081,11 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
 	uffdio_api.features &= ~UFFD_FEATURE_WP_UNPOPULATED;
 	uffdio_api.features &= ~UFFD_FEATURE_WP_ASYNC;
 #endif
+
+	ret = -EINVAL;
+	if (features & ~uffdio_api.features)
+		goto err_out;
+
 	uffdio_api.ioctls = UFFD_API_IOCTLS;
 	ret = -EFAULT;
 	if (copy_to_user(buf, &uffdio_api, sizeof(uffdio_api)))
-- 
2.44.0


