Return-Path: <linux-fsdevel+bounces-59428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFA1B389FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 21:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53E577A7542
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 19:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D0B277CB2;
	Wed, 27 Aug 2025 19:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="gu9ObVSa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A7F76025
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 19:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756321314; cv=none; b=RuuTGf88wS06qW4uWO6OJ7QNP9qCJnPJnJb7K3Jgxwb2pJ/FNyMac4XuuWJO/zhKmmZb2npoA6rSeZnmZfcNIloXrK44XfRKX9DEUa7G1+OT3CO2TsB0BvWZ8ofk0R/zsMLu+P6ySCsa1Yn59GtGyzbhBoIVZ8YrqE+bkEn+56s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756321314; c=relaxed/simple;
	bh=jTXCrqurI35lVDo9byI/H5H5ftA0NEhdYNk09tAKuDk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MIh1lQJaO/kgxXcfFe5faTBvIXthsSjXjWyeO5TkNMgTV5p2PC4P87ED6VeTmFf5noUym8Nsu3bXekDR8M8/s3GootZfjdgrOmQcbEPDTh07jOI/s769D06fIb878el9Ldkgb6Q2P5aRMG9TnSQTdkH35ewDDKZpWG6Bip3DEMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=gu9ObVSa; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-71d71bcab6fso1395607b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 12:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1756321311; x=1756926111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W6gehJLOxzkyNftXjEdQOXi6ukSj/HJus3mrt7hMc1g=;
        b=gu9ObVSaHLxBKLEwB5I7mQ6UmI6BXNzONSjHL3m9qFIML5QqMWX79nnYECWFLG6fiY
         VIRBskS8NfcZu5zRm91mLkmwcDQthEGd1GmDTsyjlhJiLa1yDHUAbcfT6aevVVCiIENY
         N0PhRcy9jVYb5nKuDvPBDv6oHDa1CEuwya1hV+mKoZHualfqI04xGN1GzpflVlED+5pg
         T16zV04W9sdZpWyeWR03IZRLHQkV+8HaZ3aK+WYJbgJ+ZTuX883De7g3vxBG3QMZEBcp
         R39y+5PBChE1GP8ze+GBknp+ztZ1+56XfTGqtTOrGYUU726ipbsIj2c6T4XnZPLfpTrD
         7o9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756321311; x=1756926111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W6gehJLOxzkyNftXjEdQOXi6ukSj/HJus3mrt7hMc1g=;
        b=k0pKq/7O78TTXbcPLvcuQzVaXuRtmZQhImVKmAwxSqX6H+r7QSC0uiikR1GgIsnhrI
         wYfiLMZbPzxofZSJrTsgX471/PBbcHq7dFIY2Oq8LjCNBzfMwBb/T3TFCIzFzYQdYHP6
         cLVyfrfwYq7dDba/yySgIW4XYMZjTli8xsSioxhvmwhN4ogGbvF9kby8PHeIR79EXXun
         OAHw1MKIwrkRR6nm/BTullYpI6TF8jh5Y7UFZMzK4hQ7fYblTb+OM0MnJrSs1C/owPWL
         jrXkcizefc5+TqWjh5jbWr0KC82jH47cB/4BRnei/qbI2nzZHR/D96SfG2SPemTnrosR
         uvCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLD4Rqt9VhcglD3HwHCYDAGcyfR+dMDGiDOMhsaTGBj2cV3VJRJjug27iEenj/5wr15ZH6QskWfT5aL88H@vger.kernel.org
X-Gm-Message-State: AOJu0YwgrNYfP5n3AUfCOVE5pBIf2xnnAavoTRySo9Lyhta1FxOVPqYb
	b2ZOieSkLP+AiMcqkhhBvLK7fF9HG/t0ieHQ+QPQ8ij1+NgpsMi8iSCvLJfrdi+S/2bKnWWl7sa
	OkQ9ia3fwBg==
