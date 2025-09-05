Return-Path: <linux-fsdevel+bounces-60382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B81B46425
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 22:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 074F0189A620
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 20:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6832C21CC;
	Fri,  5 Sep 2025 20:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="zUlW+Elg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFAB28488D
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Sep 2025 20:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757102521; cv=none; b=E1UJpx8NMqqhsqnBh972bAW1Q74TzSbJhmj8WGbEq5PfmR93ArYC7m4J7L3nhrBkVafR88LF2UlJHB0zyeVchYRlySor0qVqQkCzaC/WstYPDSRfmUiaPOR8XdEvy5l762qIBvw1j3+F98ec86e75xDHxeftbDDFocM8JISF71A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757102521; c=relaxed/simple;
	bh=uslSZosQcItNKzefvZEkseAe4QBYafj2nUTG7MdKdOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P+pybBR0zhcDMUkennQT4TQnbixpW0LW6vqBdpOlRmx6LCsxks5bqpCHDIZhTISsg7kPSj/kS04k85k411ieji6l6Cu8UzQIzS7Rxv1tPUeoZaTDI/ZHWkuX0G6jaqTy+R4aX/p22+Lyi84cppMeGUTImn+dEpGQsnZ5/xinTTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=zUlW+Elg; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-60f47bcdc5cso147300d50.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Sep 2025 13:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1757102518; x=1757707318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TjipGYKyY3TRsiPrjfJ9bWYd5Csk4u5UtulZ6LHB7mA=;
        b=zUlW+Elg8qGjp2PWZnBL3i3rCsw3samqBTDG4W8xzkOm8ovs4TiRCA1EaMmytHrmY7
         6YgDWYn6nGPR+SX5e4GXLYFYCPZKIKqPde5/WpkhIf/aJ5rtFY6qNNedTavEDmqrJAFL
         F585x9X5OnZ2tMUNcMeXNgjXAdHKCu1Yxfu8urUaItKJvyyESFruYqk0qS7BzI7jU3Cc
         0vfYxQxSVb0v2K+nQcBH0gSBO7cyhlh8RWAAz7rWY2vLMi138G2S439sIEEyb9mf9ObU
         wOiuWFnXG4SClmOapKxGrRY5PajJljtN/gG8oMDQAFqlPV/zQ/LmZeXMP9PWY2qU5oXJ
         zdkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757102518; x=1757707318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TjipGYKyY3TRsiPrjfJ9bWYd5Csk4u5UtulZ6LHB7mA=;
        b=nfSIUo5mHITT6YJddMyHrM/VV99+2Mo4mYizG01zXTDvjkBiw1dsZNUyaorT7kuqOX
         e8deiXrR6ANg94s7Z690TL7ud5ACwGHYagZQk+VrDgEn2RsnvtXQoZ1BlGJmzlfhkStY
         4T5vTkZVQAJJThZUUSyOu3uwKU3rurAaNI0cuyXLKCXwZCpNCdLGlMeruc08IKbqBmzp
         mWYZz601Vwzx3qo3YMbXuYOF2oBjgcVn2jPRjvJl/S6+iK6/gc0ID0zYNnC+izSi1rDu
         U33jcG2vn8M54I9aRIWTl1AXs7QkEJn4fj0FyawbuedWaNI5+i/oL2HcT/H4mUT4SZp4
         0qrg==
X-Forwarded-Encrypted: i=1; AJvYcCVI6WdgOqFHENB0+M447lU6H3qjzbbCIbWguRfd38cx5Gja/RSDBaSzG8XJuO6dDqGkPWl/JblkuzdEbjeI@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+Zx5xyrft4x3K+b8BniOkW5DkDIpDcW0kEzdXIC5FWhTp1mca
	LPvxJJS/ozwZl5/hozTaOVRbkkorRx+Z/edDBmtYaqkCvns7sXd9O5FEegHfjmtXSHw=
