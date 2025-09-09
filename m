Return-Path: <linux-fsdevel+bounces-60688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92529B5010A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 17:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 046B77A8D3C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 15:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749FA350D7B;
	Tue,  9 Sep 2025 15:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M/mGLWld"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F43D2EC566
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Sep 2025 15:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757431565; cv=none; b=rsKyskdZCJdIFU7hE9/Kl/l0FNJqfomNTFVzzJ/JUYhdqxoj/GSS4+Ud5XJdok3ZP9+B7euWRz61YxwroGInY6L1X23rx6xk9YuT4oeeLa9DDAetTCke2hwUC4NWU/zIABfqidsH/DLq3AAInfA2FIlL2wCb4r6cKjgfU/6Gr1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757431565; c=relaxed/simple;
	bh=O+3dGIR/1DtiE9KLcFUY0iaC5JbpkqVOUBN8aCmD/gU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:To:Cc; b=okJzwmLHXMvhWvNchOhNsfpImJgMMWyi/B0fe8rriRwfEDuKHwxqjPqnQTWGLHyx8hria9d3IEttSrFv4UpJ9FEoycYyywpkJz7d60cqWxVWHyVSm2olYZ7XuwN5mjtF2JoMicDo0tgr9bGiYw1Vx1yCrPu07SOEoiNoxMNuNRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M/mGLWld; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757431563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=z3WZwo/jaWWU1mgZkjIF7n9gEjSRZYhoi1CAELphjFM=;
	b=M/mGLWld8KH6/yD9tSkH5AWCtIHkvs0ZAb9y2R5KRt6hZHrrfMl6c+PbhBzM+CNXbj/Y/q
	1Y+7rpL1xEh0zc1ZGSltJmcqOGVTRms6k51ND7FONJfF9RdEXA16qKWGDeT2VHzl6VDGSo
	A53JN5TPIdIbx5vtGUdHqa3xtzkd/h4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-XDnTm6ibOgOktRz-T3VbEQ-1; Tue, 09 Sep 2025 11:26:02 -0400
X-MC-Unique: XDnTm6ibOgOktRz-T3VbEQ-1
X-Mimecast-MFC-AGG-ID: XDnTm6ibOgOktRz-T3VbEQ_1757431561
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3e2055ce8b7so2132827f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Sep 2025 08:26:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757431561; x=1758036361;
        h=cc:to:in-reply-to:content-transfer-encoding:mime-version:message-id
         :date:subject:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3WZwo/jaWWU1mgZkjIF7n9gEjSRZYhoi1CAELphjFM=;
        b=b76K5RlkF8Y/rpCird5NjEyzI/uraaNiR1J+9HvJAnz79mLqpkAh6B19h3AAzNFail
         kp9/g4WZo4zPZI0tYmoi29ZHZ4htPcUr39Bt5FQ9R2F8YFhw0vHr9ZEcc/+RZr9wcRRH
         +tUImadebVNn8h0kPFM2rvlKaLgltmU+Pn4zGwqvl+dTbtAA/+/C/fc81NJSOy33UKzr
         qXDrWH8mTLClAeNP57CeB12Y0XfjAeieoB7OepMNnpQ5R5Qpt8G9Fc8C6IIr5vUfQaMH
         Lrw0pkJ/L1mlwdDqIPi3TLXWfWVl4JUOcq14luK0eCHibseWfdcDT6b5FKazuIfmSe4q
         tNbw==
X-Forwarded-Encrypted: i=1; AJvYcCVk4e+8hkMdOQaB4qIplKxO7gWJ+NRqAQjEZ91T2uTAHj5/p8zxEcvvvIUyQuIPGbibsyU57U1rUnV2n9pu@vger.kernel.org
X-Gm-Message-State: AOJu0YwNJjciL+LaP63df7ky29iawNGM424k4PQGHk0V8kJCL8+zq1B6
	aKi9wZJOrwLeGGHF+te7LLvseeKNnoYqxiPQhzLpRA/ypuAWbJjNqF4iqoE3cs+GHceAaDw666m
	wcOI3Fbh2FeeY76bxDTRrtJn31RieeCuGYowWaRamTmBbH+loeGqoIK+4SS22B/E0lQ==
X-Gm-Gg: ASbGncvVm+NCjXXCyb8tmKLAHFanmxaIRTkQgyOoOLmiZwK1x1VGT2extkjq8DLgb+a
	thvDMqUY11hxqqKAYCEv6D7cQ4aEaSJc5KS+nX3WkPfgeRr2qv/9npDydIjy4TevjmLMOf/kRQh
	xufRUXRwqgZmgVWE0wXWGijuthaCO0GzNs7zD3tSSU+Yf+J3ZoUWwJHN+FDgHHDqcXs+6CKPsj0
	ncgW1xNIdhHl1v3CUDtyKFDmgdpk9hKLKrQGe6vDKa1DX/2TCoKzgwgLcYL6GJlCqI09s/+1ipx
	mq19DA77Z2TNkMBA+eS7n4iPvnmBa8M40b66NxE=
