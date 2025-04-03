Return-Path: <linux-fsdevel+bounces-45673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A948CA7A93B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 20:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 537E3177BA7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 18:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B2E2528ED;
	Thu,  3 Apr 2025 18:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEav+yLy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693102500C9;
	Thu,  3 Apr 2025 18:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743704566; cv=none; b=iPu9EG0Gl4PFbg3l+PS0hYu87Qt+i/LlAj9VYEuBsBNQJ6wOLdTF9cnsqfdWOTXHbgij5Lb4tgH93eCRPXlW3nuxH2ZA4lY9ynX1EYZjSCjIbdU7UORROi0OmAK7Pf8lzdsKRaDWONgK06RcAafhdSgefbfNGE9WoKoAKKJvKPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743704566; c=relaxed/simple;
	bh=rLzrT0AKkwsRD9XYAXkmvKNsoTJxfDta1FbB94KlwGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YB628hvrj9SQb5/GSFURiSLn/1MlDOdBQUneOmjCJgSLou+CWc6uPMC9dvRV41dM9nt5blFFdJIQYoEVfhBibKEJhK6HkC33ueQhj/R9/bBXJgI5xMSYjrHhWgsBF7ixLnq1tomQ9G3wTAnaS/RMsl1aTruiDHvzaHoNce2mc80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gEav+yLy; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-aee773df955so1238337a12.1;
        Thu, 03 Apr 2025 11:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743704564; x=1744309364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3A3lnmeTpY7k39SfGomsdy/TAtCo406v7O674RosIRo=;
        b=gEav+yLyxk/rNOTh69FRBr/uj8IDjvz4davYkgxL19aV24PI8wT2NHgSgaw7VhzeI8
         XmgTxOJdesRArNgfkx7dOJl+1LyU1xaYJXMBvYsnP6uThIc8nq5flbpSCXhglIrcJM4A
         vW0RakN6XSaRdjTNaqrSpSx3bCYWNpTd3A8y0zo9QYZVEnqhpxCNWp/cxB+PUz5Iv6E3
         x9CIlmCc7lEp5VggFGHqMA1z2UAzQbKkMQEcQqudWsQ9UGK0EJEKnw2LSXaM7pruKlxZ
         ORMQieBPKAe8Kln5P0DsxByP7vELsZzlWRstZLK+/HX4r4twdoIAhVkJMNbFGnSdsY8y
         AnJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743704564; x=1744309364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3A3lnmeTpY7k39SfGomsdy/TAtCo406v7O674RosIRo=;
        b=RKhPHgmHQ59na7dZTMKkvKGXajfm6Mdb5d6kNSEjLlJRJaiW9uMnI+IUkESDXK1qza
         oHTXqtRPuQcM1G73XQ+Zmub2ypMZVdTdaktjk9MarQqsRozvzCatkk0/0bLDmmPc1tw8
         oyG6fp1F1/Y90AQeKUAS0fPhtAvZom0UgECgpcME++gSfPw9q2rUnkaJJ5kaJdfVMQme
         AhaM9f2JNh4N3Iz9V8RPdBCXOA0Kt/OOPz/nCyEwr2jE3tw4usD1EEy+CfzxMnylIClr
         VpbK+KwsQGpnRB/6G8idEDKD4TZkc2T9V7y1YkI3Iby8SRN46nwDJmpLKWt/CGW6V2PX
         nUUQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1d0DtuySPz3J6xGMGGbSEr55jJHZEBkTKloK8fVqj4GfoaXUdcOLCxfpq1IOU7Pxc8zVIvLdVf83W2/2z@vger.kernel.org
X-Gm-Message-State: AOJu0Yze+WSLK6yLKGII6YCqC8cvLjQFou4rNZTLsPJ7JXfZd5iXzeYb
	rtVxcl2TQzkpwQIkEc73BHAjeiClrRnoo3c75KOU6I7U4fk6x7+AkzHdO/wD
X-Gm-Gg: ASbGncv4G1TH071d5Inh/YFNzUHUSj9T28ZzpTD+2nv9njt9z4Y5licarXu1mETcNNQ
	jTRnSRuF7XPL05B+Fy/GHz+lZg6Y4V+dNKfskMF6BMYqSd0cMB34JXa2kQJgwLAK0No0VOYhXs0
	VKu05JT5Wpg6mXur8fjGK5euCbMWh6XLIiTMFjSvcf8MouHpX47Gul6zZpbxdmmGjay3WrLhuBH
	QMiRkVCDwaLfEdDb8/HXrhVJWAPgoC9JNstCTwmOzDoZIQHL2ttY/Io0/v+StwzPnndOg8HeoOO
	kV1zUo+t4wIEDVIND7cqmRioxaqJ91i6DpuqWYWSm9DVVcDDBA==
X-Google-Smtp-Source: AGHT+IG1MKXIPYBOjSxG7VAk/REv0Tjn6bRi2iIpXOG6wtUFqdb5cORjJrW8EWact1WZXqC3K9wd3Q==
X-Received: by 2002:a17:90b:3d44:b0:2f1:2e10:8160 with SMTP id 98e67ed59e1d1-306a4eb58famr417670a91.11.1743704564005;
        Thu, 03 Apr 2025 11:22:44 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([171.76.86.91])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30561cac698sm3944261a91.0.2025.04.03.11.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 11:22:43 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-xfs@vger.kernel.org
Cc: John Garry <john.g.garry@oracle.com>,
	djwong@kernel.org,
	ojaswin@linux.ibm.com,
	linux-fsdevel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH 1/2] Documentation: iomap: Add missing flags description
Date: Thu,  3 Apr 2025 23:52:27 +0530
Message-ID: <3170ab367b5b350c60564886a72719ccf573d01c.1743691371.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's document the use of these flags in iomap design doc where other
flags are defined too -

- IOMAP_F_BOUNDARY was added by XFS to prevent merging of ioends
  across RTG boundaries.
- IOMAP_F_ATOMIC_BIO was added for supporting atomic I/O operations
  for filesystems to inform the iomap that it needs HW-offload based
  mechanism for torn-write protection

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 Documentation/filesystems/iomap/design.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/filesystems/iomap/design.rst b/Documentation/filesystems/iomap/design.rst
index e29651a42eec..b916e85bc930 100644
--- a/Documentation/filesystems/iomap/design.rst
+++ b/Documentation/filesystems/iomap/design.rst
@@ -243,6 +243,11 @@ The fields are as follows:
      regular file data.
      This is only useful for FIEMAP.
 
+   * **IOMAP_F_BOUNDARY**: This indicates that I/O and I/O completions
+     for this iomap must never be merged with the mapping before it.
+     Currently XFS uses this to prevent merging of ioends across RTG
+     (realtime group) boundaries.
+
    * **IOMAP_F_PRIVATE**: Starting with this value, the upper bits can
      be set by the filesystem for its own purposes.
 
@@ -250,6 +255,11 @@ The fields are as follows:
      block assigned to it yet and the file system will do that in the bio
      submission handler, splitting the I/O as needed.
 
+   * **IOMAP_F_ATOMIC_BIO**: Indicates that write I/O must be submitted
+     with the ``REQ_ATOMIC`` flag set in the bio. Filesystems need to set
+     this flag to inform iomap that the write I/O operation requires
+     torn-write protection based on HW-offload mechanism.
+
    These flags can be set by iomap itself during file operations.
    The filesystem should supply an ``->iomap_end`` function if it needs
    to observe these flags:
-- 
2.48.1