X-Gm-Gg: ASbGncvFvLtX5Rmj7MhtNooRyeTUrSVLru00eq39ZOzZSkZKT+h9R3xIMSWEx6vov17
	7APlmmlC0M7V6edU+qMi1qSTXOR58GMmpYzlcAuldVbDh6/kp84ijR/LhmHFyBVIDtiwfmsqWlJ
	lpSE/G/BFOv61Gy0Z3ntLviem6KkkREa5diPOYYqqSu1Y5NV8rRuVCNyOkAhGvjtCets8Z4zvCS
	L+vOvQOMQWBMZs6uXiaJD6DFYoYkyUd4Ix9Vr+jshDYM+5aD4OFMmE1NBYD6lC632jGOWVBc5TV
	XOLA1P8yjIg3iUDmKkE5kb2Guil8VFUbieewBYImIVtIGIflfFsDYkiNq51ivzBHqpXt1YFHTkT
	X6CqAVYyhJJYMpT9H4yDlHLRVsFF7qHii+iYmmc+3
X-Google-Smtp-Source: AGHT+IEqLOrC9IAFSmIP5/QlXSkdROjARzfVFjjoirtQyRxiNVrYUsamXSZWvTI218L4UhrxfTnddw==
X-Received: by 2002:a05:690c:dcc:b0:722:77b9:705f with SMTP id 00721157ae682-727f514f0b2mr1189577b3.39.1757102518456;
        Fri, 05 Sep 2025 13:01:58 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:2479:21e9:a32d:d3ee])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a834c9adsm32360857b3.28.2025.09.05.13.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 13:01:57 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com,
	vdubeyko@redhat.com
Subject: [RFC PATCH 08/20] ceph: add comments to metadata structures in cls_lock_client.h
Date: Fri,  5 Sep 2025 13:00:56 -0700
Message-ID: <20250905200108.151563-9-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250905200108.151563-1-slava@dubeyko.com>
References: <20250905200108.151563-1-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

We have a lot of declarations and not enough good
comments on it.

Claude AI generated comments for CephFS metadata structure
declarations in include/linux/ceph/*.h. These comments
have been reviewed, checked, and corrected.

This patch adds comments for enum ceph_cls_lock_type,
struct ceph_locker_id, struct ceph_locker_info,
struct ceph_locker in /include/linux/ceph/cls_lock_client.h.

Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Ceph Development <ceph-devel@vger.kernel.org>
---
 include/linux/ceph/cls_lock_client.h | 34 +++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/include/linux/ceph/cls_lock_client.h b/include/linux/ceph/cls_lock_client.h
index 17bc7584d1fe..8eae9f6ee8b6 100644
--- a/include/linux/ceph/cls_lock_client.h
+++ b/include/linux/ceph/cls_lock_client.h
@@ -4,23 +4,51 @@
 
 #include <linux/ceph/osd_client.h>
 
+/*
+ * Object class lock types: Defines the types of locks that can be acquired
+ * on RADOS objects through the lock object class. Supports both exclusive
+ * and shared locking semantics for distributed coordination.
+ */
 enum ceph_cls_lock_type {
+	/* No lock held */
 	CEPH_CLS_LOCK_NONE = 0,
+	/* Exclusive lock - only one holder allowed */
 	CEPH_CLS_LOCK_EXCLUSIVE = 1,
+	/* Shared lock - multiple readers allowed */
 	CEPH_CLS_LOCK_SHARED = 2,
 };
 
+/*
+ * Lock holder identifier metadata: Uniquely identifies a client that holds
+ * or is requesting a lock on a RADOS object. Combines client entity name
+ * with a session-specific cookie for disambiguation.
+ */
 struct ceph_locker_id {
-	struct ceph_entity_name name;	/* locker's client name */
-	char *cookie;			/* locker's cookie */
+	/* Client entity name (type and number) */
+	struct ceph_entity_name name;
+	/* Unique session cookie for this lock holder */
+	char *cookie;
 };
 
+/*
+ * Lock holder information metadata: Contains additional information about
+ * a lock holder, primarily the network address for client identification
+ * and potential communication.
+ */
 struct ceph_locker_info {
-	struct ceph_entity_addr addr;	/* locker's address */
+	/* Network address of the lock holder */
+	struct ceph_entity_addr addr;
 };
 
+/*
+ * Complete lock holder metadata: Combines lock holder identification and
+ * network information into a complete description of a client that holds
+ * a lock on a RADOS object. Used for lock enumeration and management.
+ */
 struct ceph_locker {
+	/* Lock holder identification (name + cookie) */
 	struct ceph_locker_id id;
+	/* Lock holder network information */
 	struct ceph_locker_info info;
 };
 
-- 
2.51.0


