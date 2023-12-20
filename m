Return-Path: <linux-fsdevel+bounces-6575-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E16A5819AF0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 09:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CCFBB21E33
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 08:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91571CABD;
	Wed, 20 Dec 2023 08:54:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out0-200.mail.aliyun.com (out0-200.mail.aliyun.com [140.205.0.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A7B1CAA7
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Dec 2023 08:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R661e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047187;MF=winters.zc@antgroup.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---.Von.c0O_1703062168;
Received: from localhost(mailfrom:winters.zc@antgroup.com fp:SMTPD_---.Von.c0O_1703062168)
          by smtp.aliyun-inc.com;
          Wed, 20 Dec 2023 16:49:28 +0800
From: "Zhao Chen" <winters.zc@antgroup.com>
To: linux-fsdevel@vger.kernel.org
Cc: miklos@szeredi.hu
Subject: [PATCH v3 RESEND 0/2] fuse: Add support for resend pending requests
Date: Wed, 20 Dec 2023 16:49:26 +0800
Message-Id: <20231220084928.298302-1-winters.zc@antgroup.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After the FUSE daemon crashes, the fuse mount point becomes inaccessible.
In some production environments, a watchdog daemon is used to preserve
the FUSE connection's file descriptor (fd). When the FUSE daemon crashes,
a new FUSE daemon is started and takes over the fd from the watchdog
daemon, allowing it to continue providing services.

However, if any inflight requests are lost during the crash, the user
process becomes stuck as it does not receive any replies.

To resolve this issue, this patchset introduces a new notification type
that enable resending these pending requests to the FUSE daemon again,
allowing the stuck user process to recover.

When using the resend API, FUSE daemon needs to ensure avoidance of
processing duplicate non-idempotent requests to prevent potential
consistency issues. The high bit of the fuse request id is utilized for
indicating the resend request.

---
v2->v3:
 - use notification instead of sysfs API to trigger resend
 - simplify FUSE_REQ_ID_MASK related code
 - rename some related macro names

v1->v2:
 - remove flush sysfs API in the original mail
 - add using high bit of request ID for indicating resend requests
 - add wakeup in fuse_resend_pqueue()

Zhao Chen (2):
  fuse: Introduce a new notification type for resend pending requests
  fuse: Use the high bit of request ID for indicating resend requests

 fs/fuse/dev.c             | 69 ++++++++++++++++++++++++++++++++++++++-
 fs/fuse/inode.c           |  3 +-
 include/uapi/linux/fuse.h | 12 +++++++
 3 files changed, 82 insertions(+), 2 deletions(-)

-- 
2.32.0.3.g01195cf9f


