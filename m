Return-Path: <linux-fsdevel+bounces-56352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F15B16697
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 20:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B22303B4D24
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 18:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54852E1C5D;
	Wed, 30 Jul 2025 18:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="gfEuhADa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061FA2E172D
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Jul 2025 18:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753901664; cv=none; b=H+/CfBqfWB2agSbOMrt00pnnMWymfDd3n/K3qgMry/uG8QQZ7tVt1mWZhyGfs2lRuXMiKWGuNpI2GV3fYLhs5K9MuHnx56rYOaqB57Hq3filuylfVQvkevoLgm+kGNGM6sdBNxVw+PnSFD2vwUAllmXgY2CtUp6uxuxs1cFhI5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753901664; c=relaxed/simple;
	bh=XtM6JG/OpIBpA8abZfcJPmuPS2KKJYSZyVLxQ1FWo2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VFHIrIrx/hWOjdvyCoVrRv3Smf2fQ7t6c5QGhM9Bx58PuV/KPOS6EN4aXspG6jWHN+Lqcn69OCtj74ggDrIZWdKhq/XXwuFeAVZhMD43WqLjOeGIdX22+2hlKh9+FqHOpxj94AFUocNpoSkjsebGB4Bm3dKkhP3B+AliGp+Rx0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=gfEuhADa; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e8e21180c55so172734276.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Jul 2025 11:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1753901661; x=1754506461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BOBue1rW0D08akK+2cb46wz7cLtVwQa85mat/MzXO7Y=;
        b=gfEuhADaYvo4GQeJTjn9FcN/fdIsgvc8qHw7q3XNqrfYr0MUPUDpBEl4CoCd0ZdHEx
         ae9i/tWKK3DJAW8kiOB0hs+s8HH+cjZdiYhvjkPl6hI4z3StMKGES0oJEoWgUtRvw+x0
         4Bihhbq1BEfpx5kDCDX6zKzz+m8ZNtg+fOk27BMtQ/GeKiWnABXRSl26wRtoMT02yKj3
         MVvZMLHZbavXeJtYTJfy59LzE65Q5maXy3SYpsWZrA3gc0RSt3lt8mxoTMmS8MWMExVo
         /g6mTKHOewVnPN4/9G+DDMUVb2Tsfx4k++R59MEtJpzBPrBzTMf8U8fKuJcRlQBTCw0Z
         XBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753901661; x=1754506461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BOBue1rW0D08akK+2cb46wz7cLtVwQa85mat/MzXO7Y=;
        b=gACJTh6At8slvS4PaoOjNzmAKRyQjAouYZnVk5mr6fZv4D/ua4sWCqwbf0g0Pia6Fz
         lNmT2j0c5Rd9MpjA9iItv89P/TK8eXzto433nuieJyo/U1JugyGN1W6mvWPUZUOxDzBb
         5XllBZRxnmf9b+r8IJGAAdkf9Ih+vfiAuOh0A3uIQv0wG/Bf+z3+V5KcYfD35h0rlO/f
         iuCQ/cFk0CewUbiURXNt5aOWFmdxgRm+4C1ORf6LT2Zer1oCGm6mesYHSiqxibBTXj8g
         iG+SvARVA/JumMlnJqeyIJMVeNYZWmuYr1s52jIo8RPmtAP0tOAGapcudo05A3MByfgg
         GCsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYnIGTp/upUaY4QJWtFlS7dl+U4CRKsornIgAJIM0eO+LiY3ZWC+2PuDgl4ZtfHdps9HrrpHrZyqM4yryg@vger.kernel.org
X-Gm-Message-State: AOJu0YwDpRpYH0a4ZEP6Q1Bk33xIifT3Y3r39gnNRjMYyc6GjudSt/H6
	am0ZdcthDPpEpS9pxJf6YQ/UtiqXMJwyAl7BVlCEsLalnNGbjqDxWRpaUllDvWRPZsY=
X-Gm-Gg: ASbGnctJvvZp3S6BnCKIF+p5iHfETuBMN92BA58TtX6U432M+Zjp69NKaAag+A32leH
	B5AXfVmxhyA16AVcnjD/YLgB/gp9NnN3ZlKkb677HaDWETasjxgUQXakryjnH+VBoQaTDyLlwvZ
	9ze33CAm3eqYHrFok1bvKHYStJLkCR9z3vopqxfu7WYiQafGRszsWUCOLa1lFvLSBukyLzQDzPc
	OkFDRtWhBogITsT6BITPDgXmvO69vfGfUa38RErJyG0AwRCXajyi/DR392dqF0CTzP0JaC1aNQy
	YEaq9uF6Z/1VSA/PdbFGR2kcAv2qYq39NeZrNcydN2J47lC9KVLYVSPE4p4JDjPcSyNtH/p1AuY
	HIWC3zQCMyZdnUKa6cKboizY1maUW35R3R7XcY8o=
