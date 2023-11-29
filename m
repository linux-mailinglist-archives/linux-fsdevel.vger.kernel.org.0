Return-Path: <linux-fsdevel+bounces-4171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 031BE7FD47E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 11:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B15C52812B5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 10:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8A61B283
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 10:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out0-200.mail.aliyun.com (out0-200.mail.aliyun.com [140.205.0.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420F6D6C
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 01:43:20 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047207;MF=winters.zc@antgroup.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---.VYcwPuU_1701250997;
Received: from localhost(mailfrom:winters.zc@antgroup.com fp:SMTPD_---.VYcwPuU_1701250997)
          by smtp.aliyun-inc.com;
          Wed, 29 Nov 2023 17:43:18 +0800
From: "Zhao Chen" <winters.zc@antgroup.com>
To: linux-fsdevel@vger.kernel.org
Cc: miklos@szeredi.hu
Subject: [PATCH v2 RESEND 0/2] Introduce sysfs API for resend pending requests
Date: Wed, 29 Nov 2023 17:43:15 +0800
Message-Id: <20231129094317.453025-1-winters.zc@antgroup.com>
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

To resolve this issue, this patchset introduces a sysfs API that enable
resending these pending requests to the FUSE daemon again, allowing the
stuck user process to recover.

When using the resend API, FUSE daemon needs to ensure proper recording
and avoidance of processing duplicate non-idempotent requests to prevent
potential consistency issues. The high bit of the fuse request id is
utilized for indicating the resend request.

---
v1->v2:
 - remove flush sysfs API in the original mail
 - add using high bit of request ID for indicating resend requests
 - add wakeup in fuse_resend_pqueue()

Peng Tao (1):
  fuse: Introduce sysfs API for resend pending reque

Zhao Chen (1):
  fuse: Use the high bit of request ID for indicating resend requests

 fs/fuse/control.c         | 20 +++++++++++
 fs/fuse/dev.c             | 70 ++++++++++++++++++++++++++++++++++++---
 fs/fuse/fuse_i.h          |  5 ++-
 fs/fuse/inode.c           |  3 +-
 include/uapi/linux/fuse.h | 11 ++++++
 5 files changed, 103 insertions(+), 6 deletions(-)

-- 
2.32.0.3.g01195cf9f


