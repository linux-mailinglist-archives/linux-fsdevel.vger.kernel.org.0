Return-Path: <linux-fsdevel+bounces-51603-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A62AD9485
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 20:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 722BB1E239D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 18:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79C9230BC9;
	Fri, 13 Jun 2025 18:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="Z1d3Phmg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E46757EA
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jun 2025 18:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749839714; cv=none; b=bOxYEPqvtB9X7QcvbH/ffYaVtfToQXWYwT4v5Z5bkWZiAQwBPHR7bKy8DCykvnK6bLDtiS9d9QntkKHhwvDckKL2ITPqYNk9tpN3S9fd8WfwdRPfBSceDUYgnji9Ckmk4fTt9piGCpzBKo4LjjG6nZdyUrqd85HlssBV//u/AW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749839714; c=relaxed/simple;
	bh=FzYI0Sker9fDBJGCSx1RvHWGeovX+wUmWT8o/1P8AS8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EHd8cVuse9Vkm1KtUkCeTN6b9VR7jmb6cB6ZnaqvUwqlDNZv/G8XDFoSlaHdqzBZ/o/kfCRj5rcCoqfs7MvHx50+DdnXfXKnu8gap2G+0L32g2qZmUVmQ+6m2Gpcodnwb5cBedFopfprCESpp8i+MxxM38m8YNOWF9IlRyvhnXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=Z1d3Phmg; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7113ac6d4b3so21011207b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jun 2025 11:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1749839709; x=1750444509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3OGn1R/yKE49/2aRgFT6tnkBXQ9m5DSCIwvtHbEVlnM=;
        b=Z1d3PhmgZQI/Sdrk4bUELJ1/i/dBq2R70hcqKwQ45GQ27SH2EaZ+7k0QAjZZjNpgjH
         VFBTFE1tM43gJNtbsOvEA0a2ErLb3l/aIOn5+GP+v7lLHxkTQx8CrATvnK3lVdEjeQWk
         lgDxGLDTN4SGHWWOImt7PYfiUuSxUJTcSLl1pUJdXrrIv2/WxMe+PwXXWAHoFHFyzprw
         NtfrfXJGH67+j4nu5QG1jQvJO65INrO6N85hMKcCL4Xadce7SlxVM1+56rFHqPvKyIu0
         NFhrjzExVC/HdkZSUs03WCSRBxxzEyn7/2XxkgE+ygnMr7Eacnf9QiVxjM8dGCpqRN9c
         5ykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749839709; x=1750444509;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3OGn1R/yKE49/2aRgFT6tnkBXQ9m5DSCIwvtHbEVlnM=;
        b=S65vnmw4VOgxfRSUFPLPr0T31JDLE6og1JIICrQ0gOwsssWft+njGwIAqcCuv2V5G3
         fqMqJJG33p4xPJ2t7xa5Wb1QJNZCbb1X/wKtzlnVS87rRfbRqbcSoZLWqQ3FZAzIah0o
         +ronnV0mu2zRT3LOnBgq94e1Y2331sVFRtFqVGGKUN+Zsk3kq46Pu9TzMCJnQ/mjtYww
         xoQHlVAQ+UlwY56geskx+DHTiD7sC/eI1VvPHg7o9fncW5rAU7uQk6nBqJ2LcxeD1Vxg
         W4sPxrn3Y3RE6JlF1EO8c6iGUTqlLHDOGwvqyzASQb5ckv7UaAO7pqOVhzCofTrcY5Kt
         2L1w==
X-Forwarded-Encrypted: i=1; AJvYcCUCxH1pC7/DJz9gzuujxgeAP6Ua0os8qvGp5N+0VpiyOMHC89CqGUCsucl5Ml+Wv7V8uOwx8vc24ERSbatK@vger.kernel.org
X-Gm-Message-State: AOJu0YxY/9rwzQftbSJhvF7OCwuKcaPK+is+Pj+puQzDLHpCfI3TtIIE
	yI8yqgP1XfHKxoqxBSEhE8L7SdEBDtyMjIReTcWUPLkermiHPF7RHX+lnDlulNKsAcc=
