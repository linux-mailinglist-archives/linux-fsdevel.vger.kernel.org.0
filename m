Return-Path: <linux-fsdevel+bounces-37057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CF59ECBC4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 13:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2C8F1627C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 12:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3DF2210EB;
	Wed, 11 Dec 2024 12:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ipvg6f/x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F64B209660
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2024 12:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733919087; cv=none; b=P3EyztzRrPFZhsxxkgm6CjouTKeS227+NVM7X0TbhPDyPrvcjtyIH8Rht4DEDfM+4g1PHYwaldhTUTLVe6Pyo7eb8Y41W5MFn7nIhh4+p/v029+POihnaESvZuXqGTV06705mq2DK+HLsHD2fCUg6CWEwoV4HUn9a6ByDKkRHVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733919087; c=relaxed/simple;
	bh=WKncBlVrIEckiGDzFEHninTQ03F1YT+gLvQhBh6YAho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R9DxWeiCDCmVKZUFMVt0RNZp3l63SAgTNn1zfupy3fozHhqybxHoLEEvr8RAcsFvXRN1El/VntHLaVwXjJbeR7hJI2nqEFGJ4A6bQd/DGjR99XWFGLJzoSb/hG9m2M20ib96p+9W3Kyh7TeQu9GtapiB1xA2/v3sdh4sD+GgZh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ipvg6f/x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733919083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gLdwmsIBE7jK5stVDngUdJnOwOLDtzp3iizvGFR+HqM=;
	b=ipvg6f/x7c+py478vV3rAYaUjQxd3hmPvBxC4OjQBCcrur+z+RQSWkumXrBkfrUmlsQn85
	PnHLM2AkSs+ytuXcQasYHYXIJBzmeUqDfAmiDiEbT3LUVnhuQp/qlERBKTafl7U5IZd2wz
	d8R/Tw1ZC1CvEisQzHoC/WmLNRTBUuQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-Ehc1fjcsOMWGzR5ETmSnPA-1; Wed, 11 Dec 2024 07:11:22 -0500
X-MC-Unique: Ehc1fjcsOMWGzR5ETmSnPA-1
X-Mimecast-MFC-AGG-ID: Ehc1fjcsOMWGzR5ETmSnPA
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aa65d975c40so182802266b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2024 04:11:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733919081; x=1734523881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gLdwmsIBE7jK5stVDngUdJnOwOLDtzp3iizvGFR+HqM=;
        b=gvT4AJBDosp4B71tVvtFPb5EbtBCPed8Rbx0ej4bLx5UzGOqq3X9A90u6IEWlvoLWB
         1hawNOhaltZViRL/iJscT1exrLm3fMTyqVYgeTxd+X9VAaNZc2vHluNU0vXCPweQjKCm
         b04zSwfZ+gQP0dXOAy9VFLRVsiy0WwaE/wdfgEQ91++sI85JZ79A1UpuwWBY3zibMT1V
         eb7bRZj4UuawlyLUjvhaUhCFglq37fqAeJjDK/sB+EOfuHDynOB9c6LyuU0OddTphbsv
         oFBPG3PdDdq/DQ5qEMSU48alNe/iSjhvGRJo7VTQ4zc5CTmBKQsS0iQNwIr9sWhLnsED
         96qw==
X-Gm-Message-State: AOJu0YxHr7qUNPKCjbpGcKNcnsh8+Bu16HIX5yfZiCMUsV4O4qlpF/FH
	rYS4R2c1f7DjKsEokOW6o3aWA3puyw0x6bnL1II4lbrjfRNK1YJHqSL01SeSc42finV/UPix01Z
	krVAVf/BEm5xX9y252hZq5lbNk2zvxUkYWl101c+J15V2eia/koXRCdTl070OM5+2JKa4ydBPSA
	==
X-Gm-Gg: ASbGncsAIOQN0EKM9xL2TnR3aSzCX2/4xdi1E7NetUkOWsZuQxx78lXzW6GKRbr4IVk
	ujp4ubyOS1rcXvO/b+4t856H4QLRlPU8czHqFyQXx3E1GEQmceOdSNCjIa6WP8W2J/hAB8FPN/J
	V3cznL3ClElNOIXuj/ABClDVcf4vt69SOPDNXTTvYm+b4wrmA6aGZpHawwnI37jJN/+zSo8hQ7G
	qnFEMiKIZNIETstijTbUA8rp2u349r54JXLZrqhSxvCwyiHR29N48xzt8qtQyrx7PeQ3LIWbPdL
	+EEWMAJiAaHHC2walLKsBKKyY+8SS7G4
X-Received: by 2002:a17:906:4c1:b0:aa6:7cae:db98 with SMTP id a640c23a62f3a-aa6b1141a54mr232894966b.10.1733919080841;
        Wed, 11 Dec 2024 04:11:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGn+9tNg7qM0MsjYiMIikQJQVEFRtrpJlQIw5d8nJQ+akaG9Z+TIu3BcfzfZK6NiP8vBpy0zg==
X-Received: by 2002:a17:906:4c1:b0:aa6:7cae:db98 with SMTP id a640c23a62f3a-aa6b1141a54mr232892366b.10.1733919080435;
        Wed, 11 Dec 2024 04:11:20 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (91-82-181-212.pool.digikabel.hu. [91.82.181.212])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa68d027f36sm421542966b.176.2024.12.11.04.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 04:11:19 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] fs: fix is_mnt_ns_file()
Date: Wed, 11 Dec 2024 13:11:17 +0100
Message-ID: <20241211121118.85268-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 1fa08aece425 ("nsfs: convert to path_from_stashed() helper") reused
nsfs dentry's d_fsdata, which no longer contains a pointer to
proc_ns_operations.

Fix the remaining use in is_mnt_ns_file().

Fixes: 1fa08aece425 ("nsfs: convert to path_from_stashed() helper")
Cc: <stable@vger.kernel.org> # v6.9
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---

Came across this while getting the mnt_ns in fsnotify_mark(), tested the
fix in that context.  I don't have a test for mainline, though.

 fs/namespace.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 23e81c2a1e3f..6eec7794f707 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2055,9 +2055,15 @@ SYSCALL_DEFINE1(oldumount, char __user *, name)
 
 static bool is_mnt_ns_file(struct dentry *dentry)
 {
+	struct ns_common *ns;
+
 	/* Is this a proxy for a mount namespace? */
-	return dentry->d_op == &ns_dentry_operations &&
-	       dentry->d_fsdata == &mntns_operations;
+	if (dentry->d_op != &ns_dentry_operations)
+		return false;
+
+	ns = d_inode(dentry)->i_private;
+
+	return ns->ops == &mntns_operations;
 }
 
 struct ns_common *from_mnt_ns(struct mnt_namespace *mnt)
-- 
2.47.0


