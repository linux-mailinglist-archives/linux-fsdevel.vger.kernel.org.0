Return-Path: <linux-fsdevel+bounces-59518-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA28B3AA32
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 20:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC6041702DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 18:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE2C2D29B7;
	Thu, 28 Aug 2025 18:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="mWn2IuPG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB7F27933A
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 18:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756406708; cv=none; b=Px5myMPfGmfaL7GQMJlA57/GDnYldqztIuDnBovTXjvzt5vbGOAlHjv8cN+Zg6dE6GJgGVwl4aMjG73zaTzFT1B7ZOYh9Og7XnVZZygzwAfDt75wiiADIdAR/K4Iew3M+xvVs2epUU5pC6YA0Bftgp5FsFJTttvlGAvRfltQDkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756406708; c=relaxed/simple;
	bh=x8ELUEO4zpbibIvbx2fhkv24vwSibg539brPVKqK0Ew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SqClZUXmlze1Z86OpPSqkhcLh/GdzWO/WQwRNZz7PbgFtfuJjfN1ddee+dKi7hA94sAP/LqJ7OpNcyGitg0/n+QigHEIqf+3O380ALNtTooLSadkVim9n4b+XDgTSrHyChEiQOKn/PKiboSCeerPHT7/WWFU5PFIbsRD/lwnsg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=mWn2IuPG; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71d60110772so9958307b3.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 11:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1756406705; x=1757011505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NJJoCqafY2R71TzE6L9BGRudxdiRZ8yK2jVs5bHbWUY=;
        b=mWn2IuPGl3/RVh4OAW8wrzLoYwnK+asL5arwy4hrcnSMdGuud1uOOPSI5zgHD2tZcN
         PigPulkEV597Qdd9vSBuBAWogj7WCFSS02CpKFBVq0B0rlYf8OE017nxNZNlunm7pVjn
         ckac6IB0DvS3cR5DedaQV9hbjKFXJjf1hWjoIn/bwN+Tvt6zRyUaBOOlXlDgcJ9gIxdB
         VIQ8ZgoFRsBvpsziwQJg88wjLBUZE2ikoa+U127+NqFnzDMMV/pB510BQOCA94HUXVVw
         Bz8bINWyZ3r3SGV7obzELHBYnBy/hduodKvUTbsDS8hMeZWL/Mz/YtXw5irmQ/weVS3W
         jU9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756406705; x=1757011505;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NJJoCqafY2R71TzE6L9BGRudxdiRZ8yK2jVs5bHbWUY=;
        b=hWlvFlmAioYGsRhbD9KTquQnCZfj5yLE6sobwE19eRlQzgQyp7K6l6za1fr5io5umC
         zkAt7wOTj+5WoSPzwCz8ejKFCOCGPCfMiPqOXS/oSKkc3n0Unin17njm3ggT55GfVA4r
         rV0ThRsM+GwgiZbZq8CEdxTUD/Y8gCRbDoGQalv6huf+SDmvojgVpzzh0NisPgJG6LrS
         B4YOMlWzZm7FcCGLfoFqdIhmrwxEm0rDMb20ErpjCLcDVMtMAy3aNs9Gvhcag/uqijbH
         96+HdPdKJwyaIYWk0URnb+TLHPL64hgdBpeiQ9M/8mdeUUtCNtbwCuL2VSNlWMMx9aEC
         iz+Q==
X-Forwarded-Encrypted: i=1; AJvYcCU8ljP++LySow1/pGUNyEGxb0lMi2KH29AtaC/z39ANqGl15KxdJ3ck1PLwgniamKSL+79sFJd7MiE7qQLK@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1HNChz8nHNIbRXFNAVN3rgec0s/3P6gvq93sp8v5hc5SGT7St
	VkbVVmFfENW9KZK6mlhSIetwRek98d4yWdNo81SwFIbDoDq1Kj8K93mYClikyPHKHEA=
X-Gm-Gg: ASbGnctkR6AQWQUsPBRi2zHe4UPsaPjXz7/kWzbhENYwWJvEIdHvfK0JFn0ORm+9ite
	DHPKnfjfksnHJMK9cQz/ttCkuCmvIoat0kbb6hPkLwOVfqtTMaG1HmudG5DR6VRO4SiZv2n5a2u
	80WhgDq9ukig5lmq0kh+hbqGop9OlgePYFHX6I50ruMX31AqYSs5xvZ8xx5Qbf5FRRm/SWz0Hht
	mHvSrlRngrnfYsWq97UaqllcM3b+7MBywyfDSAgBMiVEcAYdI9F9dAUBVLN3E6vtkBQkng+mN6J
	sUhSLL3JFi2xf1A6oRRC/qVrH7yX4MzeJP/Vbj2KiSGek494QDaB4b6kDl3c6Bt7ExGjpz4najq
	ox8zR4N4QP5FRK1ThxkTZfRlZeFwYpHvRzB7FtTFYNSsy18cbv5w=
X-Google-Smtp-Source: AGHT+IG3GoqyBGLBmGPhmOHqb16rK9P6upQaQINamt65amR5WQ/XeYvsof2WnR1hFv8BsS3/5X3Z2w==
X-Received: by 2002:a05:690c:968b:b0:71b:f56a:d116 with SMTP id 00721157ae682-71fdc2d2454mr278404217b3.2.1756406704820;
        Thu, 28 Aug 2025 11:45:04 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:450d:fa44:b650:10d9])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-721c630cc83sm1339417b3.11.2025.08.28.11.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 11:45:04 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com
Subject: [PATCH v2] ceph: fix potential NULL dereferenced issue in ceph_fill_trace()
Date: Thu, 28 Aug 2025 11:44:42 -0700
Message-ID: <20250828184441.83336-2-slava@dubeyko.com>
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

v2
Alex Markuze suggested to add unlikely macro
in the checking condition.

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
index fc543075b827..8ef6b3e561cf 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1739,6 +1739,11 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 			goto done;
 		}
 
+		if (unlikely(!in)) {
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
+		if (unlikely(!in)) {
+			err = -EINVAL;
+			goto done;
+		}
+
 		ihold(in);
 		err = splice_dentry(&req->r_dentry, in);
 		if (err < 0)
-- 
2.51.0