X-Gm-Gg: ASbGnctz10B9pRZ7sac652EJzPJV2q112dPeYVaWqH+QbdK8PIsK4aau1VIXHb4mxW8
	VNhmHGOP6UL8pxqol1Zkbi1ShcSGOe2tR8X4jWBY79OmA+1/jKT2cfb1aqgL6A0QGpdqe4rYmnN
	AtfZLuY3D6lWnj2h4DVcIlZJ46jLxpWClYjOfQQO7sNHvzTDb+Lh4jV/aDFWbxoHvnWa6ZYUixf
	nnCN6LdC3r2ZZiPhcSTNnDGuTCJ8awK5uDlUyoYpV95kuaBjKrufAtUDTsmGOFeWaaveAe4m2Ju
	E2H3lj9Bygaak2vf1NUG/ATwZlNE7h6ERFpMCfSLnpLx0UIQ4lg1GMZ+Q+Fkv2PfJA1GqRBryO+
	b/ke4
X-Google-Smtp-Source: AGHT+IEYQFcJLX8r6gHZUenmje7qRbAY6mp/2ab2kp/Vqwv3zjm9WKy1xxuOGiPIbEVuaCMSoe95cg==
X-Received: by 2002:a05:690c:3688:b0:70c:a854:8384 with SMTP id 00721157ae682-7117545cafemr8261317b3.11.1749839709594;
        Fri, 13 Jun 2025 11:35:09 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:a998:6e10:dab4:a72e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71152059c22sm7407097b3.4.2025.06.13.11.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 11:35:08 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com
Subject: [PATCH] ceph: fix potential race condition in ceph_ioctl_lazyio()
Date: Fri, 13 Jun 2025 11:34:53 -0700
Message-ID: <20250613183453.596900-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

The Coverity Scan service has detected potential
race condition in ceph_ioctl_lazyio() [1].

The CID 1591046 contains explanation: "Check of thread-shared
field evades lock acquisition (LOCK_EVASION). Thread1 sets
fmode to a new value. Now the two threads have an inconsistent
view of fmode and updates to fields correlated with fmode
may be lost. The data guarded by this critical section may
be read while in an inconsistent state or modified by multiple
racing threads. In ceph_ioctl_lazyio: Checking the value of
a thread-shared field outside of a locked region to determine
if a locked operation involving that thread shared field
has completed. (CWE-543)".

The patch places fi->fmode field access under ci->i_ceph_lock
protection. Also, it introduces the is_file_already_lazy
variable that is set under the lock and it is checked later
out of scope of critical section.

[1] https://scan5.scan.coverity.com/#/project-view/64304/10063?selectedIssue=1591046

Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
---
 fs/ceph/ioctl.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/ceph/ioctl.c b/fs/ceph/ioctl.c
index e861de3c79b9..60410cf27a34 100644
--- a/fs/ceph/ioctl.c
+++ b/fs/ceph/ioctl.c
@@ -246,21 +246,27 @@ static long ceph_ioctl_lazyio(struct file *file)
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_mds_client *mdsc = ceph_inode_to_fs_client(inode)->mdsc;
 	struct ceph_client *cl = mdsc->fsc->client;
+	bool is_file_already_lazy = false;
 
+	spin_lock(&ci->i_ceph_lock);
 	if ((fi->fmode & CEPH_FILE_MODE_LAZY) == 0) {
-		spin_lock(&ci->i_ceph_lock);
 		fi->fmode |= CEPH_FILE_MODE_LAZY;
 		ci->i_nr_by_mode[ffs(CEPH_FILE_MODE_LAZY)]++;
 		__ceph_touch_fmode(ci, mdsc, fi->fmode);
-		spin_unlock(&ci->i_ceph_lock);
+	} else
+		is_file_already_lazy = true;
+	spin_unlock(&ci->i_ceph_lock);
+
+	if (is_file_already_lazy) {
+		doutc(cl, "file %p %p %llx.%llx already lazy\n", file, inode,
+		      ceph_vinop(inode));
+	} else {
 		doutc(cl, "file %p %p %llx.%llx marked lazy\n", file, inode,
 		      ceph_vinop(inode));
 
 		ceph_check_caps(ci, 0);
-	} else {
-		doutc(cl, "file %p %p %llx.%llx already lazy\n", file, inode,
-		      ceph_vinop(inode));
 	}
+
 	return 0;
 }
 
-- 
2.49.0