X-Received: by 2002:a05:600c:5304:b0:45d:e110:e690 with SMTP id 5b1f17b1804b1-45de110e75dmr90886395e9.14.1757431560975;
        Tue, 09 Sep 2025 08:26:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHS7BPzwjcjGF4v+qJMawvK/ZJPMgzEV0RZ5/MJh+kj7pnlazKDSanzwhxINAYPZk4x6NQDbg==
X-Received: by 2002:a05:600c:5304:b0:45d:e110:e690 with SMTP id 5b1f17b1804b1-45de110e75dmr90886185e9.14.1757431560561;
        Tue, 09 Sep 2025 08:26:00 -0700 (PDT)
Received: from [127.0.0.2] ([91.245.205.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b9a6ecfafsm348550005e9.21.2025.09.09.08.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 08:26:00 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Subject: [PATCH v3 0/3] Test file_getattr and file_setattr syscalls
Date: Tue, 09 Sep 2025 17:25:55 +0200
Message-Id: <20250909-xattrat-syscall-v3-0-9ba483144789@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAANHwGgC/2WNywqDMBBFf0Vm3ZQ8qqZd9T+KixAnGioqkxAUy
 b83tcsuz4F77gEByWOAR3UAYfLBL3MBdanAjmYekPm+MEgua65EyzYTI5nIwh6smSaGqF2Nsm9
 QaCirldD57Sy+usKjD3Gh/TxI4mt/Lc31XysJxllj+N3enGqd4M830ozTdaEBupzzBwQlO/6vA
 AAA
X-Change-ID: 20250317-xattrat-syscall-ee8f5e2d6e18
In-Reply-To: <mqtzaalalgezpwfwmvrajiecz5y64mhs6h6pcghoq2hwkshcze@mxiscu7g7s32>
To: fstests@vger.kernel.org
Cc: zlang@redhat.com, linux-fsdevel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>, 
 "Darrick J. Wong" <djwong@kernel.org>, 
 Andrey Albershteyn <aalbersh@redhat.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1889; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=O+3dGIR/1DtiE9KLcFUY0iaC5JbpkqVOUBN8aCmD/gU=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMg64sxvuEhd8/7rz60KmDYvm2kxqMTSYyrLbeObKv
 qKIg59SFlzvKGVhEONikBVTZFknrTU1qUgq/4hBjTzMHFYmkCEMXJwCMBFZYUaGrcYLqrepHDvi
 8mtyyoqCqybJec0+YR+FE+/sWq2zevcvKYa/ostD5LyOn5VhP7pAO92vNbzFP4Hte+5MmWPzbE6
 7vtbiAAAGI0Y4
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

Add a test to check basic functionallity of file_getattr() and
file_setattr() syscalls. These syscalls are used to get/set filesystem
inode attributes (think of FS_IOC_SETFSXATTR ioctl()). The difference
from ioctl() is that these syscalls use *at() semantics and can be
called on any file without opening it, including special ones.

For XFS, with the use of these syscalls, xfs_quota now can
manipulate quota on special files such as sockets. Add a test to
check that special files are counted, which wasn't true before.

To: fstests@vger.kernel.org
Cc: zlang@redhat.com
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
Changes in v3:
- Fix tab vs spaces indents
- Update year in SPDX header
- Rename AC_HAVE_FILE_ATTR to AC_HAVE_FILE_GETATTR

Changes in v2:
- Improve help message for file_attr
- Refactor file_attr.c
- Drop _wants_*_commit
- Link to v1: https://lore.kernel.org/r/20250808-xattrat-syscall-v1-0-6a09c4f37f10@kernel.org

---
Andrey Albershteyn (3):
      file_attr: introduce program to set/get fsxattr
      generic: introduce test to test file_getattr/file_setattr syscalls
      xfs: test quota's project ID on special files

 .gitignore             |   1 +
 configure.ac           |   1 +
 include/builddefs.in   |   1 +
 m4/package_libcdev.m4  |  16 +++
 src/Makefile           |   5 +
 src/file_attr.c        | 274 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/2000     | 109 ++++++++++++++++++++
 tests/generic/2000.out |  37 +++++++
 tests/xfs/2000         |  73 +++++++++++++
 tests/xfs/2000.out     |  15 +++
 10 files changed, 532 insertions(+)
---
base-commit: 3d57f543ae0c149eb460574dcfb8d688aeadbfff
change-id: 20250317-xattrat-syscall-ee8f5e2d6e18

Best regards,
--  
Andrey Albershteyn <aalbersh@kernel.org>