X-Google-Smtp-Source: AGHT+IE8po90BmWOmy7rifQVl+VDOjBkYeJfiHVERW3g0hFbqcBJv78cTBAuYI4Ph44Wm5OU0ChShQ==
X-Received: by 2002:a05:690c:7408:b0:71a:3484:abe8 with SMTP id 00721157ae682-71a466ada6dmr67298137b3.34.1753901660815;
        Wed, 30 Jul 2025 11:54:20 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:4964:e64f:4b7:1866])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-719f23e0f06sm25597707b3.71.2025.07.30.11.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 11:54:19 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com
Subject: [PATCH] ceph: cleanup in __ceph_do_pending_vmtruncate() method
Date: Wed, 30 Jul 2025 11:54:11 -0700
Message-ID: <20250730185411.1105738-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

The Coverity Scan service has detected an unchecked return
value in __ceph_do_pending_vmtruncate() method [1].

The CID 114041 contains explanation: " Calling
filemap_write_and_wait_range without checking return value.
If the function returns an error value, the error value
may be mistaken for a normal value. Value returned from
a function is not checked for errors before being used.
(CWE-252)".

The patch adds the checking of returned value of
filemap_write_and_wait_range() and reporting the error
message if something wrong is happened during the call.
It reworks the logic by removing the jump to retry
label because it could be the reason of potential
infinite loop in the case of error condition during
the filemap_write_and_wait_range() call. It was removed
the check to == ci->i_truncate_pagecache_size because
the to variable is set by ci->i_truncate_pagecache_size
in the above code logic. The uneccessary finish variable
has been removed because the to variable always has
ci->i_truncate_pagecache_size value. Now if the condition
ci->i_truncate_pending == 0 is true then logic will jump
to the end of the function and wake_up_all(&ci->i_cap_wq)
will be called.

[1] https://scan5.scan.coverity.com/#/project-view/64304/10063?selectedIssue=114041

Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Ceph Development <ceph-devel@vger.kernel.org>
---
 fs/ceph/inode.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index fc543075b827..53ce776b04b5 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2203,17 +2203,17 @@ void __ceph_do_pending_vmtruncate(struct inode *inode)
 	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	u64 to;
-	int wrbuffer_refs, finish = 0;
+	int wrbuffer_refs;
+	int err;
 
 	mutex_lock(&ci->i_truncate_mutex);
-retry:
 	spin_lock(&ci->i_ceph_lock);
+
+	wrbuffer_refs = ci->i_wrbuffer_ref;
 	if (ci->i_truncate_pending == 0) {
 		doutc(cl, "%p %llx.%llx none pending\n", inode,
 		      ceph_vinop(inode));
-		spin_unlock(&ci->i_ceph_lock);
-		mutex_unlock(&ci->i_truncate_mutex);
-		return;
+		goto out_unlock;
 	}
 
 	/*
@@ -2224,9 +2224,14 @@ void __ceph_do_pending_vmtruncate(struct inode *inode)
 		spin_unlock(&ci->i_ceph_lock);
 		doutc(cl, "%p %llx.%llx flushing snaps first\n", inode,
 		      ceph_vinop(inode));
-		filemap_write_and_wait_range(&inode->i_data, 0,
-					     inode->i_sb->s_maxbytes);
-		goto retry;
+		err = filemap_write_and_wait_range(&inode->i_data, 0,
+						   inode->i_sb->s_maxbytes);
+		spin_lock(&ci->i_ceph_lock);
+
+		if (unlikely(err)) {
+			pr_err_client(cl, "failed of flushing snaps: err %d\n",
+					err);
+		}
 	}
 
 	/* there should be no reader or writer */
@@ -2242,20 +2247,17 @@ void __ceph_do_pending_vmtruncate(struct inode *inode)
 	truncate_pagecache(inode, to);
 
 	spin_lock(&ci->i_ceph_lock);
-	if (to == ci->i_truncate_pagecache_size) {
-		ci->i_truncate_pending = 0;
-		finish = 1;
-	}
-	spin_unlock(&ci->i_ceph_lock);
-	if (!finish)
-		goto retry;
+	ci->i_truncate_pending = 0;
 
+out_unlock:
+	spin_unlock(&ci->i_ceph_lock);
 	mutex_unlock(&ci->i_truncate_mutex);
 
 	if (wrbuffer_refs == 0)
 		ceph_check_caps(ci, 0);
 
 	wake_up_all(&ci->i_cap_wq);
+	return;
 }
 
 static void ceph_inode_work(struct work_struct *work)
-- 
2.50.1


