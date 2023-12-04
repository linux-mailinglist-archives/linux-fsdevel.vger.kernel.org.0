Return-Path: <linux-fsdevel+bounces-4721-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E51F802ADD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 05:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF4911F20F2B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 04:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AEB946F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 04:31:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out0-195.mail.aliyun.com (out0-195.mail.aliyun.com [140.205.0.195])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3450DD7
	for <linux-fsdevel@vger.kernel.org>; Sun,  3 Dec 2023 18:54:06 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047206;MF=winters.zc@antgroup.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---.VboaiM6_1701658443;
Received: from localhost(mailfrom:winters.zc@antgroup.com fp:SMTPD_---.VboaiM6_1701658443)
          by smtp.aliyun-inc.com;
          Mon, 04 Dec 2023 10:54:03 +0800
From: "Zhao Chen" <winters.zc@antgroup.com>
To: linux-fsdevel@vger.kernel.org
Cc: miklos@szeredi.hu
Subject: [PATCH v3 0/2] fuse: Add support for resend pending requests
Date: Mon, 04 Dec 2023 10:54:01 +0800
Message-Id: <20231204025403.304877-1-winters.zc@antgroup.com>
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


