Return-Path: <linux-fsdevel+bounces-60019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 022C1B40E60
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 22:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D52D5167546
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 20:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8EF35207A;
	Tue,  2 Sep 2025 20:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="Lrrhevg1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9081620E00B
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Sep 2025 20:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756843815; cv=none; b=THKmpl3YwoJebeeLkvNpxBgdx9T3VlICe2m35PmJ6d1zJ62NXETLyi+FBy7Nq8WZvKGCmSzRd+Rir9u9abYYL/hAUU0nzQxp9/mhkal12u9Imyi//o36BDfIOyYPakYC7jA1CJJNNTEPBc4rL1CRe4fKMm+Zgg2Jc+UHA+m20SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756843815; c=relaxed/simple;
	bh=ox5THzPZN5etHcEyK2C3ZOkwHhCcFRlqQ5TGb5TZFwk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LG2sWgZMamyTf65bj2PpfAZTQ8ucWTRzwiTRYU2aCB7xwGRvbRGbZQu5UhqhQSaqxOZ6ebC5plgWM6roCabyNqP8N6lXovLW6rbQUxrMf/x1SAa839YYsXuDVhkvSvFG/BJaImRfpgMo+d6ElUZdZBVUFzy3n95EUXZvVviYZBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=Lrrhevg1; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e931c858dbbso4817754276.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Sep 2025 13:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1756843812; x=1757448612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TRt5rZOythgd+LzyS4IZzwW0xt24ViCFGAyJwkaqRvE=;
        b=Lrrhevg17p1NcflfJ7tu40NOYn2SQC3l1FDtKbcrLG6Mgf/xIRCSfqntNNpP1oCa3D
         cz1DSFpD6OQcv1GLJCMs5S87BPpRB7aefGIJoctNTrnv6tZaIVOoDERY7ZRV1uZPS5E3
         N/Gby2o54jJDYSCnL7J9pPPZzYsx1zEVRBJbxIY1onV+rIUhA+ZcABUIfGaznzhkuHRs
         9BnESbRrGT7g68YIBZtxBlsQ0ydYTkJbF7robxTdU4P4pzYeFKySXfKm04qPwktvMyp/
         nzzvsd+Q3NCOnP51RKcC2JMD3EmxjFSLl2KWPIKVv9H8SHayMQRvODL9eHWZdj5vJGM4
         AZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756843812; x=1757448612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TRt5rZOythgd+LzyS4IZzwW0xt24ViCFGAyJwkaqRvE=;
        b=sQuveWRqcvjNdtaLPSB+EmYCSnHhrauWWNQLa1HRLIP2FtMPJaj0qZeWz84Z64oC9o
         K/Z3EQjo9QLBWGF6xiBgNKbBNcBxuxi3/bK+foEG9SM+bTjimqC4C84OhFNthK2SAEdf
         JXtEyuxJA/8T53E23IQQ7uenKhFov8pRmqbt00EpO2qOt6kMobyGEe6zt7of2rHaE2Ur
         ii3fKkiEhbFf4WSR/5CZGBF2oQMGTCMVlUfTxxenxP48bBPb0zDWsjSkiXTdd0YmLf3l
         01/ZMB0aLaPcD2axtIf4Y4IpznJMmVdmvAFAkeeLcoDn23fTnCVMj5j2hCMAZyn8GH6M
         0H5w==
X-Forwarded-Encrypted: i=1; AJvYcCWfc3VMLFR5dQB9qqv5ao3AEbSqh1GSPeY/wkzziKBbJGZYiaH94Sn0i3WJj8VS836/afXHVBT5Pha1kl/I@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4JRUK0QQXkHiSMadBcNkAxYAtbtZNfA+aBVL3c1vJj2dmy/HB
	ie7GPBTHb5MkeGzzURoGcAFGgge6nMTEzWCLEH1IWqYmpYYMITWAMJej5q7SPp9M20Y=
X-Gm-Gg: ASbGncvL7bO/TdhE7yw01970bFFfMOyUZ8Xf1ChR4yI35Nl/KxJIRfmkNA1yi7lhOXR
	Tw6Xpda4LFiwPpHBe8Uh6yWkBe2+/4dhndMI33TENihH4Pq3SgiyyGGw4oaktHQESSNJA5IL0ca
	KUaHHViHMcs3Hv8OTzZXTQx66W/A6R3RJEpjrq42iiwvKXoIeSr3aX1DqEgEvpdIAOb3okpAb9p
	HEKTwp7wfISsXOuoMokTvQPVWDY+JdOofLcPgPjs5sLj6PpIekEeGZmY24pQmdauODobhOBu0c/
	Ix0I14gXw3w1QzBNy8ne6FZ+nMVToT0iRhBr+4hveZJejRJGxr9ZOa22sMm6Wamp8pPexVx9ttx
	5tuu3tmvF968G9X3QQM3kcGqr8Ebn451lukzXY8q6mtBlq0qxzA==
X-Google-Smtp-Source: AGHT+IFGjjMVETY2jqzYCpa1MpXXZHa0qCVWQ1sPueNaaI41j1LLvWkAptKiNRYE2H1n8NnnzNBJfQ==
X-Received: by 2002:a05:6902:2d07:b0:e97:6e5:28a with SMTP id 3f1490d57ef6-e98a58210ecmr15047394276.25.1756843812171;
        Tue, 02 Sep 2025 13:10:12 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:5abd:b705:e7b:f18d])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e9bbe08d6aasm853103276.24.2025.09.02.13.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 13:10:11 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com,
	vdubeyko@redhat.com
Subject: [PATCH] ceph: add in MAINTAINERS bug tracking system info
Date: Tue,  2 Sep 2025 13:09:58 -0700
Message-ID: <20250902200957.126211-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

CephFS kernel client depends on declaractions in
include/linux/ceph/. So, this folder with Ceph
declarations should be mentioned for CephFS kernel
client. Also, this patch adds information about
Ceph bug tracking system.

Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Ceph Development <ceph-devel@vger.kernel.org>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6dcfbd11efef..70fc6435f784 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5625,6 +5625,7 @@ M:	Xiubo Li <xiubli@redhat.com>
 L:	ceph-devel@vger.kernel.org
 S:	Supported
 W:	http://ceph.com/
+B:	https://tracker.ceph.com/
 T:	git https://github.com/ceph/ceph-client.git
 F:	include/linux/ceph/
 F:	include/linux/crush/
@@ -5636,8 +5637,10 @@ M:	Ilya Dryomov <idryomov@gmail.com>
 L:	ceph-devel@vger.kernel.org
 S:	Supported
 W:	http://ceph.com/
+B:	https://tracker.ceph.com/
 T:	git https://github.com/ceph/ceph-client.git
 F:	Documentation/filesystems/ceph.rst
+F:	include/linux/ceph/
 F:	fs/ceph/
 
 CERTIFICATE HANDLING
-- 
2.51.0


