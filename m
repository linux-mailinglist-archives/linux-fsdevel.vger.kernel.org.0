Return-Path: <linux-fsdevel+bounces-50864-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD905AD0880
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 21:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 210C97A499E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 19:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7901F17E8;
	Fri,  6 Jun 2025 19:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="I4pn4krY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B051F2746A
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Jun 2025 19:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749236753; cv=none; b=Dz2ATEkDnjPEem3A/lOQ0pc4f7H24kGyoDnnh15+jOwvQmRIfJYq7YZ1fKlMdIsWfcxXZuVSq7jgvxkGqTse69Ji65kmREvZ7aIfrIL2OfHRDG7aAWxFLDBw2Py1iwirQ7s76rfvw5LKDRiryM1tk9kqYaAWoHvI4+LlFrKOwEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749236753; c=relaxed/simple;
	bh=fjA174NXcYra/qNR5ZeunrR6PJxgyVAijSUtlp0nPjM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uF9TFzpd4dmRWs4nIMVAkaFaHOwQTKK2BzBELC5UZR+WIiRhXFeh8ZP3V47N6pJT66Qftx/6ie+OzLX1Uf7jZc5QRRm8+MKPFQ/1hvpHHcNlbdv3N6SnIRdsrW1n9T4hQiXfG1X6WMgK7TJXJ4NC0fTDStPijTXBCrAAWXtTGAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=I4pn4krY; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-407a3913049so1426155b6e.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Jun 2025 12:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1749236751; x=1749841551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZB9ynOz6tzj5Zv03g68DqX1Y48gJ3m+cXZRrMsWB/Hk=;
        b=I4pn4krYKMWDA34DHWI2AMNLzHlo4TA6sgKuIVEPQ2OdoYG5n7N9vbZPSjpHF7TFgF
         TZw6ibZUgHM8qO2vTaM+iXFqMMtY/cORc8V9b8WqA73lnGJVD69A5s2JZePgVTINg9KX
         MKSGAk0ku0/DpSQ6ZGQFQLbhjb/11tp9s7u3sqOwQX9CDeyyjU4eppfL3sAYaVsf7cbO
         PssZ/JLi6KJ9ileNVqjr9snQBMoe8FqN+YnLQ0zg92CoHRONCa+QUNlqanN1dflXqtCU
         1x/ufZL0RZHIJHTWSr2AdwkJIe4KkYckic0PsMi9ypLRTYKKjYvox7Oo1JibvWA2ccAo
         iqoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749236751; x=1749841551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZB9ynOz6tzj5Zv03g68DqX1Y48gJ3m+cXZRrMsWB/Hk=;
        b=XWbaMlNCHBFIRk0lWyWoUTag9AqOmvVfg+UyDPhaQCkn+IJi+jaLTI6tT5H6VqUjVJ
         vlVwmTcbU9MKizPNIheycaqnzN6WcdnxwT/kabrkj/ffBpKpD4LLVatlWVNFPW3hAZGl
         45Evl+ILLhkkzJJawWV3x0IDaFW+OaRzRQjohjBKOZmGnVMWPjSCe31O25YvVaUYhpza
         STVhOtUYx8u54ZLP9RF357iDdEmMsSzhrRMXHzeW+0PaCXX84ksqotwQ3UhAkXXVXhMW
         O/XHvsLZS/9sh9HJ6C706cDKQrowda1u25g1h/ERsy1zB9ur42q69vCGczPkkk0l6CQ5
         x5Dg==
X-Forwarded-Encrypted: i=1; AJvYcCXHnaP/pHoibzaN9+jszgqFCQX/JtfFCRdA/vNqTp/XGWI2z7qk7UrRKvP3QHSKSZRcg0o4JqqyZ80I8fun@vger.kernel.org
X-Gm-Message-State: AOJu0YxHVtv92DBDNUN+ybaxGv1rx02cS3vbauSSFajw/toHNiNZwM7y
	bN2z8/G7ovHXOe8bHTgNoIX/oGVBlxvAQtSLrJqNu6xjbjbT7Hu17iEVKT/WoSvnQCA=
X-Gm-Gg: ASbGncslm0v/qmkf4OWzAFCHd5tEUn2wIw/skfQy3tMfwL6J5jno3tCEmPPQsev2Mhj
	W11tuJ0StPhBIJe1l7mAjkr+nEZlibcxsw7668hX7gKf0dyeXUAuP0sObP/JvdhtNI66RwsPwrT
	Bd9stpWNLfgIvXjs1guWiJA8BmNtE0PBXq7KYjV3iR3vC7OgzfPn9cAK+DtMuOkEZRQfEWthnxF
	MOoTh3Mob9oz0Snhs04Bz8RxO6yV8u3SsYvdlL3Sjt0gAiHP74H5yBO8lGjRVlJIXSlsk0AGR1S
	4QTNFQxyjjRB3ToiOsRAa/VgoAlAwpRRuJqMK7IVdEwPN/lxwwc9e3zQoK6fOjuPp4sZGyLpkyn
	QOKcd
X-Google-Smtp-Source: AGHT+IEtfRFjm8MHKUaNn5CMUbZcMb5BICcItdOhd4cO9UvJEofKS92V4U0N7MVOIpb3NgYFd96s0Q==
X-Received: by 2002:a05:6808:6f8d:b0:407:59ac:d73f with SMTP id 5614622812f47-409051f2c1fmr3218153b6e.21.1749236750747;
        Fri, 06 Jun 2025 12:05:50 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:fe8a:b218:375c:b2ed])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-409069638a7sm448598b6e.22.2025.06.06.12.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 12:05:49 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com
Subject: [PATCH] ceph: fix overflowed constant issue in ceph_do_objects_copy()
Date: Fri,  6 Jun 2025 12:05:45 -0700
Message-ID: <20250606190545.438240-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

The Coverity Scan service has detected overflowed constant
issue in ceph_do_objects_copy() [1]. The CID 1624308
defect contains explanation: "The overflowed value due to
arithmetic on constants is too small or unexpectedly
negative, causing incorrect computations. Expression bytes,
which is equal to -95, where ret is known to be equal to -95,
underflows the type that receives it, an unsigned integer
64 bits wide. In ceph_do_objects_copy: Integer overflow occurs
in arithmetic on constant operands (CWE-190)".

The patch changes the type of bytes variable from size_t
to ssize_t with the goal of to be capable to receive
negative values.

[1] https://scan5.scan.coverity.com/#/project-view/64304/10063?selectedIssue=1624308

Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
---
 fs/ceph/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 851d70200c6b..e46ff9cb25c5 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -2883,7 +2883,7 @@ static ssize_t ceph_do_objects_copy(struct ceph_inode_info *src_ci, u64 *src_off
 	struct ceph_object_id src_oid, dst_oid;
 	struct ceph_osd_client *osdc;
 	struct ceph_osd_request *req;
-	size_t bytes = 0;
+	ssize_t bytes = 0;
 	u64 src_objnum, src_objoff, dst_objnum, dst_objoff;
 	u32 src_objlen, dst_objlen;
 	u32 object_size = src_ci->i_layout.object_size;
@@ -2933,7 +2933,7 @@ static ssize_t ceph_do_objects_copy(struct ceph_inode_info *src_ci, u64 *src_off
 					"OSDs don't support copy-from2; disabling copy offload\n");
 			}
 			doutc(cl, "returned %d\n", ret);
-			if (!bytes)
+			if (bytes <= 0)
 				bytes = ret;
 			goto out;
 		}
-- 
2.49.0


