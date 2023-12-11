Return-Path: <linux-fsdevel+bounces-5470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED6D80C8F7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 13:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DB441C20A04
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 12:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BDF38FBF;
	Mon, 11 Dec 2023 12:06:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out0-221.mail.aliyun.com (out0-221.mail.aliyun.com [140.205.0.221])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26A5EB
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Dec 2023 04:06:13 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R491e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047204;MF=winters.zc@antgroup.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---.VhZAIUB_1702296371;
Received: from localhost(mailfrom:winters.zc@antgroup.com fp:SMTPD_---.VhZAIUB_1702296371)
          by smtp.aliyun-inc.com;
          Mon, 11 Dec 2023 20:06:11 +0800
From: "Zhao Chen" <winters.zc@antgroup.com>
To: linux-fsdevel@vger.kernel.org
Cc: miklos@szeredi.hu
Subject: [PATCH v3 RESEND 0/2] fuse: Add support for resend pending requests
Date: Mon, 11 Dec 2023 20:06:09 +0800
Message-Id: <20231211120611.39543-1-winters.zc@antgroup.com>
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


