Return-Path: <linux-fsdevel+bounces-18946-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 857EF8BEDC2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 22:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5FD11C21C01
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 20:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A632F16F270;
	Tue,  7 May 2024 19:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CgeUslUg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E44116E869
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 May 2024 19:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715111722; cv=none; b=tzdnEN1pjxNsNQen1VwSFjG/O6f8TeOPAzLgA7RLT/breOR4YBVZ7VAs6lbR8uBiqx7cvKx16QW8CkndkSUawEElMzc6GPLmcBMTDRjNhUHcGJbTDts/hIbo1pByFu0aaR7LjMOGg7EhCdLzP/XixRpgjgASoHExyJvTsKg5UKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715111722; c=relaxed/simple;
	bh=a0wY0qoFOsxghYv4yN8+yu9MTxt8hu8AS20FIolS/uU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SOsI7ebJTxI4if3fPCXPaP9DIv/lmrojJvQwRxYolf4AYMI8IcBAMBwh+uzDOnj9ZCToCZUGnH3IPLdamsxWAjeRk9EZEqkz0gMfTk+DID0RcZcREsjtcVWQjNnHjeChyet/f1g/XRHkpAQS+Vqw/u5NUXihVIduDzKfqGzbiLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CgeUslUg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715111719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qlhwsbkKKVd2ohQ0kuBs8V/ScuJpgv65EhyU0mX2mEQ=;
	b=CgeUslUgf9ItBqGZOF46n0bgbqSpIiUg+n9kQmG5AqFfC+swUomEeT1vbjwfklS0owqhMj
	fxvBUAopnE8SjCXIsZDsr0M/pxtvdKWBH6tMYz2kFOLHMb5ijpUR7qirseJS7wHb4KiKTr
	6X5HffJRxUSQSIXOj+86aIWTjFBmocY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-567-BSvfzLQPO9mBz_2vPSWUpg-1; Tue,
 07 May 2024 15:55:16 -0400
X-MC-Unique: BSvfzLQPO9mBz_2vPSWUpg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6BBCD1C031BB;
	Tue,  7 May 2024 19:55:15 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.18.45])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 21C3820B96E0;
	Tue,  7 May 2024 19:55:15 +0000 (UTC)
From: Audra Mitchell <audra@redhat.com>
To: viro@zeniv.linux.org.uk
Cc: brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	raquini@redhat.com
Subject: [PATCH 1/2] Fix userfaultfd_api to return EINVAL as expected
Date: Tue,  7 May 2024 15:55:09 -0400
Message-ID: <20240507195510.283744-1-audra@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Currently if we request a feature that is not set in the Kernel
config we fail silently and return the available features. However, the
documentation indicates we should return an EINVAL.

We need to fix this issue since we can end up with a Kernel warning
should a program request the feature UFFD_FEATURE_WP_UNPOPULATED on
a kernel with the config not set with this feature.

Signed-off-by: Audra Mitchell <audra@redhat.com>
---
 fs/userfaultfd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 60dcfafdc11a..17210558de79 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -2073,6 +2073,11 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
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


