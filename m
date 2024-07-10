Return-Path: <linux-fsdevel+bounces-23471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C03D92CEE5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 12:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB307B21E63
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 10:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F5418FC9E;
	Wed, 10 Jul 2024 10:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcEFUwqU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D54943156
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jul 2024 10:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720606231; cv=none; b=oVWXwXhFLya/+S5F1w1WvpLydDbrd43QboNJk3gjoXiNTbDDtLwHdXzbLGmL+QAnwK6eDO41r6LKc9+DUdgu2qclXQtJNcafk1jSNDkML82jPwJiRCgNBwOUvhRf+dSve8Trec3ctmziJT+LjhgsVwYmCJne56x07KiuK+l4QZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720606231; c=relaxed/simple;
	bh=2lMya31Y6CPzxEPsYZjrMoPKg787LJk76pbeoqWhJME=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n8Wv2JBV0bE1cPvlKadhTSAKcavU9eXEKCYxdCIqNC9vDn/ZheR/cGWPs25ttecyGjZRqfD2GV1wluPS226s2nlkKNIBG0CVm4YvTwrSKBsmPvfCs8QnThH8o9nezBl9Gpd9FfnBcFO+SED6o7cgFJyI+hKkewA698WPY5Y0qFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hcEFUwqU; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70af3d9169bso3983194b3a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jul 2024 03:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720606229; x=1721211029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rrulZi71Q5TvLynq6zJflN3L9CXzbMzXUrQCGSilbRY=;
        b=hcEFUwqUURlHFH4Dza+qVFbD9jojnIXXkJEL7jot61akrEHzE2fAcePdojPbHVF36p
         MWt3Sy79F7q3K2p8wetbJFZhKXz9bbACc0g3EfgkIpJduRwnetZ4yQPKyAaMH0vyzpgs
         /01IUpEpgrv7+kYsTKfTts1OzdOi4ovwxjpmYtTYaC1VVXAwN4RgsTEpk4RWdYe3IXAG
         166yy/XFYdcqrI06ZfVlot3W/chriiSZ3+ByOL88dMM+dFEUL5/pMK85pU6HlFG0Ekfs
         BBB6eRIp4AzmExMhnH/r7DuAlf42Ch38bnhodxI7jks1UC/AHyq2Jh++ZXFTPgv4HM5R
         /EtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720606229; x=1721211029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rrulZi71Q5TvLynq6zJflN3L9CXzbMzXUrQCGSilbRY=;
        b=cd+IBDYZUtwMhRA/EjgnMTf79DC4Wc0E9TG8dG3WWxjY5LCIxqtbUEdIdnTJmyy8nC
         6TYQyepp7SDCkVIuCdwAyK8b8N9qInPIJoEv06Ny4+qjsh8LxRzPGE2/aTVSN6WJ1HZi
         LeMKmi110YiCgxl5Nh9Ra/9Z1rDJv6M1gMnVz+UA+i65XRat71CzZZlUDZ7mKDlcjELA
         OWQ2+fbl2K900GRn4DOK2mdHIapoLGm6J3s3LMSEWeyVH8/Om5h5ysXVykSf7dCwEEP2
         SN6Hm5EMyzSyo4AZNdBJnvDiq45lDZ6NZJMuZkxWJSWjV6JOntU4TMN/wozjfLMfxzlM
         NYrQ==
X-Gm-Message-State: AOJu0YzL5tboaVuhgkln5iCuJW1mHwbIuzUZIF9HGsJrggKWtM2XZppY
	2ZEQkgBXCceEJSaaB3r79OhRt24Op4Vkp9HIQgZWn/dS2w2moq0za895ODhcbVNTJA==
X-Google-Smtp-Source: AGHT+IEvgwcM8DCyW+kpYlaKobOCGZYjVEJfzkFUOy8Q/6Lc9WHIvIU0kFkU3Zx6f/8rYN/1txEpSA==
X-Received: by 2002:a05:6a00:17a1:b0:702:3e36:b7c4 with SMTP id d2e1a72fcca58-70b434f62famr5951635b3a.5.1720606229349;
        Wed, 10 Jul 2024 03:10:29 -0700 (PDT)
Received: from dev-c81-01.ocarina.local ([12.106.87.255])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-77d603fa6d3sm2257012a12.34.2024.07.10.03.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 03:10:28 -0700 (PDT)
From: Ratna Manoj Bolla <manoj.br@gmail.com>
X-Google-Original-From: Ratna Manoj Bolla <ratna.bolla@quest.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	ratna.bolla@quest.com,
	Srinivasa.Rao.P@quest.com,
	Srinivasarao.Cheruku@quest.com,
	Narasimham.Yamijala@quest.com,
	Ratna Manoj Bolla <manoj.br@gmail.com>
Subject: [PATCH] fuse: Set iov_len to sizeof(int) for FS_IOC_GETFLAGS and FS_IOC_SETFLAGS ioctls
Date: Wed, 10 Jul 2024 04:09:29 -0600
Message-ID: <20240710101023.2991031-1-ratna.bolla@quest.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
User programs are passing integer pointers as argument to these ioctls.
Many filesystems(xfs, ext) honour this to prevent corrupting the other four bytes.

This was discussed in the fsdevel mailing list with subject "Argument type for FS_IOC_GETFLAGS/FS_IOC_SETFLAGS ioctls"

Please see if we can be compatible by breaking correctness.

Thanks.

Signed-off-by: Ratna Manoj Bolla <manoj.br@gmail.com>
---
 fs/fuse/ioctl.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
index 572ce8a82ceb..9e0ec0b3375e 100644
--- a/fs/fuse/ioctl.c
+++ b/fs/fuse/ioctl.c
@@ -264,7 +264,16 @@ long fuse_do_ioctl(struct file *file, unsigned int cmd, unsigned long arg,
 		struct iovec *iov = iov_page;
 
 		iov->iov_base = (void __user *)arg;
-		iov->iov_len = _IOC_SIZE(cmd);
+
+		switch (cmd) {
+		case FS_IOC_GETFLAGS:
+		case FS_IOC_SETFLAGS:
+			iov->iov_len = sizeof(int);
+			break;
+		default:
+			iov->iov_len = _IOC_SIZE(cmd);
+			break;
+		}
 
 		if (_IOC_DIR(cmd) & _IOC_WRITE) {
 			in_iov = iov;
-- 
2.43.5


