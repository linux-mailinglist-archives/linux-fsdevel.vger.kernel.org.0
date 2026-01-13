Return-Path: <linux-fsdevel+bounces-73511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B51CD1B2BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 21:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E05543053321
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 20:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6162F3636;
	Tue, 13 Jan 2026 20:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="Hwam6yh+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E11A1B3925
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 20:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768335413; cv=none; b=he03wp/ldy8XK+PGp7KFLgEVh0lPHhUXpUJ0PmVzZUksBghHYEzazG7kaSEKJ6HKX4O+1Vg5atFcZLKlZuywTrJ+p295S4TlkJKqTxt4zily+19zW/FDBb8ft4hi9BMUeKqTSWlxWJfs7xJf+iynhwt+UMqxZHdW879ktJrFJ5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768335413; c=relaxed/simple;
	bh=i7Q0cppGHnXoJlzKDTPAA4Ox8F1xyo7tsBiGT/yZWUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HmMkc7ghBL8IAri4ctkjmEnoqzOib107tO4+62/56h8e8HV8k4lLh1tpwxgKGo+d4BTjq5i2V/V/+uW6i1CwseSWPy6BDVV6ZCIQ4vu/ukOCb/bkA1jHJFofBhl4C0UHUym42Af8toZvMdJWsRu8sH8r6fnMWWQhulP+r0XNaUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=Hwam6yh+; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-78d6a3c3b77so2600047b3.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 12:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1768335410; x=1768940210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PxakD1KmYQa92a3vZ7/OlBVuBUSn3nQs6Us3iV3sL6Y=;
        b=Hwam6yh+pF05hqzfKu0TuhGJGLYhBSjVPC6FWINo7k0J/IPSg3/lgBQEAPSnyMukeB
         sgFz0HM5E89y13JPankrblWGAWXyE9ycWQif9EIJEWLoevFfssnMcIFKQsvrp1CG++uK
         6Lry/CRqNthQR73KNRXeNLBgn+oA+dNgbMojghyqwIeNWN+1MgxFKpxCtnZ6LOAYwWvM
         mmMfv6wt96ebEGUGckz/7jrWz4s5G8EbkM9xPftCEfZWvR6aDy67Kl10vlG9kE4aosZw
         ehZkeUctbmwMU42oM2R1ANwpdBR525/2rAuKujlJJPJ8AefJ9bHNHurWTzJmZ5A6esKC
         2S2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768335410; x=1768940210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PxakD1KmYQa92a3vZ7/OlBVuBUSn3nQs6Us3iV3sL6Y=;
        b=UEtUcpyuYhaJhZSV8XAuvu49gECYlRgZ4siKLA4XcyPl9dRwIUvq5dGYbSGPjWdrLP
         XUOgcELIxfa9KaGqs5Kp6WbBISdVfMFGhYr2wTLDQwwYRWtwVcN/2YMtA96cLdPgewbs
         zLd+IB4uOZvBDapsPKQyZY1J3Q+cLmX5l+iXevO7qibKZTC0Jwa1ie4wwwKfvXVrio2n
         fKcOfEQeRU3EG31xCUUa1W/OvUKz1PviZq66LBpA/ikEXBFe73/mHYaPou8sKnfGD5OC
         pLpKZmrA/SOlQxUyNU9qpcQ/IOcVura9JursrVvBUbOB/4tjPRz3dcJ+1MDlnQU/22J4
         kSug==
X-Forwarded-Encrypted: i=1; AJvYcCVjWVAG946ssp1ZJjdV+JxFA/7AD5k3uTJYY3TN+/jaWb4JeAGj93tAkMfL6KZjCFR4IAVkBtbF5s14dhWV@vger.kernel.org
X-Gm-Message-State: AOJu0YwcTUVd8VNR0JRmJizYmk4/51VbzBenmw19ImkNK6A656wMG2DO
	E7tebdd6ZvJjQL1iCuLbxMoz8HY4ZXBuayPzeVGdIKewzrb7P3gMXh7VwrDtslJT97U=
X-Gm-Gg: AY/fxX6Py8h5ToIhmDyT1TNd68FQc04ip1ZK8J7fS5LYynujg/k39b29MAvN86umF79
	JkkYCinPzoVxCeh1JWcVhzyAXUHneQ96p0OaZ0I+2OvZNFz7oqO7RDkp4k0HSQtVDXBDeF1byva
	ogldkE36lwm/qppYhqQOLf5yeqed5QrC4xBp4xR7fb08AC/+/dk7whB2AZEZIuhOfbs34CmUbDH
	QHGLjFrz6SeJHH/uSbw2iVHT6frDW+00dFvOEanEExZ+ysVZSr49XWAcCbgkDYAsvSiVPDRK/yz
	hzUV4WOwIjYidDn2Yb5sZcUGkHOmgBzFQ8Gpz+AZBRgemDuwc/kP7Nd5o6MNNrKxwbOiPOVpTO3
	42xIyEkLPjLdIr4DAUCey9sO+74drvFi9NQYhqJ7UHm6ov436TaMrKGbqqwYUuC/InMnTX650yX
	7qHmkAQ0bM5bmBcsReWvEd/X2OTtb2c/Bs5ZcNqRZlgLQ0P+Dv259FJte1z+TBtzSk1C0xWbKue
	4EYsA37G+QEaWvGGbw=
X-Received: by 2002:a53:8543:0:b0:645:5297:3e5d with SMTP id 956f58d0204a3-648f638c88cmr2981073d50.46.1768335410350;
        Tue, 13 Jan 2026 12:16:50 -0800 (PST)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:cf4e:ea8f:19ac:63a0])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6470d80be64sm9666151d50.6.2026.01.13.12.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 12:16:49 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: util-linux@vger.kernel.org,
	kzak@redhat.com
Cc: ceph-devel@vger.kernel.org,
	idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com,
	vdubeyko@redhat.com,
	Pavan.Rallabhandi@ibm.com
Subject: [PATCH v2] mount: (manpage) add CephFS filesystem-specific manual page
Date: Tue, 13 Jan 2026 12:16:37 -0800
Message-ID: <20260113201636.993219-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

Currently, manpage for generic mount tool doesn't contain
mentioning of CephFS kernel client filesystem-specific
manual page. This patch adds the mount.ceph(8) mentioning into
file system specific mount options section.

Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
---
 sys-utils/mount.8.adoc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sys-utils/mount.8.adoc b/sys-utils/mount.8.adoc
index 4571bd2bfd16..43d2ef9a58a4 100644
--- a/sys-utils/mount.8.adoc
+++ b/sys-utils/mount.8.adoc
@@ -853,6 +853,7 @@ This section lists options that are specific to particular filesystems. Where po
 |===
 |*Filesystem(s)* |*Manual page*
 |btrfs |*btrfs*(5)
+|cephfs |*mount.ceph*(8)
 |cifs |*mount.cifs*(8)
 |ext2, ext3, ext4 |*ext4*(5)
 |fuse |*fuse*(8)
-- 
2.52.0