X-Gm-Gg: ASbGncsZDs5afwyknDz6UCyW4x73YAkW11uuuvvoXZu4P93pxFMXQ1UGY1h0423WwJU
	uuFFdXylpG1G1C1U6R4xyhWzUTQ+NfvgtMQaf6PTzHS0l9wjVn5bjnVtwejqI4naMAU14XUotOc
	T5BtcmBQ23gVSSa+UezNpvRjNQiO6VFccvv+2qFlkTchf8NKYqsQN4MaiEGsiuczjA2pdHRg7Lo
	YvlNOkjxetbrOysV+HpLWbPbERWKqltClBKoz+bWnYoTm0woG9DpS6TNiq6YVx3+rGawuROljBs
	ezhVKJDm5XzLT6UdBjr7+Ce5inN4qXV8uZCnAhDm/RuGcx8hq/i/zaFKMtyg6pey9lLedPIAuCk
	diTuCDye15wYZQ47Zi5Mr70ZXYWkZUK3+HdYZOfKl
X-Google-Smtp-Source: AGHT+IHwoKF0+aFawZrS0k1KCAl1JFeBaHRBi5bmOFhJNIPcL8cXpeT52Jm5OpxDriusRFF4u/5jJA==
X-Received: by 2002:a05:690c:6106:b0:720:4ec:3f89 with SMTP id 00721157ae682-72004ec4967mr133070077b3.46.1756321311471;
        Wed, 27 Aug 2025 12:01:51 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:4e16:8eb2:d704:13fb])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff18aea32sm32951437b3.53.2025.08.27.12.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 12:01:50 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com
Subject: [PATCH] ceph: fix potential NULL dereferenced issue in ceph_fill_trace()
Date: Wed, 27 Aug 2025 12:01:23 -0700
Message-ID: <20250827190122.74614-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

The Coverity Scan service has detected a potential dereference of
an explicit NULL value in ceph_fill_trace() [1].

The variable in is declared in the beggining of
ceph_fill_trace() [2]:

struct inode *in = NULL;

However, the initialization of the variable is happening under
condition [3]:

if (rinfo->head->is_target) {
    <skipped>
    in = req->r_target_inode;
    <skipped>
}

Potentially, if rinfo->head->is_target == FALSE, then
in variable continues to be NULL and later the dereference of
NULL value could happen in ceph_fill_trace() logic [4,5]:

else if ((req->r_op == CEPH_MDS_OP_LOOKUPSNAP ||
            req->r_op == CEPH_MDS_OP_MKSNAP) &&
            test_bit(CEPH_MDS_R_PARENT_LOCKED, &req->r_req_flags) &&
             !test_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags)) {
<skipped>
     ihold(in);
     err = splice_dentry(&req->r_dentry, in);
     if (err < 0)
         goto done;
}

This patch adds the checking of in variable for NULL value
and it returns -EINVAL error code if it has NULL value.

[1] https://scan5.scan.coverity.com/#/project-view/64304/10063?selectedIssue=1141197
[2] https://elixir.bootlin.com/linux/v6.17-rc3/source/fs/ceph/inode.c#L1522
[3] https://elixir.bootlin.com/linux/v6.17-rc3/source/fs/ceph/inode.c#L1629
[4] https://elixir.bootlin.com/linux/v6.17-rc3/source/fs/ceph/inode.c#L1745
[5] https://elixir.bootlin.com/linux/v6.17-rc3/source/fs/ceph/inode.c#L1777

Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Ceph Development <ceph-devel@vger.kernel.org>
---
 fs/ceph/inode.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index fc543075b827..dee2793d822f 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1739,6 +1739,11 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 			goto done;
 		}
 
+		if (!in) {
+			err = -EINVAL;
+			goto done;
+		}
+
 		/* attach proper inode */
 		if (d_really_is_negative(dn)) {
 			ceph_dir_clear_ordered(dir);
@@ -1774,6 +1779,12 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 		doutc(cl, " linking snapped dir %p to dn %p\n", in,
 		      req->r_dentry);
 		ceph_dir_clear_ordered(dir);
+
+		if (!in) {
+			err = -EINVAL;
+			goto done;
+		}
+
 		ihold(in);
 		err = splice_dentry(&req->r_dentry, in);
 		if (err < 0)
-- 
2.51.0


