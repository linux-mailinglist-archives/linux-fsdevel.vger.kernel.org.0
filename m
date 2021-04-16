Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3AD362200
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Apr 2021 16:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244534AbhDPOT5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Apr 2021 10:19:57 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:39402 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235724AbhDPOT5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:19:57 -0400
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 16 Apr 2021 07:19:32 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 16 Apr 2021 07:19:30 -0700
X-QCInternal: smtphost
Received: from hydcbspbld03.qualcomm.com ([10.242.221.48])
  by ironmsg02-blr.qualcomm.com with ESMTP; 16 Apr 2021 19:49:16 +0530
Received: by hydcbspbld03.qualcomm.com (Postfix, from userid 2304101)
        id 375F8215B8; Fri, 16 Apr 2021 19:49:14 +0530 (IST)
From:   Pradeep P V K <pragalla@codeaurora.org>
To:     miklos@szeredi.hu
Cc:     stummala@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Pradeep P V K <pragalla@codeaurora.org>
Subject: [PATCH V1] fuse: Set fuse request error upon fuse abort connection
Date:   Fri, 16 Apr 2021 19:49:12 +0530
Message-Id: <1618582752-26178-1-git-send-email-pragalla@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is a minor race in setting the fuse out request error
between fuse_abort_conn() and fuse_dev_do_read() as explained
below.

Thread-1			  Thread-2
========			  ========
->fuse_simple_request()           ->shutdown
  ->__fuse_request_send()
    ->queue_request()		->fuse_abort_conn()
->fuse_dev_do_read()                ->acquire(fpq->lock)
  ->wait_for(fpq->lock) 	  ->set err to all req's in fpq->io
				  ->release(fpq->lock)
  ->acquire(fpq->lock)
  ->add req to fpq->io

The above scenario may cause Thread-1 request to add into
fpq->io list after Thread-2 sets -ECONNABORTED err to all
its requests in fpq->io list. This leaves Thread-1 request
with unset err and this further misleads as a completed
request without an err set upon request_end().

Handle this by setting the err appropriately.

Signed-off-by: Pradeep P V K <pragalla@codeaurora.org>
---
 fs/fuse/dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index a5ceccc..102c56f 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1283,6 +1283,7 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
 	clear_bit(FR_LOCKED, &req->flags);
 	if (!fpq->connected) {
 		err = fc->aborted ? -ECONNABORTED : -ENODEV;
+		req->out.h.error = err;
 		goto out_end;
 	}
 	if (err) {
-- 
2.7.4

