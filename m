Return-Path: <linux-fsdevel+bounces-48961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D42AB6B27
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 14:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F3804C260A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 12:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624F2276037;
	Wed, 14 May 2025 12:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FJQRA3ot"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256251B4132
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 12:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747224871; cv=none; b=FLYyUMaiQjRZPu7S+gravt4Obx48UNCNVmpkLHeqSy+hCmyQhlpIldYwVhcIRe+LK6v8c7vdA1QzBWr3ASU5neEiDq6KF1j6YdG0n9A4Mh0KJk9LCNUucUgbMyA/Qm4wTNTLvQjHSi7wPtiaQI4YjSfHyFNh5ECcvZs8i9yMTok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747224871; c=relaxed/simple;
	bh=SMYFdfPmKkQFIR8TkjncJxZa8D146RGZ8rVWRlLToCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C24ayLhBzEvsCpj3cPNq6JyZ5oaCWWXXfVVVwJcmATBdUh8zzPVwPFGLsyTy5LYrpiXLbUn5kyWkxdQ7R0YqygTd30f6tvck2Kzzq3oPfeZAi274JhFhHN8urW4ts0vy4TtvoK09of4z3aZAIuOriOqlh/xxcSyKkkC4X1PYd+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FJQRA3ot; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747224868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6L9xo1oZrrwqtlMhuw7yfutiq5gkGV0q5xflk/Imsrk=;
	b=FJQRA3otnxs+pC5ye4vlGmYaMU3drJrKw3oZmJqIoUpCzTc5NKvrqfpyngT+CsfFehTkSG
	8sJCLzuuIemEZLouPZ7Jgu7/EcDoBXqPSIwzt9nFxAXEe0zcwYVwzDVmeVIXX/Z9GanO6a
	k8KDl59jESzuEKof9bxg0kOmrM5Mcus=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-308-umID3qIPPPG2DLqUtBlupQ-1; Wed,
 14 May 2025 08:14:27 -0400
X-MC-Unique: umID3qIPPPG2DLqUtBlupQ-1
X-Mimecast-MFC-AGG-ID: umID3qIPPPG2DLqUtBlupQ_1747224867
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 97CDB18002A5;
	Wed, 14 May 2025 12:14:26 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.44.32.219])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8AEA930001AA;
	Wed, 14 May 2025 12:14:24 +0000 (UTC)
From: Allison Karlitskaya <allison.karlitskaya@redhat.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	lis@redhat.com,
	Allison Karlitskaya <allison.karlitskaya@redhat.com>
Subject: [PATCH] fuse: add max_stack_depth to fuse_init_in
Date: Wed, 14 May 2025 14:14:15 +0200
Message-ID: <20250514121415.2116216-1-allison.karlitskaya@redhat.com>
In-Reply-To: <CAJfpegtdy7BYUpt795vGKFDHfRpyPVhqrL=gbQzauTvNawrZyw@mail.gmail.com>
References: <CAJfpegtdy7BYUpt795vGKFDHfRpyPVhqrL=gbQzauTvNawrZyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

FILESYSTEM_MAX_STACK_DEPTH is defined privately inside of the kernel,
but you need to know its value to properly implement fd passthrough on a
FUSE filesystem.  So far most users have been assuming its current value
of 2, but there's nothing that says that it won't change.

Use one of the unused fields in fuse_init_in to add a max_stack_depth
uint32_t (matching the max_stack_depth uint32_t in fuse_init_out). If
CONFIG_FUSE_PASSTHROUGH is configured then this is set to the maximum
value that the kernel will accept for the corresponding field in
fuse_init_out (ie: FILESYSTEM_MAX_STACK_DEPTH).

Let's not treat this as an ABI change: this struct is zero-initialized
and the maximum max_stack_depth is non-zero (and always will be) so
userspace can easily find out for itself if the value is present in the
struct or not.

Signed-off-by: Allison Karlitskaya <allison.karlitskaya@redhat.com>
---
 fs/fuse/inode.c           | 4 +++-
 include/uapi/linux/fuse.h | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index fd48e8d37f2e..46fd37eec9ae 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1497,8 +1497,10 @@ void fuse_send_init(struct fuse_mount *fm)
 #endif
 	if (fm->fc->auto_submounts)
 		flags |= FUSE_SUBMOUNTS;
-	if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
+	if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH)) {
 		flags |= FUSE_PASSTHROUGH;
+		ia->in.max_stack_depth = FILESYSTEM_MAX_STACK_DEPTH;
+	}
 
 	/*
 	 * This is just an information flag for fuse server. No need to check
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 5ec43ecbceb7..eb5d77d50176 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -895,7 +895,8 @@ struct fuse_init_in {
 	uint32_t	max_readahead;
 	uint32_t	flags;
 	uint32_t	flags2;
-	uint32_t	unused[11];
+	uint32_t	max_stack_depth;
+	uint32_t	unused[10];
 };
 
 #define FUSE_COMPAT_INIT_OUT_SIZE 8
-- 
2.49.0


