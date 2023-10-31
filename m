Return-Path: <linux-fsdevel+bounces-1646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C12E37DCF5F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 15:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C740281771
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 14:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616341DA56;
	Tue, 31 Oct 2023 14:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7288E1C69D
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 14:41:13 +0000 (UTC)
Received: from out0-215.mail.aliyun.com (out0-215.mail.aliyun.com [140.205.0.215])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3280B102
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 07:41:09 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047204;MF=winters.zc@antgroup.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---.VC.9BGG_1698763265;
Received: from localhost(mailfrom:winters.zc@antgroup.com fp:SMTPD_---.VC.9BGG_1698763265)
          by smtp.aliyun-inc.com;
          Tue, 31 Oct 2023 22:41:06 +0800
From: "=?UTF-8?B?6LW15pmo?=" <winters.zc@antgroup.com>
To: linux-fsdevel@vger.kernel.org
Cc:  <miklos@szeredi.hu>,
  "=?UTF-8?B?6LW15pmo?=" <winters.zc@antgroup.com>
Subject: [PATCH v1 0/2] fuse: Introduce sysfs APIs to flush or resend pending requests
Date: Tue, 31 Oct 2023 22:40:41 +0800
Message-Id: <20231031144043.68534-1-winters.zc@antgroup.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After the fuse daemon crashes, the fuse mount point becomes inaccessible.
In some production environments, a watchdog daemon is used to preserve
the FUSE connection's file descriptor (fd). When the FUSE daemon crashes,
a new FUSE daemon is restarted and takes over the fd from the watchdog
daemon, allowing it to continue providing services.

However, if any inflight requests are lost during the crash, the user
process becomes stuck as it does not receive any replies.

To resolve this issue, this patchset introduces two sysfs APIs that enable
flushing or resending these pending requests for recovery. The flush
operation ends the pending request and returns an error to the
application, allowing the stuck user process to recover. While returning
an error may not be suitable for all scenarios, the resend API can be used
to resend the these pending requests. 

When using the resend API, FUSE daemon needs to ensure proper recording
and avoidance of processing duplicate non-idempotent requests to prevent
potential consistency issues.

Ma Jie Yue (1):
  fuse: Introduce sysfs API for flushing pending requests

Peng Tao (1):
  fuse: Introduce sysfs API for resend pending requests

 fs/fuse/control.c | 40 ++++++++++++++++++++
 fs/fuse/dev.c     | 94 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/fuse_i.h  |  8 +++-
 3 files changed, 141 insertions(+), 1 deletion(-)

-- 
2.32.0.3.g01195cf9f


