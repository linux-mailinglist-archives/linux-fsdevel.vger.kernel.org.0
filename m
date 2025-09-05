Return-Path: <linux-fsdevel+bounces-60394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64190B4643E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 22:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06E973BEB14
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 20:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDC4298CA6;
	Fri,  5 Sep 2025 20:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="hlM+HBLh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046B128725B
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Sep 2025 20:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757102543; cv=none; b=eNZraHdj61lW4Zaz4gLz7rVI9OYOamxmtKybs3eTAOffUD1aLDvZtKLqN8mD1ZOKJrrDvBc7s309Gt7YBTZ+P1reSbKRgUwNy5YME/HhHBkY3pR+rRnY5BVq/+SZ9Es0LA+Bv9J477xdYAeQq2jVw1Ueaqnoo5c6TZ2dNvfViGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757102543; c=relaxed/simple;
	bh=elXegIfp06UvQ3ZBvL3K2a7cSQ/TfQ317ejtVGBqJMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nmfbdBFJuzBTSEZrDPwoX4P1yyNYN3eoaKaSDELUAhKbNrZYjj7VzSglpnFLoLYJXiJX6qAkoJzBGe8h8UHL4N0nYz2jv8tEKr6QKSDttTWhHVeNT3fiPoLIVigYALc4HwGA/Zi0DfLyXq5f9r5VW/idbtcEILlDHPvAMi3yJJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=hlM+HBLh; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e96d8722c6eso2666430276.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Sep 2025 13:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1757102541; x=1757707341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SqXD0VXFoBYU6cJ8Lcdh6/Uq/24eOSrXykVwDRLc2Ss=;
        b=hlM+HBLhyQLOK33F2JAKPy0AzmqZ53wDaAwOcx5TDXFvo73AaTSqzfz5OUaKWlCjQD
         nouznFBzJURnT5UZGNBjh9bRynBui8nwmSGbkAItEN8dNYbC6jTfpipoLzOZwoWaRN/P
         ZHGzkI+bdzuo9zJzYleZyrLtqz9z1dVRHxUJuDZAkTL4US7s8D8q0NR1hdTgqtFfVljJ
         C+VPKKARyL+CSelctt8AXyghbC9h95qgSaWb5GRFm355/xDpPdMeEJWQYRPUZXLy8FDs
         pbj/eUs0jLWuTEHo+yb87UXMZ2dtl3zTSa6G8iwQmgY7OVqvXt3+FeJr3TK6T0gB7oGm
         WQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757102541; x=1757707341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SqXD0VXFoBYU6cJ8Lcdh6/Uq/24eOSrXykVwDRLc2Ss=;
        b=JZ+iWU/KH/t5hCDvca1lUkzCR+FR64imkdL+Y0hkUif86M0G31bKPkNu4qIX1lTdnN
         duQ78DTLTrSAI7ojkxMLIrCnZXAD6ma6Jw6RqNS0fawQFqgeYVyL2JREP9UNqGawOAuk
         Kkb4Ol4PJIfwUhir8rO4qJN8UkG5pCm+tJuQXvV9gcwwHmmr9uHB8kDqQybA5fGxCRhD
         xM3ecOObzJC4uMQ4neaswgt9l0HSlfvM09ROlPMLnM2Oy4ulxz66xCpfaXsDMhxQPOsS
         RyGVAKF9iu1U3KazAfi1ipOCRuVju/m/1FM7eYt7SpDGMw8aSxpBGtdnvuwQ7OmTPp1C
         t8VA==
X-Forwarded-Encrypted: i=1; AJvYcCVl36fgg6qrxc75S6AFBS/SHfTUcTs+HGAgVgr8ZW0FzDzSoReatX21ls51+SHFPdZHtp89dszPMD1Pw1hp@vger.kernel.org
X-Gm-Message-State: AOJu0YwdPIlUqriT2IsIlWIADZR0RxbIdm1qHzd7EyRmx9xP/kphcs8o
	iLPuz3uKUhK+eLw4olJnJMFMcMyi+GvuDs6xEJDwWPdnmhMjSQI+05o3dY83Yqgw3Sg=
X-Gm-Gg: ASbGnct1qzjBu1eSmjfAAyQtPTRVW1jJyVaO37wpWqcf+nAfCF9LbJdSYdK1395Hw3g
	EeRx8lfmq2jciaUdSn6Y71U6HQT/kBDvIKnjPngwLCa+AnJnt8GGyjigtsaVbW6INTZ08YoqyZs
	7ATZFg0clBRkZnsP0NVqeu1FS7zXPN/uoDd/p8I6IgvO3k80UkEAOOlMaMlIleRLEPBeVRveUal
	vrPBO59O4/e+JQyOXZS2GrVgjKwEhJpB33wk3MZAJyUkjAHQTVt8YpT/ywsfDys7ywPrTKPS77m
	R7XvnbVqS/1aP6TSFDgSxByL7sBWu3+8lgj1sy+mYj7OvzWT8+eAYz0bzkuVQLz/BuulbwV59sd
	znq1GUwqBf6UGkozr/pd+FxGS8jQJLoI6G69IABKd2ZA9nh3WeTU=
X-Google-Smtp-Source: AGHT+IF0RPvY2dcjsztligiYELPKSNmT6JTy56lcJSET5h1grWi9u8ykkmcx52gOkw15c48qJRX0yw==
X-Received: by 2002:a05:690c:6485:b0:720:d27:5d0 with SMTP id 00721157ae682-727ef8d7f3amr1959347b3.0.1757102541016;
        Fri, 05 Sep 2025 13:02:21 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:2479:21e9:a32d:d3ee])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a834c9adsm32360857b3.28.2025.09.05.13.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 13:02:20 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com,
	vdubeyko@redhat.com
Subject: [RFC PATCH 20/20] ceph: add comments to metadata structures in types.h
Date: Fri,  5 Sep 2025 13:01:08 -0700
Message-ID: <20250905200108.151563-21-slava@dubeyko.com>
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

This patch adds comments for struct ceph_vino,
struct ceph_cap_reservation in /include/linux/ceph/types.h.

Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Ceph Development <ceph-devel@vger.kernel.org>
---
 include/linux/ceph/types.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/ceph/types.h b/include/linux/ceph/types.h
index bd3d532902d7..beda96d2c872 100644
--- a/include/linux/ceph/types.h
+++ b/include/linux/ceph/types.h
@@ -13,17 +13,27 @@
 #include <linux/ceph/ceph_hash.h>
 
 /*
- * Identify inodes by both their ino AND snapshot id (a u64).
+ * Virtual inode identifier metadata: Uniquely identifies an inode within
+ * the CephFS namespace by combining the inode number with a snapshot ID.
+ * This allows the same inode to exist in multiple snapshots simultaneously.
  */
 struct ceph_vino {
+	/* Inode number within the filesystem */
 	u64 ino;
+	/* Snapshot ID (CEPH_NOSNAP for head/live version) */
 	u64 snap;
 };
 
 
-/* context for the caps reservation mechanism */
+/*
+ * Capability reservation context metadata: Tracks reserved capabilities
+ * for atomic operations that require multiple caps. Prevents deadlocks
+ * by pre-reserving the required capabilities before starting operations.
+ */
 struct ceph_cap_reservation {
+	/* Total number of capabilities reserved */
 	int count;
+	/* Number of reserved capabilities already consumed */
 	int used;
 };
 
-- 
2.51.0


